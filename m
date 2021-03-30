Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D3A34E5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhC3Kng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhC3Kn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:43:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F21EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:43:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l1so5941574plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inEEvxoI2d27PWTByb00t7709zab101mRTK+HEEURs0=;
        b=C9+RPFkWx1dnLku0VJzXhT4WCqoHsMPAfkkwl/4KohDQakhhONCUx+woSyEwYjrpXR
         t1d16MDlzS32+twkwF9bbNrzqgVVnTIfoI0AZogYL4G1S7OgpeJg0emu3T5/HWp5kcJG
         ++epmYQmqILHMzY2hL2QmPVz7uTVYnSW6ybUpM4NE/4ka6AX9/8CrsJwa6V5+njYVIo+
         XgbVwDjQ2vtltDtglB4fNijvaQUZc0s53NH8e1EYls6/XbWYbhbOWqh0zjfmI0VBaOGj
         vhK9ArLDxUL+ZjLu/rXXyDanwAeMXX50oJ08dRer+OEiWgpVZHK0JFYQd9TBlKlb28DY
         jk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inEEvxoI2d27PWTByb00t7709zab101mRTK+HEEURs0=;
        b=odv5PvlFbWkxWXy2teS8U/2KzWu9H4xXvqEx6whdir4tetH2zrK2fC/eQWDYLC97sR
         5czjhPMq47PPjoW0ufj4qqbEouwjRy3kFxyZdJfunppaVOUCnSnKboinjXRdxDjbVwuO
         WMVXE/c1069hqUdWsNETaguusVpRvwVpZAizCBq2EW6Pn/i+ReFkcEWX/ODBGOrJFPdk
         SUL3SwYcjGgWa0kpPFpg4F50LaMvcbeodL+oH2VdpqHiO9nEzF5HUbI4lhWbSqUhRRti
         F61u7HuhKNP6P4pC62gsMgu9Xl5Qh1V7IozOepKycr1B5w9ygEZRP8+vK2srVKEE6XS7
         wp/g==
X-Gm-Message-State: AOAM533ZiSmQWziu2I1kmW8Od00xLpQ99s0xPu3cWBFqYDMbpjKjiJJF
        33A0XnU9XP0xf6aBCKuDOJ8waAg8J8HBnK1COmOlJQ==
X-Google-Smtp-Source: ABdhPJxPMfsifg57CMk+e08YOVt3TzMww6aMvw5ulnMzAx23GI1ES2FVCsm8qjLz2RBA6UgJxREJNfH8cDlZ1xM4T2Y=
X-Received: by 2002:a17:902:e752:b029:e6:822c:355c with SMTP id
 p18-20020a170902e752b02900e6822c355cmr32807495plf.69.1617101006157; Tue, 30
 Mar 2021 03:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210326203807.105754-1-lyude@redhat.com> <20210326203807.105754-8-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-8-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 30 Mar 2021 12:43:15 +0200
Message-ID: <CAG3jFyvK6bk5mF_Jp6w9HpN2rDAPKkdHKbQMRKiW6gGKdR9-Yw@mail.gmail.com>
Subject: Re: [PATCH v2 07/20] drm/print: Fixup DRM_DEBUG_KMS_RATELIMITED()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lyude,

I'm seeing no issues with this patch and the reasoning behind the
patch is sound to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 26 Mar 2021 at 21:39, Lyude Paul <lyude@redhat.com> wrote:
>
> Since we're about to move drm_dp_helper.c over to drm_dbg_*(), we'll want
> to make sure that we can also add ratelimited versions of these macros in
> order to retain some of the previous debugging output behavior we had.
>
> However, as I was preparing to do this I noticed that the current
> rate limited macros we have are kind of bogus. It looks like when I wrote
> these, I didn't notice that we'd always be calling __ratelimit() even if
> the debugging message we'd be printing would normally be filtered out due
> to the relevant DRM debugging category being disabled.
>
> So, let's fix this by making sure to check drm_debug_enabled() in our
> ratelimited macros before calling __ratelimit(), and start using
> drm_dev_printk() in order to print debugging messages since that will save
> us from doing a redundant drm_debug_enabled() check. And while we're at it,
> let's move the code for this into another macro that we can reuse for
> defining new ratelimited DRM debug macros more easily.
>
> v2:
> * Make sure to use tabs where possible in __DRM_DEFINE_DBG_RATELIMITED()
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> ---
>  include/drm/drm_print.h | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index f32d179e139d..a3c58c941bdc 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -524,16 +524,20 @@ void __drm_err(const char *format, ...);
>  #define DRM_DEBUG_DP(fmt, ...)                                         \
>         __drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
>
> -
> -#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...)                            \
> -({                                                                     \
> -       static DEFINE_RATELIMIT_STATE(_rs,                              \
> -                                     DEFAULT_RATELIMIT_INTERVAL,       \
> -                                     DEFAULT_RATELIMIT_BURST);         \
> -       if (__ratelimit(&_rs))                                          \
> -               drm_dev_dbg(NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__);      \
> +#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)                                  \
> +({                                                                                             \
> +       static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);\
> +       const struct drm_device *drm_ = (drm);                                                  \
> +                                                                                               \
> +       if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))                        \
> +               drm_dev_printk(drm_ ? drm_->dev : NULL, KERN_DEBUG, fmt, ## __VA_ARGS__);       \
>  })
>
> +#define drm_dbg_kms_ratelimited(drm, fmt, ...) \
> +       __DRM_DEFINE_DBG_RATELIMITED(KMS, drm, fmt, ## __VA_ARGS__)
> +
> +#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...) drm_dbg_kms_ratelimited(NULL, fmt, ## __VA_ARGS__)
> +
>  /*
>   * struct drm_device based WARNs
>   *
> --
> 2.30.2
>
