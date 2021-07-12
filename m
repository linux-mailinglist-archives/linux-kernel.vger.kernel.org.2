Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1AA3C6081
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhGLQ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:29:56 -0400
Received: from foss.arm.com ([217.140.110.172]:58014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234028AbhGLQ3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:29:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5566FD6E;
        Mon, 12 Jul 2021 09:26:58 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CC6A3F774;
        Mon, 12 Jul 2021 09:26:56 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v3 6/8] clk: scmi: Support atomic enable/disable API
Date:   Mon, 12 Jul 2021 17:26:23 +0100
Message-Id: <20210712162626.34705-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712162626.34705-1-cristian.marussi@arm.com>
References: <20210712162626.34705-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support enable/disable clk_ops instead of prepare/unprepare when the
underlying SCMI transport is configured to support atomic transactions for
synchronous commands.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/clk/clk-scmi.c | 44 +++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 1e357d364ca2..a07117d5e5bd 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -88,21 +88,42 @@ static void scmi_clk_disable(struct clk_hw *hw)
 	scmi_proto_clk_ops->disable(clk->ph, clk->id);
 }
 
+/*
+ * We can provide enable/disable atomic callbacks only if the underlying SCMI
+ * transport for this SCMI instance is configured to handle synchronous commands
+ * in an atomic manner.
+ *
+ * When no SCMI atomic transport support is available we instead provide the
+ * prepare/unprepare API, as allowed by the clock framework where atomic calls
+ * are not available.
+ *
+ * Note that the provided clk_ops implementations are the same in both cases,
+ * using indeed the same underlying SCMI clock_protocol operations, it's just
+ * that they are assured to act in an atomic manner or not depending on the
+ * actual underlying SCMI transport configuration.
+ *
+ * Two distinct sets of clk_ops are provided since we could have multiple SCMI
+ * instances with different underlying transport quality, so they cannot be
+ * shared.
+ */
 static const struct clk_ops scmi_clk_ops = {
 	.recalc_rate = scmi_clk_recalc_rate,
 	.round_rate = scmi_clk_round_rate,
 	.set_rate = scmi_clk_set_rate,
-	/*
-	 * We can't provide enable/disable callback as we can't perform the same
-	 * in atomic context. Since the clock framework provides standard API
-	 * clk_prepare_enable that helps cases using clk_enable in non-atomic
-	 * context, it should be fine providing prepare/unprepare.
-	 */
 	.prepare = scmi_clk_enable,
 	.unprepare = scmi_clk_disable,
 };
 
-static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
+static const struct clk_ops scmi_atomic_clk_ops = {
+	.recalc_rate = scmi_clk_recalc_rate,
+	.round_rate = scmi_clk_round_rate,
+	.set_rate = scmi_clk_set_rate,
+	.enable = scmi_clk_enable,
+	.disable = scmi_clk_disable,
+};
+
+static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
+			     const struct clk_ops *scmi_ops)
 {
 	int ret;
 	unsigned long min_rate, max_rate;
@@ -110,7 +131,7 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
 	struct clk_init_data init = {
 		.flags = CLK_GET_RATE_NOCACHE,
 		.num_parents = 0,
-		.ops = &scmi_clk_ops,
+		.ops = scmi_ops,
 		.name = sclk->info->name,
 	};
 
@@ -145,6 +166,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	struct device_node *np = dev->of_node;
 	const struct scmi_handle *handle = sdev->handle;
 	struct scmi_protocol_handle *ph;
+	bool is_atomic;
 
 	if (!handle)
 		return -ENODEV;
@@ -168,6 +190,8 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	clk_data->num = count;
 	hws = clk_data->hws;
 
+	is_atomic = handle->is_transport_atomic(handle);
+
 	for (idx = 0; idx < count; idx++) {
 		struct scmi_clk *sclk;
 
@@ -184,7 +208,9 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		sclk->id = idx;
 		sclk->ph = ph;
 
-		err = scmi_clk_ops_init(dev, sclk);
+		err = scmi_clk_ops_init(dev, sclk,
+					is_atomic ? &scmi_atomic_clk_ops :
+					&scmi_clk_ops);
 		if (err) {
 			dev_err(dev, "failed to register clock %d\n", idx);
 			devm_kfree(dev, sclk);
-- 
2.17.1

