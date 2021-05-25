Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24030390096
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhEYML3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:11:29 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:48320 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231897AbhEYML1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:11:27 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 401E0CACC0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 13:09:57 +0100 (IST)
Received: (qmail 19293 invoked from network); 25 May 2021 12:09:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2021 12:09:56 -0000
Date:   Tue, 25 May 2021 13:09:54 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC 08/26] mm, slub: restructure new page checks in
 ___slab_alloc()
Message-ID: <20210525120954.GQ30378@techsingularity.net>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-9-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210524233946.20352-9-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:39:28AM +0200, Vlastimil Babka wrote:
> When we allocate slab object from a newly acquired page (from node's partial
> list or page allocator), we usually also retain the page as a new percpu slab.
> There are two exceptions - when pfmemalloc status of the page doesn't match our
> gfp flags, or when the cache has debugging enabled.
> 
> The current code for these decisions is not easy to follow, so restructure it
> and add comments. No functional change.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>
> <SNIP>
>
> +	if (unlikely(!pfmemalloc_match(page, gfpflags)))
> +		/*
> +		 * For !pfmemalloc_match() case we don't load freelist so that
> +		 * we don't make further mismatched allocations easier.
> +		 */
> +		goto return_single;
> +
> +	goto load_freelist;
> +
> +return_single:
>  

This looked odd to me but I see other stuff goes between the two goto's
later in the series so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
