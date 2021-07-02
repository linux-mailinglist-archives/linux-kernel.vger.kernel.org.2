Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F316A3B9A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhGBBIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234370AbhGBBIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625187951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n9OaAW86hfdiO1VA98CCVRDLl1o7BbOpKsYQYRGdLwU=;
        b=YmwxzwZYQHUhFvLaP9NcK0N36obw/P9lu7TP1Gxoh1nXO0T/K3GYsJaMfnDydh3lozy/5H
        Jyce8B8XdTCN1V56y3lrl1DFF4fpwJ96FsGLI4Lh2ow1OWDX1/hQ3mTGRz2Zdp5UJc8t1d
        yFSZsss1yX5eu84efnEbmg0LRmv4wVU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-cdjKric0OmGj8_1mPN64uw-1; Thu, 01 Jul 2021 21:05:50 -0400
X-MC-Unique: cdjKric0OmGj8_1mPN64uw-1
Received: by mail-oo1-f69.google.com with SMTP id e10-20020a4ab14a0000b029020e1573bdb7so4434151ooo.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 18:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9OaAW86hfdiO1VA98CCVRDLl1o7BbOpKsYQYRGdLwU=;
        b=lEbh7KgwECSSOWtn/M64AsTdYtynh6I4uJzLtOtgdm1PL1/R3VHu6Hv3hxHTzog+mM
         T/gJ3iUYfAAj3szM621Bm/2kwRRWQ959fsd6FaM1+cIe6rWHc/3LQk92k5vVbwIM9kBE
         dvc/d+FyWgeTSnNFAN6xrzLkzOSXdndQ0Oq0wRuqcOuIhFh91n1zoiLd6m0erExLlH90
         99GSwRNbG2V0aZ7sEGG6Er8jNadj3GlqxwwNGML1UoieB5zP4sn0jgMX7XjpjWjeOUGN
         WEwehVByEpi1SZNpWCDuzQpmG3LU/EA/UStAOJMJ+t6Vgq7fHYE3zoYgGhKXuktLcZlg
         PiYA==
X-Gm-Message-State: AOAM532AUl4qiMYUbmqthtvnYQiEr49Be+qL8BAagZ4NMYAduKDkYmvQ
        VyA415s7jKzYtjiwKOvt1gk1LyzWSzE/aU2em5lMQgrr2XUGbdvT6wXcHfh2ALFt/kCeyxL8aiH
        /lJqnMUjrtb3MwWBxoEvJ8CzE
X-Received: by 2002:a9d:1d23:: with SMTP id m32mr2320696otm.16.1625187950119;
        Thu, 01 Jul 2021 18:05:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKrpQaXrzzZQPGIuLgl5S5C4WW1Y1mBjlz3mLm9gfgmCVFs+d0MdYupOpTzKwF5UElGz5frw==
X-Received: by 2002:a9d:1d23:: with SMTP id m32mr2320687otm.16.1625187949940;
        Thu, 01 Jul 2021 18:05:49 -0700 (PDT)
Received: from tstellar.remote.csb (97-120-209-236.ptld.qwest.net. [97.120.209.236])
        by smtp.gmail.com with ESMTPSA id m126sm349784oib.55.2021.07.01.18.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 18:05:49 -0700 (PDT)
Subject: Re: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210701235505.1792711-1-ndesaulniers@google.com>
From:   Tom Stellard <tstellar@redhat.com>
Message-ID: <bea79143-b2b8-b7a4-0456-4a593f03907f@redhat.com>
Date:   Thu, 1 Jul 2021 18:05:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210701235505.1792711-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/21 4:55 PM, 'Nick Desaulniers' via Clang Built Linux wrote:
> We get constant feedback that the command line invocation of make is too
> long. CROSS_COMPILE is helpful when a toolchain has a prefix of the
> target triple, or is an absolute path outside of $PATH, but it's mostly
> redundant for a given ARCH.
> 
> If CROSS_COMPILE is not set, simply set --target=aarch64-linux for
> CLANG_FLAGS, KBUILD_CFLAGS, and KBUILD_AFLAGS.
> 
> Previously, we'd cross compile via:
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linxu-gnu make LLVM=1 LLVM_IAS=1
> Now:
> $ ARCH=arm64 make LLVM=1 LLVM_IAS=1
> 
> We can drop gnu from the triple, but dropping linux from the triple
> produces different .config files for the above invocations for the
> defconfig target.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1399
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Suggested-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>   arch/arm64/Makefile | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 7bc37d0a1b68..016873fddcc3 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile

Are there plans to do this for other architectures?

-Tom

> @@ -34,6 +34,17 @@ $(warning LSE atomics not supported by binutils)
>     endif
>   endif
>   
> +ifneq ($(LLVM),)
> +ifneq ($(LLVM_IAS),)
> +ifeq ($(CROSS_COMPILE),)
> +CLANG_TARGET	:=--target=aarch64-linux
> +CLANG_FLAGS	+= $(CLANG_TARGET)
> +KBUILD_CFLAGS	+= $(CLANG_TARGET)
> +KBUILD_AFLAGS	+= $(CLANG_TARGET)
> +endif
> +endif
> +endif
> +
>   cc_has_k_constraint := $(call try-run,echo				\
>   	'int main(void) {						\
>   		asm volatile("and w0, w0, %w0" :: "K" (4294967295));	\
> 

