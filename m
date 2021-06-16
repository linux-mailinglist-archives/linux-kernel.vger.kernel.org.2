Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAAF3AA25C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhFPRZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:25:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46115 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhFPRZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:25:40 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G4sTw3h6xzBF2H;
        Wed, 16 Jun 2021 19:23:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yApHasqJizLg; Wed, 16 Jun 2021 19:23:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G4sTw2hZ0zBF2F;
        Wed, 16 Jun 2021 19:23:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED0A98B7F4;
        Wed, 16 Jun 2021 19:23:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LawfKpjZWmkI; Wed, 16 Jun 2021 19:23:31 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EBB2C8B7F2;
        Wed, 16 Jun 2021 19:23:30 +0200 (CEST)
Subject: Re: [PATCH v13 3/3] kasan: define and use MAX_PTRS_PER_* for early
 shadow tables
To:     Marco Elver <elver@google.com>, Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.ibm.com,
        Balbir Singh <bsingharora@gmail.com>
References: <20210616080244.51236-1-dja@axtens.net>
 <20210616080244.51236-4-dja@axtens.net>
 <CANpmjNN2-nkqaQ8J3nU5QJ4KGkX2mwiNTeTCNPGQYdbb1v2OaA@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <86c9cecd-ec51-533c-0903-87b85c733695@csgroup.eu>
Date:   Wed, 16 Jun 2021 19:23:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNN2-nkqaQ8J3nU5QJ4KGkX2mwiNTeTCNPGQYdbb1v2OaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/06/2021 à 11:07, Marco Elver a écrit :
> On Wed, 16 Jun 2021 at 10:03, Daniel Axtens <dja@axtens.net> wrote:
> [...]
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index 768d7d342757..fd65f477ac92 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -40,10 +40,22 @@ struct kunit_kasan_expectation {
>>   #define PTE_HWTABLE_PTRS 0
>>   #endif
>>
>> +#ifndef MAX_PTRS_PER_PTE
>> +#define MAX_PTRS_PER_PTE PTRS_PER_PTE
>> +#endif
>> +
>> +#ifndef MAX_PTRS_PER_PMD
>> +#define MAX_PTRS_PER_PMD PTRS_PER_PMD
>> +#endif
>> +
>> +#ifndef MAX_PTRS_PER_PUD
>> +#define MAX_PTRS_PER_PUD PTRS_PER_PUD
>> +#endif
> 
> This is introducing new global constants in a <linux/..> header. It
> feels like this should be in <linux/pgtable.h> together with a
> comment. Because <linux/kasan.h> is actually included in
> <linux/slab.h>, most of the kernel will get these new definitions.
> That in itself is fine, but it feels wrong that the KASAN header
> introduces these.
> 
> Thoughts?
> 
> Sorry for only realizing this now.

My idea here was to follow the same road as MAX_PTRS_PER_P4D, added by commit 
https://github.com/linuxppc/linux/commit/c65e774f

That commit spread MAX_PTRS_PER_P4D everywhere.

Instead of doing the same, we found that it would be better to define a fallback for when the 
architecture doesn't define MAX_PTRS_PER_PxD . Now, it can be made more global in pgtable.h, in that 
case I'd suggest to also include MAX_PTRS_PER_P4D in the dance and avoid architectures like s390 
having to define it, or even not defining it either in asm-generic/pgtable-nop4d.h

Christophe

> 
> Thanks,
> -- Marco
> 
>>   extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
>> -extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS];
>> -extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
>> -extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
>> +extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS];
>> +extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
>> +extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
>>   extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>>
>>   int kasan_populate_early_shadow(const void *shadow_start,
>> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
>> index 348f31d15a97..cc64ed6858c6 100644
>> --- a/mm/kasan/init.c
>> +++ b/mm/kasan/init.c
>> @@ -41,7 +41,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
>>   }
>>   #endif
>>   #if CONFIG_PGTABLE_LEVELS > 3
>> -pud_t kasan_early_shadow_pud[PTRS_PER_PUD] __page_aligned_bss;
>> +pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
>>   static inline bool kasan_pud_table(p4d_t p4d)
>>   {
>>          return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
>> @@ -53,7 +53,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
>>   }
>>   #endif
>>   #if CONFIG_PGTABLE_LEVELS > 2
>> -pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> +pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
>>   static inline bool kasan_pmd_table(pud_t pud)
>>   {
>>          return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
>> @@ -64,7 +64,7 @@ static inline bool kasan_pmd_table(pud_t pud)
>>          return false;
>>   }
>>   #endif
>> -pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS]
>> +pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS]
>>          __page_aligned_bss;
>>
>>   static inline bool kasan_pte_table(pmd_t pmd)
>> --
>> 2.30.2
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210616080244.51236-4-dja%40axtens.net.
