Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654C0357B68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhDHEjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:39:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22551 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhDHEjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:39:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FG7nf67X2z9vBnX;
        Thu,  8 Apr 2021 06:39:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7Ulh6JSdMufP; Thu,  8 Apr 2021 06:39:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FG7nf4Vgwz9vBnS;
        Thu,  8 Apr 2021 06:39:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6568E8B7BE;
        Thu,  8 Apr 2021 06:39:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3uhCu6FeRQ6b; Thu,  8 Apr 2021 06:39:03 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E9BFB8B75F;
        Thu,  8 Apr 2021 06:39:02 +0200 (CEST)
Subject: Re: [PATCH] powerpc: remove old workaround for GCC < 4.9
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20210408030534.196347-1-masahiroy@kernel.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c1252dda-42e8-d920-c46f-1fd8250870ab@csgroup.eu>
Date:   Thu, 8 Apr 2021 06:39:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408030534.196347-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/04/2021 à 05:05, Masahiro Yamada a écrit :
> According to Documentation/process/changes.rst, the minimum supported
> GCC version is 4.9.
> 
> This workaround is dead code.

This workaround is already on the way out, see 
https://github.com/linuxppc/linux/commit/802b5560393423166e436c7914b565f3cda9e6b9



> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   arch/powerpc/Makefile | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 5f8544cf724a..32dd693b4e42 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -181,12 +181,6 @@ CC_FLAGS_FTRACE := -pg
>   ifdef CONFIG_MPROFILE_KERNEL
>   CC_FLAGS_FTRACE += -mprofile-kernel
>   endif
> -# Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
> -# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
> -# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
> -ifndef CONFIG_CC_IS_CLANG
> -CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
> -endif
>   endif
>   
>   CFLAGS-$(CONFIG_TARGET_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
> 
