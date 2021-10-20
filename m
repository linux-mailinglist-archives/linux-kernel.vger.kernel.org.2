Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B0434D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTOLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJTOLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:11:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8DEC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KRTYJRPRYXm9ZqJy2lw2hJUmwgSE6jOOWBjg81sbw4s=; b=nkMjLC8wVsQezunuXjfT408tBj
        kH18as1wq/LCEf+14wdzpwtwaanEW7VgIagT4snLfmL9jsIeBSLB6HmtXrrZ0PBwPdHpBZxTfhbK5
        iIZomUoy2oLAtrvT5cT44eK+TVkQxZaNZnDDHpLqkqNUrFiDTZ+pODYjioxewujb1GZrwhbu3P6B/
        L2ZZZASPiHNRULrYXNiduTXcwtqwO7IjyxvbCCanossohZXivpFbqsqUVFjL2lvOYnWw2AoT4doUw
        UN58roeFyvFRetjQLgg/NsKfJKSwJQ2fx0KgcCNhI0tRuok/uvbRht/QHnwyH/5YTThJrzpOON2/g
        lPTlZZXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdCFr-00CYGK-Nl; Wed, 20 Oct 2021 14:08:03 +0000
Date:   Wed, 20 Oct 2021 15:07:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Dave Taht <dave.taht@gmail.com>
Subject: Re: [RFC PATCH] mm, slob: Rewrite SLOB using segregated free list
Message-ID: <YXAir3H85gCB511Z@casper.infradead.org>
References: <20211020135535.517236-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020135535.517236-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 01:55:35PM +0000, Hyeonggon Yoo wrote:
> Hello linux-mm, I rewrote SLOB using segregated free list,
> to understand SLOB and SLUB more. It uses more kilobytes
> of memory (48kB on 32bit tinyconfig) and became 9~10x faster.
> 
> But after rewriting, I thought I need to discuss what SLOB is for.
> According to Matthew, SLOB is for small machines whose
> memory is 1~16 MB.
> 
> I wonder adding 48kB on SLOB memory for speed/lower latency
> is worth or harmful.
> 
> So.. questions in my head now:
>     - Who is users of SLOB?
>     - Is it harmful to add some kilobytes of memory into SLOB?
>     - Is it really possible to run linux under 10MB of RAM?
>     	(I failed with tinyconfig.)
>     - What is the boundary to make decision between SLOB and SLUB?

There certainly are people running Linux on such small machines.
Nicolas Pitre talked about what it takes to do it in a series of
four articles:

https://lwn.net/Articles/746780/

It's been a couple of decades since I was last paid to work on such a
system.  Dave Taht (cc'd) may be able to help you find people who
care about these use cases.  And maybe they can tell you whether 9-10x
faster for 48kB extra memory consumption is a good tradeoff for them.
