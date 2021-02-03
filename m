Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3444430D712
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhBCKKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhBCKKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:10:04 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7869AC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 02:09:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f16so4852360wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 02:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1uqjJSxQnbknlgfv18nfMi7XDivsav4kfCM1aA58KJM=;
        b=eVDcc+EhQQg7qLOGGKt1Mn74isgWTu4olg3+T3C8j4NDbE5HP7hU7FNEA5ZlY1210R
         poMcE3lZu9legm/0Fi3+gtTCSSroy6XOLFhE7YVCEC+bBx3jI76rjeoUJxOm/+kYm7fW
         rqjCSoLtJKFGV/j+OZ1FPceSO/RE76KHF0LMHPVtJcDTQ2KAOloHoFjkw3nFixYJZQIZ
         2ASNugSquQBUW98vmt4z4Zrwhh3cy+O4hVYPL+NLMyvK8ZDy5u1rDgdQMVhvorOjlDie
         LojozSkBtP1ob9jGGj2Bvicgpl0SR/F7aTR34Ywa2RK9GFNnDCAJ3mHgTyaWFzyQrJYt
         lllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1uqjJSxQnbknlgfv18nfMi7XDivsav4kfCM1aA58KJM=;
        b=BCcZiRkWTGtkY7m5EEKxZ+KU9zIQECFS+xSaUyIsQ3egc0dmcfl7CX/iXv0E45RTgY
         za5Vqax+iCAGG7ISK29Wetg/dOlgHKRDsRPzWemjtKEgFEJFhJM276DFkISaBCe50GUF
         R55Jd+ecScGGc+0xuET3DCS9P3/yXb9nSGIHKY1k2Ho0TxvYnR4s6Y7F4MFqZnO9Te3p
         C7+RZCarsRouVJ3M2B6sdibHiowb31lTHKpwrPNLDxXENK6a4ANkysG5MDj8lkYgZ+pk
         Rn5m/DrPIE9VJvJig+IApdK4gSdzPXrs4Ci9zyJhWsLYvVDGA1Eux8jA7uESTyg+JojE
         8Isg==
X-Gm-Message-State: AOAM533I8R7sPHLqHdiJvWxxh+3zd8e0EjtHmm7p2sN5SijhZ34rzlnS
        AcAYE4ZkO2z8KUhIbYRkxVUYRD0uAZG3Jw==
X-Google-Smtp-Source: ABdhPJwJPQadSdc/Rbl+Wi50mFdE5FigAkAx5hdNYeMjPJTZVaHJevUyoSTVQ1osCwB78Z44hk+3kQ==
X-Received: by 2002:a1c:dc83:: with SMTP id t125mr2056895wmg.154.1612346963151;
        Wed, 03 Feb 2021 02:09:23 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p18sm2039778wmc.31.2021.02.03.02.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 02:09:22 -0800 (PST)
Date:   Wed, 3 Feb 2021 10:09:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org,
        Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/21] clk: sunxi: clk-sun6i-ar100: Demote non-conformant
 kernel-doc header
Message-ID: <20210203100920.GB2329016@dell>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-13-lee.jones@linaro.org>
 <20210126155430.llxijnwf5i4z3end@gilmour>
 <20210126165459.GG4903@dell>
 <20210203092744.yfedaauyynzn537h@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210203092744.yfedaauyynzn537h@gilmour>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Feb 2021, Maxime Ripard wrote:

