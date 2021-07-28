Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551EA3D8B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhG1KEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:04:55 -0400
Received: from foss.arm.com ([217.140.110.172]:54448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231635AbhG1KEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:04:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB5FC31B;
        Wed, 28 Jul 2021 03:04:52 -0700 (PDT)
Received: from [10.163.65.183] (unknown [10.163.65.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 473503F73D;
        Wed, 28 Jul 2021 03:04:49 -0700 (PDT)
Subject: Re: [PATCH v4 12/12] mm/debug_vm_pgtable: Fix corrupted page flag
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gavin Shan <gshan@redhat.com>
Cc:     shan.gavin@gmail.com, chuhu@redhat.com, akpm@linux-foundation.org,
        will@kernel.org, catalin.marinas@arm.com, cai@lca.pw,
        aneesh.kumar@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-13-gshan@redhat.com>
 <20210728095326.Horde.k1npSPaQKh2i7W3XoBsdiQ3@messagerie.c-s.fr>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <58a1eaa9-ba63-403b-1f4b-c22f23a3a0d3@arm.com>
Date:   Wed, 28 Jul 2021 15:35:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728095326.Horde.k1npSPaQKh2i7W3XoBsdiQ3@messagerie.c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/21 1:23 PM, Christophe Leroy wrote:
> Gavin Shan <gshan@redhat.com> a écrit :
> 
>> In page table entry modifying tests, set_xxx_at() are used to populate
>> the page table entries. On ARM64, PG_arch_1 (PG_dcache_clean) flag is
>> set to the target page flag if execution permission is given. The logic
>> exits since commit 4f04d8f00545 ("arm64: MMU definitions"). The page
>> flag is kept when the page is free'd to buddy's free area list. However,
>> it will trigger page checking failure when it's pulled from the buddy's
>> free area list, as the following warning messages indicate.
>>
>>    BUG: Bad page state in process memhog  pfn:08000
>>    page:0000000015c0a628 refcount:0 mapcount:0 \
>>         mapping:0000000000000000 index:0x1 pfn:0x8000
>>    flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
>>    raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
>>    raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>>    page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
>>
>> This fixes the issue by clearing PG_arch_1 through flush_dcache_page()
>> after set_xxx_at() is called. For architectures other than ARM64, the
>> unexpected overhead of cache flushing is acceptable.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> 
> Maybe a Fixes: tag would be good to have

Agreed.

Fixes: a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advanced arch page table helpers")

> 
> And would it be possible to have this fix as first patch of the series so that it can be applied to stable without applying the whole series ?
Changing the allocation scheme does solve another problem (using non-owned pages)
but is achieved via the entire series applied. But this particular patch could be
moved to the beginning without much problem.
