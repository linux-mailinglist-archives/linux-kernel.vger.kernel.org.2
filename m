Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DAB32ACFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448126AbhCBVSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835152AbhCBSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:22:45 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F939C061222
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:22:04 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id h22so20929429otr.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0V4NppJX6K9gT+Ur7cLKD7613ioC61Z7I5irbavVEYA=;
        b=qZefZTyNlgwXtOJORNJkek/yKCs0FmZ9ALgW1by4vpG5bJAQfZq3eomusKgQ8/z2mx
         8LD5RIo89t0oMYXgZKB/8fczTMZrkgHwPLF3nqN402fRBaDGwsxF1zBjtZhp0flog0+Z
         v7ggvwi5ltm0QKKv31ayWCzdiVMEvRFKNC+2i9CqyN3W/F1Nsz3eOTJ4mcTKXTKmIHh5
         t2gorb9E8bsOjMG2l5Tkgx++aJqiv0G2G/Er0RGhvKwYiXimecwOg4OvUfQRyPGqkFz9
         6n2QJI9sJKmejbKwoEK/iVCcv0xjIv2lcard5q/7OFPnKzSiPYiJ7wlbxxB7tO788EYF
         zZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0V4NppJX6K9gT+Ur7cLKD7613ioC61Z7I5irbavVEYA=;
        b=irZZxG4TZbKm3fXIfBOrJ5mrEU0kLn+ah2KNX295q4wlFAe4ymDt9WozUEQo20sYpk
         7YexZOdtrMZY29rO1mFEoZwglU1/RERlz95gZAG23ZWfkk6UnrdFVEAS3p8ruxKeMe7S
         6RyrlEccnp4noFHQ0MAzWWOx4ziDS7g1sXcTBj457BcDycZDneie+gQ3ckOkwygw1D0c
         eTaehJYWOCV+nKTm5DkbtjazWDL4EEr3SjV988XItocHeirW9JiCtekUtGmElX9ZSPhL
         9OTMwpiGZO9Mlmz9D0Doz/C6ccfJwTz0OO0Dr1we+N+b88NOHsccBqt5TKlcgsEZJySc
         +NYg==
X-Gm-Message-State: AOAM5322oo74hSHfWJYFN1XWbGNJ9lbAz3ccTQQbUZHy9OLTu4ocFDkV
        gdIST5LFkJRx19NG8pzh8bIlDml9DvlDdoTvSf8=
X-Google-Smtp-Source: ABdhPJw/O9H/z+8HtBNlXU2R7NoSuNGK2lWWhXxmL6qIo44ysXAjAd/0dli43h1o0mtYbmCSY7UnIUQZyTODGiJkNjg=
X-Received: by 2002:a05:6830:408f:: with SMTP id x15mr832415ott.132.1614709323593;
 Tue, 02 Mar 2021 10:22:03 -0800 (PST)
MIME-Version: 1.0
References: <1614581387-14843-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614581387-14843-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 2 Mar 2021 13:21:52 -0500
Message-ID: <CADnq5_MvyeR83qQM8+jqkg63QxYkZeRG5jpA1w7p7+5n4mcD_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unnecessary conversion to bool
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

On Mon, Mar 1, 2021 at 1:50 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c:298:33-38:
> WARNING: conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
> index 3398540..fbefbba 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
> @@ -295,7 +295,7 @@ bool dpp3_program_gamcor_lut(
>         cm_helper_program_gamcor_xfer_func(dpp_base->ctx, params, &gam_regs);
>
>         dpp3_program_gammcor_lut(dpp_base, params->rgb_resulted, params->hw_points_num,
> -                       next_mode == LUT_RAM_A ? true:false);
> +                                next_mode == LUT_RAM_A);
>
>         //select Gamma LUT to use for next frame
>         REG_UPDATE(CM_GAMCOR_CONTROL, CM_GAMCOR_SELECT, next_mode == LUT_RAM_A ? 0:1);
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
