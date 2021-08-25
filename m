Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A343F75E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbhHYNb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:31:29 -0400
Received: from foss.arm.com ([217.140.110.172]:51158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241211AbhHYNb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:31:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 067C2106F;
        Wed, 25 Aug 2021 06:30:43 -0700 (PDT)
Received: from e123427-lin.cambridge.arm.com (unknown [10.57.43.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 469F13F5A1;
        Wed, 25 Aug 2021 06:30:41 -0700 (PDT)
Date:   Wed, 25 Aug 2021 14:30:35 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] arm64: PCI: Introduce pcibios_free_irq()
 helper function
Message-ID: <20210825133035.GA20522@e123427-lin.cambridge.arm.com>
References: <20210825071612.21543-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825071612.21543-1-yajun.deng@linux.dev>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 03:16:12PM +0800, Yajun Deng wrote:
> Introduce pcibios_free_irq() to free irq in pci_device_probe() and
> pci_device_remove() that in drivers/pci/pci-driver.c.

Add a rationale - it is just code inspection or you are fixing a bug ?

> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  arch/arm64/kernel/pci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c60..40da5aff4548 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -25,10 +25,18 @@
>  int pcibios_alloc_irq(struct pci_dev *dev)
>  {
>  	if (!acpi_disabled)
> -		acpi_pci_irq_enable(dev);
> +		return acpi_pci_irq_enable(dev);

This is an unrelated change and it is potentially introducing
regressions. I need to page in the reasons why on arm64 we had to resort
to pcibios_alloc_irq() (probe ordering IIRC) - in the meanwhile
this function stays as it is.

>  	return 0;
>  }
> +
> +void pcibios_free_irq(struct pci_dev *dev)
> +{
> +	if (!acpi_disabled)
> +		acpi_pci_irq_disable(dev);
> +
> +}

Adding pcibios_free_irq() makes sense and I believe it is a genuine
"fix".

Please add any information in the commit log that explains the
run-time condition you are fixing.

Thanks,
Lorenzo
