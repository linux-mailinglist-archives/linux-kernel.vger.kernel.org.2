Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0930410E21
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 03:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhITBLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 21:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhITBLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 21:11:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DAAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 18:09:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n2so7351205plk.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 18:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pto4r+NbIB2rnclkYpaJHKBf9z4eQ68+/d/Hn5CuMBM=;
        b=EDS4Ktlpjn0khBpFQWZa/rcf7pzIIKRv/QRTX3LAYGpLHEy8BWTmL1WUiB+dBDo7kH
         6A5zpQrik3Nz5IcjaeL2UT+7MdFTGWC3WDFIfhrz6fhc8Isb8W189/CZEI4QzwIG76ya
         YDYVx+WP5io3uGzICcpVHnaajVvoblOuH4FifrGsdX2IrfS62v5tBw99nhJZJ19qUw3o
         d+FZGjJMvW+PmeeyagDA9+FzudvBmiwRlP/TDL2xU4Feu3pjRf1bMHqmmwDWeMyHS6or
         fQaAvkCi6642D1U84Ert+T6rmhqAQPpN1sHC0X/IL2dMiNPzr4y8k2eMImQCheacRwTU
         pZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pto4r+NbIB2rnclkYpaJHKBf9z4eQ68+/d/Hn5CuMBM=;
        b=aNI4WcO+IuXKBxfgYE3SNXA3ugs4ccK2dMQP3nAbp9iKWRFRobqRA6Tf2EpK/CDsMq
         8ewYbM6IGV3nfpg9pL+y4vsL5kBc6LQ61bZ9Bci4WUSZPWUSOQlkx1yErEkelysJ8/8v
         28Jc2MB5r0fcfKAWO0MVmwcbtedvfdZsNnYHzMcVNbCWxdrmQLZazkM5wleGg7pGQX2o
         Z8UNG+FzH5DQeCnrLjDPOekMNArUkWUk0trc12uz3VhTQRegFP9FWDm0pJ/bKvY9ibwj
         I35mBhz2zgXLjPmhNv6mrv8N32TobaIbj2GEilAzHasPzG8Uorwof73pR2kxmo/wvvc3
         jTTw==
X-Gm-Message-State: AOAM531K6PyYWQkygEsznLRhLcUuEo5inmpZmcCtj0rGvknHswZlnUbO
        9DX+5FXHzvTsK87rRg4aeJ4=
X-Google-Smtp-Source: ABdhPJwVQA8v1LRupQwomar4+CUInn43EDZhqifgbRroovZmFoQ5wZbLOQFeGGJ5iMJzycSGu4j0jA==
X-Received: by 2002:a17:90a:b907:: with SMTP id p7mr26438253pjr.142.1632100183524;
        Sun, 19 Sep 2021 18:09:43 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id x19sm12485814pfa.104.2021.09.19.18.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 18:09:43 -0700 (PDT)
Date:   Mon, 20 Sep 2021 01:09:38 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH] Introducing lockless cache built on top of slab
 allocator
Message-ID: <20210920010938.GA3108@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210919164239.49905-1-42.hyeyoo@gmail.com>
 <YUeM2J7X/i0CHjrz@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUeM2J7X/i0CHjrz@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthew, Thanks to give me a comment! I appreciate it.

On Sun, Sep 19, 2021 at 08:17:44PM +0100, Matthew Wilcox wrote:
> On Sun, Sep 19, 2021 at 04:42:39PM +0000, Hyeonggon Yoo wrote:
> > It is just simple proof of concept, and not ready for submission yet.
> > There can be wrong code (like wrong gfp flags, or wrong error handling,
> > etc) it is just simple proof of concept. I want comment from you.
> 
> Have you read:
> 
> https://www.usenix.org/legacy/event/usenix01/full_papers/bonwick/bonwick_html/
> The relevant part of that paper is section 3, magazines.  We should have
> low and high water marks for number of objects

I haven't read that before, but after reading it seems not different from
SLAB's percpu queuing.
 
> and we should allocate
> from / free to the slab allocator in batches.  Slab has bulk alloc/free
> APIs already.
> 

There's kmem_cache_alloc_{bulk,free} functions for bulk
allocation. But it's designed for large number of allocation
to reduce locking cost, not for percpu lockless allocation.

Yeah, we can implement lockless cache using kmem_cache_alloc_{bulk, free}
but kmem_cache_alloc_{free,bulk} is not enough.

> I'd rather see this be part of the slab allocator than a separate API.

And I disagree on this. for because most of situation, we cannot
allocate without lock, it is special case for IO polling.

To make it as part of slab allocator, we need to modify existing data
structure. But making it part of slab allocator will be waste of memory
because most of them are not using this.
