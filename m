Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE15E33D7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhCPPlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:41:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65140 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234675AbhCPPlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:41:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F0HZ74Q2Mz9v0XB;
        Tue, 16 Mar 2021 16:41:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id k0D1psiW6rox; Tue, 16 Mar 2021 16:41:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F0HZ73LcGz9v0X9;
        Tue, 16 Mar 2021 16:41:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 065CF8B7E1;
        Tue, 16 Mar 2021 16:41:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zQauc1oIXtG0; Tue, 16 Mar 2021 16:41:04 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D29C8B7E6;
        Tue, 16 Mar 2021 16:41:04 +0100 (CET)
Subject: Re: [PATCH mm] kfence: fix printk format for ptrdiff_t
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <20210303121157.3430807-1-elver@google.com>
 <CAG_fn=W-jmnMWO24ZKdkR13K0h_0vfR=ceCVSrYOCCmDsHUxkQ@mail.gmail.com>
 <c1fea2e6-4acf-1fff-07ff-1b430169f22f@csgroup.eu>
 <20210316153320.GF16691@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <3f624e5b-567d-70f9-322f-e721b2df508b@csgroup.eu>
Date:   Tue, 16 Mar 2021 16:40:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316153320.GF16691@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/03/2021 à 16:33, Segher Boessenkool a écrit :
> On Tue, Mar 16, 2021 at 09:32:32AM +0100, Christophe Leroy wrote:
>> +segher
> 
> I cannot see through the wood of #defines here, sorry.
> 
>> Still a problem.
>>
>> I don't understand, gcc bug ?
> 
> Rule #1: If you do not understand what is happening, it is not a
> compiler bug.  I'm not saying that it isn't, just that it is much more
> likely something else.
> 
>> The offending argument is 'const ptrdiff_t object_index'
>>
>> We have:
>>
>> arch/powerpc/include/uapi/asm/posix_types.h:typedef long	
>> __kernel_ptrdiff_t;
> 
> So this is a 64-bit build.

No it's 32 bits. The code in posix-types.h is

#ifdef __powerpc64__
...
#else
...
typedef long		__kernel_ptrdiff_t;


> 
>> include/linux/types.h:typedef __kernel_ptrdiff_t	ptrdiff_t;
>>
>> And get:
>>
>>    CC      mm/kfence/report.o
>> In file included from ./include/linux/printk.h:7,
>>                   from ./include/linux/kernel.h:16,
>>                   from mm/kfence/report.c:10:
>> mm/kfence/report.c: In function 'kfence_report_error':
>> ./include/linux/kern_levels.h:5:18: warning: format '%td' expects argument
>> of type 'ptrdiff_t', but argument 6 has type 'long int' [-Wformat=]
> 
> This is declared as
>          const ptrdiff_t object_index = meta ? meta - kfence_metadata : -1;
> so maybe something with that goes wrong?  What happens if you delete the
> (useless) "const" here?

No change.

Christophe
