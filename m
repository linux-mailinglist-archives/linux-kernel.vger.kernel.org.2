Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD4D3D99D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 02:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhG2AAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 20:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232355AbhG2AAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627516818;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wwCPQjG58j7oWkSwdoN8w00sp4R5au56rr1fRjraU+E=;
        b=Ir1/JqnrygSGmG9YfLd9VCNNd6X5hY/jg7z8FVavUB5ZIkQ4m8eGvEB2RuW7gFq+Q/6I3Y
        L5IZ1bGYddSN3g4EHrwRkT0z3HpiuI0v473T8nZvVys+m8ZpKWjHg7I85egObCJlaBKa8A
        BZyWDYfspZvY8PdVPBSwW4ZkzV1IUXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-8NvSSR2xNledKlNqiAXzjg-1; Wed, 28 Jul 2021 20:00:17 -0400
X-MC-Unique: 8NvSSR2xNledKlNqiAXzjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AA0F800050;
        Thu, 29 Jul 2021 00:00:15 +0000 (UTC)
Received: from [10.64.54.184] (vpn2-54-184.bne.redhat.com [10.64.54.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1E5319D9D;
        Thu, 29 Jul 2021 00:00:11 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 12/12] mm/debug_vm_pgtable: Fix corrupted page flag
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     shan.gavin@gmail.com, chuhu@redhat.com, akpm@linux-foundation.org,
        will@kernel.org, catalin.marinas@arm.com, cai@lca.pw,
        aneesh.kumar@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-13-gshan@redhat.com>
 <20210728095326.Horde.k1npSPaQKh2i7W3XoBsdiQ3@messagerie.c-s.fr>
 <58a1eaa9-ba63-403b-1f4b-c22f23a3a0d3@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <cfa714eb-8574-8cfb-8d5f-719c9a6b0a30@redhat.com>
Date:   Thu, 29 Jul 2021 10:00:25 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <58a1eaa9-ba63-403b-1f4b-c22f23a3a0d3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe and Anshuman,

On 7/28/21 8:05 PM, Anshuman Khandual wrote:
> On 7/28/21 1:23 PM, Christophe Leroy wrote:
>> Gavin Shan <gshan@redhat.com> a écrit :
>>> In page table entry modifying tests, set_xxx_at() are used to populate
>>> the page table entries. On ARM64, PG_arch_1 (PG_dcache_clean) flag is
>>> set to the target page flag if execution permission is given. The logic
>>> exits since commit 4f04d8f00545 ("arm64: MMU definitions"). The page
>>> flag is kept when the page is free'd to buddy's free area list. However,
>>> it will trigger page checking failure when it's pulled from the buddy's
>>> free area list, as the following warning messages indicate.
>>>
>>>     BUG: Bad page state in process memhog  pfn:08000
>>>     page:0000000015c0a628 refcount:0 mapcount:0 \
>>>          mapping:0000000000000000 index:0x1 pfn:0x8000
>>>     flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
>>>     raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
>>>     raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>>>     page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
>>>
>>> This fixes the issue by clearing PG_arch_1 through flush_dcache_page()
>>> after set_xxx_at() is called. For architectures other than ARM64, the
>>> unexpected overhead of cache flushing is acceptable.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>
>> Maybe a Fixes: tag would be good to have
> 
> Agreed.
> 
> Fixes: a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advanced arch page table helpers")
> 

Yep, I will add the tag in v5.

>>
>> And would it be possible to have this fix as first patch of the series so that it can be applied to stable without applying the whole series ?
> Changing the allocation scheme does solve another problem (using non-owned pages)
> but is achieved via the entire series applied. But this particular patch could be
> moved to the beginning without much problem.
> 

I prefer to keep current layout as explained before. Firstly, all
code changes included in this series are affecting only one source
file. It's hard to apply the whole series to stable kernel. I also
need apply this series to our downstream kernel once it hits upstream.
Secondly, applying PATCH[v4 12/12] can't resolve all issues we have.
It means we need to apply the whole series to resolve all issues.
Lastly, moving PATCH[v4 12/12] to PATCH[v4 01/12] will introduce
unnecessary code for subsequent patches. I don't think it's worthy
to do.

So lets keep current layout we have.

Thanks,
Gavin

