Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02093DEF9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhHCOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:02:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:61807 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236370AbhHCOCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:02:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="213423076"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="213423076"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 07:02:24 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="502403161"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 07:02:20 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mAuzl-004kRl-2r; Tue, 03 Aug 2021 17:02:13 +0300
Date:   Tue, 3 Aug 2021 17:02:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Changbin Du <changbin.du@intel.com>
Subject: Re: [PATCH printk v1 07/10] console: add write_atomic interface
Message-ID: <YQlMZT1Isc1zS9A9@smile.fi.intel.com>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803131301.5588-8-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 03:18:58PM +0206, John Ogness wrote:
> Add a write_atomic() callback to the console. This is an optional
> function for console drivers. The function must be atomic (including
> NMI safe) for writing to the console.
> 
> Console drivers implementing write_atomic() must select the new
> HAVE_ATOMIC_CONSOLE Kconfig option.
> 
> Console drivers must still implement the write() callback. The
> write_atomic() callback will only be used in special situations,
> such as when the kernel panics.
> 
> Creating an NMI safe write_atomic() that must synchronize with
> write() requires a careful implementation of the console driver. To
> aid with the implementation, a set of console_atomic_*() functions
> are provided:
> 
>     void console_atomic_lock(unsigned long flags);
>     void console_atomic_unlock(unsigned long flags);
> 
> These functions synchronize using the printk cpulock and disable
> hardware interrupts.
> 
> In order to increase effectiveness, the printk cpulock functions are
> also made more aggressive and now keep interrupts disabled while
> spinning.
> 
> CPUs holding the printk cpulock must not spin on any other lock.
> Therefore can_use_console() will now return false if the printk
> cpulock is held in order to avoid calling into console driver code,
> while typically contain spinlocks.
> 
> Likewise, console_trylock_spinning() will fail rather than attempt
> to acquire the console_sem (which includes a spinlock in its

...

>  #include <linux/atomic.h>
>  #include <linux/types.h>
> +#include <linux/printk.h>

Ordered?

...

> +			if (!(con->flags & CON_ENABLED))	\
> +				continue;			\

What about

#define console_is_enabled(con)		(!!(con->flags & CON_ENABLED))

or inliner equivalent

static inline bool console_is_enabled(struct console *con)
{
	return !!(con->flags & CON_ENABLED);
}

?

-- 
With Best Regards,
Andy Shevchenko


