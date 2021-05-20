Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB9038ACD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbhETLtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:49:31 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:13617 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbhETL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621509959; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QdQGoosK5eEGMVA7/yRACZ9FVNifkr2uaBXA7X7Fj3OUsXRJbh+zR7z4IE+3p0Eas6
    CNQz0YCIJwZmu252OcgfzTuZWtvB54AAHBDz7XkmEnuhIt1nqROWlyE5mAms/2t1uRu0
    BZEzs4M/S8/ktMUjCFOCh+F0j14y/sG4kB2c4iDnNzuDxYrBYUMqittnzsTXHnDDjj3R
    +mhTCMZfeze9JjlIbehMeww8pjAop2IxEsmUbDtZ6Ab3q5N3cTCsBlvSpnAserwGJyJ3
    ktj29lpXAp/SIuPmFxYI0gKZ5Jc9rcqMYKA2wyg3npHHt4QyVHcu7uqIKi6t2a6QfwxC
    XO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509959;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kw7a0RxRU8YCQxK+PGjEsWQ+2SyP8ysJNAGd1toqkRU=;
    b=JOqd3gOjtOceKjce8HTx5vhrkN2R9RNMIqTbFZxxmPvla3sYc11B/mnSoCB0jgv9gd
    P124nFmo/68HVcAgvidQNAKYeWgMFQ1ySSRglRkAf7h3rXnowzEs/d1+4JPf4bsXRBMv
    jXD5k5JNL0yc5kuhDsi19SyIWUYroxbgai1m5haeTKq/7Fj5lQQjpiSozw7tMim7ygJ2
    toAYDj5Dq8ffQ0NbxLKMIRxUe9vZH6VDt09IEJcu0VOtfujlXfxGf9F3NJN7ToPH4y/i
    NcgXC0Xq10sYFg0UGQebpH4+K1tXcV9oTrgbmaulM3SmO+9+5HPe0N8otBjNT9+amI3A
    3UEg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509959;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kw7a0RxRU8YCQxK+PGjEsWQ+2SyP8ysJNAGd1toqkRU=;
    b=dkkH2e80pHsdqIHfpu2NF6Y/RUIHJpIJfrotYbqA39RC5pWzdEEIoy5+UgV21C8r+S
    IVCN1XUvE59KvbwbjN7AkWUbOU0AbZDHc26yk2c/bzEuCgoKKfZOcuG8Y/s3hF0EfUqI
    1VbXcuokhYlYgIdfUE+NxAXs7jF3GBe1ZTkuvcHCfVSZ5Mu54YfQ6Ce6Qk92rwRVU1kv
    IkXq8nOI4+nj0skjqiWRoBEXECk3Im76MZOohi1GzkRFRyycpzlRPSwIw0sOVLEBMV6T
    kCDaODFIomYoBT9DSez2KPaihvtnSvt9RjjZ7BSNcWIdGsD1Pz//DQ87mX0U+eSdfZBC
    OG2Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6FtFQ="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id 400bd8x4KBPw22Y
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 May 2021 13:25:58 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 6/6] extcon: sm5502: Add support for SM5504
Date:   Thu, 20 May 2021 13:23:34 +0200
Message-Id: <20210520112334.129556-7-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520112334.129556-1-stephan@gerhold.net>
References: <20210520112334.129556-1-stephan@gerhold.net>
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

Overall it's minor and we can support this using the existing
enum sm5502_types plus a few switch/if statements.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Interestingly enough the register set (and especially the interrupts)
also look *very* similar to Richtek RT8973A (extcon-rt8973a) but
I didn't investigate this further.

Note that the changes in this patch are mostly based on guesswork
based on a SM5504 driver from Nitin Chaudhary [1] used in some Samsung
vendor kernels, since I was not able to find a public datasheet for SM5504.

