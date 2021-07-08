Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A61D3C1A93
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 22:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhGHUhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 16:37:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:51126 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhGHUhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 16:37:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="189272575"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="gz'50?scan'50,208,50";a="189272575"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 13:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="gz'50?scan'50,208,50";a="424102645"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jul 2021 13:34:48 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1ajP-000ETg-IL; Thu, 08 Jul 2021 20:34:47 +0000
Date:   Fri, 9 Jul 2021 04:34:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202107090450.NhdvALtA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e9f1cbc0c4114880090c7a578117d3b9cf184ad4
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   11 months ago
config: alpha-randconfig-s031-20210705 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/scsi/mvumi.c:81:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/scsi/mvumi.c:81:52: sparse:     expected void [noderef] __iomem *
   drivers/scsi/mvumi.c:81:52: sparse:     got void *
   drivers/scsi/mvumi.c:90:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/scsi/mvumi.c:90:39: sparse:     expected void *
   drivers/scsi/mvumi.c:90:39: sparse:     got void [noderef] __iomem *
   drivers/scsi/mvumi.c:210:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:210:34: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:210:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:211:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:211:34: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:211:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:213:17: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:213:17: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:213:17: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:213:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:213:17: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:213:17: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:242:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:242:26: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:242:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:243:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:243:26: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:243:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:245:9: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:245:9: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:245:9: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:245:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:245:9: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:245:9: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *inb_read_pointer @@
   drivers/scsi/mvumi.c:407:40: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:407:40: sparse:     got void *inb_read_pointer
>> drivers/scsi/mvumi.c:429:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:429:30: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:429:30: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:458:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:458:31: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:458:31: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:459:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *inb_write_pointer @@
   drivers/scsi/mvumi.c:459:48: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:459:48: sparse:     got void *inb_write_pointer
>> drivers/scsi/mvumi.c:496:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:496:41: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:496:41: sparse:     got void *outb_copy_pointer
>> drivers/scsi/mvumi.c:497:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *ob_shadow @@
   drivers/scsi/mvumi.c:497:48: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:497:48: sparse:     got void *ob_shadow
>> drivers/scsi/mvumi.c:516:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:516:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:516:33: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:517:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:517:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:517:33: sparse:     got void *outb_copy_pointer
   drivers/scsi/mvumi.c:578:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:578:42: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:578:42: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:585:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:585:26: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:585:26: sparse:     got void *enpointa_mask_reg
>> drivers/scsi/mvumi.c:586:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:586:26: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:586:26: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:589:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:589:40: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:589:40: sparse:     got void *pciea_to_arm_drbl_reg
>> drivers/scsi/mvumi.c:1281:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1281:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1281:28: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1282:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1282:28: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1282:28: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1284:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1284:48: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1284:48: sparse:     got void *arm_to_pciea_mask_reg
>> drivers/scsi/mvumi.c:1285:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1285:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1285:28: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1286:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1286:28: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1286:28: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:612:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:612:26: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:612:26: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:613:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:613:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:613:28: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:615:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:615:46: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:615:46: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:624:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:624:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:624:36: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:670:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:670:32: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:670:32: sparse:     got void *reset_enable
   drivers/scsi/mvumi.c:671:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_request @@
   drivers/scsi/mvumi.c:671:34: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:671:34: sparse:     got void *reset_request
   drivers/scsi/mvumi.c:673:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:673:35: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:673:35: sparse:     got void *reset_enable
   drivers/scsi/mvumi.c:674:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_request @@
   drivers/scsi/mvumi.c:674:35: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:674:35: sparse:     got void *reset_request
