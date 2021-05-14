Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C553380D78
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhENPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhENPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:41:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DFCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EVzFRPwFxU8PgEN+PfCkyMK0yWwYPBXb5phFBctJ+Xw=; b=OkGE8p8YLT8Wqjf07+d6qHyhwV
        zeA33Mhs9pZ5/nPcBYWJtE6PIaAe9qEoy8SivOE57kbOUVy7p0hrP9I2OUM4EU4bFev8rWCR4fsQ/
        ojwdGAef91qBJe78+6cIoqoYEx2VNLBnRv863xK2hYrFuKVpZRXA9NOs+oCvgq/x9b/XKcTAi3mwM
        Mm7uyOOpnDcJfZtYumUqPf/UezLJWo6GmDsal9SatMlyYImBgvS148gWwvq4hFWWFfUUgov9y+vr4
        t0vFDaMLJLxh65h1e7EOp70OYWxGWTJXLq5Da8n+NZJpodWNtn+vU4XiJgYC0OZRczncK+dWQWBYA
        A/vIaiQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhZuz-008Q3N-Ul; Fri, 14 May 2021 15:40:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64521300233;
        Fri, 14 May 2021 17:40:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CE452C15D217; Fri, 14 May 2021 17:40:01 +0200 (CEST)
Date:   Fri, 14 May 2021 17:40:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 26/94] Maple Tree: Add new data structure
Message-ID: <YJ6Z0X91NpuPTEre@hirez.programming.kicks-ass.net>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428153542.2814175-27-Liam.Howlett@Oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:36:02PM +0000, Liam Howlett wrote:
> +/*
> + * mas_set_alloc_req() - Set the requested number of allocations.
> + * @mas: the maple state
> + * @count: the number of allocations.
> + *
> + * If @mas->alloc has bit 1 set (0x1) or @mas->alloc is %NULL, then there are no
> + * nodes allocated and @mas->alloc should be set to count << 1 | 1.  If there is
> + * already nodes allocated, then @mas->alloc->request_count stores the request.
> + */
> +static inline void mas_set_alloc_req(struct ma_state *mas, unsigned long count)
> +{
> +	if (!mas->alloc || ((unsigned long)mas->alloc & 0x1)) {
> +		if (!count)
> +			mas->alloc = NULL;
> +		else
> +			mas->alloc = (struct maple_alloc *)(((count) << 1U) | 1U);
> +		return;
> +	}
> +
> +	mas->alloc->request_count = count;
> +}
> +
> +/*
> + * mas_alloc_req() - get the requested number of allocations.
> + * @mas: The maple state
> + *
> + * The alloc count is either stored directly in @mas, or in
> + * @mas->alloc->request_count if there is at least one node allocated.
> + *
> + * Return: The allocation request count.
> + */
> +static inline unsigned int mas_alloc_req(const struct ma_state *mas)
> +{
> +	if ((unsigned long)mas->alloc & 0x1)
> +		return (unsigned long)(mas->alloc) >> 1;
> +	else if (mas->alloc)
> +		return mas->alloc->request_count;
> +	return 0;
> +}


I'm confuse.. and the comments fail to eludicate *why* the code is the
way it is, they simply explain exactly what the code does, which I can
already tell from reading the code.

Why can't we have ->request_count unconditionally be the requested
count, and have ->alloc be NULL or not. Why do we play games with low
pointer bits here? AFAICT there's no actual benefit to doing so.

