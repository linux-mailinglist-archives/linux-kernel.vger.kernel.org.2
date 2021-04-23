Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811D3368A25
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 03:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhDWBDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 21:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235839AbhDWBDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 21:03:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A07C613FA;
        Fri, 23 Apr 2021 01:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619139752;
        bh=Ox19n6Uw0xgKat1UWNFlI4zx+CWrVx7fhZhqH2PG83E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpwM6QZoenzepU6yPdlbUiHH4xIboRvEHK6v4sdYygLpni1Gzn9CoI5SKn4l79qbd
         RveD1bWZO63dQXeTJhFEcCG+T9GC4rieANjRgPpDOt+IFyodPgUhZ/s+ieifaggUOh
         C7IS9pWD14VorO6MUY0U6wLxVIUSHrumgSXJpQc8s+mIma4DipDdkhXcc3F7UEXiWk
         BAftQNd3UplN/64vkM7L6GdPmVCTQ6WhdjuokfYYHONYdm2djx0RJwYY2oT3ESI7VX
         MpPPpDIQcjmXgOWjwId0I3SkJrmlzSg6btJ60QIHaNjJrDQ5SJ4NCTeHb1IVskRxbt
         SWFkx89PESu+w==
Date:   Thu, 22 Apr 2021 18:02:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stack: replace "o" output with "r" input constraint
Message-ID: <YIIcoz4fHjVjWHTI@archlinux-ax161>
References: <20210419231741.4084415-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419231741.4084415-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 04:17:41PM -0700, Kees Cook wrote:
> From: Nick Desaulniers <ndesaulniers@google.com>
> 
> "o" isn't a common asm() constraint to use; it triggers an assertion in
> assert-enabled builds of LLVM that it's not recognized when targeting
> aarch64 (though it appears to fall back to "m"). I've fixed this in LLVM
> 13 now, but there isn't really a good reason to be using "o" in particular
> here. To avoid causing build issues for those using assert-enabled builds
> of earlier LLVM versions, the constraint needs changing.
> 
> Instead, if the point is to retain the __builtin_alloca(), we can make ptr
> appear to "escape" via being an input to an empty inline asm block. This
> is preferable anyways, since otherwise this looks like a dead store.
> 
> While the use of "r" was considered in
> https://lore.kernel.org/lkml/202104011447.2E7F543@keescook/
> it was only tested as an output (which looks like a dead store, and
> wasn't sufficient). Use "r" as an input constraint instead, which
> behaves correctly across compilers and architectures:
> https://godbolt.org/z/E9cd411ob
> 
> Link: https://reviews.llvm.org/D100412
> Link: https://bugs.llvm.org/show_bug.cgi?id=49956
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
> Signed-off-by: Kees Cook <keescook@chromium.org>

I built arm64 defconfig with and without
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT with LLVM 12 (which does not have
Nick's LLVM fix) without any issues and did a quick boot test in QEMU,
nothing exploded.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/randomize_kstack.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> index fd80fab663a9..bebc911161b6 100644
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -38,7 +38,7 @@ void *__builtin_alloca(size_t size);
>  		u32 offset = raw_cpu_read(kstack_offset);		\
>  		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
>  		/* Keep allocation even after "ptr" loses scope. */	\
> -		asm volatile("" : "=o"(*ptr) :: "memory");		\
> +		asm volatile("" :: "r"(ptr) : "memory");		\
>  	}								\
>  } while (0)
>  
> -- 
> 2.25.1
> 