>> drivers/scsi/mvumi.c:1100:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg0 @@
   drivers/scsi/mvumi.c:1100:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1100:36: sparse:     got void *arm_to_pciea_msg0
   drivers/scsi/mvumi.c:1115:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg1 @@
   drivers/scsi/mvumi.c:1115:52: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1115:52: sparse:     got void *pciea_to_arm_msg1
   drivers/scsi/mvumi.c:1116:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1116:39: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1116:39: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1117:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1117:47: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1117:47: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1122:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg1 @@
   drivers/scsi/mvumi.c:1122:45: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1122:45: sparse:     got void *pciea_to_arm_msg1
   drivers/scsi/mvumi.c:1124:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1124:45: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1124:45: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1127:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1127:39: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1127:39: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1128:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1128:47: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1128:47: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1168:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1168:39: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1168:39: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1169:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1169:47: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1169:47: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1174:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1174:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1174:36: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1176:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1176:36: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1176:36: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1177:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:1177:50: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1177:50: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:1180:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *inb_aval_count_basel @@
   drivers/scsi/mvumi.c:1180:45: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1180:45: sparse:     got void *inb_aval_count_basel
   drivers/scsi/mvumi.c:1182:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *inb_aval_count_baseh @@
   drivers/scsi/mvumi.c:1182:45: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1182:45: sparse:     got void *inb_aval_count_baseh
   drivers/scsi/mvumi.c:1188:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *ob_shadow @@
   drivers/scsi/mvumi.c:1188:61: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1188:61: sparse:     got void *ob_shadow
   drivers/scsi/mvumi.c:1190:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_copy_basel @@
   drivers/scsi/mvumi.c:1190:61: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1190:61: sparse:     got void *outb_copy_basel
   drivers/scsi/mvumi.c:1192:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_copy_baseh @@
   drivers/scsi/mvumi.c:1192:61: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1192:61: sparse:     got void *outb_copy_baseh
   drivers/scsi/mvumi.c:1244:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1244:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1244:34: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1248:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1248:51: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1248:51: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1256:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1256:42: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1256:42: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1849:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_low_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:1849:35: sparse:     expected unsigned int [usertype] src_low_addr
   drivers/scsi/mvumi.c:1849:35: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:1851:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_high_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:1851:36: sparse:     expected unsigned int [usertype] src_high_addr
   drivers/scsi/mvumi.c:1851:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:1903:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1903:48: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1903:48: sparse:     got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1904:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1904:29: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1904:29: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1906:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1906:29: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1906:29: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1918:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1918:26: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1918:26: sparse:     got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1919:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1919:29: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1919:29: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1922:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1922:29: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1922:29: sparse:     got void *enpointa_mask_reg
>> drivers/scsi/mvumi.c:1931:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *main_int_cause_reg @@
   drivers/scsi/mvumi.c:1931:31: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1931:31: sparse:     got void *main_int_cause_reg
>> drivers/scsi/mvumi.c:1935:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1935:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1935:36: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1939:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1939:61: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1939:61: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1945:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1945:53: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1945:53: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1951:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1951:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1951:36: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1953:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1953:61: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1953:61: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1956:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1956:43: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1956:43: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1958:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1958:51: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1958:51: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1975:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1975:37: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1975:37: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1977:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1977:45: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1977:45: sparse:     got void *arm_to_pciea_drbl_reg

vim +407 drivers/scsi/mvumi.c