[1]: https://github.com/NitinChaudharyUSC/MSM8x16_8x26/blob/master/drivers/misc/sm5504.c
---
 drivers/extcon/Kconfig         |   2 +-
 drivers/extcon/extcon-sm5502.c | 164 +++++++++++++++++++++++++++++----
 drivers/extcon/extcon-sm5502.h |  79 ++++++++++++++++
 3 files changed, 228 insertions(+), 17 deletions(-)

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
index 9f40bb9f1f81..9d8f208c68cc 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -40,6 +40,7 @@ struct sm5502_muic_info {
 	struct i2c_client *i2c;
 	struct regmap *regmap;
 
+	enum sm5502_types type;
 	struct regmap_irq_chip_data *irq_data;
 	struct muic_irq *muic_irqs;
 	unsigned int num_muic_irqs;
@@ -90,6 +91,33 @@ static struct reg_data sm5502_reg_data[] = {
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
@@ -198,6 +226,55 @@ static const struct regmap_irq_chip sm5502_muic_irq_chip = {
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
@@ -276,9 +353,14 @@ static int sm5502_muic_set_path(struct sm5502_muic_info *info,
 /* Return cable type of attached or detached accessories */
 static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 {
-	unsigned int cable_type, adc, dev_type1;
+	unsigned int cable_type, adc, dev_type1, otg_dev_type1;
 	int ret;
 
+	if (info->type == TYPE_SM5504)
+		otg_dev_type1 = SM5504_REG_DEV_TYPE1_USB_OTG_MASK;
+	else
+		otg_dev_type1 = SM5502_REG_DEV_TYPE1_USB_OTG_MASK;
+
 	/* Read ADC value according to external cable or button */
 	ret = regmap_read(info->regmap, SM5502_REG_ADC, &adc);
 	if (ret) {
@@ -301,11 +383,9 @@ static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 			return ret;
 		}
 
-		switch (dev_type1) {
-		case SM5502_REG_DEV_TYPE1_USB_OTG_MASK:
+		if (dev_type1 == otg_dev_type1) {
 			cable_type = SM5502_MUIC_ADC_GROUND_USB_OTG;
-			break;
-		default:
+		} else {
 			dev_dbg(info->dev,
 				"cannot identify the cable type: adc(0x%x), dev_type1(0x%x)\n",
 				adc, dev_type1);
@@ -358,6 +438,11 @@ static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 			return ret;
 		}
 
+		if (dev_type1 == otg_dev_type1) {
+			cable_type = SM5502_MUIC_ADC_OPEN_USB_OTG;
+			break;
+		}
+
 		switch (dev_type1) {
 		case SM5502_REG_DEV_TYPE1_USB_SDP_MASK:
 			cable_type = SM5502_MUIC_ADC_OPEN_USB;
@@ -365,9 +450,6 @@ static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 		case SM5502_REG_DEV_TYPE1_DEDICATED_CHG_MASK:
 			cable_type = SM5502_MUIC_ADC_OPEN_TA;
 			break;
-		case SM5502_REG_DEV_TYPE1_USB_OTG_MASK:
-			cable_type = SM5502_MUIC_ADC_OPEN_USB_OTG;
-			break;
 		default:
 			dev_dbg(info->dev,
 				"cannot identify the cable type: adc(0x%x)\n",
@@ -497,6 +579,34 @@ static int sm5502_parse_irq(struct sm5502_muic_info *info, int irq_type)
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
@@ -506,7 +616,10 @@ static irqreturn_t sm5502_muic_irq_handler(int irq, void *data)
 		if (irq == info->muic_irqs[i].virq)
 			irq_type = info->muic_irqs[i].irq;
 
-	ret = sm5502_parse_irq(info, irq_type);
+	if (info->type == TYPE_SM5504)
+		ret = sm5504_parse_irq(info, irq_type);
+	else
+		ret = sm5502_parse_irq(info, irq_type);
 	if (ret < 0) {
 		dev_warn(info->dev, "cannot handle is interrupt:%d\n",
 				    irq_type);
@@ -565,6 +678,7 @@ static void sm5502_init_dev_type(struct sm5502_muic_info *info)
 static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
 {
 	struct device_node *np = i2c->dev.of_node;
+	const struct regmap_irq_chip *irq_chip;
 	struct sm5502_muic_info *info;
 	int i, ret, irq_flags;
 
@@ -579,10 +693,26 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
 	info->dev = &i2c->dev;
 	info->i2c = i2c;
 	info->irq = i2c->irq;
-	info->muic_irqs = sm5502_muic_irqs;
-	info->num_muic_irqs = ARRAY_SIZE(sm5502_muic_irqs);
-	info->reg_data = sm5502_reg_data;
-	info->num_reg_data = ARRAY_SIZE(sm5502_reg_data);
+	info->type = (enum sm5502_types)device_get_match_data(info->dev);
+
+	switch (info->type) {
+	case TYPE_SM5502:
+		irq_chip = &sm5502_muic_irq_chip;
+		info->muic_irqs = sm5502_muic_irqs;
+		info->num_muic_irqs = ARRAY_SIZE(sm5502_muic_irqs);
+		info->reg_data = sm5502_reg_data;
+		info->num_reg_data = ARRAY_SIZE(sm5502_reg_data);
+		break;
+	case TYPE_SM5504:
+		irq_chip = &sm5504_muic_irq_chip;
+		info->muic_irqs = sm5504_muic_irqs;
+		info->num_muic_irqs = ARRAY_SIZE(sm5504_muic_irqs);
+		info->reg_data = sm5504_reg_data;
+		info->num_reg_data = ARRAY_SIZE(sm5504_reg_data);
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	mutex_init(&info->mutex);
 
@@ -598,8 +728,8 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
 
 	/* Support irq domain for SM5502 MUIC device */
 	irq_flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT | IRQF_SHARED;
-	ret = devm_regmap_add_irq_chip(info->dev, info->regmap, info->irq, irq_flags,
-				       0, &sm5502_muic_irq_chip, &info->irq_data);
+	ret = devm_regmap_add_irq_chip(info->dev, info->regmap, info->irq,
+				       irq_flags, 0, irq_chip, &info->irq_data);
 	if (ret != 0) {
 		dev_err(info->dev, "failed to request IRQ %d: %d\n",
 				    info->irq, ret);
@@ -660,7 +790,8 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id sm5502_dt_match[] = {
-	{ .compatible = "siliconmitus,sm5502-muic" },
+	{ .compatible = "siliconmitus,sm5502-muic", .data = (void *)TYPE_SM5502 },
+	{ .compatible = "siliconmitus,sm5504-muic", .data = (void *)TYPE_SM5504 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sm5502_dt_match);
@@ -692,6 +823,7 @@ static SIMPLE_DEV_PM_OPS(sm5502_muic_pm_ops,
 
 static const struct i2c_device_id sm5502_i2c_id[] = {
 	{ "sm5502", TYPE_SM5502 },
+	{ "sm5504", TYPE_SM5504 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sm5502_i2c_id);
diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
index ce1f1ec310c4..0ce00274ed86 100644
--- a/drivers/extcon/extcon-sm5502.h
+++ b/drivers/extcon/extcon-sm5502.h
@@ -10,6 +10,7 @@
 
 enum sm5502_types {
 	TYPE_SM5502,
+	TYPE_SM5504,
 };
 
 /* SM5502 registers */
@@ -93,6 +94,13 @@ enum sm5502_reg {
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
@@ -123,6 +131,36 @@ enum sm5502_reg {
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
 
@@ -199,6 +237,9 @@ enum sm5502_reg {
 #define SM5502_REG_DEV_TYPE1_DEDICATED_CHG_MASK		(0x1 << SM5502_REG_DEV_TYPE1_DEDICATED_CHG_SHIFT)
 #define SM5502_REG_DEV_TYPE1_USB_OTG_MASK		(0x1 << SM5502_REG_DEV_TYPE1_USB_OTG_SHIFT)
 
+#define SM5504_REG_DEV_TYPE1_USB_OTG_SHIFT		0
+#define SM5504_REG_DEV_TYPE1_USB_OTG_MASK		(0x1 << SM5504_REG_DEV_TYPE1_USB_OTG_SHIFT)
+
 #define SM5502_REG_DEV_TYPE2_JIG_USB_ON_SHIFT		0
 #define SM5502_REG_DEV_TYPE2_JIG_USB_OFF_SHIFT		1
 #define SM5502_REG_DEV_TYPE2_JIG_UART_ON_SHIFT		2
@@ -277,4 +318,42 @@ enum sm5502_irq {
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

