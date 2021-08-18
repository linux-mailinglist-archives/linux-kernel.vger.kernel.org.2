Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF963F0786
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbhHRPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbhHRPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:08:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04869C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a3+aWwZ8A2mBrlkKyurg8rkEDu4ERvvcEAkDI68YCTY=; b=ilXjIsZjeoTJmRb5cFbzJQzGEk
        BCxWY+LTPYRz6hRYdtZApF7gNBWJ2D0f3edub72EOEvUw2iAPyQbQl32m00/LDNYpfikIt/+5RQql
        kpgXT1HBmadVdkCpb8xbNempBVtMbKtv/Z+Lfy0LtiXwxBT+gf7smajPAj+U7y0xy9tKFTBQqCwPy
        xb36a0cHRt4/1ccucnatUepY/kqM1Enove9Vu/TOqi/MbptsRjo3XG/rX9XOt5oZhytUkVl4RvZEX
        +5KWwYIeVkWGr/ZO+PnE1qHHnTgb8UF6ZwCdLkBaCSLGJQHZOkiv7vS4Y8tXOm4aDSNwPvGx+rJZp
        M10y2D3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGN9r-003xpe-Ii; Wed, 18 Aug 2021 15:07:17 +0000
Date:   Wed, 18 Aug 2021 16:07:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        yanghui <yanghui.def@bytedance.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm/mempolicy: fix a race between offset_il_node and
 mpol_rebind_task
Message-ID: <YR0iHyBHuYufepWV@casper.infradead.org>
References: <20210815061034.84309-1-yanghui.def@bytedance.com>
 <20210816175952.3c0d1eee821cd2d9ed7c3879@linux-foundation.org>
 <YRsULowKJtUKJhJ+@casper.infradead.org>
 <CAMZfGtVNJxTw-TPXHGF0kCwYMQK8hVG6=Z+hE3yuQRZh6ak-mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVNJxTw-TPXHGF0kCwYMQK8hVG6=Z+hE3yuQRZh6ak-mw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:02:46PM +0800, Muchun Song wrote:
> On Tue, Aug 17, 2021 at 9:43 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > +   unsigned int target, nnodes;
> > > >     int i;
> > > >     int nid;
> > > > +   /*
> > > > +    * The barrier will stabilize the nodemask in a register or on
> > > > +    * the stack so that it will stop changing under the code.
> > > > +    *
> > > > +    * Between first_node() and next_node(), pol->nodes could be changed
> > > > +    * by other threads. So we put pol->nodes in a local stack.
> > > > +    */
> > > > +   barrier();
> >
> > I think this could be an smp_rmb()?
> 
> Hi Matthew,
> 
> I have a question. Why is barrier() not enough?

I think barrier() may be more than is necessary.  We don't need a
barrier on non-SMP systems (or do we?)  And we only need to order reads,
not writes.
