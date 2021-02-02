Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC130CDEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhBBV11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:27:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:3068 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231540AbhBBV1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:27:21 -0500
IronPort-SDR: 9QDkbt39XvC0+MWeN0NUFM0+QSmnaabjdu1JutI3spc7Gm+++AOOSqqrAOiou0c9JfHy4t9bQf
 LCcrMHAeNB8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160101612"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="gz'50?scan'50,208,50";a="160101612"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 13:26:37 -0800
IronPort-SDR: vB4kxMb4+rDuGJGlr+uKEOHnK+1GC/mrCoUERKnLRPpXWVvVT3XKOco462fUZMh+McFEXTXt9A
 BGsDiE6T6NlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="gz'50?scan'50,208,50";a="359210807"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2021 13:26:35 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l73Bz-0009gC-64; Tue, 02 Feb 2021 21:26:35 +0000
Date:   Wed, 3 Feb 2021 05:25:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm64/kvm/sys_regs.c:1544:13: warning: initialized field
 overwritten
Message-ID: <202102030543.QhRu6wTo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3aaf0a27ffc29b19a62314edd684b9bc6346f9a8
commit: 11663111cd49b4c6dd27479774e420f139e4c447 KVM: arm64: Hide PMU registers from userspace when not available
date:   3 weeks ago
config: arm64-randconfig-r024-20210202 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=11663111cd49b4c6dd27479774e420f139e4c447
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 11663111cd49b4c6dd27479774e420f139e4c447
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/sys_regs.c:1544:13: warning: initialized field overwritten [-Woverride-init]
    1544 |    .reset = reset_pmcr, .reg = PMCR_EL0 },
         |             ^~~~~~~~~~
   arch/arm64/kvm/sys_regs.c:1544:13: note: (near initialization for 'sys_reg_descs[203].reset')
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/bsearch.h:5,
                    from arch/arm64/kvm/sys_regs.c:12:
   include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1556:38: note: in expansion of macro 'NULL'
    1556 |    .access = access_pmceid, .reset = NULL },
         |                                      ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[209].reset')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1556:38: note: in expansion of macro 'NULL'
    1556 |    .access = access_pmceid, .reset = NULL },
         |                                      ^~~~
   include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1558:38: note: in expansion of macro 'NULL'
    1558 |    .access = access_pmceid, .reset = NULL },
         |                                      ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[210].reset')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1558:38: note: in expansion of macro 'NULL'
    1558 |    .access = access_pmceid, .reset = NULL },
         |                                      ^~~~
   include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1562:43: note: in expansion of macro 'NULL'
    1562 |    .access = access_pmu_evtyper, .reset = NULL },
         |                                           ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[212].reset')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1562:43: note: in expansion of macro 'NULL'
    1562 |    .access = access_pmu_evtyper, .reset = NULL },
         |                                           ^~~~
   include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1564:42: note: in expansion of macro 'NULL'
    1564 |    .access = access_pmu_evcntr, .reset = NULL },
         |                                          ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[213].reset')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1564:42: note: in expansion of macro 'NULL'
    1564 |    .access = access_pmu_evcntr, .reset = NULL },
         |                                          ^~~~
   arch/arm64/kvm/sys_regs.c:1570:13: warning: initialized field overwritten [-Woverride-init]
    1570 |    .reset = reset_val, .reg = PMUSERENR_EL0, .val = 0 },
         |             ^~~~~~~~~
   arch/arm64/kvm/sys_regs.c:1570:13: note: (near initialization for 'sys_reg_descs[214].reset')
   arch/arm64/kvm/sys_regs.c:1725:13: warning: initialized field overwritten [-Woverride-init]
    1725 |    .reset = reset_val, .reg = PMCCFILTR_EL0, .val = 0 },
         |             ^~~~~~~~~
   arch/arm64/kvm/sys_regs.c:1725:13: note: (near initialization for 'sys_reg_descs[356].reset')


