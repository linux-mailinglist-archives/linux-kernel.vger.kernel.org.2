Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838C345E0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 20:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350353AbhKYTNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 14:13:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:23908 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232430AbhKYTLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:11:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="222427415"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="222427415"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 11:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="675337255"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2021 11:07:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqK5z-0006oh-Ob; Thu, 25 Nov 2021 19:07:47 +0000
Date:   Fri, 26 Nov 2021 03:07:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/scsi/qedi/qedi_main.c:1540:13: warning: variable 'page' set
 but not used
Message-ID: <202111260317.6lzepIX6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: 1d987052e32f3554e84a296c4494551bc60f3877 MIPS: BMIPS: Enable PCI Kconfig
date:   2 weeks ago
config: mips-randconfig-c004-20211118 (https://download.01.org/0day-ci/archive/20211126/202111260317.6lzepIX6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c46becf500df2a7fb4b4fce16178a036c344315a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1d987052e32f3554e84a296c4494551bc60f3877
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1d987052e32f3554e84a296c4494551bc60f3877
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/qedi/qedi_main.c:1540:13: warning: variable 'page' set but not used [-Wunused-but-set-variable]
           dma_addr_t page;
                      ^
>> drivers/scsi/qedi/qedi_main.c:2092:10: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
                                 SYSFS_FLAG_FW_SEL_BOOT);
                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/qedi/qedi.h:361:32: note: expanded from macro 'SYSFS_FLAG_FW_SEL_BOOT'
   #define SYSFS_FLAG_FW_SEL_BOOT 2
                                  ^
   drivers/scsi/qedi/qedi_main.c:2259:35: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
                   rc = snprintf(buf, 3, "%hhd\n", SYSFS_FLAG_FW_SEL_BOOT);
                                          ~~~~     ^~~~~~~~~~~~~~~~~~~~~~
                                          %d
   drivers/scsi/qedi/qedi.h:361:32: note: expanded from macro 'SYSFS_FLAG_FW_SEL_BOOT'
   #define SYSFS_FLAG_FW_SEL_BOOT 2
                                  ^
   3 warnings generated.


vim +/page +1540 drivers/scsi/qedi/qedi_main.c

