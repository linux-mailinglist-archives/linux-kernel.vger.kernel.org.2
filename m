Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25210397AEF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 22:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhFAUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 16:03:56 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:22154 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbhFAUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 16:03:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622577710; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gceN2xQpjM3GnB/+WuD3yTWIDDN/mCg9wpXlfkVW6HtDiOMZBuQrpfW8UpTVEA00+v
    PkRpPQLECkuiktiN6ICxRn87NbFVE9Ty4xPGEcOj1N2SzEqlmyuAANJrbjWSnfpJ7o2q
    PRCIopRuIv9BkxEnqGKK3RfoQPnH/mcyQhgkH5jDp8JtnBLRRup4P3zOujZEg7gc573d
    fVUIvoW1RrAxh0D8kq1ZkJw+IOnVHuy5rAVpgvhU4EvTHz/zLZByQHklkSO3une82jso
    z9oEjJ3lMzNAryG0V78meumD7He9qjTzrXtMLIfdcXW4uJYawxgc4gJ9SyWfhTjQB+6Y
    n2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622577710;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WHIERZI5vIdnzffdZdfNMVc3iu5B7FKbrOM9d3fZGo0=;
    b=K2+bHzfBE84ogFOISUgpc3ViUBODWLxYIC3+NtF3G09XJn440vWBQ7Anss5yiGBXZI
    Li9Qx6PonBwwV8SYDMaabshIuX4t74COSwEtCH12FUxzJedA6dwXt+qNlC9am7YBd35N
    s5B2eNV3S48OQO9f09kpUaYax6WGDPudGInFRTBq14ipGHlQd8E5mDQrJS62iL1QWZJq
    TyK2seH/BN9nvQjmz6yREwEGQrKlzblRs5wcHe3LbRex9YlEDZzkpaeq49FIxYh/pS7q
    FbDbqTDx7jlS5us0iaEn0WNX5JsGeivOBy36D1GAP9v1Ac46AvpdBBz3l6laze6bRfB/
    WP4Q==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622577710;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WHIERZI5vIdnzffdZdfNMVc3iu5B7FKbrOM9d3fZGo0=;
    b=CJ6QwKKbUT0jRMf40qjgmUtdCk446LU6cKlulWG13JQvPwa6vO5jsu/OVneCw7+52e
    bvsecez9YbiuIrMsdN0R+o1ULTz/Op15Sc0TzWoyjckF0kZU3/pyxnJkmqqMasfEGcMc
    IITH8W8EmBRTUY+8gxDls8f77AByqF88CF5tftWz4wNbXhhlOT6Rc3l90Xhsec4CB5mW
    bpR+4EUiGCo4nSlnrP3/3/AMPeBrlMQMlHCnXUVR197uqEoRfiLt7NFmoMco9qb0iPK6
    Q5oFDSZXoqcZzKC+lM0PaGMA833n93rggyODmS90Pxku7MaOgjPcewAMq6i1rveyH7Pb
    JA8w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6Na3kD"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x51K1oWn3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 1 Jun 2021 22:01:50 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 3/3] extcon: sm5502: Add support for SM5504
Date:   Tue,  1 Jun 2021 22:00:07 +0200
Message-Id: <20210601200007.218802-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601200007.218802-1-stephan@gerhold.net>
References: <20210601200007.218802-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM5504 is another MUIC from Silicon Mitus that is fairly similar
to SM5502. They seem to use the same register set, but:

  - SM5504 has some additional bits in SM5502_REG_CONTROL
  - SM5504 has a quite different set of interrupts
  - SM5504 reports USB OTG as dev_type1 = BIT(0) instead of BIT(7)

Overall it's minor and we can support this by defining a separate
struct sm5502_type for SM5504.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v3: Avoid if statements, use struct sm5502_type indirection

Changes in v2: Fix warning: cast to smaller integer type 'enum sm5502_types'
               from 'const void *' [-Wvoid-pointer-to-enum-cast]
               reported by kernel test robot
v2: https://lore.kernel.org/lkml/20210531133438.3511-7-stephan@gerhold.net/

