Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F793410D0B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhISTUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 15:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhISTUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 15:20:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 12:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JrB8crO5qmaGGk/74p/+OVhuoZ1TfR35Lx0zXoUidCI=; b=rCz14sYtUeua4iC+9TqwrhIiUw
        I56zfeXHqGOVnH/VuCZnHcNFI8FtqNp0tjAdVosBlKR/G2dPRBhOgoNRxRSSlWV2+umiSQQq46nBh
        8GADJj/calkA6xctVt4qeHyp5oXBsBL8/qi/BJEvBDovDDNlxV0BQHXnIst8G1CMpq4pE+8T0sdxx
        RtaXz6r3jOqNi9fBqBN+87fRWOsNN2XibRgirfQAdfWyefht+VsWsgl3G4rY9PiGCxdUV2gJpVo3C
        kSznnWhx8cl+vtDYDr/W44mH9wz0vBDzwgvCubbuIkCwHp7XA6DemFMVZ6D+6KEWf4AAmj2m+Gvx0
        +NVIIoVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mS2Js-0025mj-By; Sun, 19 Sep 2021 19:17:56 +0000
Date:   Sun, 19 Sep 2021 20:17:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH] Introducing lockless cache built on top of slab
 allocator
Message-ID: <YUeM2J7X/i0CHjrz@casper.infradead.org>
References: <20210919164239.49905-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919164239.49905-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 04:42:39PM +0000, Hyeonggon Yoo wrote:
> It is just simple proof of concept, and not ready for submission yet.
> There can be wrong code (like wrong gfp flags, or wrong error handling,
> etc) it is just simple proof of concept. I want comment from you.

Have you read:

https://www.usenix.org/legacy/event/usenix01/full_papers/bonwick/bonwick_html/

The relevant part of that paper is section 3, magazines.  We should have
low and high water marks for number of objects, and we should allocate
from / free to the slab allocator in batches.  Slab has bulk alloc/free
APIs already.

I'd rather see this be part of the slab allocator than a separate API.
