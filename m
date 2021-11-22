Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E074458DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbhKVLzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:55:04 -0500
Received: from comms.puri.sm ([159.203.221.185]:43756 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238242AbhKVLzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:55:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 545DCE13E7;
        Mon, 22 Nov 2021 03:51:57 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AKUhHz9mPKVs; Mon, 22 Nov 2021 03:51:56 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     peng.fan@nxp.com, l.stach@pengutronix.de, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] soc: imx: gpcv2: avoid unbalanced powering off during system suspend
Date:   Mon, 22 Nov 2021 12:51:45 +0100
Message-Id: <20211122115145.177196-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I don't yet sign-off on this - I'm not sure whether this works around
a probem in the power domain (or regulator?) core:

When tranisioning to system sleep on imx8mq I see the following errors
(and resuming doesn't succeed):

[ 2594.505465] ldo5: Underflow of regulator enable count
[ 2594.524045] imx-pgc imx-pgc-domain.0: failed to disable regulator: -22
[ 2594.531352] imx-pgc imx-pgc-domain.5: failed to disable regulator: -5
[ 2594.547119] imx-pgc imx-pgc-domain.6: failed to disable regulator: -5

So I started debugging the "ldo5" regulator that is the power-supply for
the imx8mq mipi power domain "0" (on the imx8mq-librem5 board).

During runtime-pm only, things are fine. When transitioning to system
suspend, I at least see genpd_power_off() executing after the
"System suspend is in progress" check, where it's supposed to have returned
early already (due to genpd->prepared_count > 0). That leads to the
unbalance power-off.

While this patch "fixes" my problem, where is the root cause of this?
Thank you for your help in this!

so long,
                                martin
---
 drivers/soc/imx/gpcv2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index b8d52d8d29db..4b1b9176127f 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -318,6 +318,9 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 	u32 reg_val, pgc;
 	int ret;
 
+	if (pm_runtime_suspended(domain->dev))
+		return 0;
+
 	/* Enable reset clocks for all devices in the domain */
 	if (!domain->keep_clocks) {
 		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
-- 
2.30.2

