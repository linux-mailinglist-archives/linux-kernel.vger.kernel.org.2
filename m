Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C99413674
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhIUPtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:49:07 -0400
Received: from foss.arm.com ([217.140.110.172]:35474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234031AbhIUPtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:49:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19BFA113E;
        Tue, 21 Sep 2021 08:47:37 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D7233F718;
        Tue, 21 Sep 2021 08:47:36 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:47:31 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next v2] arm64: PCI: Introduce pcibios_free_irq()
 helper function
Message-ID: <20210921154731.GA2756@lpieralisi>
References: <20210826060406.12571-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826060406.12571-1-yajun.deng@linux.dev>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 02:04:06PM +0800, Yajun Deng wrote:
> pcibios_alloc_irq() will be called in pci_device_probe(), but there
> hasn't pcibios_free_irq() in arm64 architecture correspond it.
> pcibios_free_irq() is an empty weak function in drivers/pci/pci-driver.c.

"pcibios_alloc_irq() is a weak function called to allocate IRQs for
a device in pci_device_probe(); arm64 implements it with
ACPI specific code to enable IRQs for a device.

When a device is removed (pci_device_remove()) the pcibios_free_irq()
counterpart is called.

Current arm64 code does not implement a pcibios_free_irq() function,
and therefore, the weak empty stub is executed, which means that the
IRQ for a device are not properly disabled when a device is removed.

Add an arm64 pcibios_free_irq() to undo the actions carried out in
pcibios_alloc_irq()."

This is a stub commit log. Then you need to describe the bug you
are fixing (if any, or it is just code inspection ?)

> So add pcibios_free_irq() for correspond it. This will be called
> in pci_device_remove().
> 
> ====================
> v2: remove the change in pcibios_alloc_irq(), and modify the commit log.
> ====================

Don't add versioning in the commit log, it does not belong here.

I don't think we should send this to stable kernels straight away,
it is best to make sure we are not triggering any regressions first.

Lorenzo

> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  arch/arm64/kernel/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 2276689b5411..6ffd92126f65 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -29,6 +29,13 @@ int pcibios_alloc_irq(struct pci_dev *dev)
>  
>  	return 0;
>  }
> +
> +void pcibios_free_irq(struct pci_dev *dev)
> +{
> +	if (!acpi_disabled)
> +		acpi_pci_irq_disable(dev);
> +}
> +
>  #endif
>  
>  /*
> -- 
> 2.32.0
> 
