Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03CB33F733
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhCQRgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:36:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37721 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhCQRgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:36:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F0y583vFpzB09Zd;
        Wed, 17 Mar 2021 18:36:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id v-2_sLTpHPTF; Wed, 17 Mar 2021 18:36:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F0y582RpmzB09Zb;
        Wed, 17 Mar 2021 18:36:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 213F28B866;
        Wed, 17 Mar 2021 18:36:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ARYtUs8FK9Ly; Wed, 17 Mar 2021 18:36:46 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F7D28B865;
        Wed, 17 Mar 2021 18:36:45 +0100 (CET)
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
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <001a139e-d4fa-2fd7-348f-173392210dfd@csgroup.eu>
Date:   Wed, 17 Mar 2021 18:35:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6d4b370dc76543f2ba8ad7c6dcdfc7af@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/03/2021 à 13:51, David Laight a écrit :
> From: Christophe Leroy
>> Sent: 16 March 2021 15:41
> ...
>>>> include/linux/types.h:typedef __kernel_ptrdiff_t	ptrdiff_t;
>>>>
>>>> And get:
>>>>
>>>>     CC      mm/kfence/report.o
>>>> In file included from ./include/linux/printk.h:7,
>>>>                    from ./include/linux/kernel.h:16,
>>>>                    from mm/kfence/report.c:10:
>>>> mm/kfence/report.c: In function 'kfence_report_error':
>>>> ./include/linux/kern_levels.h:5:18: warning: format '%td' expects argument
>>>> of type 'ptrdiff_t', but argument 6 has type 'long int' [-Wformat=]
>>>
>>> This is declared as
>>>           const ptrdiff_t object_index = meta ? meta - kfence_metadata : -1;
>>> so maybe something with that goes wrong?  What happens if you delete the
>>> (useless) "const" here?
> 
> The obvious thing to try is changing it to 'int'.
> That will break 64bit builds, but if it fixes the 32bit one
> it will tell you what type gcc is expecting.
> 

Yes, if defining 'object_index' as int, gcc is happy.
If removing the powerpc re-definition of ptrdiff_t typedef in 
https://elixir.bootlin.com/linux/v5.12-rc3/source/arch/powerpc/include/uapi/asm/posix_types.h , it 
works great as well.

So seems like gcc doesn't take into account the typedef behind ptrdiff_t, it just expects it to be 
int on 32 bits ?

Christophe
