Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371193E86B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhHJXtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbhHJXtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:49:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B69C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tf6Vy/2ctRWWNIcs0s3Qu8P2Khg+cNlJrd0A29o67Xo=; b=N/9hcG+OsWYokGvRRz4SJ8jYJx
        63pHq293m9JWxXX9tLeH3ZIiSctQcFqJCSJbp3c1Wgso731WXi4XH6G48FJ3TgpkR9DnMztOOH0Eu
        ZnToEvvMkr8S87YrRPbYzTbQ+Mgy5tfkPHIB/3GbDx6tR1Vst5nvu/TyFrBKP7eoVLPVlTp+7Z76a
        c7oExzIRVQnOKpKkV95wA9x4nNDYX7zVkTaHkdZEJFfnUifqLPiaKx/DQpvbUPSTx24JfyFEG5vyj
        FFwhp+Y6hyhiSh4ZQn3QO0yeGWek1QU1XqEXRt0PB2ig4yaPqYSkBAYmk2Y3tOGgeelZRLdtBmitD
        hyo7HRwg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDbU4-00533T-Kj; Tue, 10 Aug 2021 23:48:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] kernel/irq: fix kernel-doc warnings in pm.c, msi.c, and ipi.c
Date:   Tue, 10 Aug 2021 16:48:35 -0700
Message-Id: <20210810234835.12547-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all kernel-doc warnings in these 3 files and do some simple editing
(capitalize acronyms, capitalize Linux).

kernel/irq/pm.c:235: warning: expecting prototype for irq_pm_syscore_ops(). Prototype was for irq_pm_syscore_resume() instead
kernel/irq/msi.c:530: warning: expecting prototype for __msi_domain_free_irqs(). Prototype was for msi_domain_free_irqs() instead
kernel/irq/msi.c:31: warning: No description found for return value of 'alloc_msi_entry'
kernel/irq/msi.c:103: warning: No description found for return value of 'msi_domain_set_affinity'
kernel/irq/msi.c:288: warning: No description found for return value of 'msi_create_irq_domain'
kernel/irq/msi.c:499: warning: No description found for return value of 'msi_domain_alloc_irqs'
kernel/irq/msi.c:545: warning: No description found for return value of 'msi_get_domain_info'
kernel/irq/ipi.c:264: warning: expecting prototype for ipi_send_mask(). Prototype was for __ipi_send_mask() instead
kernel/irq/ipi.c:25: warning: No description found for return value of 'irq_reserve_ipi'
kernel/irq/ipi.c:116: warning: No description found for return value of 'irq_destroy_ipi'
kernel/irq/ipi.c:163: warning: No description found for return value of 'ipi_get_hwirq'
kernel/irq/ipi.c:222: warning: No description found for return value of '__ipi_send_single'
kernel/irq/ipi.c:308: warning: No description found for return value of 'ipi_send_single'
kernel/irq/ipi.c:329: warning: No description found for return value of 'ipi_send_mask'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/ipi.c |   32 ++++++++++++++++----------------
 kernel/irq/msi.c |   18 ++++++++++++------
 kernel/irq/pm.c  |    2 +-
 3 files changed, 29 insertions(+), 23 deletions(-)

--- linux-next-20210809.orig/kernel/irq/pm.c
+++ linux-next-20210809/kernel/irq/pm.c
@@ -227,7 +227,7 @@ unlock:
 }
 
 /**
- * irq_pm_syscore_ops - enable interrupt lines early
+ * irq_pm_syscore_resume - enable interrupt lines early
  *
  * Enable all interrupt lines with %IRQF_EARLY_RESUME set.
  */
--- linux-next-20210809.orig/kernel/irq/msi.c
+++ linux-next-20210809/kernel/irq/msi.c
@@ -18,13 +18,15 @@
 #include "internals.h"
 
 /**
- * alloc_msi_entry - Allocate an initialize msi_entry
+ * alloc_msi_entry - Allocate an initialized msi_desc
  * @dev:	Pointer to the device for which this is allocated
  * @nvec:	The number of vectors used in this entry
  * @affinity:	Optional pointer to an affinity mask array size of @nvec
  *
- * If @affinity is not NULL then an affinity array[@nvec] is allocated
+ * If @affinity is not %NULL then an affinity array[@nvec] is allocated
  * and the affinity masks and flags from @affinity are copied.
+ *
+ * Return: pointer to allocated &msi_desc on success or %NULL on failure
  */
 struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
 				 const struct irq_affinity_desc *affinity)
