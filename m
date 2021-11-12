Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C9544EFD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhKLXBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 18:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKLXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 18:01:15 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1289C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:58:23 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q124so20656830oig.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kLWDjBOEgMtaOJJM6olmmsO9ZOKebdhk4SN7pITZDc=;
        b=PxML9IrtUiXHEE7CVKrWioEu8UrZNsfdaMHsjmgeA7NmE4PYMmiTKPWPccRGGNfpss
         UjWUm6FvYcJbRcXEqzuytL0tWgyKcQwtxR5ipqAZ1cS/FZ2Ge9OYHuPUUB7t3frZYjnB
         2OBDPbsKIT+jexdTtBq3VRwvFY6a0Iup/i+HsaeT7JtuK7M/3O28MGPENnX/TA+/y9EO
         XdgNcVFHfK05mctCG/fM4WqWv2TO4jAPckTqx0osvXDFeFLmhiTd5E4rzWoUwtPcMjD9
         cUHo2dEu4XHb/7a96ZIPaZsrFCyrXNsKF2iKNfttEExeSNpLOzgGKampPMU9VKJXfdFt
         CoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kLWDjBOEgMtaOJJM6olmmsO9ZOKebdhk4SN7pITZDc=;
        b=53IJz9WHdb/NsalXLwGY+uX0z7g8cWxaPYMispVYCaM7kYi+XeDzKskhBQdzD2kTBi
         0/Y+B/60Z2/l4vE9NqL0wfPbuyIU+xvEpjvwPwaLE5++Bz4Wrc5v6VWwvMsEPEzFgCX/
         qFoThuU6Hq/rJ7BH3DmWYXtZuTaXEKNjQSPahPh3/jVWob8B2vKls3iqef8GH35nxXm+
         LJ2tISQgwz//b3aA5RwLFZSiQgmFrqwBLk3/JuO/WmeROWOqDO1kidJglidtutOduVwC
         yxP8J6FbRkkQiA6mg6ohscepZAXCp6ahyL061WPlFaBqXiOzvoS3rWWVihGdndEr8W+n
         7caw==
X-Gm-Message-State: AOAM531UUWGSEb6kbJ65anKwD5CYYPKv1xkzyshHQwH6U++5/hWSjfTP
        wO/vNNX3+vJNMynuO6ISTLlxWropq+Yvcq4rrsM=
X-Google-Smtp-Source: ABdhPJyEs2LppcBiXO8PG2byHA4/cBzJjP42JCJKB570uD0M4uIGkiDHf+Ali76TI/67E28tQF0k6v5sy9PNEfBg1FU=
X-Received: by 2002:aca:180f:: with SMTP id h15mr15803059oih.120.1636757903427;
 Fri, 12 Nov 2021 14:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20211112061651.6509-1-ye.guojin@zte.com.cn>
In-Reply-To: <20211112061651.6509-1-ye.guojin@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 12 Nov 2021 17:58:12 -0500
Message-ID: <CADnq5_PbjTWCgY-WrNdYna+Dr6F0+OiMEcjk5FpEk9VUSM9U-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix cond_no_effect.cocci warnings
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>,
        xinhui pan <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Dave Airlie <airlied@linux.ie>, Jerry Zuo <Jerry.Zuo@amd.com>,
        Vladimir Stempen <vladimir.stempen@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Ye Guojin <ye.guojin@zte.com.cn>, Jun Lei <Jun.Lei@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Nov 12, 2021 at 1:17 AM <cgel.zte@gmail.com> wrote:
>
> From: Ye Guojin <ye.guojin@zte.com.cn>
>
> This was found by coccicheck:
> ./drivers/gpu/drm/amd/display/dc/core/dc_resource.c, 2516, 7-9, WARNING
> possible condition with no effect (if == else)
>
> hdmi_info.bits.YQ0_YQ1 is always YYC_QUANTIZATION_LIMITED_RANGE.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index fabe1b83bd4f..564163a85d2c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -2509,17 +2509,7 @@ static void set_avi_info_frame(
>
>         /* TODO : We should handle YCC quantization */
>         /* but we do not have matrix calculation */
> -       if (stream->qy_bit == 1) {
> -               if (color_space == COLOR_SPACE_SRGB ||
> -                       color_space == COLOR_SPACE_2020_RGB_FULLRANGE)
> -                       hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
> -               else if (color_space == COLOR_SPACE_SRGB_LIMITED ||
> -                                       color_space == COLOR_SPACE_2020_RGB_LIMITEDRANGE)
> -                       hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
> -               else
> -                       hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
> -       } else
> -               hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
> +       hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
>
>         ///VIC
>         format = stream->timing.timing_3d_format;
> --
> 2.25.1
>
