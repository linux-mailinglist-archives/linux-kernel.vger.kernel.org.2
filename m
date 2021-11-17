Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC67454F76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbhKQVke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbhKQVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:40:28 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371F1C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:37:29 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t23so9424089oiw.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tHOwXEnDhV5Lvn6fLJ2J3Qhjgh4hCRR8agBgNQdVXZo=;
        b=NFensp/cPA1OEmRZGoPLqFgBRN1fZFlowMUN/UgDPdZ2bmau6h0cglZJfZf+KmUaiz
         D7O6bNxG3UK48cf+vA75tbzvqNf6wZNLGTOW5KblF4m8QXavEPRW2IJkyZ9WYDoXUje5
         wUW3r+CGqW9LCB+hKbLrekgHKSr43AipIWgTFARQAQ+VgCtiiyfccoYcNsDu633V3ek4
         ++asU6mqQbVMthUt8b0WYRQOZualKKRrETSaf3rQpDmaNIXI1dVo/yqYNt3K77/MGDHk
         pvT3xbnYACMVe/EL7fjSq/ZAINvB3C3ozwJ9vsDDBlhlILWgi1iB75+3Ug99PRNhMmO1
         pYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHOwXEnDhV5Lvn6fLJ2J3Qhjgh4hCRR8agBgNQdVXZo=;
        b=FD2g3X/PrfS292FVtW+VgfR4ob7lslNju2NxNkadKubBwy7nM28LeylTE+a/MsjYlS
         8h7yf8vShWBm4hN6xWzS+g8AhW4b1gzhi8WYE2DvT4KJfjKkzzTCK3nKrwpXSVm+0xRu
         4QtM1in8YPXYWqCy93vSR2HDetZZSg8u0VZ70hyxdm6YKL8v1nu0agVpf8N+D2Ec1iRJ
         xl5EKfxZD/lM8jvc0vEAGitF8ElUDZXK1N/jQPr1L1FYcjUIthkgqMbD3ltZhPLwgxuM
         ktNee704uQbx+eQsywohUKdi6Pj3VRtndZ9fE3IrOmno/I+xBx20bFzFzYcpKEVgMaB/
         jZNw==
X-Gm-Message-State: AOAM530zE7oQV9yBObjJBVcViSs2XAj4DuC/dDDEB/avrbHi/rBZDbyA
        Zvs7G3OTfMDp2P91b4bx0vzeaL8O7iQclDQ/J5M=
X-Google-Smtp-Source: ABdhPJzbXpk+qQXxYSsMkmiv0w/FcSu60ld82pff+Qlf7gVvLN1Q+pDkS9xdiSJjE9Bc+5St9N49Dque5mpBKwgxYHk=
X-Received: by 2002:a05:6808:300b:: with SMTP id ay11mr2845056oib.120.1637185048503;
 Wed, 17 Nov 2021 13:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20211116014752.26868-1-bernard@vivo.com>
In-Reply-To: <20211116014752.26868-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 17 Nov 2021 16:37:17 -0500
Message-ID: <CADnq5_PisDB6f8AuUcw2q36mCp7O6dnFDw5od_MGHziMX_Gtgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove no need NULL check before kfree
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Solomon Chiu <solomon.chiu@amd.com>,
        "Li, Roman" <Roman.Li@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Eric Bernstein <Eric.Bernstein@amd.com>,
        Atufa Khan <Atufa.Khan@amd.com>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Nov 15, 2021 at 8:48 PM Bernard Zhao <bernard@vivo.com> wrote:
>
> This change is to cleanup the code a bit.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  .../drm/amd/display/dc/dcn10/dcn10_resource.c  | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> index f37551e00023..0090550d4aee 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> @@ -978,10 +978,8 @@ static void dcn10_resource_destruct(struct dcn10_resource_pool *pool)
>                 pool->base.mpc = NULL;
>         }
>
> -       if (pool->base.hubbub != NULL) {
> -               kfree(pool->base.hubbub);
> -               pool->base.hubbub = NULL;
> -       }
> +       kfree(pool->base.hubbub);
> +       pool->base.hubbub = NULL;
>
>         for (i = 0; i < pool->base.pipe_count; i++) {
>                 if (pool->base.opps[i] != NULL)
> @@ -1011,14 +1009,10 @@ static void dcn10_resource_destruct(struct dcn10_resource_pool *pool)
>         for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
>                 if (pool->base.engines[i] != NULL)
>                         dce110_engine_destroy(&pool->base.engines[i]);
> -               if (pool->base.hw_i2cs[i] != NULL) {
> -                       kfree(pool->base.hw_i2cs[i]);
> -                       pool->base.hw_i2cs[i] = NULL;
> -               }
> -               if (pool->base.sw_i2cs[i] != NULL) {
> -                       kfree(pool->base.sw_i2cs[i]);
> -                       pool->base.sw_i2cs[i] = NULL;
> -               }
> +               kfree(pool->base.hw_i2cs[i]);
> +               pool->base.hw_i2cs[i] = NULL;
> +               kfree(pool->base.sw_i2cs[i]);
> +               pool->base.sw_i2cs[i] = NULL;
>         }
>
>         for (i = 0; i < pool->base.audio_count; i++) {
> --
> 2.33.1
>
