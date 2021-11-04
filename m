Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C318C445206
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 12:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKDLO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 07:14:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:40616 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhKDLO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 07:14:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231931074"
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="gz'50?scan'50,208,50";a="231931074"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 04:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="gz'50?scan'50,208,50";a="667853790"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2021 04:11:44 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1miaem-0006JY-4F; Thu, 04 Nov 2021 11:11:44 +0000
Date:   Thu, 4 Nov 2021 19:10:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     davidcomponentone@gmail.com, jdike@addtoit.com
Cc:     kbuild-all@lists.01.org, davidcomponentone@gmail.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, yang.guang5@zte.com.cn,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] um: use swap() to make code cleaner
Message-ID: <202111041905.SrTJwTW8-lkp@intel.com>
References: <20211104061609.1496503-1-yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20211104061609.1496503-1-yang.guang5@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rw-uml/linux-next]
[also build test ERROR on v5.15 next-20211104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/davidcomponentone-gmail-com/um-use-swap-to-make-code-cleaner/20211104-141655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/0daa3d13fe02d69f3d42d17d176edb0043136241
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review davidcomponentone-gmail-com/um-use-swap-to-make-code-cleaner/20211104-141655
        git checkout 0daa3d13fe02d69f3d42d17d176edb0043136241
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/um/os-Linux/sigio.c: In function 'write_sigio_thread':
>> arch/um/os-Linux/sigio.c:80:5: error: implicit declaration of function 'swap'; did you mean 'swab'? [-Werror=implicit-function-declaration]
      80 |     swap(current_poll, next_poll);
         |     ^~~~
         |     swab
   cc1: some warnings being treated as errors


vim +80 arch/um/os-Linux/sigio.c

    50	
    51	static int write_sigio_thread(void *unused)
    52	{
    53		struct pollfds *fds;
    54		struct pollfd *p;
    55		int i, n, respond_fd;
    56		char c;
    57	
    58		os_fix_helper_signals();
    59		fds = &current_poll;
    60		while (1) {
    61			n = poll(fds->poll, fds->used, -1);
    62			if (n < 0) {
    63				if (errno == EINTR)
    64					continue;
    65				printk(UM_KERN_ERR "write_sigio_thread : poll returned "
    66				       "%d, errno = %d\n", n, errno);
    67			}
    68			for (i = 0; i < fds->used; i++) {
    69				p = &fds->poll[i];
    70				if (p->revents == 0)
    71					continue;
    72				if (p->fd == sigio_private[1]) {
    73					CATCH_EINTR(n = read(sigio_private[1], &c,
    74							     sizeof(c)));
    75					if (n != sizeof(c))
    76						printk(UM_KERN_ERR
    77						       "write_sigio_thread : "
    78						       "read on socket failed, "
    79						       "err = %d\n", errno);
  > 80					swap(current_poll, next_poll);
    81					respond_fd = sigio_private[1];
    82				}
    83				else {
    84					respond_fd = write_sigio_fds[1];
    85					fds->used--;
    86					memmove(&fds->poll[i], &fds->poll[i + 1],
    87						(fds->used - i) * sizeof(*fds->poll));
    88				}
    89	
    90				CATCH_EINTR(n = write(respond_fd, &c, sizeof(c)));
    91				if (n != sizeof(c))
    92					printk(UM_KERN_ERR "write_sigio_thread : "
    93					       "write on socket failed, err = %d\n",
    94					       errno);
    95			}
    96		}
    97	
    98		return 0;
    99	}
   100	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tThc/1wpZn/ma/RB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
HxU3/7fAlgAA

--tThc/1wpZn/ma/RB--
