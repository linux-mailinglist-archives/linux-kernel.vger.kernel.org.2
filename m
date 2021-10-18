Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD5432A74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 01:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhJRXvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 19:51:52 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:24790
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231454AbhJRXvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 19:51:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLo4XCqjtzXSeC2Brrd637b5KoI9F3bPR6m96E/P1Q/p9bPMiK6auJ5XMRGq975nNswtdogxPm403QPfhq2HVpNH0tEi6ptUjI99V3PieKUhCSV/7bBlw2uCcQlktor3eKRrjs8Ubk1sANhBtVWmxJy8RJLF7oiCcx1wftYkqABl3zyFnNAAuHY+bLPwbog/VJdhMDoim1X5qQm2ay3U1bO6tj1h9AQfDz1Nwsqj/c63MFcPetA8JQAUSl8XRk3yLNPbJ4d6f5ku7itFZ/iT7aOnBgwo46Yc80eqSP6hzTZD8+wS0lcOOulvYLXQv66IC1d39qy+ctdfjqfcqSpFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nvtO+27QYcgj+74xQJji1jJPqGvWEGmjwLyZMp29LA=;
 b=aV5u2lmGuO7HHTME6o2RShgL8VcsPwpptQAX44pjSHWKwJ1h9MbdLLjzbMBHZvCUzezGtkZ9djdAZzY2DMzvT3mMBwj8mfAmyRa6coRCndWaEh82cHZ3P+pMGtpcHhMkZes9z98TdtH1mV5v2fm3ABQ34waMwaDevvTFDe6bMS90daFaMUEWGQ2xkRdf7DuvrgpQKGwLsESq65qhBvwSUMUwi0TiuIXgidLGe2OCiVTIhEC2BDT5rFa5KKGAhYr4WdikVbGP1J66vPaFLnfvXZURlvQK+wwrtRfCh4Z3NtXeinJn+AvrbbvXtFOOTHZkXRX0G46HqhlHpPI0pKIfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nvtO+27QYcgj+74xQJji1jJPqGvWEGmjwLyZMp29LA=;
 b=6af0r+6gysuDSbmnUswBvst2iCkuAAjOwu1kuyBG1HYBKsoJy3NXiclHQjSgb3vhhyUwN+/DP6c0C47TdZDTba9eK4d82xPtSJPyn51/i2v9Z8A9yGqx4xrIl5lEHzj9pqZPp6xjs47amcQaA1s1d/l6H1WRI/Lx2Sf7E/+1c10=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6025.eurprd03.prod.outlook.com (2603:10a6:10:ed::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 23:49:34 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 23:49:34 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 2/2] reset: Add GPIO-based reset controller
