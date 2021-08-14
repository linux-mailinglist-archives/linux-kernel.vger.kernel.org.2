Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C733EC1BA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhHNJlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbhHNJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 05:41:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A8C06175F;
        Sat, 14 Aug 2021 02:41:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a20so15181432plm.0;
        Sat, 14 Aug 2021 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyuDZlwBiPoWoWGJzxCdc8Deaw0UN+jSJdhqBxitwE8=;
        b=uLM6TRFmvYT6dULUfJfkeaEbbdKYdxM46SUDZaDxUjDEcpTT7Kdu6n0bqWgyRGBp2t
         pnnWkNN2Y5usrq9OFg2aPewb9cgYmd+yjsXL2KbTmI7/iQaorLNNbAKxq2SCr1i8TIB/
         pilkpNEuWlQBibC6EtwJ0Bv5WXlvS+K8JiROE6YPLtw5o2tIuK/u4wL7suw6BHYxR7b+
         0Q7WFM+DL/Ju3YWJCho6pz9W+WkPOXVF4jS2Zh0kS5Ef/zZIR8UDNv797G6Ic69esOmI
         F67a2eRSfTFFzkBQm1/yUoVEgoIwAYPWXbqqy4ck4WWY/Rv+Mk3qix8ozYMS9cDxGoIc
         1A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyuDZlwBiPoWoWGJzxCdc8Deaw0UN+jSJdhqBxitwE8=;
        b=PjCnOZmBMWAGarLDjJxGRfnTxDV9Ng0WoQC0boXzPylCpkMFgdUprkXArZAcmlVEgH
         RO6zmFxGmATqrMniwe7om40TochwkiY/ZeZyAv5NwPicIS735yft4ALe5cOZaxXcjF3C
         2cWNikh45uN5vWyN3N/kl0QU+F+hP6HbUUZqFIQ20JGkPALjc8yJN8QkMYgdTEdNH85Z
         BQ851XIstGuRGD5XkxvRIIaxqOWbPNNL1Fg5DRNq2KSw6uFexGTga9wL90Jk1aYsQ5hK
         pxm4eViSwZR0r6oyI6fLI8icaEy9ZhyUEEUTBvt69u9LS7FBV9X6b1Zqh/4YXVfMgSvW
         xDOw==
X-Gm-Message-State: AOAM533v3BPSPnfeMQ1s8kS7MHZeqeVw3Rtn7e/ViTjMhYOY0YjLyFBE
        t5NYZJ/TSRexhs8okzx5cCr6fbad2rD9UYCUgEjhKWnik/0ngDRt
X-Google-Smtp-Source: ABdhPJxI2pl/kKvpnICTDHUe3oGKhvtzIHAbXdBKZhchFTfpiPEliSAtvo38F6eq7qCyvy3LkiUPDBHNIfEYqZ0XEFQ=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr6423874pfi.7.1628934076343; Sat, 14 Aug
 2021 02:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210814043103.2535842-1-luke@ljones.dev> <20210814043103.2535842-2-luke@ljones.dev>
In-Reply-To: <20210814043103.2535842-2-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 14 Aug 2021 12:40:39 +0300
Message-ID: <CAHp75VcCzjb7TKZ84iVjJr27+nCcA10n38nwCAGATucfAAMkKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] asus-wmi: Add support for platform_profile
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 7:33 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Add initial support for platform_profile where the support is
> based on availability of ASUS_THROTTLE_THERMAL_POLICY.
>
> Because throttle_thermal_policy is used by platform_profile and is
> writeable separately to platform_profile any userspace changes to
> throttle_thermal_policy need to notify platform_profile.
>
> In future throttle_thermal_policy sysfs should be removed so that
> only one method controls the laptop power profile.

Some comments below.

...

> +       /*
> +        * Ensure that platform_profile updates userspace with the change to ensure
> +        * that platform_profile and throttle_thermal_policy_mode are in sync

Missed period here and in other multi-line comments.

> +        */

...

> +       /* All possible toggles like throttle_thermal_policy here */
> +       if (asus->throttle_thermal_policy_available) {
> +               tp = asus->throttle_thermal_policy_mode;
> +       } else {
> +               return -1;
> +       }
> +
> +       if (tp < 0)
> +               return tp;

This will be better in a form

    if (!..._available)
        return -ENODATA; // what -1 means?

    tp = ...;
    if (tp < 0)
        return tp;

...

> +       /* All possible toggles like throttle_thermal_policy here */
> +       if (!asus->throttle_thermal_policy_available) {
> +               return -1;

See above.

> +       }

...

> +       if (asus->throttle_thermal_policy_available) {
> +               pr_info("Using throttle_thermal_policy for platform_profile support\n");

Why pr_*()?

> +       } else {
> +               /*
> +                * Not an error if a component platform_profile relies on is unavailable
> +                * so early return, skipping the setup of platform_profile.
> +               */
> +               return 0;

Do it other way around,

/*
 * Comment
 */
if (!...)
  return 0;

> +       }


-- 
With Best Regards,
Andy Shevchenko
