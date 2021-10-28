Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C4643E851
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhJ1S3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1S3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:29:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA274C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:27:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q127so8334709iod.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+G6CdJ3zT0nfkzpCxbjyGyIXPvxmC0KG1xFQgJK82Go=;
        b=gej7DeSlFNmwR+cz6LTfAGp06TY2sDf6NZOIOME9jn3HgYQhzy9SFGbRebGw8lfvGI
         oxjFP3vHtgrPiLdUZgPnJiNk6N8URKVTiHRioJhz7pLc/+R9kAOtqHO8VKUG/2jVvrf3
         POI2t4wjgtRL0WeCYTQwN0KmnspDjRtMrsScU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+G6CdJ3zT0nfkzpCxbjyGyIXPvxmC0KG1xFQgJK82Go=;
        b=XlDdBV7RcEdTEt37znp/HaGBH56MDbJP8pcZ/+nip8NhSzouvTHfA7kVTN5ebpG8/8
         Lj9IhkF1lsVZ8PmXYWsi9j4E8B4dnKt76MEQQmDCIO30qjDW9d+AJdFOrZQ3wTLbvJeD
         Dsa2nJ0qnmnpjIVBLixqeJ6djGDvogqFqDyt1OPOpG/3zD/l4oi2XOCUAy9Mnv4Gn2/H
         F21D/22JwlZhHsHzVtCRnWF3Q0KAvbN31LRHueJmSGzCyNQ75RfNFM4ya7aC4a0Ba3jb
         NYxP/xV9zFQW0uGWP1Ci0/aL2grE2Sh/j0+D5LYQE3ixiGtK6RtwfTCjj558o5OKvtwX
         yPfA==
X-Gm-Message-State: AOAM531ol6vfQWn7lXG1t4gGZoOnRLzjZkDZHalE5r0SHCDDrrOpwku2
        zLEbp+QyGSGy7FrGxcP2TwpY7qeZgsMgPw==
X-Google-Smtp-Source: ABdhPJz5qY5uX+dgNl82Lk8O47XGcP1USU8MjJGRLDMr37Do5A4rKEMXupmzO+BkBZZiBoZEpkTN5A==
X-Received: by 2002:a5d:954b:: with SMTP id a11mr4257686ios.99.1635445636042;
        Thu, 28 Oct 2021 11:27:16 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id r13sm1888450ilh.80.2021.10.28.11.27.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 11:27:14 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id l7so7936571iln.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:27:13 -0700 (PDT)
X-Received: by 2002:a05:6e02:1b09:: with SMTP id i9mr4114797ilv.142.1635445633346;
 Thu, 28 Oct 2021 11:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211026220848.439530-1-lyude@redhat.com> <20211026220848.439530-4-lyude@redhat.com>
In-Reply-To: <20211026220848.439530-4-lyude@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Oct 2021 11:27:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VXJA0DoCBOG+fzqv-5rYP4mWQE-HPxH9DxCVWgnuS4Dw@mail.gmail.com>
Message-ID: <CAD=FV=VXJA0DoCBOG+fzqv-5rYP4mWQE-HPxH9DxCVWgnuS4Dw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] drm/dp: Disable unsupported features in DP_EDP_BACKLIGHT_MODE_SET_REGISTER
To:     Lyude Paul <lyude@redhat.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Satadru Pramanik <satadru@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 26, 2021 at 3:09 PM Lyude Paul <lyude@redhat.com> wrote:
>
> As it turns out, apparently some machines will actually leave additional
> backlight functionality like dynamic backlight control on before the OS
> loads. Currently we don't take care to disable unsupported features when
> writing back the backlight mode, which can lead to some rather strange
> looking behavior when adjusting the backlight.
>
> So, let's fix this by ensuring we only keep supported features enabled for
> panel backlights - which should fix some of the issues we were seeing from
> this on fi-bdw-samus.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 867cf9cd73c3 ("drm/dp: Extract i915's eDP backlight code into DRM helpers")
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index ada0a1ff262d..8f2032a955cf 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -3372,7 +3372,9 @@ int drm_edp_backlight_enable(struct drm_dp_aux *aux, const struct drm_edp_backli
>                 return ret < 0 ? ret : -EIO;
>         }
>
> -       new_dpcd_buf = dpcd_buf;
> +       /* Disable any backlight functionality we don't support that might be on */
> +       new_dpcd_buf = dpcd_buf & (DP_EDP_BACKLIGHT_CONTROL_MODE_MASK |
> +                                  DP_EDP_BACKLIGHT_FREQ_AUX_SET_ENABLE);

My first thought when reading the above was: if we're masking so much
stuff out, why do we bother reading the old value back out at all?

I guess the two places you use the old value for are:

1. You avoid setting the "DP_EDP_PWMGEN_BIT_COUNT" if the backlight
was already configured for DPCD mode.

2. You avoid writing the register if you didn't change it.

I would actually argue that use #1 is probably a bug. If you're
worried about the firmware leaving the backlight configured in a
strange way, it could very well have left the backlight configured in
DPCD mode but set a different "bit count" than you want, right? Maybe
you should just always set the bit count?

Use #2 is fine, but does it buy you anything? Are writes to the DCPD
bus somehow more expensive than reads? ...or maybe you're expecting
that a display will glitch / act badly if you write the same value
that's already there?


So I guess my instinct here is that you should avoid reading all
together and just program the value you want.

-Doug
