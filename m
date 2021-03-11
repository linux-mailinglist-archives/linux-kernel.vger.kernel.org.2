Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4953369A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCKBak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCKBaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:30:30 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98646C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:30:29 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t9so225011ljt.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjmW9Uac0/2GrP31pLOWn3QA56y7+9ATmhFYXpW5mMY=;
        b=pQuXvzWN+db+D8fIiSC7NIQ96zoj81U+4eiFhIBqhrtAQtEAnFzrePK97DaCEUVWzH
         CZWBx5oZsrPwDHJ9f6Eg6nn36AJWCzbeqDFwFp+SceGCdvZeqpXMDf1CpKZWF45Hn1cl
         rrYlL47mJ13JaqCJ4iT16Q8ngf7AjILLq6zyJbBaiYBHCDTk2m/+kW7CfIbJrq0VJ2Cp
         NvMoiyuMBRTWcwSUs8bS8rloAaCA78P74M6rC0CWiEKQ3QL8GZUXbpo91i5u4Td2fBAJ
         x3R31WUfKbJwnzwl2DRcEWZe9zm0Gdx140vHJ2DZE5Pf21Q5wh/Ldt6h5oCJzusW1pXZ
         BqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjmW9Uac0/2GrP31pLOWn3QA56y7+9ATmhFYXpW5mMY=;
        b=I8n5PISkOPS1hFb0tNKuRXZPlW7ieaHvjuz/WUSw/xoDWq2HKOSOcYMg+KuFheG28Z
         GyoE0NXDelWh5/gHjRzprVyMosCD3a/zfsTRm56r93xuKvwPhAqQFrpLig0kg5f0nPAl
         gNAwp7yEgNNdSL5Kc1vh6BD4hFCyz20k6nhR+3gm8C2mUTHrpIjPRtKTPhgn+6M129ko
         1021tHRf1hz2EfhOcNbJ8cBlAxfWcNrhe41nYgOMh24tM4u4ts7VMu/AMM5fOySKik8S
         q3AJRU27s5OmVm9HPDLtDSrb0LBS+HFNqcKm4iRTMKh6nDVDu3PJH/HNCDNn/FNqWe4d
         CayQ==
X-Gm-Message-State: AOAM5302HCant3xjxu039MutdBA7uqF0VbmDqbMUbawU4gl2Pe699orj
        k9Aewec7ozdxOY17/EZ1NvOWS+Is3eHleIEXEsmPLyay0M5p5w==
X-Google-Smtp-Source: ABdhPJwfaIW8mpCWEuHXpl+cqaKh42CR6MT9EqnfL2awrN4j5kaWwACRbQXrx2G+Wy0JmOsZDn0iMOdMdKwRu2NUq/Y=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr3466050ljc.0.1615426227893;
 Wed, 10 Mar 2021 17:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20210311005418.2207250-1-nathan@kernel.org>
In-Reply-To: <20210311005418.2207250-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Mar 2021 17:30:17 -0800
Message-ID: <CAKwvOd=Ezmh7iNxnAncZFkqUj3SY57Y=QzAwC5nXF0r26gKu5A@mail.gmail.com>
Subject: Re: [PATCH] ARM: Make UNWINDER_ARM depend on ld.bfd or ld.lld 11.0.0+
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 4:54 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When linking aspeed_g5_defconfig with ld.lld 10.0.1, the following error
> occurs:
>
> ld.lld: error: .tmp_vmlinux.kallsyms1:(.ARM.exidx+0x34D98): relocation
> R_ARM_PREL31 out of range: 2135538592 is not in [-1073741824,
> 1073741823]
>
> This was resolved in ld.lld 11.0.0 but the minimum supported version of
> ld.lld for the kernel is 10.0.1. Prevent CONFIG_UNWINDER_ARM from being
> selected in this case so that the problematic sections cannot be
> created.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/732
> Link: https://github.com/llvm/llvm-project/commit/48aebfc908ba7b9372aaa478a9c200789491096e
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch.  We discussed at the kernelCI meeting yesterday
and the clangbuiltlinux meeting today continuing coverage for kernel
builds with clang-10, so this is still worthwhile IMO at least for
randconfig testing not to select known broken configs when using older
tools. We can rip it out once we bump the minimum supported version of
clang.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/Kconfig.debug | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 9e0b5e7f12af..64c1f8a46ab5 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -66,6 +66,8 @@ config UNWINDER_FRAME_POINTER
>  config UNWINDER_ARM
>         bool "ARM EABI stack unwinder"
>         depends on AEABI && !FUNCTION_GRAPH_TRACER
> +       # https://github.com/ClangBuiltLinux/linux/issues/732
> +       depends on !LD_IS_LLD || LLD_VERSION >= 110000
>         select ARM_UNWIND
>         help
>           This option enables stack unwinding support in the kernel
>
> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
> --

-- 
Thanks,
~Nick Desaulniers
