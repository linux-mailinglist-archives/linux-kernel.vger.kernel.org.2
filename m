Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B345072A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhKOOjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:39:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55934 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhKOOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:37:04 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2F6E321709;
        Mon, 15 Nov 2021 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636986846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wyaeJuZiM/tXx7GlGx3YKQgNoTfHJZZRTuvL5Q2cyHQ=;
        b=qdTkbTYHwKXvcIUKvhXThInRP0ugFSkn/aJ6OkcCgKEUTfM3jdFR3DO8z5bJ9UfSBSKTVc
        bmZ3vF5BHz/zzJf4y4ahISQpP7MDSET3PWO9hTHq1eDhr+QgNz7Ddk574FxJP8Q1Vu/Ye/
        GgR0d7jlLGqx2xsBxbS8dcDffaqaO/g=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EF84DA3B85;
        Mon, 15 Nov 2021 14:34:05 +0000 (UTC)
Date:   Mon, 15 Nov 2021 15:34:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] printk: Remove printk.h inclusion in percpu.h
Message-ID: <YZJv3CeClGa+jsmQ@alley>
References: <20211112140749.80042-1-andriy.shevchenko@linux.intel.com>
 <YY6vV2zUTdH5SNt5@fedora>
 <YZIs1FvxA0hKylNd@alley>
 <YZI4i5hsgD4pDjoQ@smile.fi.intel.com>
 <YZJnRyqtDzfmI0Cf@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZJnRyqtDzfmI0Cf@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-11-15 14:57:30, Petr Mladek wrote:
> On Mon 2021-11-15 12:38:03, Andy Shevchenko wrote:
> > On Mon, Nov 15, 2021 at 10:48:04AM +0100, Petr Mladek wrote:
> > > On Fri 2021-11-12 13:15:51, Dennis Zhou wrote:
> > > > On Fri, Nov 12, 2021 at 04:07:49PM +0200, Andy Shevchenko wrote:
> > > > > After the commit 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> > > > > in NMI") the printk.h is not needed anymore in percpu.h.
> > > > > 
> > > > > Moreover `make headerdep` complains (an excerpt)
> > > > > 
> > > > > In file included from linux/printk.h,
> > > > >                  from linux/dynamic_debug.h:188
> > > > >                  from linux/printk.h:559 <-- here
> > > > >                  from linux/percpu.h:9
> > > > >                  from linux/idr.h:17
> > > > > include/net/9p/client.h:13: warning: recursive header inclusion
> > > > > 
> > > > > Yeah, it's not a root cause of this, but removing will help to reduce
> > > > > the noise.
> > > > > 
> > > > > Fixes: 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> > > > > in NMI")
> > > 
> > > Yup, the include was there because of printk_func_t definition that
> > > was removed by the above commit.
> > > 
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > 
> > > > Hey Andrew, it doesn't seem like I have anything big coming through
> > > > percpu, do you mind taking this. I might have some stuff due to sh, but
> > > > I'm still working on that with them.
> > > 
> > > I assume that either Andrew or Dennis will take this patch.
> > 
> > I assumed you take it, that's why I haven't Cc'ed Andrew in the first place,
> > but it seems you have a consensus with Dennis that Andrew is the best
> > maintainer to take this. So, I'll send v2 with tags and Cc to him.
> 
> No problem, I am going to take it, in a hour or so. I did not want to
> make chaos when Denis asked Andrew. But it is not worth resending the patch.

The patch is comitted in printk/linux.git, branch for-5.16-fixup.

I am going to add it into pull request for 5.16-rc2 with another fix.

Best Regards,
Petr
