Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE26411895
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbhITPql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242035AbhITPqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:46:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A27E761159;
        Mon, 20 Sep 2021 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632152713;
        bh=EC+9dyajYM2OPNtBQsJoiGoRd9MZ5dbX2yOO9/Uoq6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQfTBETIlpVtKbA/+UDc+h1Ycdfi45SAPzATlwtFJTjYsBq6Mc3UvwPR2UUgVqSPq
         xMXRQo1l8idyhR9VJ30vQYai5gQlAlgRocso5YwY4Vcp9vzACHWjMQ3DDxSY762Zoa
         AIaqdF8h2C2XItW7pFDb/SjOj+f6fgKw7Ox/Nw/YJW/i6ZyOdiGkbruY6Ls6Z6VNBx
         g/AaCCjaTcD21MCKHy4OQH0nDr6o23qJlVRtwvqrcV7uNhudKLLt5z9KImL0KiPZJa
         APYEnZkJhTzK2mQVdHruVNHCkizkjfvMiP9HQ/PR1iX6fW3O1Z2fvNouaPyCv3RXJo
         8YN/X+jF8hiuw==
Date:   Mon, 20 Sep 2021 08:45:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v3] lib/zlib_inflate/inffast: Check config in C to avoid
 unused function warning
Message-ID: <YUishGbHeaDMJDj+@archlinux-ax161>
References: <20210920084332.5752-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920084332.5752-1-pmenzel@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 10:43:33AM +0200, Paul Menzel wrote:
> Building Linux for ppc64le with Ubuntu clang version 12.0.0-3ubuntu1~21.04.1
> shows the warning below.
> 
>     arch/powerpc/boot/inffast.c:20:1: warning: unused function 'get_unaligned16' [-Wunused-function]
>     get_unaligned16(const unsigned short *p)
>     ^
>     1 warning generated.
> 
> Fix it, by moving the check from the preprocessor to C, so the compiler
> sees the use.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> v2: Use IS_ENABLED
> v3: Use if statement over ternary operator as requested by Christophe
> 
>  lib/zlib_inflate/inffast.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
> index f19c4fbe1be7..2843f9bb42ac 100644
> --- a/lib/zlib_inflate/inffast.c
> +++ b/lib/zlib_inflate/inffast.c
> @@ -253,13 +253,12 @@ void inflate_fast(z_streamp strm, unsigned start)
>  
>  			sfrom = (unsigned short *)(from);
>  			loops = len >> 1;
> -			do
> -#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -			    *sout++ = *sfrom++;
> -#else
> -			    *sout++ = get_unaligned16(sfrom++);
> -#endif
> -			while (--loops);
> +			do {
> +			    if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
> +				*sout++ = *sfrom++;
> +			    else
> +				*sout++ = get_unaligned16(sfrom++);
> +			} while (--loops);
>  			out = (unsigned char *)sout;
>  			from = (unsigned char *)sfrom;
>  		    } else { /* dist == 1 or dist == 2 */
> -- 
> 2.33.0
> 
