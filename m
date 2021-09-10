Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D740740F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhIJXwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234787AbhIJXwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:52:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C14761215;
        Fri, 10 Sep 2021 23:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631317857;
        bh=uIpzXfyi8+fV+u3rmhdW4lpuq9BRwztl6U+ksNKr5PI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PIBWcXKzrLpgOJluRe/nYh34CXuRmxKG27Dbkve6wm+0eJ7x7H6z1IbAhgZArFREO
         1az18KO+TyHJppslmxXpR0LoXiXckEnto/CeJUadea/vLrq5JZXOn6QE9u/9gvPh3l
         BzFIULLWf1jk/uYBj1MjA2kQ+Z1d8xjnPxe4YPNw74JLvUyQzYkn2Lr+sf4eFvxeSh
         /IuDhsR1qGJ67svnFkpkL4xyAqunt6zgwVkeAUJW9U61xopJL6l2khHnwWL/kBEz06
         OpdpNLK0eu9nvb5P/G60oOIskv+VfLNCD8sMEtGb10Nw/LMYD/E2fhoXFATagx+e79
         InTBhzg2s9w6A==
Subject: Re: [PATCH 10/10] vmlinux.lds.h: remove old check for GCC 4.9
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-11-ndesaulniers@google.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <9433c702-ecf2-4197-2456-59857d38538d@kernel.org>
Date:   Fri, 10 Sep 2021 16:50:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910234047.1019925-11-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/2021 4:40 PM, Nick Desaulniers wrote:
> Now that GCC 5.1 is the minimally supported version of GCC, we can
> effectively revert
> 
> commit 85c2ce9104eb ("sched, vmlinux.lds: Increase STRUCT_ALIGNMENT to
> 64 bytes for GCC-4.9")
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>   include/asm-generic/vmlinux.lds.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index aa50bf2959fe..f2984af2b85b 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -116,11 +116,7 @@
>    * GCC 4.5 and later have a 32 bytes section alignment for structures.
>    * Except GCC 4.9, that feels the need to align on 64 bytes.

Comment should be adjusted.

>    */
> -#if __GNUC__ == 4 && __GNUC_MINOR__ == 9
> -#define STRUCT_ALIGNMENT 64
> -#else
>   #define STRUCT_ALIGNMENT 32
> -#endif
>   #define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
>   
>   /*
> 
