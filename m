Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5CB31CC27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBPOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhBPOgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:36:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2924864DFF;
        Tue, 16 Feb 2021 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613486170;
        bh=iEqJxA00L6dMaNOXAq02SgmvRex2qObuXi66DZ29Mnw=;
        h=Date:From:To:Cc:Subject:From;
        b=XrbS4ZILLtDvrvMdtKn5IEgnWEmeJWTgUbyYhZshipR/g0pvUoCk/HUtqw1LEJFyL
         QRF0QHjcmPP8yHFjUxDZ7bi9uHyhQXsqD3hB0heF9LV8cHjvIOAzoveRJxhT23Mjtq
         TQdOkbO060vNTjtFZ3cLX152au/uvkOJkss0huH8=
Date:   Tue, 16 Feb 2021 15:36:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
Message-ID: <YCvYV53ZdzQSWY6w@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to keep around a dentry pointer to a simple file that
debugfs itself can look up when we need to remove it from the system.
So simplify the code by deleting the variable and cleaning up the logic
around the debugfs file.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/irqdomain.h | 4 ----
 kernel/irq/irqdomain.c    | 9 ++++-----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 42d196805f58..33cacc8af26d 100644
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
index 6aacd342cd14..367ff1c35f75 100644
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
-- 
2.30.1

