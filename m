Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2004A366BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbhDUNHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237096AbhDUNFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A3DF61458;
        Wed, 21 Apr 2021 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010300;
        bh=fDgDbZbQ18InTmBsrFLp8RBQdFreYMG99zX/FhKdrDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAIQ6wtMQU8duQ/tYMc5ubHOmdts7rZQjRmxQbVfril9kjAcHWtBhYtnt3bP4yl5Q
         cUoOEAiBNJAodyBdLqS1PbVvkiJnLe0hFlN1LB4hKZNQEz/2k++wkoPIz+PF/OyULX
         FIQ/5G4Q2LG662FJVvNANYwK6oCOFRiOLs0/KA3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 086/190] Revert "x86/PCI: Fix PCI IRQ routing table memory leak"
Date:   Wed, 21 Apr 2021 14:59:21 +0200
Message-Id: <20210421130105.1226686-87-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ea094d53580f40c2124cef3d072b73b2425e7bfd.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Wenwen Wang <wang6495@umn.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/pci/irq.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index d3a73f9335e1..52e55108404e 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1119,8 +1119,6 @@ static const struct dmi_system_id pciirq_dmi_table[] __initconst = {
 
 void __init pcibios_irq_init(void)
 {
-	struct irq_routing_table *rtable = NULL;
-
 	DBG(KERN_DEBUG "PCI: IRQ init\n");
 
 	if (raw_pci_ops == NULL)
@@ -1131,10 +1129,8 @@ void __init pcibios_irq_init(void)
 	pirq_table = pirq_find_routing_table();
 
 #ifdef CONFIG_PCI_BIOS
-	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN)) {
+	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
 		pirq_table = pcibios_get_irq_routing_table();
-		rtable = pirq_table;
-	}
 #endif
 	if (pirq_table) {
 		pirq_peer_trick();
@@ -1149,10 +1145,8 @@ void __init pcibios_irq_init(void)
 		 * If we're using the I/O APIC, avoid using the PCI IRQ
 		 * routing table
 		 */
-		if (io_apic_assign_pci_irqs) {
-			kfree(rtable);
+		if (io_apic_assign_pci_irqs)
 			pirq_table = NULL;
-		}
 	}
 
 	x86_init.pci.fixup_irqs();
-- 
2.31.1

