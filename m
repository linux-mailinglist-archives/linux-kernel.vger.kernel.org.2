Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F859367919
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhDVFKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229568AbhDVFJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:09:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A4BB60FD7;
        Thu, 22 Apr 2021 05:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619068161;
        bh=KSAJXbhBRfmfvbY0Tr0Gz0HRPEGUOgbDF+fPPVwogAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IsCY7bT47aoR/3f6xrVU968WF8bTPn8s342OwkZfiUhNTlQFJEp+sIWAStAhfTBL6
         R/SuaTiLxCAo0VrlOnoKxW+X8OKrZv2Y+m6koROw4FXD6ukv4kISF7Lh6hh7KOMhbm
         h7PyuQSfyGsxbZJYS2xRR4eZgfZAjpRXF8v4KdhXu5Gx3yNbkaOj9XqhTeHA7S2Muo
         KI2Cn/N183FHvViGOP1mkllxYQ4wQFmn7BImubyQFRJCRA8R39KA3MNbd0Wh9f5vrh
         AhYB9NNyDh54fRVyGUE5+2/2uZohakf1avz+vEMcVpIGGT7AoeLKhSctga5Kkv/TES
         p2g5V8fEpfBBA==
Date:   Thu, 22 Apr 2021 00:09:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 086/190] Revert "x86/PCI: Fix PCI IRQ routing table
 memory leak"
Message-ID: <20210422050919.GA2913711@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-87-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:21PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit ea094d53580f40c2124cef3d072b73b2425e7bfd.
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
> Cc: Wenwen Wang <wang6495@umn.edu>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I would prefer that you not apply this revert.

Prior to ea094d53580f ("x86/PCI: Fix PCI IRQ routing table memory
leak"), we had essentially this:

  pcibios_irq_init()
    pirq_table = pcibios_get_irq_routing_table();  # kmallocs
    if (pirq_table) {
      if (io_apic_assign_pci_irqs)
	pirq_table = NULL;
    }

So if we called pcibios_get_irq_routing_table(), we kmalloced some
space and then (if io_apic_assign_pci_irqs) threw away the pointer,
which leaks the pointer as the commit log says.

After ea094d53580f, we have:

  pcibios_irq_init()
    rtable = NULL;
    pirq_table = pcibios_get_irq_routing_table();  # kmallocs
    rtable = pirq_table;
    if (pirq_table) {
      if (io_apic_assign_pci_irqs) {
        kfree(rtable);
	pirq_table = NULL;
      }
    }

which seems right to me.

Bjorn

> ---
>  arch/x86/pci/irq.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
> index d3a73f9335e1..52e55108404e 100644
> --- a/arch/x86/pci/irq.c
> +++ b/arch/x86/pci/irq.c
> @@ -1119,8 +1119,6 @@ static const struct dmi_system_id pciirq_dmi_table[] __initconst = {
>  
>  void __init pcibios_irq_init(void)
>  {
> -	struct irq_routing_table *rtable = NULL;
> -
>  	DBG(KERN_DEBUG "PCI: IRQ init\n");
>  
>  	if (raw_pci_ops == NULL)
> @@ -1131,10 +1129,8 @@ void __init pcibios_irq_init(void)
>  	pirq_table = pirq_find_routing_table();
>  
>  #ifdef CONFIG_PCI_BIOS
> -	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN)) {
> +	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
>  		pirq_table = pcibios_get_irq_routing_table();
> -		rtable = pirq_table;
> -	}
>  #endif
>  	if (pirq_table) {
>  		pirq_peer_trick();
> @@ -1149,10 +1145,8 @@ void __init pcibios_irq_init(void)
>  		 * If we're using the I/O APIC, avoid using the PCI IRQ
>  		 * routing table
>  		 */
> -		if (io_apic_assign_pci_irqs) {
> -			kfree(rtable);
> +		if (io_apic_assign_pci_irqs)
>  			pirq_table = NULL;
> -		}
>  	}
>  
>  	x86_init.pci.fixup_irqs();
> -- 
> 2.31.1
> 
