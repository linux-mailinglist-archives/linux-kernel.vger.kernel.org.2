Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE193ECAA6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 21:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhHOTXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 15:23:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:54799 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhHOTXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 15:23:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="202919010"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="gz'50?scan'50,208,50";a="202919010"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 12:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="gz'50?scan'50,208,50";a="675236977"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Aug 2021 12:22:43 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mFLiV-000Q1Z-5o; Sun, 15 Aug 2021 19:22:43 +0000
Date:   Mon, 16 Aug 2021 03:22:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202108160328.EWUQtIJz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0aa78d17099b04fd9d36fe338af48ad6fe2d7fca
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   1 year ago
config: alpha-randconfig-s031-20210816 (attached as .config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-348-gf0e6938b-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

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

f0c568a478f0353 Jianyun Li        2011-05-11  222  
f0c568a478f0353 Jianyun Li        2011-05-11  223  static int mvumi_internal_cmd_sgl(struct mvumi_hba *mhba, struct mvumi_cmd *cmd,
f0c568a478f0353 Jianyun Li        2011-05-11  224  							unsigned int size)
f0c568a478f0353 Jianyun Li        2011-05-11  225  {
f0c568a478f0353 Jianyun Li        2011-05-11  226  	struct mvumi_sgl *m_sg;
f0c568a478f0353 Jianyun Li        2011-05-11  227  	void *virt_addr;
f0c568a478f0353 Jianyun Li        2011-05-11  228  	dma_addr_t phy_addr;
f0c568a478f0353 Jianyun Li        2011-05-11  229  
f0c568a478f0353 Jianyun Li        2011-05-11  230  	if (size == 0)
f0c568a478f0353 Jianyun Li        2011-05-11  231  		return 0;
f0c568a478f0353 Jianyun Li        2011-05-11  232  
750afb08ca71310 Luis Chamberlain  2019-01-04  233  	virt_addr = dma_alloc_coherent(&mhba->pdev->dev, size, &phy_addr,
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  234  				       GFP_KERNEL);
f0c568a478f0353 Jianyun Li        2011-05-11  235  	if (!virt_addr)
f0c568a478f0353 Jianyun Li        2011-05-11  236  		return -1;
f0c568a478f0353 Jianyun Li        2011-05-11  237  
f0c568a478f0353 Jianyun Li        2011-05-11  238  	m_sg = (struct mvumi_sgl *) &cmd->frame->payload[0];
f0c568a478f0353 Jianyun Li        2011-05-11  239  	cmd->frame->sg_counts = 1;
f0c568a478f0353 Jianyun Li        2011-05-11  240  	cmd->data_buf = virt_addr;
f0c568a478f0353 Jianyun Li        2011-05-11  241  
f0c568a478f0353 Jianyun Li        2011-05-11  242  	m_sg->baseaddr_l = cpu_to_le32(lower_32_bits(phy_addr));
f0c568a478f0353 Jianyun Li        2011-05-11 @243  	m_sg->baseaddr_h = cpu_to_le32(upper_32_bits(phy_addr));
bd756ddea18e02c Shun Fu           2012-09-23  244  	m_sg->flags = 1U << mhba->eot_flag;
bd756ddea18e02c Shun Fu           2012-09-23 @245  	sgd_setsz(mhba, m_sg, cpu_to_le32(size));
f0c568a478f0353 Jianyun Li        2011-05-11  246  
f0c568a478f0353 Jianyun Li        2011-05-11  247  	return 0;
f0c568a478f0353 Jianyun Li        2011-05-11  248  }
f0c568a478f0353 Jianyun Li        2011-05-11  249  
f0c568a478f0353 Jianyun Li        2011-05-11  250  static struct mvumi_cmd *mvumi_create_internal_cmd(struct mvumi_hba *mhba,
f0c568a478f0353 Jianyun Li        2011-05-11  251  				unsigned int buf_size)
f0c568a478f0353 Jianyun Li        2011-05-11  252  {
f0c568a478f0353 Jianyun Li        2011-05-11  253  	struct mvumi_cmd *cmd;
f0c568a478f0353 Jianyun Li        2011-05-11  254  
f0c568a478f0353 Jianyun Li        2011-05-11  255  	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
f0c568a478f0353 Jianyun Li        2011-05-11  256  	if (!cmd) {
f0c568a478f0353 Jianyun Li        2011-05-11  257  		dev_err(&mhba->pdev->dev, "failed to create a internal cmd\n");
f0c568a478f0353 Jianyun Li        2011-05-11  258  		return NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  259  	}
f0c568a478f0353 Jianyun Li        2011-05-11  260  	INIT_LIST_HEAD(&cmd->queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  261  
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  262  	cmd->frame = dma_alloc_coherent(&mhba->pdev->dev, mhba->ib_max_size,
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  263  			&cmd->frame_phys, GFP_KERNEL);
f0c568a478f0353 Jianyun Li        2011-05-11  264  	if (!cmd->frame) {
f0c568a478f0353 Jianyun Li        2011-05-11  265  		dev_err(&mhba->pdev->dev, "failed to allocate memory for FW"
f0c568a478f0353 Jianyun Li        2011-05-11  266  			" frame,size = %d.\n", mhba->ib_max_size);
f0c568a478f0353 Jianyun Li        2011-05-11  267  		kfree(cmd);
f0c568a478f0353 Jianyun Li        2011-05-11  268  		return NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  269  	}
f0c568a478f0353 Jianyun Li        2011-05-11  270  
f0c568a478f0353 Jianyun Li        2011-05-11  271  	if (buf_size) {
f0c568a478f0353 Jianyun Li        2011-05-11  272  		if (mvumi_internal_cmd_sgl(mhba, cmd, buf_size)) {
f0c568a478f0353 Jianyun Li        2011-05-11  273  			dev_err(&mhba->pdev->dev, "failed to allocate memory"
f0c568a478f0353 Jianyun Li        2011-05-11  274  						" for internal frame\n");
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  275  			dma_free_coherent(&mhba->pdev->dev, mhba->ib_max_size,
bd756ddea18e02c Shun Fu           2012-09-23  276  					cmd->frame, cmd->frame_phys);
f0c568a478f0353 Jianyun Li        2011-05-11  277  			kfree(cmd);
f0c568a478f0353 Jianyun Li        2011-05-11  278  			return NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  279  		}
f0c568a478f0353 Jianyun Li        2011-05-11  280  	} else
f0c568a478f0353 Jianyun Li        2011-05-11  281  		cmd->frame->sg_counts = 0;
f0c568a478f0353 Jianyun Li        2011-05-11  282  
f0c568a478f0353 Jianyun Li        2011-05-11  283  	return cmd;
f0c568a478f0353 Jianyun Li        2011-05-11  284  }
f0c568a478f0353 Jianyun Li        2011-05-11  285  
f0c568a478f0353 Jianyun Li        2011-05-11  286  static void mvumi_delete_internal_cmd(struct mvumi_hba *mhba,
f0c568a478f0353 Jianyun Li        2011-05-11  287  						struct mvumi_cmd *cmd)
f0c568a478f0353 Jianyun Li        2011-05-11  288  {
f0c568a478f0353 Jianyun Li        2011-05-11  289  	struct mvumi_sgl *m_sg;
f0c568a478f0353 Jianyun Li        2011-05-11  290  	unsigned int size;
f0c568a478f0353 Jianyun Li        2011-05-11  291  	dma_addr_t phy_addr;
f0c568a478f0353 Jianyun Li        2011-05-11  292  
f0c568a478f0353 Jianyun Li        2011-05-11  293  	if (cmd && cmd->frame) {
f0c568a478f0353 Jianyun Li        2011-05-11  294  		if (cmd->frame->sg_counts) {
f0c568a478f0353 Jianyun Li        2011-05-11  295  			m_sg = (struct mvumi_sgl *) &cmd->frame->payload[0];
bd756ddea18e02c Shun Fu           2012-09-23  296  			sgd_getsz(mhba, m_sg, size);
f0c568a478f0353 Jianyun Li        2011-05-11  297  
f0c568a478f0353 Jianyun Li        2011-05-11  298  			phy_addr = (dma_addr_t) m_sg->baseaddr_l |
f0c568a478f0353 Jianyun Li        2011-05-11  299  				(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16);
f0c568a478f0353 Jianyun Li        2011-05-11  300  
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  301  			dma_free_coherent(&mhba->pdev->dev, size, cmd->data_buf,
f0c568a478f0353 Jianyun Li        2011-05-11  302  								phy_addr);
f0c568a478f0353 Jianyun Li        2011-05-11  303  		}
ab8e7f4bdfeac57 Christoph Hellwig 2018-10-10  304  		dma_free_coherent(&mhba->pdev->dev, mhba->ib_max_size,
bd756ddea18e02c Shun Fu           2012-09-23  305  				cmd->frame, cmd->frame_phys);
f0c568a478f0353 Jianyun Li        2011-05-11  306  		kfree(cmd);
f0c568a478f0353 Jianyun Li        2011-05-11  307  	}
f0c568a478f0353 Jianyun Li        2011-05-11  308  }
f0c568a478f0353 Jianyun Li        2011-05-11  309  
f0c568a478f0353 Jianyun Li        2011-05-11  310  /**
f0c568a478f0353 Jianyun Li        2011-05-11  311   * mvumi_get_cmd -	Get a command from the free pool
f0c568a478f0353 Jianyun Li        2011-05-11  312   * @mhba:		Adapter soft state
f0c568a478f0353 Jianyun Li        2011-05-11  313   *
f0c568a478f0353 Jianyun Li        2011-05-11  314   * Returns a free command from the pool
f0c568a478f0353 Jianyun Li        2011-05-11  315   */
f0c568a478f0353 Jianyun Li        2011-05-11  316  static struct mvumi_cmd *mvumi_get_cmd(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  317  {
f0c568a478f0353 Jianyun Li        2011-05-11  318  	struct mvumi_cmd *cmd = NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  319  
f0c568a478f0353 Jianyun Li        2011-05-11  320  	if (likely(!list_empty(&mhba->cmd_pool))) {
f0c568a478f0353 Jianyun Li        2011-05-11  321  		cmd = list_entry((&mhba->cmd_pool)->next,
f0c568a478f0353 Jianyun Li        2011-05-11  322  				struct mvumi_cmd, queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  323  		list_del_init(&cmd->queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  324  	} else
f0c568a478f0353 Jianyun Li        2011-05-11  325  		dev_warn(&mhba->pdev->dev, "command pool is empty!\n");
f0c568a478f0353 Jianyun Li        2011-05-11  326  
f0c568a478f0353 Jianyun Li        2011-05-11  327  	return cmd;
f0c568a478f0353 Jianyun Li        2011-05-11  328  }
f0c568a478f0353 Jianyun Li        2011-05-11  329  
f0c568a478f0353 Jianyun Li        2011-05-11  330  /**
f0c568a478f0353 Jianyun Li        2011-05-11  331   * mvumi_return_cmd -	Return a cmd to free command pool
f0c568a478f0353 Jianyun Li        2011-05-11  332   * @mhba:		Adapter soft state
f0c568a478f0353 Jianyun Li        2011-05-11  333   * @cmd:		Command packet to be returned to free command pool
f0c568a478f0353 Jianyun Li        2011-05-11  334   */
f0c568a478f0353 Jianyun Li        2011-05-11  335  static inline void mvumi_return_cmd(struct mvumi_hba *mhba,
f0c568a478f0353 Jianyun Li        2011-05-11  336  						struct mvumi_cmd *cmd)
f0c568a478f0353 Jianyun Li        2011-05-11  337  {
f0c568a478f0353 Jianyun Li        2011-05-11  338  	cmd->scmd = NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  339  	list_add_tail(&cmd->queue_pointer, &mhba->cmd_pool);
f0c568a478f0353 Jianyun Li        2011-05-11  340  }
f0c568a478f0353 Jianyun Li        2011-05-11  341  
f0c568a478f0353 Jianyun Li        2011-05-11  342  /**
f0c568a478f0353 Jianyun Li        2011-05-11  343   * mvumi_free_cmds -	Free all the cmds in the free cmd pool
f0c568a478f0353 Jianyun Li        2011-05-11  344   * @mhba:		Adapter soft state
f0c568a478f0353 Jianyun Li        2011-05-11  345   */
f0c568a478f0353 Jianyun Li        2011-05-11  346  static void mvumi_free_cmds(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  347  {
f0c568a478f0353 Jianyun Li        2011-05-11  348  	struct mvumi_cmd *cmd;
f0c568a478f0353 Jianyun Li        2011-05-11  349  
f0c568a478f0353 Jianyun Li        2011-05-11  350  	while (!list_empty(&mhba->cmd_pool)) {
f0c568a478f0353 Jianyun Li        2011-05-11  351  		cmd = list_first_entry(&mhba->cmd_pool, struct mvumi_cmd,
f0c568a478f0353 Jianyun Li        2011-05-11  352  							queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  353  		list_del(&cmd->queue_pointer);
bd756ddea18e02c Shun Fu           2012-09-23  354  		if (!(mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC))
f0c568a478f0353 Jianyun Li        2011-05-11  355  			kfree(cmd->frame);
f0c568a478f0353 Jianyun Li        2011-05-11  356  		kfree(cmd);
f0c568a478f0353 Jianyun Li        2011-05-11  357  	}
f0c568a478f0353 Jianyun Li        2011-05-11  358  }
f0c568a478f0353 Jianyun Li        2011-05-11  359  
f0c568a478f0353 Jianyun Li        2011-05-11  360  /**
f0c568a478f0353 Jianyun Li        2011-05-11  361   * mvumi_alloc_cmds -	Allocates the command packets
f0c568a478f0353 Jianyun Li        2011-05-11  362   * @mhba:		Adapter soft state
f0c568a478f0353 Jianyun Li        2011-05-11  363   *
f0c568a478f0353 Jianyun Li        2011-05-11  364   */
f0c568a478f0353 Jianyun Li        2011-05-11  365  static int mvumi_alloc_cmds(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  366  {
f0c568a478f0353 Jianyun Li        2011-05-11  367  	int i;
f0c568a478f0353 Jianyun Li        2011-05-11  368  	struct mvumi_cmd *cmd;
f0c568a478f0353 Jianyun Li        2011-05-11  369  
f0c568a478f0353 Jianyun Li        2011-05-11  370  	for (i = 0; i < mhba->max_io; i++) {
f0c568a478f0353 Jianyun Li        2011-05-11  371  		cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
f0c568a478f0353 Jianyun Li        2011-05-11  372  		if (!cmd)
f0c568a478f0353 Jianyun Li        2011-05-11  373  			goto err_exit;
f0c568a478f0353 Jianyun Li        2011-05-11  374  
f0c568a478f0353 Jianyun Li        2011-05-11  375  		INIT_LIST_HEAD(&cmd->queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  376  		list_add_tail(&cmd->queue_pointer, &mhba->cmd_pool);
bd756ddea18e02c Shun Fu           2012-09-23  377  		if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC) {
bd756ddea18e02c Shun Fu           2012-09-23  378  			cmd->frame = mhba->ib_frame + i * mhba->ib_max_size;
bd756ddea18e02c Shun Fu           2012-09-23  379  			cmd->frame_phys = mhba->ib_frame_phys
bd756ddea18e02c Shun Fu           2012-09-23  380  						+ i * mhba->ib_max_size;
bd756ddea18e02c Shun Fu           2012-09-23  381  		} else
f0c568a478f0353 Jianyun Li        2011-05-11  382  			cmd->frame = kzalloc(mhba->ib_max_size, GFP_KERNEL);
f0c568a478f0353 Jianyun Li        2011-05-11  383  		if (!cmd->frame)
f0c568a478f0353 Jianyun Li        2011-05-11  384  			goto err_exit;
f0c568a478f0353 Jianyun Li        2011-05-11  385  	}
f0c568a478f0353 Jianyun Li        2011-05-11  386  	return 0;
f0c568a478f0353 Jianyun Li        2011-05-11  387  
f0c568a478f0353 Jianyun Li        2011-05-11  388  err_exit:
f0c568a478f0353 Jianyun Li        2011-05-11  389  	dev_err(&mhba->pdev->dev,
f0c568a478f0353 Jianyun Li        2011-05-11  390  			"failed to allocate memory for cmd[0x%x].\n", i);
f0c568a478f0353 Jianyun Li        2011-05-11  391  	while (!list_empty(&mhba->cmd_pool)) {
f0c568a478f0353 Jianyun Li        2011-05-11  392  		cmd = list_first_entry(&mhba->cmd_pool, struct mvumi_cmd,
f0c568a478f0353 Jianyun Li        2011-05-11  393  						queue_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  394  		list_del(&cmd->queue_pointer);
bd756ddea18e02c Shun Fu           2012-09-23  395  		if (!(mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC))
f0c568a478f0353 Jianyun Li        2011-05-11  396  			kfree(cmd->frame);
f0c568a478f0353 Jianyun Li        2011-05-11  397  		kfree(cmd);
f0c568a478f0353 Jianyun Li        2011-05-11  398  	}
f0c568a478f0353 Jianyun Li        2011-05-11  399  	return -ENOMEM;
f0c568a478f0353 Jianyun Li        2011-05-11  400  }
f0c568a478f0353 Jianyun Li        2011-05-11  401  
bd756ddea18e02c Shun Fu           2012-09-23  402  static unsigned int mvumi_check_ib_list_9143(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  403  {
bd756ddea18e02c Shun Fu           2012-09-23  404  	unsigned int ib_rp_reg;
bd756ddea18e02c Shun Fu           2012-09-23  405  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu           2012-09-23  406  
bd756ddea18e02c Shun Fu           2012-09-23 @407  	ib_rp_reg = ioread32(mhba->regs->inb_read_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  408  
bd756ddea18e02c Shun Fu           2012-09-23  409  	if (unlikely(((ib_rp_reg & regs->cl_slot_num_mask) ==
bd756ddea18e02c Shun Fu           2012-09-23  410  			(mhba->ib_cur_slot & regs->cl_slot_num_mask)) &&
bd756ddea18e02c Shun Fu           2012-09-23  411  			((ib_rp_reg & regs->cl_pointer_toggle)
bd756ddea18e02c Shun Fu           2012-09-23  412  			 != (mhba->ib_cur_slot & regs->cl_pointer_toggle)))) {
bd756ddea18e02c Shun Fu           2012-09-23  413  		dev_warn(&mhba->pdev->dev, "no free slot to use.\n");
bd756ddea18e02c Shun Fu           2012-09-23  414  		return 0;
bd756ddea18e02c Shun Fu           2012-09-23  415  	}
f0c568a478f0353 Jianyun Li        2011-05-11  416  	if (atomic_read(&mhba->fw_outstanding) >= mhba->max_io) {
f0c568a478f0353 Jianyun Li        2011-05-11  417  		dev_warn(&mhba->pdev->dev, "firmware io overflow.\n");
bd756ddea18e02c Shun Fu           2012-09-23  418  		return 0;
bd756ddea18e02c Shun Fu           2012-09-23  419  	} else {
bd756ddea18e02c Shun Fu           2012-09-23  420  		return mhba->max_io - atomic_read(&mhba->fw_outstanding);
bd756ddea18e02c Shun Fu           2012-09-23  421  	}
f0c568a478f0353 Jianyun Li        2011-05-11  422  }
f0c568a478f0353 Jianyun Li        2011-05-11  423  
bd756ddea18e02c Shun Fu           2012-09-23  424  static unsigned int mvumi_check_ib_list_9580(struct mvumi_hba *mhba)
bd756ddea18e02c Shun Fu           2012-09-23  425  {
bd756ddea18e02c Shun Fu           2012-09-23  426  	unsigned int count;
bd756ddea18e02c Shun Fu           2012-09-23  427  	if (atomic_read(&mhba->fw_outstanding) >= (mhba->max_io - 1))
bd756ddea18e02c Shun Fu           2012-09-23  428  		return 0;
bd756ddea18e02c Shun Fu           2012-09-23 @429  	count = ioread32(mhba->ib_shadow);
bd756ddea18e02c Shun Fu           2012-09-23  430  	if (count == 0xffff)
bd756ddea18e02c Shun Fu           2012-09-23  431  		return 0;
bd756ddea18e02c Shun Fu           2012-09-23  432  	return count;
f0c568a478f0353 Jianyun Li        2011-05-11  433  }
f0c568a478f0353 Jianyun Li        2011-05-11  434  
bd756ddea18e02c Shun Fu           2012-09-23  435  static void mvumi_get_ib_list_entry(struct mvumi_hba *mhba, void **ib_entry)
bd756ddea18e02c Shun Fu           2012-09-23  436  {
bd756ddea18e02c Shun Fu           2012-09-23  437  	unsigned int cur_ib_entry;
bd756ddea18e02c Shun Fu           2012-09-23  438  
bd756ddea18e02c Shun Fu           2012-09-23  439  	cur_ib_entry = mhba->ib_cur_slot & mhba->regs->cl_slot_num_mask;
f0c568a478f0353 Jianyun Li        2011-05-11  440  	cur_ib_entry++;
f0c568a478f0353 Jianyun Li        2011-05-11  441  	if (cur_ib_entry >= mhba->list_num_io) {
f0c568a478f0353 Jianyun Li        2011-05-11  442  		cur_ib_entry -= mhba->list_num_io;
bd756ddea18e02c Shun Fu           2012-09-23  443  		mhba->ib_cur_slot ^= mhba->regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li        2011-05-11  444  	}
bd756ddea18e02c Shun Fu           2012-09-23  445  	mhba->ib_cur_slot &= ~mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu           2012-09-23  446  	mhba->ib_cur_slot |= (cur_ib_entry & mhba->regs->cl_slot_num_mask);
bd756ddea18e02c Shun Fu           2012-09-23  447  	if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC) {
bd756ddea18e02c Shun Fu           2012-09-23  448  		*ib_entry = mhba->ib_list + cur_ib_entry *
bd756ddea18e02c Shun Fu           2012-09-23  449  				sizeof(struct mvumi_dyn_list_entry);
bd756ddea18e02c Shun Fu           2012-09-23  450  	} else {
f0c568a478f0353 Jianyun Li        2011-05-11  451  		*ib_entry = mhba->ib_list + cur_ib_entry * mhba->ib_max_size;
bd756ddea18e02c Shun Fu           2012-09-23  452  	}
f0c568a478f0353 Jianyun Li        2011-05-11  453  	atomic_inc(&mhba->fw_outstanding);
f0c568a478f0353 Jianyun Li        2011-05-11  454  }
f0c568a478f0353 Jianyun Li        2011-05-11  455  
f0c568a478f0353 Jianyun Li        2011-05-11  456  static void mvumi_send_ib_list_entry(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  457  {
bd756ddea18e02c Shun Fu           2012-09-23 @458  	iowrite32(0xffff, mhba->ib_shadow);
bd756ddea18e02c Shun Fu           2012-09-23 @459  	iowrite32(mhba->ib_cur_slot, mhba->regs->inb_write_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  460  }
f0c568a478f0353 Jianyun Li        2011-05-11  461  
f0c568a478f0353 Jianyun Li        2011-05-11  462  static char mvumi_check_ob_frame(struct mvumi_hba *mhba,
f0c568a478f0353 Jianyun Li        2011-05-11  463  		unsigned int cur_obf, struct mvumi_rsp_frame *p_outb_frame)
f0c568a478f0353 Jianyun Li        2011-05-11  464  {
f0c568a478f0353 Jianyun Li        2011-05-11  465  	unsigned short tag, request_id;
f0c568a478f0353 Jianyun Li        2011-05-11  466  
f0c568a478f0353 Jianyun Li        2011-05-11  467  	udelay(1);
f0c568a478f0353 Jianyun Li        2011-05-11  468  	p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
f0c568a478f0353 Jianyun Li        2011-05-11  469  	request_id = p_outb_frame->request_id;
f0c568a478f0353 Jianyun Li        2011-05-11  470  	tag = p_outb_frame->tag;
f0c568a478f0353 Jianyun Li        2011-05-11  471  	if (tag > mhba->tag_pool.size) {
f0c568a478f0353 Jianyun Li        2011-05-11  472  		dev_err(&mhba->pdev->dev, "ob frame data error\n");
f0c568a478f0353 Jianyun Li        2011-05-11  473  		return -1;
f0c568a478f0353 Jianyun Li        2011-05-11  474  	}
f0c568a478f0353 Jianyun Li        2011-05-11  475  	if (mhba->tag_cmd[tag] == NULL) {
f0c568a478f0353 Jianyun Li        2011-05-11  476  		dev_err(&mhba->pdev->dev, "tag[0x%x] with NO command\n", tag);
f0c568a478f0353 Jianyun Li        2011-05-11  477  		return -1;
f0c568a478f0353 Jianyun Li        2011-05-11  478  	} else if (mhba->tag_cmd[tag]->request_id != request_id &&
f0c568a478f0353 Jianyun Li        2011-05-11  479  						mhba->request_id_enabled) {
f0c568a478f0353 Jianyun Li        2011-05-11  480  			dev_err(&mhba->pdev->dev, "request ID from FW:0x%x,"
f0c568a478f0353 Jianyun Li        2011-05-11  481  					"cmd request ID:0x%x\n", request_id,
f0c568a478f0353 Jianyun Li        2011-05-11  482  					mhba->tag_cmd[tag]->request_id);
f0c568a478f0353 Jianyun Li        2011-05-11  483  			return -1;
f0c568a478f0353 Jianyun Li        2011-05-11  484  	}
f0c568a478f0353 Jianyun Li        2011-05-11  485  
f0c568a478f0353 Jianyun Li        2011-05-11  486  	return 0;
f0c568a478f0353 Jianyun Li        2011-05-11  487  }
f0c568a478f0353 Jianyun Li        2011-05-11  488  
bd756ddea18e02c Shun Fu           2012-09-23  489  static int mvumi_check_ob_list_9143(struct mvumi_hba *mhba,
bd756ddea18e02c Shun Fu           2012-09-23  490  			unsigned int *cur_obf, unsigned int *assign_obf_end)
f0c568a478f0353 Jianyun Li        2011-05-11  491  {
bd756ddea18e02c Shun Fu           2012-09-23  492  	unsigned int ob_write, ob_write_shadow;
bd756ddea18e02c Shun Fu           2012-09-23  493  	struct mvumi_hw_regs *regs = mhba->regs;
f0c568a478f0353 Jianyun Li        2011-05-11  494  
f0c568a478f0353 Jianyun Li        2011-05-11  495  	do {
bd756ddea18e02c Shun Fu           2012-09-23 @496  		ob_write = ioread32(regs->outb_copy_pointer);
bd756ddea18e02c Shun Fu           2012-09-23 @497  		ob_write_shadow = ioread32(mhba->ob_shadow);
bd756ddea18e02c Shun Fu           2012-09-23  498  	} while ((ob_write & regs->cl_slot_num_mask) != ob_write_shadow);
f0c568a478f0353 Jianyun Li        2011-05-11  499  
bd756ddea18e02c Shun Fu           2012-09-23  500  	*cur_obf = mhba->ob_cur_slot & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu           2012-09-23  501  	*assign_obf_end = ob_write & mhba->regs->cl_slot_num_mask;
f0c568a478f0353 Jianyun Li        2011-05-11  502  
bd756ddea18e02c Shun Fu           2012-09-23  503  	if ((ob_write & regs->cl_pointer_toggle) !=
bd756ddea18e02c Shun Fu           2012-09-23  504  			(mhba->ob_cur_slot & regs->cl_pointer_toggle)) {
bd756ddea18e02c Shun Fu           2012-09-23  505  		*assign_obf_end += mhba->list_num_io;
bd756ddea18e02c Shun Fu           2012-09-23  506  	}
bd756ddea18e02c Shun Fu           2012-09-23  507  	return 0;
f0c568a478f0353 Jianyun Li        2011-05-11  508  }
f0c568a478f0353 Jianyun Li        2011-05-11  509  
bd756ddea18e02c Shun Fu           2012-09-23  510  static int mvumi_check_ob_list_9580(struct mvumi_hba *mhba,
bd756ddea18e02c Shun Fu           2012-09-23  511  			unsigned int *cur_obf, unsigned int *assign_obf_end)
bd756ddea18e02c Shun Fu           2012-09-23  512  {
bd756ddea18e02c Shun Fu           2012-09-23  513  	unsigned int ob_write;
bd756ddea18e02c Shun Fu           2012-09-23  514  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu           2012-09-23  515  
bd756ddea18e02c Shun Fu           2012-09-23 @516  	ob_write = ioread32(regs->outb_read_pointer);
bd756ddea18e02c Shun Fu           2012-09-23 @517  	ob_write = ioread32(regs->outb_copy_pointer);
bd756ddea18e02c Shun Fu           2012-09-23  518  	*cur_obf = mhba->ob_cur_slot & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu           2012-09-23  519  	*assign_obf_end = ob_write & mhba->regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu           2012-09-23  520  	if (*assign_obf_end < *cur_obf)
bd756ddea18e02c Shun Fu           2012-09-23  521  		*assign_obf_end += mhba->list_num_io;
bd756ddea18e02c Shun Fu           2012-09-23  522  	else if (*assign_obf_end == *cur_obf)
bd756ddea18e02c Shun Fu           2012-09-23  523  		return -1;
bd756ddea18e02c Shun Fu           2012-09-23  524  	return 0;
bd756ddea18e02c Shun Fu           2012-09-23  525  }
bd756ddea18e02c Shun Fu           2012-09-23  526  
bd756ddea18e02c Shun Fu           2012-09-23  527  static void mvumi_receive_ob_list_entry(struct mvumi_hba *mhba)
bd756ddea18e02c Shun Fu           2012-09-23  528  {
bd756ddea18e02c Shun Fu           2012-09-23  529  	unsigned int cur_obf, assign_obf_end, i;
bd756ddea18e02c Shun Fu           2012-09-23  530  	struct mvumi_ob_data *ob_data;
bd756ddea18e02c Shun Fu           2012-09-23  531  	struct mvumi_rsp_frame *p_outb_frame;
bd756ddea18e02c Shun Fu           2012-09-23  532  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu           2012-09-23  533  
bd756ddea18e02c Shun Fu           2012-09-23  534  	if (mhba->instancet->check_ob_list(mhba, &cur_obf, &assign_obf_end))
bd756ddea18e02c Shun Fu           2012-09-23  535  		return;
bd756ddea18e02c Shun Fu           2012-09-23  536  
f0c568a478f0353 Jianyun Li        2011-05-11  537  	for (i = (assign_obf_end - cur_obf); i != 0; i--) {
f0c568a478f0353 Jianyun Li        2011-05-11  538  		cur_obf++;
f0c568a478f0353 Jianyun Li        2011-05-11  539  		if (cur_obf >= mhba->list_num_io) {
f0c568a478f0353 Jianyun Li        2011-05-11  540  			cur_obf -= mhba->list_num_io;
bd756ddea18e02c Shun Fu           2012-09-23  541  			mhba->ob_cur_slot ^= regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li        2011-05-11  542  		}
f0c568a478f0353 Jianyun Li        2011-05-11  543  
f0c568a478f0353 Jianyun Li        2011-05-11  544  		p_outb_frame = mhba->ob_list + cur_obf * mhba->ob_max_size;
f0c568a478f0353 Jianyun Li        2011-05-11  545  
f0c568a478f0353 Jianyun Li        2011-05-11  546  		/* Copy pointer may point to entry in outbound list
f0c568a478f0353 Jianyun Li        2011-05-11  547  		*  before entry has valid data
f0c568a478f0353 Jianyun Li        2011-05-11  548  		*/
f0c568a478f0353 Jianyun Li        2011-05-11  549  		if (unlikely(p_outb_frame->tag > mhba->tag_pool.size ||
f0c568a478f0353 Jianyun Li        2011-05-11  550  			mhba->tag_cmd[p_outb_frame->tag] == NULL ||
f0c568a478f0353 Jianyun Li        2011-05-11  551  			p_outb_frame->request_id !=
f0c568a478f0353 Jianyun Li        2011-05-11  552  				mhba->tag_cmd[p_outb_frame->tag]->request_id))
f0c568a478f0353 Jianyun Li        2011-05-11  553  			if (mvumi_check_ob_frame(mhba, cur_obf, p_outb_frame))
f0c568a478f0353 Jianyun Li        2011-05-11  554  				continue;
f0c568a478f0353 Jianyun Li        2011-05-11  555  
f0c568a478f0353 Jianyun Li        2011-05-11  556  		if (!list_empty(&mhba->ob_data_list)) {
f0c568a478f0353 Jianyun Li        2011-05-11  557  			ob_data = (struct mvumi_ob_data *)
f0c568a478f0353 Jianyun Li        2011-05-11  558  				list_first_entry(&mhba->ob_data_list,
f0c568a478f0353 Jianyun Li        2011-05-11  559  					struct mvumi_ob_data, list);
f0c568a478f0353 Jianyun Li        2011-05-11  560  			list_del_init(&ob_data->list);
f0c568a478f0353 Jianyun Li        2011-05-11  561  		} else {
f0c568a478f0353 Jianyun Li        2011-05-11  562  			ob_data = NULL;
f0c568a478f0353 Jianyun Li        2011-05-11  563  			if (cur_obf == 0) {
f0c568a478f0353 Jianyun Li        2011-05-11  564  				cur_obf = mhba->list_num_io - 1;
bd756ddea18e02c Shun Fu           2012-09-23  565  				mhba->ob_cur_slot ^= regs->cl_pointer_toggle;
f0c568a478f0353 Jianyun Li        2011-05-11  566  			} else
f0c568a478f0353 Jianyun Li        2011-05-11  567  				cur_obf -= 1;
f0c568a478f0353 Jianyun Li        2011-05-11  568  			break;
f0c568a478f0353 Jianyun Li        2011-05-11  569  		}
f0c568a478f0353 Jianyun Li        2011-05-11  570  
f0c568a478f0353 Jianyun Li        2011-05-11  571  		memcpy(ob_data->data, p_outb_frame, mhba->ob_max_size);
f0c568a478f0353 Jianyun Li        2011-05-11  572  		p_outb_frame->tag = 0xff;
f0c568a478f0353 Jianyun Li        2011-05-11  573  
f0c568a478f0353 Jianyun Li        2011-05-11  574  		list_add_tail(&ob_data->list, &mhba->free_ob_list);
f0c568a478f0353 Jianyun Li        2011-05-11  575  	}
bd756ddea18e02c Shun Fu           2012-09-23  576  	mhba->ob_cur_slot &= ~regs->cl_slot_num_mask;
bd756ddea18e02c Shun Fu           2012-09-23  577  	mhba->ob_cur_slot |= (cur_obf & regs->cl_slot_num_mask);
bd756ddea18e02c Shun Fu           2012-09-23  578  	iowrite32(mhba->ob_cur_slot, regs->outb_read_pointer);
f0c568a478f0353 Jianyun Li        2011-05-11  579  }
f0c568a478f0353 Jianyun Li        2011-05-11  580  
bd756ddea18e02c Shun Fu           2012-09-23  581  static void mvumi_reset(struct mvumi_hba *mhba)
f0c568a478f0353 Jianyun Li        2011-05-11  582  {
bd756ddea18e02c Shun Fu           2012-09-23  583  	struct mvumi_hw_regs *regs = mhba->regs;
bd756ddea18e02c Shun Fu           2012-09-23  584  
bd756ddea18e02c Shun Fu           2012-09-23 @585  	iowrite32(0, regs->enpointa_mask_reg);
bd756ddea18e02c Shun Fu           2012-09-23 @586  	if (ioread32(regs->arm_to_pciea_msg1) != HANDSHAKE_DONESTATE)
f0c568a478f0353 Jianyun Li        2011-05-11  587  		return;
f0c568a478f0353 Jianyun Li        2011-05-11  588  
bd756ddea18e02c Shun Fu           2012-09-23  589  	iowrite32(DRBL_SOFT_RESET, regs->pciea_to_arm_drbl_reg);
f0c568a478f0353 Jianyun Li        2011-05-11  590  }
f0c568a478f0353 Jianyun Li        2011-05-11  591  

:::::: The code at line 407 was first introduced by commit
:::::: bd756ddea18e02ccea8b29496b2fe3bd91af8eb7 [SCSI] mvumi: Add support for Marvell SAS/SATA RAID-on-Chip(ROC) 88RC9580

:::::: TO: Shun Fu <fushun@gmail.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
BLTIAQA=

--6c2NcOVqGQ03X4Wi--
