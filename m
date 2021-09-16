Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E640DD6A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 16:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbhIPO7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 10:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235474AbhIPO7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:59:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0DF860F6B;
        Thu, 16 Sep 2021 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631804309;
        bh=AgqdIcDpy91eL8LK1OITNsHLzbyaPNMmq9RB0DZLZQ8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HuUVKWhN0Cyc3CwcojR+XB+bbOC/LqtJv/hJmtqmtM3VctvEWQLqUSvol9yx3+vxP
         ursQPNIXbL6KAvPrdcxJ/WvldvdmJAEBvlQ3vvNoj5I7eKH1Z6XvsU9PXrzuXEVnPL
         +wUuxZgO8GpkpffycTf1COG/dR8Jkht3YwJDqHhL5Xo/r6thIa3oAy5d0KM5916EG8
         KEGdZGyVc7VZSrcRzy7rVOD9bugyjPV39/0tBW1qrBpoCCMRI4Rk62EBrQMkLhULib
         9Pq0UOJbjh4fPJ6fxnBnt2fEpsBDuvINm3PK7z1Lg4FF70fU90ORMU5SJqLJadmQzA
         BSwdASIONLGXg==
Subject: Re: [PATCH] lib/zlib_inflate/inffast: Check config in C to avoid
 unused function warning
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20210916142210.26722-1-pmenzel@molgen.mpg.de>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <decede05-591b-b51c-bd5f-d844b1895e54@kernel.org>
Date:   Thu, 16 Sep 2021 07:58:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916142210.26722-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 9/16/2021 7:22 AM, Paul Menzel wrote:
> Building Linux for ppc64le with Ubuntu clang version 12.0.0-3ubuntu1~21.04.1
> shows the warning below.
> 
>      arch/powerpc/boot/inffast.c:20:1: warning: unused function 'get_unaligned16' [-Wunused-function]
>      get_unaligned16(const unsigned short *p)
>      ^
>      1 warning generated.
> 
> Fix it, by moving the check from the preprocessor to C, so the compiler
> sees the use.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>   lib/zlib_inflate/inffast.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
> index f19c4fbe1be7..444ad3c3ccd3 100644
> --- a/lib/zlib_inflate/inffast.c
> +++ b/lib/zlib_inflate/inffast.c
> @@ -254,11 +254,7 @@ void inflate_fast(z_streamp strm, unsigned start)
>   			sfrom = (unsigned short *)(from);
>   			loops = len >> 1;
>   			do
> -#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -			    *sout++ = *sfrom++;
> -#else
> -			    *sout++ = get_unaligned16(sfrom++);
> -#endif
> +			    *sout++ = CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS ? *sfrom++ : get_unaligned16(sfrom++);
>   			while (--loops);
>   			out = (unsigned char *)sout;
>   			from = (unsigned char *)sfrom;
> 

Thanks for the patch. This should probably be

IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ? ...

which matches the rest of the kernel tree, as certain CONFIG_... values 
are not guaranteed to always be defined.

Cheers,
Nathan
