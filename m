Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E3133FD99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 04:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCRDML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 23:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhCRDL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 23:11:57 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57372C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 20:11:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id d16so933107oic.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 20:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jug9lt2096iTFzdoAmqpuHgFfgrRXiyduMJw3GtK8p8=;
        b=DrhRzLOcGsAX3P72JbSKtzPAMjwFFO1Y4Ab6lZPUyB8sFejZRzxyi0tSYQdSz6J1RR
         svsVqtyj9GenOvMFGO8nzfd/2CbxFBP+GtKL6/N1CuFxzwjA1MvgquXf3/AENPcBVtBa
         7DA43Fc5y0B2aVRIYCSpmUi11e+hwpAUpsy6XSJ0iMU1Q7wY/CBHS23D9BJsd6WeAItn
         QdG0ULYIQfEcCGzhzHHcxiX7s70ZR30dARQnEhYBYQa9ByHvWhQrR5VBBPGvCBqWA7Zd
         LHdrBsOh45ANhff14lf9TfeznHi0aRebEjfg6PLyx56t/XRT3foIb8aURhgIoq1ISI2x
         aVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jug9lt2096iTFzdoAmqpuHgFfgrRXiyduMJw3GtK8p8=;
        b=UQZXTBFlmZEd7aygqyP8xlnJ/UxReJ+aSHeLzGENoFPAd3qqzApYqBfKBfabEUTHZK
         ywZClzc1ol2fpasehcHKDBaBirHT/Glk8FRkosapc9603y4NpblN4Mzgs3aSqIQm8oMS
         WdRkbd88HpX6FyUSX98AWATtbY/x1B/NNGr8mNB7t/wB+lSZfIvJHvUoI95i4xcysF52
         PIjqqwYP5mpESTIZZn2BNFEWZUszZvPG0o6z29oXg32TEcCBPncgujo5QxaQbF+FAYY8
         KciaCzsA5iPtpA5AIYW8D+40wMJJNcJvhP1WUFPQwi8Mavjo1eUD0yMIns0LhFmIKdA4
         AV5w==
X-Gm-Message-State: AOAM533E1WdcPBhhmD6AhlHoYbInxH/v9+wqCJnfHfZnL85+inV08XLh
        JNGyiXpJJfjIG7SbeX6J72eEwzh/6JHIJkKi1i8=
X-Google-Smtp-Source: ABdhPJzHuFKutJ2cmVAWC7ZqCumYXV3yTyCSCiUT12R+iMCXFfOdIbucig+gbaD6BaFQuznCzIDYFyBfUs9ktO+F3h4=
X-Received: by 2002:aca:4748:: with SMTP id u69mr1416178oia.5.1616037116859;
 Wed, 17 Mar 2021 20:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <1616035012-88614-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1616035012-88614-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 17 Mar 2021 23:11:45 -0400
Message-ID: <CADnq5_O+3EQHN8uw14HsPNm9rijveXd=W1Q+18sS_4cGNvA_3w@mail.gmail.com>
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

On Wed, Mar 17, 2021 at 10:37 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c:220:65-70:
> WARNING: conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.  Thanks.  In general, you can just roll up most these bool
conversion patches into larger patches; no need to fix them all one at
a time.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
> index 8593145..3fe9e41 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
> @@ -217,7 +217,7 @@ static bool dwb3_program_ogam_lut(
>         else
>                 next_mode = LUT_RAM_A;
>
> -       dwb3_configure_ogam_lut(dwbc30, next_mode == LUT_RAM_A ? true : false);
> +       dwb3_configure_ogam_lut(dwbc30, next_mode == LUT_RAM_A);
>
>         if (next_mode == LUT_RAM_A)
>                 dwb3_program_ogam_luta_settings(dwbc30, params);
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
