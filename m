Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B34341F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCSOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhCSOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:22:24 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB0BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:22:23 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso8679679otq.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+QTRu6EnHIJRSAxr0xqfxOd0QJj6B0MWLRcdPTUx6E=;
        b=QG1GJGF09eRn2BJfugyVxbdtWB3kouSc28Ve52z65D2tx7ZZUD23R8f8ty6P8w4Jdu
         bmIWlZYjsZg1VFL2IRknwtEbZIJNJIXG7bn+1d1EgM8d0yA9JML5LxOaH6bFGIAzbeum
         HPKyoPLxbF2Rn69l5wDiL0GSFof3fOcjPNCCT9inw0JuJU9dDBybwr2r2F8KvbB0uVPB
         TruKdtbUgTGS8ItSjHQlj/jwaGap03lCPx4S7uk6Qo4qdtQh8wuhORDslhcRytR46Gbv
         fEO0BSJQFB41G0D1lwL21P9TIm8UWdR4tHnfvnEp9ITLXPCD6VwAf0hq1me2dwns5iHy
         kejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+QTRu6EnHIJRSAxr0xqfxOd0QJj6B0MWLRcdPTUx6E=;
        b=GJdOZzscY4UYg3uUHIy++JlUE24KnYtoIlufJaxzee1ASkByK3oxIN+7FJhLUi/EzX
         p/XGoAkIvlnAHsV/c8PeDoVqjTFgWu55ROgT4tBaIgcyfF9GJFqirS8f3F3NdHfR/Bq4
         8UDVMdYj9+RCN4Qniw+C0Eaktu+oe2s8Gdvci5VLc1wfnKKVhLQ+xKKCtcF0650LzXhT
         RuyYD0cUsoZDo9QtL+7vCy+Xi9bIxZY2n2FeKDX3FMx5dUkDzwUy/t57tZBhVrH1j1Vd
         ZFUf7di6mtuQT/NxIFT+qOhmNBFelfAaglw9ojWtDW2F6wwQQivjUJ/RJLpNul+EIVVh
         hwBg==
X-Gm-Message-State: AOAM530RFkabHI7/7PItRkBj/H0DrZNRMC2M6+i6yVWceGlX5EueWdWa
        TiJD97ZOxdS6oEL5gcjPHkDRIeFXiAL4j8tdYnQ=
X-Google-Smtp-Source: ABdhPJxEwCWLzjFqAl2UnlrCHKPEGOjU2eg3HPVKAh9/P4eC++ZobzBV++X87wSuhhZv/hfDB3hKOLAzVdyEkhvo7Wk=
X-Received: by 2002:a05:6830:408f:: with SMTP id x15mr1432261ott.132.1616163743185;
 Fri, 19 Mar 2021 07:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210319164418.1.I5d51cc12776ee8993a1a54089b548952f75ada41@changeid>
In-Reply-To: <20210319164418.1.I5d51cc12776ee8993a1a54089b548952f75ada41@changeid>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Mar 2021 10:22:12 -0400
Message-ID: <CADnq5_OguuMsqT7MVC=ieNZm9mqyVUsGpQDHr59BWtBJJUvFoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Set AMDGPU_DM_DEFAULT_MIN_BACKLIGHT to 0
To:     Evan Benn <evanbenn@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stylon Wang <stylon.wang@amd.com>,
        Eryk Brol <eryk.brol@amd.com>, David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Anand <amistry@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 3:23 AM Evan Benn <evanbenn@chromium.org> wrote:
>
> AMDGPU_DM_DEFAULT_MIN_BACKLIGHT was set to the value of 12
> to ensure no display backlight will flicker at low user brightness
> settings. However this value is quite bright, so for devices that do not
> implement the ACPI ATIF
> ATIF_FUNCTION_QUERY_BRIGHTNESS_TRANSFER_CHARACTERISTICS
> functionality the user cannot set the brightness to a low level even if
> the display would support such a low PWM.
>
> This ATIF feature is not implemented on for example AMD grunt chromebooks.
>
> Signed-off-by: Evan Benn <evanbenn@chromium.org>
>
> ---
> I could not find a justification for the reason for the value. It has
> caused some noticable regression for users: https://bugzilla.kernel.org/show_bug.cgi?id=203439
>
> Maybe this can be either user controlled or userspace configured, but
> preventing users from turning their backlight dim seems wrong.

My understanding is that some panels flicker if you set the min to a
value too low.  This was a safe minimum if the platform didn't specify
it's own safe minimum.  I think we'd just be trading one bug for
another (flickering vs not dim enough).  Maybe a whitelist or
blacklist would be a better solution?

Alex


>
> Also reviewed here: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2748377
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 573cf17262da..0129bd69b94e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3151,7 +3151,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
> +#define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 0
>  #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
>  #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
>
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
