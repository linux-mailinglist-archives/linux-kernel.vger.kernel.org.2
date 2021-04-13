Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E235E277
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbhDMPQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:16:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:33142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhDMPQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:16:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618326981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCBAk+URTFULVOvwnFTivKjGG4vL7/tzhoAqlGX41HQ=;
        b=FNFL457DJGyIhbJyS9rH5zvbZeL2hv9u22QMP280IKriTLDiiPrDQ8vevrk/0aa/MVU01k
        xL6n9kArPlzBOyNjb+LB8nPLuyUMmqAdNpgR41COB73Ly7l4O74sAat2/u+VLg6gcV6z0h
        LJOFwJ+tEYJ820YkyfYRRMqQG8eb1ME=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 273DCB138;
        Tue, 13 Apr 2021 15:16:21 +0000 (UTC)
Date:   Tue, 13 Apr 2021 17:16:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 05/13] module: Add printk formats to add module build
 ID to stacktraces
Message-ID: <YHW1xBvOeHrAHWkK@alley>
References: <20210410015300.3764485-1-swboyd@chromium.org>
 <20210410015300.3764485-6-swboyd@chromium.org>
 <YHQ1yqVkweZeN5+1@smile.fi.intel.com>
 <161825574550.3764895.4387100574176584209@swboyd.mtv.corp.google.com>
 <YHV4369VJAGpfW/c@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHV4369VJAGpfW/c@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-04-13 13:56:31, Andy Shevchenko wrote:
> On Mon, Apr 12, 2021 at 12:29:05PM -0700, Stephen Boyd wrote:
> > Quoting Andy Shevchenko (2021-04-12 04:58:02)
> > > On Fri, Apr 09, 2021 at 06:52:52PM -0700, Stephen Boyd wrote:
> > > > Let's make kernel stacktraces easier to identify by including the build
> > > > ID[1] of a module if the stacktrace is printing a symbol from a module.
> > > > This makes it simpler for developers to locate a kernel module's full
> > > > debuginfo for a particular stacktrace. Combined with
> > > > scripts/decode_stracktrace.sh, a developer can download the matching
> > > > debuginfo from a debuginfod[2] server and find the exact file and line
> > > > number for the functions plus offsets in a stacktrace that match the
> > > > module. This is especially useful for pstore crash debugging where the
> > > > kernel crashes are recorded in something like console-ramoops and the
> > > > recovery kernel/modules are different or the debuginfo doesn't exist on
> > > > the device due to space concerns (the debuginfo can be too large for
> > > > space limited devices).
> > > > 
> > > > Originally, I put this on the %pS format, but that was quickly rejected
> > > > given that %pS is used in other places such as ftrace where build IDs
> > > > aren't meaningful. There was some discussions on the list to put every
> > > > module build ID into the "Modules linked in:" section of the stacktrace
> > > > message but that quickly becomes very hard to read once you have more
> > > > than three or four modules linked in. It also provides too much
> > > > information when we don't expect each module to be traversed in a
> > > > stacktrace. Having the build ID for modules that aren't important just
> > > > makes things messy. Splitting it to multiple lines for each module
> > > > quickly explodes the number of lines printed in an oops too, possibly
> > > > wrapping the warning off the console. And finally, trying to stash away
> > > > each module used in a callstack to provide the ID of each symbol printed
> > > > is cumbersome and would require changes to each architecture to stash
> > > > away modules and return their build IDs once unwinding has completed.
> > > > 
> > > > Instead, we opt for the simpler approach of introducing new printk
> > > > formats '%pS[R]b' for "pointer symbolic backtrace with module build ID"
> > > > and '%pBb' for "pointer backtrace with module build ID" and then
> > > > updating the few places in the architecture layer where the stacktrace
> > > > is printed to use this new format.
> > > > 
> > > > Example:
> > > 
> > > Can you trim a bit the example, so we will see only important lines.
> > > In such case you may provide "before" and "after" variants.
> > > 
> > > ...
> > > 
> > > > -     if (modname)
> > > > -             len += sprintf(buffer + len, " [%s]", modname);
> > > > +     if (modname) {
> > > > +             len += sprintf(buffer + len, " [%s", modname);
> > > 
> > > > +             /* build ID should match length of sprintf below */
> > > > +             BUILD_BUG_ON(BUILD_ID_SIZE_MAX != 20);
> > > 
> > > First of all, why not static_assert() defined near to the actual macro?
> > 
> > Which macro? BUILD_ID_SIZE_MAX?
> 
> Yes.
> 
> > I tried static_assert() and it didn't
> > work for me but maybe I missed something.

I guess that you wanted to use it inside macro definition:

#define VMCOREINFO_BUILD_ID(value) \
	static_assert(ARRAY_SIZE(value) == BUILD_ID_SIZE_MAX); \
	vmcoreinfo_append_str("BUILD-ID=%20phN\n", value)

Instead, you should do it outside the macro:

static_assert(ARRAY_SIZE(value) == BUILD_ID_SIZE_MAX);
#define VMCOREINFO_BUILD_ID(value) \
	vmcoreinfo_append_str("BUILD-ID=%20phN\n", value)

> Sounds weird. static_assert() is a good one. Check, for example, lib/vsprintf.c
> on how to use it.
> 
> > Why is static_assert()
> > preferred?

I guess that it is because it is enough and more efficient for
checks of constant values (no computation of the value).

> Because it's cleaner way to achieve it and as a bonus it can be put outside of
> the functions (be in the header or so).
> 
> > > > +             if (IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) && add_buildid && buildid)
> > > > +                     len += sprintf(buffer + len, " %20phN", buildid);
> > > 
> > >                         len += sprintf(buffer + len, " %*phN", BUILD_ID_SIZE_MAX, buildid);
> > > 
> > 
> > Are you suggesting to use sprintf format here so that the size is part
> > of the printf? Sounds good to me. Thanks.
> 
> I prefer %20phN when the size is carved in stone (for example by
> specification), but if you are really expecting that it may be
> changed in the future, use variadic approach as I showed above.

I would consider this written in stone (last famous words ;-) and use
%20phN with the static_assert().

Best Regards,
Petr
