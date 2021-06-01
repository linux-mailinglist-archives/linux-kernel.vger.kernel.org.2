Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58BC3937D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 23:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhE0VSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 17:18:42 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:56902 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233629AbhE0VSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 17:18:41 -0400
Received: from [77.244.183.192] (port=63784 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lmNNJ-00062h-WA; Thu, 27 May 2021 23:17:06 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH RESEND] clk: vc5: fix output disabling when enabling a FOD
Date:   Thu, 27 May 2021 23:16:47 +0200
Message-Id: <20210527211647.1520720-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5P49V6965, when an output is enabled we enable the corresponding
FOD. When this happens for the first time, and specifically when writing
register VC5_OUT_DIV_CONTROL in vc5_clk_out_prepare(), all other outputs
are stopped for a short time and then restarted.

According to Renesas support this is intended: "The reason for that is VC6E
has synced up all output function".

This behaviour can be disabled at least on VersaClock 6E devices, of which
only the 5P49V6965 is currently implemented by this driver. This requires
writing bit 7 (bypass_sync{1..4}) in register 0x20..0x50.  Those registers
are named "Unused Factory Reserved Register", and the bits are documented
as "Skip VDDO<N> verification", which does not clearly explain the relation
to FOD sync. However according to Renesas support as well as my testing
setting this bit does prevent disabling of all clock outputs when enabling
a FOD.

See "VersaClock ® 6E Family Register Descriptions and Programming Guide"
(August 30, 2018), Table 116 "Power Up VDD check", page 58:
https://www.renesas.com/us/en/document/mau/versaclock-6e-family-register-descriptions-and-programming-guide

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Adam Ford <aford173@gmail.com>

---

Changes v1 -> v2:
 - add Adam's Reviewed-by tag
---
 drivers/clk/clk-versaclock5.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 344cd6c61188..3c737742c2a9 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -69,7 +69,10 @@
 #define VC5_FEEDBACK_FRAC_DIV(n)		(0x19 + (n))
 #define VC5_RC_CONTROL0				0x1e
 #define VC5_RC_CONTROL1				0x1f
-/* Register 0x20 is factory reserved */
+
+/* These registers are named "Unused Factory Reserved Registers" */
+#define VC5_RESERVED_X0(idx)		(0x20 + ((idx) * 0x10))
+#define VC5_RESERVED_X0_BYPASS_SYNC	BIT(7) /* bypass_sync<idx> bit */
 
 /* Output divider control for divider 1,2,3,4 */
 #define VC5_OUT_DIV_CONTROL(idx)	(0x21 + ((idx) * 0x10))
@@ -87,7 +90,6 @@
 #define VC5_OUT_DIV_SKEW_INT(idx, n)	(0x2b + ((idx) * 0x10) + (n))
 #define VC5_OUT_DIV_INT(idx, n)		(0x2d + ((idx) * 0x10) + (n))
 #define VC5_OUT_DIV_SKEW_FRAC(idx)	(0x2f + ((idx) * 0x10))
-/* Registers 0x30, 0x40, 0x50 are factory reserved */
 
 /* Clock control register for clock 1,2 */
 #define VC5_CLK_OUTPUT_CFG(idx, n)	(0x60 + ((idx) * 0x2) + (n))
@@ -140,6 +142,8 @@
 #define VC5_HAS_INTERNAL_XTAL	BIT(0)
 /* chip has PFD requency doubler */
 #define VC5_HAS_PFD_FREQ_DBL	BIT(1)
+/* chip has bits to disable FOD sync */
+#define VC5_HAS_BYPASS_SYNC_BIT	BIT(2)
 
 /* Supported IDT VC5 models. */
 enum vc5_model {
@@ -581,6 +585,23 @@ static int vc5_clk_out_prepare(struct clk_hw *hw)
 	unsigned int src;
 	int ret;
 
+	/*
+	 * When enabling a FOD, all currently enabled FODs are briefly
+	 * stopped in order to synchronize all of them. This causes a clock
+	 * disruption to any unrelated chips that might be already using
+	 * other clock outputs. Bypass the sync feature to avoid the issue,
+	 * which is possible on the VersaClock 6E family via reserved
+	 * registers.
+	 */
+	if (vc5->chip_info->flags & VC5_HAS_BYPASS_SYNC_BIT) {
+		ret = regmap_update_bits(vc5->regmap,
+					 VC5_RESERVED_X0(hwdata->num),
+					 VC5_RESERVED_X0_BYPASS_SYNC,
+					 VC5_RESERVED_X0_BYPASS_SYNC);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * If the input mux is disabled, enable it first and
 	 * select source from matching FOD.
@@ -1166,7 +1187,7 @@ static const struct vc5_chip_info idt_5p49v6965_info = {
 	.model = IDT_VC6_5P49V6965,
 	.clk_fod_cnt = 4,
 	.clk_out_cnt = 5,
-	.flags = 0,
+	.flags = VC5_HAS_BYPASS_SYNC_BIT,
 };
 
 static const struct i2c_device_id vc5_id[] = {
-- 
2.25.1

