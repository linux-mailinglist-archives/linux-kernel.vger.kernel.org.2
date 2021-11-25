Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74145E098
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhKYSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhKYSjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:39:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63903C061746
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:36:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u3so18393761lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/hYrpWcR7hkT9RyMUp0r6OTrQvNhufATqdxs3bjp28=;
        b=RfBwrAKXDleQkhqaKStgQWxp2ObDrwiJxx/qH6SGAmWyAz3vY6uHN+x0TooQd6Tlvv
         AMYekAbHUYCyQnZ0AMKkRSa5R17YfSKB2tfTM4cBVelvbLtN+CnXA6kEId5W0LgkVTLj
         n/BA1iF8Yz5a+wx8mjTeBxD94TKL45rBEaWkmM9byCzefmLZja+y5kdGU1PgNwwaHh3n
         arxRY5BmSoz+GFHT0AegGb8QgAf04S6VS3ay+LBrS/wMGQbRnmoBZDkLA4K3AplQLUkn
         OfWVlKcPjvhkJwTseiTr2pzzYfEqGIW9wOEKYT2iaG8La7u6VyC1+Bm9AeibVPXevecn
         mOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/hYrpWcR7hkT9RyMUp0r6OTrQvNhufATqdxs3bjp28=;
        b=EIG8WA0Gn6rsjxkb+hF2zfHKDTrSgTCChBOxZp1MciyF4kF2LUMnDfuhfJouTvWrDx
         +HxC/0LMJjTC3GFzD4hwpWOtS7Q6d7lMzrlPeiTpkkX+zkgrwmZaMWngIQvs2F1xg6nh
         0BLvH6XQJttTEa1PdCIRCESqmtCPFvqxhv/L6a4+JX4Iwi9nRTtM+yFOza3d8fBO+f0+
         cIrMD6kESDPVx6dzgsV8MMhpWNpJ68c9FJpPbmEWN0ONKJiF95+X2CI4RUWZ3275JanV
         9W7mxPu/ugxjtpEAQoAceJywVPFz/QSM/yLqx8Q1O4O5fBSsK81LjF5+rZQ0ept1XuvL
         Mucg==
X-Gm-Message-State: AOAM532CC+BIqJYc5+NohcKVGEtcwd3fTLRYYLqA2IwVUzMUcE2jtpUM
        pck43bxUVSal994h9LbzLFZYZg==
X-Google-Smtp-Source: ABdhPJwDwT+UD3vLszlywLwIrDj28PcmA2v5rzaaWa6yRCGqCO0Ol3pDaK8+vxvad1Ksv4KeJ9z7EQ==
X-Received: by 2002:a05:6512:3127:: with SMTP id p7mr25718884lfd.57.1637865383640;
        Thu, 25 Nov 2021 10:36:23 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s15sm300353ljj.14.2021.11.25.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 10:36:23 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH] of: property: do not create clocks device link for clock controllers
Date:   Thu, 25 Nov 2021 21:36:22 +0300
Message-Id: <20211125183622.597177-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not create device link for clock controllers. Some of the clocks
provided to the device via OF can be the clocks that are just parents to
the clocks provided by this clock controller. Clock subsystem already
has support for handling missing clock parents correctly (clock
orphans). Later when the parent clock is registered, clocks get
populated properly.

An example of the system where this matters is the SDM8450 MTP board
(see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
dispcc itself provides clocks to both PHYs, to the PHY parent device,
etc. With just dsi0_phy in place devlink is able to break the
dependency, but with two PHYs, dispcc doesn't get probed at all, thus
breaking display support.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/of/property.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index a3483484a5a2..f7229e4030e3 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1264,7 +1264,6 @@ struct supplier_bindings {
 	bool node_not_dev;
 };
 
-DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
 DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
@@ -1294,6 +1293,21 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
+static struct device_node *parse_clocks(struct device_node *np,
+					const char *prop_name, int index)
+{
+	/*
+	 * Do not create clock-related device links for clocks controllers,
+	 * clock orphans will handle missing clock parents automatically.
+	 */
+	if (!strcmp(prop_name, "clocks") &&
+	    of_find_property(np, "#clock-cells", NULL))
+		return NULL;
+
+	return parse_prop_cells(np, prop_name, index, "clocks",
+				       "#clock-cells");
+}
+
 static struct device_node *parse_gpios(struct device_node *np,
 				       const char *prop_name, int index)
 {
-- 
2.33.0

