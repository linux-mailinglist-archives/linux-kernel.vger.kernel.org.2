Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D5E31CD12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhBPPgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:36:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhBPPgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:36:50 -0500
Date:   Tue, 16 Feb 2021 15:36:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613489764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+ZiVA5v1GiyLBuGIa7Sc900owyf5mfsX1Y8M/06gsA=;
        b=OYScrdmoPgHB9/hoCclGM0ijrYJe07biFqWr3BVdZHmnEMw7TTXNiMuuVyxxAdGZs4GKHj
        PfskK0hVvLRuHPLHS1mmXi7jblmp/NO44dvf3Q0121Td0jjm5/RmNnDQHoel+A7oiNEBJs
        KhEPG8oFAIp0S1FndNyp0KbNtXSFGvLe1zSZlQEPUydLGpKBGcmRiVhWCE8Toyfx8TRqT2
        lmRyN/1Yk1HqnhUi8Y45lvD6b/Uy66A2c1jxucx8h0Bebt5PVPdL7KYeVdn47A9YmLwvNP
        I1hD8t+l/SdmnapkxieQQTf9tXDvbfkjERfPxCLgLoL+wZyAYN1N5OlmSKSWQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613489764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+ZiVA5v1GiyLBuGIa7Sc900owyf5mfsX1Y8M/06gsA=;
        b=CxzLlwXs57wEDkkxNWycqHNdbg0yypYVKAK9ftGttZEK2ymFgEXCUcIqPYYXWO8wKkrhSV
        cSVIBJqHGDzAnlCw==
From:   "irqchip-bot for Greg Kroah-Hartman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Remove debugfs_file from
 struct irq_domain
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
In-Reply-To: <YCvYV53ZdzQSWY6w@kroah.com>
References: <YCvYV53ZdzQSWY6w@kroah.com>
MIME-Version: 1.0
Message-ID: <161348976392.20312.17005353692925723880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0f34a3c0fc522232a65feee5f818f3a5f4fe00b4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0f34a3c0fc522232a65feee5f818f3a5f4fe00b4
Author:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate:    Tue, 16 Feb 2021 15:36:07 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 16 Feb 2021 15:32:14 

irqdomain: Remove debugfs_file from struct irq_domain

There's no need to keep around a dentry pointer to a simple file that
debugfs itself can look up when we need to remove it from the system.
So simplify the code by deleting the variable and cleaning up the logic
around the debugfs file.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/YCvYV53ZdzQSWY6w@kroah.com
---
 include/linux/irqdomain.h |  4 ----
 kernel/irq/irqdomain.c    |  9 ++++-----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 42d1968..33cacc8 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -150,7 +150,6 @@ struct irq_domain_chip_generic;
  *      setting up one or more generic chips for interrupt controllers
  *      drivers using the generic chip library which uses this pointer.
  * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
- * @debugfs_file: dentry for the domain debugfs file
  *
  * Revmap data, used internally by irq_domain
  * @revmap_direct_max_irq: The largest hwirq that can be set for controllers that
@@ -174,9 +173,6 @@ struct irq_domain {
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain *parent;
 #endif
-#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
-	struct dentry		*debugfs_file;
-#endif
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t hwirq_max;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6aacd34..367ff1c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1896,16 +1896,15 @@ DEFINE_SHOW_ATTRIBUTE(irq_domain_debug);
 
 static void debugfs_add_domain_dir(struct irq_domain *d)
 {
-	if (!d->name || !domain_dir || d->debugfs_file)
+	if (!d->name || !domain_dir)
 		return;
-	d->debugfs_file = debugfs_create_file(d->name, 0444, domain_dir, d,
-					      &irq_domain_debug_fops);
+	debugfs_create_file(d->name, 0444, domain_dir, d,
+			    &irq_domain_debug_fops);
 }
 
 static void debugfs_remove_domain_dir(struct irq_domain *d)
 {
-	debugfs_remove(d->debugfs_file);
-	d->debugfs_file = NULL;
+	debugfs_remove(debugfs_lookup(d->name, domain_dir));
 }
 
 void __init irq_domain_debugfs_init(struct dentry *root)
