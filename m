Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FF444DE8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 00:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhKKXgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 18:36:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:32436 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231918AbhKKXgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 18:36:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="319240352"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="gz'50?scan'50,208,50";a="319240352"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 15:34:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="gz'50?scan'50,208,50";a="670459801"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Nov 2021 15:34:00 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mlJZv-000HFc-QO; Thu, 11 Nov 2021 23:33:59 +0000
Date:   Fri, 12 Nov 2021 07:33:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, "Paul E . McKenney" <paulmck@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by
 slow console devices
Message-ID: <202111120754.dm5kfUKt-lkp@intel.com>
References: <20211111195904.618253-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20211111195904.618253-2-wander@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wander,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.15 next-20211111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Wander-Lairson-Costa/printk-suppress-rcu-stall-warnings-caused-by-slow/20211112-040059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git debe436e77c72fcee804fb867f275e6d31aa999c
config: csky-defconfig (attached as .config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bb0661fcac8e6a708539fe465c8ad7f74ca920fa
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Wander-Lairson-Costa/printk-suppress-rcu-stall-warnings-caused-by-slow/20211112-040059
        git checkout bb0661fcac8e6a708539fe465c8ad7f74ca920fa
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: kernel/printk/printk.o: in function `console_unlock':
   printk.c:(.text+0x1bf4): undefined reference to `rcu_cpu_stall_suppress'
>> csky-linux-ld: printk.c:(.text+0x1d78): undefined reference to `rcu_cpu_stall_suppress'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--XsQoSWH+UP9D9v3l
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--XsQoSWH+UP9D9v3l--
