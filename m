Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60059340F88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhCRVDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhCRVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:03:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C47CC06174A;
        Thu, 18 Mar 2021 14:03:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 780811F45711
Received: by jupiter.universe (Postfix, from userid 1000)
        id EAB1F4800C3; Thu, 18 Mar 2021 22:03:27 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [RFC] clk: add boot clock support
Date:   Thu, 18 Mar 2021 22:03:18 +0100
Message-Id: <20210318210318.144961-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316215123.GA3712408@robh.at.kernel.org>
References: <20210316215123.GA3712408@robh.at.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Congatec's QMX6 system on module one of the i.MX6 fixed clocks
is provided by an I2C RTC. Specifying this properly results in a
circular dependency, since the I2C RTC (and thus its clock) cannot
be initialized without the i.MX6 clock controller being initialized.

With current code the following path is executed when i.MX6 clock
controller is probed (and ckil clock is specified to be the I2C RTC
via DT):

1. imx6q_obtain_fixed_clk_hw(ccm_node, "ckil", 0);
2. of_clk_get_by_name(ccm_node, "ckil");
3. __of_clk_get(ccm_node, 0, ccm_node->full_name, "ckil");
4. of_clk_get_hw(ccm_node, 0, "ckil")
5. spec = of_parse_clkspec(ccm_node, 0, "ckil"); // get phandle
6. of_clk_get_hw_from_clkspec(&spec); // returns -EPROBE_DEFER
7. error is propagated back, i.MX6q clock controller is probe deferred
8. I2C controller is never initialized without clock controller
   I2C RTC is never initialized without I2C controller
   CKIL clock is never initialized without I2C RTC
   clock controller is never initialized without CKIL

To fix the circular dependency this registers a dummy clock when
the RTC clock is tried to be acquired. The dummy clock will later
be unregistered when the proper clock is registered for the RTC
DT node. IIUIC clk_core_reparent_orphans() will take care of
fixing up the clock tree.

NOTE: For now the patch is compile tested only. If this approach
is the correct one I will do some testing and properly submit this.
You can find all the details about the hardware in the following
patchset:

https://lore.kernel.org/linux-devicetree/20210222171247.97609-1-sebastian.reichel@collabora.com/

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/clock/clock-bindings.txt         |   7 +
 drivers/clk/clk.c                             | 146 ++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
index f2ea53832ac6..66d67ff4aa0f 100644
--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -32,6 +32,13 @@ clock-output-names: Recommended to be a list of strings of clock output signal
 		    Clock consumer nodes must never directly reference
 		    the provider's clock-output-names property.
 
