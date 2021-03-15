Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305C033C59B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhCOS1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhCOS1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:27:31 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22960C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:27:31 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w65so35429400oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBq3gzSWM4PAYPU03bItAvmuL/jkDE66lmjkbZXjRp8=;
        b=an85zbY+atXgMmpRQQBVfLZXYZx7DbYuH6si3dsaJ4RZ750Mj6Pj9AV8KmzMw8NoBm
         c/6EqiaKL3RPUCd55n0wSCiRx68GVJECcqxYEexFcnhJ2QSIqSKjD/5zZAklkIHyRrd6
         zdb/qGWJL4AtNo0AkKQ4GSqDRNBV4m6edi9Z3YAYZm0v5zJgWW/B/eX7Dk574k4pxXNE
         Q2UPBuzzhaummRHcKdd/AI1MXXqogFcfZHpGxMw3pxfWNkCTb6LiLosFs79FAi/Wdnn0
         REWTqaTseDkF6WuhlPrDigCc9L4gB6Q8waiklbrWRchYn8lCd9/4iKfA04y1LUNKi+JF
         KnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBq3gzSWM4PAYPU03bItAvmuL/jkDE66lmjkbZXjRp8=;
        b=mSDxOqeh6xc29QQAiMan3CrlM0uSirIjPLbtjxYWe2kIPitz/tflUYFJz/TlU9JZqU
         x5w1MJLlpqGKRB4XdYvlBT41It2oeS4HCEYRDx5EDP1gs52eXF+sMSjPG6d5AUa0dWIm
         1tiTipIcfvj7OTorCar6+5pUo9sJnTC/JkdtzXPt9r9egQEcUG6meR/bixkemo2QsSUT
         AEL43sCTuGHO5kYOk6RUQpaTusqhk0tUFGpAQUp8HTE/OMJk/5mMAYGv3s94MLoCStwd
         9HM6hEbnYn1/ZvD6WsiBcQ4SDzkhqKcR4B3zPnSwiPMqSB+ldLgxLyIRxM/0Iup+Bdy8
         dhXQ==
X-Gm-Message-State: AOAM532xVpBaCsNpJog2LPxfZDdGrCwWOu7RlNolJbAiu6a+oOakAk+k
        ZH1wb5jBoTe/E064+Rb4TwDXL9Sn0wN15RRmv6Q=
X-Google-Smtp-Source: ABdhPJzUvNXxxTNXCmAj+6pzsw62g0KyCooJD4yymr3eHweuglmQ2mI2iPUzEuPjQMKBqm+SAgUsJOzl+wwI9LYJLSU=
X-Received: by 2002:aca:af10:: with SMTP id y16mr331070oie.120.1615832850600;
 Mon, 15 Mar 2021 11:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <1615796522-21363-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1615796522-21363-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Mar 2021 14:27:19 -0400
Message-ID: <CADnq5_MEqZZV1qRWzJM0PefBjCAnEDODzgrXn_8C3qzWqmZJYA@mail.gmail.com>
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

On Mon, Mar 15, 2021 at 4:22 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c:358:69-74: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
> index 3e6f760..e153109 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
> @@ -355,7 +355,7 @@ void mpc3_set_output_gamma(
>                 next_mode = LUT_RAM_A;
>
>         mpc3_power_on_ogam_lut(mpc, mpcc_id, true);
> -       mpc3_configure_ogam_lut(mpc, mpcc_id, next_mode == LUT_RAM_A ? true:false);
> +       mpc3_configure_ogam_lut(mpc, mpcc_id, next_mode == LUT_RAM_A);
>
>         if (next_mode == LUT_RAM_A)
>                 mpc3_program_luta(mpc, mpcc_id, params);
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
