Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA49409F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 23:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345882AbhIMVhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 17:37:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245497AbhIMVhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 17:37:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631568985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LgVFF6xr9X77eEH5ReBqzJav7XI77CiOd3yTIuQR1BU=;
        b=ngqDZuDqjeoqNDOC3ymvNE3J2o6Fc2ckRwRgYs7eIYDQHH1O6+vDj1vCGJvd1jPdLz79fg
        qngi0IObYKleP+dY4OW1j1XDlG4fCLd5xIHUEhDnkAbd8R2Ya6TiBYSgDMLbUeAVLRTDZq
        53tQiYDpMS9ToXwBAicbuFfrpennVC8Bu3zITNTCc0Pa9181LuM5cgpIm7oDUZT6xgeOUh
        gV+irG4IG7hhOqaL5ezOZyCh6pUnhZq+UbbGedfkYf/oIkj1+Gq/+PQC8iInUu6Zf1Ju7j
        7y2vMDmwyRKF1/GQsUJWiV+z3hcVP/Kb7/g/5SvxR32L6ZTQi233nI6i/R5iEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631568985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LgVFF6xr9X77eEH5ReBqzJav7XI77CiOd3yTIuQR1BU=;
        b=pxMUNCY7fX8I7jg+qZYt6ey+2E7HiVy5AIBHk976GV4aDMhuWX5rZIZBx6Iw1r/qiTfV2R
        ch7nx5AXCseYy5BQ==
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
In-Reply-To: <20210913055353.35219-8-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
Date:   Mon, 13 Sep 2021 23:36:24 +0200
Message-ID: <875yv4f99j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

On Mon, Sep 13 2021 at 13:53, Jason Wang wrote:
> This patch tries to make sure the virtio interrupt handler for INTX
> won't be called after a reset and before virtio_device_ready(). We
> can't use IRQF_NO_AUTOEN since we're using shared interrupt
> (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> intx_soft_enabled variable and toggle it during in
> vp_disable/enable_vectors(). The INTX interrupt handler will check
> intx_soft_enabled before processing the actual interrupt.

Ah, there it is :)

Cc'ed our memory ordering wizards as I might be wrong as usual.

> -	if (vp_dev->intx_enabled)
> +	if (vp_dev->intx_enabled) {
> +		vp_dev->intx_soft_enabled = false;
> +		/* ensure the vp_interrupt see this intx_soft_enabled value */
> +		smp_wmb();
>  		synchronize_irq(vp_dev->pci_dev->irq);

As you are synchronizing the interrupt here anyway, what is the value of
the barrier?

 		vp_dev->intx_soft_enabled = false;
  		synchronize_irq(vp_dev->pci_dev->irq);

is sufficient because of:

synchronize_irq()
   do {
   	raw_spin_lock(desc->lock);
        in_progress = check_inprogress(desc);
   	raw_spin_unlock(desc->lock);
   } while (in_progress);     

raw_spin_lock() has ACQUIRE semantics so the store to intx_soft_enabled
can complete after lock has been acquired which is uninteresting.

raw_spin_unlock() has RELEASE semantics so the store to intx_soft_enabled
has to be completed before the unlock completes.

So if the interrupt is on the flight then it might or might not see
intx_soft_enabled == false. But that's true for your barrier construct
as well.

The important part is that any interrupt for this line arriving after
synchronize_irq() has completed is guaranteed to see intx_soft_enabled
== false.

That is what you want to achieve, right?

>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
>  		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
>  
> -	if (vp_dev->intx_enabled)
> +	if (vp_dev->intx_enabled) {
> +		vp_dev->intx_soft_enabled = true;
> +		/* ensure the vp_interrupt see this intx_soft_enabled value */
> +		smp_wmb();

For the enable case the barrier is pointless vs. intx_soft_enabled

CPU 0                                           CPU 1

interrupt                                       vp_enable_vectors()
  vp_interrupt()                                
    if (!vp_dev->intx_soft_enabled)
       return IRQ_NONE;
                                                  vp_dev->intx_soft_enabled = true;

IOW, the concurrent interrupt might or might not see the store. That's
not a problem for legacy PCI interrupts. If it did not see the store and
the interrupt originated from that device then it will account it as one
spurious interrupt which will get raised again because those interrupts
are level triggered and nothing acknowledged it at the device level.

Now, what's more interesting is that is has to be guaranteed that the
interrupt which observes

        vp_dev->intx_soft_enabled == true

also observes all preceeding stores, i.e. those which make the interrupt
handler capable of handling the interrupt.

That's the real problem and for that your barrier is at the wrong place
because you want to make sure that those stores are visible before the
store to intx_soft_enabled becomes visible, i.e. this should be:


        /* Ensure that all preceeding stores are visible before intx_soft_enabled */
	smp_wmb();
	vp_dev->intx_soft_enabled = true;

Now Micheal is not really enthusiatic about the barrier in the interrupt
handler hotpath, which is understandable.

As the device startup is not really happening often it's sensible to do
the following

        disable_irq();
        vp_dev->intx_soft_enabled = true;
        enable_irq();

because:

        disable_irq()
          synchronize_irq()

acts as a barrier for the preceeding stores:

        disable_irq()
   	  raw_spin_lock(desc->lock);
          __disable_irq(desc);
   	  raw_spin_unlock(desc->lock);

          synchronize_irq()
            do {
   	      raw_spin_lock(desc->lock);
              in_progress = check_inprogress(desc);
   	      raw_spin_unlock(desc->lock);
            } while (in_progress);     

        intx_soft_enabled = true;

        enable_irq();

In this case synchronize_irq() prevents the subsequent store to
intx_soft_enabled to leak into the __disable_irq(desc) section which in
turn makes it impossible for an interrupt handler to observe
intx_soft_enabled == true before the prerequisites which preceed the
call to disable_irq() are visible.

Of course the memory ordering wizards might disagree, but if they do,
then we have a massive chase of ordering problems vs. similar constructs
all over the tree ahead of us.

From the interrupt perspective the sequence:

        disable_irq();
        vp_dev->intx_soft_enabled = true;
        enable_irq();

is perfectly fine as well. Any interrupt arriving during the disabled
section will be reraised on enable_irq() in hardware because it's a
level interrupt. Any resulting failure is either a hardware or a
hypervisor bug.

Thanks,

        tglx
