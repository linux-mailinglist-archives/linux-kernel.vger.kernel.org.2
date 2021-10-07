Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811CE4250AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbhJGKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:09:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50058 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhJGKJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:09:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E6592009A;
        Thu,  7 Oct 2021 10:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633601260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhXmwiClqquGTK25CqOIxuXctjMt4P7yDODkMvE+qbQ=;
        b=EilwoYGK8jqraM2chQ2+Jo+4YfT28UiyCYePpJmuR+QMfCw/i4vPgGYF8A+DwJUr9UIEeQ
        2y6tbwMFFp8xBWq5HGVtVNNoamKAH+hT0HYIuqgJO12XpTj0SoZ2Vkq5VgZdI3Ygc63f53
        c26BAb32F4fm0UV36+N1ivvV4a3E4ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633601260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhXmwiClqquGTK25CqOIxuXctjMt4P7yDODkMvE+qbQ=;
        b=LZmCUcwE7kD1tbb+EKuW2yM5wVoPpQW+G9xTgJj+3MT3lQ/qc99CjmuCTqkaH/hzgGDSxj
        TbVH3oO8IRRHv3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F51613B68;
        Thu,  7 Oct 2021 10:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5xWaEezGXmE6SAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Oct 2021 10:07:40 +0000
Message-ID: <0cfb2279-8cfa-6be9-d732-1fc6b1fb6dc1@suse.cz>
Date:   Thu, 7 Oct 2021 12:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: Compaction & folios
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     hannes@cmpxchg.org, willy@infradead.org, rientjes@google.com,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <YV4o9SxfYuLm1i4d@moria.home.lan>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YV4o9SxfYuLm1i4d@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/21 00:53, Kent Overstreet wrote:
> So I have some observations on memory compaction & hugepages.
> 
> Right now, the working assumption in MM is that compaction is hard and
> expensive, and right now it is - because most allocations are order 0, with a
> small subset being hugepage order allocations. This means any time we need a
> hugepage, compaction has to move a bunch of order 0 pages around, and memory
> reclaim is no help here - when we reclaim memory, it's coming back as fragmented
> order 0 pages.
> 
> But what if compaction wasn't such a difficult, expensive operation?
> 
> With folios, and then folios for anonymous pages, we won't see nearly so many
> order 0 allocations anymore - we'll see a spread of allocation sizes based on a
> mixture of application usage patterns - something much closer to a poisson
> distribution, vs. our current very bimodal distribution. And since we won't be
> fragmenting all our allocations up front, memory reclaim will be freeing
> allocations in this same distribution.

Unfortunately, the main problem with compaction is not the act of moving a
number of LRU pages, but rather the presence of unmovable pages (slab, page
tables and whatnot kernel allocations), where such a single page makes the
whole 2MB block unusable. So I don't expect this would help dramatically for
compaction, but the points added by Matthew would still apply.

> Which means that any time an order n allocation fails, it's likely that we'll
> still have order n-1 pages free - and of those free order n-1 pages, one will
> likely have a buddy that's moveable and hasn't been fragmented - meaning the
> common case is that compaction will have to move _one_ (higher order) page -
> we'll almost never be having to move a bunch of 4k pages.
> 
> Another way of thinking of this is that memory reclaim will be doing most of the
> work that compaction has to do now to allocate a high order page. Compaction
> will go from an expensive, somewhat unreliable operation to one that mostly just
> works - it's going to be _much_ less of a pain point.
> 
> It may turn out that allocating hugepages still doesn't work as reliably as we'd
> like - but folios are still a big help even when we can't allocate a 2MB page,
> because we'll be able to fall back to an order 6 or 7 or 8 allocation, which is
> something we can't do now. And, since multiple CPU vendors now support
> coalescing contiguous PTE entries in the TLB, this will still get us most of the
> performance benefits of using hugepages.
> 

