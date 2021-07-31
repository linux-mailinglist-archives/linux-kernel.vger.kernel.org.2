Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB4F3DC518
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 10:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhGaIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGaIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 04:42:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52642C06175F;
        Sat, 31 Jul 2021 01:42:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b6so18583758pji.4;
        Sat, 31 Jul 2021 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ui2pGTgUv990ujOpW+RfTTCACQki1tm456MMej0JWyo=;
        b=n0PXG9BiZXmTzVaMKXWYkI/+doL8qEI0mJQ5Uhwk8vfdiG+Bvp3NKK99FmwRlMU0i3
         XpjgGYvxxZ+KaKjFNF1SqjKU2jq0D4IyG6EEURII3fgtECBV8qiKxz1bzMivESSrVEUG
         njC2qTdwEQLEbFB5KJwqfDyOnBcZNYwoaZxW0BwkVCBTTIHv9CdeGpTXLfV3/ICOUIi+
         vtM9AuQJ7Gx6entAXyHRkSi/EqQ8cUe1tUSliOR0FRWYwQ6mLKegAR/vVWGxX7p340ed
         tcj9Uhd4imVvxiAKMd0obPdYZYLpAQ70EwPbiyvs4lB7ks1o8J8SslppOgJfu8DzKSFx
         pkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ui2pGTgUv990ujOpW+RfTTCACQki1tm456MMej0JWyo=;
        b=fSeOIWPOj7pK/hVZAX+Ps+W68cPzOyZE7XenXakRqvh8Kl5HOK2POc3jsYQSNHHiMt
         OkQHR3sCC2n+B4ZofJGO+fQUOzbo2EHcP4tl9B+e8Kt8CYyvtGOWzraS6P/f0eWlt50a
         Khf+i31RBxuSm9pf5mqs/t3iXO8di1f6MB6Uw6c+HlCS7exb/z1nsl8abszrb1pXuGTe
         a6vBI9cLalITA3+89FG3Sf4DOg3AZGQOrkm8rcV3DgeAh+IPKIbhl6HvPCTbIcv/yp/j
         /qsmQEeOdqdMuiPwgXc8Ynnqhr1o4FM1ezYTqyymxXycdcT5YCn09N9oNPnek5z1SSdy
         5ilQ==
X-Gm-Message-State: AOAM53118V2McHramXaHysyGMF1Gr9Uhc8a7CGHnC1G1fHbh6NsBAdnH
        yBemclaQE5cLVYiNc85vmsPPOZt1cTRGTnVn23M=
X-Google-Smtp-Source: ABdhPJziS+K5e82HcDPJvDeHq8wenSVByUY2IdakU03rc5WgEtSV32ey5sxUpIZBlQTDtDMUDlLfB2g7rJZbCPRKiKo=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr5618173pgg.4.1627720941716;
 Sat, 31 Jul 2021 01:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627710765.git.gayatri.kammela@intel.com> <fa72dfad9282e2c24b99327d08cbe032d7034bbf.1627710766.git.gayatri.kammela@intel.com>
In-Reply-To: <fa72dfad9282e2c24b99327d08cbe032d7034bbf.1627710766.git.gayatri.kammela@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 31 Jul 2021 11:41:45 +0300
Message-ID: <CAHp75VeAu2fs5zesQE0YqsOSTVO8zPacpW9e89adYBoZnGToOg@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>, chao.qin@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>, mlimonci@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 9:10 AM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:
>
> As part of collecting Intel x86 specific drivers in their own
> folder, move intel_pmc_core* files to its own subfolder there.

...

>  .../pmc/pltdrv.c}                             |  0

I would go further and spell it as platform.c.

...

> -F:     drivers/platform/x86/intel_pmc_core*
> +F:     drivers/platform/x86/intel/pmc/core*

This seems incorrect.

...

> +         Supported features:
> +               - SLP_S0_RESIDENCY counter
> +               - PCH IP Power Gating status
> +               - LTR Ignore / LTR Show

> +               - MPHY/PLL gating status (Sunrisepoint PCH only)
> +               - SLPS0 Debug registers (Cannonlake/Icelake PCH)
> +               - Low Power Mode registers (Tigerlake and beyond)

Perhaps you may use the opportunity to spell codenames in a better way, i.e.
Sunrise Point
Cannon Lake
Ice Lake
Tiger Lake

as it's done almost everywhere else in the kernel.

...

> +obj-$(CONFIG_INTEL_PMC_CORE)   += intel_pmc_core.o
> +intel_pmc_core-objs            += core.o

objs suffix is not for kernel modules.
Moreover, := has a difference to +=. Why is the latter in use?

> +obj-$(CONFIG_INTEL_PMC_CORE)   += pltdrv.o

This will have the very same issue as with the core module. On top of
that, do you need a separate module for it? If so, why?

-- 
With Best Regards,
Andy Shevchenko
