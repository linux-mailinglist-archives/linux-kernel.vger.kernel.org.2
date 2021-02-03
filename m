Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A3530DC12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhBCOAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:00:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:48050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232305AbhBCN77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:59:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612360751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFw21ASMuDpc7Rgdrqrf92Q6nYjLSIOVBJujA1uPqoc=;
        b=aYdqsq9QucoRGvw9hVYb62QTWZzG2XSpETdLsOs1Nsa2ntfi5EJ5sYDgV5Ro7FyFlI90X1
        RFG20ggJiveDKyBvKPLPlcwqgYzXVVZnT68J/7Kf2AvZBDpHe8Z20t8ipS3eKvzvsvGoFZ
        rKvShLmpcRrkl7yRewFJfZFw0Fsjj2U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EC2DACB0;
        Wed,  3 Feb 2021 13:59:11 +0000 (UTC)
Date:   Wed, 3 Feb 2021 14:59:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        kbuild-all@lists.01.org
Subject: Re: [PATCH 3/3] printk: move CONSOLE_EXT_LOG_MAX to
 kernel/printk/printk.c
Message-ID: <YBqsLniYEuFGICGV@alley>
References: <20210202070218.856847-3-masahiroy@kernel.org>
 <202102022035.7AbsG6ge-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102022035.7AbsG6ge-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-02 20:29:31, kernel test robot wrote:
> Hi Masahiro,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linux/master]
> [also build test ERROR on efi/next tty/tty-testing tip/x86/core v5.11-rc6 next-20210125]
> [cannot apply to pmladek/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/printk-use-CONFIG_CONSOLE_LOGLEVEL_-directly/20210202-151411
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2ab38c17aac10bf55ab3efde4c4db3893d8691d2
> config: alpha-randconfig-s031-20210202 (attached as .config)
> compiler: alpha-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-215-g0fb77bb6-dirty
>         # https://github.com/0day-ci/linux/commit/35d219bfad62e5008215f996430732aeb52c0652
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Masahiro-Yamada/printk-use-CONFIG_CONSOLE_LOGLEVEL_-directly/20210202-151411
>         git checkout 35d219bfad62e5008215f996430732aeb52c0652
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/printk/printk.c:61:
>    kernel/printk/internal.h:59:20: warning: no previous prototype for 'vprintk_func' [-Wmissing-prototypes]
>       59 | __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
>          |                    ^~~~~~~~~~~~
>    kernel/printk/printk.c:175:5: warning: no previous prototype for 'devkmsg_sysctl_set_loglvl' [-Wmissing-prototypes]
>      175 | int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/printk/printk.c: In function 'console_unlock':
> >> kernel/printk/printk.c:2469:23: error: 'CONSOLE_EXT_LOG_MAX' undeclared (first use in this function)
>     2469 |  static char ext_text[CONSOLE_EXT_LOG_MAX];
>          |                       ^~~~~~~~~~~~~~~~~~~

This code is called also when CONFIG_PRINTK is not enabled.

It is a historic mess. console_lock() is used to synchronize also some
other stuff, especially in tty code, even when printk logging is
not enabled.

It should work to define:

#define CONSOLE_EXT_LOG_MAX 0

in the middle of printk.c, search for:

#else /* CONFIG_PRINTK */

Best Regards,
Petr