ace7f46ba5fde7 Manish Rangankar 2016-12-01  1534  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1535  static int qedi_alloc_bdq(struct qedi_ctx *qedi)
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1536  {
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1537  	int i;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1538  	struct scsi_bd *pbl;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1539  	u64 *list;
ace7f46ba5fde7 Manish Rangankar 2016-12-01 @1540  	dma_addr_t page;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1541  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1542  	/* Alloc dma memory for BDQ buffers */
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1543  	for (i = 0; i < QEDI_BDQ_NUM; i++) {
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1544  		qedi->bdq[i].buf_addr =
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1545  				dma_alloc_coherent(&qedi->pdev->dev,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1546  						   QEDI_BDQ_BUF_SIZE,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1547  						   &qedi->bdq[i].buf_dma,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1548  						   GFP_KERNEL);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1549  		if (!qedi->bdq[i].buf_addr) {
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1550  			QEDI_ERR(&qedi->dbg_ctx,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1551  				 "Could not allocate BDQ buffer %d.\n", i);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1552  			return -ENOMEM;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1553  		}
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1554  	}
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1555  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1556  	/* Alloc dma memory for BDQ page buffer list */
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1557  	qedi->bdq_pbl_mem_size = QEDI_BDQ_NUM * sizeof(struct scsi_bd);
fa97c51109867c Nilesh Javali    2018-11-21  1558  	qedi->bdq_pbl_mem_size = ALIGN(qedi->bdq_pbl_mem_size, QEDI_PAGE_SIZE);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1559  	qedi->rq_num_entries = qedi->bdq_pbl_mem_size / sizeof(struct scsi_bd);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1560  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1561  	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_CONN, "rq_num_entries = %d.\n",
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1562  		  qedi->rq_num_entries);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1563  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1564  	qedi->bdq_pbl = dma_alloc_coherent(&qedi->pdev->dev,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1565  					   qedi->bdq_pbl_mem_size,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1566  					   &qedi->bdq_pbl_dma, GFP_KERNEL);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1567  	if (!qedi->bdq_pbl) {
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1568  		QEDI_ERR(&qedi->dbg_ctx, "Could not allocate BDQ PBL.\n");
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1569  		return -ENOMEM;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1570  	}
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1571  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1572  	/*
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1573  	 * Populate BDQ PBL with physical and virtual address of individual
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1574  	 * BDQ buffers
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1575  	 */
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1576  	pbl = (struct scsi_bd  *)qedi->bdq_pbl;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1577  	for (i = 0; i < QEDI_BDQ_NUM; i++) {
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1578  		pbl->address.hi =
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1579  				cpu_to_le32(QEDI_U64_HI(qedi->bdq[i].buf_dma));
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1580  		pbl->address.lo =
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1581  				cpu_to_le32(QEDI_U64_LO(qedi->bdq[i].buf_dma));
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1582  		QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_CONN,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1583  			  "pbl [0x%p] pbl->address hi [0x%llx] lo [0x%llx], idx [%d]\n",
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1584  			  pbl, pbl->address.hi, pbl->address.lo, i);
da09091732aecc Tomer Tayar      2017-12-27  1585  		pbl->opaque.iscsi_opaque.reserved_zero[0] = 0;
da09091732aecc Tomer Tayar      2017-12-27  1586  		pbl->opaque.iscsi_opaque.reserved_zero[1] = 0;
da09091732aecc Tomer Tayar      2017-12-27  1587  		pbl->opaque.iscsi_opaque.reserved_zero[2] = 0;
da09091732aecc Tomer Tayar      2017-12-27  1588  		pbl->opaque.iscsi_opaque.opaque = cpu_to_le16(i);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1589  		pbl++;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1590  	}
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1591  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1592  	/* Allocate list of PBL pages */
750afb08ca7131 Luis Chamberlain 2019-01-04  1593  	qedi->bdq_pbl_list = dma_alloc_coherent(&qedi->pdev->dev,
fa97c51109867c Nilesh Javali    2018-11-21  1594  						QEDI_PAGE_SIZE,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1595  						&qedi->bdq_pbl_list_dma,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1596  						GFP_KERNEL);
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1597  	if (!qedi->bdq_pbl_list) {
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1598  		QEDI_ERR(&qedi->dbg_ctx,
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1599  			 "Could not allocate list of PBL pages.\n");
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1600  		return -ENOMEM;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1601  	}
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1602  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1603  	/*
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1604  	 * Now populate PBL list with pages that contain pointers to the
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1605  	 * individual buffers.
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1606  	 */
fa97c51109867c Nilesh Javali    2018-11-21  1607  	qedi->bdq_pbl_list_num_entries = qedi->bdq_pbl_mem_size /
fa97c51109867c Nilesh Javali    2018-11-21  1608  					 QEDI_PAGE_SIZE;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1609  	list = (u64 *)qedi->bdq_pbl_list;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1610  	page = qedi->bdq_pbl_list_dma;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1611  	for (i = 0; i < qedi->bdq_pbl_list_num_entries; i++) {
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1612  		*list = qedi->bdq_pbl_dma;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1613  		list++;
fa97c51109867c Nilesh Javali    2018-11-21  1614  		page += QEDI_PAGE_SIZE;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1615  	}
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1616  
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1617  	return 0;
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1618  }
ace7f46ba5fde7 Manish Rangankar 2016-12-01  1619  

:::::: The code at line 1540 was first introduced by commit
:::::: ace7f46ba5fde7273207c7122b0650ceb72510e0 scsi: qedi: Add QLogic FastLinQ offload iSCSI driver framework.

:::::: TO: Manish Rangankar <manish.rangankar@cavium.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
