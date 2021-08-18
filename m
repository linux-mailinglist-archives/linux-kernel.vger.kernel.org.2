Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582DD3F0C35
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhHRT6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:58:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhHRT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:57:39 -0400
Date:   Wed, 18 Aug 2021 19:57:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629316623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPEhdPmQOzhpqOJceyC3MSX8mtgzchW+pHYlEBqqXhQ=;
        b=2KFz5KgC+gegncFHmweBjpY19sBXTSLocTy9C9/rTkJlObOIln/rDQBMIGPcpAs0/ZpbRE
        5hme3ni+cnST+5WC+TG1oKqcn7V94x00Z/BLcs/Ufz+XIErVuWPZQRpkFi6sbENU75K9yp
        30UrH7HCoLN0RmFYbU08XIR968pHQPJ/Ddm/GseJe66+skcPZlD0pz9Z8kyjBDcu/PZAl6
        W4aukqI+bUYgNXt04HGRiuTxdDuO6uiFbxsWsApn2OqyOqK1+S+HX95gIz7wRNnKKPsEVD
        8bCmorPCvqCXlWc/Zyn9r2/axWHYmbjb1nBF1kVKD/FFupaxiY2h+gVx9KguPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629316623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPEhdPmQOzhpqOJceyC3MSX8mtgzchW+pHYlEBqqXhQ=;
        b=s18xxujwpLqvGF8+MnKoaGwG+vtDuMEZW5kztZ2H9X/O4dQtRJbuqXElCIT105OvEanGy4
        CtUv3qHYP6sAiRBQ==
From:   "irqchip-bot for Jianqun Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] pinctrl/rockchip: separate struct
 rockchip_pin_bank to a head file
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>, maz@kernel.org,
        tglx@linutronix.de
In-Reply-To: <20210816011948.1118959-3-jay.xu@rock-chips.com>
References: <20210816011948.1118959-3-jay.xu@rock-chips.com>
MIME-Version: 1.0
Message-ID: <162931662292.25758.3542180294225194503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e1450694e94657458395af886d2467d6ac3355af
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e1450694e94657458395af886d2467d6ac3355af
Author:        Jianqun Xu <jay.xu@rock-chips.com>
AuthorDate:    Mon, 16 Aug 2021 09:19:41 +08:00
Committer:     Linus Walleij <linus.walleij@linaro.org>
CommitterDate: Tue, 17 Aug 2021 01:01:49 +02:00

pinctrl/rockchip: separate struct rockchip_pin_bank to a head file

Separate struct rockchip_pin_bank to pinctrl-rockchip.h file, which will
be used by gpio-rockchip driver in the future.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Link: https://lore.kernel.org/r/20210816011948.1118959-3-jay.xu@rock-chips.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-rockchip.c | 226 +--------------------------
 drivers/pinctrl/pinctrl-rockchip.h | 245 ++++++++++++++++++++++++++++-
 2 files changed, 246 insertions(+), 225 deletions(-)
 create mode 100644 drivers/pinctrl/pinctrl-rockchip.h

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 650c71c..b998133 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -37,6 +37,7 @@
 
 #include "core.h"
 #include "pinconf.h"
+#include "pinctrl-rockchip.h"
 
 /* GPIO control registers */
 #define GPIO_SWPORT_DR		0x00
@@ -52,21 +53,6 @@
 #define GPIO_EXT_PORT		0x50
 #define GPIO_LS_SYNC		0x60
 
