Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A16315999
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhBIWjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhBITmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:42:24 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B293C061A2E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:41:17 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id k204so19123264oih.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXoXX9t+fJ8x0y0o3oj+Ni+Q4UjyYGDDZmio3Vrqotk=;
        b=gC4VvFIYtHmzre1Gnuqb+O2KVzUhmSdr96r/12PS0RHwTh3y/Cl65SGWUwymg1dfSc
         0RILw3MlzO7nC82fJMVvzCTTaq4xATaZgPq81u1azvY6Ko0DD/2G6m4ncjBofq29X/at
         GzJBaxR7qdEJpGe1jG1hjZTbvAYG0DIhOfEnkjFDXhKlCendp9nSIglkzk2tMN1kKAlx
         o6Abxl6lLWSTwtigKbR8ZCdioVXVhLz8hxT/LAmyk6dt3qQnmgFuZwXRYJFfEM74aKxM
         tUilAcY3BPqv4h8a+Ok9O4w+RK6iewPK0epvVgRlgSCSkSwV5XmO59Ud0z5ZS8CJWh05
         tUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXoXX9t+fJ8x0y0o3oj+Ni+Q4UjyYGDDZmio3Vrqotk=;
        b=eaFHzk9V/KkamG3HJ9Pe/7IrEnA1UeLHQQs/utw+J2th0XkRILDHARA5h7Pm++Zhcg
         fD3jtYtp+1yoRxykJCdEtlDsoEU/DU6BdUscuXre1TWQP4nYEANF5Jysg6BW8JCj204m
         4qyzX9/hQ8Vcu/Q7wPRQvyMHfvzbh59zwU900y4DNLXStF1E+A0XXOnApNuThwtZxmpy
         Xr/FPeURCeDlLV92W9nKe4myIBLYVHGwBf0nDV5CMV8e4sIK7gEgwBGE7I1p46J6/NYE
         ne7CQvXhrB/o1yOQ8tcPy4hB8u7yOpWPhpFD/uPnK4wFogvU6bKlujMbZ/QORN/4X+WH
         heMQ==
X-Gm-Message-State: AOAM532ELE6IUgmCbOcwL1S4NI01Pif4XSVlHeivmn97r6YR76DNZdLm
        OhBvEoxRsMHBWeG7eHjlH6Lyte/kPB4kqYyqops=
X-Google-Smtp-Source: ABdhPJyi8YAv3Mr94sjJIKowedWyGeiZtBKiNpp2j7n3eofNp2+Ob1AqBzjl96BXSvyOAQ8g+Ay8MPEWa4Qc0NozfRM=
X-Received: by 2002:aca:c786:: with SMTP id x128mr3540978oif.120.1612899676846;
 Tue, 09 Feb 2021 11:41:16 -0800 (PST)
MIME-Version: 1.0
References: <1612780168-83989-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612780168-83989-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 9 Feb 2021 14:41:06 -0500
Message-ID: <CADnq5_PguFm7Qo2i1dqCAwLAWYhq68m-wdSx8B5LGUVmMbS3pw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Simplify bool comparison
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

On Mon, Feb 8, 2021 at 5:29 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> ./drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h:319:11-23:
> WARNING: Comparison to bool.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> index ffd3769..316301f 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> @@ -309,9 +309,9 @@ static inline bool should_set_clock(bool safe_to_lower, int calc_clk, int cur_cl
>  static inline bool should_update_pstate_support(bool safe_to_lower, bool calc_support, bool cur_support)
>  {
>         if (cur_support != calc_support) {
> -               if (calc_support == true && safe_to_lower)
> +               if (calc_support && safe_to_lower)
>                         return true;
> -               else if (calc_support == false && !safe_to_lower)
> +               else if (!calc_support && !safe_to_lower)
>                         return true;
>         }
>
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
