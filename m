Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863043EE1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhHQBA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232974AbhHQBAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:00:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD3DE60C40;
        Tue, 17 Aug 2021 00:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629161993;
        bh=BMmQf7bi0wjKmNsveoF8QSTkNCouxlQgj3rEDb7otAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pw2MeiZIAQ+w+x6P+jq8wZb8LyIcUMUPKfv+pcJ5KUJcdFhCT4XyLgtGMuCcUIcVe
         cLo6D8BLeWEN6bwOaMtj06L8qVA9Liv+0KrFPeTP9WsmtQZ4QM+A1/0cTvJtWdWEt9
         VMK8eJvtZsfX1XwcqKh+nxy/LfqfpmZ1tBTq6fwY=
Date:   Mon, 16 Aug 2021 17:59:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     yanghui <yanghui.def@bytedance.com>
Cc:     willy@infradead.org, songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/mempolicy: fix a race between offset_il_node and
 mpol_rebind_task
Message-Id: <20210816175952.3c0d1eee821cd2d9ed7c3879@linux-foundation.org>
In-Reply-To: <20210815061034.84309-1-yanghui.def@bytedance.com>
References: <20210815061034.84309-1-yanghui.def@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2021 14:10:34 +0800 yanghui <yanghui.def@bytedance.com> wrote:

> Servers happened below panic:
> Kernel version:5.4.56
> BUG: unable to handle page fault for address: 0000000000002c48
> RIP: 0010:__next_zones_zonelist+0x1d/0x40
> [264003.977696] RAX: 0000000000002c40 RBX: 0000000000100dca RCX: 0000000000000014
> [264003.977872] Call Trace:
> [264003.977888]  __alloc_pages_nodemask+0x277/0x310
> [264003.977908]  alloc_page_interleave+0x13/0x70
> [264003.977926]  handle_mm_fault+0xf99/0x1390
> [264003.977951]  __do_page_fault+0x288/0x500
> [264003.977979]  ? schedule+0x39/0xa0
> [264003.977994]  do_page_fault+0x30/0x110
> [264003.978010]  page_fault+0x3e/0x50
> 
> The reason of panic is that MAX_NUMNODES is passd in the third parameter
> in function __alloc_pages_nodemask(preferred_nid). So if to access
> zonelist->zoneref->zone_idx in __next_zones_zonelist the panic will happen.
> 
> In offset_il_node(), first_node() return nid from pol->v.nodes, after
> this other threads may changed pol->v.nodes before next_node().
> This race condition will let next_node return MAX_NUMNODES.So put
> pol->nodes in a local variable.
> 
> The race condition is between offset_il_node and cpuset_change_task_nodemask:
> CPU0:                                     CPU1:
> alloc_pages_vma()
>   interleave_nid(pol,)
>     offset_il_node(pol,)
>       first_node(pol->v.nodes)            cpuset_change_task_nodemask
>                       //nodes==0xc          mpol_rebind_task
>                                               mpol_rebind_policy
>                                                 mpol_rebind_nodemask(pol,nodes)
>                       //nodes==0x3
>       next_node(nid, pol->v.nodes)//return MAX_NUMNODES
> 
>
> ...
>
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1965,17 +1965,26 @@ unsigned int mempolicy_slab_node(void)
>   */
>  static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
>  {
> -	unsigned nnodes = nodes_weight(pol->nodes);
> -	unsigned target;
> +	nodemask_t nodemask = pol->nodes;

Ouch.  nodemask_t can be large - up to 128 bytes I think.  This looks
like an expensive thing to be adding to fast paths (alloc_pages_vma()).

Plus it consumes a lot of stack.

> +	unsigned int target, nnodes;
>  	int i;
>  	int nid;
> +	/*
> +	 * The barrier will stabilize the nodemask in a register or on
> +	 * the stack so that it will stop changing under the code.
> +	 *
> +	 * Between first_node() and next_node(), pol->nodes could be changed
> +	 * by other threads. So we put pol->nodes in a local stack.
> +	 */
> +	barrier();
>  
> +	nnodes = nodes_weight(nodemask);
>  	if (!nnodes)
>  		return numa_node_id();
>  	target = (unsigned int)n % nnodes;
> -	nid = first_node(pol->nodes);
> +	nid = first_node(nodemask);
>  	for (i = 0; i < target; i++)
> -		nid = next_node(nid, pol->nodes);
> +		nid = next_node(nid, nodemask);
>  	return nid;
>  }

The whole idea seems a bit hacky and fragile to be.  We're dealing with
a potentially stale copy of the nodemask, yes?

Ordinarily this is troublesome because there could be other problems
caused by working off stale data and a better fix would be to simply
avoid using stale data!

But I guess that if the worst case is that once in a billion times,
interleaving hands out a page which isn't on the intended node then we
can live with that.

And if this guess is correct and it is indeed the case that this is the
worst case, can we please spell all this out in the changelog.

