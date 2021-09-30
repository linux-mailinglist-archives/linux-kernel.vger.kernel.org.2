Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05BB41E032
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352688AbhI3Rbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352606AbhI3Rbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:31:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96090C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:30:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y26so28652342lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ye/qqO0p8PKVzbuUoEwamPcpYGy0s9HnvVApER+R6kA=;
        b=ftI3Z0SVqMbhoWdnhg5bUeF+owpQShwFKiFCCXBcdn4RZHbJbc2J0o5nj5aw/QCKc0
         Vdv2kgukq9RGNxjvjCA3DkRkCBBBad79JhJxxgNrkccjH4TiJmRBW0i0ltEOb3yFMdev
         fFeMeE/vjhHmOt6rD9YvGkHtfgRxvfpXrATQ9+w5QnzKHBDo8urSjo0OMyTAAQJAH+zc
         EwvsOhDC+BRkFf8OyUTq4uGhLOTBNWDzgLni0BSbv5tf0eiZ2g1db+Bz2V5XwFVunwsL
         zbC/56A/1fmE7NB8Ti2l0dQyedYulC894HG+7anlAY/mFjb5fTXbiZUoIMQ/I8y6CLKy
         8uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ye/qqO0p8PKVzbuUoEwamPcpYGy0s9HnvVApER+R6kA=;
        b=SEMdb4xB+SWyDJY/KaH4YnWJOcy4CgmdDTSJLSQ3fJ+qfZOvXB7jIxH3byWvhHyT+f
         dtKorVbANFBL3ccLFebrs7hxZT8KE+OGvSiUGMNzLOxNRSxco6QoYpG8U/NlHP2Hq+17
         8EpZxrCxr6wJEAgAqNRKo4NVXC9yCUwQ0NCGpGGjG7u7YdjRZmuDt6gq9RxDZVawR/1s
         sAMWzBa0jxzoqmOuu/gmGGmKq2jGiyUecE9X/6JMSQohX2z1/2fNPQ/SCT5TaHd4fwbx
         DKKIZOi0iUt6T4gzvSzmHtFxz+KjWsP+eS034VMu+zgtEz94kTm9h1yVf9mDgg1bjU4Y
         kq4g==
X-Gm-Message-State: AOAM531dppU0BJ78ByK7cezwUFfPZWAx54M1m26BILv39tNgwV83EHxb
        KDqNBWu1TahLtGxo9+E5a1QFcLeuJKOPhFga4l3LTw==
X-Google-Smtp-Source: ABdhPJyhCryWkdo+UwgKGKjWkIyiSDBhEOEx2SxpkNiPWf9uVV7dyEnhQqYnZexjKufQh9L+L+s2Toet+ZTQxKlAHrM=
X-Received: by 2002:a05:651c:b20:: with SMTP id b32mr7192491ljr.62.1633023000715;
 Thu, 30 Sep 2021 10:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210930160142.2301257-1-nathan@kernel.org>
In-Reply-To: <20210930160142.2301257-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Sep 2021 10:29:49 -0700
Message-ID: <CAKwvOdkrD4WuZzUnBc2LeCjLVAumBCKXJdyr=k=dPDX1BsMhOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Guard IS_OLD_GCC assignment with CONFIG_CC_IS_GCC
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 9:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
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

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

$ grep -rn "ifdef IS_OLD_GCC" drivers/gpu/drm/amd/display/dc/ | wc -l
11

It's probably time to put this pattern in a Makefile under scripts/
and include it in all of these Makefiles.  Anything to minimize the
amount of code that has to be carried forward to new subdirs.

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


-- 
Thanks,
~Nick Desaulniers
