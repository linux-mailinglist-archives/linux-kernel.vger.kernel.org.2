Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72223A356B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFJVJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJVJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:09:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B702A6100A;
        Thu, 10 Jun 2021 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623359251;
        bh=pHf7P+Kb3MrvjIG7mkj0zoaPtUSfHejw14zrzz56EeQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uRNsrryiOKU8G5C08uQbch7cIB4uPe1F6y6EvVfv4vD/JnDGswiRybXw5WBmTADXR
         UTYJuaCl3M4JuXL0BgHDTJMHhLSbp1NlG391aI5nIkXUPlpEUXvb3AAQxlbKXqtoiv
         0egM/uG0204tfvMTazLFbhMmFOjV/HYrKL1SAvW8ij8hH4SLa/GMOROuHqX/hCj2s/
         IYcz+dzNINj01SW1ZXQadRmAXtdAAid3dcNTAxC62herqdqH3K9koFqgHqKem9Ekp6
         hpY2TmiI32fVJTvyVZLlVbx8l60GeM8z/5nPBkeClnzN0A8axdlIoIzuGvBpT7+abJ
         8H2EsoNmvacOw==
Subject: Re: [PATCH v2 1/1] x86/Makefile: make -stack-alignment conditional on
 LLD < 13.0.0
To:     Tor Vic <torvic9@mailbox.org>
Cc:     clang-built-linux@googlegroups.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
References: <f2c018ee-5999-741e-58d4-e482d5246067@mailbox.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <9b93b016-c19a-21db-2cc4-041810ae722d@kernel.org>
Date:   Thu, 10 Jun 2021 14:07:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f2c018ee-5999-741e-58d4-e482d5246067@mailbox.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/2021 1:58 PM, Tor Vic wrote:
> Since LLVM commit 3787ee4, the '-stack-alignment' flag has been dropped
> [1], leading to the following error message when building a LTO kernel
> with Clang-13 and LLD-13:
> 
>      ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument
>      '-stack-alignment=8'.  Try 'ld.lld --help'
>      ld.lld: Did you mean '--stackrealign=8'?
> 
> It also appears that the '-code-model' flag is not necessary anymore
> starting with LLVM-9 [2].
> 
> Drop '-code-model' and make '-stack-alignment' conditional on LLD < 13.0.0.
> 
> These flags were necessary because these flags were not encoded in the
> IR properly, so the link would restart optimizations without them. Now
> there are properly encoded in the IR, and these flags exposing
> implementation details are no longer necessary.
> 
> Changes from v1:
> - based on mainline
> - provide more information about the flags (Nick)
> - use correct tags

Small note for the future, probably not worth resending unless the x86 
folks feel it is necessary but these comments belong between the '---' 
and the stats below so that they do not get included in the final commit 
message.

> Cc: stable@vger.kernel.org
> Link: https://github.com/ClangBuiltLinux/linux/issues/1377
> [1]: https://reviews.llvm.org/D103048
> [2]: https://reviews.llvm.org/D52322
> Signed-off-by: Tor Vic <torvic9@mailbox.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

Thank you for the patch!

> ---
>   arch/x86/Makefile | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 307529417021..cb5e8d39cac1 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -200,8 +200,9 @@ endif
>   KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
> 
>   ifdef CONFIG_LTO_CLANG
> -KBUILD_LDFLAGS	+= -plugin-opt=-code-model=kernel \
> -		   -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
> +ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
> +KBUILD_LDFLAGS	+= -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
> +endif
>   endif
> 
>   ifdef CONFIG_X86_NEED_RELOCS
> 

Cheers,
Nathan
