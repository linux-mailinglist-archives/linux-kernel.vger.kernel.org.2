Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEAD443E97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhKCIxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:53:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44168 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhKCIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635929429; x=1667465429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FUjWEzl0ouzmhl/moxSk5WH7KnBS/v2vT+Oz8dijZ1U=;
  b=iXbobVz79arlQA3CeKYiPeuAYmJjKYhhdM9uKkl4biZ3ve35FB9xIMHr
   BpALQXijMSiYuVkXFSdMNh56UYjYWJ6Cw5GCHWbg4rHZoKhXKw7LCoqvf
   4gb62xrZja9/6BkK+zFlEpA9k4mCUiVUsg6RQnC75oGJNzcOidE5jyBjP
   jfTu0YNSzMVPA2IQKIT0kwBPfkwMKTLS5h06hBuTeNJGVzsKkTq1QHoZW
   Dp4FlMND1c91ekYqtTx3DJNvAHtrXnS6vtaRKcAVOyleuOuesEqwT3Fvc
   hQ+oftcz2uEEl7OhoyekDBUkUqVsCshrK2TnvWIDLP4Y9YUi4+RVw0X7S
   A==;
IronPort-SDR: Mi0Kt3cjizsZetvxpo1h9Ip2e7Fsg0goqnj3232yYzisTAtNnXZLwxcqNlD420M9GbNYpCWiDn
 CkAZ51X/H2g3X17LtyxLeWQPuM6fbR7qwHGvNPtahd2kvLaf55HglJs2vH+jbNIdnhxqaQ8fXE
 cj2Pu3Uetj4Z/TYgSbAswX0WFzoByvM8j2ff2qsTvpzbit0/3w/sVwKS/nXPmhWfXTdGo9rfZM
 wPyHcL5LAw5rFhxMvlcwSLSR1dIns6PiGYXpmeBjQcKJJEItMjSxz0TMrwxkJQZ6jw6G1T46zF
 /vN9o7SBVnd4HXuOaM8L7Des
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="135311501"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Nov 2021 01:50:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 3 Nov 2021 01:50:28 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 3 Nov 2021 01:50:26 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <nicolas.ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v4 1/4] clk: gate: Add devm_clk_hw_register_gate()
Date:   Wed, 3 Nov 2021 09:50:59 +0100
Message-ID: <20211103085102.1656081-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
References: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
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

