Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC540AC2C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhINLGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhINLGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:06:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D1FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mMZLspAs4SibC8RtzDy4xBKwM9DL7s6XmwYmYiusX18=; b=rNwoE9hFA4si/ZyTkc3P2xDSE7
        dcDCaJMft5fR4xVFBTYgKbPlTrZobXVQCFvH5slK9GNtC8AsiWSO1E52cxfHL+8hDcJzCnIU7bnO+
        5284nOCG0guLsFRtNKk9mOpa+t8kHLtFTlOqLF5cadZkcvqQYIQhTJYITteqcomdiUyCmoaczvSVd
        3bUD9lxuc3YT+t2ug8Z+Mr0ptYmcX5blTE3UTp7QhWKR3vNK7bdpN3aI6Ik2v1hXccBUNiwH8cNqE
        7FS0N0sS7q4CoyuNfKZozcRXEoLqjCQctkiifuggp9azW6hpMeitTSp8Yo6dePlYN8Ge4Ly83VSTj
        rAXlcRvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ6DQ-00Ea8d-1B; Tue, 14 Sep 2021 11:03:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE829300255;
        Tue, 14 Sep 2021 13:03:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4AA62D0615DB; Tue, 14 Sep 2021 13:03:02 +0200 (CEST)
Date:   Tue, 14 Sep 2021 13:03:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
Message-ID: <YUCBZjjk77q8JS4f@hirez.programming.kicks-ass.net>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
 <875yv4f99j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yv4f99j.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:36:24PM +0200, Thomas Gleixner wrote:

> That's the real problem and for that your barrier is at the wrong place
> because you want to make sure that those stores are visible before the
> store to intx_soft_enabled becomes visible, i.e. this should be:
> 
> 
>         /* Ensure that all preceeding stores are visible before intx_soft_enabled */
> 	smp_wmb();
> 	vp_dev->intx_soft_enabled = true;

That arguably wants to be smp_store_release() instead of smp_wmb() :-)

> Now Micheal is not really enthusiatic about the barrier in the interrupt
> handler hotpath, which is understandable.
> 
> As the device startup is not really happening often it's sensible to do
> the following
> 
>         disable_irq();
>         vp_dev->intx_soft_enabled = true;
>         enable_irq();
> 
> because:
> 
>         disable_irq()
>           synchronize_irq()
> 
> acts as a barrier for the preceeding stores:
> 
>         disable_irq()
>    	  raw_spin_lock(desc->lock);
>           __disable_irq(desc);
>    	  raw_spin_unlock(desc->lock);
> 
>           synchronize_irq()
>             do {
>    	      raw_spin_lock(desc->lock);
>               in_progress = check_inprogress(desc);
>    	      raw_spin_unlock(desc->lock);
>             } while (in_progress);     

Here you rely on the UNLOCK+LOCK pattern because we have two adjacent
critical sections (or rather, the same twice), which provides RCtso
ordering, which is sufficient to make the below store:

> 
>         intx_soft_enabled = true;

a RELEASE. still, I would suggest writing it at least using
WRITE_ONCE() with a comment on.

	disable_irq();
	/*
	 * The above disable_irq() provides TSO ordering and as such
	 * promotes the below store to store-release.
	 */
	WRITE_ONCE(intx_soft_enabled, true);
	enable_irq();

> In this case synchronize_irq() prevents the subsequent store to
> intx_soft_enabled to leak into the __disable_irq(desc) section which in
> turn makes it impossible for an interrupt handler to observe
> intx_soft_enabled == true before the prerequisites which preceed the
> call to disable_irq() are visible.
> 
> Of course the memory ordering wizards might disagree, but if they do,
> then we have a massive chase of ordering problems vs. similar constructs
> all over the tree ahead of us.

Your case, UNLOCK s + LOCK s, is fully documented to provide RCtso
ordering. The more general case of: UNLOCK r + LOCK s, will shortly
appear in documentation near you. Meaning we can forget about the
details an blanket state that any UNLOCK followed by a LOCK (on the same
CPU) will provide TSO ordering.
