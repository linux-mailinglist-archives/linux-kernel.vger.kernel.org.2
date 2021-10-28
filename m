Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E89F43DCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJ1IMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 04:12:00 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220]:60313
        "HELO zg8tmtyylji0my4xnjeumjiw.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229800AbhJ1IL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:11:59 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Oct 2021 04:11:58 EDT
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwAHK8scWXphBj+iBA--.25690S2;
        Thu, 28 Oct 2021 16:02:36 +0800 (CST)
Received: from centos7.localdomain (unknown [202.43.158.76])
        by mail (Coremail) with SMTP id AQAAfwCXstT9WHphqBgAAA--.143S2;
        Thu, 28 Oct 2021 16:02:06 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc:     daizhiyuan@phytium.com.cn, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/gic-v3: Fix EOImode semantics in git_cpu_sys_reg_init()
Date:   Thu, 28 Oct 2021 04:01:31 -0400
Message-Id: <1635408092-5259-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAfwCXstT9WHphqBgAAA--.143S2
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=daizhiyuan
        @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kr48CF4DCryUur1fKr18AFb_yoW8uF45pr
        WrCayfG343Ga4UGr9Y9w17Za45G39rCFWav3y0gr17Xr95Gas7JF4kJay7Wr93JrW0yr1U
        ZFsIqry3WrW7ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICC_CTLR_EL1 is a 64-bit register.EOImode, bit [1] EOI mode
for the current Security state.

current code semantics is set ICC_CTLR_EL1 register to zero.
This patch only set the EOImode Bit to zero.

refs: See Arm IHI 0069G, page 12-229.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 drivers/irqchip/irq-gic-v3.c       | 9 +++++++--
 include/linux/irqchip/arm-gic-v3.h | 3 +--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd4e9a3..96466fc0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -967,6 +967,7 @@ static void gic_cpu_sys_reg_init(void)
 	u64 need_rss = MPIDR_RS(mpidr);
 	bool group0;
 	u32 pribits;
+	u32 val;
 
 	/*
 	 * Need to check that the SRE bit has actually been set. If
@@ -1009,12 +1010,16 @@ static void gic_cpu_sys_reg_init(void)
 	 */
 	gic_write_bpr1(0);
 
+	val = gic_read_ctlr();
+
 	if (static_branch_likely(&supports_deactivate_key)) {
 		/* EOI drops priority only (mode 1) */
-		gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop);
+		val |= ICC_CTLR_EL1_EOImode;
+		gic_write_ctlr(val);
 	} else {
 		/* EOI deactivates interrupt too (mode 0) */
-		gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop_dir);
+		val &= ~ICC_CTLR_EL1_EOImode;
+		gic_write_ctlr(val);
 	}
 
 	/* Always whack Group0 before Group1 */
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 81cbf85..1a35b24 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -544,8 +544,7 @@
  * CPU interface registers
  */
 #define ICC_CTLR_EL1_EOImode_SHIFT	(1)
-#define ICC_CTLR_EL1_EOImode_drop_dir	(0U << ICC_CTLR_EL1_EOImode_SHIFT)
-#define ICC_CTLR_EL1_EOImode_drop	(1U << ICC_CTLR_EL1_EOImode_SHIFT)
+#define ICC_CTLR_EL1_EOImode	(1U << ICC_CTLR_EL1_EOImode_SHIFT)
 #define ICC_CTLR_EL1_EOImode_MASK	(1 << ICC_CTLR_EL1_EOImode_SHIFT)
 #define ICC_CTLR_EL1_CBPR_SHIFT		0
 #define ICC_CTLR_EL1_CBPR_MASK		(1 << ICC_CTLR_EL1_CBPR_SHIFT)
-- 
1.8.3.1