@@ -97,6 +99,8 @@ static void msi_check_level(struct irq_d
  *
  * Intended to be used by MSI interrupt controllers which are
  * implemented with hierarchical domains.
+ *
+ * Return: IRQ_SET_MASK_* result code
  */
 int msi_domain_set_affinity(struct irq_data *irq_data,
 			    const struct cpumask *mask, bool force)
@@ -277,10 +281,12 @@ static void msi_domain_update_chip_ops(s
 }
 
 /**
- * msi_create_irq_domain - Create a MSI interrupt domain
+ * msi_create_irq_domain - Create an MSI interrupt domain
  * @fwnode:	Optional fwnode of the interrupt controller
  * @info:	MSI domain info
  * @parent:	Parent irq domain
+ *
+ * Return: pointer to the created &struct irq_domain or %NULL on failure
  */
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
@@ -492,7 +498,7 @@ cleanup:
  *		are allocated
  * @nvec:	The number of interrupts to allocate
  *
- * Returns 0 on success or an error code.
+ * Return: %0 on success or an error code.
  */
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec)
@@ -521,7 +527,7 @@ void __msi_domain_free_irqs(struct irq_d
 }
 
 /**
- * __msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
+ * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
  * @domain:	The domain to managing the interrupts
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are free
@@ -538,7 +544,7 @@ void msi_domain_free_irqs(struct irq_dom
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
  *
- * Returns the pointer to the msi_domain_info stored in
+ * Return: the pointer to the msi_domain_info stored in
  * @domain->host_data.
  */
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain)
--- linux-next-20210809.orig/kernel/irq/ipi.c
+++ linux-next-20210809/kernel/irq/ipi.c
@@ -14,11 +14,11 @@
 /**
  * irq_reserve_ipi() - Setup an IPI to destination cpumask
  * @domain:	IPI domain
- * @dest:	cpumask of cpus which can receive the IPI
+ * @dest:	cpumask of CPUs which can receive the IPI
  *
  * Allocate a virq that can be used to send IPI to any CPU in dest mask.
  *
- * On success it'll return linux irq number and error code on failure
+ * Return: Linux IRQ number on success or error code on failure
  */
 int irq_reserve_ipi(struct irq_domain *domain,
 			     const struct cpumask *dest)
@@ -104,13 +104,13 @@ free_descs:
 
 /**
  * irq_destroy_ipi() - unreserve an IPI that was previously allocated
- * @irq:	linux irq number to be destroyed
- * @dest:	cpumask of cpus which should have the IPI removed
+ * @irq:	Linux IRQ number to be destroyed
+ * @dest:	cpumask of CPUs which should have the IPI removed
  *
  * The IPIs allocated with irq_reserve_ipi() are returned to the system
  * destroying all virqs associated with them.
  *
- * Return 0 on success or error code on failure.
+ * Return: %0 on success or error code on failure.
  */
 int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 {
@@ -150,14 +150,14 @@ int irq_destroy_ipi(unsigned int irq, co
 }
 
 /**
- * ipi_get_hwirq - Get the hwirq associated with an IPI to a cpu
- * @irq:	linux irq number
- * @cpu:	the target cpu
+ * ipi_get_hwirq - Get the hwirq associated with an IPI to a CPU
+ * @irq:	Linux IRQ number
+ * @cpu:	the target CPU
  *
  * When dealing with coprocessors IPI, we need to inform the coprocessor of
  * the hwirq it needs to use to receive and send IPIs.
  *
- * Returns hwirq value on success and INVALID_HWIRQ on failure.
+ * Return: hwirq value on success or INVALID_HWIRQ on failure.
  */
 irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
 {
@@ -216,7 +216,7 @@ static int ipi_send_verify(struct irq_ch
  * This function is for architecture or core code to speed up IPI sending. Not
  * usable from driver code.
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int __ipi_send_single(struct irq_desc *desc, unsigned int cpu)
 {
@@ -250,7 +250,7 @@ int __ipi_send_single(struct irq_desc *d
 }
 
 /**
- * ipi_send_mask - send an IPI to target Linux SMP CPU(s)
+ * __ipi_send_mask - send an IPI to target Linux SMP CPU(s)
  * @desc:	pointer to irq_desc of the IRQ
  * @dest:	dest CPU(s), must be a subset of the mask passed to
  *		irq_reserve_ipi()
@@ -258,7 +258,7 @@ int __ipi_send_single(struct irq_desc *d
  * This function is for architecture or core code to speed up IPI sending. Not
  * usable from driver code.
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest)
 {
@@ -298,11 +298,11 @@ int __ipi_send_mask(struct irq_desc *des
 
 /**
  * ipi_send_single - Send an IPI to a single CPU
- * @virq:	linux irq number from irq_reserve_ipi()
+ * @virq:	Linux IRQ number from irq_reserve_ipi()
  * @cpu:	destination CPU, must in the destination mask passed to
  *		irq_reserve_ipi()
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int ipi_send_single(unsigned int virq, unsigned int cpu)
 {
@@ -319,11 +319,11 @@ EXPORT_SYMBOL_GPL(ipi_send_single);
 
 /**
  * ipi_send_mask - Send an IPI to target CPU(s)
- * @virq:	linux irq number from irq_reserve_ipi()
+ * @virq:	Linux IRQ number from irq_reserve_ipi()
  * @dest:	dest CPU(s), must be a subset of the mask passed to
  *		irq_reserve_ipi()
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest)
 {
