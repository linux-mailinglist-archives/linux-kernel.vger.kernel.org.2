Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B8436D8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbhD1Nvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:51:43 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:34482
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240017AbhD1Nvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:51:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVtmmhLnBeEGqCXU50LY7xz+kPEPBoBY9/kWHFMKXFfso+ltLlZ6DNMvXaWRnMxJThg311OQjZ04HLZlr1jLDawWaQ0TVFwKf0gE8p9SOv7/PbpT83MffzxRRLV9HdgPwAQI/iMRMJlEpWu9j+/7xjtiyfHMoJRLvcf7rDlGcP6sAj0D7pNli7gxyLWo1XekoQ3wEUFPURT6+g+J6XWhBmbtVyN+S7Q6AR9rJRsAsUAMfErDRpBAHbysymKNiMDPbzc8sYVHNR4RNgy5JIG7lx9hc4RGkbW3GHvWMyEKpAMkMEUJwEKq2Q/CrSfzHBvXPtNR4vrpxXQOBWVOMc4GsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxSWi+oRrTUtnImFGOpgwPVk/Kvbo89mJy2eQDQZVtM=;
 b=BvtF5FaiWw0tJCI90iKtebyGthOPPkzfPsNq6lzEsoL1g06AUTTR2XbYQcwRau2NIxRzymy5UTi2czBR9YhUAqoTW/r8AHBJN9hcMNggbPkwfDZGSxu2XesEbDVT3A1OrE+/S44NnT10/pz1p+laSCfC+fpz/jmj4yrTpo4kOcgXgVuzXxeCPKj5Gn7xdcfCcB+nepv6/8DxapPBCvhSaPGUGG795Z5aPUSoGs5zJESfLIAUFKxIrMuoUQcGDcQjUVd5tVDmVj5nwZ7vGorFtJ8Db2xtV3LSmEK7qXlBMLhOO/vLA8eA2UlN0WEbWOYx1ClH1SOgbRdOIaYty1P/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxSWi+oRrTUtnImFGOpgwPVk/Kvbo89mJy2eQDQZVtM=;
 b=oEfQgZdcESJoQVzwEOzjnacFHe0gpM7GNSZ6XpkmW4x+mUomgSa8N8wqk5QGIWj892feKn2OXrP2DCdkTaUkA0Wy982rgtWOCr+bJhGv9rQzUjuXBrR9DdpheMBHAj4fyAb0bjSwNzniZ3oOMNYjwVylMdKKfKMu4wAr/7v6l9VhNC4xfqJiwpoL9wWiX+fC0jyNRZm8ShP5e4ZpGoQgHG4dzmmeq34ZmnU4nCenjeV1Ho/2Cu0zLiM5wci36y2LA1kLaHMBqHQgd8xxTS6tgPsJtqDb/OQ55Nh4sMCcdVKJnnw2WLMco2tbK29x+8apcQQm1xX4Ni71uN6Bq/7GWw==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2361.eurprd06.prod.outlook.com (2603:10a6:3:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Wed, 28 Apr
 2021 13:50:50 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 13:50:50 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>,
        =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v2 2/4] nvmem: bootcount: add bootcount driver
