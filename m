Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BDF424A70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 01:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhJFXUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 19:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhJFXUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 19:20:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2133C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 16:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ffTwrIBmUt2AAjjYbplxTVj+0VLY0JCFISjMFxJRyH0=; b=RFQyO1qb+x4mkvFGwNUrZcbmv/
        Ktr0rrrxz8WWL4HorWEaEEa/WvIQniKzRKicdNakJ0WtiOtqr3jZP1pyo0hQ2Kc6qqh2xws0wdgWC
        KyNHzKWo/w8Plj16yf8DaATQ0+/h8mYRdpVSIWX7k2UJ7Vms6HF/7BWkuvEeBKaoR2AoWnjeXcnpO
        Ih2Yt9U3IrZql6ruxxoDdf5ck/A8OEThOHgsXdFJv6aJJRtNAhNo3LwVpmHPX4YZix6m3TDUHxA6r
        jv0cIxqEX+TrJaxPQgxv6lG0ncNw+0y8PUZXWcFPaDyCdsTZd90z5NWz7vtbVAMh1u4rxF5XIFBLN
        R5KZFyBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYGAI-001Mhk-Gx; Wed, 06 Oct 2021 23:17:39 +0000
Date:   Thu, 7 Oct 2021 00:17:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hannes@cmpxchg.org, rientjes@google.com
Subject: Re: Compaction & folios
Message-ID: <YV4ujjM33QdLC8Xk@casper.infradead.org>
References: <YV4o9SxfYuLm1i4d@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV4o9SxfYuLm1i4d@moria.home.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 06:53:41PM -0400, Kent Overstreet wrote:
> It may turn out that allocating hugepages still doesn't work as reliably as we'd
> like - but folios are still a big help even when we can't allocate a 2MB page,
> because we'll be able to fall back to an order 6 or 7 or 8 allocation, which is
> something we can't do now. And, since multiple CPU vendors now support
> coalescing contiguous PTE entries in the TLB, this will still get us most of the
> performance benefits of using hugepages.

I'd like to add two things:

1. A lot of people talk about the performance improvements from using
2MB pages, and there are the obvious hardware ones -- one fewer level
to dereference in the page table walk when there's a TLB miss; using a
single TLB entry to cache an entire 2MB page.

But there are the software ones, which I believe Google have measured
(perhaps it was the ChromeOS team?)  Allocating order-2/3/4 pages reduces
the length of the LRU list by a factor of 4/8/16.  That means we get 4-16x
memory reclaimed per unit of time, which reduces the LRU lock contention.
Not to mention the advantage of being able to use a pagevec to describe
960KB of memory rather than 60KB.

2. We can only measure what CPUs do today.  If our behaviour changes,
CPU vendors will adapt.  I talked to someone who dabbles in hardware
design who said that it really isn't that hard to design a TLB that
can support mapping 64KB entries at arbitrary 4KB offsets.  There's no
particular incentive for CPU manufacturers to do that today, but if we
start allocating 64KB pages to cache files, that will change.