+boot-clock-frequencies: This property is used to specify that a clock is enabled
+			by default with the provided frequency at boot time. This
+			is required to break circular clock dependencies. For clock
+			providers with #clock-cells = 0 this is a single u32
+			with the frequency in Hz. Otherwise it's a list of
+			clock cell specifier + frequency in Hz.
+
 For example:
 
     oscillator {
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5052541a0986..029088ed5f1a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4499,6 +4499,146 @@ static const struct of_device_id __clk_of_table_sentinel
 static LIST_HEAD(of_clk_providers);
 static DEFINE_MUTEX(of_clk_mutex);
 
+struct of_boot_clk {
+	struct of_clk_provider cp;
+	struct clk_hw clk;
+	unsigned long rate;
+};
+
+/**
+ * of_clk_get_boot_rate() - Get DT configured boot rate for a DT clkspec
+ * @clkspec: pointer to a clock specifier data structure
+ *
+ * This function provides the boot clock rate configured in DT
+ * for a clkspec without requiring a device being registered in
+ * the kernel.
+ *
+ * This is required for clock setups with circular dependencies,
+ * which only work because of some clocks being enabled
+ * automatically.
+ *
+ * The return value is either the rate,
+ * -EINVAL for malformed DT,
+ * -ENODATA if no boot frequency is specified.
+ */
+static int of_clk_get_boot_rate(struct of_phandle_args *clkspec)
+{
+	const struct device_node *np;
+	u32 cells;
+	u32 val;
+
+	if (!clkspec || !clkspec->np)
+		return -EINVAL;
+	np = clkspec->np;
+
+	if (!of_property_read_u32(np, "#clock-cells", &cells))
+		return -EINVAL;
+
+	/* complex clock providers are currently not supported */
+	if (cells > 0)
+		return -EINVAL;
+
+	if (!of_property_read_u32(np, "boot-clock-frequencies", &val))
+		return -ENODATA;
+
+	return val;
+}
+
+static struct clk_hw *of_boot_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	return data;
+}
+
+static unsigned long
+of_boot_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct of_boot_clk *bootclk = container_of(hw, struct of_boot_clk, clk);
+
+	return bootclk->rate;
+}
+
+static const struct clk_ops of_boot_clk_ops = {
+	.recalc_rate = of_boot_clk_recalc_rate,
+};
+
+/**
+ * of_clk_register_boot_clk() - Register a boot clock provider for a node
+ * @clkspec: pointer to a clock specifier data structure
+ *
+ * Register a fixed rate dummy clock for solving circular dependencies
+ * during boot. This is expected to be replaced by a real clock device
+ * once the correct driver is probed.
+ *
+ * The function expects of_clk_mutex to be locked.
+ *
+ * Returns:
+ *  -EPROBE_DEFER, if DT does not specify a boot clock
+ *  -ENOMEM, if there is not sufficient memory available
+ *  -EINVAL, if DT contains invalid data
+ *  dummy clk_hw device on success
+ */
+static struct clk_hw *
+of_clk_register_boot_clk(struct of_phandle_args *clkspec)
+{
+	struct of_boot_clk *bootclk;
+	struct clk_init_data init;
+	int rate = of_clk_get_boot_rate(clkspec);
+
+	WARN_ON(!mutex_is_locked(&of_clk_mutex));
+
+	if (rate < 0) {
+		if (rate == -ENODATA)
+			return ERR_PTR(-EPROBE_DEFER);
+		return ERR_PTR(rate);
+	}
+
+	bootclk = kzalloc(sizeof(*bootclk), GFP_KERNEL);
+	if (!bootclk)
+		return ERR_PTR(-ENOMEM);
+
+	bootclk->rate = rate;
+
+	/* TODO: name should be unique, use idr_alloc */
+	init.name = "dummy-boot-clk";
+	init.ops = &of_boot_clk_ops;
+	init.flags = 0;
+	init.parent_names = NULL;
+	init.num_parents = 0;
+	bootclk->clk.init = &init;
+
+	bootclk->cp.node = of_node_get(clkspec->np);
+	bootclk->cp.data = bootclk;
+	bootclk->cp.get_hw = of_boot_clk_get;
+
+	/* TODO: use same name as in clk.init.name */
+	clk_hw_register_clkdev(&bootclk->clk, NULL, "dummy-boot-clk");
+
+	list_add(&bootclk->cp.link, &of_clk_providers);
+
+	pr_debug("Added clk_hw boot provider from %pOF\n", clkspec->np);
+
+	return &bootclk->clk;
+}
+
+static void of_clk_unregister_boot_clk(struct device_node *np)
+{
+	struct of_boot_clk *bootclk;
+	struct of_clk_provider *cp;
+
+	WARN_ON(!mutex_is_locked(&of_clk_mutex));
+
+	list_for_each_entry(cp, &of_clk_providers, link) {
+		if (cp->node == np && cp->get_hw == of_boot_clk_get) {
+			bootclk = container_of(cp, struct of_boot_clk, cp);
+			list_del(&cp->link);
+			// TODO: undo clk_hw_register_clkdev
+			of_node_put(cp->node);
+			kfree(bootclk);
+			break;
+		}
+	}
+}
+
 struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
 				     void *data)
 {
@@ -4566,6 +4706,7 @@ int of_clk_add_provider(struct device_node *np,
 	cp->get = clk_src_get;
 
 	mutex_lock(&of_clk_mutex);
+	of_clk_unregister_boot_clk(np);
 	list_add(&cp->link, &of_clk_providers);
 	mutex_unlock(&of_clk_mutex);
 	pr_debug("Added clock from %pOF\n", np);
@@ -4605,6 +4746,7 @@ int of_clk_add_hw_provider(struct device_node *np,
 	cp->get_hw = get;
 
 	mutex_lock(&of_clk_mutex);
+	of_clk_unregister_boot_clk(np);
 	list_add(&cp->link, &of_clk_providers);
 	mutex_unlock(&of_clk_mutex);
 	pr_debug("Added clk_hw provider from %pOF\n", np);
@@ -4837,6 +4979,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
 				break;
 		}
 	}
+
+	if (hw == ERR_PTR(-EPROBE_DEFER))
+		hw = of_clk_register_boot_clk(clkspec);
+
 	mutex_unlock(&of_clk_mutex);
 
 	return hw;
-- 
2.30.2

