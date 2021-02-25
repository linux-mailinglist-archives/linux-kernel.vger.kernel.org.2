Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3185325865
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhBYVIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:08:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232591AbhBYVAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:00:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3712D64DA3;
        Thu, 25 Feb 2021 20:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614286757;
        bh=eV1kJaWfevV6RouK8LRLTU3ZuWjF9BEgVywj5uj8o6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGtJ0wvdv7iWICnifbRB9ajKhBV1vF/UjYU9qAnPikX4mRlJw3Kipi7kFBjUOTsz5
         22dHxT8QzrP/KE7GmhTzY1gobQr/51iaTYjazU6/9mDt4zBvsMUaQ0OZtu7ROQQsCy
         XKLdR1uRqIW48YGCOv+ohHnHNdvgYIkS8/SCuTNgRolnhbJaamXHXJkGlFyKmxQ4W3
         kqaRYIFV+XTMVQElQPc63YRc8TVVRUcRq7qfIj3rtLX+u/X/QQzmx9GohC/L+e12oT
         PqcZxjlcHx8rYMRnkHkgX2ydCqeOgkkvXNu+DTTBPOwvdS406ljHSvUxAxXpe04viZ
         3QI6GUp43wZYw==
Date:   Thu, 25 Feb 2021 22:59:08 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        David Hildenbrand <david@redhat.com>,
        Aslan Bakirov <aslan@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] memblock: fix section mismatch warning
Message-ID: <20210225205908.GM1447004@kernel.org>
References: <20210225133808.2188581-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225133808.2188581-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:38:00PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The inlining logic in clang-13 is rewritten to often not inline
> some functions that were inlined by all earlier compilers.
> 
> In case of the memblock interfaces, this exposed a harmless bug
> of a missing __init annotation:
> 
> WARNING: modpost: vmlinux.o(.text+0x507c0a): Section mismatch in reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
> The function memblock_bottom_up() references
> the variable __meminitdata memblock.
> This is often because memblock_bottom_up lacks a __meminitdata
> annotation or the annotation of memblock is wrong.
> 
> Interestingly, these annotations were present originally, but got removed
> with the explanation that the __init annotation prevents the function
> from getting inlined. I checked this again and found that while this
> is the case with clang, gcc (version 7 through 10, did not test others)
> does inline the functions regardless.
> 
> As the previous change was apparently intended to help the clang
> builds, reverting it to help the newer clang versions seems appropriate
> as well. gcc builds don't seem to care either way.
> 
> Fixes: 5bdba520c1b3 ("mm: memblock: drop __init from memblock functions to make it inline")
> Reference: 2cfb3665e864 ("include/linux/memblock.h: add __init to memblock_set_bottom_up()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I thought it'll go via memblock tree but since Andrew has already took it

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/memblock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index c88bc24e31aa..d13e3cd938b4 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -460,7 +460,7 @@ static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
>  /*
>   * Set the allocation direction to bottom-up or top-down.
>   */
> -static inline void memblock_set_bottom_up(bool enable)
> +static inline __init void memblock_set_bottom_up(bool enable)
>  {
>  	memblock.bottom_up = enable;
>  }
> @@ -470,7 +470,7 @@ static inline void memblock_set_bottom_up(bool enable)
>   * if this is true, that said, memblock will allocate memory
>   * in bottom-up direction.
>   */
> -static inline bool memblock_bottom_up(void)
> +static inline __init bool memblock_bottom_up(void)
>  {
>  	return memblock.bottom_up;
>  }
> -- 
> 2.29.2
> 

-- 
Sincerely yours,
Mike.
