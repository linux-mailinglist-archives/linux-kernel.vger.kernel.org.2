Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54463C2514
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhGINlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhGINla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:41:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC28BC0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 06:38:46 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 14so9334589qkh.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=51q7TWW5ZfyqHGcwfbH0N94fp7j84UGUTesBOl2dCJg=;
        b=oChV8h9lLEeFsv50IxRkqKlJDcGz56NlFwu81MrG/P+KI4MnSxC3zdqIjRF9GLKQy+
         yEZjnR8+JkpR1c5zyvB4dTt3CN44reLlCkd9uVm+BpHZ9i/zKyL0coGNwFTQ4Cf8jvp7
         iefSNawIX+76J4NYn+w0MgM7zBZEq0urszH8myhMSa2T4tYaYrkq58zVdhHW3PECHORo
         JH5ROC8yj56C8xmHAF+PeSobx/XURcmBsuZ1nVGl9sy39GlJsBjgwSokhKuy0IrJUDhP
         q8yOoV458OZq0hiy3c8gGqpUHAZguL6FRgEBT3sxiSKRxxoWtcbfb0JzfFUN2/33aOSS
         Y0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=51q7TWW5ZfyqHGcwfbH0N94fp7j84UGUTesBOl2dCJg=;
        b=o1bLFASEuSf4wTZDN1KYDin6YGQu5rx90j3okQfYBjSzvQqBeMukghKTN1mXyltOdZ
         iTLmcbMyvEmEhFcYHhjn+bqu1onnhNGu2VfZq7yCtX91EHX2cGEJjXq32Lobgc3KF4fW
         MNRg+/vpFbtKzemPY69xyG6corqDAilUALZRwFlOIUSwRZr1+v/DRWrMSnJNTQN615XO
         bxQBSXP3ssnUJb9E9x2qVPpKl8NmW/BaSUu/vIy54j60g7LHMEXY1YrBmMGSWIR3fQXp
         qUSzLA9X04SBy99bvpnVtsuejtCy5k95QzvfhpyPQcfZpNKzFPKDwlEmDIirHhvKF9rO
         Ke/Q==
X-Gm-Message-State: AOAM532eVev+oQ1aUMjwCsxHMtvuwW5EV082bv6c/AdsjDWwhLNBwdzP
        ECG7GcNM0UC4Ke1AMUufuftRemMZ+LL8L3q8EW8=
X-Google-Smtp-Source: ABdhPJwz/MwkceFeIvLb0qU+cd11JrOj8lt/wfb1hFPDj58IT0PnEhe5QDQ+0+K0kIA9TKn0TfkeEQ==
X-Received: by 2002:a37:9481:: with SMTP id w123mr30566065qkd.75.1625837925452;
        Fri, 09 Jul 2021 06:38:45 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id m6sm2214672qtx.9.2021.07.09.06.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:38:45 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     James.Bottomley@hansenpartnership.com
Cc:     deller@gmx.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: parisc: Update iosapic driver with proper printks
Date:   Fri, 09 Jul 2021 09:38:44 -0400
Message-ID: <5760611.lOV4Wx5bFT@iron-maiden>
Organization: Virginia Tech
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code from the old I/O Sapic Driver is outdated when it comes to printks. Fix
applying proper indentation and using dev_dbg() instead of printk on debugging
blocks. Also add a KERN_<LEVEL> where it is missing.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 drivers/parisc/iosapic.c | 65 +++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 8a3b0c3a1e92..808f3fdcb8ee 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -123,6 +123,7 @@
 **   o disable IRdT - call disable_irq(vector[line]->processor_irq)
 */
 
+#include <linux/dev_printk.h>
 #include <linux/pci.h>
 
 #include <asm/pdc.h>
@@ -141,18 +142,17 @@
 #undef DEBUG_IOSAPIC
 #undef DEBUG_IOSAPIC_IRT
 
-
 #ifdef DEBUG_IOSAPIC
-#define DBG(x...) printk(x)
-#else /* DEBUG_IOSAPIC */
+#define DBG(x...) dev_dbg(x)
+#else /* !DEBUG_IOSAPIC */
 #define DBG(x...)
-#endif /* DEBUG_IOSAPIC */
+#endif /* !DEBUG_IOSAPIC */
 
 #ifdef DEBUG_IOSAPIC_IRT
-#define DBG_IRT(x...) printk(x)
-#else
+#define DBG_IRT(x...) dev_dbg(x)
+#else /* !DEBUG_IOSAPIC_IRT */
 #define DBG_IRT(x...)
-#endif
+#endif /* !DEBUG_IOSAPIC_IRT */
 
 #ifdef CONFIG_64BIT
 #define COMPARE_IRTE_ADDR(irte, hpa)	((irte)->dest_iosapic_addr == (hpa))
@@ -335,14 +335,14 @@ iosapic_load_irt(unsigned long cell_num, struct irt_entry **irt)
 	struct irt_entry *p = table;
 	int i;
 
