Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE4E30F347
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhBDMis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbhBDMio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:38:44 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478AFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:38:04 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jj19so5049961ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2meDbtyGONrxJMGNQvqNi6iD/KDP6jfgGsOB/1E0xwI=;
        b=py6mmFrKhu6e8bmetejikaW5cxyQ+bCMX27AZ4YPrz5HUATenX04nwCoWJ1aUu2JTS
         7j93QpsWgR7NFIa4m9owjFaF9yl/qz5uBC2wAEzA8RerBe7B8HDF5MBXuJouInMx8PIQ
         2ShOxc37XTnpNvFDtbcgB/4W0wzaKayRz5DS+uoVfMwdPTnM59pooUoLFSMARFUY4CrP
         g3/9qMpF2+Scs+Suj7A6rQLf75rWWTyicml5siXuE44ALh8ux3eyKjBaQJMXrv1ISjh7
         p3JXL6LR23Df94ikK4gHZzDWSMTcmibrrSsjH45epM+vTcieEQY1uIwXgHTQlNLOpAfc
         SNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2meDbtyGONrxJMGNQvqNi6iD/KDP6jfgGsOB/1E0xwI=;
        b=PmA0hz+mFvsKmUcxUK77UCuOsDAw/8kwS5JniN7tpg09Lto2r2gjKJt0z5d73QtxNm
         UM+urznzsHYEv0WG8sB76P4ApMRsduZ96Ib0Ktm6YyJaPmmiKz+lXpzMDwh3VcoqzSt5
         SvO8Oybqq+bLpa4SCzaT9MSdPTbZkE8IaHky2CIMIQJGQSn3Fj0OdHeDNuxDFvS3HtHJ
         2NxgQ31CdKrmfij1aMDdLXsLMNnIa8AXbBI9GUVSIp9brEiJPTySzNMmZ/PXle9Ht5Rk
         Q1Dx6HRMKSwRk95A5X4R6gv0igvDu1HhgNsFWICdzY1ccIwnAKZSxmAHum4no+g0Q3ju
         zGpA==
X-Gm-Message-State: AOAM530odrTq1/4fuBlRDHwUNX82KHrCX0W5Sf+XOVHjiBI1+A/R42xt
        U8SJHamg23R6GeV+vNKsNXIgLiZebs3B50ILRfFOFA==
X-Google-Smtp-Source: ABdhPJztiyR/m3bmzNcgovCZL69Us1jNdugTJoTrpT/656WsCiSZwQvieiH0KCa4KRE4tkSJPy6oKdnx8loxQLMdmQ8=
X-Received: by 2002:a17:906:eddd:: with SMTP id sb29mr7552229ejb.383.1612442283016;
 Thu, 04 Feb 2021 04:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20210111140814.3668-1-brgl@bgdev.pl>
In-Reply-To: <20210111140814.3668-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 4 Feb 2021 13:37:52 +0100
Message-ID: <CAMRc=MfeAokkWdHNS1HES07YBFX6kM_JZRFehk0F+sB552_UbQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource: davinci: move pr_fmt() before the includes
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 3:08 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We no longer need to undef pr_fmt if we define our own before including
> any headers.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/clocksource/timer-davinci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
> index bb4eee31ae08..9996c0542520 100644
> --- a/drivers/clocksource/timer-davinci.c
> +++ b/drivers/clocksource/timer-davinci.c
> @@ -7,6 +7,8 @@
>   * (with tiny parts adopted from code by Kevin Hilman <khilman@baylibre.com>)
>   */
>
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
>  #include <linux/clk.h>
>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
> @@ -17,9 +19,6 @@
>
>  #include <clocksource/timer-davinci.h>
>
> -#undef pr_fmt
> -#define pr_fmt(fmt) "%s: " fmt, __func__
> -
>  #define DAVINCI_TIMER_REG_TIM12                        0x10
>  #define DAVINCI_TIMER_REG_TIM34                        0x14
>  #define DAVINCI_TIMER_REG_PRD12                        0x18
> --
> 2.29.1
>

Gentle ping.

Bart
