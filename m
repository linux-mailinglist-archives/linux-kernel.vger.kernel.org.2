Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918493AE1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 05:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFUDSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 23:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229901AbhFUDSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 23:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624245364;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2ArXRtPJQk6BlyRJnDmaMoLiN4BggSlTFGtO4czGec=;
        b=DSjqlKWhGaynEgp/Bv2rv6ToF3WL3YpOfy6rSSOnKb8Vo4aIGCITqEg4i3c0L1dABqL724
        1pJqsSYdjboxdetmX+khJ+XRYROCROcf3zlLsOdVxjFCkOgqIgq/uOgdl0qF8qet/IiRZo
        mpNDJA9eO/7XQFtSXVV9S17NbcWg/Po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-k9RcUUAnOGa-LzfWJ-xwQg-1; Sun, 20 Jun 2021 23:16:00 -0400
X-MC-Unique: k9RcUUAnOGa-LzfWJ-xwQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35F821084F57;
        Mon, 21 Jun 2021 03:15:59 +0000 (UTC)
Received: from [10.64.54.84] (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8396C5D703;
        Mon, 21 Jun 2021 03:15:53 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
To:     David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shan.gavin@gmail.com, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210601033319.100737-1-gshan@redhat.com>
 <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
 <0c0eb8c8-463d-d6f1-3cec-bbc0af0a229c@redhat.com>
 <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
 <CAKgT0Ue9SQ8=ju1m6ftKTb4Tai9EJ5NQhnB_uk-DzMc19-R4cQ@mail.gmail.com>
 <63c06446-3b10-762c-3a29-464854b74e08@redhat.com>
 <0cb302f1-7fb6-e47c-e138-b7a03f2b02e2@redhat.com>
 <33b441b2-f10d-a7fb-8163-df2afbf6527d@redhat.com>
 <9e553b30-ce18-df65-bd3c-c68eaa4d0d91@redhat.com>
 <3adbcad8-1016-cf48-4574-799de0bba6e4@redhat.com>
 <249e5814-e644-3d82-9b38-232928af4dbd@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <5ee628f8-772c-b1ed-557c-68d6a4a83415@redhat.com>
Date:   Mon, 21 Jun 2021 15:16:54 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <249e5814-e644-3d82-9b38-232928af4dbd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 10:07 PM, David Hildenbrand wrote:
>> Indeed. 512MB pageblocks are rare, especially on systems which have been
>> up and running for long time.
>>
>> The free page reporting starts from guest. Taking an extreme case: guest has
>> 512MB memory and it's backed by one THP on host. The free page reporting won't
>> work at all.
>>
>> Besides, it seems free page reporting isn't guranteed to work all the time.
>> For example, on system where we have 4KB base page size. Freeing individual
>> 4KB pages can't come up with a free 2MB pageblock due to fragmentation.
>> In this case, the free'd page won't be reported immediately, but might be
>> reported after swapping or compaction due to memory pressure. The free page
>> isn't reported immediately at least.
> 
> Exactly, it's a pure optimization that won't work, especially when guest memory is heavily fragmented. There has to be a balance between reclaiming free memory in the hypervisor, degrading VM performance, and overhead of the feature.
> 
> Further, there are no guarantees when a VM will reuse the memory again. In the worst case, all VMs that reported free pages reuse memory at the same time. In that case, one definitely needs sufficient backend memory in the hypervisor (-> swap) to not run out of memory, and performance will be degraded.
> 
> As MST once phrased it, if the feature has a higher overhead than swapping in the hypervisor, it's of little use.
> 

Thanks for the explanation and sorry again for late response, David. I took
last week as holiday and didn't work too much.

However, it's nice to have unused pages returned back to the host. These pages
can be used by other VMs or applications running on the host.

>>
>> David, how about taking your suggestion to have different threshold size only
>> for arm64 (64KB base page size). The threshold will be smaller than pageblock_order
>> for sure. There are two ways to do so and please let me know which is the preferred
>> way to go if you (and Alex) agree to do it.
>>
>> (a) Introduce CONFIG_PAGE_REPORTING_ORDER for individual archs to choose the
>>       value. The threshold falls back to pageblock_order if isn't configurated.
>> (b) Rename PAGE_REPORTING_MIN_ORDER to PAGE_REPORTING_ORDER. archs can decide
>>       its value. If it's not provided by arch, it falls back to pageblock_order.
>>
> 
> I wonder if we could further define it as a (module/cmdline) parameter and make it configurable when booting. The default could then be set based on CONFIG_PAGE_REPORTING_ORDER. CONFIG_PAGE_REPORTING_ORDER would default to pageblock_order (if easily possible) and could be special-cases to arm64 with 64k.
> 

The formal patches are posted for review. I used macro PAGE_REPORTING_ORDER
instead of CONFIG_PAGE_REPORTING_ORDER. The page reporting order (threshold)
is also exported as a module parameter, as you suggested.

>> By the way, I recently had some performance testing on different page sizes.
>> We get much more performance gain from 64KB (vs 4KB) page size in guest than
>> 512MB (vs 2MB) THP on host. It means the performance won't be affected too
>> much even the 512MB THP is splitted on arm64 host.
> 
> Yes, if one is even able to get 512MB THP populated in the hypervisor -- because once again, 512MB THP are just a bad fit for many workloads.
> 

Yeah, indeed :)

Thanks,
Gavin

