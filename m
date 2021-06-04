Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947B039BDFD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFDRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhFDRG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:06:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35E31613F9;
        Fri,  4 Jun 2021 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622826281;
        bh=fZj+CPZxWhDStdJaFlv4f+84Dx/Uuufl3Qk9TqS2KzY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W0ZC6bs1DluChxI7cTtGp5v4G94sW1V6HClXLoQP9nqrYHsrwNFIBAbEe52mWlddj
         80DfOqJkCw1X2BnowZKpA6/biq05zRb2ZXyQMUaMmoQk4EZv+TE/U3lWH9PsmOZiiY
         G46NIGYfGKnnH4AJ2LWCYgIawlRqqkl0eVVUXDbwt4Aehvos4P//5W32z60bQ9Sr2p
         rKfl7ouN17JdHSql2QTgtEwc0CoL2Z/LU7ojUH7lxulhgYTOs4As4L2hbitLCsDLr0
         OpoUGaJF6+kUngxmtuJqcZ7Z682ncJb+6kTFDZN1rV5Kx1f8s6x27jeoJRXQy7RumI
         RFhWBL7Q+Z92w==
Subject: Re: [PATCH v3 1/1] pgo: Fix allocate_node() v2
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     morbo@google.com
References: <20210604165819.7947-1-jarmo.tiitto@gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <b04bafeb-541b-b1e7-9fbc-66bd1a04916f@kernel.org>
Date:   Fri, 4 Jun 2021 10:04:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210604165819.7947-1-jarmo.tiitto@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/2021 9:58 AM, Jarmo Tiitto wrote:
> When clang instrumentation eventually calls allocate_node()
> the struct llvm_prf_data *p argument tells us from what section
> we should reserve the vnode: It either points into vmlinux's
> core __llvm_prf_data section or some loaded module's
> __llvm_prf_data section.
> 
> But since we don't have access to corresponding
> __llvm_prf_vnds section(s) for any module, the function
> should return just NULL and ignore any profiling attempts
> from modules for now.
> 
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Based on Kees and others feedback here is v3 patch
> that clarifies why the current checks in allocate_node()
> are flawed. I did fair amount of KGDB time on it.
> 
> The commit is based on kees/for-next/clang/features tree,
> hopefully this is ok. Should I have based it on linux-next
> instead?
> 
> I grep -R'd where the memory_contains() can be found and it is only
> found in #include <asm-generic/sections.h>
> 
> I cross my fingers and await if this is my first accepted patch. :-)
> ---
>   kernel/pgo/instrument.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> index 0e07ee1b17d9..c69b4f7ebaad 100644
> --- a/kernel/pgo/instrument.c
> +++ b/kernel/pgo/instrument.c
> @@ -18,6 +18,7 @@
>   
>   #define pr_fmt(fmt)	"pgo: " fmt
>   
> +#include <asm-generic/sections.h>
>   #include <linux/bitops.h>
>   #include <linux/kernel.h>
>   #include <linux/export.h>
> @@ -55,17 +56,21 @@ void prf_unlock(unsigned long flags)
>   static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
>   						 u32 index, u64 value)
>   {
> -	if (&__llvm_prf_vnds_start[current_node + 1] >= __llvm_prf_vnds_end)
> -		return NULL; /* Out of nodes */
> -
> -	current_node++;
> -
> -	/* Make sure the node is entirely within the section */
> -	if (&__llvm_prf_vnds_start[current_node] >= __llvm_prf_vnds_end ||
> -	    &__llvm_prf_vnds_start[current_node + 1] > __llvm_prf_vnds_end)
> +	const int max_vnds = prf_vnds_count();
> +
> +	/*
> +	 * Check that p is within vmlinux __llvm_prf_data section.
> +	 * If not, don't allocate since we can't handle modules yet.
> +	 */
> +	if (!memory_contains(__llvm_prf_data_start,
> +		__llvm_prf_data_end, p, sizeof(*p)))
>   		return NULL;
>   
> -	return &__llvm_prf_vnds_start[current_node];
> +	if (WARN_ON_ONCE(current_node >= max_vnds))
> +		return NULL; /* Out of nodes */
> +
> +	/* reserve vnode for vmlinux */
> +	return &__llvm_prf_vnds_start[current_node++];
>   }
>   
>   /*
> 
> base-commit: 5d0cda65918279ada060417c5fecb7e86ccb3def
> 

