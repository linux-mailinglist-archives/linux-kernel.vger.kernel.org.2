Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC141DFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbhI3RLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbhI3RLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:11:43 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B34C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:10:01 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 24so8236374oix.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQogwYZrvFu5Jfwlkrcfq3WvY8WdwXPWkmnjzSEdhJA=;
        b=BnTi5yVXAfDjmWTBRPXF8NGo1YE+5AZtAQsVeFujbgn52DpBNG/u8BQCEA6yTZObMG
         wehpKbgoGdQ9/QTuH+G5l39mHnrCNXaZC3HRFNjQuNBadU1z9yvSWHC06Gx7uhyZHMFc
         mib9yjTtb6lr7ZhK1la1hOWvhyIRII+nMOl9PVfm9aUTXNvmW0hANEbfugTvEBEmSatI
         xaTq4+hIWVdNRE4a/lKOUOeV8VynnBZxyRIZFtxa6m7GTlSsM8qRTDLXcILWujx6ipOb
         JRUqVVydfpl1D/YwKGad+pUGCOBKPdk/EgzL3PB30/ZwSzU2g7QUYKe9HVgDJt3wcLmo
         BDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQogwYZrvFu5Jfwlkrcfq3WvY8WdwXPWkmnjzSEdhJA=;
        b=s7zMmeZIyW9m9A7euH768pQhp1Aq5FmG8zY+2uJgY31qjoC0luUpDgHIUuzmonOTmC
         8AI8QjLIyA0pcnLO9a91koooyuB52qOBRWjuDtDzyQ71Dk84U+nY2xap9OWgtzJwqtOm
         FLs6Y4up621Vj0X2s7gmjqrxg8c5vDspE9KU7byENoPKAlKCXt2mXO8CBZz78uacelqE
         LDd160sy9rKWH6EZ9g+4xCVFRuSoiAW85LoQRYoThPMWC1UT1YeISUMnMo5JVHeVPQzj
         gN//QS60eBMngdnDdI6Ocnf4ooc7LawbvJWlEXoVPKobjIT4+Ru7lLyPb7H+7dN9b/cE
         SnwQ==
X-Gm-Message-State: AOAM531TeDWTKdbeNBBFfr44lIvj3XQz8QBaMMm12B7jZk99lhom3Gb/
        +Tgx7XMkfOOk1fSaa8BwwufabD7jK99C2oZf2E4=
X-Google-Smtp-Source: ABdhPJyRKPsrHxUPVPxsmZJBSYdQhA0oY4DyYGw0Ib3s43wNku5L4chLBN6tFR9C67rUuP9Cv4X16bsCZ1CgRYrsJxc=
X-Received: by 2002:aca:706:: with SMTP id 6mr283505oih.5.1633021800478; Thu,
 30 Sep 2021 10:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210930162302.2344542-1-nathan@kernel.org>
In-Reply-To: <20210930162302.2344542-1-nathan@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Sep 2021 13:09:49 -0400
Message-ID: <CADnq5_PBMGdUG8VMUQ2UOSdd9qXbZ7QoyGH2RTgUPnTjdzKqFA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Return NULL instead of false in dcn201_acquire_idle_pipe_for_layer()
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

On Thu, Sep 30, 2021 at 12:23 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:1017:10: error: expression which evaluates to zero treated as a null pointer constant of type 'struct pipe_ctx *' [-Werror,-Wnon-literal-null-conversion]
>                 return false;
>                        ^~~~~
> 1 error generated.
>
> Use NULL instead of false since the function is returning a pointer
> rather than a boolean.
>
> Fixes: ff7e396f822f ("drm/amd/display: add cyan_skillfish display support")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1470
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> index aec276e1db65..8523a048e6f6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
> @@ -1014,7 +1014,7 @@ static struct pipe_ctx *dcn201_acquire_idle_pipe_for_layer(
>                 ASSERT(0);
>
>         if (!idle_pipe)
> -               return false;
> +               return NULL;
>
>         idle_pipe->stream = head_pipe->stream;
>         idle_pipe->stream_res.tg = head_pipe->stream_res.tg;
>
> base-commit: b47b99e30cca8906753c83205e8c6179045dd725
> --
> 2.33.0.591.gddb1055343
>