vim +1544 arch/arm64/kvm/sys_regs.c

  1332	
  1333	/*
  1334	 * Architected system registers.
  1335	 * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
  1336	 *
  1337	 * Debug handling: We do trap most, if not all debug related system
  1338	 * registers. The implementation is good enough to ensure that a guest
  1339	 * can use these with minimal performance degradation. The drawback is
  1340	 * that we don't implement any of the external debug, none of the
  1341	 * OSlock protocol. This should be revisited if we ever encounter a
  1342	 * more demanding guest...
  1343	 */
  1344	static const struct sys_reg_desc sys_reg_descs[] = {
  1345		{ SYS_DESC(SYS_DC_ISW), access_dcsw },
  1346		{ SYS_DESC(SYS_DC_CSW), access_dcsw },
  1347		{ SYS_DESC(SYS_DC_CISW), access_dcsw },
  1348	
  1349		DBG_BCR_BVR_WCR_WVR_EL1(0),
  1350		DBG_BCR_BVR_WCR_WVR_EL1(1),
  1351		{ SYS_DESC(SYS_MDCCINT_EL1), trap_debug_regs, reset_val, MDCCINT_EL1, 0 },
  1352		{ SYS_DESC(SYS_MDSCR_EL1), trap_debug_regs, reset_val, MDSCR_EL1, 0 },
  1353		DBG_BCR_BVR_WCR_WVR_EL1(2),
  1354		DBG_BCR_BVR_WCR_WVR_EL1(3),
  1355		DBG_BCR_BVR_WCR_WVR_EL1(4),
  1356		DBG_BCR_BVR_WCR_WVR_EL1(5),
  1357		DBG_BCR_BVR_WCR_WVR_EL1(6),
  1358		DBG_BCR_BVR_WCR_WVR_EL1(7),
  1359		DBG_BCR_BVR_WCR_WVR_EL1(8),
  1360		DBG_BCR_BVR_WCR_WVR_EL1(9),
  1361		DBG_BCR_BVR_WCR_WVR_EL1(10),
  1362		DBG_BCR_BVR_WCR_WVR_EL1(11),
  1363		DBG_BCR_BVR_WCR_WVR_EL1(12),
  1364		DBG_BCR_BVR_WCR_WVR_EL1(13),
  1365		DBG_BCR_BVR_WCR_WVR_EL1(14),
  1366		DBG_BCR_BVR_WCR_WVR_EL1(15),
  1367	
  1368		{ SYS_DESC(SYS_MDRAR_EL1), trap_raz_wi },
  1369		{ SYS_DESC(SYS_OSLAR_EL1), trap_raz_wi },
  1370		{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1 },
  1371		{ SYS_DESC(SYS_OSDLR_EL1), trap_raz_wi },
  1372		{ SYS_DESC(SYS_DBGPRCR_EL1), trap_raz_wi },
  1373		{ SYS_DESC(SYS_DBGCLAIMSET_EL1), trap_raz_wi },
  1374		{ SYS_DESC(SYS_DBGCLAIMCLR_EL1), trap_raz_wi },
  1375		{ SYS_DESC(SYS_DBGAUTHSTATUS_EL1), trap_dbgauthstatus_el1 },
  1376	
  1377		{ SYS_DESC(SYS_MDCCSR_EL0), trap_raz_wi },
  1378		{ SYS_DESC(SYS_DBGDTR_EL0), trap_raz_wi },
  1379		// DBGDTR[TR]X_EL0 share the same encoding
  1380		{ SYS_DESC(SYS_DBGDTRTX_EL0), trap_raz_wi },
  1381	
  1382		{ SYS_DESC(SYS_DBGVCR32_EL2), NULL, reset_val, DBGVCR32_EL2, 0 },
  1383	
  1384		{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1 },
  1385	
  1386		/*
  1387		 * ID regs: all ID_SANITISED() entries here must have corresponding
  1388		 * entries in arm64_ftr_regs[].
  1389		 */
  1390	
  1391		/* AArch64 mappings of the AArch32 ID registers */
  1392		/* CRm=1 */
  1393		ID_SANITISED(ID_PFR0_EL1),
  1394		ID_SANITISED(ID_PFR1_EL1),
  1395		ID_SANITISED(ID_DFR0_EL1),
  1396		ID_HIDDEN(ID_AFR0_EL1),
  1397		ID_SANITISED(ID_MMFR0_EL1),
  1398		ID_SANITISED(ID_MMFR1_EL1),
  1399		ID_SANITISED(ID_MMFR2_EL1),
  1400		ID_SANITISED(ID_MMFR3_EL1),
  1401	
  1402		/* CRm=2 */
  1403		ID_SANITISED(ID_ISAR0_EL1),
  1404		ID_SANITISED(ID_ISAR1_EL1),
  1405		ID_SANITISED(ID_ISAR2_EL1),
  1406		ID_SANITISED(ID_ISAR3_EL1),
  1407		ID_SANITISED(ID_ISAR4_EL1),
  1408		ID_SANITISED(ID_ISAR5_EL1),
  1409		ID_SANITISED(ID_MMFR4_EL1),
  1410		ID_SANITISED(ID_ISAR6_EL1),
  1411	
  1412		/* CRm=3 */
  1413		ID_SANITISED(MVFR0_EL1),
  1414		ID_SANITISED(MVFR1_EL1),
  1415		ID_SANITISED(MVFR2_EL1),
  1416		ID_UNALLOCATED(3,3),
  1417		ID_SANITISED(ID_PFR2_EL1),
  1418		ID_HIDDEN(ID_DFR1_EL1),
  1419		ID_SANITISED(ID_MMFR5_EL1),
  1420		ID_UNALLOCATED(3,7),
  1421	
  1422		/* AArch64 ID registers */
  1423		/* CRm=4 */
  1424		{ SYS_DESC(SYS_ID_AA64PFR0_EL1), .access = access_id_reg,
  1425		  .get_user = get_id_reg, .set_user = set_id_aa64pfr0_el1, },
  1426		ID_SANITISED(ID_AA64PFR1_EL1),
  1427		ID_UNALLOCATED(4,2),
  1428		ID_UNALLOCATED(4,3),
  1429		ID_SANITISED(ID_AA64ZFR0_EL1),
  1430		ID_UNALLOCATED(4,5),
  1431		ID_UNALLOCATED(4,6),
  1432		ID_UNALLOCATED(4,7),
  1433	
  1434		/* CRm=5 */
  1435		ID_SANITISED(ID_AA64DFR0_EL1),
  1436		ID_SANITISED(ID_AA64DFR1_EL1),
  1437		ID_UNALLOCATED(5,2),
  1438		ID_UNALLOCATED(5,3),
  1439		ID_HIDDEN(ID_AA64AFR0_EL1),
  1440		ID_HIDDEN(ID_AA64AFR1_EL1),
  1441		ID_UNALLOCATED(5,6),
  1442		ID_UNALLOCATED(5,7),
  1443	
  1444		/* CRm=6 */
  1445		ID_SANITISED(ID_AA64ISAR0_EL1),
  1446		ID_SANITISED(ID_AA64ISAR1_EL1),
  1447		ID_UNALLOCATED(6,2),
  1448		ID_UNALLOCATED(6,3),
  1449		ID_UNALLOCATED(6,4),
  1450		ID_UNALLOCATED(6,5),
  1451		ID_UNALLOCATED(6,6),
  1452		ID_UNALLOCATED(6,7),
  1453	
  1454		/* CRm=7 */
  1455		ID_SANITISED(ID_AA64MMFR0_EL1),
  1456		ID_SANITISED(ID_AA64MMFR1_EL1),
  1457		ID_SANITISED(ID_AA64MMFR2_EL1),
  1458		ID_UNALLOCATED(7,3),
  1459		ID_UNALLOCATED(7,4),
  1460		ID_UNALLOCATED(7,5),
  1461		ID_UNALLOCATED(7,6),
  1462		ID_UNALLOCATED(7,7),
  1463	
  1464		{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
  1465		{ SYS_DESC(SYS_ACTLR_EL1), access_actlr, reset_actlr, ACTLR_EL1 },
  1466		{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
  1467	
  1468		{ SYS_DESC(SYS_RGSR_EL1), undef_access },
  1469		{ SYS_DESC(SYS_GCR_EL1), undef_access },
  1470	
  1471		{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
  1472		{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
  1473		{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
  1474		{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
  1475	
  1476		PTRAUTH_KEY(APIA),
  1477		PTRAUTH_KEY(APIB),
  1478		PTRAUTH_KEY(APDA),
  1479		PTRAUTH_KEY(APDB),
  1480		PTRAUTH_KEY(APGA),
  1481	
  1482		{ SYS_DESC(SYS_AFSR0_EL1), access_vm_reg, reset_unknown, AFSR0_EL1 },
  1483		{ SYS_DESC(SYS_AFSR1_EL1), access_vm_reg, reset_unknown, AFSR1_EL1 },
  1484		{ SYS_DESC(SYS_ESR_EL1), access_vm_reg, reset_unknown, ESR_EL1 },
  1485	
  1486		{ SYS_DESC(SYS_ERRIDR_EL1), trap_raz_wi },
  1487		{ SYS_DESC(SYS_ERRSELR_EL1), trap_raz_wi },
  1488		{ SYS_DESC(SYS_ERXFR_EL1), trap_raz_wi },
  1489		{ SYS_DESC(SYS_ERXCTLR_EL1), trap_raz_wi },
  1490		{ SYS_DESC(SYS_ERXSTATUS_EL1), trap_raz_wi },
  1491		{ SYS_DESC(SYS_ERXADDR_EL1), trap_raz_wi },
  1492		{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
  1493		{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
  1494	
  1495		{ SYS_DESC(SYS_TFSR_EL1), undef_access },
  1496		{ SYS_DESC(SYS_TFSRE0_EL1), undef_access },
  1497	
  1498		{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
  1499		{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
  1500	
  1501		{ PMU_SYS_REG(SYS_PMINTENSET_EL1),
  1502		  .access = access_pminten, .reg = PMINTENSET_EL1 },
  1503		{ PMU_SYS_REG(SYS_PMINTENCLR_EL1),
  1504		  .access = access_pminten, .reg = PMINTENSET_EL1 },
  1505	
  1506		{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
  1507		{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
  1508	
  1509		{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
  1510		{ SYS_DESC(SYS_LOREA_EL1), trap_loregion },
  1511		{ SYS_DESC(SYS_LORN_EL1), trap_loregion },
  1512		{ SYS_DESC(SYS_LORC_EL1), trap_loregion },
  1513		{ SYS_DESC(SYS_LORID_EL1), trap_loregion },
  1514	
  1515		{ SYS_DESC(SYS_VBAR_EL1), NULL, reset_val, VBAR_EL1, 0 },
  1516		{ SYS_DESC(SYS_DISR_EL1), NULL, reset_val, DISR_EL1, 0 },
  1517	
  1518		{ SYS_DESC(SYS_ICC_IAR0_EL1), write_to_read_only },
  1519		{ SYS_DESC(SYS_ICC_EOIR0_EL1), read_from_write_only },
  1520		{ SYS_DESC(SYS_ICC_HPPIR0_EL1), write_to_read_only },
  1521		{ SYS_DESC(SYS_ICC_DIR_EL1), read_from_write_only },
  1522		{ SYS_DESC(SYS_ICC_RPR_EL1), write_to_read_only },
  1523		{ SYS_DESC(SYS_ICC_SGI1R_EL1), access_gic_sgi },
  1524		{ SYS_DESC(SYS_ICC_ASGI1R_EL1), access_gic_sgi },
  1525		{ SYS_DESC(SYS_ICC_SGI0R_EL1), access_gic_sgi },
  1526		{ SYS_DESC(SYS_ICC_IAR1_EL1), write_to_read_only },
  1527		{ SYS_DESC(SYS_ICC_EOIR1_EL1), read_from_write_only },
  1528		{ SYS_DESC(SYS_ICC_HPPIR1_EL1), write_to_read_only },
  1529		{ SYS_DESC(SYS_ICC_SRE_EL1), access_gic_sre },
  1530	
  1531		{ SYS_DESC(SYS_CONTEXTIDR_EL1), access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
  1532		{ SYS_DESC(SYS_TPIDR_EL1), NULL, reset_unknown, TPIDR_EL1 },
  1533	
  1534		{ SYS_DESC(SYS_SCXTNUM_EL1), undef_access },
  1535	
  1536		{ SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
  1537	
  1538		{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
  1539		{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
  1540		{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
  1541		{ SYS_DESC(SYS_CTR_EL0), access_ctr },
  1542	
  1543		{ PMU_SYS_REG(SYS_PMCR_EL0), .access = access_pmcr,
> 1544		  .reset = reset_pmcr, .reg = PMCR_EL0 },
  1545		{ PMU_SYS_REG(SYS_PMCNTENSET_EL0),
  1546		  .access = access_pmcnten, .reg = PMCNTENSET_EL0 },
  1547		{ PMU_SYS_REG(SYS_PMCNTENCLR_EL0),
  1548		  .access = access_pmcnten, .reg = PMCNTENSET_EL0 },
  1549		{ PMU_SYS_REG(SYS_PMOVSCLR_EL0),
  1550		  .access = access_pmovs, .reg = PMOVSSET_EL0 },
  1551		{ PMU_SYS_REG(SYS_PMSWINC_EL0),
  1552		  .access = access_pmswinc, .reg = PMSWINC_EL0 },
  1553		{ PMU_SYS_REG(SYS_PMSELR_EL0),
  1554		  .access = access_pmselr, .reg = PMSELR_EL0 },
  1555		{ PMU_SYS_REG(SYS_PMCEID0_EL0),
  1556		  .access = access_pmceid, .reset = NULL },
  1557		{ PMU_SYS_REG(SYS_PMCEID1_EL0),
  1558		  .access = access_pmceid, .reset = NULL },
  1559		{ PMU_SYS_REG(SYS_PMCCNTR_EL0),
  1560		  .access = access_pmu_evcntr, .reg = PMCCNTR_EL0 },
  1561		{ PMU_SYS_REG(SYS_PMXEVTYPER_EL0),
  1562		  .access = access_pmu_evtyper, .reset = NULL },
  1563		{ PMU_SYS_REG(SYS_PMXEVCNTR_EL0),
  1564		  .access = access_pmu_evcntr, .reset = NULL },
  1565		/*
  1566		 * PMUSERENR_EL0 resets as unknown in 64bit mode while it resets as zero
  1567		 * in 32bit mode. Here we choose to reset it as zero for consistency.
  1568		 */
  1569		{ PMU_SYS_REG(SYS_PMUSERENR_EL0), .access = access_pmuserenr,
  1570		  .reset = reset_val, .reg = PMUSERENR_EL0, .val = 0 },
  1571		{ PMU_SYS_REG(SYS_PMOVSSET_EL0),
  1572		  .access = access_pmovs, .reg = PMOVSSET_EL0 },
  1573	
  1574		{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
  1575		{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
  1576	
  1577		{ SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
  1578	
  1579		{ SYS_DESC(SYS_AMCR_EL0), undef_access },
  1580		{ SYS_DESC(SYS_AMCFGR_EL0), undef_access },
  1581		{ SYS_DESC(SYS_AMCGCR_EL0), undef_access },
  1582		{ SYS_DESC(SYS_AMUSERENR_EL0), undef_access },
  1583		{ SYS_DESC(SYS_AMCNTENCLR0_EL0), undef_access },
  1584		{ SYS_DESC(SYS_AMCNTENSET0_EL0), undef_access },
  1585		{ SYS_DESC(SYS_AMCNTENCLR1_EL0), undef_access },
  1586		{ SYS_DESC(SYS_AMCNTENSET1_EL0), undef_access },
  1587		AMU_AMEVCNTR0_EL0(0),
  1588		AMU_AMEVCNTR0_EL0(1),
  1589		AMU_AMEVCNTR0_EL0(2),
  1590		AMU_AMEVCNTR0_EL0(3),
  1591		AMU_AMEVCNTR0_EL0(4),
  1592		AMU_AMEVCNTR0_EL0(5),
  1593		AMU_AMEVCNTR0_EL0(6),
  1594		AMU_AMEVCNTR0_EL0(7),
  1595		AMU_AMEVCNTR0_EL0(8),
  1596		AMU_AMEVCNTR0_EL0(9),
  1597		AMU_AMEVCNTR0_EL0(10),
  1598		AMU_AMEVCNTR0_EL0(11),
  1599		AMU_AMEVCNTR0_EL0(12),
  1600		AMU_AMEVCNTR0_EL0(13),
  1601		AMU_AMEVCNTR0_EL0(14),
  1602		AMU_AMEVCNTR0_EL0(15),
  1603		AMU_AMEVTYPER0_EL0(0),
  1604		AMU_AMEVTYPER0_EL0(1),
  1605		AMU_AMEVTYPER0_EL0(2),
  1606		AMU_AMEVTYPER0_EL0(3),
  1607		AMU_AMEVTYPER0_EL0(4),
  1608		AMU_AMEVTYPER0_EL0(5),
  1609		AMU_AMEVTYPER0_EL0(6),
  1610		AMU_AMEVTYPER0_EL0(7),
  1611		AMU_AMEVTYPER0_EL0(8),
  1612		AMU_AMEVTYPER0_EL0(9),
  1613		AMU_AMEVTYPER0_EL0(10),
  1614		AMU_AMEVTYPER0_EL0(11),
  1615		AMU_AMEVTYPER0_EL0(12),
  1616		AMU_AMEVTYPER0_EL0(13),
  1617		AMU_AMEVTYPER0_EL0(14),
  1618		AMU_AMEVTYPER0_EL0(15),
  1619		AMU_AMEVCNTR1_EL0(0),
  1620		AMU_AMEVCNTR1_EL0(1),
  1621		AMU_AMEVCNTR1_EL0(2),
  1622		AMU_AMEVCNTR1_EL0(3),
  1623		AMU_AMEVCNTR1_EL0(4),
  1624		AMU_AMEVCNTR1_EL0(5),
  1625		AMU_AMEVCNTR1_EL0(6),
  1626		AMU_AMEVCNTR1_EL0(7),
  1627		AMU_AMEVCNTR1_EL0(8),
  1628		AMU_AMEVCNTR1_EL0(9),
  1629		AMU_AMEVCNTR1_EL0(10),
  1630		AMU_AMEVCNTR1_EL0(11),
  1631		AMU_AMEVCNTR1_EL0(12),
  1632		AMU_AMEVCNTR1_EL0(13),
  1633		AMU_AMEVCNTR1_EL0(14),
  1634		AMU_AMEVCNTR1_EL0(15),
  1635		AMU_AMEVTYPER1_EL0(0),
  1636		AMU_AMEVTYPER1_EL0(1),
  1637		AMU_AMEVTYPER1_EL0(2),
  1638		AMU_AMEVTYPER1_EL0(3),
  1639		AMU_AMEVTYPER1_EL0(4),
  1640		AMU_AMEVTYPER1_EL0(5),
  1641		AMU_AMEVTYPER1_EL0(6),
  1642		AMU_AMEVTYPER1_EL0(7),
  1643		AMU_AMEVTYPER1_EL0(8),
  1644		AMU_AMEVTYPER1_EL0(9),
  1645		AMU_AMEVTYPER1_EL0(10),
  1646		AMU_AMEVTYPER1_EL0(11),
  1647		AMU_AMEVTYPER1_EL0(12),
  1648		AMU_AMEVTYPER1_EL0(13),
  1649		AMU_AMEVTYPER1_EL0(14),
  1650		AMU_AMEVTYPER1_EL0(15),
  1651	
  1652		{ SYS_DESC(SYS_CNTP_TVAL_EL0), access_arch_timer },
  1653		{ SYS_DESC(SYS_CNTP_CTL_EL0), access_arch_timer },
  1654		{ SYS_DESC(SYS_CNTP_CVAL_EL0), access_arch_timer },
  1655	
  1656		/* PMEVCNTRn_EL0 */
  1657		PMU_PMEVCNTR_EL0(0),
  1658		PMU_PMEVCNTR_EL0(1),
  1659		PMU_PMEVCNTR_EL0(2),
  1660		PMU_PMEVCNTR_EL0(3),
  1661		PMU_PMEVCNTR_EL0(4),
  1662		PMU_PMEVCNTR_EL0(5),
  1663		PMU_PMEVCNTR_EL0(6),
  1664		PMU_PMEVCNTR_EL0(7),
  1665		PMU_PMEVCNTR_EL0(8),
  1666		PMU_PMEVCNTR_EL0(9),
  1667		PMU_PMEVCNTR_EL0(10),
  1668		PMU_PMEVCNTR_EL0(11),
  1669		PMU_PMEVCNTR_EL0(12),
  1670		PMU_PMEVCNTR_EL0(13),
  1671		PMU_PMEVCNTR_EL0(14),
  1672		PMU_PMEVCNTR_EL0(15),
  1673		PMU_PMEVCNTR_EL0(16),
  1674		PMU_PMEVCNTR_EL0(17),
  1675		PMU_PMEVCNTR_EL0(18),
  1676		PMU_PMEVCNTR_EL0(19),
  1677		PMU_PMEVCNTR_EL0(20),
  1678		PMU_PMEVCNTR_EL0(21),
  1679		PMU_PMEVCNTR_EL0(22),
  1680		PMU_PMEVCNTR_EL0(23),
  1681		PMU_PMEVCNTR_EL0(24),
  1682		PMU_PMEVCNTR_EL0(25),
  1683		PMU_PMEVCNTR_EL0(26),
  1684		PMU_PMEVCNTR_EL0(27),
  1685		PMU_PMEVCNTR_EL0(28),
  1686		PMU_PMEVCNTR_EL0(29),
  1687		PMU_PMEVCNTR_EL0(30),
  1688		/* PMEVTYPERn_EL0 */
  1689		PMU_PMEVTYPER_EL0(0),
  1690		PMU_PMEVTYPER_EL0(1),
  1691		PMU_PMEVTYPER_EL0(2),
  1692		PMU_PMEVTYPER_EL0(3),
  1693		PMU_PMEVTYPER_EL0(4),
  1694		PMU_PMEVTYPER_EL0(5),
  1695		PMU_PMEVTYPER_EL0(6),
  1696		PMU_PMEVTYPER_EL0(7),
  1697		PMU_PMEVTYPER_EL0(8),
  1698		PMU_PMEVTYPER_EL0(9),
  1699		PMU_PMEVTYPER_EL0(10),
  1700		PMU_PMEVTYPER_EL0(11),
  1701		PMU_PMEVTYPER_EL0(12),
  1702		PMU_PMEVTYPER_EL0(13),
  1703		PMU_PMEVTYPER_EL0(14),
  1704		PMU_PMEVTYPER_EL0(15),
  1705		PMU_PMEVTYPER_EL0(16),
  1706		PMU_PMEVTYPER_EL0(17),
  1707		PMU_PMEVTYPER_EL0(18),
  1708		PMU_PMEVTYPER_EL0(19),
  1709		PMU_PMEVTYPER_EL0(20),
  1710		PMU_PMEVTYPER_EL0(21),
  1711		PMU_PMEVTYPER_EL0(22),
  1712		PMU_PMEVTYPER_EL0(23),
  1713		PMU_PMEVTYPER_EL0(24),
  1714		PMU_PMEVTYPER_EL0(25),
  1715		PMU_PMEVTYPER_EL0(26),
  1716		PMU_PMEVTYPER_EL0(27),
  1717		PMU_PMEVTYPER_EL0(28),
  1718		PMU_PMEVTYPER_EL0(29),
  1719		PMU_PMEVTYPER_EL0(30),
  1720		/*
  1721		 * PMCCFILTR_EL0 resets as unknown in 64bit mode while it resets as zero
  1722		 * in 32bit mode. Here we choose to reset it as zero for consistency.
  1723		 */
  1724		{ PMU_SYS_REG(SYS_PMCCFILTR_EL0), .access = access_pmu_evtyper,
  1725		  .reset = reset_val, .reg = PMCCFILTR_EL0, .val = 0 },
  1726	
  1727		{ SYS_DESC(SYS_DACR32_EL2), NULL, reset_unknown, DACR32_EL2 },
  1728		{ SYS_DESC(SYS_IFSR32_EL2), NULL, reset_unknown, IFSR32_EL2 },
  1729		{ SYS_DESC(SYS_FPEXC32_EL2), NULL, reset_val, FPEXC32_EL2, 0x700 },
  1730	};
  1731	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EeQfGwPcQSOJBaQU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
By/IIib6bQIA

--EeQfGwPcQSOJBaQU--
