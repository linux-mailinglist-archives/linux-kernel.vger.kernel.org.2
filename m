Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB832698C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBZV3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhBZV30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:29:26 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBDAC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:28:46 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id d9so10378797ote.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0FQBH3XZRWaOEVdA/TaIzgXzrKxsUm8rwjI33W19Xo=;
        b=ulH6diblgdIknIaJzStXLEnNMmRTYNNeQtO4iHIMd4VzYKb5VvExX8hjLev31N9TKm
         7H/jkB0x6hbwcbBHoYcj+/Q9g4aeNgiHROw/yuQFrUzLvsTFilnXVm5YgQM6psNjAYgE
         oam7aoCc/pErNv0iVJF9d/Z6X1POWJ08ASKMieRCrrhiTq0e6k2HtynAcQ7iHoOhKugh
         XqQaOXSVUt7poktCQ3v0GWLjvV45jNunoKYLPlyM8AUaj3LKwHeo7IKWw2EbzRXbETCg
         ikbgwbjMtnuVp7I+tZGMmXi4LmIJD27z2Egk4CZmfjdn/Mu38p1TXBs28Yrnqr9o5Gm3
         XpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0FQBH3XZRWaOEVdA/TaIzgXzrKxsUm8rwjI33W19Xo=;
        b=KlpAp9FtNFDw1V4fOnzXQGsEU2xyIpRdqMA41JJeRWE+2nukJcQ+thh6y71PIQLx7J
         3sGan0hYioAR0B/IjboPgCgZh66vdhss5N/EsVeYOuZDPvJW5BTw+x6on1aJtmHJyqF+
         WhgrRrrbGcl/LMsKbRwVrc+24N30mHfVIr9sZglTrsyyJ6OBoiXmirzqD05huLQ3WMs9
         P1OU8u7SUOLaeVxwc93Gmd8CAmdt2ECnaVXLrVeTPy1hhnRa19TRCgVLPOkfAjZdzwdh
         P7Q00Xlnexi3YAOYX/gxf43rMPlJbH6g1caYCc5CzmHkhpc/Eistn+qcVmi+rf6VJMdM
         w4Bg==
X-Gm-Message-State: AOAM5326RPTEMLHF7NvXV3Rn/7082mtJGYeS2O8hfRxJ4d23npovj0ZT
        mfbjZs10xRe3EmapkIsuH8Zc0idREUf2oy9k5Yg=
X-Google-Smtp-Source: ABdhPJxeL1KhiiGw9G2A8daWBoi5NfRH+ResQd71t1cyA3TwtcRMdEOCybZypc2hTXvt/2T6PoxQ0GDGLIPgpa55rfg=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr3929555otl.23.1614374925511;
 Fri, 26 Feb 2021 13:28:45 -0800 (PST)
MIME-Version: 1.0
References: <1614331036-110338-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614331036-110338-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 26 Feb 2021 16:28:34 -0500
Message-ID: <CADnq5_M7hfiHW8jOv+bAcQ9kVOY3EJibGLSUPW2eB3=aPBVLVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/swsmu: Remove unnecessary conversion to bool
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 4:17 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:924:47-52:
> WARNING: conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index af73e14..2382438 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -921,7 +921,7 @@ static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu,
>         dpm_desc = &pptable->DpmDescriptor[clk_index];
>
>         /* 0 - Fine grained DPM, 1 - Discrete DPM */
> -       return dpm_desc->SnapToDiscrete == 0 ? true : false;
> +       return dpm_desc->SnapToDiscrete == 0;
>  }
>
>  static bool sienna_cichlid_is_od_feature_supported(struct smu_11_0_7_overdrive_table *od_table,
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
