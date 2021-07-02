Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04D3B9DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhGBI5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:57:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:57907 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhGBI5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:57:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="205692316"
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="205692316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 01:55:03 -0700
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="559851194"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 01:55:02 -0700
Subject: Re: [kbuild-all] arch/arm64/kvm/sys_regs.c:1544:13: warning:
 initialized field overwritten
To:     kernel test robot <lkp@intel.com>, Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202107011859.Aaa29UW0-lkp@intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <e1a81333-7113-8c33-3513-594c15c7b190@intel.com>
Date:   Fri, 2 Jul 2021 16:55:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202107011859.Aaa29UW0-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

It looks like another report 
https://lore.kernel.org/lkml/202106302037.QmEffgZV-lkp@intel.com/
Do you want us to stop report this commit too?

Best Regards,
Rong Chen

On 7/1/21 6:45 PM, kernel test robot wrote:
> Hi Marc,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dbe69e43372212527abf48609aba7fc39a6daa27
> commit: 11663111cd49b4c6dd27479774e420f139e4c447 KVM: arm64: Hide PMU registers from userspace when not available
> date:   6 months ago
> config: arm64-buildonly-randconfig-r002-20210701 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=11663111cd49b4c6dd27479774e420f139e4c447
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 11663111cd49b4c6dd27479774e420f139e4c447
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> arch/arm64/kvm/sys_regs.c:1544:13: warning: initialized field overwritten [-Woverride-init]
>      1544 |    .reset = reset_pmcr, .reg = PMCR_EL0 },
>           |             ^~~~~~~~~~
>     arch/arm64/kvm/sys_regs.c:1544:13: note: (near initialization for 'sys_reg_descs[203].reset')
>     In file included from include/uapi/linux/posix_types.h:5,
>                      from include/uapi/linux/types.h:14,
>                      from include/linux/types.h:6,
>                      from include/linux/bsearch.h:5,
>                      from arch/arm64/kvm/sys_regs.c:12:
>     include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
>         8 | #define NULL ((void *)0)
>           |              ^
>     arch/arm64/kvm/sys_regs.c:1556:38: note: in expansion of macro 'NULL'
>      1556 |    .access = access_pmceid, .reset = NULL },
>           |                                      ^~~~
>     include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[209].reset')
>         8 | #define NULL ((void *)0)
>           |              ^
>     arch/arm64/kvm/sys_regs.c:1556:38: note: in expansion of macro 'NULL'
>      1556 |    .access = access_pmceid, .reset = NULL },
>           |                                      ^~~~
>     include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
>         8 | #define NULL ((void *)0)
>           |              ^
>     arch/arm64/kvm/sys_regs.c:1558:38: note: in expansion of macro 'NULL'
>      1558 |    .access = access_pmceid, .reset = NULL },
>           |                                      ^~~~
>     include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[210].reset')
>         8 | #define NULL ((void *)0)
>           |              ^
>     arch/arm64/kvm/sys_regs.c:1558:38: note: in expansion of macro 'NULL'
>      1558 |    .access = access_pmceid, .reset = NULL },
>           |                                      ^~~~
>     include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
>         8 | #define NULL ((void *)0)
>           |              ^
>     arch/arm64/kvm/sys_regs.c:1562:43: note: in expansion of macro 'NULL'
>      1562 |    .access = access_pmu_evtyper, .reset = NULL },
>           |                                           ^~~~
>     include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[212].reset')
>         8 | #define NULL ((void *)0)
>           |              ^
>     arch/arm64/kvm/sys_regs.c:1562:43: note: in expansion of macro 'NULL'
>      1562 |    .access = access_pmu_evtyper, .reset = NULL },
>           |                                           ^~~~
>     include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
>         8 | #define NULL ((void *)0)
>           |              ^
>     arch/arm64/kvm/sys_regs.c:1564:42: note: in expansion of macro 'NULL'
>      1564 |    .access = access_pmu_evcntr, .reset = NULL },
>           |                                          ^~~~
>     include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[213].reset')
>         8 | #define NULL ((void *)0)
>           |              ^
>     arch/arm64/kvm/sys_regs.c:1564:42: note: in expansion of macro 'NULL'
>      1564 |    .access = access_pmu_evcntr, .reset = NULL },
>           |                                          ^~~~
>     arch/arm64/kvm/sys_regs.c:1570:13: warning: initialized field overwritten [-Woverride-init]
>      1570 |    .reset = reset_val, .reg = PMUSERENR_EL0, .val = 0 },
>           |             ^~~~~~~~~
>     arch/arm64/kvm/sys_regs.c:1570:13: note: (near initialization for 'sys_reg_descs[214].reset')
>     arch/arm64/kvm/sys_regs.c:1725:13: warning: initialized field overwritten [-Woverride-init]
>      1725 |    .reset = reset_val, .reg = PMCCFILTR_EL0, .val = 0 },
>           |             ^~~~~~~~~
>     arch/arm64/kvm/sys_regs.c:1725:13: note: (near initialization for 'sys_reg_descs[356].reset')
>
>
> vim +1544 arch/arm64/kvm/sys_regs.c
>
>    1332	
>    1333	/*
>    1334	 * Architected system registers.
>    1335	 * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
>    1336	 *
>    1337	 * Debug handling: We do trap most, if not all debug related system
>    1338	 * registers. The implementation is good enough to ensure that a guest
>    1339	 * can use these with minimal performance degradation. The drawback is
>    1340	 * that we don't implement any of the external debug, none of the
>    1341	 * OSlock protocol. This should be revisited if we ever encounter a
>    1342	 * more demanding guest...
>    1343	 */
>    1344	static const struct sys_reg_desc sys_reg_descs[] = {
>    1345		{ SYS_DESC(SYS_DC_ISW), access_dcsw },
>    1346		{ SYS_DESC(SYS_DC_CSW), access_dcsw },
>    1347		{ SYS_DESC(SYS_DC_CISW), access_dcsw },
>    1348	
>    1349		DBG_BCR_BVR_WCR_WVR_EL1(0),
>    1350		DBG_BCR_BVR_WCR_WVR_EL1(1),
>    1351		{ SYS_DESC(SYS_MDCCINT_EL1), trap_debug_regs, reset_val, MDCCINT_EL1, 0 },
>    1352		{ SYS_DESC(SYS_MDSCR_EL1), trap_debug_regs, reset_val, MDSCR_EL1, 0 },
>    1353		DBG_BCR_BVR_WCR_WVR_EL1(2),
>    1354		DBG_BCR_BVR_WCR_WVR_EL1(3),
>    1355		DBG_BCR_BVR_WCR_WVR_EL1(4),
>    1356		DBG_BCR_BVR_WCR_WVR_EL1(5),
>    1357		DBG_BCR_BVR_WCR_WVR_EL1(6),
>    1358		DBG_BCR_BVR_WCR_WVR_EL1(7),
>    1359		DBG_BCR_BVR_WCR_WVR_EL1(8),
>    1360		DBG_BCR_BVR_WCR_WVR_EL1(9),
>    1361		DBG_BCR_BVR_WCR_WVR_EL1(10),
>    1362		DBG_BCR_BVR_WCR_WVR_EL1(11),
>    1363		DBG_BCR_BVR_WCR_WVR_EL1(12),
>    1364		DBG_BCR_BVR_WCR_WVR_EL1(13),
>    1365		DBG_BCR_BVR_WCR_WVR_EL1(14),
>    1366		DBG_BCR_BVR_WCR_WVR_EL1(15),
>    1367	
>    1368		{ SYS_DESC(SYS_MDRAR_EL1), trap_raz_wi },
>    1369		{ SYS_DESC(SYS_OSLAR_EL1), trap_raz_wi },
>    1370		{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1 },
>    1371		{ SYS_DESC(SYS_OSDLR_EL1), trap_raz_wi },
>    1372		{ SYS_DESC(SYS_DBGPRCR_EL1), trap_raz_wi },
>    1373		{ SYS_DESC(SYS_DBGCLAIMSET_EL1), trap_raz_wi },
>    1374		{ SYS_DESC(SYS_DBGCLAIMCLR_EL1), trap_raz_wi },
>    1375		{ SYS_DESC(SYS_DBGAUTHSTATUS_EL1), trap_dbgauthstatus_el1 },
>    1376	
>    1377		{ SYS_DESC(SYS_MDCCSR_EL0), trap_raz_wi },
>    1378		{ SYS_DESC(SYS_DBGDTR_EL0), trap_raz_wi },
>    1379		// DBGDTR[TR]X_EL0 share the same encoding
>    1380		{ SYS_DESC(SYS_DBGDTRTX_EL0), trap_raz_wi },
>    1381	
>    1382		{ SYS_DESC(SYS_DBGVCR32_EL2), NULL, reset_val, DBGVCR32_EL2, 0 },
>    1383	
>    1384		{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1 },
>    1385	
>    1386		/*
>    1387		 * ID regs: all ID_SANITISED() entries here must have corresponding
>    1388		 * entries in arm64_ftr_regs[].
>    1389		 */
>    1390	
>    1391		/* AArch64 mappings of the AArch32 ID registers */
>    1392		/* CRm=1 */
>    1393		ID_SANITISED(ID_PFR0_EL1),
>    1394		ID_SANITISED(ID_PFR1_EL1),
>    1395		ID_SANITISED(ID_DFR0_EL1),
>    1396		ID_HIDDEN(ID_AFR0_EL1),
>    1397		ID_SANITISED(ID_MMFR0_EL1),
>    1398		ID_SANITISED(ID_MMFR1_EL1),
>    1399		ID_SANITISED(ID_MMFR2_EL1),
>    1400		ID_SANITISED(ID_MMFR3_EL1),
>    1401	
>    1402		/* CRm=2 */
>    1403		ID_SANITISED(ID_ISAR0_EL1),
>    1404		ID_SANITISED(ID_ISAR1_EL1),
>    1405		ID_SANITISED(ID_ISAR2_EL1),
>    1406		ID_SANITISED(ID_ISAR3_EL1),
>    1407		ID_SANITISED(ID_ISAR4_EL1),
>    1408		ID_SANITISED(ID_ISAR5_EL1),
>    1409		ID_SANITISED(ID_MMFR4_EL1),
>    1410		ID_SANITISED(ID_ISAR6_EL1),
>    1411	
>    1412		/* CRm=3 */
>    1413		ID_SANITISED(MVFR0_EL1),
>    1414		ID_SANITISED(MVFR1_EL1),
>    1415		ID_SANITISED(MVFR2_EL1),
>    1416		ID_UNALLOCATED(3,3),
>    1417		ID_SANITISED(ID_PFR2_EL1),
>    1418		ID_HIDDEN(ID_DFR1_EL1),
>    1419		ID_SANITISED(ID_MMFR5_EL1),
>    1420		ID_UNALLOCATED(3,7),
>    1421	
>    1422		/* AArch64 ID registers */
>    1423		/* CRm=4 */
>    1424		{ SYS_DESC(SYS_ID_AA64PFR0_EL1), .access = access_id_reg,
>    1425		  .get_user = get_id_reg, .set_user = set_id_aa64pfr0_el1, },
>    1426		ID_SANITISED(ID_AA64PFR1_EL1),
>    1427		ID_UNALLOCATED(4,2),
>    1428		ID_UNALLOCATED(4,3),
>    1429		ID_SANITISED(ID_AA64ZFR0_EL1),
>    1430		ID_UNALLOCATED(4,5),
>    1431		ID_UNALLOCATED(4,6),
>    1432		ID_UNALLOCATED(4,7),
>    1433	
>    1434		/* CRm=5 */
>    1435		ID_SANITISED(ID_AA64DFR0_EL1),
>    1436		ID_SANITISED(ID_AA64DFR1_EL1),
>    1437		ID_UNALLOCATED(5,2),
>    1438		ID_UNALLOCATED(5,3),
>    1439		ID_HIDDEN(ID_AA64AFR0_EL1),
>    1440		ID_HIDDEN(ID_AA64AFR1_EL1),
>    1441		ID_UNALLOCATED(5,6),
>    1442		ID_UNALLOCATED(5,7),
>    1443	
>    1444		/* CRm=6 */
>    1445		ID_SANITISED(ID_AA64ISAR0_EL1),
>    1446		ID_SANITISED(ID_AA64ISAR1_EL1),
>    1447		ID_UNALLOCATED(6,2),
>    1448		ID_UNALLOCATED(6,3),
>    1449		ID_UNALLOCATED(6,4),
>    1450		ID_UNALLOCATED(6,5),
>    1451		ID_UNALLOCATED(6,6),
>    1452		ID_UNALLOCATED(6,7),
>    1453	
>    1454		/* CRm=7 */
>    1455		ID_SANITISED(ID_AA64MMFR0_EL1),
>    1456		ID_SANITISED(ID_AA64MMFR1_EL1),
>    1457		ID_SANITISED(ID_AA64MMFR2_EL1),
>    1458		ID_UNALLOCATED(7,3),
>    1459		ID_UNALLOCATED(7,4),
>    1460		ID_UNALLOCATED(7,5),
>    1461		ID_UNALLOCATED(7,6),
>    1462		ID_UNALLOCATED(7,7),
>    1463	
>    1464		{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
>    1465		{ SYS_DESC(SYS_ACTLR_EL1), access_actlr, reset_actlr, ACTLR_EL1 },
>    1466		{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
>    1467	
>    1468		{ SYS_DESC(SYS_RGSR_EL1), undef_access },
>    1469		{ SYS_DESC(SYS_GCR_EL1), undef_access },
>    1470	
>    1471		{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
>    1472		{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
>    1473		{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
>    1474		{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
>    1475	
>    1476		PTRAUTH_KEY(APIA),
>    1477		PTRAUTH_KEY(APIB),
>    1478		PTRAUTH_KEY(APDA),
>    1479		PTRAUTH_KEY(APDB),
>    1480		PTRAUTH_KEY(APGA),
>    1481	
>    1482		{ SYS_DESC(SYS_AFSR0_EL1), access_vm_reg, reset_unknown, AFSR0_EL1 },
>    1483		{ SYS_DESC(SYS_AFSR1_EL1), access_vm_reg, reset_unknown, AFSR1_EL1 },
>    1484		{ SYS_DESC(SYS_ESR_EL1), access_vm_reg, reset_unknown, ESR_EL1 },
>    1485	
>    1486		{ SYS_DESC(SYS_ERRIDR_EL1), trap_raz_wi },
>    1487		{ SYS_DESC(SYS_ERRSELR_EL1), trap_raz_wi },
>    1488		{ SYS_DESC(SYS_ERXFR_EL1), trap_raz_wi },
>    1489		{ SYS_DESC(SYS_ERXCTLR_EL1), trap_raz_wi },
>    1490		{ SYS_DESC(SYS_ERXSTATUS_EL1), trap_raz_wi },
>    1491		{ SYS_DESC(SYS_ERXADDR_EL1), trap_raz_wi },
>    1492		{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
>    1493		{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
>    1494	
>    1495		{ SYS_DESC(SYS_TFSR_EL1), undef_access },
>    1496		{ SYS_DESC(SYS_TFSRE0_EL1), undef_access },
>    1497	
>    1498		{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
>    1499		{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
>    1500	
>    1501		{ PMU_SYS_REG(SYS_PMINTENSET_EL1),
>    1502		  .access = access_pminten, .reg = PMINTENSET_EL1 },
>    1503		{ PMU_SYS_REG(SYS_PMINTENCLR_EL1),
>    1504		  .access = access_pminten, .reg = PMINTENSET_EL1 },
>    1505	
>    1506		{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
>    1507		{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
>    1508	
>    1509		{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
>    1510		{ SYS_DESC(SYS_LOREA_EL1), trap_loregion },
>    1511		{ SYS_DESC(SYS_LORN_EL1), trap_loregion },
>    1512		{ SYS_DESC(SYS_LORC_EL1), trap_loregion },
>    1513		{ SYS_DESC(SYS_LORID_EL1), trap_loregion },
>    1514	
>    1515		{ SYS_DESC(SYS_VBAR_EL1), NULL, reset_val, VBAR_EL1, 0 },
>    1516		{ SYS_DESC(SYS_DISR_EL1), NULL, reset_val, DISR_EL1, 0 },
>    1517	
>    1518		{ SYS_DESC(SYS_ICC_IAR0_EL1), write_to_read_only },
>    1519		{ SYS_DESC(SYS_ICC_EOIR0_EL1), read_from_write_only },
>    1520		{ SYS_DESC(SYS_ICC_HPPIR0_EL1), write_to_read_only },
>    1521		{ SYS_DESC(SYS_ICC_DIR_EL1), read_from_write_only },
>    1522		{ SYS_DESC(SYS_ICC_RPR_EL1), write_to_read_only },
>    1523		{ SYS_DESC(SYS_ICC_SGI1R_EL1), access_gic_sgi },
>    1524		{ SYS_DESC(SYS_ICC_ASGI1R_EL1), access_gic_sgi },
>    1525		{ SYS_DESC(SYS_ICC_SGI0R_EL1), access_gic_sgi },
>    1526		{ SYS_DESC(SYS_ICC_IAR1_EL1), write_to_read_only },
>    1527		{ SYS_DESC(SYS_ICC_EOIR1_EL1), read_from_write_only },
>    1528		{ SYS_DESC(SYS_ICC_HPPIR1_EL1), write_to_read_only },
>    1529		{ SYS_DESC(SYS_ICC_SRE_EL1), access_gic_sre },
>    1530	
>    1531		{ SYS_DESC(SYS_CONTEXTIDR_EL1), access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
>    1532		{ SYS_DESC(SYS_TPIDR_EL1), NULL, reset_unknown, TPIDR_EL1 },
>    1533	
>    1534		{ SYS_DESC(SYS_SCXTNUM_EL1), undef_access },
>    1535	
>    1536		{ SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
>    1537	
>    1538		{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
>    1539		{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
>    1540		{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
>    1541		{ SYS_DESC(SYS_CTR_EL0), access_ctr },
>    1542	
>    1543		{ PMU_SYS_REG(SYS_PMCR_EL0), .access = access_pmcr,
>> 1544		  .reset = reset_pmcr, .reg = PMCR_EL0 },
>    1545		{ PMU_SYS_REG(SYS_PMCNTENSET_EL0),
>    1546		  .access = access_pmcnten, .reg = PMCNTENSET_EL0 },
>    1547		{ PMU_SYS_REG(SYS_PMCNTENCLR_EL0),
>    1548		  .access = access_pmcnten, .reg = PMCNTENSET_EL0 },
>    1549		{ PMU_SYS_REG(SYS_PMOVSCLR_EL0),
>    1550		  .access = access_pmovs, .reg = PMOVSSET_EL0 },
>    1551		{ PMU_SYS_REG(SYS_PMSWINC_EL0),
>    1552		  .access = access_pmswinc, .reg = PMSWINC_EL0 },
>    1553		{ PMU_SYS_REG(SYS_PMSELR_EL0),
>    1554		  .access = access_pmselr, .reg = PMSELR_EL0 },
>    1555		{ PMU_SYS_REG(SYS_PMCEID0_EL0),
>    1556		  .access = access_pmceid, .reset = NULL },
>    1557		{ PMU_SYS_REG(SYS_PMCEID1_EL0),
>    1558		  .access = access_pmceid, .reset = NULL },
>    1559		{ PMU_SYS_REG(SYS_PMCCNTR_EL0),
>    1560		  .access = access_pmu_evcntr, .reg = PMCCNTR_EL0 },
>    1561		{ PMU_SYS_REG(SYS_PMXEVTYPER_EL0),
>    1562		  .access = access_pmu_evtyper, .reset = NULL },
>    1563		{ PMU_SYS_REG(SYS_PMXEVCNTR_EL0),
>    1564		  .access = access_pmu_evcntr, .reset = NULL },
>    1565		/*
>    1566		 * PMUSERENR_EL0 resets as unknown in 64bit mode while it resets as zero
>    1567		 * in 32bit mode. Here we choose to reset it as zero for consistency.
>    1568		 */
>    1569		{ PMU_SYS_REG(SYS_PMUSERENR_EL0), .access = access_pmuserenr,
>    1570		  .reset = reset_val, .reg = PMUSERENR_EL0, .val = 0 },
>    1571		{ PMU_SYS_REG(SYS_PMOVSSET_EL0),
>    1572		  .access = access_pmovs, .reg = PMOVSSET_EL0 },
>    1573	
>    1574		{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
>    1575		{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
>    1576	
>    1577		{ SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
>    1578	
>    1579		{ SYS_DESC(SYS_AMCR_EL0), undef_access },
>    1580		{ SYS_DESC(SYS_AMCFGR_EL0), undef_access },
>    1581		{ SYS_DESC(SYS_AMCGCR_EL0), undef_access },
>    1582		{ SYS_DESC(SYS_AMUSERENR_EL0), undef_access },
>    1583		{ SYS_DESC(SYS_AMCNTENCLR0_EL0), undef_access },
>    1584		{ SYS_DESC(SYS_AMCNTENSET0_EL0), undef_access },
>    1585		{ SYS_DESC(SYS_AMCNTENCLR1_EL0), undef_access },
>    1586		{ SYS_DESC(SYS_AMCNTENSET1_EL0), undef_access },
>    1587		AMU_AMEVCNTR0_EL0(0),
>    1588		AMU_AMEVCNTR0_EL0(1),
>    1589		AMU_AMEVCNTR0_EL0(2),
>    1590		AMU_AMEVCNTR0_EL0(3),
>    1591		AMU_AMEVCNTR0_EL0(4),
>    1592		AMU_AMEVCNTR0_EL0(5),
>    1593		AMU_AMEVCNTR0_EL0(6),
>    1594		AMU_AMEVCNTR0_EL0(7),
>    1595		AMU_AMEVCNTR0_EL0(8),
>    1596		AMU_AMEVCNTR0_EL0(9),
>    1597		AMU_AMEVCNTR0_EL0(10),
>    1598		AMU_AMEVCNTR0_EL0(11),
>    1599		AMU_AMEVCNTR0_EL0(12),
>    1600		AMU_AMEVCNTR0_EL0(13),
>    1601		AMU_AMEVCNTR0_EL0(14),
>    1602		AMU_AMEVCNTR0_EL0(15),
>    1603		AMU_AMEVTYPER0_EL0(0),
>    1604		AMU_AMEVTYPER0_EL0(1),
>    1605		AMU_AMEVTYPER0_EL0(2),
>    1606		AMU_AMEVTYPER0_EL0(3),
>    1607		AMU_AMEVTYPER0_EL0(4),
>    1608		AMU_AMEVTYPER0_EL0(5),
>    1609		AMU_AMEVTYPER0_EL0(6),
>    1610		AMU_AMEVTYPER0_EL0(7),
>    1611		AMU_AMEVTYPER0_EL0(8),
>    1612		AMU_AMEVTYPER0_EL0(9),
>    1613		AMU_AMEVTYPER0_EL0(10),
>    1614		AMU_AMEVTYPER0_EL0(11),
>    1615		AMU_AMEVTYPER0_EL0(12),
>    1616		AMU_AMEVTYPER0_EL0(13),
>    1617		AMU_AMEVTYPER0_EL0(14),
>    1618		AMU_AMEVTYPER0_EL0(15),
>    1619		AMU_AMEVCNTR1_EL0(0),
>    1620		AMU_AMEVCNTR1_EL0(1),
>    1621		AMU_AMEVCNTR1_EL0(2),
>    1622		AMU_AMEVCNTR1_EL0(3),
>    1623		AMU_AMEVCNTR1_EL0(4),
>    1624		AMU_AMEVCNTR1_EL0(5),
>    1625		AMU_AMEVCNTR1_EL0(6),
>    1626		AMU_AMEVCNTR1_EL0(7),
>    1627		AMU_AMEVCNTR1_EL0(8),
>    1628		AMU_AMEVCNTR1_EL0(9),
>    1629		AMU_AMEVCNTR1_EL0(10),
>    1630		AMU_AMEVCNTR1_EL0(11),
>    1631		AMU_AMEVCNTR1_EL0(12),
>    1632		AMU_AMEVCNTR1_EL0(13),
>    1633		AMU_AMEVCNTR1_EL0(14),
>    1634		AMU_AMEVCNTR1_EL0(15),
>    1635		AMU_AMEVTYPER1_EL0(0),
>    1636		AMU_AMEVTYPER1_EL0(1),
>    1637		AMU_AMEVTYPER1_EL0(2),
>    1638		AMU_AMEVTYPER1_EL0(3),
>    1639		AMU_AMEVTYPER1_EL0(4),
>    1640		AMU_AMEVTYPER1_EL0(5),
>    1641		AMU_AMEVTYPER1_EL0(6),
>    1642		AMU_AMEVTYPER1_EL0(7),
>    1643		AMU_AMEVTYPER1_EL0(8),
>    1644		AMU_AMEVTYPER1_EL0(9),
>    1645		AMU_AMEVTYPER1_EL0(10),
>    1646		AMU_AMEVTYPER1_EL0(11),
>    1647		AMU_AMEVTYPER1_EL0(12),
>    1648		AMU_AMEVTYPER1_EL0(13),
>    1649		AMU_AMEVTYPER1_EL0(14),
>    1650		AMU_AMEVTYPER1_EL0(15),
>    1651	
>    1652		{ SYS_DESC(SYS_CNTP_TVAL_EL0), access_arch_timer },
>    1653		{ SYS_DESC(SYS_CNTP_CTL_EL0), access_arch_timer },
>    1654		{ SYS_DESC(SYS_CNTP_CVAL_EL0), access_arch_timer },
>    1655	
>    1656		/* PMEVCNTRn_EL0 */
>    1657		PMU_PMEVCNTR_EL0(0),
>    1658		PMU_PMEVCNTR_EL0(1),
>    1659		PMU_PMEVCNTR_EL0(2),
>    1660		PMU_PMEVCNTR_EL0(3),
>    1661		PMU_PMEVCNTR_EL0(4),
>    1662		PMU_PMEVCNTR_EL0(5),
>    1663		PMU_PMEVCNTR_EL0(6),
>    1664		PMU_PMEVCNTR_EL0(7),
>    1665		PMU_PMEVCNTR_EL0(8),
>    1666		PMU_PMEVCNTR_EL0(9),
>    1667		PMU_PMEVCNTR_EL0(10),
>    1668		PMU_PMEVCNTR_EL0(11),
>    1669		PMU_PMEVCNTR_EL0(12),
>    1670		PMU_PMEVCNTR_EL0(13),
>    1671		PMU_PMEVCNTR_EL0(14),
>    1672		PMU_PMEVCNTR_EL0(15),
>    1673		PMU_PMEVCNTR_EL0(16),
>    1674		PMU_PMEVCNTR_EL0(17),
>    1675		PMU_PMEVCNTR_EL0(18),
>    1676		PMU_PMEVCNTR_EL0(19),
>    1677		PMU_PMEVCNTR_EL0(20),
>    1678		PMU_PMEVCNTR_EL0(21),
>    1679		PMU_PMEVCNTR_EL0(22),
>    1680		PMU_PMEVCNTR_EL0(23),
>    1681		PMU_PMEVCNTR_EL0(24),
>    1682		PMU_PMEVCNTR_EL0(25),
>    1683		PMU_PMEVCNTR_EL0(26),
>    1684		PMU_PMEVCNTR_EL0(27),
>    1685		PMU_PMEVCNTR_EL0(28),
>    1686		PMU_PMEVCNTR_EL0(29),
>    1687		PMU_PMEVCNTR_EL0(30),
>    1688		/* PMEVTYPERn_EL0 */
>    1689		PMU_PMEVTYPER_EL0(0),
>    1690		PMU_PMEVTYPER_EL0(1),
>    1691		PMU_PMEVTYPER_EL0(2),
>    1692		PMU_PMEVTYPER_EL0(3),
>    1693		PMU_PMEVTYPER_EL0(4),
>    1694		PMU_PMEVTYPER_EL0(5),
>    1695		PMU_PMEVTYPER_EL0(6),
>    1696		PMU_PMEVTYPER_EL0(7),
>    1697		PMU_PMEVTYPER_EL0(8),
>    1698		PMU_PMEVTYPER_EL0(9),
>    1699		PMU_PMEVTYPER_EL0(10),
>    1700		PMU_PMEVTYPER_EL0(11),
>    1701		PMU_PMEVTYPER_EL0(12),
>    1702		PMU_PMEVTYPER_EL0(13),
>    1703		PMU_PMEVTYPER_EL0(14),
>    1704		PMU_PMEVTYPER_EL0(15),
>    1705		PMU_PMEVTYPER_EL0(16),
>    1706		PMU_PMEVTYPER_EL0(17),
>    1707		PMU_PMEVTYPER_EL0(18),
>    1708		PMU_PMEVTYPER_EL0(19),
>    1709		PMU_PMEVTYPER_EL0(20),
>    1710		PMU_PMEVTYPER_EL0(21),
>    1711		PMU_PMEVTYPER_EL0(22),
>    1712		PMU_PMEVTYPER_EL0(23),
>    1713		PMU_PMEVTYPER_EL0(24),
>    1714		PMU_PMEVTYPER_EL0(25),
>    1715		PMU_PMEVTYPER_EL0(26),
>    1716		PMU_PMEVTYPER_EL0(27),
>    1717		PMU_PMEVTYPER_EL0(28),
>    1718		PMU_PMEVTYPER_EL0(29),
>    1719		PMU_PMEVTYPER_EL0(30),
>    1720		/*
>    1721		 * PMCCFILTR_EL0 resets as unknown in 64bit mode while it resets as zero
>    1722		 * in 32bit mode. Here we choose to reset it as zero for consistency.
>    1723		 */
>    1724		{ PMU_SYS_REG(SYS_PMCCFILTR_EL0), .access = access_pmu_evtyper,
>    1725		  .reset = reset_val, .reg = PMCCFILTR_EL0, .val = 0 },
>    1726	
>    1727		{ SYS_DESC(SYS_DACR32_EL2), NULL, reset_unknown, DACR32_EL2 },
>    1728		{ SYS_DESC(SYS_IFSR32_EL2), NULL, reset_unknown, IFSR32_EL2 },
>    1729		{ SYS_DESC(SYS_FPEXC32_EL2), NULL, reset_val, FPEXC32_EL2, 0x700 },
>    1730	};
>    1731	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

