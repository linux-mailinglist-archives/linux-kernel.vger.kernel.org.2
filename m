Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0CE391E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhEZSBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbhEZSBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:01:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD6EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=EhcbGn82P1aMRBzk35vUH4tsbyiGy0EL2EgdMVyTk24=; b=j/6e+LpThe9SpuWQh+EkRNrt82
        gcVeYpQ8BOFSXMJ7kL7qofAJgHZO+93nyhMx5QKhDlKQYCJxbusI5rzS4/FBfFP4E+wxx8Qhkz4nX
        n0A/JqOhGIhKvxX7Z0G4zzoPfdjMOUeU5MZsK7rxGuVNg6U05GL8SzQz/VGLT3ve3ste0okQVYKHB
        GyDzJrrmartXnXcYMe7pF5A40qFbafk4zOiZtnD9jM7j1rGZDS+ABikmFQi68qtBf6bXIGdp+XopN
        bNSNlUCLKS9cXTk6Ia/Dr3u/XEfoks1itHw08z0B4RlOYAvfB4WHWmSUVkYhcQmFz+tU2ZXnTqHkA
        eOq56Ksg==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llxou-00GKFL-HN; Wed, 26 May 2021 17:59:52 +0000
Subject: Re: [PATCH] x86: fixmap: use CONFIG_NR_CPUS instead of NR_CPUS
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Mel Gorman <mgorman@techsingularity.net>,
        Tom Rix <trix@redhat.com>
References: <20210521195918.2183-1-rdunlap@infradead.org>
 <YK3vrIB7cWop+UIW@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <59676378-1b52-cae7-7944-adeffd27190e@infradead.org>
Date:   Wed, 26 May 2021 10:59:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YK3vrIB7cWop+UIW@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 11:50 PM, Ingo Molnar wrote:
> 
> * Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Use CONFIG_NR_CPUS instead of NR_CPUS for an enum entry item.
>> (Alternatively, #include <linux/threads.h> unconditionally instead of
>> conditionally.)
>>
>> This fixes 100+ build errors like so:
>>
>> In file included from ../include/asm-generic/early_ioremap.h:6:0,
>>                  from ./arch/x86/include/generated/asm/early_ioremap.h:1,
>>                  from ../arch/x86/include/asm/io.h:44,
>>                  from ../include/linux/io.h:13,
>>                  from ../mm/early_ioremap.c:13:
>> ../arch/x86/include/asm/fixmap.h:103:48: error: ‘NR_CPUS’ undeclared here (not in a function); did you mean ‘NR_OPEN’?
>>   FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
>>
>> Fixes: e972c2511967 ("mm/early_ioremap: add prototype for early_memremap_pgprot_adjust")
> 
> I believe this patch is in the -mm tree, not the x86 tree.
> 
>> @@ -100,7 +100,7 @@ enum fixed_addresses {
>>  #endif
>>  #ifdef CONFIG_KMAP_LOCAL
>>  	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
>> -	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
>> +	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * CONFIG_NR_CPUS) - 1,
>>  #ifdef CONFIG_PCI_MMCONFIG
>>  	FIX_PCIE_MCFG,
>>  #endif
> 
> Please resolve this bug properly:
> 
>  - Don't sprinkle low level headers with random CONFIG_NR_CPUS conversions.
> 
>  - <asm/io.h> currently includes <asm/early_ioremap.h>, but this seems 
>    unjustified.

Deleting it causes build errors.

>  - Once early_ioremap.h is gone from io.h, it's potentially possible to 
>    include <linux/threads.h>. More work to resolve dependencies might be 
>    needed though.

Yes, my first patch for this (unsent) just included <linux/threads.h>
in fixmap.h unconditionally instead of conditionally.

> Frankly, I'd prefer if such a low level header dependencies change came in 
> via the x86 tree so we can properly review it, test it, and keep it 
> working. Right now I can only guess what is needed here...

Sure, makes sense.

Mel, do you have any patch suggestions here?  re:

commit e972c2511967181d955f74181d74438e26b2e797
Author: Mel Gorman <mgorman@techsingularity.net>
Date:   Fri May 21 10:40:56 2021 +1000

    mm/early_ioremap: add prototype for early_memremap_pgprot_adjust


thanks.
-- 
~Randy

