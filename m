Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECFC3DF4BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 20:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhHCS1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 14:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbhHCS1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:27:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F01EC061757;
        Tue,  3 Aug 2021 11:27:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j1so30786102pjv.3;
        Tue, 03 Aug 2021 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neYMRGFv1RsPRAo87VU+9LYDqXD7iPtI9TOdzPNT+VI=;
        b=R6ke4YOWxKh+a+NsrXOFzhOIojducjjBRFY6LQNuNMwPCSG041YGkUUGC2LcUVBgt7
         tc6vAgghf09iP4guj5TA6iwMIafs5/16ozLOzRyuftj9zHt/u7LMT1E71vwf5RMBh/HD
         Trlb9IkwJrDKWc2Ieo8bOEC2N/9OZC9L57wPF5g7kD1bOHOx//QIiC/4v2xr9c37Cqh2
         ydHq/I/GLqt6aO7dqj/FNXx9N7uN9VfBCjuUQpJF2lhcAwkywWm5AV2fS/thJpnADZqn
         EiMAG1qeE0kh3VPHK1nZa1QeCFJdvGn9t4H5R/3JPVTD1iGewUbhTZULnZEjQfzCdkPF
         fT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neYMRGFv1RsPRAo87VU+9LYDqXD7iPtI9TOdzPNT+VI=;
        b=rjrB7t+QXccMghPcnXEN/dGx1Fpd70YPwUyUQftxpgr6gtTBPKrXr5MA/8I8+SgjsV
         p5boXSEhgtsyY2r09oQWkr3nTuP2Ae9hRiz+rrB7n/BL0kg0Bkq7r/uZeIky7mOEJwcy
         6z5lSGmYD8RTFRzVcYCftAGdITlK3CuOI8lOLAMH3OAF8C79tyh6EMp4n13n6vs5GgPM
         1S4w3LBmmCiD2fflfcNj1qiBnLc0RFqdMAk7jG+rO7Eit4k329VbCUcuUMyWKu45BvNI
         JJj5KcbsVBgX61mxR/1LeCsrNKb8OyJcM9hlrqdfIYiGxTTACBb3Za8p5Hs3v+a22CSH
         RUzg==
X-Gm-Message-State: AOAM531AINp8M8KHvErPyHawuv8YA0wM9BPzku88QLuczmUGjKE8C6bU
        zAtLxobaIyeZFgnNKvzf4fY3JrDuBffH1jfV4K03ZWhI+Wc=
X-Google-Smtp-Source: ABdhPJxTwjCeST0OYo6uDxH2TImicKsYJ4f/zzK+tjQbcbnvnLxoR9k9k1MawD/59SFo5xDXK++gLe0ukAAyWDRsCVA=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr23303962pfi.7.1628015249763; Tue, 03
 Aug 2021 11:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210803181135.22298-1-novikov@ispras.ru>
In-Reply-To: <20210803181135.22298-1-novikov@ispras.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Aug 2021 21:26:50 +0300
Message-ID: <CAHp75Vde1RAKTCTzmt0eHjNGrKUyi7r1rtNo934WW6wqi9T=ng@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Fix potential buffer overflows
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 9:21 PM Evgeny Novikov <novikov@ispras.ru> wrote:
>
> It looks like pmc_core_get_low_power_modes() mixes up modes and
> priorities. In addition to invalid behavior, potentially this can
> cause buffer overflows since the driver reads priorities from the
> register and then it uses them as indexes for array lpm_priority
> that can contain 8 elements at most. The patch swaps modes and
> priorities.
>
> Found by Linux Driver Verification project (linuxtesting.org).

Seems legit.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 005125bfd70e ("platform/x86: intel_pmc_core: Handle sub-states generically")
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index b0e486a6bdfb..667b3df03764 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1469,8 +1469,8 @@ static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
>                 int pri0 = GENMASK(3, 0) & priority;
>                 int pri1 = (GENMASK(7, 4) & priority) >> 4;
>
> -               lpm_priority[pri0] = mode;
> -               lpm_priority[pri1] = mode + 1;
> +               lpm_priority[mode] = pri0;

I would write it as + 0, but up to you and maintainers.

> +               lpm_priority[mode + 1] = pri1;
>         }
>
>         /*
> --
> 2.26.2
>


-- 
With Best Regards,
Andy Shevchenko
