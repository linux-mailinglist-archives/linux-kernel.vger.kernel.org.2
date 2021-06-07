Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B61F39D9E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFGKn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:43:28 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:41890 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFGKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:43:27 -0400
Received: by mail-io1-f49.google.com with SMTP id p66so15899136iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frqaxGMAkJEQAuZ/tJXzTA+WvhXTF9BfhxoU4WYTb2k=;
        b=p6IGs0SA13VrJLKJ+xDgTb9AqH8xXm9Ul9GMgdJwfsAELNHb+tkky/fQ4lc7sMHXdL
         qdkEVXJULjOpXqhZPMUr0Q2AS2Kl19Mv71jo9SjQSt1Pypo8NraZuKrRM6VqBM/ylz36
         4cR5TMAIFTBEvKL4qgOzbOlv7+4g24nhLgazXv6TKmJpRWlNXrshGEVRAxy64adfeIbe
         dw07T+Vw3Pvo4sr0VO4Qw3LMNIyJsb/KkWpQy2FswJcx5v7IsrFV3IzHBJ3oMo0+vTIX
         moGc19IBep7rGYVW/APXmF5zWx2gUmhQEe5B1xFYDwoTkOXR/5FMZnkSm4h+CwHiS9ye
         IntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frqaxGMAkJEQAuZ/tJXzTA+WvhXTF9BfhxoU4WYTb2k=;
        b=oMNLl++qE73yXuAiFGNp4uKDE6ZEB38y28Q/xREcAKvJqRjry5q0+LvtFKcOOuAAkj
         RrpWxiK5Kb6EFmxQzxgGBZneEO0GZJUyYSU1k2V6IMWG05alvvV6crFksQphPfX21QpJ
         +QGYxxDk8kPPkbpY8iNwu6uKlnx34MyqznSWwf/jVFDtvKSozY8bIXmYImdv1DgFoITi
         BOtHUVYe2WalX86wV8tmNsPTVPdTLr8tCPemeAVEDmVthA/VuBANZem2/nIar0Dwe6a1
         3+J9fk1YujqDDakPHTbV9mHa8QS8+HCazSOsCKMpfIV/xbmak9U298dj0UvmofXqorkC
         Hz+Q==
X-Gm-Message-State: AOAM5307JGPVwRSeYyZzRoAtc24BF6WpVSAi/n5HbhgcqJ71hOeDYLlq
        LdsCaD+RYaNwUmGttk7jkiYADxYO0Pr/uhEOIUCgqw==
X-Google-Smtp-Source: ABdhPJxWAwxZMctyeQ+om2eZkWgu1RcVW4YnItSFwAHwO0bcHTomlwOedkny1vYuvwXNPZph6YXez8T7mMrwJWB7lAs=
X-Received: by 2002:a05:6638:634:: with SMTP id h20mr15743491jar.14.1623062423730;
 Mon, 07 Jun 2021 03:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210602122439.2084775-1-robert.marko@sartura.hr>
 <20210602122439.2084775-4-robert.marko@sartura.hr> <df76ecd3748a055085fe62f3119eaebc7f2c16bd.camel@pengutronix.de>
In-Reply-To: <df76ecd3748a055085fe62f3119eaebc7f2c16bd.camel@pengutronix.de>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Mon, 7 Jun 2021 12:40:13 +0200
Message-ID: <CA+HBbNHQuMf5z3teqgbn4aY6z+AydCwn1THeMJWCp3RafGXv8w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] reset: Add Delta TN48M CPLD reset controller
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        robh+dt@kernel.org, Lee Jones <lee.jones@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 11:23 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Robert,
>
> On Wed, 2021-06-02 at 14:24 +0200, Robert Marko wrote:
> > Delta TN48M CPLD exposes resets for the following:
> > * 88F7040 SoC
> > * 88F6820 SoC
> > * 98DX3265 switch MAC-s
> > * 88E1680 PHY-s
> > * 88E1512 PHY
> > * PoE PSE controller
> >
> > Controller supports only self clearing resets.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/reset/Kconfig       |   9 +++
> >  drivers/reset/Makefile      |   1 +
> >  drivers/reset/reset-tn48m.c | 128 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 138 insertions(+)
> >  create mode 100644 drivers/reset/reset-tn48m.c
> >
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 4171c6f76385..14e179cda58c 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -237,6 +237,15 @@ config RESET_TI_SYSCON
> >         you wish to use the reset framework for such memory-mapped devices,
> >         say Y here. Otherwise, say N.
> >
> > +config RESET_TN48M_CPLD
> > +     tristate "Delta Networks TN48M switch CPLD reset controller"
> > +     depends on MFD_TN48M_CPLD
>
> Let's make this
>
>         depends on MFD_TN48M_CPLD || COMPILE_TEST
>         default MFD_TN48M_CPLD

Sure, I will change that and send a v5.
>
> unless there is a reason not to enable the reset driver by default when
> the MFD driver is activated.

No, it's just a habit of making everything optional.

Regards,
Robert
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> regards
> Philipp



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
