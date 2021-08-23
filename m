Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716E63F524B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhHWUcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhHWUcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:32:42 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE6C061796
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:31:53 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso24940304ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YztTrgwvM/nmj6MMrgNrjzMlI5AYchZazMGR/sdkBds=;
        b=BMyImnscdvSRsb5ejTiZG2NMR0fN+ONhbsHfOHRSF7zffkLBfyD+T0p/hJNUaZdKx5
         ng4yZWA1PQ5RB/dZpK9LiuqpEXBeYc6FbISJ4DF0K2k7IW31SF4jzyyBQ7Zro1Q/tXjH
         tzofHxJ0N1fIngWsfH/upkJagIVkqHnG65nBAg9oi11ytHZCZMWK5HMdbgBE7UYD9l7L
         dDSJLfQV0ZbZZ2tVWfT0vB8lZhaFj1k0mlJ34zQKSwfEr1ynk9CYS9Pf6s96jiWEIne/
         AglcdATRxi0rc+jbTrPfRTLMHgJinUqGKTyAz5aVtAEbvZmqjzwYPg59aMFP9KO3kSLz
         /5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YztTrgwvM/nmj6MMrgNrjzMlI5AYchZazMGR/sdkBds=;
        b=Z7qgHHAbiC/4/F+tY6O833m5Uy0JHQMVTEowDZJC5LBEKK6PTWvdhbfU1GRHpoKkxC
         Y2SPzdtdGJ/gCQFEF5C8KVXq7hqa1Aqlh/06GsVSiLSFjKc1vaGUT/267cT8sQhv8ym2
         ZbUkF8Rc/ebBt4wEAuizYRShDArCzv2cP5JnlUcltUZ+NqIlGMDEAJ1hmMhnCoq69D15
         isQvM0yJgLuXPW1NKtTrlKcrNGFZuH2EiIAq5A72PKps3T+g5OSI5oC3GQ0jz6BEHsnb
         1lcJItMzvcz859W6k3cmFgKAxotcKDL+nFNb1D6GZlfXxN4K9NFdi1b0S/uFeSg55wgT
         tF+A==
X-Gm-Message-State: AOAM532rjSBH7hheX08f6FIqtVqqqDtAu6vzPlGw5rHr9F1z67SDz2L4
        TO3MDDqtCzyD/x36GBELdSy2vBOjjZcY9KbYllnEKlXP
X-Google-Smtp-Source: ABdhPJxwVaCFmOhToGFrcJFOSAqw2KkSEEg6DfejiKYf8Ch06ZIbpv3b7VSinrTGBbVS5Deb+BYQ4MLKp5xAcj8k14E=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr29208288otp.23.1629750713165;
 Mon, 23 Aug 2021 13:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <YSP6Lv53QV0cOAsd@zn.tnic> <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic>
In-Reply-To: <YSQE6fN9uO0CIWeh@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 23 Aug 2021 16:31:42 -0400
Message-ID: <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
Subject: Re: ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko]
 undefined!
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <Lijo.Lazar@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 4:27 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Aug 23, 2021 at 03:49:39PM -0400, Alex Deucher wrote:
> > Maybe fixed with this patch?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5706cb3c910cc8283f344bc37a889a8d523a2c6d
>
> Nope, this one is already in:
>
> $ git tag --contains 5706cb3c910cc8283f344bc37a889a8d523a2c6d
> v5.14-rc5
> v5.14-rc6
> v5.14-rc7
>
> also, from only a quick poke so IMHO, the error says:
>
> ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> which means you need the
>
> EXPORT_SYMBOL_GPL(pm_suspend_target_state);
>
> which is in kernel/power/suspend.c which gets enabled with
>
> obj-$(CONFIG_SUSPEND)           += suspend.o
>
> and if you look at PM_SLEEP:
>
> config PM_SLEEP
>         def_bool y
>         depends on SUSPEND || HIBERNATE_CALLBACKS
>
> (notice the ||)
>
> and my randconfig has:
>
> $ grep -E "(HIBERNATE_CALLBACKS|SUSPEND)" .config
> # CONFIG_SUSPEND is not set
> CONFIG_HIBERNATE_CALLBACKS=y
>
> which means, you need:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 4137e848f6a2..a9ce3b20d371 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1040,7 +1040,7 @@ void amdgpu_acpi_detect(void)
>   */
>  bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
>  {
> -#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_PM_SLEEP)
> +#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
>         if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>                 if (adev->flags & AMD_IS_APU)
>                         return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
>
>
> but whether that gives you what you want for amdgpu, you probably need
> to ponder on a bit.
>
> I sincerely hope that helps a little.

Thanks.  I think that should do the trick.  Care to send that as a formal patch?

Alex
