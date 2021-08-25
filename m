Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395063F7288
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbhHYKFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235904AbhHYKFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:05:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4AAD61076;
        Wed, 25 Aug 2021 10:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629885905;
        bh=YwYi8a+J5g/Nx04R5c0CB3jA7B0h8kMs+HlDvPDVe0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DFnIqZ8e8yIcCuy2Hva0GCFyaX6/EN7I7TK1ec81fOPW/82dy8Y4PZfzSxWhLYCe9
         bjPIoaIoFgyFv7YcdzhrNorwjNHUbZOqQWqn27qH+0Qtvu0hCLiGNwH0lfmfo+knt1
         i8xjNAVYbsXS3UsNFOwOY3gnLkvurGeV7ahN4r9rghXj5f8dD0dZAD1PN3lxsPyzIo
         fuvtdDdBhBfRQBNCS+2NfJK2mEY14E+75km1SzGtL+iypEnaMPL+sAgp3R76XF+14F
         nBWwv13r8x5ymKB9m4PURqayrmvu1Ko6sBxPRlYIBVFoZfSRz+uWKr91xt+TF3h5pI
         NRPmQod1w3HKg==
Date:   Wed, 25 Aug 2021 11:05:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH linux-next] arm64: PCI: Introduce pcibios_free_irq()
 helper function
Message-ID: <20210825100500.GC24546@willie-the-truck>
References: <20210825071612.21543-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825071612.21543-1-yajun.deng@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Lorenzo]

On Wed, Aug 25, 2021 at 03:16:12PM +0800, Yajun Deng wrote:
> Introduce pcibios_free_irq() to free irq in pci_device_probe() and
> pci_device_remove() that in drivers/pci/pci-driver.c.

Please can you describe the problem you're solving?

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

This means we'll now fail device probe if we can't enable the GSI. Is that a
problem?

Will
