Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901D332536A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhBYQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhBYQWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:22:38 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E29C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 08:21:56 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id l8so5917661ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 08:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cP36naQj3qpC5i/IheYs6HlbPebR0MpDFfVJ183xi8=;
        b=KeDpl/ntLDJO0xHlFgkxocqJLerEAuvIJ2EY3GHp0W3hUj+P/H80wjBdRtEMG9I6mk
         mOgnF2arVx72Klh9ceuX9/gZrNp086hN7VWSm2CdPxWGVLlv/d3ygeohIOvkZz5l7Cyx
         ZhFxLDCDeov/Avb6rWbqVkBHPzx5KAcHND5L3Oyd1ikRLLXkV4M2h1M2rxeBlmXO1FzC
         h6wigFdFrnCmS2Ta1BenFcqq3z1TeWEZYayefvy101cUxA4uZ/76DzbLiVB0QDg4ef1t
         RT0ZhWM3jjPl7MNJayNpq84oFbz/wj7Vm1HMTE9TGejYbOcy+PrX9l5mI0z5Sz0KgvLo
         ksGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cP36naQj3qpC5i/IheYs6HlbPebR0MpDFfVJ183xi8=;
        b=CR69NnU6xOpS+POy7f8+XtjsocBJa/3Gt0Z3wKZzg1s7tDxO+7PMDaPL6JMS7rJVfe
         9J0pPqNVWH5MXsNKaQh5IH8gkzDvhD8JeioS6ZO1ZQfpZzSvwh77af8Zx6PrahF8B2ik
         ffdEGfKy9LoQQ5vKzwjc0CmeSMqEbqd9J7FFXUoBhhs3GTPa/Jya53t/kI7kjY6Tysq0
         ikx5/UagIlxgOVbiAy0ysAwsOiSYsENgl8ROJEtR2oystNr3vXxuMSg2rsgOd5niYe6d
         n9tKPwV7whYNZIcKslDhoiIEBwd3p7TJ4w/QoUEY4EieVG47Oa6jjozvcO3UvV32vBKJ
         RH6w==
X-Gm-Message-State: AOAM533Z/F5Qdine74SV9Pn2un67Y2GRD9O+Rt2pFR4d3PHzF/4AqClM
        n6Kb6LUSWpvYyyUGTVClU/ZWUVJHU1cNzD3vtGdoKw==
X-Google-Smtp-Source: ABdhPJwM8YNyUIdNGpLL8VN5EQjunqmqzPDS5sX6h/EAdG7KRABzywLAjcwqJL7G07M7ZbMubkIt94W1wIhCADUnp+I=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr5354227ybi.32.1614270115514;
 Thu, 25 Feb 2021 08:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20210215151405.2551143-1-geert+renesas@glider.be>
 <CAGETcx-c5P76JkB-upi8ArDqa=TrR3bJMnpDTO-59sh83opW8g@mail.gmail.com>
 <CAMuHMdVXCH+27cpC=-viQev1HeN_DkU0=7Dydp4G50z0bB2Ang@mail.gmail.com>
 <CAGETcx_B7r6DErnxzDngh_KW9a33f4+cHhvthzfEHX8pO0et8w@mail.gmail.com> <CAMuHMdXr99COTVHyostPLfYC7hezwOf9GfBi_oPfBPQu9nLB9Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXr99COTVHyostPLfYC7hezwOf9GfBi_oPfBPQu9nLB9Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Feb 2021 08:21:19 -0800
Message-ID: <CAGETcx8AYjq7jdGhNXZffg2Y_Jxn3RszuBeXJsRH8on8TC0A-g@mail.gmail.com>
Subject: Re: [PATCH] staging: board: Fix uninitialized spinlock when attaching genpd
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 1:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Mon, Feb 15, 2021 at 10:03 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Mon, Feb 15, 2021 at 11:10 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, Feb 15, 2021 at 7:37 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Mon, Feb 15, 2021 at 7:14 AM Geert Uytterhoeven
> > > > > @@ -148,7 +149,11 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
> > > > >         pd_args.np = np;
> > > > >         pd_args.args_count = 0;
> > > > >
> > > > > -       return of_genpd_add_device(&pd_args, &pdev->dev);
> > > > > +       /* Cfr. device_pm_init_common() */
> > > >
> > > > What's Cfr?
> > >
> > > "compare to" (from Latin "confer").
> >
> > Can you please change this to "refer to" or "similar to"? Also, not
> > sure if this comment is even adding anything useful even if you switch
> > the words.
>
> I changed it to "Initialization similar to device_pm_init_common()"
>
> > Also, device_pm_init_common() is used in two places outside of
> > drivers/base/ with this change. Maybe better to move it to
> > linux/device.h?
>
> arch/sh/drivers/platform_early.c has a separate definition, and this
> is intentional, cfr. commit 507fd01d53333387 ("drivers: move the early
> platform device support to arch/sh"):
>
>     In order not to export internal drivers/base functions to arch code for
>     this temporary solution - copy the two needed routines for driver
>     matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
>

Thanks. The comments and decision to copy the code sounds okay to me.
But I'll still leave the Ack/Review to Rafael or someone else as I'm
not too familiar with the intent of this flag.

-Saravana