Interestingly enough the register set (and especially the interrupts)
also look *very* similar to Richtek RT8973A (extcon-rt8973a) but
I didn't investigate this further.

Note that the changes in this patch are mostly based on guesswork
based on a SM5504 driver from Nitin Chaudhary [1] used in some Samsung
vendor kernels, since I was not able to find a public datasheet for SM5504.

[1]: https://github.com/NitinChaudharyUSC/MSM8x16_8x26/blob/master/drivers/misc/sm5504.c
---
 drivers/extcon/Kconfig         |   2 +-
 drivers/extcon/extcon-sm5502.c | 132 +++++++++++++++++++++++++++++++--
 drivers/extcon/extcon-sm5502.h |  78 +++++++++++++++++++
 3 files changed, 204 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index e3db936becfd..c69d40ae5619 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -154,7 +154,7 @@ config EXTCON_RT8973A
 	  from abnormal high input voltage (up to 28V).
 
 config EXTCON_SM5502
-	tristate "Silicon Mitus SM5502 EXTCON support"
+	tristate "Silicon Mitus SM5502/SM5504 EXTCON support"
 	depends on I2C
 	select IRQ_DOMAIN
 	select REGMAP_I2C
diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 951f6ca4c479..af44c1e2f368 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -66,6 +66,7 @@ struct sm5502_type {
 	struct reg_data *reg_data;
 	unsigned int num_reg_data;
 
+	unsigned int otg_dev_type1;
 	int (*parse_irq)(struct sm5502_muic_info *info, int irq_type);
 };
 
@@ -97,6 +98,33 @@ static struct reg_data sm5502_reg_data[] = {
 	},
 };
 
