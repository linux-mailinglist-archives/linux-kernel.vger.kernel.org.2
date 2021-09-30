Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1441E081
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352977AbhI3SCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352969AbhI3SCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:02:50 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD1C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:01:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u22so8384731oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZQ9+ptpmGZPeIgxp8JUYclciB8//BIrr9G2Q/xQRpI=;
        b=L5lkL0l6KtT5agnJdUQekOZPgWMZ0FQsY02b7YU0lwUgKl6cw6/Ib735DMgIFQrF+d
         P03cs2riMQ5Wr7yZHIIGQ4bPt2aSo38AE3EQiSb6k2/DJ6XJR5U5YDsSwM5lzUWTlpuM
         sT+wfKmv2UZu/6i0vfXH/JtiLZx+ZaonnIPjYD2rUKf7Gzq614FM9WFRVd/4KYQWZVaO
         OywtzTV969OrJBkpZWn/6FA4BOZczstYSv+KllGGnqPkK/bOOeB2pHqTbilUcBYPjezA
         neGf1eHNG03ig12fbBFc+YqIyBVfb9UvUUwu/bSb7efwyRIHMxw1kTn9itC/oCrgHDOH
         DLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZQ9+ptpmGZPeIgxp8JUYclciB8//BIrr9G2Q/xQRpI=;
        b=aitkyLFtyVCh+99hjqKj4xLRGCkQtR8uinrazacirXTQpZcfcwvIggXgQ88nIo6HXn
         irFXRmFZUB06xKqJBJUVGEdq3FBA8Zqlq5qTzjQg9ia8E/VaL0cIBPjjcuTw7ZsPDbct
         AxgABR5DEaTr5Hxf4An6RGTJ7XJqIXyUASdDLeLGk7HlDH+R8801A0GWUmJ8crVLz8M2
         Qqu37GoDLgl++xCBBaF2XJUVuSCXpin1xqotMFsumxzTsJsX0+1Qt//gQuBdT3JzY7PY
         5CljPIkWEFDa0FISqkzytkDnTvBPgJlymd3lKma+inJ16Wd/Q6NvMPoMBeKpgpRSxCR6
         3zkQ==
X-Gm-Message-State: AOAM530ZIlPN80/Mz0D4EZCw7T7/2ngLfJ4xo9nYicmET7lzJKiNyMNt
        1vRZMusFa5P1kdndVyO39xjifovxQyJRvJJGeVo=
X-Google-Smtp-Source: ABdhPJxzr0g8+mn8CixoZiIj4shBlN5EDztIQ6LzFMC+yNKVdi+qZtKnohF4pLFo6+pUFAfRnlf2DGEHzUu9maVUU5U=
X-Received: by 2002:a05:6808:1141:: with SMTP id u1mr444880oiu.123.1633024867391;
 Thu, 30 Sep 2021 11:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210930160142.2301257-1-nathan@kernel.org>
In-Reply-To: <20210930160142.2301257-1-nathan@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Sep 2021 14:00:56 -0400
Message-ID: <CADnq5_P5eKwjeR4nKTsOFc-QRUYkSuiko91PO4L4Djtr=VU=ZA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Guard IS_OLD_GCC assignment with CONFIG_CC_IS_GCC
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

On Thu, Sep 30, 2021 at 12:02 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> cc-ifversion only works for GCC, as clang pretends to be GCC 4.2.1 for
> glibc compatibility, which means IS_OLD_GCC will get set and unsupported
> flags will be passed to clang when building certain code within the DCN
> files:
>
> clang-14: error: unknown argument: '-mpreferred-stack-boundary=4'
> make[5]: *** [scripts/Makefile.build:277: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.o] Error 1
>
> Guard the call to cc-ifversion with CONFIG_CC_IS_GCC so that everything
> continues to work properly. See commit 00db297106e8 ("drm/amdgpu: fix stack
> alignment ABI mismatch for GCC 7.1+") for more context.
>
> Fixes: ff7e396f822f ("drm/amd/display: add cyan_skillfish display support")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1468
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Harry beat you to the punch by a little bit.

Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn201/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> index d98d69705117..96cbd4ccd344 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> @@ -14,9 +14,11 @@ ifdef CONFIG_PPC64
>  CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o := -mhard-float -maltivec
>  endif
>
> +ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +endif
>
>  ifdef CONFIG_X86
>  ifdef IS_OLD_GCC
>
> base-commit: b47b99e30cca8906753c83205e8c6179045dd725
> --
> 2.33.0.591.gddb1055343
>