-enum rockchip_pinctrl_type {
-	PX30,
-	RV1108,
-	RK2928,
-	RK3066B,
-	RK3128,
-	RK3188,
-	RK3288,
-	RK3308,
-	RK3368,
-	RK3399,
-	RK3568,
-};
-
-
 /**
  * Generate a bitmask for setting a value (v) with a write mask bit in hiword
  * register 31:16 area.
@@ -84,103 +70,6 @@ enum rockchip_pinctrl_type {
 #define IOMUX_WIDTH_3BIT	BIT(4)
 #define IOMUX_WIDTH_2BIT	BIT(5)
 
-/**
- * struct rockchip_iomux
- * @type: iomux variant using IOMUX_* constants
- * @offset: if initialized to -1 it will be autocalculated, by specifying
- *	    an initial offset value the relevant source offset can be reset
- *	    to a new value for autocalculating the following iomux registers.
- */
-struct rockchip_iomux {
-	int				type;
-	int				offset;
-};
-
-/*
- * enum type index corresponding to rockchip_perpin_drv_list arrays index.
- */
-enum rockchip_pin_drv_type {
-	DRV_TYPE_IO_DEFAULT = 0,
-	DRV_TYPE_IO_1V8_OR_3V0,
-	DRV_TYPE_IO_1V8_ONLY,
-	DRV_TYPE_IO_1V8_3V0_AUTO,
-	DRV_TYPE_IO_3V3_ONLY,
-	DRV_TYPE_MAX
-};
-
-/*
- * enum type index corresponding to rockchip_pull_list arrays index.
- */
-enum rockchip_pin_pull_type {
-	PULL_TYPE_IO_DEFAULT = 0,
-	PULL_TYPE_IO_1V8_ONLY,
-	PULL_TYPE_MAX
-};
-
-/**
- * struct rockchip_drv
- * @drv_type: drive strength variant using rockchip_perpin_drv_type
- * @offset: if initialized to -1 it will be autocalculated, by specifying
- *	    an initial offset value the relevant source offset can be reset
- *	    to a new value for autocalculating the following drive strength
- *	    registers. if used chips own cal_drv func instead to calculate
- *	    registers offset, the variant could be ignored.
- */
-struct rockchip_drv {
-	enum rockchip_pin_drv_type	drv_type;
-	int				offset;
-};
-
-/**
- * struct rockchip_pin_bank
- * @reg_base: register base of the gpio bank
- * @regmap_pull: optional separate register for additional pull settings
- * @clk: clock of the gpio bank
- * @irq: interrupt of the gpio bank
- * @saved_masks: Saved content of GPIO_INTEN at suspend time.
- * @pin_base: first pin number
- * @nr_pins: number of pins in this bank
- * @name: name of the bank
- * @bank_num: number of the bank, to account for holes
- * @iomux: array describing the 4 iomux sources of the bank
- * @drv: array describing the 4 drive strength sources of the bank
- * @pull_type: array describing the 4 pull type sources of the bank
- * @valid: is all necessary information present
- * @of_node: dt node of this bank
- * @drvdata: common pinctrl basedata
- * @domain: irqdomain of the gpio bank
- * @gpio_chip: gpiolib chip
- * @grange: gpio range
- * @slock: spinlock for the gpio bank
- * @toggle_edge_mode: bit mask to toggle (falling/rising) edge mode
- * @recalced_mask: bit mask to indicate a need to recalulate the mask
- * @route_mask: bits describing the routing pins of per bank
- */
-struct rockchip_pin_bank {
-	void __iomem			*reg_base;
-	struct regmap			*regmap_pull;
-	struct clk			*clk;
-	int				irq;
-	u32				saved_masks;
-	u32				pin_base;
-	u8				nr_pins;
-	char				*name;
-	u8				bank_num;
-	struct rockchip_iomux		iomux[4];
-	struct rockchip_drv		drv[4];
-	enum rockchip_pin_pull_type	pull_type[4];
-	bool				valid;
-	struct device_node		*of_node;
-	struct rockchip_pinctrl		*drvdata;
-	struct irq_domain		*domain;
-	struct gpio_chip		gpio_chip;
-	struct pinctrl_gpio_range	grange;
-	raw_spinlock_t			slock;
-	u32				toggle_edge_mode;
-	u32				recalced_mask;
-	u32				route_mask;
-};
-
 #define PIN_BANK(id, pins, label)			\
 	{						\
 		.bank_num	= id,			\
@@ -320,119 +209,6 @@ struct rockchip_pin_bank {
 #define RK_MUXROUTE_PMU(ID, PIN, FUNC, REG, VAL)	\
 	PIN_BANK_MUX_ROUTE_FLAGS(ID, PIN, FUNC, REG, VAL, ROCKCHIP_ROUTE_PMU)
 
-/**
- * struct rockchip_mux_recalced_data: represent a pin iomux data.
- * @num: bank number.
- * @pin: pin number.
- * @bit: index at register.
- * @reg: register offset.
- * @mask: mask bit
- */
-struct rockchip_mux_recalced_data {
-	u8 num;
-	u8 pin;
-	u32 reg;
-	u8 bit;
-	u8 mask;
-};
-
-enum rockchip_mux_route_location {
-	ROCKCHIP_ROUTE_SAME = 0,
-	ROCKCHIP_ROUTE_PMU,
-	ROCKCHIP_ROUTE_GRF,
-};
-
-/**
- * struct rockchip_mux_recalced_data: represent a pin iomux data.
- * @bank_num: bank number.
- * @pin: index at register or used to calc index.
- * @func: the min pin.
- * @route_location: the mux route location (same, pmu, grf).
- * @route_offset: the max pin.
- * @route_val: the register offset.
- */
-struct rockchip_mux_route_data {
-	u8 bank_num;
-	u8 pin;
-	u8 func;
-	enum rockchip_mux_route_location route_location;
-	u32 route_offset;
-	u32 route_val;
-};
-
-struct rockchip_pin_ctrl {
-	struct rockchip_pin_bank	*pin_banks;
-	u32				nr_banks;
-	u32				nr_pins;
-	char				*label;
-	enum rockchip_pinctrl_type	type;
-	int				grf_mux_offset;
-	int				pmu_mux_offset;
-	int				grf_drv_offset;
-	int				pmu_drv_offset;
-	struct rockchip_mux_recalced_data *iomux_recalced;
-	u32				niomux_recalced;
-	struct rockchip_mux_route_data *iomux_routes;
-	u32				niomux_routes;
-
-	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
-				    int pin_num, struct regmap **regmap,
-				    int *reg, u8 *bit);
-	void	(*drv_calc_reg)(struct rockchip_pin_bank *bank,
-				    int pin_num, struct regmap **regmap,
-				    int *reg, u8 *bit);
-	int	(*schmitt_calc_reg)(struct rockchip_pin_bank *bank,
-				    int pin_num, struct regmap **regmap,
-				    int *reg, u8 *bit);
-};
-
-struct rockchip_pin_config {
-	unsigned int		func;
-	unsigned long		*configs;
-	unsigned int		nconfigs;
-};
-
-/**
- * struct rockchip_pin_group: represent group of pins of a pinmux function.
- * @name: name of the pin group, used to lookup the group.
- * @pins: the pins included in this group.
- * @npins: number of pins included in this group.
- * @data: local pin configuration
- */
-struct rockchip_pin_group {
-	const char			*name;
-	unsigned int			npins;
-	unsigned int			*pins;
-	struct rockchip_pin_config	*data;
-};
-
-/**
- * struct rockchip_pmx_func: represent a pin function.
- * @name: name of the pin function, used to lookup the function.
- * @groups: one or more names of pin groups that provide this function.
- * @ngroups: number of groups included in @groups.
- */
-struct rockchip_pmx_func {
-	const char		*name;
-	const char		**groups;
-	u8			ngroups;
-};
-
-struct rockchip_pinctrl {
-	struct regmap			*regmap_base;
-	int				reg_size;
-	struct regmap			*regmap_pull;
-	struct regmap			*regmap_pmu;
-	struct device			*dev;
-	struct rockchip_pin_ctrl	*ctrl;
-	struct pinctrl_desc		pctl;
-	struct pinctrl_dev		*pctl_dev;
-	struct rockchip_pin_group	*groups;
-	unsigned int			ngroups;
-	struct rockchip_pmx_func	*functions;
-	unsigned int			nfunctions;
-};
-
 static struct regmap_config rockchip_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
new file mode 100644
index 0000000..dba9e95
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -0,0 +1,245 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021 Rockchip Electronics Co. Ltd.
+ *
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
+ *
+ * With some ideas taken from pinctrl-samsung:
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2012 Linaro Ltd
+ *		https://www.linaro.org
+ *
+ * and pinctrl-at91:
+ * Copyright (C) 2011-2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ */
+
+#ifndef _PINCTRL_ROCKCHIP_H
+#define _PINCTRL_ROCKCHIP_H
+
+enum rockchip_pinctrl_type {
+	PX30,
+	RV1108,
+	RK2928,
+	RK3066B,
+	RK3128,
+	RK3188,
+	RK3288,
+	RK3308,
+	RK3368,
+	RK3399,
+	RK3568,
+};
+
+/**
+ * struct rockchip_iomux
+ * @type: iomux variant using IOMUX_* constants
+ * @offset: if initialized to -1 it will be autocalculated, by specifying
+ *	    an initial offset value the relevant source offset can be reset
+ *	    to a new value for autocalculating the following iomux registers.
+ */
+struct rockchip_iomux {
+	int type;
+	int offset;
+};
+
+/*
+ * enum type index corresponding to rockchip_perpin_drv_list arrays index.
+ */
+enum rockchip_pin_drv_type {
+	DRV_TYPE_IO_DEFAULT = 0,
+	DRV_TYPE_IO_1V8_OR_3V0,
+	DRV_TYPE_IO_1V8_ONLY,
+	DRV_TYPE_IO_1V8_3V0_AUTO,
+	DRV_TYPE_IO_3V3_ONLY,
+	DRV_TYPE_MAX
+};
+
+/*
+ * enum type index corresponding to rockchip_pull_list arrays index.
+ */
+enum rockchip_pin_pull_type {
+	PULL_TYPE_IO_DEFAULT = 0,
+	PULL_TYPE_IO_1V8_ONLY,
+	PULL_TYPE_MAX
+};
+
+/**
+ * struct rockchip_drv
+ * @drv_type: drive strength variant using rockchip_perpin_drv_type
+ * @offset: if initialized to -1 it will be autocalculated, by specifying
+ *	    an initial offset value the relevant source offset can be reset
+ *	    to a new value for autocalculating the following drive strength
+ *	    registers. if used chips own cal_drv func instead to calculate
+ *	    registers offset, the variant could be ignored.
+ */
+struct rockchip_drv {
+	enum rockchip_pin_drv_type	drv_type;
+	int				offset;
+};
+
+/**
+ * struct rockchip_pin_bank
+ * @reg_base: register base of the gpio bank
+ * @regmap_pull: optional separate register for additional pull settings
+ * @clk: clock of the gpio bank
+ * @irq: interrupt of the gpio bank
+ * @saved_masks: Saved content of GPIO_INTEN at suspend time.
+ * @pin_base: first pin number
+ * @nr_pins: number of pins in this bank
+ * @name: name of the bank
+ * @bank_num: number of the bank, to account for holes
+ * @iomux: array describing the 4 iomux sources of the bank
+ * @drv: array describing the 4 drive strength sources of the bank
+ * @pull_type: array describing the 4 pull type sources of the bank
+ * @valid: is all necessary information present
+ * @of_node: dt node of this bank
+ * @drvdata: common pinctrl basedata
+ * @domain: irqdomain of the gpio bank
+ * @gpio_chip: gpiolib chip
+ * @grange: gpio range
+ * @slock: spinlock for the gpio bank
+ * @toggle_edge_mode: bit mask to toggle (falling/rising) edge mode
+ * @recalced_mask: bit mask to indicate a need to recalulate the mask
+ * @route_mask: bits describing the routing pins of per bank
+ */
+struct rockchip_pin_bank {
+	void __iomem			*reg_base;
+	struct regmap			*regmap_pull;
+	struct clk			*clk;
+	int				irq;
+	u32				saved_masks;
+	u32				pin_base;
+	u8				nr_pins;
+	char				*name;
+	u8				bank_num;
+	struct rockchip_iomux		iomux[4];
+	struct rockchip_drv		drv[4];
+	enum rockchip_pin_pull_type	pull_type[4];
+	bool				valid;
+	struct device_node		*of_node;
+	struct rockchip_pinctrl		*drvdata;
+	struct irq_domain		*domain;
+	struct gpio_chip		gpio_chip;
+	struct pinctrl_gpio_range	grange;
+	raw_spinlock_t			slock;
+	u32				toggle_edge_mode;
+	u32				recalced_mask;
+	u32				route_mask;
+};
+
+/**
+ * struct rockchip_mux_recalced_data: represent a pin iomux data.
+ * @num: bank number.
+ * @pin: pin number.
+ * @bit: index at register.
+ * @reg: register offset.
+ * @mask: mask bit
+ */
+struct rockchip_mux_recalced_data {
+	u8 num;
+	u8 pin;
+	u32 reg;
+	u8 bit;
+	u8 mask;
+};
+
+enum rockchip_mux_route_location {
+	ROCKCHIP_ROUTE_SAME = 0,
+	ROCKCHIP_ROUTE_PMU,
+	ROCKCHIP_ROUTE_GRF,
+};
+
+/**
+ * struct rockchip_mux_recalced_data: represent a pin iomux data.
+ * @bank_num: bank number.
+ * @pin: index at register or used to calc index.
+ * @func: the min pin.
+ * @route_location: the mux route location (same, pmu, grf).
+ * @route_offset: the max pin.
+ * @route_val: the register offset.
+ */
+struct rockchip_mux_route_data {
+	u8 bank_num;
+	u8 pin;
+	u8 func;
+	enum rockchip_mux_route_location route_location;
+	u32 route_offset;
+	u32 route_val;
+};
+
+struct rockchip_pin_ctrl {
+	struct rockchip_pin_bank	*pin_banks;
+	u32				nr_banks;
+	u32				nr_pins;
+	char				*label;
+	enum rockchip_pinctrl_type	type;
+	int				grf_mux_offset;
+	int				pmu_mux_offset;
+	int				grf_drv_offset;
+	int				pmu_drv_offset;
+	struct rockchip_mux_recalced_data *iomux_recalced;
+	u32				niomux_recalced;
+	struct rockchip_mux_route_data *iomux_routes;
+	u32				niomux_routes;
+
+	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit);
+	void	(*drv_calc_reg)(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit);
+	int	(*schmitt_calc_reg)(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit);
+};
+
+struct rockchip_pin_config {
+	unsigned int		func;
+	unsigned long		*configs;
+	unsigned int		nconfigs;
+};
+
+/**
+ * struct rockchip_pin_group: represent group of pins of a pinmux function.
+ * @name: name of the pin group, used to lookup the group.
+ * @pins: the pins included in this group.
+ * @npins: number of pins included in this group.
+ * @data: local pin configuration
+ */
+struct rockchip_pin_group {
+	const char			*name;
+	unsigned int			npins;
+	unsigned int			*pins;
+	struct rockchip_pin_config	*data;
+};
+
+/**
+ * struct rockchip_pmx_func: represent a pin function.
+ * @name: name of the pin function, used to lookup the function.
+ * @groups: one or more names of pin groups that provide this function.
+ * @ngroups: number of groups included in @groups.
+ */
+struct rockchip_pmx_func {
+	const char		*name;
+	const char		**groups;
+	u8			ngroups;
+};
+
+struct rockchip_pinctrl {
+	struct regmap			*regmap_base;
+	int				reg_size;
+	struct regmap			*regmap_pull;
+	struct regmap			*regmap_pmu;
+	struct device			*dev;
+	struct rockchip_pin_ctrl	*ctrl;
+	struct pinctrl_desc		pctl;
+	struct pinctrl_dev		*pctl_dev;
+	struct rockchip_pin_group	*groups;
+	unsigned int			ngroups;
+	struct rockchip_pmx_func	*functions;
+	unsigned int			nfunctions;
+};
+
+#endif
