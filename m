Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB541E003
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352550AbhI3RVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352601AbhI3RUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:20:39 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767CDC06176F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:18:56 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so8238798otj.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AEwdvslYHUXs1dqzetG2U/icJ2B0o3I7Pc5jNQMpJk=;
        b=Z6NVRoXyvyBymM0wfTEIbRdKEFzPE3zEoQfQzXBE1Sa3C8tcMvesMOL73y29kgY8ux
         Q0tX6Lx8bD/XPIbppY9xCiNQcnwITqaA+VP8kH7xmzG2yPhsVXAC/9llUIr8trDN2aZG
         1q6NoEoZAyr2unmZZGnkm4YCz4bvoALVAdfJtgsRBXbF3Y7AYtM8sfJRcFJ9rrwat2XF
         F6F55z2CU+T+id9GUYKLdeaa6t/Vqwcg8EnOYf1/MpnpWeK0Nm5Y3mVS3n1RT+h60prQ
         n9GfgfylrpmQoLhGkylpedNBAWT3rDQOqo1fLNYm49NAxy91YgXG3LneBVGQXjWluEjG
         NKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AEwdvslYHUXs1dqzetG2U/icJ2B0o3I7Pc5jNQMpJk=;
        b=brsSdvpPseTYFYTJLUlrYkiFJJcbLeJccCZEwGrcXX3y204FWaznQ67oE4xDD8t//q
         yeV7FHd1bdH/MPKPdnzshTX0RCrNYUN8l/hDTc1r1ko6vbjDmAXPb+PVlZcSYVppaV84
         isQGDARbN1RTtiZTMtT3cODLI3QXSujlRXxkJLuwYm/vDYlDX9VWi9AQZVSqeplUg2O0
         hNJthQUmYR5iC9/x10iJTJ4eeA4Ght2TsqZ6ATbmznUx3E/0GqFRBx1EeCxn29RdBEVD
         7SJonHLoNbm25nCUIfFF+MRVQ1a1+bAu+nNZJh6QA1gLgFlIvjamwIUVxnTvoOJpULC3
         YDWg==
X-Gm-Message-State: AOAM532fV2Wy3pxvGmXxg51okWFUBT3V3q4tvusSS4KvH4WS+zjXjvQe
        6Vbo8OnhXhHKvF37wzDSf3BXaYnge2SWrNhYoGA=
X-Google-Smtp-Source: ABdhPJwZ+f3/GZr7/EhQcpADsCHcDrnSO+IWU2DxU0XdnmmE+Gn2F4P1HkTjRXY64eJeiizqhK+U7IZvCsBBAiYV2JQ=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr6263825otd.200.1633022335866;
 Thu, 30 Sep 2021 10:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210930161641.2333583-1-nathan@kernel.org>
In-Reply-To: <20210930161641.2333583-1-nathan@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Sep 2021 13:18:44 -0400
Message-ID: <CADnq5_PS3T6GpqL0zi6ct+QFFzutPJEuTy638O=-ik=LETKMYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Initialize remove_mpcc in dcn201_update_mpcc()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Sep 30, 2021 at 12:16 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:505:6: error: variable 'remove_mpcc' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         if (mpc->funcs->get_mpcc_for_dpp_from_secondary)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:509:6: note: uninitialized use occurs here
>         if (remove_mpcc != NULL && mpc->funcs->remove_mpcc_from_secondary)
>             ^~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:505:2: note: remove the 'if' if its condition is always true
>         if (mpc->funcs->get_mpcc_for_dpp_from_secondary)
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:442:26: note: initialize the variable 'remove_mpcc' to silence this warning
>         struct mpcc *remove_mpcc;
>                                 ^
>                                  = NULL
> 1 error generated.
>
> The code already handles remove_mpcc being NULL just fine so initialize
> it to NULL at the beginning of the function so it is never used
> uninitialized.
>
> Fixes: ff7e396f822f ("drm/amd/display: add cyan_skillfish display support")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1469
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> index ceaaeeb8f2de..cfd09b3f705e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
> @@ -439,7 +439,7 @@ void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>         bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
>         int mpcc_id, dpp_id;
>         struct mpcc *new_mpcc;
> -       struct mpcc *remove_mpcc;
> +       struct mpcc *remove_mpcc = NULL;
>         struct mpc *mpc = dc->res_pool->mpc;
>         struct mpc_tree *mpc_tree_params = &(pipe_ctx->stream_res.opp->mpc_tree_params);
>
>
> base-commit: 30fc33064c846df29888c3c61e30a064aad3a342
> --
> 2.33.0.591.gddb1055343
>
