Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3713E2953
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbhHFLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:18:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:4615 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242720AbhHFLSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:18:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="211248743"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="211248743"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 04:18:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="420700416"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 04:18:12 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mBxrZ-005o8h-7h; Fri, 06 Aug 2021 14:18:05 +0300
Date:   Fri, 6 Aug 2021 14:18:05 +0300
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
Message-ID: <YQ0abcsiQBr7y0sT@smile.fi.intel.com>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-8-john.ogness@linutronix.de>
 <YQlMZT1Isc1zS9A9@smile.fi.intel.com>
 <87tuk2j0yf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuk2j0yf.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 01:02:40PM +0206, John Ogness wrote:
> On 2021-08-03, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> >> +			if (!(con->flags & CON_ENABLED))	\
> >> +				continue;			\
> >
> > What about
> >
> > #define console_is_enabled(con)		(!!(con->flags & CON_ENABLED))
> >
> > or inliner equivalent
> >
> > static inline bool console_is_enabled(struct console *con)
> > {
> > 	return !!(con->flags & CON_ENABLED);
> > }
> 
> Generally kernel code uses the console flags directly. A quick check for
> CON_ENABLED shows direct flag queries all over:
> 
> $ git grep -l -e 'flags.*& .*CON_ENABLED' | wc -c
> 16
> 
> Are you suggesting I replace this usage in all of these files? Or just
> the one macro in console.h for now? And since there are 6 more console
> flags, they should probably also have equivalent wrappers?

Introduce it now and reuse in new code, but somebody may clean up the rest in
the future.

-- 
With Best Regards,
Andy Shevchenko


