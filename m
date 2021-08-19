Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329743F1A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhHSNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:10:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54878 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhHSNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:10:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A268022090;
        Thu, 19 Aug 2021 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629378621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnN4NhsbsVljPz5pPHh0UMyKIk5EJXTM21pZJrmMzAg=;
        b=gLobaIG3v5Id2jNch2V9/1HWJfZAtDcVMqE69s1NYFxSL1DswaplMPUQyec3p5WJGdofpA
        45C1WSiUOHTcF1e6OpPCeQtJSsbgM1NBM/bzCvNiYDlLOLyle4K9yoIqK89rbEDuFlwdnO
        jEVS2KqCCV83//GZul6no09S5753g2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629378621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnN4NhsbsVljPz5pPHh0UMyKIk5EJXTM21pZJrmMzAg=;
        b=fj+2GPTPWBDhzN9+yZLMaqYLwXe6TlKd1Aq4nzKIVEF5r7z4iImYqgb0tDczfiyCZDbvrF
        HXD6Z3i26fgx4GCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0247813AC4;
        Thu, 19 Aug 2021 13:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yP5mODxYHmHgagAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 19 Aug 2021 13:10:20 +0000
Subject: Re: [PATCH] mm/page_alloc: don't corrupt pcppage_migratetype
To:     Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20210811182917.2607994-1-opendmb@gmail.com>
 <e9393682-5429-448a-d151-a3ee05216499@suse.cz>
 <b5020966-c7dd-54b2-9e6a-e1d21a23d267@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a4a1344d-8b67-cc7f-2b28-6d9c2fd2c62d@suse.cz>
Date:   Thu, 19 Aug 2021 15:09:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b5020966-c7dd-54b2-9e6a-e1d21a23d267@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 2:21 AM, Doug Berger wrote:
> On 8/12/2021 1:17 AM, Vlastimil Babka wrote:
>> On 8/11/21 8:29 PM, Doug Berger wrote:
>>> When placing pages on a pcp list, migratetype values over
>>> MIGRATE_PCPTYPES get added to the MIGRATE_MOVABLE pcp list.
>>>
>>> However, the actual migratetype is preserved in the page and
>>> should not be changed to MIGRATE_MOVABLE or the page may end
>>> up on the wrong free_list.
>>
>> Nice, how did you find out? Were there any user-visible effects? (Hint: which?
>> the changelog should say that so that the severity of the bug can be judged).
>> Otherwise I agree the bug is there and patch is fixing it. Thanks.
> 
> I did not observe the bug "in the wild", but rather noticed it while
> reviewing the current CMA implementation. I would imagine in the worst
> case that CMA memory could leak onto MIGRATE_MOVABLE free_lists and get
> "stolen" through fallback for MIGRATE_UNMOVABLE allocations effectively
> breaking CMA.

Right, thanks.

> For full disclosure I should take this opportunity to say that I am
> investigating ways to improve the CMA/Movable memory implementations
> somewhat in line with what Joonsoo Kim has been trying, which is why I
> observed this bug.
> 
> However, I largely agree with the proposal Mel Gorman made in his
> comments on:
> https://lkml.org/lkml/2016/4/28/244
> 
> I can appreciate that zones may provide a convenient way of grouping
> memory with common attributes, but it is a bastardization of the
> original intention of zones. I would prefer a mechanism for designating
> blocks of memory as "sticky" movable such that they can only be used to
> satisfy movable memory requests and not be converted to other
> migratetypes. I've wrestled with the terminology and currently favor
> Designated Movable Blocks (as opposed to "sticky") because these are
> blocks of memory that have the movable attribute by designation rather
> than by default or accident.
> 
> While CMA blocks should be a subset of Designated Movable Blocks since
> they have the same migration properties, it may be desirable/necessary
> to maintain a distinction to accommodate competing allocation
> objectives. Specifically, Designated Movable Blocks used by CMA to
> satisfy the needs of drivers will likely want the page allocator to be
> less aggressive than users of Memory Hot-plug or kernelcore= Designated
> Movable Blocks. Perhaps a round-robin scheme with MIGRATE_MOVABLE can
> satisfy all users, but I'm not too optimistic.

I was, on the other hand, in favor Joonsoo's zone based solution, as
there's always problems with these designated pageblocks and watermarks.
It's also described in the thread you linked above. See
__zone_watermark_unusable_free() how it has to subtract
NR_FREE_CMA_PAGES for non-movable allocations. So you need to track
NR_FREE_CMA_PAGES which is rather fragile, and then reclaim target
depends on whether your goal is movable or unmovable allocation. Either
it's movable and you might end up in free memory only in those
designated-movable (today, MIGRATE_CMA) blocks, and unmovable allocation
has to direct reclaim and hope the reclaimed LRU pages will be in the
"normal" pageblocks, or you make sure that there's enough free pages in
normal pageblocks, and end up with lower memory utilization. A separate
zone solves this problem.

> I don't know if Mel has changed his opinions on this matter, but any
> suggestions and encouragement are appreciated.
> 
> Thanks,
>     Doug
