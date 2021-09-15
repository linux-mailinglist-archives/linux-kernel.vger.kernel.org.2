Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5540BE73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhIODvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhIODvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:51:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68A3761211;
        Wed, 15 Sep 2021 03:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631677802;
        bh=ehBnRriQ/9bYDl2cldEheYmnNbHXE8FmT0zYlMMkxj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=npz36+ING3M584KM4OWfeBT3W5anGIE8wDXk0eEyia6Jrk1iusXcHvfRigsNoI9Bo
         YDzySz87GkViL2SWP6/pqDfaGYTKMumsdtTYyRDoe2/duDJR/zoGaFLk7E7ahLX+VJ
         9QpXhSYa0xSrq0tQ2bbOs5jPTDJGTOyYsnsx836E=
Date:   Tue, 14 Sep 2021 20:50:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     yaozhenguo <yaozhenguo1@gmail.com>
Cc:     mike.kravetz@oracle.com, corbet@lwn.net, yaozhenguo@jd.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
Message-Id: <20210914205001.7ccc7ef3dd76a9ec551b370e@linux-foundation.org>
In-Reply-To: <20210909141655.87821-1-yaozhenguo1@gmail.com>
References: <20210909141655.87821-1-yaozhenguo1@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Sep 2021 22:16:55 +0800 yaozhenguo <yaozhenguo1@gmail.com> wrote:

> We can specify the number of hugepages to allocate at boot. But the
> hugepages is balanced in all nodes at present. In some scenarios,
> we only need hugepages in one node. For example: DPDK needs hugepages
> which are in the same node as NIC. if DPDK needs four hugepages of 1G
> size in node1 and system has 16 numa nodes. We must reserve 64 hugepages
> in kernel cmdline. But, only four hugepages are used. The others should
> be free after boot. If the system memory is low(for example: 64G), it will
> be an impossible task. So, Extending hugepages parameter to support
> specifying hugepages at a specific node.
> For example add following parameter:
> 
> hugepagesz=1G hugepages=0:1,1:3
> 
> It will allocate 1 hugepage in node0 and 3 hugepages in node1.
> 
> ...
>
> @@ -2842,10 +2843,75 @@ static void __init gather_bootmem_prealloc(void)
>  	}
>  }
>  
> +static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
> +{
> +	unsigned long i;
> +	char buf[32];
> +
> +	for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
> +		if (hstate_is_gigantic(h)) {
> +			struct huge_bootmem_page *m;
> +			void *addr;
> +
> +			addr = memblock_alloc_try_nid_raw(
> +					huge_page_size(h), huge_page_size(h),
> +					0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +			if (!addr)
> +				break;
> +			m = addr;
> +			BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));

We try very hard to avoid adding BUG calls.  Is there any way in which
this code can emit a WARNing then permit the kernel to keep operating?

> +			/*
> +			 * Put them into a private list first because mem_map
> +			 * is not up yet
> +			 */
> +			INIT_LIST_HEAD(&m->list);
> +			list_add(&m->list, &huge_boot_pages);
> +			m->hstate = h;
> +		} else {
> +			struct page *page;
> +
> +			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> +
> +			page = alloc_fresh_huge_page(h, gfp_mask, nid,
> +					&node_states[N_MEMORY], NULL);
> +			if (!page)
> +				break;
> +			put_page(page); /* free it into the hugepage allocator */
> +		}
> +		cond_resched();
> +	}
> +	if (i == h->max_huge_pages_node[nid])
> +		return;
> +
> +	string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> +	pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
> +		h->max_huge_pages_node[nid], buf, nid, i);
> +	h->max_huge_pages_node[nid] = i;
> +	h->max_huge_pages -= (h->max_huge_pages_node[nid] - i);
> +}
> +

