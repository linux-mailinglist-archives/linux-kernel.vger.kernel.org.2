Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4572C4040C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 23:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhIHV7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 17:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhIHV7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 17:59:19 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B840C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 14:58:11 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id o4-20020ae9f504000000b003d39d97b227so6845658qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=x+U5iWmPoc1LfbS98FFnjN/NqYTsrrmBn1Md/SAIYso=;
        b=Tb2pIUbrz/LJACHHduVCMRoPRDcBFoGHjznQXviGDyrNSpLai7hvOZ6dpLnVy5eNcv
         WXnuQGKUwQySu76yuzPsNaaK9tZXW8W9gBfc4vE0gnfDuU4xcxEZlbaQQ76vA/elMYpN
         EEoQDvOLEOMSGwQWXYzzh3vRBW3gfLm1Z1t+JBcOQ7I/b1zE04OXmc4qMiCmIB9cfPvs
         v5d7Q6A+5/iYS1O27OFKVNJVEaGh8VyayIob16RTd8gD6Y9a57H33xvGDnttaGSrEtXr
         nZEGAFQ7SKCLFViPYFXu3mP8YfvzFbF2/ojkF5oM1hdgr8F4TGi948uSkJwcfKIH2csH
         HL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=x+U5iWmPoc1LfbS98FFnjN/NqYTsrrmBn1Md/SAIYso=;
        b=kQLph+9CmgHzXP62OkQVYUtW/6dDApUBTgwm21NFUv4jVVxBW+u8Cj0Bc+g6wA27bw
         4lz20WDIQctpUx5mZy3EtyIDzqM4aqKgGuPxyDN3mEslyt/epDY7DnUKG1bZjydLahQv
         wVE9kG8JJvpmJdIqNXnXniQSyTTZ99Lsm49w1apHzbqqTa7ACbVtfFZKnCdhMPESsPsh
         sj5MsbISDFY2JFpiFeLkjy1QnhNm5/Az4JIIZ1umOut1UheZfdR2zb2BAE3qPx7JmAMh
         S/UHEWl/ltzs8S4Aa5KSZHEEjeKxSJO/6scwYW7r9Dhr5gljSr7HA+rdX+eb9Ttz5veB
         ma0Q==
X-Gm-Message-State: AOAM530lVNEemiELlahW6hFshqNO721QhoJX0YWVGFq/rWXiTl2lgcui
        SG5zwGHji30yyc87dQPBpNJsewcMnyzb4UQ=
X-Google-Smtp-Source: ABdhPJxe3ydz2tSxy7UkERAnDMDXfIJdVm9ByjH+6b1kkjTXPwmcS0WxbSSXtEAf2PYqOxWMPlnuCpLTG48LELI=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:de29:dab5:94d3:3388])
 (user=saravanak job=sendgmr) by 2002:a05:6214:20eb:: with SMTP id
 11mr497044qvk.52.1631138290824; Wed, 08 Sep 2021 14:58:10 -0700 (PDT)
Date:   Wed,  8 Sep 2021 14:58:06 -0700
In-Reply-To: <2023d07e-18bb-e129-760a-18b17ff772cd@samsung.com>
Message-Id: <20210908215806.2748361-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1] RFC: of: property: fix phy-hanlde issue
From:   Saravana Kannan <saravanak@google.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a test patch. I'll split it up into multiple commits and clean
it up once it's shown to help.

Marek, can you please test this and let me know if it helps?

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 76 ++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 0c0dc2e369c0..039e1cb07348 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -30,6 +30,35 @@
 
 #include "of_private.h"
 