> On Tue, Jan 26, 2021 at 04:54:59PM +0000, Lee Jones wrote:
> > On Tue, 26 Jan 2021, Maxime Ripard wrote:
> > 
> > > On Tue, Jan 26, 2021 at 12:45:31PM +0000, Lee Jones wrote:
> > > > Fixes the following W=1 kernel build warning(s):
> > > > 
> > > >  drivers/clk/sunxi/clk-sun6i-ar100.c:26: warning: Function parameter or member 'req' not described in 'sun6i_get_ar100_factors'
> > > > 
> > > > Cc: "Emilio López" <emilio@elopez.com.ar>
> > > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > > Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > > > Cc: linux-clk@vger.kernel.org
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/clk/sunxi/clk-sun6i-ar100.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-sun6i-ar100.c
> > > > index e1b7d0929cf7f..54babc2b4b9ee 100644
> > > > --- a/drivers/clk/sunxi/clk-sun6i-ar100.c
> > > > +++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
> > > > @@ -16,7 +16,7 @@
> > > >  
> > > >  #include "clk-factors.h"
> > > >  
> > > > -/**
> > > > +/*
> > > >   * sun6i_get_ar100_factors - Calculates factors p, m for AR100
> > > >   *
> > > >   * AR100 rate is calculated as follows
> > > 
> > > This is the sixth patch doing the exact same thing over the files in
> > > that folder you sent. Please fix all the occurences at once
> > 
> > No.  That would make the whole clean-up process 10x harder than it
> > already is
> > 
> > Before starting this endeavour there were 18,000+ warnings spread over
> > 100's of files and 10's of subsystems that needed addressing (only a
> > couple thousand left now thankfully).  Some issues vastly different,
> > some duplicated (much too much copy/pasting going which made things
> > very frustrating at times).
> > 
> > Anyway, in order to work though them all gracefully and in a sensible
> > time-frame I had to come up with a workable plan.  Each subsystem is
> > compiled separately and a script attempts to take out duplicate
> > warnings and takes me through the build-log one file at a time.  Once
> > all of the warnings are fixed in a source-file, it moves on to the
> > next file.  The method is clean and allows me to handle this
> > gargantuan task in bite-sized chunks.
> 
> I mean, you have literally used the same commit log and the same changes
> over six different files in the same directory.

Yes, that happens.  It's an unfortunate side-effect of the same ol'
issues repeating themselves over and over.  Mostly due to copy/paste
of mundane code segments such as function documentation.

> Sure changes across
> different parts of the kernel can be painful, but it's really not what
> we're discussing here.

It would have even been painful to post-process patches within the
same subsystem.  For instance, I've just finished cleaning up GPU
which was a mammoth task where most of the issues were perpetually
duplicated.

I will admit though, that here in Clock, it would be somewhat easier.

> > Going though and pairing up similar changes is unsustainable for a
> > task like this.  It would add a lot of additional overhead and would
> > slow down the rate of acceptance since source files tend to have
> > different reviewers/maintainers - some working faster to review
> > patches than others, leading to excessive lag times waiting for that
> > one reviewer who takes weeks to review.
> 
> Are you arguing that sending the same patch 6 times is easier and faster
> to review for the maintainer than the same changes in a single patch?

The issue I see with the Clock, is that some files are maintained by
individual driver Maintainers and others by subsystem Maintainers.  So
the post-process here is that much more painful (as it can't be
easily scripted using get_maintainer.pl) and the aforementioned
lag-time issues come into play while we wait for sleepy reviewers.

> > Having each file addressed in a separate patch also helps
> > revertability and bisectability. Not such a big problem with the
> > documentation patches, but still.
> 
> There's nothing to revert or bisect, those changes aren't functional
> changes.

Right, I did mention that.

> > Admittedly doing it this way *can* look a bit odd in *some* patch-sets
> > when they hit the MLs - particularly clock it seems, where there
> > hasn't even been a vague attempt to document any of the parameters in
> > the kernel-doc headers - however the alternative would mean nothing
> > would get done!
> 
> Yeah, and even though properly documenting the functions would have been
> the right way to fix those warnings, I didn't ask you to do that since I
> was expecting it to be daunting.

There are a couple of schools of thought on function documentation.
The conflicting one to yours is that Kernel-doc headers should only be
used if they are part of an API and have an accompanying kernel-doc::
tag in Documentation.  The functions touched here do not.

NB: Fortunately the functions we're discussing are all static or else
`scripts/find-unused-docs.sh` would complain about them also.

Personally, I am in the middle.  If authors have had a good go at
documenting functions and their parameters, I'll make the effort to
fix any doc-rot or oversights.  However if, like here, no such effort
has been made, they get demoted.  Nothing stopping authors fixing them
up properly and re-promoting them again though.  Essentially I'm
trying to avoid a situation where authors throw something together
half-heatedly, safe in the knowledge that someone will come fix and
beautify things for them.

> Surely we can meet half-way

I'm always happy to collaborate.  What does half-way look like?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
