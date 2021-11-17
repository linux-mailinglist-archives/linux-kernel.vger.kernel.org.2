Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650C04540A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhKQGKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:10:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:52694 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhKQGKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:10:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="297309636"
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; 
   d="gz'50?scan'50,208,50";a="297309636"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 22:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; 
   d="gz'50?scan'50,208,50";a="454755448"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2021 22:07:41 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnE6f-0001JC-9f; Wed, 17 Nov 2021 06:07:41 +0000
Date:   Wed, 17 Nov 2021 14:07:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof-next:20211116-sysctl-cleanups-v4 6/35] kernel/sysctl.c:1772:
 error: unterminated #ifdef
Message-ID: <202111171405.IT8PGvr9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211116-sysctl-cleanups-v4
head:   5347239461f25fc50aa761923245b9ec4a4aafec
commit: 88b045e811bcb4988e2f37077d8a582b7a111b68 [6/35] sysctl: Add const decoration for static boundary value variables
config: nds32-allnoconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=88b045e811bcb4988e2f37077d8a582b7a111b68
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20211116-sysctl-cleanups-v4
        git checkout 88b045e811bcb4988e2f37077d8a582b7a111b68
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/sysctl.c:1772: error: unterminated #ifdef
    1772 | #ifdef CONFIG_SCHED_DEBUG
         | 
>> kernel/sysctl.c:1733: error: unterminated #if
    1733 | #if defined(CONFIG_SYSCTL)
         | 