+/**
+ * struct supplier_bindings - Property parsing functions for suppliers
+ *
+ * @parse_prop: function name
+ *	parse_prop() finds the node corresponding to a supplier phandle
+ * @parse_prop.np: Pointer to device node holding supplier phandle property
+ * @parse_prop.prop_name: Name of property holding a phandle value
+ * @parse_prop.index: For properties holding a list of phandles, this is the
+ *		      index into the list
+ * @optional: Describes whether a supplier is mandatory or not
+ * @node_not_dev: The consumer node containing the property is never a device.
+ * @sup_node_always_dev: The supplier node pointed to by the property will
+ *			 always have a struct device created for it even if it
+ *			 doesn't have a "compatible" property.
+ *
+ * Returns:
+ * parse_prop() return values are
+ * - phandle node pointer with refcount incremented. Caller must of_node_put()
+ *   on it when done.
+ * - NULL if no phandle found at index
+ */
+struct supplier_bindings {
+	struct device_node *(*parse_prop)(struct device_node *np,
+					  const char *prop_name, int index);
+	bool optional;
+	bool node_not_dev;
+	bool sup_node_always_dev;
+};
+
 /**
  * of_graph_is_present() - check graph's presence
  * @node: pointer to device_node containing graph port
@@ -1079,6 +1108,7 @@ static struct device_node *of_get_compat_node(struct device_node *np)
  * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
  * @con_np: consumer device tree node
  * @sup_np: supplier device tree node
+ * @s: The supplier binding used to get the supplier phandle
  *
  * Given a phandle to a supplier device tree node (@sup_np), this function
  * finds the device that owns the supplier device tree node and creates a
@@ -1093,7 +1123,8 @@ static struct device_node *of_get_compat_node(struct device_node *np)
  * - -ENODEV if struct device will never be create for supplier
  */
 static int of_link_to_phandle(struct device_node *con_np,
-			      struct device_node *sup_np)
+			      struct device_node *sup_np,
+			      const struct supplier_bindings *s)
 {
 	struct device *sup_dev;
 	struct device_node *tmp_np = sup_np;
@@ -1102,11 +1133,15 @@ static int of_link_to_phandle(struct device_node *con_np,
 	 * Find the device node that contains the supplier phandle.  It may be
 	 * @sup_np or it may be an ancestor of @sup_np.
 	 */
-	sup_np = of_get_compat_node(sup_np);
-	if (!sup_np) {
-		pr_debug("Not linking %pOFP to %pOFP - No device\n",
-			 con_np, tmp_np);
-		return -ENODEV;
+	if (s->sup_node_always_dev) {
+		of_node_get(sup_np);
+	} else {
+		sup_np = of_get_compat_node(sup_np);
+		if (!sup_np) {
+			pr_debug("Not linking %pOFP to %pOFP - No device\n",
+				 con_np, tmp_np);
+			return -ENODEV;
+		}
 	}
 
 	/*
@@ -1239,31 +1274,6 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
 	return parse_suffix_prop_cells(np, prop_name, index, suffix, cells); \
 }
 
-/**
- * struct supplier_bindings - Property parsing functions for suppliers
- *
- * @parse_prop: function name
- *	parse_prop() finds the node corresponding to a supplier phandle
- * @parse_prop.np: Pointer to device node holding supplier phandle property
- * @parse_prop.prop_name: Name of property holding a phandle value
- * @parse_prop.index: For properties holding a list of phandles, this is the
- *		      index into the list
- * @optional: Describes whether a supplier is mandatory or not
- * @node_not_dev: The consumer node containing the property is never a device.
- *
- * Returns:
- * parse_prop() return values are
- * - phandle node pointer with refcount incremented. Caller must of_node_put()
- *   on it when done.
- * - NULL if no phandle found at index
- */
-struct supplier_bindings {
-	struct device_node *(*parse_prop)(struct device_node *np,
-					  const char *prop_name, int index);
-	bool optional;
-	bool node_not_dev;
-};
-
 DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
 DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
@@ -1380,7 +1390,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_resets, },
 	{ .parse_prop = parse_leds, },
 	{ .parse_prop = parse_backlight, },
-	{ .parse_prop = parse_phy_handle, },
+	{ .parse_prop = parse_phy_handle, .sup_node_always_dev = true, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },
@@ -1430,7 +1440,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 					: of_node_get(con_np);
 			matched = true;
 			i++;
-			of_link_to_phandle(con_dev_np, phandle);
+			of_link_to_phandle(con_dev_np, phandle, s);
 			of_node_put(phandle);
 			of_node_put(con_dev_np);
 		}
-- 
2.33.0.153.gba50c8fa24-goog

