Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064ED4507D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhKOPHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:07:52 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:42685 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhKOPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:07:27 -0500
Received: by mail-qk1-f171.google.com with SMTP id g28so12689346qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 07:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ywlZ6ivBrVweqme2JRtHcgtd2wHVvwsW9gDLxTi7uU=;
        b=5WDPSAZQVZf3jW+wYgaD/vL23exD+Uf2u1F9FxDf87lh9nCC1lir+tdz4O3x4wMbAB
         XdsfKX9YiEFg179NyGW6vMHLStew1aMEwjg94vtRzoQg1zIYJkomkxVgi7IMrcUQzIQn
         R4D3XEQWAXWG0zjxj1h0M2LAtVEa870twYbI9ugB0hU6DHU9R8nFmavHP3320riYfYfL
         M0txhToZLr5euEFDNQGo0e+WzVWnqrxdAUK3nMKVRH+qioowKoz8rxsJ0dobnOOvG4wg
         JydslcpdcBzO/r5c0MlTngxlepftw6Ds9Go3ZFirnpHw4RYyGr75WEQkjbjOVq5INbTu
         5bCA==
X-Gm-Message-State: AOAM532wZmm3RSZz/7FVpvLedGvQ06cfzpjqhrDU3bjojyoK7bEN7qhr
        19JJO5xEzgk1RXXU3Itt7rM=
X-Google-Smtp-Source: ABdhPJyjlP71OZgSnFmrs9IPwOeuByfzPFgePjHyk+E3t/coLIU2EX0N6f4TTrKVMRHn/LPNGadwyg==
X-Received: by 2002:a05:620a:4622:: with SMTP id br34mr29018631qkb.504.1636988670389;
        Mon, 15 Nov 2021 07:04:30 -0800 (PST)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id g21sm6520756qtb.62.2021.11.15.07.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 07:04:29 -0800 (PST)
Date:   Mon, 15 Nov 2021 10:04:27 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] printk: Remove printk.h inclusion in percpu.h
Message-ID: <YZJ2++H9u+9WGTqw@fedora>
References: <20211112140749.80042-1-andriy.shevchenko@linux.intel.com>
 <YY6vV2zUTdH5SNt5@fedora>
 <YZIs1FvxA0hKylNd@alley>
 <YZI4i5hsgD4pDjoQ@smile.fi.intel.com>
 <YZJnRyqtDzfmI0Cf@alley>
 <YZJv3CeClGa+jsmQ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZJv3CeClGa+jsmQ@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 03:34:04PM +0100, Petr Mladek wrote:
> On Mon 2021-11-15 14:57:30, Petr Mladek wrote:
> > On Mon 2021-11-15 12:38:03, Andy Shevchenko wrote:
> > > On Mon, Nov 15, 2021 at 10:48:04AM +0100, Petr Mladek wrote:
> > > > On Fri 2021-11-12 13:15:51, Dennis Zhou wrote:
> > > > > On Fri, Nov 12, 2021 at 04:07:49PM +0200, Andy Shevchenko wrote:
> > > > > > After the commit 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> > > > > > in NMI") the printk.h is not needed anymore in percpu.h.
> > > > > > 
> > > > > > Moreover `make headerdep` complains (an excerpt)
> > > > > > 
> > > > > > In file included from linux/printk.h,
> > > > > >                  from linux/dynamic_debug.h:188
> > > > > >                  from linux/printk.h:559 <-- here
> > > > > >                  from linux/percpu.h:9
> > > > > >                  from linux/idr.h:17
> > > > > > include/net/9p/client.h:13: warning: recursive header inclusion
> > > > > > 
> > > > > > Yeah, it's not a root cause of this, but removing will help to reduce
> > > > > > the noise.
> > > > > > 
> > > > > > Fixes: 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> > > > > > in NMI")
> > > > 
> > > > Yup, the include was there because of printk_func_t definition that
> > > > was removed by the above commit.
> > > > 
> > > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > > 
> > > > > Hey Andrew, it doesn't seem like I have anything big coming through
> > > > > percpu, do you mind taking this. I might have some stuff due to sh, but
> > > > > I'm still working on that with them.
> > > > 
> > > > I assume that either Andrew or Dennis will take this patch.
> > > 
> > > I assumed you take it, that's why I haven't Cc'ed Andrew in the first place,
> > > but it seems you have a consensus with Dennis that Andrew is the best
> > > maintainer to take this. So, I'll send v2 with tags and Cc to him.
> > 
> > No problem, I am going to take it, in a hour or so. I did not want to
> > make chaos when Denis asked Andrew. But it is not worth resending the patch.
> 
> The patch is comitted in printk/linux.git, branch for-5.16-fixup.
> 
> I am going to add it into pull request for 5.16-rc2 with another fix.
> 
> Best Regards,
> Petr

Thanks Petr!

In general I would take it, it just depends on other circumstances such
as if I'm carrying anything or if there is any other bigger issues with
other mm. Right now I'm dealing with mm as a fix for hotplug in percpu
has been pulled and I'm not terribly happy about it.

I appreciate being looped in and made aware of the changes. Thank you
Andy and Petr.

Thanks,
Dennis
