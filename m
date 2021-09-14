Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D240AC39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhINLKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:10:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32870 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhINLKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:10:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631617771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5L53b1aW4qWbrWwixZQLL5XpvN/Xich8YXIpyYky8g=;
        b=taPBC9dDsPSAxokSNWsFlzdEp2X2njXjJABW2xf54PpdxaXJW8V5Hd8e98sgxTFU/0wj8z
        4EZxiZFfGjQz1kncwWvCniVE0bwqUt3p7W0UAR0nH+JjDYw1GNW51sh4W9nmnfmmtOtwwK
        b9Kn28esA6htvsuKMsWg6Ad32TAFZ/EASmvYpvNl6y97qFIZqHs6jrWWLZ6NyN7aUs7S3c
        uUoaxJfxHbTV8tPLX22lWZEd4RhJgLQIE2zGXxiZRrJw1fwrIGVXx9onJyEnLTGPd7qhzq
        pNE8d9p3pqBAAhXRXBzaf/5r9TzCqmeJ48dmS3L1Nm2iTYol58mWl4ST4g0Dkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631617771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5L53b1aW4qWbrWwixZQLL5XpvN/Xich8YXIpyYky8g=;
        b=IWZiRicc3an/+umdwpR9xwKZEvdzyIUll1dV1bDMKON/4eAqP/uib1dxUY6WkhRsurOu/S
        npzWxwUSYz0F9nCg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
In-Reply-To: <YUCBZjjk77q8JS4f@hirez.programming.kicks-ass.net>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com> <875yv4f99j.ffs@tglx>
 <YUCBZjjk77q8JS4f@hirez.programming.kicks-ass.net>
Date:   Tue, 14 Sep 2021 13:09:31 +0200
Message-ID: <87tuinct1w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2021 at 13:03, Peter Zijlstra wrote:
> On Mon, Sep 13, 2021 at 11:36:24PM +0200, Thomas Gleixner wrote:
> Here you rely on the UNLOCK+LOCK pattern because we have two adjacent
> critical sections (or rather, the same twice), which provides RCtso
> ordering, which is sufficient to make the below store:
>
>> 
>>         intx_soft_enabled = true;
>
> a RELEASE. still, I would suggest writing it at least using
> WRITE_ONCE() with a comment on.

Right. forgot about that.

> 	disable_irq();
> 	/*
> 	 * The above disable_irq() provides TSO ordering and as such
> 	 * promotes the below store to store-release.
> 	 */
> 	WRITE_ONCE(intx_soft_enabled, true);
> 	enable_irq();
>
>> In this case synchronize_irq() prevents the subsequent store to
>> intx_soft_enabled to leak into the __disable_irq(desc) section which in
>> turn makes it impossible for an interrupt handler to observe
>> intx_soft_enabled == true before the prerequisites which preceed the
>> call to disable_irq() are visible.
>> 
>> Of course the memory ordering wizards might disagree, but if they do,
>> then we have a massive chase of ordering problems vs. similar constructs
>> all over the tree ahead of us.
>
> Your case, UNLOCK s + LOCK s, is fully documented to provide RCtso
> ordering. The more general case of: UNLOCK r + LOCK s, will shortly
> appear in documentation near you. Meaning we can forget about the
> details an blanket state that any UNLOCK followed by a LOCK (on the same
> CPU) will provide TSO ordering.

I think we also should document the disable/synchronize_irq() scheme
somewhere.

Thanks,

        tglx

