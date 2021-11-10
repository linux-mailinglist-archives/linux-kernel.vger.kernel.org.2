Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4014644C52D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhKJQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhKJQlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:41:17 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368F4C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 08:38:30 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso4713309otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 08:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8O7Ml++eH7v9/z2actv39rMvzGZ2e5JQKOxsiMZkTw8=;
        b=QrM7VQvAnnZJ+TvjkxLiZWGPxMIb6hTI8O6pku+JNbhr+GNHksX50FBzWCL1NcPRrr
         ydiJVDCElnod0CfXF2MmbbFg5JO2BXRZBCH14a/m5izYRxI8ohrc44PuyhY7I383RMWt
         DqjUlJPcD1KmcXUx+uSc4ioHT5lmNYExE5E6Oi95EgoFBSfsdWvHoT7Syq138NPWdFdm
         zfm/hQk7HxfTd237Z/PAW2EeQVH3NT0S0dtcZkrxVurbweYQwrNTT/5T4s7NpPbkWOL1
         zA/qePUjm60vNWz/y1vrd2rcQcSY3QmexqZBO+KwlB5bMib1W5IJdDnoj5t2U3X1RpfB
         WQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8O7Ml++eH7v9/z2actv39rMvzGZ2e5JQKOxsiMZkTw8=;
        b=GJqfohNo+ih7Qk9YVH/lfS0ZrKCYxL7mJC3uKivq7blLuWNdRgte8/1UVy42XAxZEq
         15abp2/BSKAsi6W5afbNJBdvxq6JhPVBi372oUG1cMfV8om8+5cgu0F3QDlQ4D3w0Pz3
         5dUSyU0O4yjQ3R39Q9SojdqaXXzcNdH84jhverxAxhfqbkXei/qb4jabk0rmeWOaIfj7
         EbVk6kepNGLzF54OGtt+7jyxltorfAUshKy0VVgz8y0SRUkGWPy6is9e0tOcYssH4OLQ
         SG+T8lfgO4JaJ4bMY/9cXTULTC2tIZKQwp8BynVg8l6T6ktBRzm4uOL9xPMDeg71rUd2
         ULAw==
X-Gm-Message-State: AOAM533LAysMQm1QZOkGs+WXOd1gX9D/ETqPSUDxU3r1Ahq4tC+TQTJk
        BGyNGZF5Z5lR7JFzQMGenP5q+7fJUjSKFBzckYIhNhmc
X-Google-Smtp-Source: ABdhPJx1W5gm5rRuISODGf7o+AkWxNCzJKvkNJD+nfmrH51sWHNEB4hodQX5h1cBPs9UGfyTt5Kb+f3snNFQM3W6aL4=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr432308oto.357.1636562309606;
 Wed, 10 Nov 2021 08:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20211110055303.136782-1-ran.jianping@zte.com.cn>
In-Reply-To: <20211110055303.136782-1-ran.jianping@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 10 Nov 2021 11:38:18 -0500
Message-ID: <CADnq5_OsymFzMqPGGkpST-Bm6rL_6tw_xjW9Lm-hTZsrNZoKvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unneeded variable
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Quan, Evan" <evan.quan@amd.com>,
        "Lazar, Lijo" <lijo.lazar@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        Dave Airlie <airlied@linux.ie>, Zeal Robot <zealci@zte.com.cn>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        ran jianping <ran.jianping@zte.com.cn>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Nov 10, 2021 at 12:53 AM <cgel.zte@gmail.com> wrote:
>
> From: ran jianping <ran.jianping@zte.com.cn>
>
> Fix the following coccicheck review:
> ./drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:1174:14-18
> :Unneeded variable
>
> Remove unneeded variable used to store return value.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index a4108025fe29..b0bb389185d5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1171,7 +1171,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
>                                    enum smu_clk_type clk_type, uint32_t mask)
>  {
>         struct amdgpu_device *adev = smu->adev;
> -       int ret = 0, size = 0;
> +       int ret = 0;
>         uint32_t soft_min_level = 0, soft_max_level = 0, min_freq = 0, max_freq = 0;
>
>         soft_min_level = mask ? (ffs(mask) - 1) : 0;
> @@ -1216,7 +1216,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
>         if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
>                 amdgpu_gfx_off_ctrl(adev, true);
>
> -       return size;
> +       return 0;
>  }
>
>  static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)
> --
> 2.25.1
>
