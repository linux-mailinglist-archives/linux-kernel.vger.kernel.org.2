Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD13308D68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhA2T1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbhA2T1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:27:45 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9CCC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:27:05 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id h14so9706018otr.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soh8pOn1T1DcxTY1XPnZj9TZgDqYse0vYVofp5N1pk0=;
        b=k2PxTxJsoShBobn+g2aJQ756Qotit4VnYGyN5pleotb/YOxh6ue5M3R2RxWIqBL5qO
         LuhxvL5iGqHXxLMvrt6dQgj+xiecomucEYhdfNLx1z/YpdWev1b/cgKZpYTFX1Bke9xg
         ULIlIIWGfJFs7dLWlQ0YdkKEKueZzaeBsU4uwFAM2mcXVMgE2wNwX9ZuYxxZantEBZf1
         hL8QYe9RMl1Hg0RfS0dvLLLQNn/o1X12VxSZ5J1KmfGot6ZT1Ga4K0Msq7pXcr2yrJ3t
         MnnES2BRldX+ECDbyEwxOnSvX2Nae1FDDFqmn2UtXOhJsqE500/T2psWnqr4k0H60WRP
         pqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soh8pOn1T1DcxTY1XPnZj9TZgDqYse0vYVofp5N1pk0=;
        b=QTt+hrLQRNd4AxkcmSbtDGwTlDPF7NAE/YruXKRIogBGIrAYIE50LX88wghSNXxex9
         4IzryAygNusyKRs0LxCi6uJB00zFIWgAaLLLbh69MkDd1sbUB+i8HZNhjCzyee2J1myL
         M34eD036WBDjdvbQgpZfjnWTqQOmH6AEPULxutiMcdWZ381FJ8rrv6pqtmhYTtDrNIwl
         i4kKfQg0j+ZK6JY1OXYd8iCGq/LPnAOhsu+8xsDL9hQ9csS586IDjpL95pQUI0+smTbr
         fHVRv7eMV8dBgRrS9xZQj/MCaM7CggVujQ4mwJGMhAafpD+MFa5yXy55Y2cFJeb94PAE
         tXgQ==
X-Gm-Message-State: AOAM530qNcswouHDVJEshGaCZFkzA91fG+WKjXPadqe+xh9rkpOSySl4
        T32JjyuYcKQDLfclAwk6U5CDHBJfu44PAQE6w8Y=
X-Google-Smtp-Source: ABdhPJxlTOWVyx5I+HBNBTVKPsK8MScCcBl7MtldcLXaXJhx7OQ6Ilrry7lRtrPDpA3Jl8x2fC8hKfH8JztSg/b3AiM=
X-Received: by 2002:a9d:1293:: with SMTP id g19mr3821708otg.311.1611948424891;
 Fri, 29 Jan 2021 11:27:04 -0800 (PST)
MIME-Version: 1.0
References: <1611823774-20749-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1611823774-20749-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 29 Jan 2021 14:26:53 -0500
Message-ID: <CADnq5_NhUzGDff0xE4nH2mvvE8BwcbGXAUgqu7B4trbdwj1eng@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Simplify bool conversion
To:     Abaci Team <abaci-bugfix@linux.alibaba.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 2:45 PM Abaci Team
<abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:3137:35-40:
> WARNING: conversion to bool not needed here
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Suggested-by: Yang Li <oswb@linux.alibaba.com>
> Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 017b67b8..fc03d91 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -3134,7 +3134,7 @@ void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
>
>         pipe_ctx->stream_res.opp->funcs->opp_program_stereo(
>                 pipe_ctx->stream_res.opp,
> -               flags.PROGRAM_STEREO == 1 ? true:false,
> +               flags.PROGRAM_STEREO == 1,
>                 &stream->timing);
>
>         pipe_ctx->stream_res.tg->funcs->program_stereo(
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
