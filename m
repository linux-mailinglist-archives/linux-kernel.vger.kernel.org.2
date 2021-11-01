Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424F44414FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhKAIKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:10:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62892 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhKAIJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635754046; x=1667290046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FUjWEzl0ouzmhl/moxSk5WH7KnBS/v2vT+Oz8dijZ1U=;
  b=FlxWTCTTjjlLxj/esbkgIvvJ82cpTFwaJUAr+iBH9HKZuoL6dVaMxYHO
   Aur9XL+UIvyJTHD8ev9MGdG51iLUwZwh0/bx6NPJKW3YoGNRPTY7KgHem
   XH6Ly4+Juai5IciqKXI3/NQAV/cuLzhqK9PVVWYhAqWsy9mIIRX0jfRFo
   Um9G0SMiPq6NYnFThtDjZu0qHtJjBQpjSdL63d0yjIPmPWOTOFJh0nIVi
   eg1OUd5AT+WmrV/jXgIdx9KFcxJIJJqolm3ihHxGgwXTI/BkK8h3MVKaJ
   iNICZ7NGa4xEuGPnAtwelnuLlsTuUio118DQxo6nlLao8xkKHawMgnhi2
   A==;
IronPort-SDR: 6kLYJ9uAmWfk8eX8M941GywPzu5zSlRtmJv357B88HgFmFgXTADz4BmdHo/4sk6MuAwHwb+Dg/
 6YpTeUJ7JNnDK6hc5CQvrDA7GbdrNjQD1FS5G8OA0t6nJ3YR090fGqbCRAZL6r5ud1gMMtAZtL
 AZexv98hqf8POzTur02vKZqtL7jzWb3djud5RXABIcRnP86SMoKcqhpi7DOrV8PDff6ViaI9CH
 Jo43DxZcuZujKduR8KvKEGqhXy9y3En3LxNcpDE8N2d5lJxXWJ/klWdaOB6eqKsAYraURP+hV+
 Jr8vTtvQz9OUh2vvvcA1koES
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="137558388"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2021 01:07:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 1 Nov 2021 01:07:25 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 1 Nov 2021 01:07:23 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <kavyasree.kotagiri@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v3 1/4] clk: gate: Add devm_clk_hw_register_gate()
Date:   Mon, 1 Nov 2021 09:08:42 +0100
Message-ID: <20211101080845.3343836-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211101080845.3343836-1-horatiu.vultur@microchip.com>
References: <20211101080845.3343836-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devm_clk_hw_register_gate() - devres-managed version of
clk_hw_register_gate()

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/clk/clk-gate.c       | 35 +++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h | 23 +++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 070dc47e95a1..64283807600b 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -222,3 +223,37 @@ void clk_hw_unregister_gate(struct clk_hw *hw)
 	kfree(gate);
 }
 EXPORT_SYMBOL_GPL(clk_hw_unregister_gate);
+
+static void devm_clk_hw_release_gate(struct device *dev, void *res)
+{
+	clk_hw_unregister_gate(*(struct clk_hw **)res);
+}
+
+struct clk_hw *__devm_clk_hw_register_gate(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clk_hw **ptr, *hw;
+
+	ptr = devres_alloc(devm_clk_hw_release_gate, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hw = __clk_hw_register_gate(dev, np, name, parent_name, parent_hw,
+				    parent_data, flags, reg, bit_idx,
+				    clk_gate_flags, lock);
+
+	if (!IS_ERR(hw)) {
+		*ptr = hw;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(__devm_clk_hw_register_gate);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f59c875271a0..2faa6f7aa8a8 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -490,6 +490,13 @@ struct clk_hw *__clk_hw_register_gate(struct device *dev,
 		unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock);
+struct clk_hw *__devm_clk_hw_register_gate(struct device *dev,
+		struct device_node *np, const char *name,
+		const char *parent_name, const struct clk_hw *parent_hw,
+		const struct clk_parent_data *parent_data,
+		unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
 struct clk *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
@@ -544,6 +551,22 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	__clk_hw_register_gate((dev), NULL, (name), NULL, NULL, (parent_data), \
 			       (flags), (reg), (bit_idx),		      \
 			       (clk_gate_flags), (lock))
+/**
+ * devm_clk_hw_register_gate - register a gate clock with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of this clock's parent
+ * @flags: framework-specific flags for this clock
+ * @reg: register address to control gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define devm_clk_hw_register_gate(dev, name, parent_name, flags, reg, bit_idx,\
+				  clk_gate_flags, lock)			      \
+	__devm_clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL, \
+			       NULL, (flags), (reg), (bit_idx),		      \
+			       (clk_gate_flags), (lock))
 void clk_unregister_gate(struct clk *clk);
 void clk_hw_unregister_gate(struct clk_hw *hw);
 int clk_gate_is_enabled(struct clk_hw *hw);
-- 
2.33.0

