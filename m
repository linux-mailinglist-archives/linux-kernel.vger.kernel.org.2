Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7108A4591C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbhKVP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbhKVP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:57:18 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B80BC061746
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:54:10 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e4da:38c:79e9:48bf])
        by xavier.telenet-ops.be with bizsmtp
        id MTu92600q4yPVd601Tu9GX; Mon, 22 Nov 2021 16:54:10 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBdx-00EL2z-M5; Mon, 22 Nov 2021 16:54:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBdx-00HGv8-8E; Mon, 22 Nov 2021 16:54:09 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] regulator: lp873x: Use bitfield helpers
Date:   Mon, 22 Nov 2021 16:54:08 +0100
Message-Id: <44d60384b640c8586b4ca7edbc9287a34ce21c5b.1637593297.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the FIELD_PREP() helper, instead open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

See "[PATCH 00/17] Non-const bitfield helper conversions"
(https://lore.kernel.org/r/cover.1637592133.git.geert+renesas@glider.be)
for background and more conversions.
---
 drivers/regulator/lp873x-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index c38387e0fbb2a33d..f1f5be7b54cd9e90 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -13,6 +13,7 @@
  * GNU General Public License version 2 for more details.
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -101,7 +102,7 @@ static int lp873x_buck_set_ramp_delay(struct regulator_dev *rdev,
 
 	ret = regmap_update_bits(lp873->regmap, regulators[id].ctrl2_reg,
 				 LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE,
-				 reg << __ffs(LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE));
+				 FIELD_PREP(LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE, reg));
 	if (ret) {
 		dev_err(lp873->dev, "SLEW RATE write failed: %d\n", ret);
 		return ret;
-- 
2.25.1

