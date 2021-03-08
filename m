Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876EF331902
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhCHVDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCHVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:02:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E550DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 13:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C0RDcISmL6coxbn097zV9gfcDqq0luPUdtiKEigF4hQ=; b=N2VsIT+wdPNzR/tbA29Er6XDgl
        Q+jIPHVEHrMW+PZLmIr0LhJ/vclfPxgkoJ0nX1NkCHkRpRr3L2oInFOKkLyAZ6CkITFcnx+qiZT6p
        DE6c3AptaPEv9T0PU8yx/ci3Uxm7CqUFalaKcmZVRQGF1IM9Lep0v4OPr0b/I47UmwRttDuFo10Iy
        RUSpXaLLQhCTKOHAR9XPBQc3jMhWuor+3Cxo/sStzTOFi11I2dXOS2XRpQ1I9onVixONeXEwsvoN6
        A0S98AKgeY/kEMkrvrRqiObRAM4LjAEEt1tDe2yOKkjY8r1dTaOTOr4Zqw20UKbPzxRN2uoeKldOz
        xMvtwT+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJN1F-00GGAq-Gz; Mon, 08 Mar 2021 21:02:30 +0000
Date:   Mon, 8 Mar 2021 21:02:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        hughd@google.com, kirill.shutemov@linux.intel.com,
        npiggin@gmail.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
        guohanjun@huawei.com, dingtianhong@huawei.com,
        chenweilong@huawei.com, rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <20210308210225.GF3479805@casper.infradead.org>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304074053.65527-3-zhouguanghui1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:40:53AM +0000, Zhou Guanghui wrote:
> As described in the split_page function comment, for the non-compound
> high order page, the sub-pages must be freed individually. If the
> memcg of the fisrt page is valid, the tail pages cannot be uncharged
> when be freed.
> 
> For example, when alloc_pages_exact is used to allocate 1MB continuous
> physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> set). When make_alloc_exact free the unused 1MB and free_pages_exact
> free the applied 1MB, actually, only 4KB(one page) is uncharged.
> 
> Therefore, the memcg of the tail page needs to be set when split page.

There's another place we need to do this to ...

+++ b/mm/page_alloc.c
@@ -5081,9 +5081,15 @@ void __free_pages(struct page *page, unsigned int order)
 {
        if (put_page_testzero(page))
                free_the_page(page, order);
-       else if (!PageHead(page))
-               while (order-- > 0)
-                       free_the_page(page + (1 << order), order);
+       else if (!PageHead(page)) {
+               while (order-- > 0) {
+                       struct page *tail = page + (1 << order);
+#ifdef CONFIG_MEMCG
+                       tail->memcg_data = page->memcg_data;
+#endif
+                       free_the_page(tail, order);
+               }
+       }
 }
 EXPORT_SYMBOL(__free_pages);
 

I wonder if we shouldn't initialise memcg_data on all subsequent pages
of non-compound allocations instead?  Because I'm not sure this is the
only place that needs to be fixed.
