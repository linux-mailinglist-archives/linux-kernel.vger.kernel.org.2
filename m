Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095CD36B746
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhDZQyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234333AbhDZQyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:54:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A26BD610FC;
        Mon, 26 Apr 2021 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456053;
        bh=/5nxe/CNEoSpv79yM3ZjDoG3vzUZrsto5hjWd0kskeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1tMl04aWQ/yNETBVoCZ1N9e8QmBje2w9kM8HXq6ANDgzc1XXZxB0wjdOpBzoKykG
         fPCJRSdMaHWlNIuDplcRH4z3xhu66WQ21zYq6n+e2dtSMMKu/L1qfIvzjAv+MJTGXO
         75li+IFBMvKriV0m/qcvpxUJ/VALLAXSJ8OHWN4k=
Date:   Mon, 26 Apr 2021 18:54:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        Wenwen Wang <wang6495@umn.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 086/190] Revert "x86/PCI: Fix PCI IRQ routing table
 memory leak"
Message-ID: <YIbwMhw2sGRpNenN@kroah.com>
References: <20210422050919.GA2913711@bjorn-Precision-5520>
 <87a6ppwcmc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6ppwcmc.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 11:53:31AM +0200, Thomas Gleixner wrote:
> On Thu, Apr 22 2021 at 00:09, Bjorn Helgaas wrote:
> > On Wed, Apr 21, 2021 at 02:59:21PM +0200, Greg Kroah-Hartman wrote:
> > I would prefer that you not apply this revert.
> >
> > Prior to ea094d53580f ("x86/PCI: Fix PCI IRQ routing table memory
> > leak"), we had essentially this:
> >
> >   pcibios_irq_init()
> >     pirq_table = pcibios_get_irq_routing_table();  # kmallocs
> >     if (pirq_table) {
> >       if (io_apic_assign_pci_irqs)
> > 	pirq_table = NULL;
> >     }
> >
> > So if we called pcibios_get_irq_routing_table(), we kmalloced some
> > space and then (if io_apic_assign_pci_irqs) threw away the pointer,
> > which leaks the pointer as the commit log says.
> >
> > After ea094d53580f, we have:
> >
> >   pcibios_irq_init()
> >     rtable = NULL;
> >     pirq_table = pcibios_get_irq_routing_table();  # kmallocs
> >     rtable = pirq_table;
> >     if (pirq_table) {
> >       if (io_apic_assign_pci_irqs) {
> >         kfree(rtable);
> > 	pirq_table = NULL;
> >       }
> >     }
> >
> > which seems right to me.
> 
> It is correct.

Thanks for the review, I'll go drop this revert.

greg k-h
