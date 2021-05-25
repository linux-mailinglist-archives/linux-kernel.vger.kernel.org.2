Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0B338FEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEYKTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:19:19 -0400
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:50724 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229597AbhEYKTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:19:15 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id AE9E1C0BED
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:17:44 +0100 (IST)
Received: (qmail 1239 invoked from network); 25 May 2021 10:17:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2021 10:17:44 -0000
Date:   Tue, 25 May 2021 11:17:42 +0100
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
Subject: Re: [RFC 02/26] mm, slub: allocate private object map for
 validate_slab_cache()
Message-ID: <20210525101742.GK30378@techsingularity.net>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210524233946.20352-3-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:39:22AM +0200, Vlastimil Babka wrote:
> validate_slab_cache() is called either to handle a sysfs write, or from a
> self-test context. In both situations it's straightforward to preallocate a
> private object bitmap instead of grabbing the shared static one meant for
> critical sections, so let's do that.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>
> <SNIP>
>
> @@ -4685,10 +4685,17 @@ static long validate_slab_cache(struct kmem_cache *s)
>  	int node;
>  	unsigned long count = 0;
>  	struct kmem_cache_node *n;
> +	unsigned long *obj_map;
> +
> +	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
> +	if (!obj_map)
> +		return -ENOMEM;
>  


Most callers of validate_slab_cache don't care about the return value
except when the validate sysfs file is written. Should a simply
informational message be displayed for -ENOMEM in case a writer to
validate fails and it's not obvious it was because of an allocation
failure?

It's a fairly minor concern so whether you add a message or not

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
