Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5070D410D3B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhISUMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:12:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:40588 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhISUL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:11:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="223073870"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="gz'50?scan'50,208,50";a="223073870"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 13:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="gz'50?scan'50,208,50";a="555781456"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2021 13:10:30 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mS38v-0005ci-NU; Sun, 19 Sep 2021 20:10:29 +0000
Date:   Mon, 20 Sep 2021 04:09:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 499/729]
 arch/powerpc/kernel/smp.c:1380:14: error: variable 'ret' set but not used
Message-ID: <202109200442.uIcRaEnf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   1cc4b0ead8e0b1fc178825942dd78cca63d47970
commit: e91077cf1780108dc586cedf1d19f65b44fa3870 [499/729] powerpc/smp: Update cpu_core_map on all PowerPc systems
config: powerpc-ps3_defconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=e91077cf1780108dc586cedf1d19f65b44fa3870
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout e91077cf1780108dc586cedf1d19f65b44fa3870
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/smp.c:551:6: error: no previous prototype for 'tick_broadcast' [-Werror=missing-prototypes]
     551 | void tick_broadcast(const struct cpumask *mask)
         |      ^~~~~~~~~~~~~~
   arch/powerpc/kernel/smp.c: In function 'add_cpu_to_masks':
>> arch/powerpc/kernel/smp.c:1380:14: error: variable 'ret' set but not used [-Werror=unused-but-set-variable]
    1380 |         bool ret;
         |              ^~~
   cc1: all warnings being treated as errors


vim +/ret +1380 arch/powerpc/kernel/smp.c

b8a97cb4599cda Srikar Dronamraju 2020-09-21  1373  
df52f6714071c4 Oliver O'Halloran 2017-06-29  1374  static void add_cpu_to_masks(int cpu)
df52f6714071c4 Oliver O'Halloran 2017-06-29  1375  {
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1376  	struct cpumask *(*submask_fn)(int) = cpu_sibling_mask;
df52f6714071c4 Oliver O'Halloran 2017-06-29  1377  	int first_thread = cpu_first_thread_sibling(cpu);
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1378  	int chip_id = cpu_to_chip_id(cpu);
84dbf66c634720 Srikar Dronamraju 2020-10-19  1379  	cpumask_var_t mask;
bf6476152a0a08 Srikar Dronamraju 2021-04-15 @1380  	bool ret;
df52f6714071c4 Oliver O'Halloran 2017-06-29  1381  	int i;
df52f6714071c4 Oliver O'Halloran 2017-06-29  1382  
df52f6714071c4 Oliver O'Halloran 2017-06-29  1383  	/*
df52f6714071c4 Oliver O'Halloran 2017-06-29  1384  	 * This CPU will not be in the online mask yet so we need to manually
df52f6714071c4 Oliver O'Halloran 2017-06-29  1385  	 * add it to it's own thread sibling mask.
df52f6714071c4 Oliver O'Halloran 2017-06-29  1386  	 */
df52f6714071c4 Oliver O'Halloran 2017-06-29  1387  	cpumask_set_cpu(cpu, cpu_sibling_mask(cpu));
e91077cf178010 Srikar Dronamraju 2021-08-26  1388  	cpumask_set_cpu(cpu, cpu_core_mask(cpu));
df52f6714071c4 Oliver O'Halloran 2017-06-29  1389  
df52f6714071c4 Oliver O'Halloran 2017-06-29  1390  	for (i = first_thread; i < first_thread + threads_per_core; i++)
df52f6714071c4 Oliver O'Halloran 2017-06-29  1391  		if (cpu_online(i))
df52f6714071c4 Oliver O'Halloran 2017-06-29  1392  			set_cpus_related(i, cpu, cpu_sibling_mask);
df52f6714071c4 Oliver O'Halloran 2017-06-29  1393  
425752c63b6f3f Gautham R. Shenoy 2018-10-11  1394  	add_cpu_to_smallcore_masks(cpu);
84dbf66c634720 Srikar Dronamraju 2020-10-19  1395  
84dbf66c634720 Srikar Dronamraju 2020-10-19  1396  	/* In CPU-hotplug path, hence use GFP_ATOMIC */
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1397  	ret = alloc_cpumask_var_node(&mask, GFP_ATOMIC, cpu_to_node(cpu));
84dbf66c634720 Srikar Dronamraju 2020-10-19  1398  	update_mask_by_l2(cpu, &mask);
2a636a56d2d396 Oliver O'Halloran 2017-06-29  1399  
b8a97cb4599cda Srikar Dronamraju 2020-09-21  1400  	if (has_coregroup_support())
84dbf66c634720 Srikar Dronamraju 2020-10-19  1401  		update_coregroup_mask(cpu, &mask);
84dbf66c634720 Srikar Dronamraju 2020-10-19  1402  
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1403  	if (shared_caches)
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1404  		submask_fn = cpu_l2_cache_mask;
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1405  
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1406  	/* Update core_mask with all the CPUs that are part of submask */
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1407  	or_cpumasks_related(cpu, cpu, submask_fn, cpu_core_mask);
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1408  
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1409  	/* Skip all CPUs already part of current CPU core mask */
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1410  	cpumask_andnot(mask, cpu_online_mask, cpu_core_mask(cpu));
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1411  
e91077cf178010 Srikar Dronamraju 2021-08-26  1412  	/* If chip_id is -1; limit the cpu_core_mask to within DIE*/
e91077cf178010 Srikar Dronamraju 2021-08-26  1413  	if (chip_id == -1)
e91077cf178010 Srikar Dronamraju 2021-08-26  1414  		cpumask_and(mask, mask, cpu_cpu_mask(cpu));
e91077cf178010 Srikar Dronamraju 2021-08-26  1415  
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1416  	for_each_cpu(i, mask) {
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1417  		if (chip_id == cpu_to_chip_id(i)) {
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1418  			or_cpumasks_related(cpu, i, submask_fn, cpu_core_mask);
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1419  			cpumask_andnot(mask, mask, submask_fn(i));
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1420  		} else {
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1421  			cpumask_andnot(mask, mask, cpu_core_mask(i));
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1422  		}
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1423  	}
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1424  
84dbf66c634720 Srikar Dronamraju 2020-10-19  1425  	free_cpumask_var(mask);
a8a5356cd511db Paul Mackerras    2013-08-12  1426  }
a8a5356cd511db Paul Mackerras    2013-08-12  1427  

:::::: The code at line 1380 was first introduced by commit
:::::: bf6476152a0a084038b12b9d770e32717f54a6ab powerpc/smp: Reintroduce cpu_core_mask

:::::: TO: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
wChYkQABAA==

--dDRMvlgZJXvWKvBx--
