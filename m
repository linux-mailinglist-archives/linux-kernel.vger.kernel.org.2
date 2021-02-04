Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4CA30CEB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhBBWWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:22:11 -0500
Received: from foss.arm.com ([217.140.110.172]:58466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234929AbhBBWSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:18:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C3E01595;
        Tue,  2 Feb 2021 14:17:16 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 394943F694;
        Tue,  2 Feb 2021 14:17:14 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v6 19/37] clk: scmi: port driver to the new scmi_clk_proto_ops interface
Date:   Tue,  2 Feb 2021 22:15:37 +0000
Message-Id: <20210202221555.41167-20-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202221555.41167-1-cristian.marussi@arm.com>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port driver to the new SCMI Clock interface based on protocol handles
and common devm_get_ops().

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- using renamed devm_get/put_protocol
---
 drivers/clk/clk-scmi.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index c754dfbb73fd..f3da3042d09c 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Power Interface (SCMI) Protocol based clock driver
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2020 ARM Ltd.
  */
 
 #include <linux/clk-provider.h>
@@ -13,11 +13,13 @@
 #include <linux/scmi_protocol.h>
 #include <asm/div64.h>
 
+static const struct scmi_clk_proto_ops *clk_ops;
+
 struct scmi_clk {
 	u32 id;
 	struct clk_hw hw;
 	const struct scmi_clock_info *info;
-	const struct scmi_handle *handle;
+	const struct scmi_protocol_handle *ph;
 };
 
 #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
@@ -29,7 +31,7 @@ static unsigned long scmi_clk_recalc_rate(struct clk_hw *hw,
 	u64 rate;
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	ret = clk->handle->clk_ops->rate_get(clk->handle, clk->id, &rate);
+	ret = clk_ops->rate_get(clk->ph, clk->id, &rate);
 	if (ret)
 		return 0;
 	return rate;
@@ -69,21 +71,21 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	return clk->handle->clk_ops->rate_set(clk->handle, clk->id, rate);
+	return clk_ops->rate_set(clk->ph, clk->id, rate);
 }
 
 static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	return clk->handle->clk_ops->enable(clk->handle, clk->id);
+	return clk_ops->enable(clk->ph, clk->id);
 }
 
 static void scmi_clk_disable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	clk->handle->clk_ops->disable(clk->handle, clk->id);
+	clk_ops->disable(clk->ph, clk->id);
 }
 
 static const struct clk_ops scmi_clk_ops = {
@@ -142,11 +144,16 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_protocol_handle *ph;
 
-	if (!handle || !handle->clk_ops)
+	if (!handle)
 		return -ENODEV;
 
-	count = handle->clk_ops->count_get(handle);
+	clk_ops = handle->devm_get_protocol(sdev, SCMI_PROTOCOL_CLOCK, &ph);
+	if (IS_ERR(clk_ops))
+		return PTR_ERR(clk_ops);
+
+	count = clk_ops->count_get(ph);
 	if (count < 0) {
 		dev_err(dev, "%pOFn: invalid clock output count\n", np);
 		return -EINVAL;
@@ -167,14 +174,14 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		if (!sclk)
 			return -ENOMEM;
 
-		sclk->info = handle->clk_ops->info_get(handle, idx);
+		sclk->info = clk_ops->info_get(ph, idx);
 		if (!sclk->info) {
 			dev_dbg(dev, "invalid clock info for idx %d\n", idx);
 			continue;
 		}
 
 		sclk->id = idx;
-		sclk->handle = handle;
+		sclk->ph = ph;
 
 		err = scmi_clk_ops_init(dev, sclk);
 		if (err) {
-- 
2.17.1

