Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967223B9666
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhGATUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 15:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGATUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 15:20:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6897C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 12:18:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i18so12524479yba.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MwRpov181Xxl6DOtkPtQbShnFlr5OF506VpbcmbwuI=;
        b=oFX98qKeDz/S2rFehmPmo0Av5LTQuusU8aUo/m6V55S2bc312ajPb3EvFuhnsrmNy6
         9eYtvSd3YrC2DSuOkbcPedR8y33sZrL8/ivYBjAZl9/TfhRK2BU/7RG8z9UXP2TO3TM+
         4V3SctWJVn2fJCTRpVa8N5v7p13O9/EwHCnWR4EpqjUsUf3SHYdz+WvPeVI+tl+4T7NZ
         Jpe5/15bEUMtsZEX5XwJNE+jpkYOkKtz7FgPrrxAS9jP6hkcydYCw8T1T+KemkMkrF65
         bcPnY5ocXItyZ3TPYM5XXy+9skeXZ5ySC6HrSqK60iFCulPFq4GZdJFcowodyH7bBU8y
         J1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MwRpov181Xxl6DOtkPtQbShnFlr5OF506VpbcmbwuI=;
        b=S6Xb+Ggr7n+Zn7PIZezUyPVRffC5Vl+C/QlYJD5eLk8PM9PwyuEX74V/QYubR4nBGN
         JZPV3vYjvXqKGNoH8tfwGe2gd5PlknkT2PX1SFjjpebSc1JE/8gzAHN2urtRGRj5c22W
         j4UKPujNjg5wwlugFOga/JJvHG/CmcMpDsESwarj8fz6AsjOL68lsXxGqxiRgzP1j9yW
         S3FElxlD4/6I/+GHq3/V3smTMZK5liatN+p/GsnhF5/ssVb2jt+gwoakeBpDfkpZNa3b
         ovwdU0hsbttGE/BPzdnaj37dB1ZZtlUNlbT+rM+m4vLuS4oq/V/qJ7mG2zdTjgbfxTP7
         NYKg==
X-Gm-Message-State: AOAM5326m89wKP+vlP8bOX2VKehslPZAnJX5sv/4MEbzALpJshuidhal
        Y7uQluvAUq5/ovzVlAC7u3Q3KJfKf0lKTrJDSg/5L7dza1Y=
X-Google-Smtp-Source: ABdhPJyRmoPfxaQwrGtr1pdYLJJrnEiuHLY38spI+PtHbtJ15vx541cyDM6OUrVtRFwW5ZMDSIPybiJ9doJRR0PgIyY=
X-Received: by 2002:a25:59d6:: with SMTP id n205mr1901589ybb.20.1625167090318;
 Thu, 01 Jul 2021 12:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210701085159.208143-1-zhang.lyra@gmail.com> <20210701085159.208143-4-zhang.lyra@gmail.com>
In-Reply-To: <20210701085159.208143-4-zhang.lyra@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 1 Jul 2021 12:17:33 -0700
Message-ID: <CAGETcx-5Y6g3yO1Xs0=+WEsr5Hw7_6W6XRnseC7u5SfKAXbpCA@mail.gmail.com>
Subject: Re: [PATCH 3/3] clocksource/drivers/sprd: Add module support to
 Unisoc timer
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 1:52 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> Timers still have devices created for them. So, when compiling a timer
> driver as a module, implement it as a normal platform device driver.
>
> Original-by: Baolin Wang <baolin.wang7@gmail.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/clocksource/Kconfig      |  2 +-
>  drivers/clocksource/timer-sprd.c | 15 +++++++++++++--
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 39aa21d01e05..9f16c2779edb 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -447,7 +447,7 @@ config MTK_TIMER
>           Support for Mediatek timer driver.
>
>  config SPRD_TIMER
> -       bool "Spreadtrum timer driver" if EXPERT
> +       tristate "Spreadtrum timer driver" if EXPERT
>         depends on HAS_IOMEM
>         depends on (ARCH_SPRD || COMPILE_TEST)
>         default ARCH_SPRD
> diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
> index 430cb99d8d79..73c7b3f8c901 100644
> --- a/drivers/clocksource/timer-sprd.c
> +++ b/drivers/clocksource/timer-sprd.c
> @@ -5,6 +5,8 @@
>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
>
>  #include "timer-of.h"
>
> @@ -141,7 +143,7 @@ static struct timer_of to = {
>         },
>  };
>
> -static int __init sprd_timer_init(struct device_node *np)
> +static int sprd_timer_init(struct device_node *np)
>  {
>         int ret;
>
> @@ -190,7 +192,7 @@ static struct clocksource suspend_clocksource = {
>         .flags  = CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
>  };
>
> -static int __init sprd_suspend_timer_init(struct device_node *np)
> +static int sprd_suspend_timer_init(struct device_node *np)
>  {
>         int ret;
>
> @@ -204,6 +206,15 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
>         return 0;
>  }
>
> +#ifdef MODULE
> +TIMER_PLATFORM_DRIVER_BEGIN(sprd_timer)
> +TIMER_MATCH("sprd,sc9860-timer", sprd_timer_init)
> +TIMER_MATCH("sprd,sc9860-suspend-timer", sprd_suspend_timer_init)
> +TIMER_PLATFORM_DRIVER_END(sprd_timer);
> +MODULE_DESCRIPTION("Unisoc broadcast timer module");
> +MODULE_LICENSE("GPL");
> +#else
>  TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
>  TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
>                  sprd_suspend_timer_init);
> +#endif

Would it be a problem if you removed the ifdef and dropped these
TIMER_OF_DECLARE? Doesn't look like either of these timers are needed
for the early scheduler timer.

-Saravana
