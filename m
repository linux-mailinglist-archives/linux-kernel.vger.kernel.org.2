Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2213E3E2EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbhHFQye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:54:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48384 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbhHFQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:54:32 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B3F521C8B;
        Fri,  6 Aug 2021 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628268855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wxZVzpP79pSH135ygMJb54Rw1U8W8NfIxU10/tpqYFs=;
        b=WLBGcvjbDu4HJ9eRQHe5ns1sEQFZ/KN3d3dSf9RQl1Lc2fby2/Ww15YE2UC2hvK3Pp68fz
        bG299u1jDcpzRarGAaYneYrzOVYFAPJJVjZ4iz+BHKCBaie6azTmIlMlsPxHdXakastYSr
        2zZ6V5mV377MosihLd5G1N1/SrsSn40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628268855;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wxZVzpP79pSH135ygMJb54Rw1U8W8NfIxU10/tpqYFs=;
        b=joFbrKvB5WLHlKh/vmwwqkVuX/9S4evCFoy6WEv+7ztAHBU2qzwtInX5t/3DYZloWSOqsd
        yFj7QoDUN3OpnXCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3D97313C0E;
        Fri,  6 Aug 2021 16:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UuJ8DTdpDWH3RgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 06 Aug 2021 16:54:15 +0000
To:     David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <40982106-0eee-4e62-7ce0-c4787b0afac4@suse.cz>
 <72b317e5-c78a-f0bc-fe69-f82261ec252e@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time
 parameter.
Message-ID: <3417eb98-36c8-5459-c83e-52f90e42a146@suse.cz>
Date:   Fri, 6 Aug 2021 18:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <72b317e5-c78a-f0bc-fe69-f82261ec252e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 6:16 PM, David Hildenbrand wrote:
> On 06.08.21 17:36, Vlastimil Babka wrote:
>> On 8/5/21 9:02 PM, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>
>>> Patch 3 restores the pfn_valid_within() check when buddy allocator can merge
>>> pages across memory sections. The check was removed when ARM64 gets rid of holes
>>> in zones, but holes can appear in zones again after this patchset.
>>
>> To me that's most unwelcome resurrection. I kinda missed it was going away and
>> now I can't even rejoice? I assume the systems that will be bumping max_order
>> have a lot of memory. Are they going to have many holes? What if we just
>> sacrificed the memory that would have a hole and don't add it to buddy at all?
> 
> I think the old implementation was just horrible and the description we have
> here still suffers from that old crap: "but holes can appear in zones again".
> No, it's not related to holes in zones at all. We can have MAX_ORDER -1 pages
> that are partially a hole.
> 
> And to be precise, "hole" here means "there is no memmap" and not "there is a
> hole but it has a valid memmap".

Yes.

> But IIRC, we now have under SPARSEMEM always a complete memmap for a complete
> memory sections (when talking about system RAM, ZONE_DEVICE is different but we
> don't really care for now I think).
> 
> So instead of introducing what we had before, I think we should look into
> something that doesn't confuse each person that stumbles over it out there. What
> does pfn_valid_within() even mean in the new context? pfn_valid() is most
> probably no longer what we really want, as we're dealing with multiple sections
> that might be online or offline; in the old world, this was different, as a
> MAX_ORDER -1 page was completely contained in a memory section that was either
> online or offline.
> 
> I'd imagine something that expresses something different in the context of
> sparsemem:
> 
> "Some page orders, such as MAX_ORDER -1, might span multiple memory sections.
> Each memory section has a completely valid memmap if online. Memory sections
> might either be completely online or completely offline. pfn_to_online_page()
> might succeed on one part of a MAX_ORDER - 1 page, but not on another part. But
> it will certainly be consistent within one memory section."
> 
> Further, as we know that MAX_ORDER -1 and memory sections are a power of two, we
> can actually do a binary search to identify boundaries, instead of having to
> check each and every page in the range.
> 
> Is what I describe the actual reason why we introduce pfn_valid_within() ? (and
> might better introduce something new, with a better fitting name?)

What I don't like is mainly the re-addition of pfn_valid_within() (or whatever
we'd call it) into __free_one_page() for performance reasons, and also to
various pfn scanners (compaction) for performance and "I must not forget to
check this, or do I?" confusion reasons. It would be really great if we could
keep a guarantee that memmap exists for MAX_ORDER blocks. I see two ways to
achieve that:

1. we create memmap for MAX_ORDER blocks, pages in sections not online are
marked as reserved or some other state that allows us to do checks such as "is
there a buddy? no" without accessing a missing memmap
2. smaller blocks than MAX_ORDER are not released to buddy allocator

I think 1 would be more work, but less wasteful in the end?
