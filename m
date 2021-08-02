Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0923DDD5E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhHBQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhHBQRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:17:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BC1C061760
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 09:17:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k1so20184745plt.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LJj2P5o2cKeLKuYjXi+czGF513yMyMUQ9HYrVL8TL84=;
        b=SQ22Ul4TppIXopyLdTekgOvhFKVew15BJDLJwUUyXUQRK0tANvQYq8bbWLHRP8KoSb
         4zoS4Oqecr4M6tThv+4s/klsyd28FfD3c5RX3kQpzCQPuhItFvutStScryZU/kA1rww2
         1p+XNbS3JtELAs7/T1zVNRJhbJ0JS+r+mNxo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LJj2P5o2cKeLKuYjXi+czGF513yMyMUQ9HYrVL8TL84=;
        b=OG2KweZORwyp2P3IGZ6uADkavPQzbeQ9as6k2f2DJDiy0bXA4q5Hl0066UYSZx6mPB
         8SxwFW4FOz1NQ5WOxD2v+m+J7i2ipZWxM3lFOkQrExDKDcUfTE+CHChJeWyNusjf8eVh
         ycsli5mQbJUwKw5XKQsHp5d7f0Tm+qr9aIjyqC4TjUwnXi3v0+ogtePmRSEgz1Vf/KO5
         FIQWOl9lQXVVuSnJ7Jcsytx6v8Om/tV1DWRNmLfdet20fvV+G5pWICuuDlMdTF2+ke8l
         WwpzCeuA+R/kGlwqwHAJT3aFHSNg8aw9Xc9P7+FnNK3r8tjYt6Y8iUnu8jVOLu5MO/EL
         Ks+A==
X-Gm-Message-State: AOAM531kB7+MW/t1wNPJgjuLok73LdryT8DI+vkuyBIHUGXD0vzoUdP2
        9Rym2X5zmexXhpWL6SZk63NiBA==
X-Google-Smtp-Source: ABdhPJx0B/YwU5dyCtUO2xD8jnUHhQGTg6uR41kMgVBypegibDOXaPPnHyP9y3EwFcz1z7SAxlsN7A==
X-Received: by 2002:aa7:854a:0:b029:332:330e:1387 with SMTP id y10-20020aa7854a0000b0290332330e1387mr17244524pfn.67.1627921043292;
        Mon, 02 Aug 2021 09:17:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm11589670pfi.204.2021.08.02.09.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:17:22 -0700 (PDT)
Date:   Mon, 2 Aug 2021 09:17:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Len Baker <len.baker@gmx.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-hardening@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drivers/input: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <202108020913.2FB270539C@keescook>
References: <20210801144316.12841-1-len.baker@gmx.com>
 <20210801145959.GI22278@shell.armlinux.org.uk>
 <20210801155732.GA16547@titan>
 <202108010934.FA668DEB28@keescook>
 <YQbXiwie4YPzPWKK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQbXiwie4YPzPWKK@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 10:19:07AM -0700, Dmitry Torokhov wrote:
> On Sun, Aug 01, 2021 at 09:44:33AM -0700, Kees Cook wrote:
> > On Sun, Aug 01, 2021 at 05:57:32PM +0200, Len Baker wrote:
> > > Hi,
> > > 
> > > On Sun, Aug 01, 2021 at 04:00:00PM +0100, Russell King (Oracle) wrote:
> > > > On Sun, Aug 01, 2021 at 04:43:16PM +0200, Len Baker wrote:
> > > > > strcpy() performs no bounds checking on the destination buffer. This
> > > > > could result in linear overflows beyond the end of the buffer, leading
> > > > > to all kinds of misbehaviors. The safe replacement is strscpy().
> > > > >
> > > > > Signed-off-by: Len Baker <len.baker@gmx.com>
> > > > > ---
> > > > > This is a task of the KSPP [1]
> > > > >
> > > > > [1] https://github.com/KSPP/linux/issues/88
> > > > >
> > > > >  drivers/input/keyboard/locomokbd.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
> > > > > index dae053596572..dbb3dc48df12 100644
> > > > > --- a/drivers/input/keyboard/locomokbd.c
> > > > > +++ b/drivers/input/keyboard/locomokbd.c
> > > > > @@ -254,7 +254,7 @@ static int locomokbd_probe(struct locomo_dev *dev)
> > > > >  	locomokbd->suspend_jiffies = jiffies;
> > > > >
> > > > >  	locomokbd->input = input_dev;
> > > > > -	strcpy(locomokbd->phys, "locomokbd/input0");
> > > > > +	strscpy(locomokbd->phys, "locomokbd/input0", sizeof(locomokbd->phys));
> > > >
> > > > So if the string doesn't fit, it's fine to silently truncate it?
> > > 
> > > I think it is better than overflow :)
> > > 
> > > > Rather than converting every single strcpy() in the kernel to
> > > > strscpy(), maybe there should be some consideration given to how the
> > > > issue of a strcpy() that overflows the buffer should be handled.
> > > > E.g. in the case of a known string such as the above, if it's longer
> > > > than the destination, should we find a way to make the compiler issue
> > > > a warning at compile time?
> > > 
> > > Good point. I am a kernel newbie and have no experience. So this
> > > question should be answered by some kernel hacker :) But I agree
> > > with your proposals.
> > > 
> > > Kees and folks: Any comments?
> > > 
> > > Note: Kees is asked the same question in [2]
> > > 
> > > [2] https://lore.kernel.org/lkml/20210731135957.GB1979@titan/
> > 
> > Hi!
> > 
> > Sorry for the delay at looking into this. It didn't use to be a problem
> > (there would always have been a compile-time warning generated for
> > known-too-small cases), but that appears to have regressed when,
> > ironically, strscpy() coverage was added. I've detailed it in the bug
> > report:
> > https://github.com/KSPP/linux/issues/88
> > 
> > So, bottom line: we need to fix the missing compile-time warnings for
> > strcpy() and strscpy() under CONFIG_FORTIFY_SOURCE=y.
> 
> Is it possible to have them warn always? Or that would be too many false
> positives?

There are actually no false positives right now (they were all fixed
before FORTIFY_SOURCE landed). Enabling it by default would likely mean
splitting compile-time checks from run-time checks... I'm kind of
already doing this in the recent memcpy() strictness series[1], so ...
maybe?

I think I'd like to land the memcpy() series first, then we can revisit
making it always warn.

> > In the past we'd tried to add a stracpy()[1] that would only work with
> > const string sources. Linus got angry[2] about API explosion, though,
> > so we're mostly faced with doing the strscpy() replacements.
> 
> I would like to have an API that would do compile-time checks and
> BUILD_BUG_ON() for a few places in input drivers where we copy constant
> strings. There is no reason to encumber the code with runtime checks,
> and bombing out on compile instead of truncating would be nice.

In theory, this is provided by CONFIG_FORTIFY_SOURCE, though a recent
change broke a specific instance. I've added tests for this now to the
memcpy() series, and will get it fixed in there too.

> > Another idea might be to have strcpy() do the "constant strings only"
> > thing, leaving strscpy() for the dynamic lengths.
> > 
> > One thing is clear: replacing strlcpy() with strscpy() is probably the
> > easiest and best first step to cleaning up the proliferation of str*()
> > functions.
> 
> OK, so the consensus is that we set this patch aside as it does not
> really fix any issues (the strcpy() destination is 32 bytes and is big
> enough to hold the string being copied)?

I think that's fair.

-Kees

[1] https://lore.kernel.org/lkml/20210727205855.411487-1-keescook@chromium.org/

-- 
Kees Cook
