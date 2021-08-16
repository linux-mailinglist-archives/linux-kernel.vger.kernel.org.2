Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294553EDC59
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhHPRYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhHPRYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:24:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8D2C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:23:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v4so17558172wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q4xb7GT62H6SH9N7ILRbjnxbiy5piEQLOJSGos0eCQo=;
        b=EnEZK2cQBW4b172TC6B+BW8FW+wZgwIrsxF+ror+myRSVK5Sm37BtL79pov3S0VKE6
         HtOPAco6KUKg7xPID4z8HgjWPwWsNK2S9YQgjjaKkiJiQX+oNuyGHv7/BHRzAXmZDm9U
         IlZfqEkrY3GxedUs8PG1nHfq78wkR6LQsyk5N/pCnNIComRgjieAQRwD2KqoHNFdsVvB
         QEBXLfXF/JksZzedmmCi0APZloL/dOYHeN1PV5CyKWGnoGFRa3saT0d0z2jQO7s3f/qU
         tqe1GTXBc3JCpix06eW+IBEMyNr9EL6hnuPghvSACjiNNYlJ9KQ7RdKs31ebblh4dZ7N
         E+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q4xb7GT62H6SH9N7ILRbjnxbiy5piEQLOJSGos0eCQo=;
        b=KxzvEle+im87HnSY1NV+zNnKYbZ40QUkCtQPoKEWbEPBoQbaB2qqdb21U+gJ1N+9MH
         u15wA7zFnplBGWdtOcKFhQOPT9YSOg2qpQU6v2DTUMbsffasRfK9sCx5SuT3Xb8e1Tks
         c873VSekUpPLr64Xd2tp6r0BXUWJpDRRsfMkmi6KVF/A7Ao344kfrH/3kqTWn5Tm9cWU
         EHyQLzjs3EuKt2rhOEdcvCpR9mqiXm05YfSt4eBgVyhBChgvQgaqW+G+6yl5SMB9YeA8
         fU4o+Jmz+jtkf8BsIin6MwgTZGjkfnu3XJKTE2nHhK3ZUKXdW38FdxI9VtX9kfX6JO+j
         Z4bQ==
X-Gm-Message-State: AOAM531nvUnqUKwh5mMImMPq8SSTKaL3eXIuAa62Za1mXOddq/lD7adJ
        KJalP/jvbfOb5aTxqREt2C7bjQ==
X-Google-Smtp-Source: ABdhPJyjBAhWC+XP2eudHlLpJWyL0Ebt28ndaitiFqzPUNeGjjlVpBpkMDnL3nh/G/ZB/VGhzJuMaQ==
X-Received: by 2002:a5d:4ec5:: with SMTP id s5mr12809049wrv.267.1629134637607;
        Mon, 16 Aug 2021 10:23:57 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:4ab8:21c4:bd1f:eac2])
        by smtp.gmail.com with ESMTPSA id p4sm14175973wrq.81.2021.08.16.10.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:23:57 -0700 (PDT)
Date:   Mon, 16 Aug 2021 19:23:51 +0200
From:   Marco Elver <elver@google.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: LKMM: Read dependencies of writes ordered by dma_wmb()?
Message-ID: <YRqfJz/lpUaZpxq7@elver.google.com>
References: <YRo58c+JGOvec7tc@elver.google.com>
 <20210816145945.GB121345@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816145945.GB121345@rowland.harvard.edu>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 10:59AM -0400, Alan Stern wrote:
[...]
> > One caveat is the case I'm trying to understand doesn't involve just 2
> > CPUs but also a device. And for now, I'm assuming that dma_wmb() is as
> > strong as smp_wmb() also wrt other CPUs (but my guess is this
> > assumption is already too strong).
> 
> I'm not sure that is right.  dma_wmb affects the visibility of writes to 
> a DMA buffer from the point of view of the device, not necessarily from 
> the point of view of other CPUs.  At least, there doesn't seem to be any 
> claim in memory-barriers.txt that it does so.

Thanks, I thought so.

While I could just not instrument dma_*mb() at all, because KCSAN
obviously can't instrument what devices do, I wonder if the resulting
reports are at all interesting.

For example, if I do not make the assumption that dma_wmb==smp_smb, and
don't instrument dma_*mb() at all, I also get racy UAF reordered writes:
I could imagine some architecture where dma_wmb() propagates the write
to devices from CPU 0; but CPU 1 then does the kfree(), reallocates,
reuses the data, but then gets its data overwritten by CPU 0.