Date:   Wed, 28 Apr 2021 16:50:39 +0300
Message-Id: <29092688ae0199b29247f145928f7a3fc1ee1248.1619617498.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619617498.git.nandor.han@vaisala.com>
References: <cover.1619617498.git.nandor.han@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.136.150.171]
X-ClientProxiedBy: HE1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:3:64::11) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (37.136.150.171) by HE1PR0701CA0067.eurprd07.prod.outlook.com (2603:10a6:3:64::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend Transport; Wed, 28 Apr 2021 13:50:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c801b994-8934-46f9-398b-08d90a4ca23c
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2361:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB23619424860A97FA29A6B54D85409@HE1PR0601MB2361.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1jQXPHEG80TPLrpEnBLv1xmrWL66k3dcUERWbhDJQNyAN8Q3ZDy7OkB83PkDeDygUmwCFARDdPIuU6LdDfAmLc38KCxKLJOhNFLKEcSwNss9MO+DoNxLUo23rb45V5PYd4ABrD1hp9h274uA18smVsuGDqeRNwjG1dXdpe7dMs7IUmDezMJE45P5oP2KlRea73ebDfFCQPLeuaHRjyBtdkPIQpSi09uLVhzTHUVGl1q/41WXCQyp/DOSxK2Fp3tlctbQs09CNtV7t1vOmd4jq8fKKhJKlFooQoGGDq4kRESi2GBnC9oFTY0Wlalq5NGRhDOE3Y0Kne+PbhFGScAPhZ2jZEPrTo0u99CoaDY1E/wVpvKKA8F30+xZKpbE5uF3UzIbVaCQYXGyD3Jgj2HsFOll0PhHOgYqV7S8LfGL2hXR2hR0MfnwtKoXHL3f45aDy2RYFUy8Kc618abuYfgNANp7MYdiP673k8dUKS8Od2RQeyYZEbKkB6n1cnplUox3zE5JGfq0jDFEFWRaOSHrTrxiML6xcQbW92rxNTZLuHS+g4csScATa3teI2okDjcyeEotqaNhDIK3rcESAr0k9zxyNPyYj5bzL3q1Nd9wzjEWTxDtLt/1BVqyIgl3mDJIBYu4tG/zSpKCBUtqjMBRyfdkm2ZMTC5ChgdHGxj9DVyZuFQb8UU6PKO2LNvOI7UKVEfWAeWwcB0hs2rGUzAi0kcdhbV7sXqRNW1zfUeWHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(5660300002)(2616005)(86362001)(6486002)(66556008)(26005)(2906002)(107886003)(66476007)(44832011)(66574015)(8676002)(956004)(83380400001)(8936002)(4326008)(186003)(966005)(54906003)(52116002)(316002)(38100700002)(66946007)(36756003)(7696005)(6666004)(16526019)(478600001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUJ5QkxGWHFyZFVhVmNIaTBYZUR6ZWNnQit4ZUNCdnNIVFovTTVjOUFyZGZy?=
 =?utf-8?B?NllmQVZjS1k4c3RkNmVOYi9qNXl6cXZvcnNaWkVQWDd4MC81b2lNdHIxcHpz?=
 =?utf-8?B?MmQralRwSE9sbzMwSHlacmJpODRhNTYzRWxLZGdyTTdhMTlRM09KUmxMTUhw?=
 =?utf-8?B?OExyVXZaTENFT2ZjRzh3cXRxeHl6TTYyNysyVTVOLzYzYXQ4anUzYkhJMmNX?=
 =?utf-8?B?V3pxZkhBNDNZNGozU29USk1od2FJY3dic0NYVExiWHBXN0M3ZXlOV21aOFhT?=
 =?utf-8?B?dENoZlR4eE5Ua3NJMFd1SytFR3FkOXExMzNxOVBBcXV3bUMvRmE1MDI1THQy?=
 =?utf-8?B?b1dMY3gvbFdsZlFLWlBBY2JkdXNlWnd5bkZteVpDT29YZWNaMERENktNYk5W?=
 =?utf-8?B?NzdHQTB2QSs2a0NCWVBtL0dHNWM0dTJqQ05mYUt6VWhTUHlwY3dqNjhraUow?=
 =?utf-8?B?RjFrWnM3YWdubUpMVDB6NC96Z0ZDVFNvamhkdjVSSUVBendPMi9sQ3pzSU9H?=
 =?utf-8?B?Ym9BdUNOUkxIKy9GcjE1aUhWMVVjWWI5MVovcS9EcUZRNjFWdjF5WVNUM1Jm?=
 =?utf-8?B?bWpIUUNsRWRrQTZvaS84MDRyclN1Y0dkODlseUpHcjhHSWgzUklMWUs0cWhi?=
 =?utf-8?B?UmszaWhYNGRjS3YzUDN6OUZRUGVzWXc5NVJOSG43N2JoUmRVbUlXVGNpT2pW?=
 =?utf-8?B?QUkrTnR1YVZ6MWoxNzdpL2pibkM4NzhDaGV3Wlo4UE1KUGo1YWg1WHJqT0t4?=
 =?utf-8?B?enVldkZMK1FnMFFLemt1aG9KN3o2NFNocTZzVml6S0k1MnZ4bFNCUW02aC9K?=
 =?utf-8?B?WFVjRjJqalZIUXl4RkVwajVmOWZWNDE1VHp2d0YyMFA4T0ZrZXdyc1JLWnBF?=
 =?utf-8?B?RzRYWWVGc0U1N25aaGhNTDdZN2VaeDZINzJBWEpWSHJ1S1VLRW1NN2M3cEN2?=
 =?utf-8?B?QXA1WEkyYzU2bk5Ic2hoQ3Boa1A2WGtxQzVJQWhMQjRPMjlOWEFhWW9jQWNB?=
 =?utf-8?B?d3VzaldtTXJuN1grdVZvWWdLTmREMUlVUmMrdXhoOWZSSDl1bW5SMmdVa1oy?=
 =?utf-8?B?d1A1ZTlCeTRJaXFwcU56S3VtZi92a2dOM2t6UmxEOThYV21jZFhCcU5TaGhT?=
 =?utf-8?B?QURjaDVRWk1WMWExK1ZKN3RXdWpQZjNNQjhmSENSemZLUzdld2YxVFdWWEZN?=
 =?utf-8?B?VDFub0VLajVEbUN6ZEF4RmZkMXJBajJ0QUNhZG5zY1h5V3RYMURmM216TUFS?=
 =?utf-8?B?dVJ0R0xsUHFhaVoyRGxNeUVFNFpRUllrZmNMb3RsN1Rzd2RvUEVXeENnQ3dw?=
 =?utf-8?B?MWJkQjVmeTJleWQrTGRKN3FSTHJlblF5UndxUUl4eGQwNWNXVlJ1RVRCTUdX?=
 =?utf-8?B?dytJZXdrblJEQi9iQm9uTHV5WjFGYUhUVG1wazJvZUNjZ3BaUlNKVzhnNEhG?=
 =?utf-8?B?TUpuM0Zvdm5ieVR6a0xPWUhMOFJLMXZybEdBMHhLT1lPNktSWk9KSzNNSHNi?=
 =?utf-8?B?UHMwdjVkME9LamZqcko0RHdmc2NMYUgxL3ZIUUVJVXo1WTVBUkcvZUUyeW00?=
 =?utf-8?B?bmM5TlRZbEtmblhaemExd0VTT05EZk00K1BjNTVnNjBIdjlsMVFnbU9hV1BW?=
 =?utf-8?B?bU5SM0ZTc1d3OE84Z1JCc0J2ZXltQXYxTlBFajV5bnBPRnc0TG9KcnNuZTJC?=
 =?utf-8?B?dVNiZ0czUHhuYjhZTWxIRThyYVZJdE0xOGhXdUlWQUJuZW1RTjVYMVJkSFpD?=
 =?utf-8?Q?AoaCle61kqXlqpf0rNb27bqiQ4U1l2gn9RHUoG4?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c801b994-8934-46f9-398b-08d90a4ca23c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 13:50:50.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqXS8M72HFAqk7zUj27aS7mJxxghq+zKVzniH5Nlume6m71mFr/cHRIb+M6VrBtzajDBAUEvmq/OEL1UzOmrrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2361
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have a robust system we want to be able to identify and take
actions if a boot loop occurs. This is possible by using the bootcount
feature, which can be used to identify the number of times device has
booted since bootcount was last time reset. Bootcount feature (1)
requires a collaboration between bootloader and user-space, where
the bootloader will increase a counter and user-space reset it.
If the counter is not reset and a pre-established threshold is reached,
bootloader can react and take action.

This is the kernel side implementation, which can be used to
identify the number of times device has booted since bootcount was
last time reset.

The driver supports both 16 and 32 bits NVMEM cell size.

1) https://www.denx.de/wiki/DULG/UBootBootCountLimit

Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---
 drivers/nvmem/Kconfig           |  10 ++
 drivers/nvmem/Makefile          |   1 +
 drivers/nvmem/bootcount-nvmem.c | 195 ++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 drivers/nvmem/bootcount-nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index dd2019006838..d5413c937350 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -288,4 +288,14 @@ config NVMEM_BRCM_NVRAM
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
 
+config BOOTCOUNT_NVMEM
+	bool "Bootcount driver using nvmem registers"
+	depends on OF
+	depends on NVMEM
+	help
+	  Driver that implements the bootcount feature support using a
+	  NVMEM cell as a backend. The driver supports 2 and 4 bytes
+	  size cells.
+
+	  Say y here to enable bootcount support.
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index bbea1410240a..4c77679bbf0d 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
 nvmem-rmem-y			:= rmem.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y		:= brcm_nvram.o
+obj-$(CONFIG_BOOTCOUNT_NVMEM)	+= bootcount-nvmem.o
diff --git a/drivers/nvmem/bootcount-nvmem.c b/drivers/nvmem/bootcount-nvmem.c
new file mode 100644
index 000000000000..7d9b6caefc2b
--- /dev/null
+++ b/drivers/nvmem/bootcount-nvmem.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Vaisala Oyj. All rights reserved.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* Default magic values from u-boot bootcount drivers */
+#define BOOTCOUNT_NVMEM_DEFAULT_MAGIC_VAL16 0xBC00
+#define BOOTCOUNT_NVMEM_DEFAULT_MAGIC_VAL32 0xB001C041
+
+struct bootcount_nvmem {
+	struct nvmem_cell *nvmem;
+	u32 magic;
+	u32 mask;
+	size_t bytes_count;
+};
+
+static ssize_t value_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct bootcount_nvmem *bootcount = dev_get_drvdata(dev);
+	u32 regval;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &regval);
+	if (ret < 0)
+		return ret;
+
+	/* Check if the value fits */
+	if ((regval & ~(bootcount->mask)) != 0)
+		return -EINVAL;
+
+	/*
+	 * In case we use 2 bytes for saving the value we need to take
+	 * in consideration the endianness of the system. Because of this
+	 * we mirror the 2 bytes from one side to another.
+	 * This way, regardless of endianness, the value will be written
+	 * in the correct order.
+	 */
+	if (bootcount->bytes_count == 2) {
+		regval &= 0xffff;
+		regval |= (regval & 0xffff) << 16;
+	}
+
+	regval = (~bootcount->mask & bootcount->magic) |
+		 (regval & bootcount->mask);
+	ret = nvmem_cell_write(bootcount->nvmem, &regval,
+			       bootcount->bytes_count);
+	if (ret < 0)
+		return ret;
+	else if (ret != bootcount->bytes_count)
+		ret = -EIO;
+	else
+		ret = count;
+
+	return ret;
+}
+
+static ssize_t value_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct bootcount_nvmem *bootcount = dev_get_drvdata(dev);
+	u32 regval;
+	void *val;
+	size_t len;
+	int ret;
+
+	val = nvmem_cell_read(bootcount->nvmem, &len);
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+
+	if (len != bootcount->bytes_count) {
+		kfree(val);
+		return -EINVAL;
+	}
+
+	if (bootcount->bytes_count == 2)
+		regval = *(u16 *)val;
+	else
+		regval = *(u32 *)val;
+
+	kfree(val);
+
+	if ((regval & ~bootcount->mask) == bootcount->magic)
+		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
+				(unsigned int)(regval & bootcount->mask));
+	else {
+		dev_warn(dev, "invalid magic value\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static DEVICE_ATTR_RW(value);
+
+static int bootcount_nvmem_probe(struct platform_device *pdev)
+{
+	struct bootcount_nvmem *bootcount;
+	int ret;
+	u32 bits;
+	void *val = NULL;
+	size_t len;
+
+	bootcount = devm_kzalloc(&pdev->dev, sizeof(struct bootcount_nvmem),
+				 GFP_KERNEL);
+	if (!bootcount)
+		return -ENOMEM;
+
+	bootcount->nvmem = devm_nvmem_cell_get(&pdev->dev, "bootcount-regs");
+	if (IS_ERR(bootcount->nvmem)) {
+		if (PTR_ERR(bootcount->nvmem) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "cannot get 'bootcount-regs'\n");
+		return PTR_ERR(bootcount->nvmem);
+	}
+
+	/* detect cell dimensions */
+	val = nvmem_cell_read(bootcount->nvmem, &len);
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+	kfree(val);
+	val = NULL;
+
+	if (len != 2 && len != 4) {
+		dev_err(&pdev->dev, "unsupported register size\n");
+		return -EINVAL;
+	}
+
+	bootcount->bytes_count = len;
+
+	platform_set_drvdata(pdev, bootcount);
+
+	ret = device_create_file(&pdev->dev, &dev_attr_value);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to export bootcount value\n");
+		return ret;
+	}
+
+	bits = bootcount->bytes_count << 3;
+	bootcount->mask = GENMASK((bits >> 1) - 1, 0);
+
+	ret = of_property_read_u32(pdev->dev.of_node, "linux,bootcount-magic",
+				   &bootcount->magic);
+	if (ret == -EINVAL) {
+		if (bootcount->bytes_count == 2)
+			bootcount->magic = BOOTCOUNT_NVMEM_DEFAULT_MAGIC_VAL16;
+		else
+			bootcount->magic = BOOTCOUNT_NVMEM_DEFAULT_MAGIC_VAL32;
+		ret = 0;
+	} else if (ret) {
+		dev_err(&pdev->dev,
+			"failed to parse linux,bootcount-magic, error: %d\n",
+			ret);
+		return ret;
+	}
+
+	bootcount->magic &= ~bootcount->mask;
+
+	return ret;
+}
+
+static int bootcount_nvmem_remove(struct platform_device *pdev)
+{
+	device_remove_file(&pdev->dev, &dev_attr_value);
+
+	return 0;
+}
+
+static const struct of_device_id bootcount_nvmem_match[] = {
+	{ .compatible = "linux,bootcount-nvmem" },
+	{},
+};
+
+static struct platform_driver bootcount_nvmem_driver = {
+	.driver = {
+		.name = "bootcount-nvmem",
+		.of_match_table = bootcount_nvmem_match,
+	},
+	.probe = bootcount_nvmem_probe,
+	.remove = bootcount_nvmem_remove,
+};
+
+module_platform_driver(bootcount_nvmem_driver);
+
+MODULE_DEVICE_TABLE(of, bootcount_nvmem_match);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Vaisala Oyj");
+MODULE_DESCRIPTION("Bootcount driver using nvmem compatible registers");
-- 
2.26.3

