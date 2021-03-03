Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03CC32BF5A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835270AbhCCSCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:02:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:19216 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244653AbhCCPLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:11:55 -0500
IronPort-SDR: +2wYwCgFPfD9FtElz+xVprH65qjIas6MNPFtQRuBK6O0vZg41zTWmlr5D3/XY1fIHo6lM3ZTFe
 8LyygaVonMSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="206900994"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="gz'50?scan'50,208,50";a="206900994"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 07:08:50 -0800
IronPort-SDR: oa8GBFEjcVnEzrLg/3rcnFuTHqDaylCwu6JdeH7/RTn6qCBPSPwvI8qvtV5pPRmpcn9uc2dcwq
 DsT2RnrCk0eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="gz'50?scan'50,208,50";a="436029609"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2021 07:07:56 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHT6H-0001Z1-UB; Wed, 03 Mar 2021 15:07:45 +0000
Date:   Wed, 3 Mar 2021 23:06:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: drivers/firmware/efi/test/efi_test.c:157:13: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202103032340.5v3dyP01-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Atish,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f69d02e37a85645aa90d18cacfff36dba370f797
commit: d7071743db31b4f6898b1c742e4b451bb4bc4b02 RISC-V: Add EFI stub support.
date:   5 months ago
config: riscv-randconfig-s031-20210303 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-245-gacc5c298-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7071743db31b4f6898b1c742e4b451bb4bc4b02
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d7071743db31b4f6898b1c742e4b451bb4bc4b02
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/firmware/efi/test/efi_test.c:157:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__p @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:157:13: sparse:     expected unsigned long const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:157:13: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:160:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:167:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:187:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:194:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:209:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     got void *[addressable] data
   drivers/firmware/efi/test/efi_test.c:215:19: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__p @@     got unsigned int [usertype] *[addressable] attributes @@
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     expected unsigned int [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     got unsigned int [usertype] *[addressable] attributes
   drivers/firmware/efi/test/efi_test.c:220:19: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:243:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:243:53: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:243:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:248:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:248:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:248:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:253:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:253:39: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:253:39: sparse:     got void *[addressable] data
   drivers/firmware/efi/test/efi_test.c:263:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:292:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:301:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct efi_time_cap_t [noderef] [usertype] __user *cap_local @@     got struct efi_time_cap_t [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:301:27: sparse:     expected struct efi_time_cap_t [noderef] [usertype] __user *cap_local
   drivers/firmware/efi/test/efi_test.c:301:27: sparse:     got struct efi_time_cap_t [usertype] *
   drivers/firmware/efi/test/efi_test.c:308:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:308:41: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:308:41: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:325:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:325:46: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:325:46: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:330:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:360:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__p @@     got unsigned char [usertype] *[addressable] enabled @@
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     expected unsigned char [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     got unsigned char [usertype] *[addressable] enabled
   drivers/firmware/efi/test/efi_test.c:365:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:389:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:397:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:421:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__p @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     expected unsigned long const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:429:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:429:52: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:429:52: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:439:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:439:52: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:439:52: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:452:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:452:52: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:452:52: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:461:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:468:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:479:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *dst @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     expected unsigned short [noderef] [usertype] __user *dst
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:487:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:494:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:522:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:529:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__p @@     got unsigned int [usertype] *[addressable] high_count @@
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     expected unsigned int [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     got unsigned int [usertype] *[addressable] high_count
   drivers/firmware/efi/test/efi_test.c:546:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void * @@
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     got void *
   drivers/firmware/efi/test/efi_test.c:575:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:581:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] maximum_variable_storage_size @@
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     got unsigned long long [usertype] *[addressable] maximum_variable_storage_size
   drivers/firmware/efi/test/efi_test.c:585:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] remaining_variable_storage_size @@
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     got unsigned long long [usertype] *[addressable] remaining_variable_storage_size
   drivers/firmware/efi/test/efi_test.c:589:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] maximum_variable_size @@
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     got unsigned long long [usertype] *[addressable] maximum_variable_size
>> drivers/firmware/efi/test/efi_test.c:625:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct efi_capsule_header_t [usertype] *const [noderef] __user *__p @@     got struct efi_capsule_header_t [usertype] ** @@
   drivers/firmware/efi/test/efi_test.c:625:21: sparse:     expected struct efi_capsule_header_t [usertype] *const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:625:21: sparse:     got struct efi_capsule_header_t [usertype] **
   drivers/firmware/efi/test/efi_test.c:625:21: sparse: sparse: Using plain integer as NULL pointer
   drivers/firmware/efi/test/efi_test.c:629:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_capsule_header_t [usertype] *[assigned] c @@
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     got struct efi_capsule_header_t [usertype] *[assigned] c
   drivers/firmware/efi/test/efi_test.c:643:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *__p @@     got unsigned long [usertype] *[addressable] [assigned] status @@
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     expected unsigned long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     got unsigned long [usertype] *[addressable] [assigned] status
   drivers/firmware/efi/test/efi_test.c:653:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *__p @@     got unsigned long long [usertype] *[addressable] [assigned] maximum_capsule_size @@
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     expected unsigned long long [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     got unsigned long long [usertype] *[addressable] [assigned] maximum_capsule_size
   drivers/firmware/efi/test/efi_test.c:658:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int *[addressable] [assigned] reset_type @@
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     expected int [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     got int *[addressable] [assigned] reset_type
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short const [noderef] __user *__p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *

vim +157 drivers/firmware/efi/test/efi_test.c

ff6301dabc3ca2 Ivan Hu      2016-08-25   26  
ff6301dabc3ca2 Ivan Hu      2016-08-25   27  /*
ff6301dabc3ca2 Ivan Hu      2016-08-25   28   * Count the bytes in 'str', including the terminating NULL.
ff6301dabc3ca2 Ivan Hu      2016-08-25   29   *
ff6301dabc3ca2 Ivan Hu      2016-08-25   30   * Note this function returns the number of *bytes*, not the number of
ff6301dabc3ca2 Ivan Hu      2016-08-25   31   * ucs2 characters.
ff6301dabc3ca2 Ivan Hu      2016-08-25   32   */
ff6301dabc3ca2 Ivan Hu      2016-08-25   33  static inline size_t user_ucs2_strsize(efi_char16_t  __user *str)
ff6301dabc3ca2 Ivan Hu      2016-08-25   34  {
ff6301dabc3ca2 Ivan Hu      2016-08-25   35  	efi_char16_t *s = str, c;
ff6301dabc3ca2 Ivan Hu      2016-08-25   36  	size_t len;
ff6301dabc3ca2 Ivan Hu      2016-08-25   37  
ff6301dabc3ca2 Ivan Hu      2016-08-25   38  	if (!str)
ff6301dabc3ca2 Ivan Hu      2016-08-25   39  		return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   40  
ff6301dabc3ca2 Ivan Hu      2016-08-25   41  	/* Include terminating NULL */
ff6301dabc3ca2 Ivan Hu      2016-08-25   42  	len = sizeof(efi_char16_t);
ff6301dabc3ca2 Ivan Hu      2016-08-25   43  
ff6301dabc3ca2 Ivan Hu      2016-08-25  @44  	if (get_user(c, s++)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25   45  		/* Can't read userspace memory for size */
ff6301dabc3ca2 Ivan Hu      2016-08-25   46  		return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   47  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25   48  
ff6301dabc3ca2 Ivan Hu      2016-08-25   49  	while (c != 0) {
ff6301dabc3ca2 Ivan Hu      2016-08-25   50  		if (get_user(c, s++)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25   51  			/* Can't read userspace memory for size */
ff6301dabc3ca2 Ivan Hu      2016-08-25   52  			return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   53  		}
ff6301dabc3ca2 Ivan Hu      2016-08-25   54  		len += sizeof(efi_char16_t);
ff6301dabc3ca2 Ivan Hu      2016-08-25   55  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25   56  	return len;
ff6301dabc3ca2 Ivan Hu      2016-08-25   57  }
ff6301dabc3ca2 Ivan Hu      2016-08-25   58  
ff6301dabc3ca2 Ivan Hu      2016-08-25   59  /*
ff6301dabc3ca2 Ivan Hu      2016-08-25   60   * Allocate a buffer and copy a ucs2 string from user space into it.
ff6301dabc3ca2 Ivan Hu      2016-08-25   61   */
ff6301dabc3ca2 Ivan Hu      2016-08-25   62  static inline int
ff6301dabc3ca2 Ivan Hu      2016-08-25   63  copy_ucs2_from_user_len(efi_char16_t **dst, efi_char16_t __user *src,
ff6301dabc3ca2 Ivan Hu      2016-08-25   64  			size_t len)
ff6301dabc3ca2 Ivan Hu      2016-08-25   65  {
ff6301dabc3ca2 Ivan Hu      2016-08-25   66  	efi_char16_t *buf;
ff6301dabc3ca2 Ivan Hu      2016-08-25   67  
ff6301dabc3ca2 Ivan Hu      2016-08-25   68  	if (!src) {
ff6301dabc3ca2 Ivan Hu      2016-08-25   69  		*dst = NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25   70  		return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   71  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25   72  
5f72cad65cfaac Geliang Tang 2017-06-02   73  	buf = memdup_user(src, len);
5f72cad65cfaac Geliang Tang 2017-06-02   74  	if (IS_ERR(buf)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25   75  		*dst = NULL;
5f72cad65cfaac Geliang Tang 2017-06-02   76  		return PTR_ERR(buf);
ff6301dabc3ca2 Ivan Hu      2016-08-25   77  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25   78  	*dst = buf;
ff6301dabc3ca2 Ivan Hu      2016-08-25   79  
ff6301dabc3ca2 Ivan Hu      2016-08-25   80  	return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   81  }
ff6301dabc3ca2 Ivan Hu      2016-08-25   82  
ff6301dabc3ca2 Ivan Hu      2016-08-25   83  /*
ff6301dabc3ca2 Ivan Hu      2016-08-25   84   * Count the bytes in 'str', including the terminating NULL.
ff6301dabc3ca2 Ivan Hu      2016-08-25   85   *
ff6301dabc3ca2 Ivan Hu      2016-08-25   86   * Just a wrap for user_ucs2_strsize
ff6301dabc3ca2 Ivan Hu      2016-08-25   87   */
ff6301dabc3ca2 Ivan Hu      2016-08-25   88  static inline int
ff6301dabc3ca2 Ivan Hu      2016-08-25   89  get_ucs2_strsize_from_user(efi_char16_t __user *src, size_t *len)
ff6301dabc3ca2 Ivan Hu      2016-08-25   90  {
ff6301dabc3ca2 Ivan Hu      2016-08-25   91  	*len = user_ucs2_strsize(src);
ff6301dabc3ca2 Ivan Hu      2016-08-25   92  	if (*len == 0)
ff6301dabc3ca2 Ivan Hu      2016-08-25   93  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25   94  
ff6301dabc3ca2 Ivan Hu      2016-08-25   95  	return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25   96  }
ff6301dabc3ca2 Ivan Hu      2016-08-25   97  
ff6301dabc3ca2 Ivan Hu      2016-08-25   98  /*
ff6301dabc3ca2 Ivan Hu      2016-08-25   99   * Calculate the required buffer allocation size and copy a ucs2 string
ff6301dabc3ca2 Ivan Hu      2016-08-25  100   * from user space into it.
ff6301dabc3ca2 Ivan Hu      2016-08-25  101   *
ff6301dabc3ca2 Ivan Hu      2016-08-25  102   * This function differs from copy_ucs2_from_user_len() because it
ff6301dabc3ca2 Ivan Hu      2016-08-25  103   * calculates the size of the buffer to allocate by taking the length of
ff6301dabc3ca2 Ivan Hu      2016-08-25  104   * the string 'src'.
ff6301dabc3ca2 Ivan Hu      2016-08-25  105   *
ff6301dabc3ca2 Ivan Hu      2016-08-25  106   * If a non-zero value is returned, the caller MUST NOT access 'dst'.
ff6301dabc3ca2 Ivan Hu      2016-08-25  107   *
ff6301dabc3ca2 Ivan Hu      2016-08-25  108   * It is the caller's responsibility to free 'dst'.
ff6301dabc3ca2 Ivan Hu      2016-08-25  109   */
ff6301dabc3ca2 Ivan Hu      2016-08-25  110  static inline int
ff6301dabc3ca2 Ivan Hu      2016-08-25  111  copy_ucs2_from_user(efi_char16_t **dst, efi_char16_t __user *src)
ff6301dabc3ca2 Ivan Hu      2016-08-25  112  {
ff6301dabc3ca2 Ivan Hu      2016-08-25  113  	size_t len;
ff6301dabc3ca2 Ivan Hu      2016-08-25  114  
ff6301dabc3ca2 Ivan Hu      2016-08-25  115  	len = user_ucs2_strsize(src);
ff6301dabc3ca2 Ivan Hu      2016-08-25  116  	if (len == 0)
ff6301dabc3ca2 Ivan Hu      2016-08-25  117  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  118  	return copy_ucs2_from_user_len(dst, src, len);
ff6301dabc3ca2 Ivan Hu      2016-08-25  119  }
ff6301dabc3ca2 Ivan Hu      2016-08-25  120  
ff6301dabc3ca2 Ivan Hu      2016-08-25  121  /*
ff6301dabc3ca2 Ivan Hu      2016-08-25  122   * Copy a ucs2 string to a user buffer.
ff6301dabc3ca2 Ivan Hu      2016-08-25  123   *
ff6301dabc3ca2 Ivan Hu      2016-08-25  124   * This function is a simple wrapper around copy_to_user() that does
ff6301dabc3ca2 Ivan Hu      2016-08-25  125   * nothing if 'src' is NULL, which is useful for reducing the amount of
ff6301dabc3ca2 Ivan Hu      2016-08-25  126   * NULL checking the caller has to do.
ff6301dabc3ca2 Ivan Hu      2016-08-25  127   *
ff6301dabc3ca2 Ivan Hu      2016-08-25  128   * 'len' specifies the number of bytes to copy.
ff6301dabc3ca2 Ivan Hu      2016-08-25  129   */
ff6301dabc3ca2 Ivan Hu      2016-08-25  130  static inline int
ff6301dabc3ca2 Ivan Hu      2016-08-25  131  copy_ucs2_to_user_len(efi_char16_t __user *dst, efi_char16_t *src, size_t len)
ff6301dabc3ca2 Ivan Hu      2016-08-25  132  {
ff6301dabc3ca2 Ivan Hu      2016-08-25  133  	if (!src)
ff6301dabc3ca2 Ivan Hu      2016-08-25  134  		return 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25  135  
ff6301dabc3ca2 Ivan Hu      2016-08-25  136  	return copy_to_user(dst, src, len);
ff6301dabc3ca2 Ivan Hu      2016-08-25  137  }
ff6301dabc3ca2 Ivan Hu      2016-08-25  138  
ff6301dabc3ca2 Ivan Hu      2016-08-25  139  static long efi_runtime_get_variable(unsigned long arg)
ff6301dabc3ca2 Ivan Hu      2016-08-25  140  {
ff6301dabc3ca2 Ivan Hu      2016-08-25  141  	struct efi_getvariable __user *getvariable_user;
ff6301dabc3ca2 Ivan Hu      2016-08-25  142  	struct efi_getvariable getvariable;
46b9b7135332d1 Ivan Hu      2016-10-18  143  	unsigned long datasize = 0, prev_datasize, *dz;
ff6301dabc3ca2 Ivan Hu      2016-08-25  144  	efi_guid_t vendor_guid, *vd = NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  145  	efi_status_t status;
ff6301dabc3ca2 Ivan Hu      2016-08-25  146  	efi_char16_t *name = NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  147  	u32 attr, *at;
ff6301dabc3ca2 Ivan Hu      2016-08-25  148  	void *data = NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  149  	int rv = 0;
ff6301dabc3ca2 Ivan Hu      2016-08-25  150  
ff6301dabc3ca2 Ivan Hu      2016-08-25  151  	getvariable_user = (struct efi_getvariable __user *)arg;
ff6301dabc3ca2 Ivan Hu      2016-08-25  152  
ff6301dabc3ca2 Ivan Hu      2016-08-25  153  	if (copy_from_user(&getvariable, getvariable_user,
ff6301dabc3ca2 Ivan Hu      2016-08-25  154  			   sizeof(getvariable)))
ff6301dabc3ca2 Ivan Hu      2016-08-25  155  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  156  	if (getvariable.data_size &&
ff6301dabc3ca2 Ivan Hu      2016-08-25 @157  	    get_user(datasize, getvariable.data_size))
ff6301dabc3ca2 Ivan Hu      2016-08-25  158  		return -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  159  	if (getvariable.vendor_guid) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  160  		if (copy_from_user(&vendor_guid, getvariable.vendor_guid,
ff6301dabc3ca2 Ivan Hu      2016-08-25  161  					sizeof(vendor_guid)))
ff6301dabc3ca2 Ivan Hu      2016-08-25  162  			return -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  163  		vd = &vendor_guid;
ff6301dabc3ca2 Ivan Hu      2016-08-25  164  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  165  
ff6301dabc3ca2 Ivan Hu      2016-08-25  166  	if (getvariable.variable_name) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  167  		rv = copy_ucs2_from_user(&name, getvariable.variable_name);
ff6301dabc3ca2 Ivan Hu      2016-08-25  168  		if (rv)
ff6301dabc3ca2 Ivan Hu      2016-08-25  169  			return rv;
ff6301dabc3ca2 Ivan Hu      2016-08-25  170  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  171  
ff6301dabc3ca2 Ivan Hu      2016-08-25  172  	at = getvariable.attributes ? &attr : NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  173  	dz = getvariable.data_size ? &datasize : NULL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  174  
ff6301dabc3ca2 Ivan Hu      2016-08-25  175  	if (getvariable.data_size && getvariable.data) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  176  		data = kmalloc(datasize, GFP_KERNEL);
ff6301dabc3ca2 Ivan Hu      2016-08-25  177  		if (!data) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  178  			kfree(name);
ff6301dabc3ca2 Ivan Hu      2016-08-25  179  			return -ENOMEM;
ff6301dabc3ca2 Ivan Hu      2016-08-25  180  		}
ff6301dabc3ca2 Ivan Hu      2016-08-25  181  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  182  
ff6301dabc3ca2 Ivan Hu      2016-08-25  183  	prev_datasize = datasize;
ff6301dabc3ca2 Ivan Hu      2016-08-25  184  	status = efi.get_variable(name, vd, at, dz, data);
ff6301dabc3ca2 Ivan Hu      2016-08-25  185  	kfree(name);
ff6301dabc3ca2 Ivan Hu      2016-08-25  186  
ff6301dabc3ca2 Ivan Hu      2016-08-25  187  	if (put_user(status, getvariable.status)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  188  		rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  189  		goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  190  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  191  
ff6301dabc3ca2 Ivan Hu      2016-08-25  192  	if (status != EFI_SUCCESS) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  193  		if (status == EFI_BUFFER_TOO_SMALL) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  194  			if (dz && put_user(datasize, getvariable.data_size)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  195  				rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  196  				goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  197  			}
ff6301dabc3ca2 Ivan Hu      2016-08-25  198  		}
ff6301dabc3ca2 Ivan Hu      2016-08-25  199  		rv = -EINVAL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  200  		goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  201  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  202  
ff6301dabc3ca2 Ivan Hu      2016-08-25  203  	if (prev_datasize < datasize) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  204  		rv = -EINVAL;
ff6301dabc3ca2 Ivan Hu      2016-08-25  205  		goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  206  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  207  
ff6301dabc3ca2 Ivan Hu      2016-08-25  208  	if (data) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  209  		if (copy_to_user(getvariable.data, data, datasize)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  210  			rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  211  			goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  212  		}
ff6301dabc3ca2 Ivan Hu      2016-08-25  213  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  214  
ff6301dabc3ca2 Ivan Hu      2016-08-25  215  	if (at && put_user(attr, getvariable.attributes)) {
ff6301dabc3ca2 Ivan Hu      2016-08-25  216  		rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  217  		goto out;
ff6301dabc3ca2 Ivan Hu      2016-08-25  218  	}
ff6301dabc3ca2 Ivan Hu      2016-08-25  219  
ff6301dabc3ca2 Ivan Hu      2016-08-25  220  	if (dz && put_user(datasize, getvariable.data_size))
ff6301dabc3ca2 Ivan Hu      2016-08-25  221  		rv = -EFAULT;
ff6301dabc3ca2 Ivan Hu      2016-08-25  222  
ff6301dabc3ca2 Ivan Hu      2016-08-25  223  out:
ff6301dabc3ca2 Ivan Hu      2016-08-25  224  	kfree(data);
ff6301dabc3ca2 Ivan Hu      2016-08-25  225  	return rv;
ff6301dabc3ca2 Ivan Hu      2016-08-25  226  

:::::: The code at line 157 was first introduced by commit
:::::: ff6301dabc3ca20ab8f50f8d0252ac05da610d89 efi: Add efi_test driver for exporting UEFI runtime service interfaces

:::::: TO: Ivan Hu <ivan.hu@canonical.com>
:::::: CC: Matt Fleming <matt@codeblueprint.co.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--IS0zKkzwUGydFO0o--