Date:   Mon, 18 Oct 2021 19:49:22 -0400
Message-Id: <20211018234923.1769028-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211018234923.1769028-1-sean.anderson@seco.com>
References: <20211018234923.1769028-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:23a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 23:49:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c733dc5e-7abc-4fe6-1e60-08d99291efd3
X-MS-TrafficTypeDiagnostic: DB8PR03MB6025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB6025852A299F5848B40E47DC96BC9@DB8PR03MB6025.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaVwE5aU9DJXZbgiId45K3YLpYhWXxt8NWU/hK3gWU6Ncgyphdrgb/WFujyLUbVwRxhj2+acghvw1/qwkvXkKag7IhWzXTe0AtipBkPmSmCgS8/sEzsVKo1wpO8jLSEkCzvVjXT+G4mmNm83AfTwrNUzsu+touD5HKzV6ej1NhVov2Ai9fhTVrLiaCtDgGI0Q/Hr7bY673jf6QijGWKsPfFhZ1FU1AnFVVAbkfdp0hIBoeRjEaOF1LD0gpmKUk4TDuVwTI7A70Ci3MErBgFKOzBOyqczBygLvIg3b3g0FHNKePtlcqdpKjrN9JKFoRCI+oSljEf6yLN1YEhb47Mrpn64iozASZy8+X7OoCVHB8ibsmretw2/WQ4BiJRkeUgsg5Ddw/nONAnSNUyn+ekZ1vstsn4BsjIgAYv5RU+p1OVYP0+byrbXXEh91Er+TDp3PMx6nUAGZIry21uxTFKxdh6UUYqVM6tncJNKq0w5h7nDx/RMQSkyHPSHxGsflzN20fhukdmmoHRwM4FuE8ep7KbCHjumMtMAm7whSI9nWVUGWFusxwF95lq6aE5mmNlPKleFvGL4fGlxu6ycGpvmVnWDvWx5nfdvga0yYMO193XSeaOCgw46Aj4VHKjpkmNFcpnb1V/3x0TQyAjv9O2DMPNqznWnEmQhg8BlzA9tulMMlm9WCuqiMNHGw1aqrc3ZNNgjPLUCJ+pqXSQ11txAFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(956004)(38350700002)(38100700002)(6916009)(8936002)(186003)(2616005)(6506007)(4326008)(1076003)(44832011)(52116002)(316002)(6512007)(86362001)(2906002)(83380400001)(66476007)(66556008)(66946007)(6486002)(508600001)(8676002)(107886003)(5660300002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDW7FppQ+xLhvguySom2dt19M6t1oFV+4aJXBL4ulh9eIPn0VYOI1AsA2Ab/?=
 =?us-ascii?Q?CviOwVwxqov1pDAkyN2fyYTkATl9e7Pg1A8SWbvc+heiCiP7KeyA5xXK+zZg?=
 =?us-ascii?Q?sfyVtDJU4q++TkE9pgBx9pqshI1n9XB535coKCN4z5A3WBhrKVFYZYrawAgm?=
 =?us-ascii?Q?+TWzbj1pqjKIgXBEjmrpxCB0D7h3DSO5n8w7D/tZHDrvm5GVeM3hQTNpdivC?=
 =?us-ascii?Q?lyigjaoHSAOTmxkVEw15me1oyTSFkTX/EdvSle5V/VGryqUKkXNnwdnBY2NP?=
 =?us-ascii?Q?/EiRTwQ8F3KQvJ4dkz1jB6nCv+ElFmfulObKZyHlmk9XgTu4dG96KRupjPxT?=
 =?us-ascii?Q?jTj7LU3C51qOuIXWGoFj9bOCCVOdEMGMxb+15pCVrXQdgMfb4OvN+CLaSt2z?=
 =?us-ascii?Q?SWFOOxai9xv4wkaIPoZ/INE/pHsQMG/WzhBWCFBKxtMOmobZyBYXrXZ8aImg?=
 =?us-ascii?Q?my/r3HjN0CZQdZFlgFZakRvn/Yi8b7FB04hWr2MZAw6L1Lz10y/MPyWCowMF?=
 =?us-ascii?Q?nmx+JE4sk8gID3JgWkv5pD5mJEsFATPUv835x8iyOsAzvxSfJOZJG5jhcj8Y?=
 =?us-ascii?Q?7x00j/rp/inyIDZa1HMbejUtnzvUnqGHeVTZCUZiUlYnvQC8lwLxasSNk6OL?=
 =?us-ascii?Q?MQayD8l2nOlPFk6+8HO244ud5LGw1yyj8Am8ChXA1bW2DX4IEyhEeZ6xfFrU?=
 =?us-ascii?Q?0uLogtzD8xfCONsmmx0NRXUkEzq7GBd8jqyIM/6sPh/0Al/LUoIjG3Cs5kE5?=
 =?us-ascii?Q?rfYQOJzfnRtz2IU/QM4P81H86oQ/X7zepVdORStZaWdSFrYWcwhdZlBPUk9U?=
 =?us-ascii?Q?kLHzyniOCVO/jCSNS43yU+vdl06z7/YwR5EvI8NWw53L9GXfNd0ksyaWgGxF?=
 =?us-ascii?Q?mASMyaFGRilrdpUe6FV0h8aC6n+LP+vLLRUAwLD2XQOnjxB9myPTg0ai+anr?=
 =?us-ascii?Q?ZeA5/r48VVoXoQuMsezsq8OoFyvYAi+nMFPOUGI3NchLWWMVwgerHJHFsA+F?=
 =?us-ascii?Q?x3NITPieFPpvFoS8ZK7eP7g2ktlPl4uC6iw3/Xs+2l9hOeHNlVRqpJO9rnHx?=
 =?us-ascii?Q?SIhg+R+uY//4P8TlTwpC9C+S+lo90hc9vxf4PXT0AXf8BL90Oivlyfa0qjbk?=
 =?us-ascii?Q?y+zFov7LaBIRJIVCka2LHGtKp8mD5hSgTysNOoYR+/gZdThUJw2jp/RDvlVX?=
 =?us-ascii?Q?xyT5OcNKppZPmGRjdNegkCUBu64C/fTq2CW7B2OjMmp/LBF2PTzFvv0329iy?=
 =?us-ascii?Q?KHQ7Qd/lLVibw2DCZo3PLcBkg1mJFCxn4bfnP8Sfk0ecj0X3TAldhSMxeCId?=
 =?us-ascii?Q?42tZXFWY+qu8VyuGKPWP/vAR?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c733dc5e-7abc-4fe6-1e60-08d99291efd3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 23:49:34.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kyr0KX0BOOpJym5jzN1QUH0UzSiZDYlQBxJ+0oWVT3JtIYuq1fhaWWvdAxUUDhQ7/YrZy7wLDbS9kbsRXi8tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a driver to control GPIO-based resets using the reset
controller API. This allows using a common interface for devices which
may have both GPIO resets and reset controllers, depending on the
configuration. It also allows for easier sharing of reset GPIOs in the
case where one GPIO is a reset for multiple devices.

There are several properties for specifying pre/post-(de)assert delays.
This device can also use a "reset done" GPIO, for cases when such a GPIO
is provided by the device being reset. This can be useful when the
datasheet does not otherwise specify reset timings, or specifies a much
longer maximum reset delay than the typical delay.

There is one queue for waiters on done GPIOs. I don't anticipate there
being a penalty from this, since there will likely only be concurrent
waiters during startup. I believe that wait_event_idle_timeout is the
correct function to use here, but there are a lot of variants of this
function, so I am not completely sure it is the best.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 MAINTAINERS                |   5 +
 drivers/reset/Kconfig      |  11 ++
 drivers/reset/Makefile     |   1 +
 drivers/reset/reset-gpio.c | 223 +++++++++++++++++++++++++++++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 drivers/reset/reset-gpio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d118d7957d2..0a54c4dd83d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7813,6 +7813,11 @@ F:	Documentation/i2c/muxes/i2c-mux-gpio.rst
 F:	drivers/i2c/muxes/i2c-mux-gpio.c
 F:	include/linux/platform_data/i2c-mux-gpio.h
 
+GENERIC GPIO RESET DRIVER
+M:	Sean Anderson <seanga2@gmail.com>
+S:	Supported
+F:	drivers/reset/reset-gpio.c
+
 GENERIC HDLC (WAN) DRIVERS
 M:	Krzysztof Halasa <khc@pm.waw.pl>
 S:	Maintained
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index be799a5abf8a..24888005baf8 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -66,6 +66,17 @@ config RESET_BRCMSTB_RESCAL
 	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
 	  BCM7216.
 
+config RESET_GPIO
+	tristate "GPIO reset controller"
+	depends on OF
+	help
+	  This enables a generic controller for resets attached via GPIOs. It
+	  may be used to add GPIO resets to drivers which expect a reset
+	  controller. It supports adding delays and waiting for a "done" GPIO
+	  to be asserted.
+
+	  If compiled as module, it will be called reset-gpio.
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 21d46d8869ff..f577ec16fd93 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
+obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
new file mode 100644
index 000000000000..93d3dbb150e0
--- /dev/null
+++ b/drivers/reset/reset-gpio.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * This driver controls GPIOs used to reset device(s). It may be used for when
+ * there is a need for more complex behavior than a simple reset-gpios
+ * property. It may also be used to unify code paths between device-based and
+ * gpio-based resets.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+
+/**
+ * struct reset_gpio_priv - Private data for GPIO reset driver
+ * @rc: Reset controller for this driver
+ * @done_queue: Queue to wait for changes on done GPIOs. Events occur whenever
+ *              the value of any done GPIO changes. Valid only when @done is
+ *              non-%NULL.
+ * @reset: Array of gpios to use when (de)asserting resets
+ * @done: Array of gpios to determine whether a reset has finished; may be
+ *        %NULL
+ * @done_timeout_jiffies: Timeout when waiting for a done GPIO to be asserted, in jiffies
+ * @post_assert_delay: Time to wait after asserting a reset, in us
+ * @post_deassert_delay: Time to wait after deasserting a reset, in us
+ */
+struct reset_gpio_priv {
+	struct reset_controller_dev rc;
+	struct wait_queue_head done_queue;
+	struct gpio_descs *reset;
+	struct gpio_descs *done;
+	unsigned long done_timeout_jiffies;
+	u32 pre_assert_delay;
+	u32 post_assert_delay;
+	u32 pre_deassert_delay;
+	u32 post_deassert_delay;
+};
+
+static inline struct reset_gpio_priv
+*rc_to_reset_gpio(struct reset_controller_dev *rc)
+{
+	return container_of(rc, struct reset_gpio_priv, rc);
+}
+
+static int reset_gpio_assert(struct reset_controller_dev *rc, unsigned long id)
+{
+	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
+
+	if (priv->pre_assert_delay)
+		fsleep(priv->pre_assert_delay);
+	gpiod_set_value_cansleep(priv->reset->desc[id], 1);
+	if (priv->post_assert_delay)
+		fsleep(priv->post_assert_delay);
+	return 0;
+}
+
+static int reset_gpio_deassert(struct reset_controller_dev *rc,
+			       unsigned long id)
+{
+	int ret = 0;
+	unsigned int remaining;
+	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
+
+	if (priv->pre_deassert_delay)
+		fsleep(priv->pre_deassert_delay);
+	gpiod_set_value_cansleep(priv->reset->desc[id], 0);
+	if (priv->post_deassert_delay)
+		fsleep(priv->post_deassert_delay);
+
+	if (!priv->done)
+		return 0;
+
+	remaining = wait_event_idle_timeout(
+		priv->done_queue,
+		(ret = gpiod_get_value_cansleep(priv->done->desc[id])),
+		priv->done_timeout_jiffies);
+	dev_dbg(rc->dev, "%s: remaining=%u\n", __func__, remaining);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		return 0;
+	return -ETIMEDOUT;
+}
+
+static int reset_gpio_reset(struct reset_controller_dev *rc, unsigned long id)
+{
+	int ret = reset_gpio_assert(rc, id);
+
+	if (!ret)
+		return ret;
+
+	return reset_gpio_deassert(rc, id);
+}
+
+static int reset_gpio_status(struct reset_controller_dev *rc, unsigned long id)
+{
+	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
+
+	return gpiod_get_value_cansleep(priv->reset->desc[id]);
+}
+
+static const struct reset_control_ops reset_gpio_ops = {
+	.reset = reset_gpio_reset,
+	.assert = reset_gpio_assert,
+	.deassert = reset_gpio_deassert,
+	.status = reset_gpio_status,
+};
+
+static irqreturn_t reset_gpio_irq(int irq, void *data)
+{
+	struct reset_gpio_priv *priv = data;
+
+	wake_up(&priv->done_queue);
+	return IRQ_HANDLED;
+}
+
+static int reset_gpio_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct reset_gpio_priv *priv;
+	u32 done_timeout_us;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, priv);
+
+	/* A short macro to reduce repetitive error handling */
+#define read_delay(propname, val) do { \
+	ret = of_property_read_u32(dev->of_node, (propname), &(val)); \
+	if (ret == -EINVAL) \
+		(val) = 0; \
+	else if (ret) \
+		return dev_err_probe(dev, ret, \
+				     "Could not read %s\n", propname); \
+} while (0)
+
+	read_delay("pre-assert-us", priv->pre_assert_delay);
+	read_delay("post-assert-us", priv->post_assert_delay);
+	read_delay("pre-deassert-us", priv->pre_deassert_delay);
+	read_delay("post-deassert-us", priv->post_deassert_delay);
+
+	ret = of_property_read_u32(np, "done-timeout-us", &done_timeout_us);
+	if (ret == -EINVAL) {
+		if (priv->post_deassert_delay)
+			done_timeout_us = 10 * priv->post_deassert_delay;
+		else
+			done_timeout_us = 1000;
+	} else if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not read done timeout\n");
+	priv->done_timeout_jiffies = usecs_to_jiffies(done_timeout_us);
+
+	priv->reset = devm_gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(dev, PTR_ERR(priv->reset),
+				     "Could not get reset gpios\n");
+
+	priv->done = devm_gpiod_get_array_optional(dev, "done",
+						   GPIOD_IN);
+	if (IS_ERR(priv->done))
+		return dev_err_probe(dev, PTR_ERR(priv->done),
+				     "Could not get done gpios\n");
+	if (priv->done) {
+		int i;
+
+		if (priv->reset->ndescs != priv->done->ndescs)
+			return dev_err_probe(dev, -EINVAL,
+					     "Number of reset and done gpios does not match\n");
+		init_waitqueue_head(&priv->done_queue);
+		for (i = 0; i < priv->done->ndescs; i++) {
+			ret = gpiod_to_irq(priv->done->desc[i]);
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
+						     "Could not convert GPIO to IRQ\n");
+
+			ret = devm_request_irq(dev, ret, reset_gpio_irq,
+					       IRQF_SHARED, dev_name(dev),
+					       priv);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Could not request IRQ\n");
+		}
+	}
+
+	priv->rc.ops = &reset_gpio_ops;
+	priv->rc.owner = THIS_MODULE;
+	priv->rc.dev = dev;
+	priv->rc.of_node = np;
+	priv->rc.nr_resets = priv->reset->ndescs;
+	ret = devm_reset_controller_register(dev, &priv->rc);
+	if (!ret)
+		dev_info(dev, "probed with %u resets\n", priv->reset->ndescs);
+	return ret;
+}
+
+static const struct of_device_id reset_gpio_of_match[] = {
+	{ .compatible = "gpio-reset", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, reset_gpio_of_match);
+
+static struct platform_driver reset_gpio_driver = {
+	.probe = reset_gpio_probe,
+	.driver = {
+		.name = "gpio-reset",
+		.of_match_table = of_match_ptr(reset_gpio_of_match),
+	},
+};
+module_platform_driver(reset_gpio_driver);
+
+MODULE_ALIAS("platform:gpio-reset");
+MODULE_DESCRIPTION("Generic GPIO reset driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

