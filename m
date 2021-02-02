Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B48D30BA0C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhBBIgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:36:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229850AbhBBIgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612254917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NY/G36GtP697RjgpeOLFmdF2+6N5HezZacpHU3/OHU=;
        b=fNc5uvakWDZzN6fO5crkpZoRiPjshH3QHsntGsyG90z8iOXqF36ktz3oSsIgWULeUtkL/b
        dPzb6pN05kNIFADMEkde9w+/w9RmOHoO9cdJLYVglpa/28C6CltTTPMA7snqYdlkVbTJmp
        iwu23yILZmNR7UaRna/yFeZbVM0DvvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-lPodgu1jNaaMDod5g1K1VQ-1; Tue, 02 Feb 2021 03:35:15 -0500
X-MC-Unique: lPodgu1jNaaMDod5g1K1VQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A306B107ACE4;
        Tue,  2 Feb 2021 08:35:13 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A53A1975E;
        Tue,  2 Feb 2021 08:35:10 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210129064045.18471-1-osalvador@suse.de>
 <b9a2f80e-a90f-62bf-4197-66cdb315cb84@redhat.com>
 <20210202075243.GA7037@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v2] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <dd9dfa98-21df-70c8-d43d-e9a83889464c@redhat.com>
Date:   Tue, 2 Feb 2021 09:35:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210202075243.GA7037@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> IMHO, we should rip out that code here and enforce page alignment in
>> vmemmap_populate()/vmemmap_free().
>>
>> Am I missing something?
> 
> Thanks David for bringing this up, I must say I was not aware that this
> topic was ever discussed.

Yeah, last time I raised it was in

https://lkml.kernel.org/r/20200703013435.GA11340@L-31X9LVDL-1304.local

but I never got to clean it up myself.

> 
> Ok, I've been having a look into this.
> At first I was concerced because of a pure SPARSEMEM configuration, but I
> see that those allocations are done in a very diferent way so it does not
> bother us.
> 
> So we have the following enforcements during hotplug:
> 
> add_memory_resource
>   check_hotplug_memory_range : Checks range aligned to memory_block_size_bytes,
>                              : which means it must be section-size aligned
> 
> populate_section_memmap
>   __populate_section_memmap  : Checks range aligned to sub-section size
> 
> So, IIRC we have two cases during hotplug:
>   1) the ones that want memory blocks
>   2) the ones that do not want them (pmem stuff)
> 
> For #1, we always enforce section alignment in add_memory_resource, and for
> #2 we always make sure the range is at least sub-section aligned.
> 
> And the important stuff is that boot memory is no longer to be hot-removed
> (boot memory had some strange layout sometimes).

The vmemmap of boot mem sections is always fully populated, even with 
strange memory layouts (e.g., see comment in pfn_valid()). In addition, 
we can only offline+remove whole sections, so that should be fine.

> 
> So, given the above, I think it should be safe to drop that check in
> remote_pte_table.
> But do we really need to force page alignment in vmemmap_populate/vmemmap_free?
> vmemmap_populate should already receive a page-aligned chunk because
>   __populate_section_memmap made sure of that, and vmemmap_free() should be ok
> as we already filtered out at hot-adding stage.
> 
> Of course, this will hold as long as struct page size of multiple of 8.
> Should that change we might get trouble, but I do not think that can ever
> happened (tm).
> 
> But anyway, I am fine with placing a couple of checks in vmemmap_{populate,free}
> just to double check.
> 
> What do you think?

I'd just throw in 1 or 2 VM_BUG_ON() to self-document what we expect and 
that we thought about these conditions. It's then easy to identify the 
relevant commit where we explain the rationale.

I don't have a strong opinion, the other archs also don't seem to care 
about documenting/enforcing it.

-- 
Thanks,

David / dhildenb