What would be more useful?

1. Let the architecture decide how they want KCSAN to instrument non-smp
   barriers, given it's underspecified. This means KCSAN would report
   different races on different architectures, but keep the noise down.

2. Assume the weakest possible model, where non-smp barriers just do
   nothing wrt other CPUs.

> > The whole area of the memory model that includes talking to devices and
> > devices talking back to CPUs seems quite murky, and need to confirm that
> > I either got it right or wrong. :-)
> 
> The LKMM itself doesn't include anything about device I/O.  So you're 
> already going beyond the known limits.  :-)
> 
> ...
> 
> > KCSAN is saying there is a potential use-after-free read of an skb due
> > to the read to 0xffff8880077b5570 potentially being delayed/reordered
> > later. If the memory was reallocated and reused concurrently, the read
> > could read garbage data:
> > 
> > 1.	The e1000 driver is being instructed to transmit in
> > 	e1000_xmit_frame(). Here it uses the data in the skb in various
> > 	places (e.g. in skb_headlen() above) to set up a new element in
> > 	the ring buffer to be consumed by the device via DMA.
> 
> You mean here the driver reads some stuff from the skb, right?  And 
> various writes depend on the data that was read, but these dependencies 
> aren't evident to the memory model because they all involve plain 
> accesses.

Yes, correct.

> > 2.	Eventually it calls e1000_tx_queue(), which seems to publish the
> > 	next entry into the ring buffer and finally calls dma_wmb().
> > 	Until this point I see no other barriers (although there's a
> > 	writel(), but it doesn't always seem to be called).
> 
> And potentially those reads from above could be delayed (or repeated) 
> after this point.
> 
> But you're missing something.  What matters isn't the dma_wmb.  Rather, 
> it's the call which transfers ownership of the buffer to the device.  
> That call must certainly include its own memory barrier, meaning that 
> the reads must complete before the call returns.  We don't depend on a 
> dma_wmb which might or might not be present to enforce this ordering.
> 
> Unless this buffer mapping is supposed to be coherent, of course, in 
> which case there would be no ownership transfers.

I think it's coherent:

	txdr->desc = dma_alloc_coherent(&pdev->dev, txdr->size, &txdr->dma,
					GFP_KERNEL);

and then in:

	static void e1000_tx_queue(...)
	{
		... writes to desc ...
		/* Force memory writes to complete before letting h/w
		 * know there are new descriptors to fetch.  (Only
		 * applicable for weak-ordered memory model archs,
		 * such as IA-64).
		 */
		dma_wmb();
		tx_ring->next_to_use = i;
	}

used by

	static netdev_tx_t e1000_xmit_frame(...)
	{
		...
		e1000_tx_queue(..., tx_ring, ...);
		...
		if (!netdev_xmit_more() ||
		    netif_xmit_stopped(netdev_get_tx_queue(netdev, 0))) {
			writel(tx_ring->next_to_use, hw->hw_addr + tx_ring->tdt);
		}
		...
	}

My best guess: as long as the device is fetching from the ring, the
driver can just append to it and does not do the writel().

> > 3.	e1000_clean_tx_irq() is called on another CPU after transmit
> > 	completes, and we know the device has consumed that entry from
> > 	the ring buffer. At this point the driver then says that the
> > 	associated skb can be kfree()'d.
> > 
> > 4.	If I interpreted dma_wmb() (and smp_wmb()) right, plain reads
> > 	may be reordered after it, irrespective if a write that depended
> > 	on such reads was ordered by the wmb(). Which means the
> > 	reordering of the plain reads accessing the skb before it may in
> > 	fact happen concurrently with the kfree() of skb if reordered
> > 	after. For example reordered to the very end of
> > 	e1000_xmit_frame() (line 3282) as KCSAN simulated in this case.
> > 
> > Is the above result allowed by the kernel's memory model?
> 
> This can't happen, for the reason explained above, if the buffer is 
> non-coherent.  But if the DMA mapping is coherent, this does sound like 
> a bug.

Makes sense.

> > In practice, my guess is no compiler and architecture combination would
> > allow this today; or is there an arch where it could?
> 
> Probably not; reordering of reads tends to take place over time 
> scales a lot shorter than lengthy I/O operations.

Which might be an argument to make KCSAN's non-smp barrier
instrumentation arch-dependent, because some drivers might in fact be
written with some target architectures and their properties in mind. At
least it would help keep the noise down, and those architecture that
want to see such races certainly still could.

Any preferences?

Thanks,
-- Marco