>> kernel/sysctl.c:1771:9: error: expected expression at end of input
    1771 |         },
         |         ^
   kernel/sysctl.c:1764:25: warning: 'kern_table' defined but not used [-Wunused-variable]
    1764 | static struct ctl_table kern_table[] = {
         |                         ^~~~~~~~~~
   kernel/sysctl.c:1482:12: warning: 'proc_do_cad_pid' defined but not used [-Wunused-function]
    1482 | static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
         |            ^~~~~~~~~~~~~~~
   kernel/sysctl.c:1187:12: warning: 'proc_dostring_coredump' defined but not used [-Wunused-function]
    1187 | static int proc_dostring_coredump(struct ctl_table *table, int write,
         |            ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sysctl.c:1177:12: warning: 'proc_dointvec_minmax_coredump' defined but not used [-Wunused-function]
    1177 | static int proc_dointvec_minmax_coredump(struct ctl_table *table, int write,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sysctl.c:1156:12: warning: 'proc_dopipe_max_size' defined but not used [-Wunused-function]
    1156 | static int proc_dopipe_max_size(struct ctl_table *table, int write,
         |            ^~~~~~~~~~~~~~~~~~~~
   kernel/sysctl.c:931:12: warning: 'proc_dointvec_minmax_sysadmin' defined but not used [-Wunused-function]
     931 | static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sysctl.c:891:12: warning: 'proc_taint' defined but not used [-Wunused-function]
     891 | static int proc_taint(struct ctl_table *table, int write,
         |            ^~~~~~~~~~
   kernel/sysctl.c:128:18: warning: 'cap_last_cap' defined but not used [-Wunused-const-variable=]
     128 | static const int cap_last_cap = CAP_LAST_CAP;
         |                  ^~~~~~~~~~~~
   kernel/sysctl.c:127:18: warning: 'ngroups_max' defined but not used [-Wunused-const-variable=]
     127 | static const int ngroups_max = NGROUPS_MAX;
         |                  ^~~~~~~~~~~
   kernel/sysctl.c:125:18: warning: 'minolduid' defined but not used [-Wunused-const-variable=]
     125 | static const int minolduid;
         |                  ^~~~~~~~~
   kernel/sysctl.c:124:18: warning: 'maxolduid' defined but not used [-Wunused-const-variable=]
     124 | static const int maxolduid = 65535;
         |                  ^~~~~~~~~
   kernel/sysctl.c:121:28: warning: 'dirty_bytes_min' defined but not used [-Wunused-const-variable=]
     121 | static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
         |                            ^~~~~~~~~~~~~~~
   kernel/sysctl.c:114:18: warning: 'ten_thousand' defined but not used [-Wunused-const-variable=]
     114 | static const int ten_thousand = 10000;
         |                  ^~~~~~~~~~~~
   kernel/sysctl.c:112:28: warning: 'long_max' defined but not used [-Wunused-const-variable=]
     112 | static const unsigned long long_max = LONG_MAX;
         |                            ^~~~~~~~
   kernel/sysctl.c:111:28: warning: 'one_ul' defined but not used [-Wunused-const-variable=]
     111 | static const unsigned long one_ul = 1;
         |                            ^~~~~~
   kernel/sysctl.c:110:28: warning: 'zero_ul' defined but not used [-Wunused-const-variable=]
     110 | static const unsigned long zero_ul;
         |                            ^~~~~~~


vim +1772 kernel/sysctl.c

  1732	
> 1733	#if defined(CONFIG_SYSCTL)
  1734	int proc_do_static_key(struct ctl_table *table, int write,
  1735			       void *buffer, size_t *lenp, loff_t *ppos)
  1736	{
  1737		struct static_key *key = (struct static_key *)table->data;
  1738		static DEFINE_MUTEX(static_key_mutex);
  1739		int val, ret;
  1740		struct ctl_table tmp = {
  1741			.data   = &val,
  1742			.maxlen = sizeof(val),
  1743			.mode   = table->mode,
  1744			.extra1 = SYSCTL_ZERO,
  1745			.extra2 = SYSCTL_ONE,
  1746		};
  1747	
  1748		if (write && !capable(CAP_SYS_ADMIN))
  1749			return -EPERM;
  1750	
  1751		mutex_lock(&static_key_mutex);
  1752		val = static_key_enabled(key);
  1753		ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
  1754		if (write && !ret) {
  1755			if (val)
  1756				static_key_enable(key);
  1757			else
  1758				static_key_disable(key);
  1759		}
  1760		mutex_unlock(&static_key_mutex);
  1761		return ret;
  1762	}
  1763	
  1764	static struct ctl_table kern_table[] = {
  1765		{
  1766			.procname	= "sched_child_runs_first",
  1767			.data		= &sysctl_sched_child_runs_first,
  1768			.maxlen		= sizeof(unsigned int),
  1769			.mode		= 0644,
  1770			.proc_handler	= proc_dointvec,
> 1771		},
> 1772	#ifdef CONFIG_SCHED_DEBUG
  1773		{
  1774			.procname	= "sched_min_granularity_ns",
  1775			.data		= &sysctl_sched_min_granularity,
  1776			.maxlen		= sizeof(unsigned int),
  1777			.mode		= 0644,
  1778			.proc_handler	= sched_proc_update_handler,
  1779			.extra1		= (void *)&min_sched_granularity_ns,
  1780			.extra2		= (void *)&max_sched_granularity_ns,
  1781		},
  1782		{
  1783			.procname	= "sched_latency_ns",
  1784			.data		= &sysctl_sched_latency,
  1785			.maxlen		= sizeof(unsigned int),
  1786			.mode		= 0644,
  1787			.proc_handler	= sched_proc_update_handler,
  1788			.extra1		= (void *)&min_sched_granularity_ns,
  1789			.extra2		= (void *)&max_sched_granularity_ns,
  1790		},
  1791		{
  1792			.procname	= "sched_wakeup_granularity_ns",
  1793			.data		= &sysctl_sched_wakeup_granularity,
  1794			.maxlen		= sizeof(unsigned int),
  1795			.mode		= 0644,
  1796			.proc_handler	= sched_proc_update_handler,
  1797			.extra1		= (void *)&min_wakeup_granularity_ns,
  1798			.extra2		= (void *)&max_wakeup_granularity_ns,
  1799		},
  1800	#ifdef CONFIG_SMP
  1801		{
  1802			.procname	= "sched_tunable_scaling",
  1803			.data		= &sysctl_sched_tunable_scaling,
  1804			.maxlen		= sizeof(enum sched_tunable_scaling),
  1805			.mode		= 0644,
  1806			.proc_handler	= sched_proc_update_handler,
  1807			.extra1		= (void *)&min_sched_tunable_scaling,
  1808			.extra2		= (void *)&max_sched_tunable_scaling,
  1809		},
  1810		{
  1811			.procname	= "sched_migration_cost_ns",
  1812			.data		= &sysctl_sched_migration_cost,
  1813			.maxlen		= sizeof(unsigned int),
  1814			.mode		= 0644,
  1815			.proc_handler	= proc_dointvec,
  1816		},
  1817		{
  1818			.procname	= "sched_nr_migrate",
  1819			.data		= &sysctl_sched_nr_migrate,
  1820			.maxlen		= sizeof(unsigned int),
  1821			.mode		= 0644,
  1822			.proc_handler	= proc_dointvec,
  1823		},
  1824	#ifdef CONFIG_SCHEDSTATS
  1825		{
  1826			.procname	= "sched_schedstats",
  1827			.data		= NULL,
  1828			.maxlen		= sizeof(unsigned int),
  1829			.mode		= 0644,
  1830			.proc_handler	= sysctl_schedstats,
  1831			.extra1		= SYSCTL_ZERO,
  1832			.extra2		= SYSCTL_ONE,
  1833		},
  1834	#endif /* CONFIG_SCHEDSTATS */
  1835	#ifdef CONFIG_TASK_DELAY_ACCT
  1836		{
  1837			.procname	= "task_delayacct",
  1838			.data		= NULL,
  1839			.maxlen		= sizeof(unsigned int),
  1840			.mode		= 0644,
  1841			.proc_handler	= sysctl_delayacct,
  1842			.extra1		= SYSCTL_ZERO,
  1843			.extra2		= SYSCTL_ONE,
  1844		},
  1845	#endif /* CONFIG_TASK_DELAY_ACCT */
  1846	#ifdef CONFIG_NUMA_BALANCING
  1847		{
  1848			.procname	= "numa_balancing",
  1849			.data		= NULL, /* filled in by handler */
  1850			.maxlen		= sizeof(unsigned int),
  1851			.mode		= 0644,
  1852			.proc_handler	= sysctl_numa_balancing,
  1853			.extra1		= SYSCTL_ZERO,
  1854			.extra2		= SYSCTL_ONE,
  1855		},
  1856	#endif /* CONFIG_NUMA_BALANCING */
  1857		{
  1858			.procname	= "sched_rt_period_us",
  1859			.data		= &sysctl_sched_rt_period,
  1860			.maxlen		= sizeof(unsigned int),
  1861			.mode		= 0644,
  1862			.proc_handler	= sched_rt_handler,
  1863		},
  1864		{
  1865			.procname	= "sched_rt_runtime_us",
  1866			.data		= &sysctl_sched_rt_runtime,
  1867			.maxlen		= sizeof(int),
  1868			.mode		= 0644,
  1869			.proc_handler	= sched_rt_handler,
  1870		},
  1871		{
  1872			.procname	= "sched_deadline_period_max_us",
  1873			.data		= &sysctl_sched_dl_period_max,
  1874			.maxlen		= sizeof(unsigned int),
  1875			.mode		= 0644,
  1876			.proc_handler	= proc_dointvec,
  1877		},
  1878		{
  1879			.procname	= "sched_deadline_period_min_us",
  1880			.data		= &sysctl_sched_dl_period_min,
  1881			.maxlen		= sizeof(unsigned int),
  1882			.mode		= 0644,
  1883			.proc_handler	= proc_dointvec,
  1884		},
  1885		{
  1886			.procname	= "sched_rr_timeslice_ms",
  1887			.data		= &sysctl_sched_rr_timeslice,
  1888			.maxlen		= sizeof(int),
  1889			.mode		= 0644,
  1890			.proc_handler	= sched_rr_handler,
  1891		},
  1892	#ifdef CONFIG_UCLAMP_TASK
  1893		{
  1894			.procname	= "sched_util_clamp_min",
  1895			.data		= &sysctl_sched_uclamp_util_min,
  1896			.maxlen		= sizeof(unsigned int),
  1897			.mode		= 0644,
  1898			.proc_handler	= sysctl_sched_uclamp_handler,
  1899		},
  1900		{
  1901			.procname	= "sched_util_clamp_max",
  1902			.data		= &sysctl_sched_uclamp_util_max,
  1903			.maxlen		= sizeof(unsigned int),
  1904			.mode		= 0644,
  1905			.proc_handler	= sysctl_sched_uclamp_handler,
  1906		},
  1907		{
  1908			.procname	= "sched_util_clamp_min_rt_default",
  1909			.data		= &sysctl_sched_uclamp_util_min_rt_default,
  1910			.maxlen		= sizeof(unsigned int),
  1911			.mode		= 0644,
  1912			.proc_handler	= sysctl_sched_uclamp_handler,
  1913		},
  1914	#endif
  1915	#ifdef CONFIG_SCHED_AUTOGROUP
  1916		{
  1917			.procname	= "sched_autogroup_enabled",
  1918			.data		= &sysctl_sched_autogroup_enabled,
  1919			.maxlen		= sizeof(unsigned int),
  1920			.mode		= 0644,
  1921			.proc_handler	= proc_dointvec_minmax,
  1922			.extra1		= SYSCTL_ZERO,
  1923			.extra2		= SYSCTL_ONE,
  1924		},
  1925	#endif
  1926	#ifdef CONFIG_CFS_BANDWIDTH
  1927		{
  1928			.procname	= "sched_cfs_bandwidth_slice_us",
  1929			.data		= &sysctl_sched_cfs_bandwidth_slice,
  1930			.maxlen		= sizeof(unsigned int),
  1931			.mode		= 0644,
  1932			.proc_handler	= proc_dointvec_minmax,
  1933			.extra1		= SYSCTL_ONE,
  1934		},
  1935	#endif
  1936	#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
  1937		{
  1938			.procname	= "sched_energy_aware",
  1939			.data		= &sysctl_sched_energy_aware,
  1940			.maxlen		= sizeof(unsigned int),
  1941			.mode		= 0644,
  1942			.proc_handler	= sched_energy_aware_handler,
  1943			.extra1		= SYSCTL_ZERO,
  1944			.extra2		= SYSCTL_ONE,
  1945		},
  1946	#endif
  1947	#ifdef CONFIG_PROVE_LOCKING
  1948		{
  1949			.procname	= "prove_locking",
  1950			.data		= &prove_locking,
  1951			.maxlen		= sizeof(int),
  1952			.mode		= 0644,
  1953			.proc_handler	= proc_dointvec,
  1954		},
  1955	#endif
  1956	#ifdef CONFIG_LOCK_STAT
  1957		{
  1958			.procname	= "lock_stat",
  1959			.data		= &lock_stat,
  1960			.maxlen		= sizeof(int),
  1961			.mode		= 0644,
  1962			.proc_handler	= proc_dointvec,
  1963		},
  1964	#endif
  1965		{
  1966			.procname	= "panic",
  1967			.data		= &panic_timeout,
  1968			.maxlen		= sizeof(int),
  1969			.mode		= 0644,
  1970			.proc_handler	= proc_dointvec,
  1971		},
  1972	#ifdef CONFIG_COREDUMP
  1973		{
  1974			.procname	= "core_uses_pid",
  1975			.data		= &core_uses_pid,
  1976			.maxlen		= sizeof(int),
  1977			.mode		= 0644,
  1978			.proc_handler	= proc_dointvec,
  1979		},
  1980		{
  1981			.procname	= "core_pattern",
  1982			.data		= core_pattern,
  1983			.maxlen		= CORENAME_MAX_SIZE,
  1984			.mode		= 0644,
  1985			.proc_handler	= proc_dostring_coredump,
  1986		},
  1987		{
  1988			.procname	= "core_pipe_limit",
  1989			.data		= &core_pipe_limit,
  1990			.maxlen		= sizeof(unsigned int),
  1991			.mode		= 0644,
  1992			.proc_handler	= proc_dointvec,
  1993		},
  1994	#endif
  1995	#ifdef CONFIG_PROC_SYSCTL
  1996		{
  1997			.procname	= "tainted",
  1998			.maxlen 	= sizeof(long),
  1999			.mode		= 0644,
  2000			.proc_handler	= proc_taint,
  2001		},
  2002		{
  2003			.procname	= "sysctl_writes_strict",
  2004			.data		= &sysctl_writes_strict,
  2005			.maxlen		= sizeof(int),
  2006			.mode		= 0644,
  2007			.proc_handler	= proc_dointvec_minmax,
  2008			.extra1		= SYSCTL_NEG_ONE,
  2009			.extra2		= SYSCTL_ONE,
  2010		},
  2011	#endif
  2012	#ifdef CONFIG_LATENCYTOP
  2013		{
  2014			.procname	= "latencytop",
  2015			.data		= &latencytop_enabled,
  2016			.maxlen		= sizeof(int),
  2017			.mode		= 0644,
  2018			.proc_handler	= sysctl_latencytop,
  2019		},
  2020	#endif
  2021	#ifdef CONFIG_BLK_DEV_INITRD
  2022		{
  2023			.procname	= "real-root-dev",
  2024			.data		= &real_root_dev,
  2025			.maxlen		= sizeof(int),
  2026			.mode		= 0644,
  2027			.proc_handler	= proc_dointvec,
  2028		},
  2029	#endif
  2030		{
  2031			.procname	= "print-fatal-signals",
  2032			.data		= &print_fatal_signals,
  2033			.maxlen		= sizeof(int),
  2034			.mode		= 0644,
  2035			.proc_handler	= proc_dointvec,
  2036		},
  2037	#ifdef CONFIG_SPARC
  2038		{
  2039			.procname	= "reboot-cmd",
  2040			.data		= reboot_command,
  2041			.maxlen		= 256,
  2042			.mode		= 0644,
  2043			.proc_handler	= proc_dostring,
  2044		},
  2045		{
  2046			.procname	= "stop-a",
  2047			.data		= &stop_a_enabled,
  2048			.maxlen		= sizeof (int),
  2049			.mode		= 0644,
  2050			.proc_handler	= proc_dointvec,
  2051		},
  2052		{
  2053			.procname	= "scons-poweroff",
  2054			.data		= &scons_pwroff,
  2055			.maxlen		= sizeof (int),
  2056			.mode		= 0644,
  2057			.proc_handler	= proc_dointvec,
  2058		},
  2059	#endif
  2060	#ifdef CONFIG_SPARC64
  2061		{
  2062			.procname	= "tsb-ratio",
  2063			.data		= &sysctl_tsb_ratio,
  2064			.maxlen		= sizeof (int),
  2065			.mode		= 0644,
  2066			.proc_handler	= proc_dointvec,
  2067		},
  2068	#endif
  2069	#ifdef CONFIG_PARISC
  2070		{
  2071			.procname	= "soft-power",
  2072			.data		= &pwrsw_enabled,
  2073			.maxlen		= sizeof (int),
  2074			.mode		= 0644,
  2075			.proc_handler	= proc_dointvec,
  2076		},
  2077	#endif
  2078	#ifdef CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW
  2079		{
  2080			.procname	= "unaligned-trap",
  2081			.data		= &unaligned_enabled,
  2082			.maxlen		= sizeof (int),
  2083			.mode		= 0644,
  2084			.proc_handler	= proc_dointvec,
  2085		},
  2086	#endif
  2087		{
  2088			.procname	= "ctrl-alt-del",
  2089			.data		= &C_A_D,
  2090			.maxlen		= sizeof(int),
  2091			.mode		= 0644,
  2092			.proc_handler	= proc_dointvec,
  2093		},
  2094	#ifdef CONFIG_FUNCTION_TRACER
  2095		{
  2096			.procname	= "ftrace_enabled",
  2097			.data		= &ftrace_enabled,
  2098			.maxlen		= sizeof(int),
  2099			.mode		= 0644,
  2100			.proc_handler	= ftrace_enable_sysctl,
  2101		},
  2102	#endif
  2103	#ifdef CONFIG_STACK_TRACER
  2104		{
  2105			.procname	= "stack_tracer_enabled",
  2106			.data		= &stack_tracer_enabled,
  2107			.maxlen		= sizeof(int),
  2108			.mode		= 0644,
  2109			.proc_handler	= stack_trace_sysctl,
  2110		},
  2111	#endif
  2112	#ifdef CONFIG_TRACING
  2113		{
  2114			.procname	= "ftrace_dump_on_oops",
  2115			.data		= &ftrace_dump_on_oops,
  2116			.maxlen		= sizeof(int),
  2117			.mode		= 0644,
  2118			.proc_handler	= proc_dointvec,
  2119		},
  2120		{
  2121			.procname	= "traceoff_on_warning",
  2122			.data		= &__disable_trace_on_warning,
  2123			.maxlen		= sizeof(__disable_trace_on_warning),
  2124			.mode		= 0644,
  2125			.proc_handler	= proc_dointvec,
  2126		},
  2127		{
  2128			.procname	= "tracepoint_printk",
  2129			.data		= &tracepoint_printk,
  2130			.maxlen		= sizeof(tracepoint_printk),
  2131			.mode		= 0644,
  2132			.proc_handler	= tracepoint_printk_sysctl,
  2133		},
  2134	#endif
  2135	#ifdef CONFIG_KEXEC_CORE
  2136		{
  2137			.procname	= "kexec_load_disabled",
  2138			.data		= &kexec_load_disabled,
  2139			.maxlen		= sizeof(int),
  2140			.mode		= 0644,
  2141			/* only handle a transition from default "0" to "1" */
  2142			.proc_handler	= proc_dointvec_minmax,
  2143			.extra1		= SYSCTL_ONE,
  2144			.extra2		= SYSCTL_ONE,
  2145		},
  2146	#endif
  2147	#ifdef CONFIG_MODULES
  2148		{
  2149			.procname	= "modprobe",
  2150			.data		= &modprobe_path,
  2151			.maxlen		= KMOD_PATH_LEN,
  2152			.mode		= 0644,
  2153			.proc_handler	= proc_dostring,
  2154		},
  2155		{
  2156			.procname	= "modules_disabled",
  2157			.data		= &modules_disabled,
  2158			.maxlen		= sizeof(int),
  2159			.mode		= 0644,
  2160			/* only handle a transition from default "0" to "1" */
  2161			.proc_handler	= proc_dointvec_minmax,
  2162			.extra1		= SYSCTL_ONE,
  2163			.extra2		= SYSCTL_ONE,
  2164		},
  2165	#endif
  2166	#ifdef CONFIG_UEVENT_HELPER
  2167		{
  2168			.procname	= "hotplug",
  2169			.data		= &uevent_helper,
  2170			.maxlen		= UEVENT_HELPER_PATH_LEN,
  2171			.mode		= 0644,
  2172			.proc_handler	= proc_dostring,
  2173		},
  2174	#endif
  2175	#ifdef CONFIG_CHR_DEV_SG
  2176		{
  2177			.procname	= "sg-big-buff",
  2178			.data		= &sg_big_buff,
  2179			.maxlen		= sizeof (int),
  2180			.mode		= 0444,
  2181			.proc_handler	= proc_dointvec,
  2182		},
  2183	#endif
  2184	#ifdef CONFIG_BSD_PROCESS_ACCT
  2185		{
  2186			.procname	= "acct",
  2187			.data		= &acct_parm,
  2188			.maxlen		= 3*sizeof(int),
  2189			.mode		= 0644,
  2190			.proc_handler	= proc_dointvec,
  2191		},
  2192	#endif
  2193	#ifdef CONFIG_MAGIC_SYSRQ
  2194		{
  2195			.procname	= "sysrq",
  2196			.data		= NULL,
  2197			.maxlen		= sizeof (int),
  2198			.mode		= 0644,
  2199			.proc_handler	= sysrq_sysctl_handler,
  2200		},
  2201	#endif
  2202	#ifdef CONFIG_PROC_SYSCTL
  2203		{
  2204			.procname	= "cad_pid",
  2205			.data		= NULL,
  2206			.maxlen		= sizeof (int),
  2207			.mode		= 0600,
  2208			.proc_handler	= proc_do_cad_pid,
  2209		},
  2210	#endif
  2211		{
  2212			.procname	= "threads-max",
  2213			.data		= NULL,
  2214			.maxlen		= sizeof(int),
  2215			.mode		= 0644,
  2216			.proc_handler	= sysctl_max_threads,
  2217		},
  2218		{
  2219			.procname	= "random",
  2220			.mode		= 0555,
  2221			.child		= random_table,
  2222		},
  2223		{
  2224			.procname	= "usermodehelper",
  2225			.mode		= 0555,
  2226			.child		= usermodehelper_table,
  2227		},
  2228	#ifdef CONFIG_FW_LOADER_USER_HELPER
  2229		{
  2230			.procname	= "firmware_config",
  2231			.mode		= 0555,
  2232			.child		= firmware_config_table,
  2233		},
  2234	#endif
  2235		{
  2236			.procname	= "overflowuid",
  2237			.data		= &overflowuid,
  2238			.maxlen		= sizeof(int),
  2239			.mode		= 0644,
  2240			.proc_handler	= proc_dointvec_minmax,
  2241			.extra1		= (void *)&minolduid,
  2242			.extra2		= (void *)&maxolduid,
  2243		},
  2244		{
  2245			.procname	= "overflowgid",
  2246			.data		= &overflowgid,
  2247			.maxlen		= sizeof(int),
  2248			.mode		= 0644,
  2249			.proc_handler	= proc_dointvec_minmax,
  2250			.extra1		= (void *)&minolduid,
  2251			.extra2		= (void *)&maxolduid,
  2252		},
  2253	#ifdef CONFIG_S390
  2254		{
  2255			.procname	= "userprocess_debug",
  2256			.data		= &show_unhandled_signals,
  2257			.maxlen		= sizeof(int),
  2258			.mode		= 0644,
  2259			.proc_handler	= proc_dointvec,
  2260		},
  2261	#endif
  2262	#ifdef CONFIG_SMP
  2263		{
  2264			.procname	= "oops_all_cpu_backtrace",
  2265			.data		= &sysctl_oops_all_cpu_backtrace,
  2266			.maxlen		= sizeof(int),
  2267			.mode		= 0644,
  2268			.proc_handler	= proc_dointvec_minmax,
  2269			.extra1		= SYSCTL_ZERO,
  2270			.extra2		= SYSCTL_ONE,
  2271		},
  2272	#endif /* CONFIG_SMP */
  2273		{
  2274			.procname	= "pid_max",
  2275			.data		= &pid_max,
  2276			.maxlen		= sizeof (int),
  2277			.mode		= 0644,
  2278			.proc_handler	= proc_dointvec_minmax,
  2279			.extra1		= &pid_max_min,
  2280			.extra2		= &pid_max_max,
  2281		},
  2282		{
  2283			.procname	= "panic_on_oops",
  2284			.data		= &panic_on_oops,
  2285			.maxlen		= sizeof(int),
  2286			.mode		= 0644,
  2287			.proc_handler	= proc_dointvec,
  2288		},
  2289		{
  2290			.procname	= "panic_print",
  2291			.data		= &panic_print,
  2292			.maxlen		= sizeof(unsigned long),
  2293			.mode		= 0644,
  2294			.proc_handler	= proc_doulongvec_minmax,
  2295		},
  2296	#if defined CONFIG_PRINTK
  2297		{
  2298			.procname	= "printk",
  2299			.data		= &console_loglevel,
  2300			.maxlen		= 4*sizeof(int),
  2301			.mode		= 0644,
  2302			.proc_handler	= proc_dointvec,
  2303		},
  2304		{
  2305			.procname	= "printk_ratelimit",
  2306			.data		= &printk_ratelimit_state.interval,
  2307			.maxlen		= sizeof(int),
  2308			.mode		= 0644,
  2309			.proc_handler	= proc_dointvec_jiffies,
  2310		},
  2311		{
  2312			.procname	= "printk_ratelimit_burst",
  2313			.data		= &printk_ratelimit_state.burst,
  2314			.maxlen		= sizeof(int),
  2315			.mode		= 0644,
  2316			.proc_handler	= proc_dointvec,
  2317		},
  2318		{
  2319			.procname	= "printk_delay",
  2320			.data		= &printk_delay_msec,
  2321			.maxlen		= sizeof(int),
  2322			.mode		= 0644,
  2323			.proc_handler	= proc_dointvec_minmax,
  2324			.extra1		= SYSCTL_ZERO,
  2325			.extra2		= (void *)&ten_thousand,
  2326		},
  2327		{
  2328			.procname	= "printk_devkmsg",
  2329			.data		= devkmsg_log_str,
  2330			.maxlen		= DEVKMSG_STR_MAX_SIZE,
  2331			.mode		= 0644,
  2332			.proc_handler	= devkmsg_sysctl_set_loglvl,
  2333		},
  2334		{
  2335			.procname	= "dmesg_restrict",
  2336			.data		= &dmesg_restrict,
  2337			.maxlen		= sizeof(int),
  2338			.mode		= 0644,
  2339			.proc_handler	= proc_dointvec_minmax_sysadmin,
  2340			.extra1		= SYSCTL_ZERO,
  2341			.extra2		= SYSCTL_ONE,
  2342		},
  2343		{
  2344			.procname	= "kptr_restrict",
  2345			.data		= &kptr_restrict,
  2346			.maxlen		= sizeof(int),
  2347			.mode		= 0644,
  2348			.proc_handler	= proc_dointvec_minmax_sysadmin,
  2349			.extra1		= SYSCTL_ZERO,
  2350			.extra2		= SYSCTL_TWO,
  2351		},
  2352	#endif
  2353		{
  2354			.procname	= "ngroups_max",
  2355			.data		= (void *)&ngroups_max,
  2356			.maxlen		= sizeof (int),
  2357			.mode		= 0444,
  2358			.proc_handler	= proc_dointvec,
  2359		},
  2360		{
  2361			.procname	= "cap_last_cap",
  2362			.data		= (void *)&cap_last_cap,
  2363			.maxlen		= sizeof(int),
  2364			.mode		= 0444,
  2365			.proc_handler	= proc_dointvec,
  2366		},
  2367	#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
  2368		{
  2369			.procname       = "unknown_nmi_panic",
  2370			.data           = &unknown_nmi_panic,
  2371			.maxlen         = sizeof (int),
  2372			.mode           = 0644,
  2373			.proc_handler   = proc_dointvec,
  2374		},
  2375	#endif
  2376	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--AhhlLboLdkugWU4S
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--AhhlLboLdkugWU4S--
