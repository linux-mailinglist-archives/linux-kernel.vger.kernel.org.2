Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F72397A6E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhFATI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233397AbhFATI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:08:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C72AD61287;
        Tue,  1 Jun 2021 19:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622574435;
        bh=lDMpMfNCZ2MTzjxr62K2HQLSkk5cdQjeJfMGQh+qJ3M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BWVJnjnGuMNc5jl7Uw2vAZaiPrR3tsBC8GrDuLC6UJ1cxAagUwSTgrXTQ66oKL1+f
         3XEo6yhk0r5lYyadND0Zfa2laaPU8EQltsNC1hVh9b3U8uuYn59WDY7INQ93CCfJZE
         hykt566I+W6vnlKk3k8q4K5x1ULSnddvJdsgSp6gCiuohMb9pI+NgcIoY+RwiFgFk5
         RDbSWLxdiHKaWqAbeKqXXuhA/CjiucxBA9phQ8QDhg9KUQ7q6lWDx7Saey4ZA0+nMJ
         jW1g8n6MJpilatlIdAGt1VYSTFuZK4/V5EcTDUdq8IM7pfJiQVuT7VIdG8ogjAhYH6
         8ZT/iQQfgoQYw==
Subject: Re: [PATCH] MAINTAINERS: Expand and relocate PGO entry
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
References: <20210601190541.1446239-1-keescook@chromium.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <75a5aefd-084f-ef59-ceff-0f3856dcce71@kernel.org>
Date:   Tue, 1 Jun 2021 12:07:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601190541.1446239-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/2021 12:05 PM, Kees Cook wrote:
> This expands the "PGO" acronym and adds additional metadata to help have
> patches get directed correctly.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Bill Wendling <wcw@google.com>
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
> as seen in: https://lore.kernel.org/lkml/YLVRTilQ5k5n+Vmz@archlinux-ax161/
> ---
>   MAINTAINERS | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd7d34fcd95c..2030cd9593cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4448,6 +4448,19 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/cla
>   F:	include/linux/cfi.h
>   F:	kernel/cfi.c
>   
> +CLANG PROFILE GUIDED OPTIMIZATION SUPPORT
> +M:	Sami Tolvanen <samitolvanen@google.com>
> +M:	Bill Wendling <wcw@google.com>
> +M:	Kees Cook <keescook@chromium.org>
> +R:	Nathan Chancellor <nathan@kernel.org>
> +R:	Nick Desaulniers <ndesaulniers@google.com>
> +L:	clang-built-linux@googlegroups.com
> +S:	Supported
> +B:	https://github.com/ClangBuiltLinux/linux/issues
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
> +F:	Documentation/dev-tools/pgo.rst
> +F:	kernel/pgo/
> +
>   CLEANCACHE API
>   M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>   L:	linux-kernel@vger.kernel.org
> @@ -14387,15 +14400,6 @@ S:	Maintained
>   F:	include/linux/personality.h
>   F:	include/uapi/linux/personality.h
>   
> -PGO BASED KERNEL PROFILING
> -M:	Sami Tolvanen <samitolvanen@google.com>
> -M:	Bill Wendling <wcw@google.com>
> -R:	Nathan Chancellor <nathan@kernel.org>
> -R:	Nick Desaulniers <ndesaulniers@google.com>
> -S:	Supported
> -F:	Documentation/dev-tools/pgo.rst
> -F:	kernel/pgo/
> -
>   PHOENIX RC FLIGHT CONTROLLER ADAPTER
>   M:	Marcus Folkesson <marcus.folkesson@gmail.com>
>   L:	linux-input@vger.kernel.org
> 

