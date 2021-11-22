Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29214591C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbhKVP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbhKVP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:57:18 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D1DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:54:11 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e4da:38c:79e9:48bf])
        by andre.telenet-ops.be with bizsmtp
        id MTu92600k4yPVd601Tu9PK; Mon, 22 Nov 2021 16:54:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBdx-00EL2n-8o; Mon, 22 Nov 2021 16:54:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBdw-00HGtn-HG; Mon, 22 Nov 2021 16:54:08 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mfd: mc13xxx: Use bitfield helpers
Date:   Mon, 22 Nov 2021 16:54:07 +0100
Message-Id: <afa46868cf8c1666e9cbbbec42767ca2294b024d.1637593297.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the FIELD_GET() helper, instead of defining a custom macro
implementing the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

See "[PATCH 00/17] Non-const bitfield helper conversions"
(https://lore.kernel.org/r/cover.1637592133.git.geert+renesas@glider.be)
for background and more conversions.
---
 drivers/mfd/mc13xxx-core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 8a4f1d90dcfd1c33..a9b7cf23c9079882 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -7,6 +7,7 @@
  * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -174,28 +175,27 @@ int mc13xxx_irq_free(struct mc13xxx *mc13xxx, int irq, void *dev)
 }
 EXPORT_SYMBOL(mc13xxx_irq_free);
 
-#define maskval(reg, mask)	(((reg) & (mask)) >> __ffs(mask))
 static void mc13xxx_print_revision(struct mc13xxx *mc13xxx, u32 revision)
 {
 	dev_info(mc13xxx->dev, "%s: rev: %d.%d, "
 			"fin: %d, fab: %d, icid: %d/%d\n",
 			mc13xxx->variant->name,
-			maskval(revision, MC13XXX_REVISION_REVFULL),
-			maskval(revision, MC13XXX_REVISION_REVMETAL),
-			maskval(revision, MC13XXX_REVISION_FIN),
-			maskval(revision, MC13XXX_REVISION_FAB),
-			maskval(revision, MC13XXX_REVISION_ICID),
-			maskval(revision, MC13XXX_REVISION_ICIDCODE));
+			FIELD_GET(MC13XXX_REVISION_REVFULL, revision),
+			FIELD_GET(MC13XXX_REVISION_REVMETAL, revision),
+			FIELD_GET(MC13XXX_REVISION_FIN, revision),
+			FIELD_GET(MC13XXX_REVISION_FAB, revision),
+			FIELD_GET(MC13XXX_REVISION_ICID, revision),
+			FIELD_GET(MC13XXX_REVISION_ICIDCODE, revision));
 }
 
 static void mc34708_print_revision(struct mc13xxx *mc13xxx, u32 revision)
 {
 	dev_info(mc13xxx->dev, "%s: rev %d.%d, fin: %d, fab: %d\n",
 			mc13xxx->variant->name,
-			maskval(revision, MC34708_REVISION_REVFULL),
-			maskval(revision, MC34708_REVISION_REVMETAL),
-			maskval(revision, MC34708_REVISION_FIN),
-			maskval(revision, MC34708_REVISION_FAB));
+			FIELD_GET(MC34708_REVISION_REVFULL, revision),
+			FIELD_GET(MC34708_REVISION_REVMETAL, revision),
+			FIELD_GET(MC34708_REVISION_FIN, revision),
+			FIELD_GET(MC34708_REVISION_FAB, revision));
 }
 
 /* These are only exported for mc13xxx-i2c and mc13xxx-spi */
-- 
2.25.1

