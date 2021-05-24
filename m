Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D938F18C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhEXQaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:30:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:26416 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233859AbhEXQ37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:29:59 -0400
IronPort-SDR: lNQBmdMAwhbxZLs67XH85cOT5pdcVSGASkB4k03Kx5WdOLb2As8nfmjhAMNP0hfTosYHiI2qGl
 Dlemc3iBYiag==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="263182204"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="gz'50?scan'50,208,50";a="263182204"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 09:28:28 -0700
IronPort-SDR: VaCIb2Kh1qQkkHZmN63c7aDy45GZ7jRg5Kqtc0YeWF/beuaJXFbaZoLNpepXL7wx99qNXSC+2b
 lZsErErf2huw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="gz'50?scan'50,208,50";a="413658175"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2021 09:28:26 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1llDRJ-0001Hk-DQ; Mon, 24 May 2021 16:28:25 +0000
Date:   Tue, 25 May 2021 00:27:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202105250009.b8pXBDNq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c4681547bcce777daf576925a966ffa824edd09d
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   9 months ago
config: alpha-randconfig-s032-20210524 (attached as .config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=alpha 

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

--/9DWx/yDrRhgMJTb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--/9DWx/yDrRhgMJTb--
