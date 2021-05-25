Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A99A390063
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhEYL4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:56:25 -0400
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:42627 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231770AbhEYL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:56:24 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id E8318FAC00
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:54:53 +0100 (IST)
Received: (qmail 30068 invoked from network); 25 May 2021 11:54:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2021 11:54:53 -0000
Date:   Tue, 25 May 2021 12:54:51 +0100
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
Subject: Re: [RFC 05/26] mm, slub: extract get_partial() from
 new_slab_objects()
Message-ID: <20210525115451.GO30378@techsingularity.net>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210524233946.20352-6-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:39:25AM +0200, Vlastimil Babka wrote:
> The later patches will need more fine grained control over individual actions
> in ___slab_alloc(), the only caller of new_slab_objects(), so this is a first
> preparatory step with no functional change.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> <SNIP>
> @@ -2748,6 +2743,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		goto redo;
>  	}
>  
> +	freelist = get_partial(s, gfpflags, node, c);
> +	if (freelist)
> +		goto check_new_page;
> +
>  	freelist = new_slab_objects(s, gfpflags, node, &c);
>  
>  	if (unlikely(!freelist)) {

It's a nit-pick, but why did you not simply do something like this
instead of the goto?

	freelist = get_partial(s, gfpflags, node, c);
	if (!freelist)
		freelist = new_slab_objects(s, gfpflags, node, &c);

	if (unlikely(!freelist))
		...

If nothing else, the label may be misleading because c->page may not
be new.

-- 
Mel Gorman
SUSE Labs
