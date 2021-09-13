Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57D4099E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhIMQt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238219AbhIMQt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:49:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C657760F26;
        Mon, 13 Sep 2021 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631551691;
        bh=dgZoCqLRf7yYWTZPvAE8JfsdZ8bcTrri+VeUGd3Iql0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7krykSzHQ2oEYzswpeqbkf6gI29sZwJe/8kAJPOfbPnLkn2PamRUl9wC/DzveXLP
         GhNrMiSeoscNezVWufm1PfIf8FfSYdsQikMUOe1jDqDOpG6rjReQ8BpZBEEcjwAZhn
         gYlWxk+2izBA93AwNrdz5EcHCLNkjkcVnjHpe4eM=
Date:   Mon, 13 Sep 2021 18:48:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/uaccess: Fix 32-bit __get_user_asm_u64() when
 CC_HAS_ASM_GOTO_OUTPUT=y
Message-ID: <YT+AyR2JHh02Q0B1@kroah.com>
References: <20210913163547.5156-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913163547.5156-1-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 05:35:47PM +0100, Will Deacon wrote:
> Commit 865c50e1d279 ("x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT")
> added an optimised version of __get_user_asm() for x86 using 'asm goto'.
> 
> Like the non-optimised code, the 32-bit implementation of 64-bit get_user()
> expands to a pair of 32-bit accesses. Unlike the non-optimised code, the
> _original_ pointer is incremented to copy the high word instead of loading
> through a new pointer explicitly constructed to point at a 32-bit type.
> Consequently, if the pointer points at a 64-bit type then we end up
> loading the wrong data for the upper 32-bits.
> 
> This was observed as a mount() failure in Android targetting i686 after
> b0cfcdd9b967 ("d_path: make 'prepend()' fill up the buffer exactly on
> overflow") because the call to copy_from_kernel_nofault() from
> prepend_copy() ends up in __get_kernel_nofault() and casts the source
> pointer to a 'u64 __user *'. An attempt to mount at "/debug_ramdisk"
> therefore ends up failing trying to mount "/debumdismdisk".
> 
> Use the existing '__gu_ptr' source pointer to unsigned int for 32-bit
> __get_user_asm_u64() instead of the original pointer.
> 
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 865c50e1d279 ("x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/x86/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index c9fa7be3df82..5c95d242f38d 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -301,8 +301,8 @@ do {									\
>  	unsigned int __gu_low, __gu_high;				\
>  	const unsigned int __user *__gu_ptr;				\
>  	__gu_ptr = (const void __user *)(ptr);				\
> -	__get_user_asm(__gu_low, ptr, "l", "=r", label);		\
> -	__get_user_asm(__gu_high, ptr+1, "l", "=r", label);		\
> +	__get_user_asm(__gu_low, __gu_ptr, "l", "=r", label);		\
> +	__get_user_asm(__gu_high, __gu_ptr+1, "l", "=r", label);	\
>  	(x) = ((unsigned long long)__gu_high << 32) | __gu_low;		\
>  } while (0)
>  #else
> -- 
> 2.33.0.309.g3052b89438-goog
> 

Tested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for finding and fixing this!

greg k-h
