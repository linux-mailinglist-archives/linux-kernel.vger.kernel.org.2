Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1333CFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhCPIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:32:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49887 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234888AbhCPIcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:32:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F063n3w10z9v02D;
        Tue, 16 Mar 2021 09:32:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id l5wHRkQBPkSS; Tue, 16 Mar 2021 09:32:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F063n0rlPz9v02C;
        Tue, 16 Mar 2021 09:32:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E4E128B789;
        Tue, 16 Mar 2021 09:32:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jhvqrq-uzdBC; Tue, 16 Mar 2021 09:32:37 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3ADBD8B782;
        Tue, 16 Mar 2021 09:32:37 +0100 (CET)
Subject: Re: [PATCH mm] kfence: fix printk format for ptrdiff_t
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <20210303121157.3430807-1-elver@google.com>
 <CAG_fn=W-jmnMWO24ZKdkR13K0h_0vfR=ceCVSrYOCCmDsHUxkQ@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c1fea2e6-4acf-1fff-07ff-1b430169f22f@csgroup.eu>
Date:   Tue, 16 Mar 2021 09:32:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=W-jmnMWO24ZKdkR13K0h_0vfR=ceCVSrYOCCmDsHUxkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+segher

Le 03/03/2021 à 13:27, Alexander Potapenko a écrit :
> On Wed, Mar 3, 2021 at 1:12 PM Marco Elver <elver@google.com> wrote:
>>
>> Use %td for ptrdiff_t.
>>
>> Link: https://lkml.kernel.org/r/3abbe4c9-16ad-c168-a90f-087978ccd8f7@csgroup.eu
>> Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> 

Still a problem.

I don't understand, gcc bug ?

The offending argument is 'const ptrdiff_t object_index'

We have:

arch/powerpc/include/uapi/asm/posix_types.h:typedef long		__kernel_ptrdiff_t;
include/linux/types.h:typedef __kernel_ptrdiff_t	ptrdiff_t;

And get:

   CC      mm/kfence/report.o
In file included from ./include/linux/printk.h:7,
                  from ./include/linux/kernel.h:16,
                  from mm/kfence/report.c:10:
mm/kfence/report.c: In function 'kfence_report_error':
./include/linux/kern_levels.h:5:18: warning: format '%td' expects argument of type 'ptrdiff_t', but 
argument 6 has type 'long int' [-Wformat=]
     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
       |                  ^~~~~~
./include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
       |                  ^~~~~~~~
./include/linux/printk.h:343:9: note: in expansion of macro 'KERN_ERR'
   343 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
       |         ^~~~~~~~
mm/kfence/report.c:213:3: note: in expansion of macro 'pr_err'
   213 |   pr_err("Out-of-bounds %s at 0x%p (%luB %s of kfence-#%td):\n",
       |   ^~~~~~
./include/linux/kern_levels.h:5:18: warning: format '%td' expects argument of type 'ptrdiff_t', but 
argument 4 has type 'long int' [-Wformat=]
     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
       |                  ^~~~~~
./include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
       |                  ^~~~~~~~
./include/linux/printk.h:343:9: note: in expansion of macro 'KERN_ERR'
   343 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
       |         ^~~~~~~~
mm/kfence/report.c:222:3: note: in expansion of macro 'pr_err'
   222 |   pr_err("Use-after-free %s at 0x%p (in kfence-#%td):\n",
       |   ^~~~~~
./include/linux/kern_levels.h:5:18: warning: format '%td' expects argument of type 'ptrdiff_t', but 
argument 2 has type 'long int' [-Wformat=]
     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
       |                  ^~~~~~
./include/linux/kern_levels.h:24:19: note: in expansion of macro 'KERN_SOH'
    24 | #define KERN_CONT KERN_SOH "c"
       |                   ^~~~~~~~
./include/linux/printk.h:385:9: note: in expansion of macro 'KERN_CONT'
   385 |  printk(KERN_CONT fmt, ##__VA_ARGS__)
       |         ^~~~~~~~~
mm/kfence/report.c:229:3: note: in expansion of macro 'pr_cont'
   229 |   pr_cont(" (in kfence-#%td):\n", object_index);
       |   ^~~~~~~
./include/linux/kern_levels.h:5:18: warning: format '%td' expects argument of type 'ptrdiff_t', but 
argument 3 has type 'long int' [-Wformat=]
     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
       |                  ^~~~~~
./include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
       |                  ^~~~~~~~
./include/linux/printk.h:343:9: note: in expansion of macro 'KERN_ERR'
   343 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
       |         ^~~~~~~~
mm/kfence/report.c:239:3: note: in expansion of macro 'pr_err'
   239 |   pr_err("Invalid free of 0x%p (in kfence-#%td):\n", (void *)address,
       |   ^~~~~~


Christophe
