package pscout.db;
import java.util.List;

import pscout.models.Class;
import pscout.models.Invocation;
import pscout.models.Method;

public interface IDataProvider {
	
	public void addClass(Class cls);
	public void addMethod(Method method);
	public void addInvocation(Invocation invocation);
	
	public Class getClassById(long classId);
	public Class getClassByName(String className, String version);
	public Method getMethodById(long id);
	public Invocation getInvocationById(long id);
	
	public Method getMethod(String clsName, String methodName, String descriptor, String version);
	public List<Invocation> findInvocations(String className, String methodName, String descriptor, String version);
	
	public void shutdown();
}
