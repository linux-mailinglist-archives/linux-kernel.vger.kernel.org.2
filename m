Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5FE3DCCB9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 18:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhHAQop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 12:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhHAQon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 12:44:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B76EC0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 09:44:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nh14so10366664pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9NdtZ+M8WQCeVD4BIR2vaRk3pqeGSmk7XeEKy9q9h0U=;
        b=gP9XuhvHdBGh2F/SVek/ldY7uGeyWNqBgqR+kyntTfIRo1AKeeIbuXK7RtRD4MIerb
         isiCbUkixUh/ohRFX82skqpOzeWgIyWs8ElZSJ3HdAUBXeQ7NEEzGm27PXaQCAOb4hHz
         DGWFM52KQXs1CcQ8eXEYBMgNyY+F3E2hmToqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9NdtZ+M8WQCeVD4BIR2vaRk3pqeGSmk7XeEKy9q9h0U=;
        b=JC3pfWG+J4YabvOn2HjQeZJV+C6vTt7g/wnEBkZA60gb3kuZR+A1QwGLqs9AtReOca
         Y8oT9+kWp6Xu7lZenyvwCrKGjoM6ZhmzYP56F26E5QDDjLo7ygJ9YvTlm+vCNfxebaEC
         /jQl2Lq3+sSRUpHvTHJv6GlnVeQIxYtg0psR6IWEW1G9FWEtG/Qn3vU0t74twlT2xl8h
         5KordOba5jtPtdaxzSaipRVmaH0KG3obexPiHJa5VYl5ipbRtcDvS1pQLkwnaoV6w7WV
         9ur4sJrZ3tz53k27ZY4i1eguIyNMjigcbxXINMXtPxO64aL3RsTYsxeZJdbVB0Ahuifo
         YxLA==
X-Gm-Message-State: AOAM533EDep0WObJdzAfWKQYvN5Ws642NeViY0kY/lOFPwN8d0kMSOoo
        TXvkX4PBXzZQTCjjHorm03UZ7fA+Mw3jRg==
X-Google-Smtp-Source: ABdhPJz8VbM5XQgXgUec6CExsiHwloVTLYiatWTmTcvkZiJ+WLe2l2Yv3aDhTYwhCKRcPUCBFCT8EQ==
X-Received: by 2002:a17:90a:c085:: with SMTP id o5mr3925399pjs.9.1627836274852;
        Sun, 01 Aug 2021 09:44:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g71sm8945302pfb.139.2021.08.01.09.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 09:44:34 -0700 (PDT)
Date:   Sun, 1 Aug 2021 09:44:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-hardening@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drivers/input: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <202108010934.FA668DEB28@keescook>
References: <20210801144316.12841-1-len.baker@gmx.com>
 <20210801145959.GI22278@shell.armlinux.org.uk>
 <20210801155732.GA16547@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801155732.GA16547@titan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 05:57:32PM +0200, Len Baker wrote:
> Hi,
> 
> On Sun, Aug 01, 2021 at 04:00:00PM +0100, Russell King (Oracle) wrote:
> > On Sun, Aug 01, 2021 at 04:43:16PM +0200, Len Baker wrote:
> > > strcpy() performs no bounds checking on the destination buffer. This
> > > could result in linear overflows beyond the end of the buffer, leading
> > > to all kinds of misbehaviors. The safe replacement is strscpy().
> > >
> > > Signed-off-by: Len Baker <len.baker@gmx.com>
> > > ---
> > > This is a task of the KSPP [1]
> > >
> > > [1] https://github.com/KSPP/linux/issues/88
> > >
> > >  drivers/input/keyboard/locomokbd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
> > > index dae053596572..dbb3dc48df12 100644
> > > --- a/drivers/input/keyboard/locomokbd.c
> > > +++ b/drivers/input/keyboard/locomokbd.c
> > > @@ -254,7 +254,7 @@ static int locomokbd_probe(struct locomo_dev *dev)
> > >  	locomokbd->suspend_jiffies = jiffies;
> > >
> > >  	locomokbd->input = input_dev;
> > > -	strcpy(locomokbd->phys, "locomokbd/input0");
> > > +	strscpy(locomokbd->phys, "locomokbd/input0", sizeof(locomokbd->phys));
> >
> > So if the string doesn't fit, it's fine to silently truncate it?
> 
> I think it is better than overflow :)
> 
> > Rather than converting every single strcpy() in the kernel to
> > strscpy(), maybe there should be some consideration given to how the
> > issue of a strcpy() that overflows the buffer should be handled.
> > E.g. in the case of a known string such as the above, if it's longer
> > than the destination, should we find a way to make the compiler issue
> > a warning at compile time?
> 
> Good point. I am a kernel newbie and have no experience. So this
> question should be answered by some kernel hacker :) But I agree
> with your proposals.
> 
> Kees and folks: Any comments?
> 
> Note: Kees is asked the same question in [2]
> 
> [2] https://lore.kernel.org/lkml/20210731135957.GB1979@titan/

Hi!

Sorry for the delay at looking into this. It didn't use to be a problem
(there would always have been a compile-time warning generated for
known-too-small cases), but that appears to have regressed when,
ironically, strscpy() coverage was added. I've detailed it in the bug
report:
https://github.com/KSPP/linux/issues/88

So, bottom line: we need to fix the missing compile-time warnings for
strcpy() and strscpy() under CONFIG_FORTIFY_SOURCE=y.

In the past we'd tried to add a stracpy()[1] that would only work with
const string sources. Linus got angry[2] about API explosion, though,
so we're mostly faced with doing the strscpy() replacements.

Another idea might be to have strcpy() do the "constant strings only"
thing, leaving strscpy() for the dynamic lengths.

One thing is clear: replacing strlcpy() with strscpy() is probably the
easiest and best first step to cleaning up the proliferation of str*()
functions.

-Kees

[1] https://lore.kernel.org/lkml/ed4611a4a96057bf8076856560bfbf9b5e95d390.1563889130.git.joe@perches.com/
[2] https://lore.kernel.org/lkml/CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com/

-- 
Kees Cook