+/* Default value of SM5504 register to bring up MUIC device. */
+static struct reg_data sm5504_reg_data[] = {
+	{
+		.reg = SM5502_REG_RESET,
+		.val = SM5502_REG_RESET_MASK,
+		.invert = true,
+	}, {
+		.reg = SM5502_REG_INTMASK1,
+		.val = SM5504_REG_INTM1_ATTACH_MASK
+			| SM5504_REG_INTM1_DETACH_MASK,
+		.invert = false,
+	}, {
+		.reg = SM5502_REG_INTMASK2,
+		.val = SM5504_REG_INTM2_RID_CHG_MASK
+			| SM5504_REG_INTM2_UVLO_MASK
+			| SM5504_REG_INTM2_POR_MASK,
+		.invert = true,
+	}, {
+		.reg = SM5502_REG_CONTROL,
+		.val = SM5502_REG_CONTROL_MANUAL_SW_MASK
+			| SM5504_REG_CONTROL_CHGTYP_MASK
+			| SM5504_REG_CONTROL_USBCHDEN_MASK
+			| SM5504_REG_CONTROL_ADC_EN_MASK,
+		.invert = true,
+	},
+};
+
 /* List of detectable cables */
 static const unsigned int sm5502_extcon_cable[] = {
 	EXTCON_USB,
@@ -205,6 +233,55 @@ static const struct regmap_irq_chip sm5502_muic_irq_chip = {
 	.num_irqs		= ARRAY_SIZE(sm5502_irqs),
 };
 
+/* List of supported interrupt for SM5504 */
+static struct muic_irq sm5504_muic_irqs[] = {
+	{ SM5504_IRQ_INT1_ATTACH,	"muic-attach" },
+	{ SM5504_IRQ_INT1_DETACH,	"muic-detach" },
+	{ SM5504_IRQ_INT1_CHG_DET,	"muic-chg-det" },
+	{ SM5504_IRQ_INT1_DCD_OUT,	"muic-dcd-out" },
+	{ SM5504_IRQ_INT1_OVP_EVENT,	"muic-ovp-event" },
+	{ SM5504_IRQ_INT1_CONNECT,	"muic-connect" },
+	{ SM5504_IRQ_INT1_ADC_CHG,	"muic-adc-chg" },
+	{ SM5504_IRQ_INT2_RID_CHG,	"muic-rid-chg" },
+	{ SM5504_IRQ_INT2_UVLO,		"muic-uvlo" },
+	{ SM5504_IRQ_INT2_POR,		"muic-por" },
+	{ SM5504_IRQ_INT2_OVP_FET,	"muic-ovp-fet" },
+	{ SM5504_IRQ_INT2_OCP_LATCH,	"muic-ocp-latch" },
+	{ SM5504_IRQ_INT2_OCP_EVENT,	"muic-ocp-event" },
+	{ SM5504_IRQ_INT2_OVP_OCP_EVENT, "muic-ovp-ocp-event" },
+};
+
+/* Define interrupt list of SM5504 to register regmap_irq */
+static const struct regmap_irq sm5504_irqs[] = {
+	/* INT1 interrupts */
+	{ .reg_offset = 0, .mask = SM5504_IRQ_INT1_ATTACH_MASK, },
+	{ .reg_offset = 0, .mask = SM5504_IRQ_INT1_DETACH_MASK, },
+	{ .reg_offset = 0, .mask = SM5504_IRQ_INT1_CHG_DET_MASK, },
+	{ .reg_offset = 0, .mask = SM5504_IRQ_INT1_DCD_OUT_MASK, },
+	{ .reg_offset = 0, .mask = SM5504_IRQ_INT1_OVP_MASK, },
+	{ .reg_offset = 0, .mask = SM5504_IRQ_INT1_CONNECT_MASK, },
+	{ .reg_offset = 0, .mask = SM5504_IRQ_INT1_ADC_CHG_MASK, },
+
+	/* INT2 interrupts */
+	{ .reg_offset = 1, .mask = SM5504_IRQ_INT2_RID_CHG_MASK,},
+	{ .reg_offset = 1, .mask = SM5504_IRQ_INT2_UVLO_MASK, },
+	{ .reg_offset = 1, .mask = SM5504_IRQ_INT2_POR_MASK, },
+	{ .reg_offset = 1, .mask = SM5504_IRQ_INT2_OVP_FET_MASK, },
+	{ .reg_offset = 1, .mask = SM5504_IRQ_INT2_OCP_LATCH_MASK, },
+	{ .reg_offset = 1, .mask = SM5504_IRQ_INT2_OCP_EVENT_MASK, },
+	{ .reg_offset = 1, .mask = SM5504_IRQ_INT2_OVP_OCP_EVENT_MASK, },
+};
+
+static const struct regmap_irq_chip sm5504_muic_irq_chip = {
+	.name			= "sm5504",
+	.status_base		= SM5502_REG_INT1,
+	.mask_base		= SM5502_REG_INTMASK1,
+	.mask_invert		= false,
+	.num_regs		= 2,
+	.irqs			= sm5504_irqs,
+	.num_irqs		= ARRAY_SIZE(sm5504_irqs),
+};
+
 /* Define regmap configuration of SM5502 for I2C communication  */
 static bool sm5502_muic_volatile_reg(struct device *dev, unsigned int reg)
 {
@@ -308,11 +385,9 @@ static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 			return ret;
 		}
 
-		switch (dev_type1) {
-		case SM5502_REG_DEV_TYPE1_USB_OTG_MASK:
+		if (dev_type1 == info->type->otg_dev_type1) {
 			cable_type = SM5502_MUIC_ADC_GROUND_USB_OTG;
-			break;
-		default:
+		} else {
 			dev_dbg(info->dev,
 				"cannot identify the cable type: adc(0x%x), dev_type1(0x%x)\n",
 				adc, dev_type1);
@@ -365,6 +440,11 @@ static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 			return ret;
 		}
 
+		if (dev_type1 == info->type->otg_dev_type1) {
+			cable_type = SM5502_MUIC_ADC_OPEN_USB_OTG;
+			break;
+		}
+
 		switch (dev_type1) {
 		case SM5502_REG_DEV_TYPE1_USB_SDP_MASK:
 			cable_type = SM5502_MUIC_ADC_OPEN_USB;
@@ -372,9 +452,6 @@ static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 		case SM5502_REG_DEV_TYPE1_DEDICATED_CHG_MASK:
 			cable_type = SM5502_MUIC_ADC_OPEN_TA;
 			break;
-		case SM5502_REG_DEV_TYPE1_USB_OTG_MASK:
-			cable_type = SM5502_MUIC_ADC_OPEN_USB_OTG;
-			break;
 		default:
 			dev_dbg(info->dev,
 				"cannot identify the cable type: adc(0x%x)\n",
@@ -504,6 +581,34 @@ static int sm5502_parse_irq(struct sm5502_muic_info *info, int irq_type)
 	return 0;
 }
 
+static int sm5504_parse_irq(struct sm5502_muic_info *info, int irq_type)
+{
+	switch (irq_type) {
+	case SM5504_IRQ_INT1_ATTACH:
+		info->irq_attach = true;
+		break;
+	case SM5504_IRQ_INT1_DETACH:
+		info->irq_detach = true;
+		break;
+	case SM5504_IRQ_INT1_CHG_DET:
+	case SM5504_IRQ_INT1_DCD_OUT:
+	case SM5504_IRQ_INT1_OVP_EVENT:
+	case SM5504_IRQ_INT1_CONNECT:
+	case SM5504_IRQ_INT1_ADC_CHG:
+	case SM5504_IRQ_INT2_RID_CHG:
+	case SM5504_IRQ_INT2_UVLO:
+	case SM5504_IRQ_INT2_POR:
+	case SM5504_IRQ_INT2_OVP_FET:
+	case SM5504_IRQ_INT2_OCP_LATCH:
+	case SM5504_IRQ_INT2_OCP_EVENT:
+	case SM5504_IRQ_INT2_OVP_OCP_EVENT:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static irqreturn_t sm5502_muic_irq_handler(int irq, void *data)
 {
 	struct sm5502_muic_info *info = data;
@@ -672,11 +777,23 @@ static const struct sm5502_type sm5502_data = {
 	.irq_chip = &sm5502_muic_irq_chip,
 	.reg_data = sm5502_reg_data,
 	.num_reg_data = ARRAY_SIZE(sm5502_reg_data),
+	.otg_dev_type1 = SM5502_REG_DEV_TYPE1_USB_OTG_MASK,
 	.parse_irq = sm5502_parse_irq,
 };
 
+static const struct sm5502_type sm5504_data = {
+	.muic_irqs = sm5504_muic_irqs,
+	.num_muic_irqs = ARRAY_SIZE(sm5504_muic_irqs),
+	.irq_chip = &sm5504_muic_irq_chip,
+	.reg_data = sm5504_reg_data,
+	.num_reg_data = ARRAY_SIZE(sm5504_reg_data),
+	.otg_dev_type1 = SM5504_REG_DEV_TYPE1_USB_OTG_MASK,
+	.parse_irq = sm5504_parse_irq,
+};
+
 static const struct of_device_id sm5502_dt_match[] = {
 	{ .compatible = "siliconmitus,sm5502-muic", .data = &sm5502_data },
+	{ .compatible = "siliconmitus,sm5504-muic", .data = &sm5504_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sm5502_dt_match);
@@ -708,6 +825,7 @@ static SIMPLE_DEV_PM_OPS(sm5502_muic_pm_ops,
 
 static const struct i2c_device_id sm5502_i2c_id[] = {
 	{ "sm5502", (kernel_ulong_t)&sm5502_data },
+	{ "sm5504", (kernel_ulong_t)&sm5504_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sm5502_i2c_id);
diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
index d187205df7b3..9c04315d48e2 100644
--- a/drivers/extcon/extcon-sm5502.h
+++ b/drivers/extcon/extcon-sm5502.h
@@ -89,6 +89,13 @@ enum sm5502_reg {
 #define SM5502_REG_CONTROL_RAW_DATA_MASK	(0x1 << SM5502_REG_CONTROL_RAW_DATA_SHIFT)
 #define SM5502_REG_CONTROL_SW_OPEN_MASK		(0x1 << SM5502_REG_CONTROL_SW_OPEN_SHIFT)
 
+#define SM5504_REG_CONTROL_CHGTYP_SHIFT		5
+#define SM5504_REG_CONTROL_USBCHDEN_SHIFT	6
+#define SM5504_REG_CONTROL_ADC_EN_SHIFT		7
+#define SM5504_REG_CONTROL_CHGTYP_MASK		(0x1 << SM5504_REG_CONTROL_CHGTYP_SHIFT)
+#define SM5504_REG_CONTROL_USBCHDEN_MASK	(0x1 << SM5504_REG_CONTROL_USBCHDEN_SHIFT)
+#define SM5504_REG_CONTROL_ADC_EN_MASK		(0x1 << SM5504_REG_CONTROL_ADC_EN_SHIFT)
+
 #define SM5502_REG_INTM1_ATTACH_SHIFT		0
 #define SM5502_REG_INTM1_DETACH_SHIFT		1
 #define SM5502_REG_INTM1_KP_SHIFT		2
@@ -119,6 +126,36 @@ enum sm5502_reg {
 #define SM5502_REG_INTM2_STUCK_KEY_RCV_MASK	(0x1 << SM5502_REG_INTM2_STUCK_KEY_RCV_SHIFT)
 #define SM5502_REG_INTM2_MHL_MASK		(0x1 << SM5502_REG_INTM2_MHL_SHIFT)
 
+#define SM5504_REG_INTM1_ATTACH_SHIFT		0
+#define SM5504_REG_INTM1_DETACH_SHIFT		1
+#define SM5504_REG_INTM1_CHG_DET_SHIFT		2
+#define SM5504_REG_INTM1_DCD_OUT_SHIFT		3
+#define SM5504_REG_INTM1_OVP_EVENT_SHIFT	4
+#define SM5504_REG_INTM1_CONNECT_SHIFT		5
+#define SM5504_REG_INTM1_ADC_CHG_SHIFT		6
+#define SM5504_REG_INTM1_ATTACH_MASK		(0x1 << SM5504_REG_INTM1_ATTACH_SHIFT)
+#define SM5504_REG_INTM1_DETACH_MASK		(0x1 << SM5504_REG_INTM1_DETACH_SHIFT)
+#define SM5504_REG_INTM1_CHG_DET_MASK		(0x1 << SM5504_REG_INTM1_CHG_DET_SHIFT)
+#define SM5504_REG_INTM1_DCD_OUT_MASK		(0x1 << SM5504_REG_INTM1_DCD_OUT_SHIFT)
+#define SM5504_REG_INTM1_OVP_EVENT_MASK		(0x1 << SM5504_REG_INTM1_OVP_EVENT_SHIFT)
+#define SM5504_REG_INTM1_CONNECT_MASK		(0x1 << SM5504_REG_INTM1_CONNECT_SHIFT)
+#define SM5504_REG_INTM1_ADC_CHG_MASK		(0x1 << SM5504_REG_INTM1_ADC_CHG_SHIFT)
+
+#define SM5504_REG_INTM2_RID_CHG_SHIFT		0
+#define SM5504_REG_INTM2_UVLO_SHIFT		1
+#define SM5504_REG_INTM2_POR_SHIFT		2
+#define SM5504_REG_INTM2_OVP_FET_SHIFT		4
+#define SM5504_REG_INTM2_OCP_LATCH_SHIFT	5
+#define SM5504_REG_INTM2_OCP_EVENT_SHIFT	6
+#define SM5504_REG_INTM2_OVP_OCP_EVENT_SHIFT	7
+#define SM5504_REG_INTM2_RID_CHG_MASK		(0x1 << SM5504_REG_INTM2_RID_CHG_SHIFT)
+#define SM5504_REG_INTM2_UVLO_MASK		(0x1 << SM5504_REG_INTM2_UVLO_SHIFT)
+#define SM5504_REG_INTM2_POR_MASK		(0x1 << SM5504_REG_INTM2_POR_SHIFT)
+#define SM5504_REG_INTM2_OVP_FET_MASK		(0x1 << SM5504_REG_INTM2_OVP_FET_SHIFT)
+#define SM5504_REG_INTM2_OCP_LATCH_MASK		(0x1 << SM5504_REG_INTM2_OCP_LATCH_SHIFT)
+#define SM5504_REG_INTM2_OCP_EVENT_MASK		(0x1 << SM5504_REG_INTM2_OCP_EVENT_SHIFT)
+#define SM5504_REG_INTM2_OVP_OCP_EVENT_MASK	(0x1 << SM5504_REG_INTM2_OVP_OCP_EVENT_SHIFT)
+
 #define SM5502_REG_ADC_SHIFT			0
 #define SM5502_REG_ADC_MASK			(0x1f << SM5502_REG_ADC_SHIFT)
 
@@ -195,6 +232,9 @@ enum sm5502_reg {
 #define SM5502_REG_DEV_TYPE1_DEDICATED_CHG_MASK		(0x1 << SM5502_REG_DEV_TYPE1_DEDICATED_CHG_SHIFT)
 #define SM5502_REG_DEV_TYPE1_USB_OTG_MASK		(0x1 << SM5502_REG_DEV_TYPE1_USB_OTG_SHIFT)
 
+#define SM5504_REG_DEV_TYPE1_USB_OTG_SHIFT		0
+#define SM5504_REG_DEV_TYPE1_USB_OTG_MASK		(0x1 << SM5504_REG_DEV_TYPE1_USB_OTG_SHIFT)
+
 #define SM5502_REG_DEV_TYPE2_JIG_USB_ON_SHIFT		0
 #define SM5502_REG_DEV_TYPE2_JIG_USB_OFF_SHIFT		1
 #define SM5502_REG_DEV_TYPE2_JIG_UART_ON_SHIFT		2
@@ -273,4 +313,42 @@ enum sm5502_irq {
 #define SM5502_IRQ_INT2_STUCK_KEY_RCV_MASK	BIT(4)
 #define SM5502_IRQ_INT2_MHL_MASK		BIT(5)
 
+/* SM5504 Interrupts */
+enum sm5504_irq {
+	/* INT1 */
+	SM5504_IRQ_INT1_ATTACH,
+	SM5504_IRQ_INT1_DETACH,
+	SM5504_IRQ_INT1_CHG_DET,
+	SM5504_IRQ_INT1_DCD_OUT,
+	SM5504_IRQ_INT1_OVP_EVENT,
+	SM5504_IRQ_INT1_CONNECT,
+	SM5504_IRQ_INT1_ADC_CHG,
+
+	/* INT2 */
+	SM5504_IRQ_INT2_RID_CHG,
+	SM5504_IRQ_INT2_UVLO,
+	SM5504_IRQ_INT2_POR,
+	SM5504_IRQ_INT2_OVP_FET,
+	SM5504_IRQ_INT2_OCP_LATCH,
+	SM5504_IRQ_INT2_OCP_EVENT,
+	SM5504_IRQ_INT2_OVP_OCP_EVENT,
+
+	SM5504_IRQ_NUM,
+};
+
+#define SM5504_IRQ_INT1_ATTACH_MASK		BIT(0)
+#define SM5504_IRQ_INT1_DETACH_MASK		BIT(1)
+#define SM5504_IRQ_INT1_CHG_DET_MASK		BIT(2)
+#define SM5504_IRQ_INT1_DCD_OUT_MASK		BIT(3)
+#define SM5504_IRQ_INT1_OVP_MASK		BIT(4)
+#define SM5504_IRQ_INT1_CONNECT_MASK		BIT(5)
+#define SM5504_IRQ_INT1_ADC_CHG_MASK		BIT(6)
+#define SM5504_IRQ_INT2_RID_CHG_MASK		BIT(0)
+#define SM5504_IRQ_INT2_UVLO_MASK		BIT(1)
+#define SM5504_IRQ_INT2_POR_MASK		BIT(2)
+#define SM5504_IRQ_INT2_OVP_FET_MASK		BIT(4)
+#define SM5504_IRQ_INT2_OCP_LATCH_MASK		BIT(5)
+#define SM5504_IRQ_INT2_OCP_EVENT_MASK		BIT(6)
+#define SM5504_IRQ_INT2_OVP_OCP_EVENT_MASK	BIT(7)
+
 #endif /*  __LINUX_EXTCON_SM5502_H */
-- 
2.31.1

