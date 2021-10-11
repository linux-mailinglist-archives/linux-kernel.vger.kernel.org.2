Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCB428BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbhJKLLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235970AbhJKLLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7952460EB4;
        Mon, 11 Oct 2021 11:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633950586;
        bh=aU/ORD9aTN28OfqMBJVt9VUK/rhaDiAzfDUP8h089Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GouTvkCeDkPzQvUYCbuKjINzgc5ybPb58t45woq27gFjR2efiF6CiDdzr3QUBXKQt
         vz/l1uEv5esSH6QiodIueAf2dUEu62OagO4oRWLTD68dZUs/l4TJ7VCb+7urslXc9u
         QaHwO5wnsfo7lNa2yH45RW1f+d461Do6FhHRYXnv7oL9GU/TcZfjpZ+Wh83oq5k+xe
         zXUo1MXLdgW8xfLJvYhvJ5t/Y5EE5i1HxdVnzIg6QHXo2HQQm++SiZyOP+xf+8GI0I
         WcHD7KXegeH6Nv+Tk09vOspkvzEJHPjyp+7tg6LXSmLKCImuEgOh3x9qKqIrlQXqp7
         6i+5j6uZUnBIQ==
Date:   Mon, 11 Oct 2021 12:09:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     yajun.deng@linux.dev, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next v2] arm64: PCI: Introduce pcibios_free_irq()
 helper function
Message-ID: <20211011110940.GC4068@willie-the-truck>
References: <20210921154731.GA2756@lpieralisi>
 <20210826060406.12571-1-yajun.deng@linux.dev>
 <b821ee0489f71a90a74c1d905c4fa530@linux.dev>
 <20210922162201.GA24429@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922162201.GA24429@lpieralisi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 05:22:01PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 22, 2021 at 02:49:13AM +0000, yajun.deng@linux.dev wrote:
> > September 21, 2021 11:47 PM, "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com> wrote:
> > 
> > > On Thu, Aug 26, 2021 at 02:04:06PM +0800, Yajun Deng wrote:
> > > 
> > >> pcibios_alloc_irq() will be called in pci_device_probe(), but there
> > >> hasn't pcibios_free_irq() in arm64 architecture correspond it.
> > >> pcibios_free_irq() is an empty weak function in drivers/pci/pci-driver.c.
> > > 
> > > "pcibios_alloc_irq() is a weak function called to allocate IRQs for
> > > a device in pci_device_probe(); arm64 implements it with
> > > ACPI specific code to enable IRQs for a device.
> > > 
> > > When a device is removed (pci_device_remove()) the pcibios_free_irq()
> > > counterpart is called.
> > > 
> > > Current arm64 code does not implement a pcibios_free_irq() function,
> > > and therefore, the weak empty stub is executed, which means that the
> > > IRQ for a device are not properly disabled when a device is removed.
> > > 
> > > Add an arm64 pcibios_free_irq() to undo the actions carried out in
> > > pcibios_alloc_irq()."
> > > 
> > > This is a stub commit log. Then you need to describe the bug you
> > > are fixing (if any, or it is just code inspection ?)
> > > 
> > It is just code inspection.
> 
> Before merging it it must be tested, which would prove it is needed.

Ok, I'll ignore this patch for now then. Please yell if you want me to pick
it up.

Will
