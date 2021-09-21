Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8376E4134C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhIUNsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233218AbhIUNsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:48:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D81D0610E8;
        Tue, 21 Sep 2021 13:47:21 +0000 (UTC)
Date:   Tue, 21 Sep 2021 14:47:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     will@kernel.org, lorenzo.pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next v2] arm64: PCI: Introduce pcibios_free_irq()
 helper function
Message-ID: <YUniZmeU3SA6+Aut@arm.com>
References: <20210826060406.12571-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826060406.12571-1-yajun.deng@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 02:04:06PM +0800, Yajun Deng wrote:
> pcibios_alloc_irq() will be called in pci_device_probe(), but there
> hasn't pcibios_free_irq() in arm64 architecture correspond it.
> pcibios_free_irq() is an empty weak function in drivers/pci/pci-driver.c.
> So add pcibios_free_irq() for correspond it. This will be called
> in pci_device_remove().
> 
> ====================
> v2: remove the change in pcibios_alloc_irq(), and modify the commit log.
> ====================
> 
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

For symmetry with the alloc path, this looks fine but I'd like Lorenzo
to confirm.

The other questions, what does it fix and do we need a cc stable?

Thanks.

-- 
Catalin
