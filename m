Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87141407620
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbhIKKpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 06:45:14 -0400
Received: from ozlabs.org ([203.11.71.1]:49445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235443AbhIKKpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 06:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1631357040;
        bh=IAM6TXV6wXFq89B5Tg489wwFMphvmD5Og9aY6yFESQg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R6ZXpzlbpiL9jKuN4WCfe1KuLWTgLxflTVJRzGiDwa0pTXkvhcPYgdcqb9H4N9qiG
         8YEQ7ydw8LYh1/3D6ULsiYSP/DMc+YZTYTW+45tyjXHzu2lx4k0hSZmJm6MVkk3sYd
         pu1rcfjKjFOrZLYgRGg3z2cysyHY2x5M4m/FjY1tIGH7O1GkPxLsZCbPhk5UMMi/0n
         1eKfoEKCNAg0wXJdTwH47G+1h/05x9gA7FiSr4kB5BZQ4IoTXYqsJMlid5dtVttVSf
         C/xR4iqL2YXJQ993AakossuahedxPa1CEg1CMLimvXL7ZQEYMVZEjeyIfdfcr0s6sz
         wOQDz+okAuIIg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H68Vj4T5kz9sXk;
        Sat, 11 Sep 2021 20:43:57 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/10] powerpc: remove GCC version check for UPD_CONSTR
In-Reply-To: <b940bd2c-21d2-dfe9-e171-e265085a2b11@kernel.org>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-7-ndesaulniers@google.com>
 <b940bd2c-21d2-dfe9-e171-e265085a2b11@kernel.org>
Date:   Sat, 11 Sep 2021 20:43:57 +1000
Message-ID: <87zgsjl7de.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:
> On 9/10/2021 4:40 PM, Nick Desaulniers wrote:
>> Now that GCC 5.1 is the minimum supported version, we can drop this
>> workaround for older versions of GCC. This adversely affected clang,
>> too.
>> 
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Segher Boessenkool <segher@kernel.crashing.org>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> ---
>>   arch/powerpc/include/asm/asm-const.h | 10 ----------
>>   1 file changed, 10 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/asm-const.h b/arch/powerpc/include/asm/asm-const.h
>> index 0ce2368bd20f..dbfa5e1e3198 100644
>> --- a/arch/powerpc/include/asm/asm-const.h
>> +++ b/arch/powerpc/include/asm/asm-const.h
>> @@ -12,16 +12,6 @@
>>   #  define ASM_CONST(x)		__ASM_CONST(x)
>>   #endif
>>   
>> -/*
>> - * Inline assembly memory constraint
>> - *
>> - * GCC 4.9 doesn't properly handle pre update memory constraint "m<>"
>> - *
>> - */
>> -#if defined(GCC_VERSION) && GCC_VERSION < 50000
>> -#define UPD_CONSTR ""
>> -#else
>>   #define UPD_CONSTR "<>"
>> -#endif
>
> The only reason this exists is because of commit 592bbe9c505d 
> ("powerpc/uaccess: Don't use "m<>" constraint with GCC 4.9"). It is 
> probably just worth sinking "<>" into all of the callsites and removing
> UPD_CONSTR.

Yeah that would be great if you're doing a v2. Or we can do it as a
follow-up.

cheers
