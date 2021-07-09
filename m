Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1ABB3C2826
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhGIRTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIRTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:19:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2069C0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:16:31 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i125so9997816qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdqIsV//Q4vhJs3qwgiDVZoj0NjhNPqIuJo+SfgNN5E=;
        b=TAlD3h0Im6oRi7XhTmQC0eClIgZH/AeAzBPrYhIQQ5ilawAhT7ql0UURAoT+NJxQpk
         tGSEufuGbYBFlTpakA8lgpnTFqI+GIc3tlxlVmAqsuGMqt2/u7sBmO3JfF+EK3b5HE9M
         I7k1gsGWz4kJaXtbl/rzcEkocLD9HBrfuNUFruGplVyJnx9A+/UiOpE5URliu2BG8ZvL
         akUKay7dIp5uEol0vP9ChsFPrb96hhlj+032j6W9nSOL3J/BujW4cSrVq1H1lMP5wYxV
         ozvD1Z9q79+9E2kXYnIVV3m3U+Xobi1aeXnSFad4G7+TOEQ8rY7aBTp363pw/AcmWmxI
         ND9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MdqIsV//Q4vhJs3qwgiDVZoj0NjhNPqIuJo+SfgNN5E=;
        b=q/KFf5TK+KDPAoQqRs8pPyxGAiu/f69qoO1nl4A6ZSXp1nQV+CbfrcytUnEn5RruPW
         EiL770Uvhue+ckHl7fgy6sfb5HPc4L0YOJCB8v6KPYE8L3cAopLtnt9UbYLAbtzLQNLB
         zdNUZufLSTGgxz/nGbBjpuxdeQTvteVIYN8qrOBbCRYsEaf7XuY/08BgqNqq5n+VnGRo
         gq7y8IxokP2WUExXcXtGD12QYXBLX1CxcRAHpQ4/xe6xoNQU/wzXLaGGVKk1NVYN9Gx3
         pzLZNHOEC9LhmjmAPpSN7sUB3PN2zxD29I3hSW88OHOMAgImvhlkvPKCstKIuWz5AahF
         gyHA==
X-Gm-Message-State: AOAM532Lw66K0e0ARDYifeKTv6MxUvpv707v2Hf4bNcAH9LF/ioGJ9bq
        RXZsEgE9d2GVvWZW4eAexp899A==
X-Google-Smtp-Source: ABdhPJx4XhSYY1fX8BE1I2uYoy8RZqDwkjMG1/VvQr3Rih4LbRvhls5nPGrikOhqFYldN3nmree9Hg==
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr14782898qka.297.1625850990816;
        Fri, 09 Jul 2021 10:16:30 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id y20sm2719483qkm.5.2021.07.09.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:16:30 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     James.Bottomley@hansenpartnership.com,
        Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     deller@gmx.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1.1] drivers: parisc: Update iosapic driver with proper printks
Date:   Fri, 09 Jul 2021 13:16:29 -0400
Message-ID: <5526022.DvuYhMxLoT@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <7261873.EvYhyI6sBW@daneel.sf-tec.de>
References: <5760611.lOV4Wx5bFT@iron-maiden> <7261873.EvYhyI6sBW@daneel.sf-tec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code from the old I/O Sapic Driver is outdated when it comes to printks. Fix
applying proper indentation and using pr_debug() instead of printk on debugging
blocks. Also add a KERN_<LEVEL> where it is missing.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
Changelog: Replace dev_dbg() for pr_debug()
---
 drivers/parisc/iosapic.c | 65 +++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 8a3b0c3a1e92..5bfbca3f5756 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -124,6 +124,7 @@
 */
 
 #include <linux/pci.h>
+#include <linux/printk.h>
 
 #include <asm/pdc.h>
 #include <asm/pdcpat.h>
@@ -141,18 +142,17 @@
 #undef DEBUG_IOSAPIC
 #undef DEBUG_IOSAPIC_IRT
 
-
 #ifdef DEBUG_IOSAPIC
-#define DBG(x...) printk(x)
-#else /* DEBUG_IOSAPIC */
+#define DBG(x...) pr_debug(x)
+#else /* !DEBUG_IOSAPIC */
 #define DBG(x...)
-#endif /* DEBUG_IOSAPIC */
+#endif /* !DEBUG_IOSAPIC */
 
 #ifdef DEBUG_IOSAPIC_IRT
-#define DBG_IRT(x...) printk(x)
-#else
+#define DBG_IRT(x...) pr_debug(x)
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



