Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A434591BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbhKVP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240078AbhKVP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:57:14 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9BDC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:54:07 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e4da:38c:79e9:48bf])
        by baptiste.telenet-ops.be with bizsmtp
        id MTu62600h4yPVd601Tu6vk; Mon, 22 Nov 2021 16:54:07 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBdu-00EL2J-Eg; Mon, 22 Nov 2021 16:54:06 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBdt-00HGq7-UQ; Mon, 22 Nov 2021 16:54:05 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] intel_th: Use bitfield helpers
Date:   Mon, 22 Nov 2021 16:54:05 +0100
Message-Id: <b1e4f027aa88acfbdfaa771b0920bd1d977828ba.1637593297.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the FIELD_{GET,PREP}() helpers, instead of open-coding the same
operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

See "[PATCH 00/17] Non-const bitfield helper conversions"
(https://lore.kernel.org/r/cover.1637592133.git.geert+renesas@glider.be)
for background and more conversions.
---
 drivers/hwtracing/intel_th/msu.c |  8 ++++----
 drivers/hwtracing/intel_th/pti.c | 13 +++++++------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 432ade0842f68724..3ee5ad18f0a61ef6 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -789,8 +790,8 @@ static int msc_configure(struct msc *msc)
 	reg &= ~(MSC_MODE | MSC_WRAPEN | MSC_EN | MSC_RD_HDR_OVRD);
 
 	reg |= MSC_EN;
-	reg |= msc->mode << __ffs(MSC_MODE);
-	reg |= msc->burst_len << __ffs(MSC_LEN);
+	reg |= FIELD_PREP(MSC_MODE, msc->mode);
+	reg |= FIELD_PREP(MSC_LEN, msc->burst_len);
 
 	if (msc->wrap)
 		reg |= MSC_WRAPEN;
@@ -1691,8 +1692,7 @@ static int intel_th_msc_init(struct msc *msc)
 	INIT_LIST_HEAD(&msc->iter_list);
 
 	msc->burst_len =
-		(ioread32(msc->reg_base + REG_MSU_MSC0CTL) & MSC_LEN) >>
-		__ffs(MSC_LEN);
+		FIELD_GET(MSC_LEN, ioread32(msc->reg_base + REG_MSU_MSC0CTL));
 
 	return 0;
 }
diff --git a/drivers/hwtracing/intel_th/pti.c b/drivers/hwtracing/intel_th/pti.c
index 09132ab8bc23265a..eadc236ec43e0ad3 100644
--- a/drivers/hwtracing/intel_th/pti.c
+++ b/drivers/hwtracing/intel_th/pti.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -152,12 +153,12 @@ static int intel_th_pti_activate(struct intel_th_device *thdev)
 	u32 ctl = PTI_EN;
 
 	if (pti->patgen)
-		ctl |= pti->patgen << __ffs(PTI_PATGENMODE);
+		ctl |= FIELD_PREP(PTI_PATGENMODE, pti->patgen);
 	if (pti->freeclk)
 		ctl |= PTI_FCEN;
-	ctl |= pti->mode << __ffs(PTI_MODE);
-	ctl |= pti->clkdiv << __ffs(PTI_CLKDIV);
-	ctl |= pti->lpp_dest << __ffs(LPP_DEST);
+	ctl |= FIELD_PREP(PTI_MODE, pti->mode);
+	ctl |= FIELD_PREP(PTI_CLKDIV, pti->clkdiv);
+	ctl |= FIELD_PREP(LPP_DEST, pti->lpp_dest);
 
 	iowrite32(ctl, pti->base + REG_PTI_CTL);
 
@@ -179,8 +180,8 @@ static void read_hw_config(struct pti_device *pti)
 {
 	u32 ctl = ioread32(pti->base + REG_PTI_CTL);
 
-	pti->mode	= (ctl & PTI_MODE) >> __ffs(PTI_MODE);
-	pti->clkdiv	= (ctl & PTI_CLKDIV) >> __ffs(PTI_CLKDIV);
+	pti->mode	= FIELD_GET(PTI_MODE, ctl);
+	pti->clkdiv	= FIELD_GET(PTI_CLKDIV, ctl);
 	pti->freeclk	= !!(ctl & PTI_FCEN);
 
 	if (!pti_mode[pti->mode])
-- 
2.25.1

