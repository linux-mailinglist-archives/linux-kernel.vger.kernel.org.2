Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4B3ED95A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhHPPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:00:19 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35619 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229586AbhHPPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:00:18 -0400
Received: (qmail 123487 invoked by uid 1000); 16 Aug 2021 10:59:45 -0400
Date:   Mon, 16 Aug 2021 10:59:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: LKMM: Read dependencies of writes ordered by dma_wmb()?
Message-ID: <20210816145945.GB121345@rowland.harvard.edu>
References: <YRo58c+JGOvec7tc@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRo58c+JGOvec7tc@elver.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 12:12:01PM +0200, Marco Elver wrote:
> Hello,
> 
> Commit c58a801701693 added a paragraph to the LKMM:
> 
> 	+Although we said that plain accesses are not linked by the ppo
> 	+relation, they do contribute to it indirectly.  Namely, when there is
> 	+an address dependency from a marked load R to a plain store W,
> 	+followed by smp_wmb() and then a marked store W', the LKMM creates a
> 	+ppo link from R to W'.
> 
> Defining that certain _marked reads_ will also be ordered by smp_wmb().
> But otherwise, other reads (especially plain reads!) will _never_ be
> ordered by smp_wmb(). Is my understanding correct?

The ordering is indirect, but yes.

> I am asking because KCSAN is growing limited support for weak memory
> modeling and memory barriers, and I'm trying to figure out if I'm seeing
> a false positive or genuinely allowed race.
> 
> One caveat is the case I'm trying to understand doesn't involve just 2
> CPUs but also a device. And for now, I'm assuming that dma_wmb() is as
> strong as smp_wmb() also wrt other CPUs (but my guess is this
> assumption is already too strong).

I'm not sure that is right.  dma_wmb affects the visibility of writes to 
a DMA buffer from the point of view of the device, not necessarily from 
the point of view of other CPUs.  At least, there doesn't seem to be any 
claim in memory-barriers.txt that it does so.

> The whole area of the memory model that includes talking to devices and
> devices talking back to CPUs seems quite murky, and need to confirm that
> I either got it right or wrong. :-)

The LKMM itself doesn't include anything about device I/O.  So you're 
already going beyond the known limits.  :-)

...

> KCSAN is saying there is a potential use-after-free read of an skb due
> to the read to 0xffff8880077b5570 potentially being delayed/reordered
> later. If the memory was reallocated and reused concurrently, the read
> could read garbage data:
> 
> 1.	The e1000 driver is being instructed to transmit in
> 	e1000_xmit_frame(). Here it uses the data in the skb in various
> 	places (e.g. in skb_headlen() above) to set up a new element in
> 	the ring buffer to be consumed by the device via DMA.

You mean here the driver reads some stuff from the skb, right?  And 
various writes depend on the data that was read, but these dependencies 
aren't evident to the memory model because they all involve plain 
accesses.

> 2.	Eventually it calls e1000_tx_queue(), which seems to publish the
> 	next entry into the ring buffer and finally calls dma_wmb().
> 	Until this point I see no other barriers (although there's a
> 	writel(), but it doesn't always seem to be called).

And potentially those reads from above could be delayed (or repeated) 
after this point.

But you're missing something.  What matters isn't the dma_wmb.  Rather, 
it's the call which transfers ownership of the buffer to the device.  
That call must certainly include its own memory barrier, meaning that 
the reads must complete before the call returns.  We don't depend on a 
dma_wmb which might or might not be present to enforce this ordering.

Unless this buffer mapping is supposed to be coherent, of course, in 
which case there would be no ownership transfers.

> 3.	e1000_clean_tx_irq() is called on another CPU after transmit
> 	completes, and we know the device has consumed that entry from
> 	the ring buffer. At this point the driver then says that the
> 	associated skb can be kfree()'d.
> 
> 4.	If I interpreted dma_wmb() (and smp_wmb()) right, plain reads
> 	may be reordered after it, irrespective if a write that depended
> 	on such reads was ordered by the wmb(). Which means the
> 	reordering of the plain reads accessing the skb before it may in
> 	fact happen concurrently with the kfree() of skb if reordered
> 	after. For example reordered to the very end of
> 	e1000_xmit_frame() (line 3282) as KCSAN simulated in this case.
> 
> Is the above result allowed by the kernel's memory model?

This can't happen, for the reason explained above, if the buffer is 
non-coherent.  But if the DMA mapping is coherent, this does sound like 
a bug.

> In practice, my guess is no compiler and architecture combination would
> allow this today; or is there an arch where it could?

Probably not; reordering of reads tends to take place over time 
scales a lot shorter than lengthy I/O operations.

Alan
