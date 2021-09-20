Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA02411150
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhITIs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:48:57 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45299 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231625AbhITIs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:48:56 -0400
Received: from [192.168.0.3] (ip5f5aef72.dynamic.kabel-deutschland.de [95.90.239.114])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0FB6E61E5FE00;
        Mon, 20 Sep 2021 10:47:29 +0200 (CEST)
Subject: Re: [PATCH v2] lib/zlib_inflate/inffast: Check config in C to avoid
 unused function warning
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20210920074633.13089-1-pmenzel@molgen.mpg.de>
 <00f8d7d7-cb13-203e-5a37-aee34a3258ff@csgroup.eu>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <dcae41fe-b09b-eb0c-f518-f49e2ea36aa8@molgen.mpg.de>
Date:   Mon, 20 Sep 2021 10:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <00f8d7d7-cb13-203e-5a37-aee34a3258ff@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Christophe,


Thank you for the review.

Am 20.09.21 um 10:36 schrieb Christophe Leroy:
> 
> 
> Le 20/09/2021 à 09:46, Paul Menzel a écrit :
>> Building Linux for ppc64le with Ubuntu clang version 12.0.0-3ubuntu1~21.04.1
>> shows the warning below.
>>
>>      arch/powerpc/boot/inffast.c:20:1: warning: unused function 'get_unaligned16' [-Wunused-function]
>>      get_unaligned16(const unsigned short *p)
>>      ^
>>      1 warning generated.
>>
>> Fix it, by moving the check from the preprocessor to C, so the compiler
>> sees the use.
>>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>>   lib/zlib_inflate/inffast.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
>> index f19c4fbe1be7..fb87a3120f0f 100644
>> --- a/lib/zlib_inflate/inffast.c
>> +++ b/lib/zlib_inflate/inffast.c
>> @@ -254,11 +254,8 @@ void inflate_fast(z_streamp strm, unsigned start)
>>               sfrom = (unsigned short *)(from);
>>               loops = len >> 1;
>>               do
>> -#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>> -                *sout++ = *sfrom++;
>> -#else
>> -                *sout++ = get_unaligned16(sfrom++);
>> -#endif
>> +                *sout++ = 
>> IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ?
>> +                *sfrom++ : get_unaligned16(sfrom++);
> 
> I think it would be more readable as
> 
> do {
>          if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
>                  *sout++ = *sfrom++;
>          else
>                  *sout++ = get_unaligned16(sfrom++);
> } while (--loops);

I prefer the ternary operator, as it’s less lines, and it’s clear, that 
only the variable assignment is affected by the condition. But as style 
is subjective, I sent v3.

>>               while (--loops);
>>               out = (unsigned char *)sout;
>>               from = (unsigned char *)sfrom;


Kind regards,

Paul
