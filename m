Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B63FB83E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhH3O1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237211AbhH3O1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:27:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018DEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hAzEvoe8QavvyMY1614AsLbQz9LG+GuYVMMP3swKQBQ=; b=OsbZFW16L7Anah7yvA9S/TRG4l
        ZE4sQbE4o0XlrwQfrxDWwfDXlca0r/eK54oQ0aKExFtKo1UeE7DHqxND+Gaz6qiN24vuyNvVE6R49
        XLE/VfbhRMWIFMPhapJ8HJJhfIgwH1a6ECfOWQx/bomIGJ1U0o3ZkUQ8+ed6wQ+mpks+D0CJlL0aK
        l3q5TI/ZJ04f3HFrHLhD+Dzr0513uvGFUwwURGebPx3OX6xOcWwFusK7Bsb1tmjBH0r5aXomdBQFz
        Nt8xK6NxdjRnpBA9y7LRP7USgXBdnxFSTxiSfTqycGTrQvVfpN5bPx42ef4N6hRCjXCOaqrJWwvRT
        39eN9IJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKiCs-000E4Q-HJ; Mon, 30 Aug 2021 14:24:30 +0000
Date:   Mon, 30 Aug 2021 15:24:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sfr@canb.auug.org.au,
        peterz@infradead.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mm/page_alloc.c: avoid allocating highmem pages via
 alloc_pages_exact_nid()
Message-ID: <YSzqDt/13YbOAyo4@casper.infradead.org>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-7-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830141051.64090-7-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:10:51PM +0800, Miaohe Lin wrote:
> Don't use with __GFP_HIGHMEM because page_address() cannot represent
> highmem pages without kmap(). Newly allocated pages would leak as
> page_address() will return NULL for highmem pages here. But It works
> now because the only caller does not specify __GFP_HIGHMEM now.

This is a misunderstanding of how alloc_pages_exact() /
alloc_pages_exact_nid() work.  You simply can't call them with
GFP_HIGHMEM.

If you really must change anything here,
s/__GFP_COMP/(__GFP_COMP|__GFP_HIGHMEM)/g throughout both
alloc_pages_exact() and alloc_pages_exact_nid().
