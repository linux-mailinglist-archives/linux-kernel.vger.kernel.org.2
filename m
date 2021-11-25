Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DA245D3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 04:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhKYDhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 22:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhKYDfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 22:35:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E925FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 19:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sarg9j5uWpI80F+KYVVMFI4IuQs+6DnBhpJFGqNmqjE=; b=UyglqFLIIELXdNN5G/Cc95S9CL
        Pwp3FTeuSvheJxG93898eO3cgBX+B/aClH/M+VHmFsFMcYwu3lVb5LE2BhaUdRCacWY8Vm5qo7e6u
        +zalP0PUiLwddUZqpTDi7Tgc3nO9qRep/zSE2gu8coVo8AiA5OyxS0bFuXlC6IyC2hXsyBJTActvw
        +omFB3LvlO+cuyc2biu8Z0AUADJXq8PWslJy3x+GG01XFt+rraUJXRs1EY0geT49+EMMSY8B7OxVp
        fHY85twGQhyP13Q3I10tGt9GWc57FlNT7nxk2AWENO1h2FgeVqPTNCwfpzivR4ihAfZMs9NoJIBaG
        Kgmz9GCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq5Ut-004Zro-FL; Thu, 25 Nov 2021 03:32:31 +0000
Date:   Thu, 25 Nov 2021 03:32:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgel.zte@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mm: Use BUG_ON instead of if condition followed by BUG
Message-ID: <YZ8Dz/85n1Dogy87@casper.infradead.org>
References: <20211124030849.34998-1-chi.minghao@zte.com.cn>
 <YZ483gwnwTysPt0G@casper.infradead.org>
 <20211124142751.e48cdcc3aea9e0ef899f4347@linux-foundation.org>
 <348f3a1f-c7d3-c21f-419d-7acd2e5290b6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <348f3a1f-c7d3-c21f-419d-7acd2e5290b6@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 02:45:59PM -0800, John Hubbard wrote:
> @@ -2201,13 +2201,12 @@ static int __ref try_remove_memory(u64 start, u64 size)
> */
> void __remove_memory(u64 start, u64 size)
> {
> -
> +       int ret = try_remove_memory(start, size);
> /*
> * trigger BUG() if some memory is not offlined prior to calling this
> * function
> */
> -       if (try_remove_memory(start, size))
> -               BUG();
> +       BUG_ON(ret);
> }

I'd rather leave it the way it is.  I don't see why the version you
propose is better.

> ...and by the way, while going to type that, I immediately stumbled upon
> another pre-existing case of this sort of thing, in try_remove_memory(),
> which does this:
> 
> static int __ref try_remove_memory(u64 start, u64 size)
> {
> 	struct vmem_altmap mhp_altmap = {};
> 	struct vmem_altmap *altmap = NULL;
> 	unsigned long nr_vmemmap_pages;
> 	int rc = 0, nid = NUMA_NO_NODE;
> 
> 	BUG_ON(check_hotplug_memory_range(start, size));

That needs to be fixed.
