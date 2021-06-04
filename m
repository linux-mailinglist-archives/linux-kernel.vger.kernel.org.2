Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58AC39B9F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhFDNhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFDNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:37:04 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59731C0619F6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 06:35:18 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 18070C800BF;
        Fri,  4 Jun 2021 15:35:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id D_sbqGfmdHEP; Fri,  4 Jun 2021 15:35:16 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37f2E2A0038B625c68b541A92.dip0.t-ipconnect.de [IPv6:2003:e3:7f2e:2a00:38b6:25c6:8b54:1a92])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id D3747C800BE;
        Fri,  4 Jun 2021 15:35:16 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     linux-kernel@vger.kernel.org
Cc:     Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH] typo: Fix typo "softare" in documentation and several comments
Date:   Fri,  4 Jun 2021 15:35:12 +0200
Message-Id: <20210604133512.7402-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I stumbled above the "softare" instead of "software" typo in the kernel docs
about the drm subsystem and fixed it everywhere.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 arch/alpha/kernel/osf_sys.c                   | 4 ++--
 arch/arc/include/asm/pgtable.h                | 2 +-
 drivers/gpu/drm/drm_mode_object.c             | 2 +-
 drivers/mtd/nand/raw/arasan-nand-controller.c | 2 +-
 drivers/net/ethernet/micrel/ks8842.c          | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index d5367a1c6300..d31167e3269c 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -834,7 +834,7 @@ SYSCALL_DEFINE5(osf_setsysinfo, unsigned long, op, void __user *, buffer,
 			return -EFAULT;
 		state = &current_thread_info()->ieee_state;
 
-		/* Update softare trap enable bits.  */
+		/* Update software trap enable bits.  */
 		*state = (*state & ~IEEE_SW_MASK) | (swcr & IEEE_SW_MASK);
 
 		/* Update the real fpcr.  */
@@ -854,7 +854,7 @@ SYSCALL_DEFINE5(osf_setsysinfo, unsigned long, op, void __user *, buffer,
 		state = &current_thread_info()->ieee_state;
 		exc &= IEEE_STATUS_MASK;
 
-		/* Update softare trap enable bits.  */
+		/* Update software trap enable bits.  */
  		swcr = (*state & IEEE_SW_MASK) | exc;
 		*state |= exc;
 
diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 5878846f00cf..1e2b890dcea5 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -40,7 +40,7 @@
 /**************************************************************************
  * Page Table Flags
  *
- * ARC700 MMU only deals with softare managed TLB entries.
+ * ARC700 MMU only deals with software managed TLB entries.
  * Page Tables are purely for Linux VM's consumption and the bits below are
  * suited to that (uniqueness). Hence some are not implemented in the TLB and
  * some have different value in TLB.
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index b26588b52795..e2fd95914d49 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -328,7 +328,7 @@ static int __drm_object_property_get_value(struct drm_mode_object *obj,
  * @property: property to retrieve
  * @val: storage for the property value
  *
- * This function retrieves the softare state of the given property for the given
+ * This function retrieves the software state of the given property for the given
  * property. Since there is no driver callback to retrieve the current property
  * value this might be out of sync with the hardware, depending upon the driver
  * and property.
diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index 549aac00228e..4e7b65e93559 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -351,7 +351,7 @@ static int anfc_read_page_hw_ecc(struct nand_chip *chip, u8 *buf,
 		return ret;
 
 	/*
-	 * For each step, compute by softare the BCH syndrome over the raw data.
+	 * For each step, compute by software the BCH syndrome over the raw data.
 	 * Compare the theoretical amount of errors and compare with the
 	 * hardware engine feedback.
 	 */
diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index caa251d0e381..6c5f6a4763fe 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -242,7 +242,7 @@ static void ks8842_reset(struct ks8842_adapter *adapter)
 		msleep(10);
 		iowrite16(0, adapter->hw_addr + REG_GRR);
 	} else {
-		/* The KS8842 goes haywire when doing softare reset
+		/* The KS8842 goes haywire when doing software reset
 		* a work around in the timberdale IP is implemented to
 		* do a hardware reset instead
 		ks8842_write16(adapter, 3, 1, REG_GRR);
-- 
2.25.1

