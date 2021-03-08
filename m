Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540B6331873
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhCHU0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:26:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhCHUZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:25:57 -0500
Date:   Mon, 08 Mar 2021 20:25:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615235156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkAGJFlsMlRwMoieJ+e7Zf9cvbsYrzywx/OBEWx0vyk=;
        b=VKYGkw9xTKElPXPVmpYNA0snxrb1Q9VAgPh7s+jRgLLyGuMX/oE2dAHhi3k2UKm+3I8HCU
        3b5cHfxM7K7pUnQYuejTKBIHpqUu+5l2nw3vxC6lDfML2/S3y9hNsfCT1whfNp8P7IZJM3
        udzEILSIL0Y3xykOCvgO0VQx+/Y3JYQ6v8PiY/i7n8gHntO9mwWmkP4gcfxBayz4yIvUdz
        FspTWYM71UKDGpjmITFkQeAaRTpfv5hkJV6DsnYFxR+btiAWvxPxq6qHIZVvnJoZ4nLuUK
        jzSpnI7g4Y9lrHkC7O2R5ta09Kz5SSr0EqKbn7BCO2bloFSk2ePv6rMOOjsGww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615235156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkAGJFlsMlRwMoieJ+e7Zf9cvbsYrzywx/OBEWx0vyk=;
        b=5sp04yLdErygqCcUz0EwvVnMQqcgkImwGaVFdqCCYwCZYy9Zk3WK8v3kVmwp8oY+6rrchq
        Jt3Jzx8bDpcoJ5CA==
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
Message-ID: <161523515626.398.7178950064751758201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     69dd4503a7e6bae3389b8e028e5768008be8f2d7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/69dd4503a7e6bae3389b8e028e5768008be8f2d7
Author:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate:    Tue, 16 Feb 2021 15:36:07 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 08 Mar 2021 20:12:08 

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
index 2881513..d10ab1d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1898,16 +1898,15 @@ DEFINE_SHOW_ATTRIBUTE(irq_domain_debug);
 
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
