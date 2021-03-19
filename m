Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC41D341B86
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSLav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCSLab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:30:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:30:30 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m7so3469575pgj.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBRi75+4ZXFYImT5TGU9kGKxGRhGqVxM6M+tAV+mb/E=;
        b=UazQNSNh6OqCQMM7wl92C43GmrPxGV3RZTO1y89v5bBE501r/9WKGlixY+7tAGZMeL
         v1rihy7KJQrRr70kCLg1utX4ZLw15BnWYkmDtcze4PGsl5h7zGOhqRfvfnX7iZri2IeK
         m/E/gTkDMa8E8Jsmtqf12BlJY9luyi+9POcFQErCOwISZg9gXbdzRWg7CGnS6s0afTFs
         WUKpqnWVcxnm86q8NVsJV6ijswLLKfpq6/o5BLRXQ00OZJLwvJ3rYSR5fYBo/vmkhNxx
         ns5vkqPFqwJyGnanDCUOVTbGsq9M6ylYB7FQINiZPwOtBnWlRFqlE2Adv0FI5b9jdTDc
         ejeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBRi75+4ZXFYImT5TGU9kGKxGRhGqVxM6M+tAV+mb/E=;
        b=l9sGuzeBynG3b0kZ+IQiJKuCXQoD1QtVPnwTCDPwSC1anxaKQ03sPXJDllhDikhIsx
         ZzGXmvSx8WPSkeFNlWrKr7S+RrAoJnZpMmKlB30dbKh8A/+KaAof2jc+Fd+Sr/5YQBOa
         Yfbzo0HsuzMh20MAjKOTwD0RKhgcJ2AJ0ZeynClQhn90WjgY+2C2VzlrOpS53JtKfqm3
         WgBeYtS4lgPeD7soHboteYvaT2S2UPK9EKHPiP5kpBOwI93av+Rvvd+Xu9uUFXeE+yqN
         q1jS3MFcz1d3+7UQb9VIy/3pWguN1tHklQzwT0IZPZEcKfmE3WJvKXmim9qYafacj5dv
         JFUw==
X-Gm-Message-State: AOAM533Fo6o2PCYqzMAb5TAK1dI/dCpG54jSOoH1vCsrPku6HQwhWvsm
        PxjJcdMjxgdR4cLTWJVcHwk10HNyyJWVSaVOzk6PXA==
X-Google-Smtp-Source: ABdhPJyueJqbCvxvjsAE48+4+uzNTfZK3apwOOTQ5ZGtvQfah7LFUXUY4ry2appxkZ5SC84t3BxNou620Ggqog2+hro=
X-Received: by 2002:a05:6a00:b54:b029:207:2a04:7b05 with SMTP id
 p20-20020a056a000b54b02902072a047b05mr8786871pfo.12.1616153430352; Fri, 19
 Mar 2021 04:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com> <20210219215326.2227596-19-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-19-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Mar 2021 12:30:19 +0100
Message-ID: <CAG3jFyv2F7ri4wQcwipoLT6nr-K_SWpLcAFi_B0Lo_O+KaWo2w@mail.gmail.com>
Subject: Re: [PATCH 18/30] drm/print: Fixup DRM_DEBUG_KMS_RATELIMITED()
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lyude,

Thanks for the patch,

On Fri, 19 Feb 2021 at 22:59, Lyude Paul <lyude@redhat.com> wrote:
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
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  include/drm/drm_print.h | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index f32d179e139d..3a0c3fe4d292 100644
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
> +#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)                                    \
> +({                                                                                               \
> +       static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST); \
> +       const struct drm_device *drm_ = (drm);                                                   \
> +                                                                                                 \
> +       if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))                         \
> +               drm_dev_printk(drm_ ? drm_->dev : NULL, KERN_DEBUG, fmt, ## __VA_ARGS__);        \
>  })

checkpatch --strict is unhappy about the tabs/spaces in this patch


ERROR: code indent should use tabs where possible
#48: FILE: include/drm/drm_print.h:531:
+
                           \$

WARNING: please, no spaces at the start of a line
#48: FILE: include/drm/drm_print.h:531:
+
                           \$


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
> 2.29.2
>
