Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB393221B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhBVVmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhBVVmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:42:20 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BF9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:41:40 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id f3so15538816oiw.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFU4xCY1lmnRTtgwAHd72b7gU2GJilKA5WuHpwi22SA=;
        b=N1FTYldZeoOzK0vtgLm7rTW/SrZeksU0UMK+hNfUjrGwLWkzgnrjW+J8221K8R/qAk
         P1RtcqMpFdUPPWRZ1qGzfLb/fllFVkWpv456DO/kEO7ByFRVthMhw4nErdSm5g1kGQ6J
         xtj7++SXbvzz+akwgRWz0RXcQqbESbDoza4lLvwf/fr+dbRpw22RXPQIcBtS34oD06YZ
         q4iNK4WJJJvHtuuHqmj+aTFS6Xr/D5QqaDXaZLV4w+RcaxLOIMnnnOE9c8YBHle77u7x
         7rz43vrISGWowpXNo0iAUQQSjESNwXYiCtdThfJInG6LQNIz+CsfS/WjKmDU6NkRnER7
         hS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFU4xCY1lmnRTtgwAHd72b7gU2GJilKA5WuHpwi22SA=;
        b=NnIomLwCY11aJjYEFRCT0jVlTmnyfmUJloXoKBiG54A/wdimpDDRbkyqFZjqUxf6sY
         QdycLZcH4kDrdJDnDTrrX7AP7CikTCYh4B40dlImRmlMksedc7nXKJ+p3JCAuK0eaIHf
         XVhxp2KlvIpOFKYM6cWG486dBfWz2u39MpQUM8q9A6QTRNTS1IWTcdpnzXSEqIrTwdYI
         u0hiCpTAgnvYvo9uvQ9BbeY4RGNzjDTFgsKD9tWP9JzIPpB2T4QHRMVJyxtICW4lRUs/
         SlFe6uVb/b/F4WN0trvcrly/J2/91DeLmZfCz0Gmol5mBNqPex/5VrleI+b5Vm0xrpHE
         LdJw==
X-Gm-Message-State: AOAM533eCACiR/H1ILEd3WN8i6RZQMyVDmlARfueu/x+YxYbA9z5GqIX
        tSZVQuq8D06rG8Q0Mn1kROX+7KrLjsPi6cm70yQ=
X-Google-Smtp-Source: ABdhPJw32ZEogvCTmpB15sh+Ll3hSPvV8Sc5iPF1lqUkxoZjhcorelbZg6kdvkFnrG3d+38kCN+sLXkRallvCqbxDB0=
X-Received: by 2002:aca:fccb:: with SMTP id a194mr7835630oii.5.1614030099987;
 Mon, 22 Feb 2021 13:41:39 -0800 (PST)
MIME-Version: 1.0
References: <1613805352-12397-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1613805352-12397-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Feb 2021 16:41:28 -0500
Message-ID: <CADnq5_OdQ8ZAV+sMFEbNJeoBXca5i87-T8_rSpzqiK-D=2Kz+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display/dc/core/dc_link_ddc: Remove unnecessary
 conversion to bool
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sat, Feb 20, 2021 at 2:16 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c:544:34-39: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> index c5936e0..45a59cf 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> @@ -541,7 +541,7 @@ bool dal_ddc_service_query_ddc_data(
>                         /* should not set mot (middle of transaction) to 0
>                          * if there are pending read payloads
>                          */
> -                       payload.mot = read_size == 0 ? false : true;
> +                       payload.mot = !(read_size == 0);
>                         payload.length = write_size;
>                         payload.data = write_buf;
>
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
