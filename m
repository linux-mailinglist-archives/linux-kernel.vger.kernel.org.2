Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFF3258AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhBYVbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhBYVbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:31:44 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75435C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:31:04 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id n19so1722542ooj.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iJBm8mwb9g0tbzXMjQMrV+sZ/dkoZZpwUu4VHqMwWs=;
        b=saAXPMJHPwxOKN9qHujc6Ftk1IhGH00YldtkPbXQx3+a3J1pTSu/Yb2tjmjutFWZhA
         8plWq8Ark/GQeSFOT0SmX0WX1aXZssKwlutFSMSKrHAKq5vZogkhREelec2C/gHuONws
         kqDP0VF2OJ0YyUDcV7kfHLPfr9zKm6IqeFy4MPOaqsXLInh23ohAnn/y1MwPj9grwvlD
         s9gRKC/NGiSUiV84o5AZmM/0O+SGlh0BBCdw2IZkEsxklVT4XQjQNc2cU145ft7uIKCh
         cxTi98cRbe773Fg1YJZgKY3LwBwqRbtqYCUPiajCu5hqKyfdat7rwFAieRk7vmAHz70c
         NVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iJBm8mwb9g0tbzXMjQMrV+sZ/dkoZZpwUu4VHqMwWs=;
        b=f3m19WTeFrqpKE5u7ABKSgz3fovh+kFWBlKHgdEhDDtTidd1wlGEjoychmSJG8Y9Bs
         rBDYlGOVS2SzHHgXpLSTAQim0T0CAmHz1Eir7R5P3kc1ZU4mdqjkxYoXUjMnDxvlON48
         ssuTwGOmZDRP1iZ4daqDqa9XGp564uL072PFWPvKocHs/lk/IsN/Vg4jkX+/pgfy870H
         rSou1RRhyGSEMs6zpFaDjuSH65V2Aq5BKpC6MKFOXlrM/s7/vEcGMpWP5bqBBWLcUCIm
         sLyOzbi3AMwQTLzFUsTymA8VVkcK+GvidKybAbAJgFbCh0FILhhFE8lJlyy4mp5SPOCq
         /gMA==
X-Gm-Message-State: AOAM531yp8194qHxyswGx28h/DplaJQeCWnZEj1Dn71fWDTJA4PYE3S6
        hNcRpNwyIGQ9bQvxE82y2nR4YBFizyAadFKiMhM=
X-Google-Smtp-Source: ABdhPJwzqcw5WVktyTlPS7c1vX8XU71qqt0U0NU7W3IdGqEL6xrX54Tk5v2JI/V57TOa0LGRExqirx6rzZes2A/Z/4o=
X-Received: by 2002:a4a:88ee:: with SMTP id q43mr3928324ooh.61.1614288663762;
 Thu, 25 Feb 2021 13:31:03 -0800 (PST)
MIME-Version: 1.0
References: <1614244742-67869-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614244742-67869-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Feb 2021 16:30:52 -0500
Message-ID: <CADnq5_OwCB1+uXRoqHfkHp3t6kvY8Emu=pLgoTJ6VkyWPFJDLw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unnecessary conversion to bool
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

On Thu, Feb 25, 2021 at 4:19 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c:243:67-72:
> WARNING: conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
> index 3398540..102f6a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
> @@ -240,7 +240,7 @@ bool dpp3_program_gamcor_lut(
>                 next_mode = LUT_RAM_A;
>
>         dpp3_power_on_gamcor_lut(dpp_base, true);
> -       dpp3_configure_gamcor_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
> +       dpp3_configure_gamcor_lut(dpp_base, next_mode == LUT_RAM_A);
>
>         if (next_mode == LUT_RAM_B) {
>                 gam_regs.start_cntl_b = REG(CM_GAMCOR_RAMB_START_CNTL_B);
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
