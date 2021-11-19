Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4C456EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 13:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhKSMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 07:36:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40624 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhKSMgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:36:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 014CB1FD3B;
        Fri, 19 Nov 2021 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637325185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4eXQRQkyOnlkfqIjP+4InF8CkZnCxzQH+4oBGRF5bzQ=;
        b=Rj0Bb7aNc9Pq/SEl+lwV4pZ0xaw0YNXnDB8He3zLmNU/uVGsBdvudyeinMU5nS85cF1Z+4
        j6sydHcbBQiWua8myjFS7weVD8guJQlxemgIa32po//oxhMSYutsZwDLfrpTOEc5UeCTWl
        A9LRFyBxKr+Zc5EgfzvvwhM3VaJHzyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637325185;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4eXQRQkyOnlkfqIjP+4InF8CkZnCxzQH+4oBGRF5bzQ=;
        b=37Ndmb7me3fMnFCMahzCk8SVpCAyZepl+YuAvScQn2siBak0RgVSkgkQs5eYMHcvE3YEfp
        Z71c+vJs+cLXasAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB59D13B2A;
        Fri, 19 Nov 2021 12:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 04/sMICZl2F8SwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 19 Nov 2021 12:33:04 +0000
Message-ID: <3083463d-978b-fbe6-dadf-670d400ed437@suse.cz>
Date:   Fri, 19 Nov 2021 13:33:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 0/3] Use pageblock_order for cma and
 alloc_contig_range alignment.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org
References: <20211115193725.737539-1-zi.yan@sent.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211115193725.737539-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 20:37, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi David,
> 
> You suggested to make alloc_contig_range() deal with pageblock_order instead of
> MAX_ORDER - 1 and get rid of MAX_ORDER - 1 dependency in virtio_mem[1]. This
> patchset is my attempt to achieve that. Please take a look and let me know if
> I am doing it correctly or not.
> 
> From what my understanding, cma required alignment of
> max(MAX_ORDER - 1, pageblock_order), because when MIGRATE_CMA was introduced,
> __free_one_page() does not prevent merging two different pageblocks, when
> MAX_ORDER - 1 > pageblock_order. But current __free_one_page() implementation
> does prevent that.

But it does prevent that only for isolated pageblock, not CMA, and yout
patchset doesn't seem to expand that to CMA? Or am I missing something.


> It should be OK to just align cma to pageblock_order.
> alloc_contig_range() relies on MIGRATE_CMA to get free pages, so it can use
> pageblock_order as alignment too.
> 
> In terms of virtio_mem, if I understand correctly, it relies on
> alloc_contig_range() to obtain contiguous free pages and offlines them to reduce
> guest memory size. As the result of alloc_contig_range() alignment change,
> virtio_mem should be able to just align PFNs to pageblock_order.
> 
> Thanks.
> 
> 
> [1] https://lore.kernel.org/linux-mm/28b57903-fae6-47ac-7e1b-a1dd41421349@redhat.com/
> 
> Zi Yan (3):
>   mm: cma: alloc_contig_range: use pageblock_order as the single
>     alignment.
>   drivers: virtio_mem: use pageblock size as the minimum virtio_mem
>     size.
>   arch: powerpc: adjust fadump alignment to be pageblock aligned.
> 
>  arch/powerpc/include/asm/fadump-internal.h |  4 +---
>  drivers/virtio/virtio_mem.c                |  6 ++----
>  include/linux/mmzone.h                     |  5 +----
>  kernel/dma/contiguous.c                    |  2 +-
>  mm/cma.c                                   |  6 ++----
>  mm/page_alloc.c                            | 12 +++++-------
>  6 files changed, 12 insertions(+), 23 deletions(-)
> 

