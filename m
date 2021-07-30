Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFF3DB2F3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 07:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhG3Fn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 01:43:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:23823 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230162AbhG3Fn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:43:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="211154452"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="gz'50?scan'50,208,50";a="211154452"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 22:43:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="gz'50?scan'50,208,50";a="664697157"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2021 22:43:19 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9LIl-0009eW-AY; Fri, 30 Jul 2021 05:43:19 +0000
Date:   Fri, 30 Jul 2021 13:43:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [linux-stable-rc:linux-4.4.y 573/615]
 drivers/ata/sata_dwc_460ex.c:1158:14: warning: initialization of 'enum
 ata_completion_errors (*)(struct ata_queued_cmd *)' from incompatible
 pointer type 'void (*)(struct ata_queued_cmd *)'
Message-ID: <202107301301.lZzUGJoI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
head:   36437aaa551298340a942cd706837e40efdae9c3
commit: 6002dcd35aa356a3ea79d106f94733e7a298f040 [573/615] ata: make qc_prep return ata_completion_errors
config: powerpc64-randconfig-r023-20210730 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=6002dcd35aa356a3ea79d106f94733e7a298f040
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.4.y
        git checkout 6002dcd35aa356a3ea79d106f94733e7a298f040
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/scatterlist.h:7,
                    from include/linux/dma-mapping.h:10,
                    from include/linux/libata.h:32,
                    from drivers/ata/sata_dwc_460ex.c:37:
   include/linux/mm.h: In function 'is_vmalloc_addr':
   include/linux/mm.h:386:14: warning: comparison of integer expressions of different signedness: 'long unsigned int' and 'long int' [-Wsign-compare]
     386 |  return addr >= VMALLOC_START && addr < VMALLOC_END;
         |              ^~
   In file included from include/linux/libata.h:35,
                    from drivers/ata/sata_dwc_460ex.c:37:
   include/linux/ata.h: In function 'ata_id_is_lba_capacity_ok':
   include/linux/ata.h:950:17: warning: comparison of integer expressions of different signedness: 'long unsigned int' and 'int' [-Wsign-compare]
     950 |      (lba_sects >= 16383 * 63 * id[ATA_ID_HEADS]))
         |                 ^~
   In file included from include/linux/blkdev.h:14,
                    from include/linux/blk-mq.h:4,
                    from include/scsi/scsi_host.h:10,
                    from include/linux/libata.h:37,
                    from drivers/ata/sata_dwc_460ex.c:37:
   include/linux/pagemap.h: In function 'fault_in_multipages_readable':
   include/linux/pagemap.h:632:16: warning: variable 'c' set but not used [-Wunused-but-set-variable]
     632 |  volatile char c;
         |                ^
   In file included from include/linux/blkdev.h:18,
                    from include/linux/blk-mq.h:4,
                    from include/scsi/scsi_host.h:10,
                    from include/linux/libata.h:37,
                    from drivers/ata/sata_dwc_460ex.c:37:
   include/linux/bio.h: In function 'bio_next_split':
   include/linux/bio.h:424:14: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
     424 |  if (sectors >= bio_sectors(bio))
         |              ^~
   In file included from drivers/ata/sata_dwc_460ex.c:37:
   include/linux/libata.h: In function 'ata_msg_init':
   include/linux/libata.h:113:23: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
     113 |  if (dval < 0 || dval >= (sizeof(u32) * 8))
         |                       ^~
   drivers/ata/sata_dwc_460ex.c: In function 'dma_dwc_xfer_setup':
   drivers/ata/sata_dwc_460ex.c:308:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     308 |  dma_addr_t addr = (dma_addr_t)&hsdev->sata_dwc_regs->dmadr;
         |                    ^
   drivers/ata/sata_dwc_460ex.c: At top level:
>> drivers/ata/sata_dwc_460ex.c:1158:14: warning: initialization of 'enum ata_completion_errors (*)(struct ata_queued_cmd *)' from incompatible pointer type 'void (*)(struct ata_queued_cmd *)' [-Wincompatible-pointer-types]
    1158 |  .qc_prep  = sata_dwc_qc_prep,
         |              ^~~~~~~~~~~~~~~~
   drivers/ata/sata_dwc_460ex.c:1158:14: note: (near initialization for 'sata_dwc_ops.qc_prep')


vim +1158 drivers/ata/sata_dwc_460ex.c

62936009f35a66 Rupjyoti Sarmah 2010-07-06  1151  
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1152  static struct ata_port_operations sata_dwc_ops = {
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1153  	.inherits		= &ata_sff_port_ops,
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1154  
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1155  	.error_handler		= sata_dwc_error_handler,
3a8b788f61a5b8 Thang Q. Nguyen 2012-04-17  1156  	.hardreset		= sata_dwc_hardreset,
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1157  
62936009f35a66 Rupjyoti Sarmah 2010-07-06 @1158  	.qc_prep		= sata_dwc_qc_prep,
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1159  	.qc_issue		= sata_dwc_qc_issue,
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1160  
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1161  	.scr_read		= sata_dwc_scr_read,
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1162  	.scr_write		= sata_dwc_scr_write,
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1163  
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1164  	.port_start		= sata_dwc_port_start,
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1165  	.port_stop		= sata_dwc_port_stop,
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1166  
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1167  	.bmdma_setup		= sata_dwc_bmdma_setup,
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1168  	.bmdma_start		= sata_dwc_bmdma_start,
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1169  };
62936009f35a66 Rupjyoti Sarmah 2010-07-06  1170  

:::::: The code at line 1158 was first introduced by commit
:::::: 62936009f35a6659cc3ebe0d90c754182d60da73 [libata] Add 460EX on-chip SATA driver, sata_dwc_460ex

:::::: TO: Rupjyoti Sarmah <rsarmah@amcc.com>
:::::: CC: Jeff Garzik <jgarzik@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--pWyiEgJYm5f9v55/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--pWyiEgJYm5f9v55/--
