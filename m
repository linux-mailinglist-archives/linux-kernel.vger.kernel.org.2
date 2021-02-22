Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9303221A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhBVVlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhBVVkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:40:21 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC92AC06178B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:39:40 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 12so12793148oij.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bpwLuoH4voXjwzIWIXFj730L/u03ILuA10nlROuAAPg=;
        b=RtSm4vGAQI/k15Zc+MhbWThYoVIHUBjRuiLTgwMzhNx9gW+mM8DVoSBXcJ6KwFyLl7
         NADk5NS010JkZuflRXd5PV8s441E+xM5z1LqqW793M+o15pzmWBPJsh42ng0IF5HPS78
         /X7OHqNoetoB66FJwwXIs21AF2rD68zJBzkFdA4Cnt0ZzpbmSt5atLW07DoekekBQJz5
         Y07Kz+PG2nxYw0Eyr94zVgFwXyvZGoGj2CIrpTsnr2gvOpAflaryBTciwv+/z8z72cdY
         0334AjBlMLr8s/oZTftypjnYuhuHl1HyofiulEBY8zKxtMi+nZXvgzTtL7NHqxZDQA0h
         ts2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bpwLuoH4voXjwzIWIXFj730L/u03ILuA10nlROuAAPg=;
        b=HXL+ruWr9PYCEnwByZAJLQXFvOL8cRIPVDdiIbSrNyc7LJlUP5GUvmyKPW4XI9J/8V
         +0hWDPIKnE7ROKvBTR3qdgROkvfwzsv+TkAQTwxTXKZLEswcpV7TWemUbq3wLZBSD1Y5
         Q+R1zwxgXcoEBOtmmPlwravU9Psun5bArn7EWy74bLyQB/GdHUrldoztlYjZCyNfLvW9
         5yEHMhZk8JVin1vpzJaFZFulgXcKK9PZk+pw1xuj7CCdzJyUMxa8Uehqf01ogtkjBmDm
         kq/ylF78lfWFH5gb1dWYnuwkblEidO+dcOAWjyXZrBToFikYv6pIaDgSXQPOBwy2D+pE
         sVcA==
X-Gm-Message-State: AOAM530SmpibypEUPUMsUGWaKexP9BnAel99IQWRaVIJzjqboTPQUehC
        NvqSaafuJja2NqdKIzq+eMeV9tS3IfCiTLtUF2TcN2OU
X-Google-Smtp-Source: ABdhPJz+XTEBh9rMRWrP+PL5NjbeiM01iVf+NigQOaTQ4Euq6MJtWEU8l9nuBVdXGl6KOkHStItZEKJQdkzgpo2u6Rk=
X-Received: by 2002:aca:fccb:: with SMTP id a194mr7832287oii.5.1614029980194;
 Mon, 22 Feb 2021 13:39:40 -0800 (PST)
MIME-Version: 1.0
References: <1613789706-100430-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <DM6PR12MB2619934BA14F887DF37BF2C2E4819@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619934BA14F887DF37BF2C2E4819@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Feb 2021 16:39:29 -0500
Message-ID: <CADnq5_MW6S+MH4U4Za6NN3XNPhKqVtKJ67ZycdPQfbn1xhX2Wg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/swsmu/navi1x: Remove unnecessary conversion
 to bool
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Feb 21, 2021 at 10:15 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiapen=
g Chong
> Sent: Saturday, February 20, 2021 10:55 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>; airlied@linux.ie; li=
nux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; amd-gfx@lists.=
freedesktop.org; daniel@ffwll.ch; Koenig, Christian <Christian.Koenig@amd.c=
om>
> Subject: [PATCH v2] drm/amdgpu/swsmu/navi1x: Remove unnecessary conversio=
n to bool
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c:900:47-52: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index cd7efa9..58028a7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -897,7 +897,7 @@ static bool navi10_is_support_fine_grained_dpm(struct=
 smu_context *smu, enum smu
>         dpm_desc =3D &pptable->DpmDescriptor[clk_index];
>
>         /* 0 - Fine grained DPM, 1 - Discrete DPM */
> -       return dpm_desc->SnapToDiscrete =3D=3D 0 ? true : false;
> +       return dpm_desc->SnapToDiscrete =3D=3D 0;
>  }
>
>  static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdr=
ive_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap)
> --
> 1.8.3.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cevan.q=
uan%40amd.com%7C443a5df938954827326108d8d6582201%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637495021310885387%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6E=
TadiVbRBgbXfEbkXbxTX%2F1Ozg1wp3Nr9lHGF3SKHk%3D&amp;reserved=3D0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
