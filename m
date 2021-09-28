Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF97041B7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbhI1UB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242535AbhI1UB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:01:58 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90069C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:00:18 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p80so104502iod.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tt9tt/F3IxLyQ34cK+9pj6tNPzMMJ1v10W8CXUTZIXc=;
        b=N3sK4GpDM7NoausvCZ7uvCv2xW8y1o2GqpLxTtHdEz+qukAhK9GRVXI15tRB36rXkG
         nIIXXm2zgad8mAZpCf5s5YQsjUW2aE4PBDSL5ia/k1Nt9Mo4BFgPQLAOAlIwoYQXGXuH
         fmr97KMI5Q8zlbFdiIq/dYgMzPBdrUuYP8EE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tt9tt/F3IxLyQ34cK+9pj6tNPzMMJ1v10W8CXUTZIXc=;
        b=EUMCHqMSOPukuIYrexg8rgzda8ik8uOK2S8e/Xe6j4KnyTVyeLqqTzY1+v7Ge56ABf
         vOOm3G46LBdRoY+ZP/9sVdCUjXnLnvScrlNqpiflZ6iSYfLrQyDOfSHHbCDzbKwZxLEc
         pt4tI3ucJSB+Zrln+wnrwmv7xsmQmynD319MC0wtWYmDW3CU2Ipbt6GtdfjKJ7Vn1t39
         upYAh9AHZGtfiY5m9JxiEpN5rLPM/TQHK0ccSo1jTKe1iBDh1gVSL9GyU1QFSJQSluFj
         chhs1Uc5oLGSoGKm3fZnHxZ12R+5XuqOA8HmjgLKXLZDq38a/pDT1OcE6Lj9LSsYRMIl
         0k2w==
X-Gm-Message-State: AOAM530VOV8DIxLigqsszIhQBgk2QBzQMiq3acZ/HM1xDUTS3j7s1NuO
        DWsZPINC+lMVYhrKiq5xDvUp/ME7Q7+ydA==
X-Google-Smtp-Source: ABdhPJz46h5/SAf+ZB5e/6ZuYjDCAcSsf6UnmGCXQxrZiw4d6he07xc3cNEpGomGLTyzfeHR9UZOtQ==
X-Received: by 2002:a05:6638:2183:: with SMTP id s3mr6231605jaj.11.1632859217392;
        Tue, 28 Sep 2021 13:00:17 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id r7sm11392215ilm.5.2021.09.28.13.00.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 13:00:16 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id y15so239446ilu.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:00:15 -0700 (PDT)
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr5900911ilv.180.1632859215623;
 Tue, 28 Sep 2021 13:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210927201206.682788-1-lyude@redhat.com> <20210927201206.682788-3-lyude@redhat.com>
In-Reply-To: <20210927201206.682788-3-lyude@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Sep 2021 13:00:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V00-z=zvh6oZVYt7Hw00o07zEYxCa4zMrCmgNKEzcBCw@mail.gmail.com>
Message-ID: <CAD=FV=V00-z=zvh6oZVYt7Hw00o07zEYxCa4zMrCmgNKEzcBCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/dp, drm/i915: Add support for VESA backlights
 using PWM for brightness control
To:     Lyude Paul <lyude@redhat.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rajeev Nandan <rajeevny@codeaurora.org>,
        Satadru Pramanik <satadru@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 27, 2021 at 1:12 PM Lyude Paul <lyude@redhat.com> wrote:
>
> @@ -3305,11 +3313,10 @@ EXPORT_SYMBOL(drm_edp_backlight_enable);
>   * @bl: Backlight capability info from drm_edp_backlight_init()
>   *
>   * This function handles disabling DPCD backlight controls on a panel over AUX. Note that some
> - * panels have backlights that are enabled/disabled by other means, despite having their brightness
> - * values controlled through DPCD. On such panels &drm_edp_backlight_info.aux_enable will be set to
> - * %false, this function will become a no-op (and we will skip updating
> - * %DP_EDP_DISPLAY_CONTROL_REGISTER), and the driver must take care to perform it's own
> - * implementation specific step for disabling the backlight.
> + * panels have backlights that are enabled/disabled via PWM. On such panels
> + * &drm_edp_backlight_info.aux_enable will be set to %false, this function will become a no-op (and
> + * we will skip updating %DP_EDP_DISPLAY_CONTROL_REGISTER), and the driver must handle disabling the
> + * backlight via PWM.

I'm not sure I understand the comment above. You say "enabled/disabled
via PWM" and that doesn't make sense w/ my mental model. Normally I
think of a PWM allowing you to adjust the brightness and there being a
separate GPIO that's in charge of enable/disable. To some extent you
could think of a PWM as being "disabled" when its duty cycle is 0%,
but usually there's separate "enable" logic that really has nothing to
do with the PWM itself.

In general, it seems like the options are:

1. DPCD controls PWM and the "enable" logic.

2. DPCD controls PWM but requires an external "enable" GPIO.

3. We require an external PWM but DPCD controls the "enable" logic.

Maybe you need a second "capability" to describe whether the client of
your code knows how to control an enable GPIO? ...or perhaps better
you don't need a capability and you can just assume that if the client
needs to set an "enable" GPIO that it will do so. That would match how
things work today. AKA:

a) Client calls the AUX backlight code to "enable"

b) AUX backlight code will set the "enable" bit if supported.

c) Client will set the "enable" GPIO if it knows about one.

Presumably only one of b) or c) will actually do something. If neither
does something then this panel simply isn't compatible with this
board.


> +/**
> + * drm_edp_backlight_supported() - Check an eDP DPCD for VESA backlight support
> + * @aux: The AUX channel, only used for debug logging
> + * @edp_dpcd: The DPCD to check
> + * @caps: The backlight capabilities this driver supports
> + *
> + * Returns: %True if @edp_dpcd indicates that VESA backlight controls are supported, %false
> + * otherwise
> + */
> +bool drm_edp_backlight_supported(struct drm_dp_aux *aux,
> +                                const u8 edp_dpcd[EDP_DISPLAY_CTL_CAP_SIZE],
> +                                enum drm_edp_backlight_driver_caps caps)
> +{
> +       if (!(edp_dpcd[1] & DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP))
> +               return false;
> +
> +       if (!(caps & DRM_EDP_BACKLIGHT_DRIVER_CAP_PWM) &&
> +           (!(edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP) ||
> +            !(edp_dpcd[2] & DP_EDP_BACKLIGHT_AUX_ENABLE_CAP))) {

Elsewhere you match DP_EDP_BACKLIGHT_AUX_ENABLE_CAP against
edp_dpcd[1]. Here you match against [2]. Are you sure that's correct?


>  /*
>   * DisplayPort AUX channel
>   */
> @@ -2200,7 +2182,11 @@ drm_dp_has_quirk(const struct drm_dp_desc *desc, enum drm_dp_quirk quirk)
>   * @pwm_freq_pre_divider: The PWM frequency pre-divider value being used for this backlight, if any
>   * @max: The maximum backlight level that may be set
>   * @lsb_reg_used: Do we also write values to the DP_EDP_BACKLIGHT_BRIGHTNESS_LSB register?
> - * @aux_enable: Does the panel support the AUX enable cap?
> + * @aux_enable: Does the panel support the AUX enable cap? Always %false when the driver doesn't
> + * support %DRM_EDP_BACKLIGHT_DRIVER_CAP_PWM

Why is aux_enable always false if it doesn't support
DRM_EDP_BACKLIGHT_DRIVER_CAP_PWM? It doesn't seem like the code
enforces this and I'm not sure why it would. Am I confused?
