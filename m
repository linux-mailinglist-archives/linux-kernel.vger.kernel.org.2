Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61645367EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhDVKnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:43:04 -0400
Received: from foss.arm.com ([217.140.110.172]:49736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235830AbhDVKnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:43:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB4FD11D4;
        Thu, 22 Apr 2021 03:42:27 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4A4C3F774;
        Thu, 22 Apr 2021 03:42:26 -0700 (PDT)
Date:   Thu, 22 Apr 2021 11:42:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Steven Price <steven.price@arm.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 101/190] Revert "PCI: xilinx: Check for
 __get_free_pages() failure"
Message-ID: <20210422104224.GB20094@lpieralisi>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-102-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-102-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:36PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 699ca30162686bf305cdf94861be02eb0cf9bda2.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Mukesh Ojha <mojha@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pci/controller/pcie-xilinx.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Hi Greg,

For this revert - the commit we are reverting looked and looks OK
to me even though honestly I'd revert it just on principle given
the nuisance it is causing.

Actually, we have code in -next that is removing the reverted content
anyway (but not because it is bogus, code in -next is a nice clean-up
for all PCI drivers from Marc):

https://git.kernel.org/lpieralisi/pci/c/161260e7f7bc

Again, happy to go ahead with the revert and rework the queued code
on top of it, just let me know please.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index fa5baeb82653..942c25bf7980 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -326,19 +326,14 @@ static const struct irq_domain_ops msi_domain_ops = {
>   * xilinx_pcie_enable_msi - Enable MSI support
>   * @port: PCIe port information
>   */
> -static int xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
> +static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
>  {
>  	phys_addr_t msg_addr;
>  
>  	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
> -	if (!port->msi_pages)
> -		return -ENOMEM;
> -
>  	msg_addr = virt_to_phys((void *)port->msi_pages);
>  	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
>  	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
> -
> -	return 0;
>  }
>  
>  /* INTx Functions */
> @@ -493,7 +488,6 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  	struct device *dev = port->dev;
>  	struct device_node *node = dev->of_node;
>  	struct device_node *pcie_intc_node;
> -	int ret;
>  
>  	/* Setup INTx */
>  	pcie_intc_node = of_get_next_child(node, NULL);
> @@ -522,9 +516,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  			return -ENODEV;
>  		}
>  
> -		ret = xilinx_pcie_enable_msi(port);
> -		if (ret)
> -			return ret;
> +		xilinx_pcie_enable_msi(port);
>  	}
>  
>  	return 0;
> -- 
> 2.31.1
> 