f0c568a478f035 Jianyun Li 2011-05-11  401  
bd756ddea18e02 Shun Fu    2012-09-23  402  static unsigned int mvumi_check_ib_list_9143(struct mvumi_hba *mhba)
f0c568a478f035 Jianyun Li 2011-05-11  403  {
bd756ddea18e02 Shun Fu    2012-09-23  404  	unsigned int ib_rp_reg;
bd756ddea18e02 Shun Fu    2012-09-23  405  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02 Shun Fu    2012-09-23  406  
bd756ddea18e02 Shun Fu    2012-09-23 @407  	ib_rp_reg = ioread32(mhba->regs->inb_read_pointer);
f0c568a478f035 Jianyun Li 2011-05-11  408  
bd756ddea18e02 Shun Fu    2012-09-23  409  	if (unlikely(((ib_rp_reg & regs->cl_slot_num_mask) ==
bd756ddea18e02 Shun Fu    2012-09-23  410  			(mhba->ib_cur_slot & regs->cl_slot_num_mask)) &&
bd756ddea18e02 Shun Fu    2012-09-23  411  			((ib_rp_reg & regs->cl_pointer_toggle)
bd756ddea18e02 Shun Fu    2012-09-23  412  			 != (mhba->ib_cur_slot & regs->cl_pointer_toggle)))) {
bd756ddea18e02 Shun Fu    2012-09-23  413  		dev_warn(&mhba->pdev->dev, "no free slot to use.\n");
bd756ddea18e02 Shun Fu    2012-09-23  414  		return 0;
bd756ddea18e02 Shun Fu    2012-09-23  415  	}
f0c568a478f035 Jianyun Li 2011-05-11  416  	if (atomic_read(&mhba->fw_outstanding) >= mhba->max_io) {
f0c568a478f035 Jianyun Li 2011-05-11  417  		dev_warn(&mhba->pdev->dev, "firmware io overflow.\n");
bd756ddea18e02 Shun Fu    2012-09-23  418  		return 0;
bd756ddea18e02 Shun Fu    2012-09-23  419  	} else {
bd756ddea18e02 Shun Fu    2012-09-23  420  		return mhba->max_io - atomic_read(&mhba->fw_outstanding);
bd756ddea18e02 Shun Fu    2012-09-23  421  	}
f0c568a478f035 Jianyun Li 2011-05-11  422  }
f0c568a478f035 Jianyun Li 2011-05-11  423  
bd756ddea18e02 Shun Fu    2012-09-23  424  static unsigned int mvumi_check_ib_list_9580(struct mvumi_hba *mhba)
bd756ddea18e02 Shun Fu    2012-09-23  425  {
bd756ddea18e02 Shun Fu    2012-09-23  426  	unsigned int count;
bd756ddea18e02 Shun Fu    2012-09-23  427  	if (atomic_read(&mhba->fw_outstanding) >= (mhba->max_io - 1))
bd756ddea18e02 Shun Fu    2012-09-23  428  		return 0;
bd756ddea18e02 Shun Fu    2012-09-23 @429  	count = ioread32(mhba->ib_shadow);
bd756ddea18e02 Shun Fu    2012-09-23  430  	if (count == 0xffff)
bd756ddea18e02 Shun Fu    2012-09-23  431  		return 0;
bd756ddea18e02 Shun Fu    2012-09-23  432  	return count;
f0c568a478f035 Jianyun Li 2011-05-11  433  }
f0c568a478f035 Jianyun Li 2011-05-11  434  
bd756ddea18e02 Shun Fu    2012-09-23  435  static void mvumi_get_ib_list_entry(struct mvumi_hba *mhba, void **ib_entry)
bd756ddea18e02 Shun Fu    2012-09-23  436  {
bd756ddea18e02 Shun Fu    2012-09-23  437  	unsigned int cur_ib_entry;
bd756ddea18e02 Shun Fu    2012-09-23  438  
bd756ddea18e02 Shun Fu    2012-09-23  439  	cur_ib_entry = mhba->ib_cur_slot & mhba->regs->cl_slot_num_mask;
f0c568a478f035 Jianyun Li 2011-05-11  440  	cur_ib_entry++;
f0c568a478f035 Jianyun Li 2011-05-11  441  	if (cur_ib_entry >= mhba->list_num_io) {
f0c568a478f035 Jianyun Li 2011-05-11  442  		cur_ib_entry -= mhba->list_num_io;
bd756ddea18e02 Shun Fu    2012-09-23  443  		mhba->ib_cur_slot ^= mhba->regs->cl_pointer_toggle;
f0c568a478f035 Jianyun Li 2011-05-11  444  	}
bd756ddea18e02 Shun Fu    2012-09-23  445  	mhba->ib_cur_slot &= ~mhba->regs->cl_slot_num_mask;
bd756ddea18e02 Shun Fu    2012-09-23  446  	mhba->ib_cur_slot |= (cur_ib_entry & mhba->regs->cl_slot_num_mask);
bd756ddea18e02 Shun Fu    2012-09-23  447  	if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC) {
bd756ddea18e02 Shun Fu    2012-09-23  448  		*ib_entry = mhba->ib_list + cur_ib_entry *
bd756ddea18e02 Shun Fu    2012-09-23  449  				sizeof(struct mvumi_dyn_list_entry);
bd756ddea18e02 Shun Fu    2012-09-23  450  	} else {
f0c568a478f035 Jianyun Li 2011-05-11  451  		*ib_entry = mhba->ib_list + cur_ib_entry * mhba->ib_max_size;
bd756ddea18e02 Shun Fu    2012-09-23  452  	}
f0c568a478f035 Jianyun Li 2011-05-11  453  	atomic_inc(&mhba->fw_outstanding);
f0c568a478f035 Jianyun Li 2011-05-11  454  }
f0c568a478f035 Jianyun Li 2011-05-11  455  
f0c568a478f035 Jianyun Li 2011-05-11  456  static void mvumi_send_ib_list_entry(struct mvumi_hba *mhba)
f0c568a478f035 Jianyun Li 2011-05-11  457  {
bd756ddea18e02 Shun Fu    2012-09-23  458  	iowrite32(0xffff, mhba->ib_shadow);
bd756ddea18e02 Shun Fu    2012-09-23  459  	iowrite32(mhba->ib_cur_slot, mhba->regs->inb_write_pointer);
f0c568a478f035 Jianyun Li 2011-05-11  460  }
f0c568a478f035 Jianyun Li 2011-05-11  461  
f0c568a478f035 Jianyun Li 2011-05-11  462  static char mvumi_check_ob_frame(struct mvumi_hba *mhba,
f0c568a478f035 Jianyun Li 2011-05-11  463  		unsigned int cur_obf, struct mvumi_rsp_frame *p_outb_frame)
f0c568a478f035 Jianyun Li 2011-05-11  464  {
f0c568a478f035 Jianyun Li 2011-05-11  465  	unsigned short tag, request_id;
f0c568a478f035 Jianyun Li 2011-05-11  466  
f0c568a478f035 Jianyun Li 2011-05-11  467  	udelay(1);
f0c568a478f035 Jianyun Li 2011-05-11  468  	p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
f0c568a478f035 Jianyun Li 2011-05-11  469  	request_id = p_outb_frame->request_id;
f0c568a478f035 Jianyun Li 2011-05-11  470  	tag = p_outb_frame->tag;
f0c568a478f035 Jianyun Li 2011-05-11  471  	if (tag > mhba->tag_pool.size) {
f0c568a478f035 Jianyun Li 2011-05-11  472  		dev_err(&mhba->pdev->dev, "ob frame data error\n");
f0c568a478f035 Jianyun Li 2011-05-11  473  		return -1;
f0c568a478f035 Jianyun Li 2011-05-11  474  	}
f0c568a478f035 Jianyun Li 2011-05-11  475  	if (mhba->tag_cmd[tag] == NULL) {
f0c568a478f035 Jianyun Li 2011-05-11  476  		dev_err(&mhba->pdev->dev, "tag[0x%x] with NO command\n", tag);
f0c568a478f035 Jianyun Li 2011-05-11  477  		return -1;
f0c568a478f035 Jianyun Li 2011-05-11  478  	} else if (mhba->tag_cmd[tag]->request_id != request_id &&
f0c568a478f035 Jianyun Li 2011-05-11  479  						mhba->request_id_enabled) {
f0c568a478f035 Jianyun Li 2011-05-11  480  			dev_err(&mhba->pdev->dev, "request ID from FW:0x%x,"
f0c568a478f035 Jianyun Li 2011-05-11  481  					"cmd request ID:0x%x\n", request_id,
f0c568a478f035 Jianyun Li 2011-05-11  482  					mhba->tag_cmd[tag]->request_id);
f0c568a478f035 Jianyun Li 2011-05-11  483  			return -1;
f0c568a478f035 Jianyun Li 2011-05-11  484  	}
f0c568a478f035 Jianyun Li 2011-05-11  485  
f0c568a478f035 Jianyun Li 2011-05-11  486  	return 0;
f0c568a478f035 Jianyun Li 2011-05-11  487  }
f0c568a478f035 Jianyun Li 2011-05-11  488  
bd756ddea18e02 Shun Fu    2012-09-23  489  static int mvumi_check_ob_list_9143(struct mvumi_hba *mhba,
bd756ddea18e02 Shun Fu    2012-09-23  490  			unsigned int *cur_obf, unsigned int *assign_obf_end)
f0c568a478f035 Jianyun Li 2011-05-11  491  {
bd756ddea18e02 Shun Fu    2012-09-23  492  	unsigned int ob_write, ob_write_shadow;
bd756ddea18e02 Shun Fu    2012-09-23  493  	struct mvumi_hw_regs *regs = mhba->regs;
f0c568a478f035 Jianyun Li 2011-05-11  494  
f0c568a478f035 Jianyun Li 2011-05-11  495  	do {
bd756ddea18e02 Shun Fu    2012-09-23 @496  		ob_write = ioread32(regs->outb_copy_pointer);
bd756ddea18e02 Shun Fu    2012-09-23 @497  		ob_write_shadow = ioread32(mhba->ob_shadow);
bd756ddea18e02 Shun Fu    2012-09-23  498  	} while ((ob_write & regs->cl_slot_num_mask) != ob_write_shadow);
f0c568a478f035 Jianyun Li 2011-05-11  499  
bd756ddea18e02 Shun Fu    2012-09-23  500  	*cur_obf = mhba->ob_cur_slot & mhba->regs->cl_slot_num_mask;
bd756ddea18e02 Shun Fu    2012-09-23  501  	*assign_obf_end = ob_write & mhba->regs->cl_slot_num_mask;
f0c568a478f035 Jianyun Li 2011-05-11  502  
bd756ddea18e02 Shun Fu    2012-09-23  503  	if ((ob_write & regs->cl_pointer_toggle) !=
bd756ddea18e02 Shun Fu    2012-09-23  504  			(mhba->ob_cur_slot & regs->cl_pointer_toggle)) {
bd756ddea18e02 Shun Fu    2012-09-23  505  		*assign_obf_end += mhba->list_num_io;
bd756ddea18e02 Shun Fu    2012-09-23  506  	}
bd756ddea18e02 Shun Fu    2012-09-23  507  	return 0;
f0c568a478f035 Jianyun Li 2011-05-11  508  }
f0c568a478f035 Jianyun Li 2011-05-11  509  
bd756ddea18e02 Shun Fu    2012-09-23  510  static int mvumi_check_ob_list_9580(struct mvumi_hba *mhba,
bd756ddea18e02 Shun Fu    2012-09-23  511  			unsigned int *cur_obf, unsigned int *assign_obf_end)
bd756ddea18e02 Shun Fu    2012-09-23  512  {
bd756ddea18e02 Shun Fu    2012-09-23  513  	unsigned int ob_write;
bd756ddea18e02 Shun Fu    2012-09-23  514  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02 Shun Fu    2012-09-23  515  
bd756ddea18e02 Shun Fu    2012-09-23 @516  	ob_write = ioread32(regs->outb_read_pointer);
bd756ddea18e02 Shun Fu    2012-09-23  517  	ob_write = ioread32(regs->outb_copy_pointer);
bd756ddea18e02 Shun Fu    2012-09-23  518  	*cur_obf = mhba->ob_cur_slot & mhba->regs->cl_slot_num_mask;
bd756ddea18e02 Shun Fu    2012-09-23  519  	*assign_obf_end = ob_write & mhba->regs->cl_slot_num_mask;
bd756ddea18e02 Shun Fu    2012-09-23  520  	if (*assign_obf_end < *cur_obf)
bd756ddea18e02 Shun Fu    2012-09-23  521  		*assign_obf_end += mhba->list_num_io;
bd756ddea18e02 Shun Fu    2012-09-23  522  	else if (*assign_obf_end == *cur_obf)
bd756ddea18e02 Shun Fu    2012-09-23  523  		return -1;
bd756ddea18e02 Shun Fu    2012-09-23  524  	return 0;
bd756ddea18e02 Shun Fu    2012-09-23  525  }
bd756ddea18e02 Shun Fu    2012-09-23  526  
bd756ddea18e02 Shun Fu    2012-09-23  527  static void mvumi_receive_ob_list_entry(struct mvumi_hba *mhba)
bd756ddea18e02 Shun Fu    2012-09-23  528  {
bd756ddea18e02 Shun Fu    2012-09-23  529  	unsigned int cur_obf, assign_obf_end, i;
bd756ddea18e02 Shun Fu    2012-09-23  530  	struct mvumi_ob_data *ob_data;
bd756ddea18e02 Shun Fu    2012-09-23  531  	struct mvumi_rsp_frame *p_outb_frame;
bd756ddea18e02 Shun Fu    2012-09-23  532  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02 Shun Fu    2012-09-23  533  
bd756ddea18e02 Shun Fu    2012-09-23  534  	if (mhba->instancet->check_ob_list(mhba, &cur_obf, &assign_obf_end))
bd756ddea18e02 Shun Fu    2012-09-23  535  		return;
bd756ddea18e02 Shun Fu    2012-09-23  536  
f0c568a478f035 Jianyun Li 2011-05-11  537  	for (i = (assign_obf_end - cur_obf); i != 0; i--) {
f0c568a478f035 Jianyun Li 2011-05-11  538  		cur_obf++;
f0c568a478f035 Jianyun Li 2011-05-11  539  		if (cur_obf >= mhba->list_num_io) {
f0c568a478f035 Jianyun Li 2011-05-11  540  			cur_obf -= mhba->list_num_io;
bd756ddea18e02 Shun Fu    2012-09-23  541  			mhba->ob_cur_slot ^= regs->cl_pointer_toggle;
f0c568a478f035 Jianyun Li 2011-05-11  542  		}
f0c568a478f035 Jianyun Li 2011-05-11  543  
f0c568a478f035 Jianyun Li 2011-05-11  544  		p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
f0c568a478f035 Jianyun Li 2011-05-11  545  
f0c568a478f035 Jianyun Li 2011-05-11  546  		/* Copy pointer may point to entry in outbound list
f0c568a478f035 Jianyun Li 2011-05-11  547  		*  before entry has valid data
f0c568a478f035 Jianyun Li 2011-05-11  548  		*/
f0c568a478f035 Jianyun Li 2011-05-11  549  		if (unlikely(p_outb_frame->tag > mhba->tag_pool.size ||
f0c568a478f035 Jianyun Li 2011-05-11  550  			mhba->tag_cmd[p_outb_frame->tag] == NULL ||
f0c568a478f035 Jianyun Li 2011-05-11  551  			p_outb_frame->request_id !=
f0c568a478f035 Jianyun Li 2011-05-11  552  				mhba->tag_cmd[p_outb_frame->tag]->request_id))
f0c568a478f035 Jianyun Li 2011-05-11  553  			if (mvumi_check_ob_frame(mhba, cur_obf, p_outb_frame))
f0c568a478f035 Jianyun Li 2011-05-11  554  				continue;
f0c568a478f035 Jianyun Li 2011-05-11  555  
f0c568a478f035 Jianyun Li 2011-05-11  556  		if (!list_empty(&mhba->ob_data_list)) {
f0c568a478f035 Jianyun Li 2011-05-11  557  			ob_data = (struct mvumi_ob_data *)
f0c568a478f035 Jianyun Li 2011-05-11  558  				list_first_entry(&mhba->ob_data_list,
f0c568a478f035 Jianyun Li 2011-05-11  559  					struct mvumi_ob_data, list);
f0c568a478f035 Jianyun Li 2011-05-11  560  			list_del_init(&ob_data->list);
f0c568a478f035 Jianyun Li 2011-05-11  561  		} else {
f0c568a478f035 Jianyun Li 2011-05-11  562  			ob_data = NULL;
f0c568a478f035 Jianyun Li 2011-05-11  563  			if (cur_obf == 0) {
f0c568a478f035 Jianyun Li 2011-05-11  564  				cur_obf = mhba->list_num_io - 1;
bd756ddea18e02 Shun Fu    2012-09-23  565  				mhba->ob_cur_slot ^= regs->cl_pointer_toggle;
f0c568a478f035 Jianyun Li 2011-05-11  566  			} else
f0c568a478f035 Jianyun Li 2011-05-11  567  				cur_obf -= 1;
f0c568a478f035 Jianyun Li 2011-05-11  568  			break;
f0c568a478f035 Jianyun Li 2011-05-11  569  		}
f0c568a478f035 Jianyun Li 2011-05-11  570  
f0c568a478f035 Jianyun Li 2011-05-11  571  		memcpy(ob_data->data, p_outb_frame, mhba->ob_max_size);
f0c568a478f035 Jianyun Li 2011-05-11  572  		p_outb_frame->tag = 0xff;
f0c568a478f035 Jianyun Li 2011-05-11  573  
f0c568a478f035 Jianyun Li 2011-05-11  574  		list_add_tail(&ob_data->list, &mhba->free_ob_list);
f0c568a478f035 Jianyun Li 2011-05-11  575  	}
bd756ddea18e02 Shun Fu    2012-09-23  576  	mhba->ob_cur_slot &= ~regs->cl_slot_num_mask;
bd756ddea18e02 Shun Fu    2012-09-23  577  	mhba->ob_cur_slot |= (cur_obf & regs->cl_slot_num_mask);
bd756ddea18e02 Shun Fu    2012-09-23  578  	iowrite32(mhba->ob_cur_slot, regs->outb_read_pointer);
f0c568a478f035 Jianyun Li 2011-05-11  579  }
f0c568a478f035 Jianyun Li 2011-05-11  580  
bd756ddea18e02 Shun Fu    2012-09-23  581  static void mvumi_reset(struct mvumi_hba *mhba)
f0c568a478f035 Jianyun Li 2011-05-11  582  {
bd756ddea18e02 Shun Fu    2012-09-23  583  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02 Shun Fu    2012-09-23  584  
bd756ddea18e02 Shun Fu    2012-09-23  585  	iowrite32(0, regs->enpointa_mask_reg);
bd756ddea18e02 Shun Fu    2012-09-23 @586  	if (ioread32(regs->arm_to_pciea_msg1) != HANDSHAKE_DONESTATE)
f0c568a478f035 Jianyun Li 2011-05-11  587  		return;
f0c568a478f035 Jianyun Li 2011-05-11  588  
bd756ddea18e02 Shun Fu    2012-09-23  589  	iowrite32(DRBL_SOFT_RESET, regs->pciea_to_arm_drbl_reg);
f0c568a478f035 Jianyun Li 2011-05-11  590  }
f0c568a478f035 Jianyun Li 2011-05-11  591  

:::::: The code at line 407 was first introduced by commit
:::::: bd756ddea18e02ccea8b29496b2fe3bd91af8eb7 [SCSI] mvumi: Add support for Marvell SAS/SATA RAID-on-Chip(ROC) 88RC9580

:::::: TO: Shun Fu <fushun@gmail.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EVF5PPMfhYS0aIcm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Mz5PlBBcwm6JMl4n7SPy/wMT0l3TAoACAA==

--EVF5PPMfhYS0aIcm--
