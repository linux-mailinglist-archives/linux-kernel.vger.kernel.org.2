Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2716840F18C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 07:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244786AbhIQFS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 01:18:26 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:45041 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhIQFSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 01:18:25 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H9hyk2qq5z9sTc;
        Fri, 17 Sep 2021 07:17:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nv5IhXWb4hJc; Fri, 17 Sep 2021 07:17:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H9hyk1bp6z9sTX;
        Fri, 17 Sep 2021 07:17:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 186B28B783;
        Fri, 17 Sep 2021 07:17:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rpsHFshvp2DV; Fri, 17 Sep 2021 07:17:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.36])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D7E38B768;
        Fri, 17 Sep 2021 07:17:01 +0200 (CEST)
Subject: Re: [PATCH] lib/zlib_inflate/inffast: Check config in C to avoid
 unused function warning
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20210916142210.26722-1-pmenzel@molgen.mpg.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <51258322-8665-76f9-c807-76cb56764229@csgroup.eu>
Date:   Fri, 17 Sep 2021 07:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916142210.26722-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/09/2021 à 16:22, Paul Menzel a écrit :
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

You can't do that, CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not 
something that have value 0 or 1, it is something which is either 
defined or not. You have to use IS_ENABLED() macro, so it should become 
something like:

	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
		*sout++ = *sfrom++;
	else
		*sout++ = get_unaligned16(sfrom++);


>   			while (--loops);
>   			out = (unsigned char *)sout;
>   			from = (unsigned char *)sfrom;
> 
