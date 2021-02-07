Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE853127D2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 23:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBGWWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 17:22:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:60479 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBGWWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 17:22:30 -0500
IronPort-SDR: oSNVaDrj04MQPKgwbzvCxj6TXR5pLMejGSTQBH48chbQYXM/wUeAGGsd0yTFFl3c3tBpyQD+M0
 M/XjRCiiKM7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="245706630"
X-IronPort-AV: E=Sophos;i="5.81,160,1610438400"; 
   d="gz'50?scan'50,208,50";a="245706630"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 14:21:49 -0800
IronPort-SDR: v4FJgkFw8lPS4El5zaFkSgdFOJZHnsq73LwNIr+v02OrmyRbQTDs6SKSn8EDmq6i497LotAkoV
 JQbDD6GiMl9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,160,1610438400"; 
   d="gz'50?scan'50,208,50";a="584918307"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Feb 2021 14:21:46 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l8sR7-00037q-TI; Sun, 07 Feb 2021 22:21:45 +0000
Date:   Mon, 8 Feb 2021 06:21:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel-team@fb.com
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <202102080635.uqNxyQZp-lkp@intel.com>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <YBwU0G+P0vb9wTwm@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chris,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jeyu/modules-next]
[also build test ERROR on linux/master soc/for-next openrisc/for-next powerpc/next asm-generic/master linus/master v5.11-rc6 next-20210125]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chris-Down/printk-Userspace-format-enumeration-support/20210204-234240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/08a6039db35c32e39de288d58d0362013fdfb387
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chris-Down/printk-Userspace-format-enumeration-support/20210204-234240
        git checkout 08a6039db35c32e39de288d58d0362013fdfb387
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/um/drivers/xterm.o: in function `xterm_open':
>> xterm.c:(.text+0x16b): undefined reference to `printk'
>> /usr/bin/ld: xterm.c:(.text+0x1a8): undefined reference to `printk'
   /usr/bin/ld: xterm.c:(.text+0x1f4): undefined reference to `printk'
   /usr/bin/ld: xterm.c:(.text+0x25e): undefined reference to `printk'
   /usr/bin/ld: xterm.c:(.text+0x2b5): undefined reference to `printk'
   /usr/bin/ld: arch/um/drivers/xterm.o:xterm.c:(.text+0x31c): more undefined references to `printk' follow
   collect2: error: ld returned 1 exit status

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--4Ckj6UjgE2iN1+kY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ITjTMYYAAA==

--4Ckj6UjgE2iN1+kY--
