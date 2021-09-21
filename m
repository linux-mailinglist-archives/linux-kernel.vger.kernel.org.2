Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3140413159
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhIUKNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:13:05 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:41279 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232130AbhIUKMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:12:47 -0400
Received: from [192.168.178.35] (unknown [88.130.155.181])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 53A2761E64760;
        Tue, 21 Sep 2021 12:11:17 +0200 (CEST)
Subject: Re: [PATCH v3] lib/zlib_inflate/inffast: Check config in C to avoid
 unused function warning
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20210920084332.5752-1-pmenzel@molgen.mpg.de>
 <YUishGbHeaDMJDj+@archlinux-ax161>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <d00bb831-211e-0c7b-2734-1ed7769af2ef@molgen.mpg.de>
Date:   Tue, 21 Sep 2021 12:11:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUishGbHeaDMJDj+@archlinux-ax161>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Am 20.09.21 um 17:45 schrieb Nathan Chancellor:
> On Mon, Sep 20, 2021 at 10:43:33AM +0200, Paul Menzel wrote:
>> Building Linux for ppc64le with Ubuntu clang version 12.0.0-3ubuntu1~21.04.1
>> shows the warning below.
>>
>>      arch/powerpc/boot/inffast.c:20:1: warning: unused function 'get_unaligned16' [-Wunused-function]
>>      get_unaligned16(const unsigned short *p)
>>      ^
>>      1 warning generated.
>>
>> Fix it, by moving the check from the preprocessor to C, so the compiler
>> sees the use.
>>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
>> ---
>> v2: Use IS_ENABLED
>> v3: Use if statement over ternary operator as requested by Christophe
>>
>>   lib/zlib_inflate/inffast.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
>> index f19c4fbe1be7..2843f9bb42ac 100644
>> --- a/lib/zlib_inflate/inffast.c
>> +++ b/lib/zlib_inflate/inffast.c
>> @@ -253,13 +253,12 @@ void inflate_fast(z_streamp strm, unsigned start)
>>   
>>   			sfrom = (unsigned short *)(from);
>>   			loops = len >> 1;
>> -			do
>> -#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>> -			    *sout++ = *sfrom++;
>> -#else
>> -			    *sout++ = get_unaligned16(sfrom++);
>> -#endif
>> -			while (--loops);
>> +			do {
>> +			    if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
>> +				*sout++ = *sfrom++;
>> +			    else
>> +				*sout++ = get_unaligned16(sfrom++);
>> +			} while (--loops);
>>   			out = (unsigned char *)sout;
>>   			from = (unsigned char *)sfrom;
>>   		    } else { /* dist == 1 or dist == 2 */
>> -- 
>> 2.33.0

Just for the record,

I compared both object files by running `objdump -d`, and the result is 
the same.

The binary differed (`vbindiff`), but I guess this is due to the 
increased revision (`make bindeb-pkg`).

without a change (Linus’ current master):

0000 0B50: 00 00 00 00 00 00 00 00  1F 01 00 00 36 00 00 00  ........ 
....6...
                                      ^
0000 0B60: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ........ 
........
0000 0B70: 00 00 00 00 00 00 00 00  29 01 00 00 32 00 00 00  ........ 
)...2...
                                      ^

v2 (ternary operator):

0000 0B50: 00 00 00 00 00 00 00 00  1C 01 00 00 36 00 00 00  ........ 
....6...
0000 0B60: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ........ 
........
0000 0B70: 00 00 00 00 00 00 00 00  26 01 00 00 32 00 00 00  ........ 
&...2...

v3 (if-else statement):

0000 0B50: 00 00 00 00 00 00 00 00  1E 01 00 00 36 00 00 00  ........ 
....6...
0000 0B60: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ........ 
........
0000 0B70: 00 00 00 00 00 00 00 00  28 01 00 00 32 00 00 00  ........ 
(...2...


Kind regards,

Paul
