Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF9D34023E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCRJjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:39:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46025 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhCRJiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:38:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F1MRB6KJyz9twcf;
        Thu, 18 Mar 2021 10:38:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Y-YcfSLncL4O; Thu, 18 Mar 2021 10:38:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F1MRB4pdHz9twcd;
        Thu, 18 Mar 2021 10:38:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BEB3E8B8C9;
        Thu, 18 Mar 2021 10:38:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id feJZioXZgfgZ; Thu, 18 Mar 2021 10:38:47 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1693B8B881;
        Thu, 18 Mar 2021 10:38:47 +0100 (CET)
Subject: Re: [PATCH mm] kfence: fix printk format for ptrdiff_t
To:     David Laight <David.Laight@ACULAB.COM>,
        Segher Boessenkool <segher@kernel.crashing.org>
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
 <3f624e5b-567d-70f9-322f-e721b2df508b@csgroup.eu>
 <6d4b370dc76543f2ba8ad7c6dcdfc7af@AcuMS.aculab.com>
 <001a139e-d4fa-2fd7-348f-173392210dfd@csgroup.eu>
 <4f7becfe2b6e4263be83b5ee461b5732@AcuMS.aculab.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <e4577151-bc73-5033-a9ed-114dd0c1aaaf@csgroup.eu>
Date:   Thu, 18 Mar 2021 10:38:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4f7becfe2b6e4263be83b5ee461b5732@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/03/2021 à 10:14, David Laight a écrit :
> From: Christophe Leroy
>> Sent: 17 March 2021 17:35
>>
>> Le 17/03/2021 à 13:51, David Laight a écrit :
>>> From: Christophe Leroy
>>>> Sent: 16 March 2021 15:41
>>> ...
>>>>>> include/linux/types.h:typedef __kernel_ptrdiff_t	ptrdiff_t;
>>>>>>
>>>>>> And get:
>>>>>>
>>>>>>      CC      mm/kfence/report.o
>>>>>> In file included from ./include/linux/printk.h:7,
>>>>>>                     from ./include/linux/kernel.h:16,
>>>>>>                     from mm/kfence/report.c:10:
>>>>>> mm/kfence/report.c: In function 'kfence_report_error':
>>>>>> ./include/linux/kern_levels.h:5:18: warning: format '%td' expects argument
>>>>>> of type 'ptrdiff_t', but argument 6 has type 'long int' [-Wformat=]
>>>>>
>>>>> This is declared as
>>>>>            const ptrdiff_t object_index = meta ? meta - kfence_metadata : -1;
>>>>> so maybe something with that goes wrong?  What happens if you delete the
>>>>> (useless) "const" here?
>>>
>>> The obvious thing to try is changing it to 'int'.
>>> That will break 64bit builds, but if it fixes the 32bit one
>>> it will tell you what type gcc is expecting.
>>>
>>
>> Yes, if defining 'object_index' as int, gcc is happy.
>> If removing the powerpc re-definition of ptrdiff_t typedef in
>> https://elixir.bootlin.com/linux/v5.12-rc3/source/arch/powerpc/include/uapi/asm/posix_types.h , it
>> works great as well.
>>
>> So seems like gcc doesn't take into account the typedef behind ptrdiff_t, it just expects it to be
>> int on 32 bits ?
> 
> gcc never cares how ptrdiff_t (or any of the related types) is defined
> it requires int or long for the format depending on the architecture.
> The error message will say ptrdiff_t or size_t (etc) - but that is just
> in the error message.
> 
> So the ppc32 uapi definition of __kernel_ptrdiff_t is wrong.
> However it is probably set in stone.
> 

Yes it seems to be wrong. It was changed by commit d27dfd3887 ("Import pre2.0.8"), so that's long 
time ago. Before that it was an 'int' for ppc32.

gcc provides ptrdiff_t in stddef.h via __PTRDIFF_TYPE__
gcc defined __PTRDIFF_TYPE__ as 'int' at build time.

Should we fix it in arch/powerpc/include/uapi/asm/posix_types.h ? Anyway 'long' and 'int' makes no 
functionnal difference on 32 bits so there should be no impact for users if any.

Christophe
