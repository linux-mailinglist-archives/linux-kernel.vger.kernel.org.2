Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D743604E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhDOIxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:53:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:59584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhDOIxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:53:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618476781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WXKLpoBi6rAmdX0EzavGiuPYe0Kt3AGJje04jsBjUDs=;
        b=XRcRbNYR3DMpEIasLAZr8INrdzaOGiT411ZwU0XialkYsLwTFVrZyACUJGkFu8xAMgQdcI
        yqKFVZFVIrj7ZH1oG6OPvIJZeHcxlXUB66q9TUp63x/rNGU8HlWAmmZbO5idv7YdQgOM6E
        rUHKq1dNiwk/vyqrMuXvVcxtEeSR4mU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 404FEB1F7;
        Thu, 15 Apr 2021 08:53:01 +0000 (UTC)
Date:   Thu, 15 Apr 2021 10:53:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 05/13] module: Add printk formats to add module build
 ID to stacktraces
Message-ID: <YHf+7AaMLk3YC/G6@alley>
References: <20210410015300.3764485-1-swboyd@chromium.org>
 <20210410015300.3764485-6-swboyd@chromium.org>
 <YHWyOhYZuLsbt2gB@alley>
 <161835466995.3764895.13268854960596303989@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161835466995.3764895.13268854960596303989@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-04-13 15:57:49, Stephen Boyd wrote:
> Quoting Petr Mladek (2021-04-13 08:01:14)
> > On Fri 2021-04-09 18:52:52, Stephen Boyd wrote:
> > > Let's make kernel stacktraces easier to identify by including the build
> > > ID[1] of a module if the stacktrace is printing a symbol from a module.
> > > This makes it simpler for developers to locate a kernel module's full
> > > debuginfo for a particular stacktrace. Combined with
> > > scripts/decode_stracktrace.sh, a developer can download the matching
> > > debuginfo from a debuginfod[2] server and find the exact file and line
> > > number for the functions plus offsets in a stacktrace that match the
> > > module. This is especially useful for pstore crash debugging where the
> > > kernel crashes are recorded in something like console-ramoops and the
> > > recovery kernel/modules are different or the debuginfo doesn't exist on
> > > the device due to space concerns (the debuginfo can be too large for
> > > space limited devices).
> > > 
> > > diff --git a/include/linux/module.h b/include/linux/module.h
> > > index 59f094fa6f74..4bf869f6c944 100644
> > > --- a/include/linux/module.h
> > > +++ b/include/linux/module.h
> > > @@ -11,6 +11,7 @@
> > >  
> > >  #include <linux/list.h>
> > >  #include <linux/stat.h>
> > > +#include <linux/buildid.h>
> > >  #include <linux/compiler.h>
> > >  #include <linux/cache.h>
> > >  #include <linux/kmod.h>
> > > @@ -367,6 +368,9 @@ struct module {
> > >       /* Unique handle for this module */
> > >       char name[MODULE_NAME_LEN];
> > >  
> > > +     /* Module build ID */
> > > +     unsigned char build_id[BUILD_ID_SIZE_MAX];
> > 
> > Do we want to initialize/store the ID even when
> > CONFIG_STACKTRACE_BUILD_ID is disabled and nobody would
> > use it?
> > 
> > Most struct module members are added only when the related feature
> > is enabled.
> > 
> > I am not sure how it would complicate the code. It is possible
> > that it is not worth it. Well, I could imagine that the API
> > will always pass the buildid parameter and
> > module_address_lookup() might do something like
> > 
> > #ifndef CONFIG_STACKTRACE_BUILD_ID
> > static char empty_build_id[BUILD_ID_SIZE_MAX];
> > #endif
> > 
> >                 if (modbuildid) {
> >                         if (IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID))
> >                                 *modbuildid = mod->build_id;
> >                         else
> >                                 *modbuildid = empty_build_id;
> > 
> > IMHO, this is primary a call for Jessica as the module code maintainer.
> > 
> > Otherwise, I am fine with this patch. And it works as expected.
> > 
> 
> Does declaring mod->build_id as zero length work well enough?

It might be fine because it would actually never get displayed.
But yeah, it is kind of hack. The idea was to avoid too many
#ifdefs in the code.

I think that it is Jessica's call what she would prefer.

Best Regards,
Petr
