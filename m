Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0997F324342
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhBXRlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhBXRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:41:01 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E80DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:40:21 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i18so2421752ilq.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=KVEFF/e3cq8hSLAqkkWzb/tsBUvxw8HxL0663tRmoQo=;
        b=rYBE3tx41p3vC7kUwVnZVOt8IudcouNv90aVHp5aRhAJWTwWstiIG9UaRmHFnBkT1J
         U24fewXNjZGiaZFhZpq2ulihxcffmastRktVQy01PCBiB0hV5Cns2qWgzjvMr3b9EU7k
         7XcN6DV9zH3YcToGb6XW27xkxP6Y2joVmWEVJS0m83PlcBp/DY0IawGND8xawJA+4Fwq
         lZhMZvy6HTWMHwcbp1cPGDjsnr591C0nHLhw1Q5L8I/hgf9LLjcSUFGDZBlNpJOleUki
         HlKTFrumpxZPh7ICSMsxUmo5wRAeraFG4DAyIMeNb4NSZWcsNG/c01XghtRuzsus7PjG
         OiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=KVEFF/e3cq8hSLAqkkWzb/tsBUvxw8HxL0663tRmoQo=;
        b=X3aMM4KxgJ1qaGGmtDOmELlGu0K/BCjdwswbeos9jCu/1dGzcjjS5TBo00W1oG7Mdm
         Ogb08HrVygWtqJwkONVLG2ZHLj42zdJT3utVz3QB2IWa7OvlLeGKGtdjEmek6yRHCdzn
         7xqYSSeJkksdp/YqSVIIfmsaHGXeUW5vXxvPcAEaT4t8pjytKodFj6G/RucTT+ywYTPP
         85FVlav6HKAuYuJYp5VHHm7N4GoqQmHqk+aFTQplFjGIWPlg4C1uahQzOD6fgUu9aNre
         yiau+IP7uoL92IbwzWGzD9jh5IJVUWWqaBXVTWArR6QljQnKlxlsy1MEPU2LNCK/0fD1
         wlcA==
X-Gm-Message-State: AOAM532D0wVlh8DCvAhRx2+bs5KFgrk8OivierHcEtsRGH05uoDwnPsC
        cbcVPFKdUtRSuGy7+6zQlEtAJoqun74eiRuntDw=
X-Google-Smtp-Source: ABdhPJx86Fjs3j/bSxZdqqIGrInEz4YE62R4z11rDBzdrMiNUtL9AvS8Ry4ssztrLtAXwA9epgL09On9AhA7jn5fI64=
X-Received: by 2002:a92:c145:: with SMTP id b5mr19179398ilh.186.1614188420558;
 Wed, 24 Feb 2021 09:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20210218224849.5591-1-nathan@kernel.org>
In-Reply-To: <20210218224849.5591-1-nathan@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 24 Feb 2021 18:40:09 +0100
Message-ID: <CA+icZUXGS_bbVRsMVJowVPTZpi8NYQ_18Ec9bXBTztWL6dA=hQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/swsmu: Avoid using structure_size
 uninitialized in smu_cmn_init_soft_gpu_metrics
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 11:49 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:764:2: warning:
> variable 'structure_size' is used uninitialized whenever switch default
> is taken [-Wsometimes-uninitialized]
>         default:
>         ^~~~~~~
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:770:23: note:
> uninitialized use occurs here
>         memset(header, 0xFF, structure_size);
>                              ^~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:753:25: note:
> initialize the variable 'structure_size' to silence this warning
>         uint16_t structure_size;
>                                ^
>                                 = 0
> 1 warning generated.
>
> Return in the default case, as the size of the header will not be known.
>
> Fixes: de4b7cd8cb87 ("drm/amd/pm/swsmu: unify the init soft gpu metrics function")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1304
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I fell over this today with Linux v5.11-10201-gc03c21ba6f4e.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v13-git

- Sedat -

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index bb620fdd4cd2..bcedd4d92e35 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -762,7 +762,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
>                 structure_size = sizeof(struct gpu_metrics_v2_0);
>                 break;
>         default:
> -               break;
> +               return;
>         }
>
>  #undef METRICS_VERSION
> --
> 2.30.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210218224849.5591-1-nathan%40kernel.org.
