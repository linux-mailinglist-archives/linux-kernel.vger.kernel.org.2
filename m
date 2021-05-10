Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116B4379235
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbhEJPQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbhEJPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:14:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8B5C03462B
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:33:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x19so23692217lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TD4F9oa3VitNBzFXjP4uGUFTgbLeIBvDuQfeO7iSJY8=;
        b=E/AVuCxqIjpRB0+97YiL29NgoO40mm0LemOYWr0wXSq8+huvTkRQzmYbXLpUpjnzTW
         DTd/i6sw7eW12OSeunmEp9C7EC9xGVmvUgzxnfduX/ZuXLne5SBkQqqNlhwHj9UJPEl4
         vROzCfpAZvTTkTnvLfomnlGIH3VFuxwbR5+4TlffIdAnC/KmOjV0QJ9CV5z9VviMtOgb
         QKr667wwvXurnBzzNn5Mn7mB/u4mbet24esfg81vJ6i0/da+V/svnOI3/0kuYvgJZ9wt
         2yPrxpX9mwqhNgdSRtlZONIV6fXHZW0bUjJ/N4AyJb7abtn06WELrTBGdjKBmhL+DFGH
         4T+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TD4F9oa3VitNBzFXjP4uGUFTgbLeIBvDuQfeO7iSJY8=;
        b=A2tWr5hHoUw6/AppoJaQkCSfDVsznOYvOtfzUbxL8fpHMJq/e7U1J6a3bifhW+jOKu
         WviL3ERGvLOZ/I+ahbIZCt64/heVnSJ5p3g2bcRZQK9xMdPS9R3bshk6WJhzHoX+84CO
         RD8hlhxUkT+1J6pkm7QscdyytrAU22dYMdjDmqYbb3qw7C4Lt16hlOdtu8VzQ3/C86Ie
         1C8Mj0pMqjMBSGmnayKYhnm3RoNabkR38yuHuG4uSMvbzf4t+KThkGrSIOVEVIt/QTTL
         Y1CEVMN88eQqyakHuNeXUw+m5zMneiJCeuJs6S/wO7Ajr7Z3sxqlwzXA33whXWS2aXb4
         ua2w==
X-Gm-Message-State: AOAM530NZmMm/pWOKsjlnXxQ4IReN3r8YgUh3lJXfFd47VD8Nxy426sl
        AqttXeyu7L6UQ7sCVDDnlBxaoeNbZOAbQfApwE3jFA==
X-Google-Smtp-Source: ABdhPJwkl4uaiRO8zDucHIXDoAr9bPah/2qvkFw0x4qRgxXcIfiLsPizRjl4ovVfsUxSnLSBQKUZrYUi+VGBuItVfn0=
X-Received: by 2002:a05:6512:24b:: with SMTP id b11mr16869562lfo.486.1620657179908;
 Mon, 10 May 2021 07:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
 <20210506145829.198823-3-ulf.hansson@linaro.org> <CACRpkdZ2JRapr5x2zn3ABwiGJw-8kbfG4K2oZVD0Lfr7KHG8Jw@mail.gmail.com>
In-Reply-To: <CACRpkdZ2JRapr5x2zn3ABwiGJw-8kbfG4K2oZVD0Lfr7KHG8Jw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 May 2021 16:32:22 +0200
Message-ID: <CAPDyKFqPhSSP1TBite3dcBd7W2x2=c-xH=_M=udzBiMs95bkjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Add support for cache ctrl for SD cards
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 May 2021 at 21:01, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, May 6, 2021 at 4:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > In SD spec v6.x the SD function extension registers for performance
> > enhancements were introduced. As a part of this an optional internal cache
> > on the SD card, can be used to improve performance.
> >
> > The let the SD card use the cache, the host needs to enable it and manage
> > flushing of the cache, so let's add support for this.
> >
> > Note that for an SD card supporting the cache it's mandatory for it, to
> > also support the poweroff notification feature. According to the SD spec,
> > if the cache has been enabled and a poweroff notification is sent to the
> > card, that implicitly also means that the card should flush its internal
> > cache. Therefore, dealing with cache flushing for REQ_OP_FLUSH block
> > requests is sufficient.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> (...)
>
> > +       /*
> > +        * Set the Flush Cache bit in the performance enhancement register at
> > +        * 261 bytes offset.
> > +        */
> > +       fno = card->ext_perf.fno;
> > +       page = card->ext_perf.page;
> > +       offset = card->ext_perf.offset + 261;
>
> 261 looks a bit magic, can we add a define of some sort?

We could, but I am not sure it really improves things. At least it
would not be consistent with the way we treat other magic numbers.

I think it's better to look into this as wider cleanup instead.

> I guess it has a name in the spec?

It's called the "Power Management Setting Register".

>
> > +       err = sd_write_ext_reg(card, fno, page, offset, 0x1);
> > +       if (err) {
> > +               pr_warn("%s: error %d writing Cache Flush bit\n",
> > +                       mmc_hostname(host), err);
> > +               goto out;
> > +       }
>
> So this offset contains a single bit.
>
> > +       if (reg_buf[0] & 0x1)
> > +               err = -ETIMEDOUT;
>
> And that same bit is checked here.

Correct.

>
> Is it always going to be one bit only or do we want to
>
> #include <linux/bits.h>
> #define SD_CACHE_FLUSH_FLAG BIT(0)
>
> Does it have a name in the spec we can use?

Well, it just says "Cache Flush" bit.

It seems to be one bit always for these features. The remaining bits
in the same byte are unused/reserved.

Each feature has at least one dedicated byte, so there are no bytes
being shared between features.

>
> > +       /*
> > +        * Set the Cache Enable bit in the performance enhancement register at
> > +        * 260 bytes offset.
> > +        */
> > +       err = sd_write_ext_reg(card, card->ext_perf.fno, card->ext_perf.page,
> > +                              card->ext_perf.offset + 260, 0x1);
>
> Same here we want to #define 260 to something symbolic,
>
> And here some define for BIT(0) as well. At least with BIT(0)
> in the call to sd_write_ext_reg() rather than 0x1 if I can say
> something.

The conversion to BIT(0) in the argument is clearly an improvement. I
do that change when applying, but leave the defines for the other
magics to be considered as a future cleanup.

>
> With the above nitpicking fixed up (I trust you):
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

Kind regards
Uffe
