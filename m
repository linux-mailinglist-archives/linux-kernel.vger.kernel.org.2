Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13FA390761
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhEYRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbhEYRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:21:01 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E860C06138C
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:19:30 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v8so31207529qkv.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0I/7mJjy8fAtyuQW3u9pKYduA4z2KSC8v2zpf0k2q4Q=;
        b=LoEAi62rRu7tHFsRIAnERe0Uo6+lB7bp00VbsoFCad2BNA4J/p4XQRSUgdI2W2YwpI
         BCwReshEWdDvXBR49YxtAe1g92O1OceM2w/LWlaEzlpySS/rDNROaMb5tLKesjeJPP0X
         CNKYpCq57mgvBz5whA92hLzX7uNngLYIcuAIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0I/7mJjy8fAtyuQW3u9pKYduA4z2KSC8v2zpf0k2q4Q=;
        b=j+ztDDh+QMYxo7eeL5nTZ7ot6WVM46dpBSQmzzSu0LdzU/ZD+7kayhrr+rfKC2mtTZ
         EVGu/DIly34u/wdHvnGwU8cqCR3kmSffVQF7QkJj13c3ck5q6Lv96D5QJYWvmmjx4tTu
         DqFdeLd33kOkwWVBQySMtEdQefVozUf3GsDug8frzs9zMxUcp3X97sDHFVDNf4ynD3x+
         H2d6Vq+u35D5hcearjQxMFNy015ouvc3/XhxPpyJqWBhvMtU6h2mPDYbHMBGNND04yWz
         CyLKhNZsG672NRSjmyIdA8HaDgjulMqdPmCLAPW6MDz4xOg/Jum+1lbJKU0FQ2z0b/pk
         hvsQ==
X-Gm-Message-State: AOAM531UVwWzuvHTrm6WuHlkcNBz5yv76g6msKgbssao+fi3V0qFoJqz
        jJaW4p7kD2NQlMOfMgOA23pDUQhabd6vkA==
X-Google-Smtp-Source: ABdhPJyRIiVAnJmIwOqPPdXSGSztMMca7Q+0p+T5K2pkTJwXorHvJV4DHoAgJT6n8ctGKqsGfZa9Gw==
X-Received: by 2002:a37:a254:: with SMTP id l81mr34482345qke.175.1621963169895;
        Tue, 25 May 2021 10:19:29 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id p17sm12865092qkg.67.2021.05.25.10.19.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 10:19:29 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id r8so44044103ybb.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:19:29 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr44274582ybp.476.1621963168291;
 Tue, 25 May 2021 10:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <1621927831-29471-1-git-send-email-rajeevny@codeaurora.org> <1621927831-29471-5-git-send-email-rajeevny@codeaurora.org>
In-Reply-To: <1621927831-29471-5-git-send-email-rajeevny@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 May 2021 10:19:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=VtC9EGyxUGptRN1=PcKwyWLEyRfA9J1frTVPCKY68w@mail.gmail.com>
Message-ID: <CAD=FV=X=VtC9EGyxUGptRN1=PcKwyWLEyRfA9J1frTVPCKY68w@mail.gmail.com>
Subject: Re: [v4 4/4] drm/panel-simple: Add Samsung ATNA33XC20
To:     Rajeev Nandan <rajeevny@codeaurora.org>
Cc:     y@qualcomm.com, dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>, mkrishn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 25, 2021 at 12:31 AM Rajeev Nandan <rajeevny@codeaurora.org> wrote:
>
> Add Samsung 13.3" FHD eDP AMOLED panel.
>
> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> ---
>
> Changes in v4:
> - New
>
>  drivers/gpu/drm/panel/panel-simple.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index caed71b..21af794 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3644,6 +3644,37 @@ static const struct panel_desc rocktech_rk101ii01d_ct = {
>         .connector_type = DRM_MODE_CONNECTOR_LVDS,
>  };
>
> +static const struct drm_display_mode samsung_atna33xc20_mode = {
> +       .clock = 138770,
> +       .hdisplay = 1920,
> +       .hsync_start = 1920 + 48,
> +       .hsync_end = 1920 + 48 + 32,
> +       .htotal = 1920 + 48 + 32 + 80,
> +       .vdisplay = 1080,
> +       .vsync_start = 1080 + 8,
> +       .vsync_end = 1080 + 8 + 8,
> +       .vtotal = 1080 + 8 + 8 + 16,
> +       .flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};
> +
> +static const struct panel_desc samsung_atna33xc20 = {
> +       .modes = &samsung_atna33xc20_mode,
> +       .num_modes = 1,
> +       .bpc = 10,
> +       .size = {
> +               .width = 294,
> +               .height = 165,
> +       },
> +       .delay = {
> +               .disable_to_power_off = 150,
> +               .power_to_enable = 150,
> +               .hpd_absent_delay = 200,
> +               .unprepare = 500,
> +       },
> +       .connector_type = DRM_MODE_CONNECTOR_eDP,
> +       .uses_dpcd_backlight = true,

From my feedback on the previous patch in this series, I believe the
"uses_dpcd_backlight" property should be removed and this should be
auto-detected. Other than that this patch looks fine to me. Feel free
to add my Reviewed-by tag next spin when that property is removed.