-	printk(MODULE_NAME " Interrupt Routing Table (cell %ld)\n", cell_num);
-	printk(MODULE_NAME " start = 0x%p num_entries %ld entry_size %d\n",
+	DBG_IRT("Interrupt Routing Table (cell %ld)\n", cell_num);
+	DBG_IRT("start = 0x%p num_entries %ld entry_size %d\n",
 		table,
 		num_entries,
 		(int) sizeof(struct irt_entry));
 
 	for (i = 0 ; i < num_entries ; i++, p++) {
-		printk(MODULE_NAME " %02x %02x %02x %02x %02x %02x %02x %02x %08x%08x\n",
+		DBG_IRT(" %02x %02x %02x %02x %02x %02x %02x %02x %08x%08x\n",
 		p->entry_type, p->entry_length, p->interrupt_type,
 		p->polarity_trigger, p->src_bus_irq_devno, p->src_bus_id,
 		p->src_seg_id, p->dest_iosapic_intin,
@@ -627,22 +627,22 @@ static void iosapic_unmask_irq(struct irq_data *d)
 #ifdef DEBUG_IOSAPIC_IRT
 {
 	u32 *t = (u32 *) ((ulong) vi->eoi_addr & ~0xffUL);
-	printk("iosapic_enable_irq(): regs %p", vi->eoi_addr);
+	DBG_IRT("iosapic_enable_irq(): regs %p", vi->eoi_addr);
 	for ( ; t < vi->eoi_addr; t++)
-		printk(" %x", readl(t));
-	printk("\n");
+		DBG_IRT(" %x", readl(t));
+	DBG_IRT("\n");
 }
 
-printk("iosapic_enable_irq(): sel ");
+	DBG_IRT("iosapic_enable_irq(): sel ");
 {
 	struct iosapic_info *isp = vi->iosapic;
 
 	for (d0=0x10; d0<0x1e; d0++) {
 		d1 = iosapic_read(isp->addr, d0);
-		printk(" %x", d1);
+		DBG_IRT(" %x", d1);
 	}
 }
-printk("\n");
+	DBG_IRT("\n");
 #endif
 
 	/*
@@ -738,7 +738,7 @@ int iosapic_fixup_irq(void *isi_obj, struct pci_dev *pcidev)
 	/* lookup IRT entry for isi/slot/pin set */
 	irte = iosapic_xlate_pin(isi, pcidev);
 	if (!irte) {
-		printk("iosapic: no IRTE for %s (IRQ not connected?)\n",
+		printk(KERN_NOTICE "iosapic: no IRTE for %s (IRQ not connected?)\n",
 				pci_name(pcidev));
 		return -1;
 	}
@@ -956,36 +956,33 @@ iosapic_prt_irt(void *irt, long num_entry)
 {
 	unsigned int i, *irp = (unsigned int *) irt;
 
-
-	printk(KERN_DEBUG MODULE_NAME ": Interrupt Routing Table (%lx entries)\n", num_entry);
+	DBG("Interrupt Routing Table (%lx entries)\n", num_entry);
 
 	for (i=0; i<num_entry; i++, irp += 4) {
-		printk(KERN_DEBUG "%p : %2d %.8x %.8x %.8x %.8x\n",
+		DBG("%p : %2d %.8x %.8x %.8x %.8x\n",
 					irp, i, irp[0], irp[1], irp[2], irp[3]);
 	}
 }
 
-
 static void
 iosapic_prt_vi(struct vector_info *vi)
 {
-	printk(KERN_DEBUG MODULE_NAME ": vector_info[%d] is at %p\n", vi->irqline, vi);
-	printk(KERN_DEBUG "\t\tstatus:	 %.4x\n", vi->status);
-	printk(KERN_DEBUG "\t\ttxn_irq:  %d\n",  vi->txn_irq);
-	printk(KERN_DEBUG "\t\ttxn_addr: %lx\n", vi->txn_addr);
-	printk(KERN_DEBUG "\t\ttxn_data: %lx\n", vi->txn_data);
-	printk(KERN_DEBUG "\t\teoi_addr: %p\n",  vi->eoi_addr);
-	printk(KERN_DEBUG "\t\teoi_data: %x\n",  vi->eoi_data);
+	DBG("vector_info[%d] is at %p\n", vi->irqline, vi);
+	DBG("\t\tstatus:	 %.4x\n", vi->status);
+	DBG("\t\ttxn_irq:  %d\n",  vi->txn_irq);
+	DBG("\t\ttxn_addr: %lx\n", vi->txn_addr);
+	DBG("\t\ttxn_data: %lx\n", vi->txn_data);
+	DBG("\t\teoi_addr: %p\n",  vi->eoi_addr);
+	DBG("\t\teoi_data: %x\n",  vi->eoi_data);
 }
 
-
 static void
 iosapic_prt_isi(struct iosapic_info *isi)
 {
-	printk(KERN_DEBUG MODULE_NAME ": io_sapic_info at %p\n", isi);
-	printk(KERN_DEBUG "\t\tisi_hpa:       %lx\n", isi->isi_hpa);
-	printk(KERN_DEBUG "\t\tisi_status:    %x\n", isi->isi_status);
-	printk(KERN_DEBUG "\t\tisi_version:   %x\n", isi->isi_version);
-	printk(KERN_DEBUG "\t\tisi_vector:    %p\n", isi->isi_vector);
+	DBG("io_sapic_info at %p\n", isi);
+	DBG("\t\tisi_hpa:       %lx\n", isi->isi_hpa);
+	DBG("\t\tisi_status:    %x\n", isi->isi_status);
+	DBG("\t\tisi_version:   %x\n", isi->isi_version);
+	DBG("\t\tisi_vector:    %p\n", isi->isi_vector);
 }
 #endif /* DEBUG_IOSAPIC */
-- 
2.25.1



