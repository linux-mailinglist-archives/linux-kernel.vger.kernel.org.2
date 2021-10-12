Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547B542AE32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhJLUwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhJLUwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:52:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37029C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:50:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so2789601pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=niP7v3xFwLnCjLXmT0nzm06tTYa6qI3k7igZv8TEJsc=;
        b=MrnlfgVEgsrzhHRtZFc5utknl/ytW5WjQcYfTv2HnZ6fS9lKKuW+F42Nrbx+gHripS
         Xc2RIA6gaKDSc/bn3xBmR20a0BtY+7gzFpyZmggMd//w3Ub3xZ+2jCun1uq9tVGlgJIT
         sVMI8bJ+eODJIFrgH34toluuVDOHJLd8ha9UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niP7v3xFwLnCjLXmT0nzm06tTYa6qI3k7igZv8TEJsc=;
        b=EzYH18vnTAtxEZmBKQbf+m4f37QvT7OCNdcCJhRhmL0WIFZQhFYNRjfsN4ADlDW9P/
         VjjNheNABOKHIjJ1aIPzc5qrtpdFilV/7vLTTZC+nzwJFsVyE46Eyh4b607Wt6qCkxwZ
         ULiOUdl/lrrh10e9a6k+IP9MKwtLBAo8EFQhHAprtgOs4QPQeH78qAIxyLN8S9vxfZ27
         gDc10WtHmYWdfTk3YjD2EoXFI8ORWQCJwIjFcAXOleSycWEnw2r/DqVKZK5Ij2LAXM5d
         LtbfMrlrZThEUv/RTDUDPuFsWHI3H68S2M45oeSel5GkGbRb3oNj1ffPPkJR82I8glKY
         mymw==
X-Gm-Message-State: AOAM533l7N2tBbA4Q06D++GSzoYMUa9fAd01J+HotfnW3X7nDc/iIM1r
        C+6zWJnPDfdj+vEgoyl32q5yXVAPAh/g/g==
X-Google-Smtp-Source: ABdhPJwMrNZVf/uCIGNke+KhPOuFe2TfzE2YxhhhBLQHGfz84Sz3avFPR0sXDjQkafDtZXBlu7WWGw==
X-Received: by 2002:a17:90a:7d05:: with SMTP id g5mr8568637pjl.14.1634071830488;
        Tue, 12 Oct 2021 13:50:30 -0700 (PDT)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id s20sm12294899pgq.85.2021.10.12.13.50.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 13:50:30 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id r2so231242pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:50:30 -0700 (PDT)
X-Received: by 2002:a6b:f915:: with SMTP id j21mr25937447iog.98.1634071515111;
 Tue, 12 Oct 2021 13:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211006024018.320394-1-lyude@redhat.com> <20211006024018.320394-5-lyude@redhat.com>
In-Reply-To: <20211006024018.320394-5-lyude@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Oct 2021 13:45:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WV15+qBBA8ZcgxwOQ=i_LHsytdrUWyqZHZZBwuJJ6CFQ@mail.gmail.com>
Message-ID: <CAD=FV=WV15+qBBA8ZcgxwOQ=i_LHsytdrUWyqZHZZBwuJJ6CFQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drm/dp, drm/i915: Add support for VESA backlights
 using PWM for brightness control
To:     Lyude Paul <lyude@redhat.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
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
        Sean Paul <seanpaul@chromium.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 5, 2021 at 7:41 PM Lyude Paul <lyude@redhat.com> wrote:
>
> @@ -1859,8 +1859,7 @@ drm_dp_sink_can_do_video_without_timing_msa(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
>  static inline bool
>  drm_edp_backlight_supported(const u8 edp_dpcd[EDP_DISPLAY_CTL_CAP_SIZE])
>  {
> -       return (edp_dpcd[1] & DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP) &&
> -               (edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP);
> +       return !!(edp_dpcd[1] & DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP);
>  }

nit: I don't believe that the "!!" is needed in the above. C should
automatically handle this since the return type of the function is
"bool".

I've reviewed the generic (non-intel) code and it looks like a
reasonable approach to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
