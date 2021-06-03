Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F939AC6E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFCVQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCVQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:16:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74340613EA;
        Thu,  3 Jun 2021 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622754865;
        bh=CxBbmUenIBFNJFx7O27MK3tssmpiShEcuKEzQF2jLcc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pu+42oUaDgPWMp7MbNEM8xQNlCSB4wtURC8zRbNB49a3mi5KACYdlWJbmsDGU48kZ
         O8wIwObqvk8vw32O9if29gFFEgwqQ5/3SGupaV0giSYgLLCQhUGaUpAu8+Rb1IhI0u
         LQrmp7hx25jk5wmAJjHpK06rJe3EZyAyLfWUWpVXZ9UEZWawWmJ2HqTTa1lvVwXuvY
         a+HXTz7RAoSTLSGyw8NEJWU81Ly8TX8Aa/2LB33QEk2qI0flAtcJn02n9NQaDxHeA/
         KDl6lM8p+OWtIcotDQ+SKamUdGokysMRnXVL2k+LKtKh+nr5pF2Kwhvv4xJrVjYbId
         ELSUUEv172uXg==
Subject: Re: [PATCH v2 1/1] pgo: Fix allocate_node() v2
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     morbo@google.com
References: <20210603133853.5383-1-jarmo.tiitto@gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <d7e94352-0b24-1ab1-8b54-b6ffd4347963@kernel.org>
Date:   Thu, 3 Jun 2021 14:14:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603133853.5383-1-jarmo.tiitto@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/2021 6:38 AM, Jarmo Tiitto wrote:
> Based on Kees and others feedback here is v2 patch
> that clarifies why the current checks in allocate_node()
> are flawed. I did fair amount of KGDB time on it.
> 
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

I agree with Nick on the comments about the commit message. A few more 
small nits below, not sure they necessitate a v3, up to you. Thank you 
for the patch!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   kernel/pgo/instrument.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> index 0e07ee1b17d9..afe9982b07a3 100644
> --- a/kernel/pgo/instrument.c
> +++ b/kernel/pgo/instrument.c
> @@ -23,6 +23,7 @@
>   #include <linux/export.h>
>   #include <linux/spinlock.h>
>   #include <linux/types.h>
> +#include <asm-generic/sections.h>

Not sure that it actually matters but I think this should be

#include <asm/sections.h>

instead. Might be nice to keep this sorted by moving it to the top as well.

>   #include "pgo.h"
>   
>   /*
> @@ -55,17 +56,19 @@ void prf_unlock(unsigned long flags)
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

A blank line between this variable and the comment below would look nice.

> +	/* Check that p is within vmlinux __llvm_prf_data section. > +	 * If not, don't allocate since we can't handle modules yet.
> +	 */

For every subsystem except for netdev, there should be a blank line at 
the beginning of a comment. In other works:

/*
  * Check that p is within vmlinux __llvm_prf_data section.
  * If not, don't allocate since we can't handle modules yet.
  */

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

