Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E709F3CCCBD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhGSDm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:42:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:40532 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233720AbhGSDm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:42:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="191269692"
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="gz'50?scan'50,208,50";a="191269692"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2021 20:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="gz'50?scan'50,208,50";a="430498288"
Received: from lkp-server01.sh.intel.com (HELO a467b34d8c10) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2021 20:39:56 -0700
Received: from kbuild by a467b34d8c10 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5K8J-0000Y3-UJ; Mon, 19 Jul 2021 03:39:55 +0000
Date:   Mon, 19 Jul 2021 11:39:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [linux-stable-rc:linux-4.4.y 1449/1774]
 drivers/input/joydev.c:485:16: warning: comparison of integer expressions of
 different signedness: 'int' and 'long unsigned int'
Message-ID: <202107191112.AwqoFW63-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
head:   38c92ba3580f0d00e57a55caf8f880aa1a0f2a50
commit: ade5180681d778d36b569ad35cc175ab22196c5f [1449/1774] Input: joydev - prevent potential read overflow in ioctl
config: h8300-randconfig-r031-20210718 (attached as .config)
compiler: h8300-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=ade5180681d778d36b569ad35cc175ab22196c5f
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.4.y
        git checkout ade5180681d778d36b569ad35cc175ab22196c5f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/h8300/include/generated/asm/uaccess.h:1,
                    from include/linux/poll.h:11,
                    from drivers/input/joydev.c:27:
   include/asm-generic/uaccess.h: In function '__put_user_fn':
   include/asm-generic/uaccess.h:178:16: warning: operand of '?:' changes signedness from 'int' to 'size_t' {aka 'long unsigned int'} due to unsignedness of other operand [-Wsign-compare]
     178 |  return size ? -EFAULT : size;
   drivers/input/joydev.c: In function 'joydev_handle_JSIOCSAXMAP':
   drivers/input/joydev.c:451:16: warning: comparison of integer expressions of different signedness: 'int' and 'size_t' {aka 'long unsigned int'} [-Wsign-compare]
     451 |  for (i = 0; i < len && i < joydev->nabs; i++) {
         |                ^
   drivers/input/joydev.c: In function 'joydev_handle_JSIOCSBTNMAP':
>> drivers/input/joydev.c:485:16: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
     485 |  for (i = 0; i < (len / 2) && i < joydev->nkey; i++) {
         |                ^
   drivers/input/joydev.c: In function 'joydev_ioctl_common':
   drivers/input/joydev.c:566:52: warning: operand of '?:' changes signedness from 'int' to 'size_t' {aka 'long unsigned int'} due to unsignedness of other operand [-Wsign-compare]
     566 |   return copy_to_user(argp, joydev->abspam, len) ? -EFAULT : len;
   drivers/input/joydev.c:573:52: warning: operand of '?:' changes signedness from 'int' to 'size_t' {aka 'long unsigned int'} due to unsignedness of other operand [-Wsign-compare]
     573 |   return copy_to_user(argp, joydev->keypam, len) ? -EFAULT : len;
   drivers/input/joydev.c:581:42: warning: operand of '?:' changes signedness from 'int' to 'size_t' {aka 'long unsigned int'} due to unsignedness of other operand [-Wsign-compare]
     581 |   return copy_to_user(argp, name, len) ? -EFAULT : len;


vim +485 drivers/input/joydev.c

   467	
   468	static int joydev_handle_JSIOCSBTNMAP(struct joydev *joydev,
   469					      void __user *argp, size_t len)
   470	{
   471		__u16 *keypam;
   472		int i;
   473		int retval = 0;
   474	
   475		if (len % sizeof(*keypam))
   476			return -EINVAL;
   477	
   478		len = min(len, sizeof(joydev->keypam));
   479	
   480		/* Validate the map. */
   481		keypam = memdup_user(argp, len);
   482		if (IS_ERR(keypam))
   483			return PTR_ERR(keypam);
   484	
 > 485		for (i = 0; i < (len / 2) && i < joydev->nkey; i++) {
   486			if (keypam[i] > KEY_MAX || keypam[i] < BTN_MISC) {
   487				retval = -EINVAL;
   488				goto out;
   489			}
   490		}
   491	
   492		memcpy(joydev->keypam, keypam, len);
   493	
   494		for (i = 0; i < joydev->nkey; i++)
   495			joydev->keymap[keypam[i] - BTN_MISC] = i;
   496	
   497	 out:
   498		kfree(keypam);
   499		return retval;
   500	}
   501	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--4Ckj6UjgE2iN1+kY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--4Ckj6UjgE2iN1+kY--
