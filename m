Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7344739F817
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhFHNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:50:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38906 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhFHNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:50:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 56F4F219B0;
        Tue,  8 Jun 2021 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623160103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hb0+q30Gnp7DrPWOKT7XlTLbXFkLxN7BDKSfDeblI9U=;
        b=rSqDwP5fROQpQw3tt1jtvGahQY7+vrm4nVZD6ybGz0s6PYAx5CYSr9EdXAsJWgaRYubcxx
        L8vYL1NQsJ83CREDRrBNgPjcQ1MmEmJRh/04lrFQyhWcrZjGY0UJ2fLkOGG6b5UC/VS6Jl
        G842nrMxQVa1BGRbE+PAjgVONTvdR+0=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EBA28A3B83;
        Tue,  8 Jun 2021 13:48:22 +0000 (UTC)
Date:   Tue, 8 Jun 2021 15:48:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     kernel test robot <lkp@intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>, kbuild-all@lists.01.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH next v2 1/2] dump_stack: move cpu lock to printk.c
Message-ID: <YL91JlCUiD6C05Q2@alley>
References: <20210607200232.22211-2-john.ogness@linutronix.de>
 <202106081055.UgUlUS1Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106081055.UgUlUS1Z-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-08 10:43:46, kernel test robot wrote:
> Hi John,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on next-20210607]
> 
> url:    https://github.com/0day-ci/linux/commits/John-Ogness/introduce-printk-cpu-lock/20210608-040454
> base:    7f09e895a7f3e0af63bf9ec6c7c22893ec7e6c8e
> config: mips-randconfig-r036-20210607 (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/136bcc2980e636b2ae156ca63fbe95c713e44c1b
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review John-Ogness/introduce-printk-cpu-lock/20210608-040454
>         git checkout 136bcc2980e636b2ae156ca63fbe95c713e44c1b
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    lib/dump_stack.c: In function 'dump_stack_lvl':
> >> lib/dump_stack.c:107:2: warning: 'lock_flag' is used uninitialized in this function [-Wuninitialized]
>      107 |  printk_cpu_unlock_irqrestore(lock_flag, irq_flags);
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Interesting. I am curious that it does not complain also about
irq_flags. But it is possible the it reports only the first problem.

Anyway, we will likely need to do some trickery via #define to tell
the compiler that the value is set. I mean to do similar thing as:

#define raw_local_irq_save(flags)			\
	do {						\
		typecheck(unsigned long, flags);	\
		flags = arch_local_irq_save();		\
	} while (0)


In our case, it might look like:

#define printk_cpu_lock_irqsave(lock_nested, irq_flags)		\
	do {							\
		local_irq_save(irq_flags);			\
		typecheck(bool, lock_nested);			\
		lock_nested = __printk_cpu_lock(irq_flags);	\
	} while (0)


then we would need to do in __prink_cpu_lock(unsigned long irq_flags)


	} else {
		local_irq_restore(irq_flags);

		/*
		 * Wait for the lock to release before jumping to cmpxchg()
		 * in order to mitigate the thundering herd problem.
		 */
		do {
			cpu_relax();
		} while (atomic_read(&printk_cpulock_owner) != -1);

		local_irq_save(irq_flags)
		goto retry;
	}

Best Regards,
Petr
