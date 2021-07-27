Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993A63D7C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhG0RbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0RbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:31:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CA1C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/5u/kL2/B/88RazFOk7B7gT7fQ27YXJaLficWp9tFRI=; b=Hjg1TmZsbkN99YT4XrirMDJZie
        rtGlKFshaHEmcn4QefRePBIAVjUnHmU5WBGSUDqvwKQD2kBtLwkyS2UIPh8LjOv28Z3iC1V+FWf/m
        c6NbPv/sBQ11DWVv98i/ZySUrDvupkI2btcB3x60SaNT5q3CfSGaoVgY8pNqeZXotnAZrMzYuR8tc
        1jrmV4GZ3hyqDl4J5071b/Z1qFv3MT/TepEuuWsWytdq73QlqnpHXm/Kv70MXNQkBfYzb5ys/QC/H
        LK8X+ndEWMXMQFP77qhJKok1s94ZFuVQg6icJyd0u/M65RZFqUgzsDnHz70OwGEfAFyoaKQIhEt5x
        ztkQ/uWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8QuS-00FF5H-Ri; Tue, 27 Jul 2021 17:30:36 +0000
Date:   Tue, 27 Jul 2021 18:30:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        weiyongjun1@huawei.com
Subject: Re: [PATCH] mm/vmalloc: add missing __GFP_HIGHMEM flag for vmalloc
Message-ID: <YQBCtHv1qD4Pinw/@casper.infradead.org>
References: <20210726032333.3404164-1-chenwandun@huawei.com>
 <YP4rM7qtSet+H+nG@casper.infradead.org>
 <f064b046-8831-2aa9-2234-63e867e28dc1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f064b046-8831-2aa9-2234-63e867e28dc1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:05:44PM +0800, Chen Wandun wrote:
> 在 2021/7/26 11:25, Matthew Wilcox 写道:
> > On Mon, Jul 26, 2021 at 11:23:33AM +0800, Chen Wandun wrote:
> > > struct page array can also be allocated in highmem during vmalloc,
> > > that will ease the low memory stress in 32bit system.
> > Huh?  Where does it get kmapped in order to access it?

(i misread your patch, apologies)

> The struct page array contain numbers of pointer of struct page, it is used to save
> 
> pages that allocated for vmalloc mapping in vmap_pages_range, it does't need to kmap.
> 
> 
> The main idea of this patch is come from:
> 
> https://lore.kernel.org/lkml/20170307141020.29107-1-mhocko@kernel.org/

you've misunderstood that patch.  think about it:

static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
                                 pgprot_t prot, unsigned int page_shift,
                                 int node)
{
	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
(now nested_gfp has neither DMA nor DMA32 set)

        gfp_mask |= __GFP_NOWARN;
        if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
                gfp_mask |= __GFP_HIGHMEM;
(we set HIGHMEM if DMA and DMA32 are both not set)

                area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
                                        area->caller);
(we don't need to set HIGHMEM here because it will be set for us in
the second call to __vmalloc_area_node)
