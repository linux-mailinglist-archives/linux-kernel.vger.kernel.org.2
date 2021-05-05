Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AFC3738BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhEEKno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:43:44 -0400
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:45339
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232828AbhEEKnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQn8eN2Z4o2884DVCx2Zh+9QDcT9Dp11NPxYFAnVyfu2YzuV4gcmNr8BiLuQH3IxO35KD9yIYrnvNiQgKNWCVwH62fGxcJ7VfAk5aTAi/vnIh8KKK0WLpiOWxUZDL82zkNbvfM/pn2zlEAB1t33cbCqV+mF9f4AxckS9iDMtZd+rfjog532aIi0FOy2Y76CYFOMxL0KolBPlc3MuKcGAdiV/67sdKTuvQkcf9YVd7uFXe4rIkCScaWNHrXt1e/UHlCXswGkSOgZcq7Je14vl1eCmHTALbsiP3SSaYBf4SwNQULeCVLrUNp2la8HTJyUB0SVby9PQijTcFr+1kOLskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxSWi+oRrTUtnImFGOpgwPVk/Kvbo89mJy2eQDQZVtM=;
 b=cIAlPFqYg97A+fUetLxL1o605BSYz+KdimUJ85ayEGS/5AQlNtaXtI1Ir4PR66W4OvSyagMyauGreqjdTQ1zkOsq03pYdZUIOmVH3yhGjHjDN6v6DUx574F9iHK1ZKBp3Fiu5pyVPX3UW3z+3qhBNWztSmakmFI/YqCIWTP1XgXuiwJqHz/XURrF8lou2c2l9qMtgfoTPHhpgkw1uH/Q6bancbMLCFjfBgpV545BjQB8imQmErciM2VyISUnyS/BARoyFxVr+rN9xGFVo/yQhNt/BJ/LDa4yKgZn4EhoRLfvSDmhs5dczeOBKcAPXmNx01NSNKmmtknq/c25lzYfNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxSWi+oRrTUtnImFGOpgwPVk/Kvbo89mJy2eQDQZVtM=;
 b=wOWpyQ6sBdoV50rTACSzUayX0qVCP8AyKDHPUyPRmzPkBYCdBs9BDNlR3YlQSalgBUZnh0ckaHlc5RPZBqPWVfhJ6/bH3URgrz4S0sdg798fKc7MGejotvoH72n+Wb3Pt/S4elL4SwGs9YkgsfcGWCF/MeKZ2QRWh/TGA98l++cGWxJmuSMR046GPAgRM481gTw5CgCWF6H8Hf6K1RE3wFj0LWZAgoHRTPW7zeopnfHtXfCIGsYYOR7mZ+aURzbGMBkhUDzZECfWJtmB8HfAelnUCDRHKAe8LXcV3qvbyKu63283MfyYHxwnwHUBXIQ1/0lE4ltCHEkJpMC59y4VzA==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0602MB3242.eurprd06.prod.outlook.com (2603:10a6:7:1b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 10:42:31 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::9ca0:8dd:38d7:c7d4]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::9ca0:8dd:38d7:c7d4%7]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 10:42:31 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>,
        =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v4 2/4] nvmem: bootcount: add bootcount driver
Date:   Wed,  5 May 2021 13:42:19 +0300
Message-Id: <43e36704e9acbf89b3b29113554d3a79417d42db.1620211180.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1620211180.git.nandor.han@vaisala.com>
References: <cover.1620211180.git.nandor.han@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.143.230.131]
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (193.143.230.131) by HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 10:42:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e90cd945-149b-43a8-f403-08d90fb27be8
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0602MB32423EF2DEA19F532042A64685599@HE1PR0602MB3242.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptF40slG9T0a8o9FfV++K0NpHJ5fUoSxgW6/NvjrNzD48vznwBxaO7a4abZ4gWUHdHq73WpEulGHOiZP1PLIqZ3d/qZnrUNxCyuooK7Jw6g4UdWi/t++zxCeZsFeFRVAjy5w5FQg6CGeUYDzQ57zjpAN1kYwRTn3bUETBiGA85mytpNNrZc/kGBQ+ZBOQFO7FYE0PM5AhEaZm/pFdhtvHNq37BH1t/uO1ToWbTWoyAY0WZSjtfwWdi2zzYMZU8bGenqmqw4hWXFBJdwpVPWWvjg3EAK75ATWK0WCR1YRf3hiR2afOVpwBUU3fepd8vAdLdPjNulkYGb5RVLdpOzc4UbzOiGZSYUsrScl3H6Qh2Z5U96fyxbWMrWLTUVuu+dKKy1VsztzO3FVRlsMxa7DtDu8KA+oXuKSQL+2i+XH/Zu+HeUYHM+jx1vhMtHeHO8OhCG5iZlBzIY8LV+zzaFgavI/JN+9NXOJqB9mqG+2qyz57pGqIq5ldQd7pd6X4lILZdjmKZEI3oqSDcsNXgm2dqmJiTaRTKBFlK5swt1/6VXzDBOoob1BMP1TArXCTeaC3qFlXjWnOao8AZzCii/4INNuJ0hvKTmIiLl7hSfwjlNOHVPoXl0BaZdp/w+mGVDVP8fDA9XS7NJfN/aea3WouPO34PGL8iCMUi74zBlq97AmvCK/dVpSZoOyTFAZUOyJmGSDgYrTyNbgvRdMOtOemlu9AB6E135pmd43YIIH0t4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39850400004)(136003)(6666004)(8676002)(2906002)(956004)(83380400001)(26005)(16526019)(8936002)(186003)(478600001)(107886003)(44832011)(66946007)(4326008)(6486002)(66574015)(966005)(6512007)(66556008)(316002)(66476007)(5660300002)(52116002)(6506007)(38350700002)(38100700002)(86362001)(54906003)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VDlIOHlBdjZ1OG9KR2F0NjNUeHBKcHJtZFllVjArZEJjQjBleUZ3ME9LOWlP?=
 =?utf-8?B?Z3BZQTZsaGJ4NkplQjQ4MVlxbjFkK2lwSDRKeWU1ZDc4WXE2c2xGenl4Z3cx?=
 =?utf-8?B?eEZNY1N4MEhHOTNpR3JZNTE4Y2tXUlZhT0dOQU12RGFPSXNPU3Jsb0xxdUJL?=
 =?utf-8?B?SjZIejFnemlpeEFSdkY4bUZ3eEhwU3dEVEhyMDYzM3hwQ215dEd4MFU0WTk0?=
 =?utf-8?B?QzUxTFZmaXJkOUlrM1NRMnRjaHFpcE1nWW9TTjFmZFkxYUNGdzJYeFhZVWFU?=
 =?utf-8?B?TTIwLzFCUG1EYmZqaE41ZGM5aUgwdnZHcHRTTFVKYmh0RDd1aGtPbCtZR2Y1?=
 =?utf-8?B?ZlcxandUbmM1MWdubitjOXZ5d2hRNDJHN3RhN05SaUxvOVE2L1draHFUWVRj?=
 =?utf-8?B?aFI4a2Y4c2ZjVVVlY000dDZYbGg0K2xHM0pHNDRiR1pLVEluTFQ2N1B4RkNE?=
 =?utf-8?B?NTRtWlozUUxwcjhtVnRtT3pGaW40V1J1OW9RenI2L09vWHBReWZSTWdkbGx3?=
 =?utf-8?B?SHdidVlwRk9hcXRXTG9TZXRENEpaaGpXbk9vemxHdWNPTitmejhqY1JhWCtj?=
 =?utf-8?B?VWpPTDN3WlEzcURmelgxZHFIemZwQmpVQXhZaXdqTzdYNHpIenpqZFg1ZnNk?=
 =?utf-8?B?SzZ0a0dzUVNYT0tEdEQxN3l3Rm93V0pvSFdCaDhOa2NjNW0zNUdMYjNYMUxT?=
 =?utf-8?B?ejFtVG5ISnN4NjFPaDlGSUtta0liWm1zbEpoNnA3LzRSSWRBODZXU0JTSzlZ?=
 =?utf-8?B?S2xjSVd5NnQ5OHUvNmwzaUhjRHM0c3BPZEZ5M1QzOTJva1c4SXRwdU5mZGlJ?=
 =?utf-8?B?SmttamZQK3VzQlpwQ1o3Ymk1akpPTllvc3AzeFA1WnIvVHVEdG1rNFd4TTA1?=
 =?utf-8?B?dUZ0dDFiTmRqNEhuaDMxckswVTJzMzhBdFFwbDFEQzJQNlBxYVE2Q1kxNHdC?=
 =?utf-8?B?Uno4Zzk0U2M4SUhmUjdQQjVaUFdDTmR6SlE2enZoNkJmejlhWlFBSWNmd2Ry?=
 =?utf-8?B?QjdBWE10NWxkSGthZXE2aXlHV1B2ZzBQUXlkTksvdEdLc1ZyaHM2UHQ5TVdB?=
 =?utf-8?B?V1ZTQWNBaFdRV2d3d1EyWVU0aDIxbTVhWG5uaWh6WC9LQ3lsVmcwaWhJbTBq?=
 =?utf-8?B?RmpqOVRkTklmOHNDaWdKRm9LeVRHZG9LMFNCY2JsN2hQclkyd0E3ZFlOUk4v?=
 =?utf-8?B?clNBRUhLQjBpQmFBOVpiUGJWdVoxQUVpMDB4YkJSWnprSUFnN0FXekZvbHN4?=
 =?utf-8?B?M1l4SVVTL3hJUmNlM3RBOHdxOUZRTFNwRU9uaDBZRUc1NDlnVTJnQm8yc050?=
 =?utf-8?B?amN6bnU0Z3pmVkJQZGNOcitPYWxjeE1nYkxPTWJOK1NyTEpOeGNTYUxCeFlM?=
 =?utf-8?B?ZHR6WlJ1TnN3S0NPQStTcTJkdUdTNW1SdFdTbXhGRzlOd2VZelRZRjdQVm1l?=
 =?utf-8?B?Nk9rYUhUQjZad2JpeEQzSW4xcDFWM25RZUNDM2luRDZRWUY2dDZVRFEzbGxv?=
 =?utf-8?B?TnZqZDM2RDRCcGZDOExGR1VCVXpQUXZQRnJ5MVp6Yi9uckNaREMyU2hFYlJs?=
 =?utf-8?B?RXB1ZXJUamZvUW5jdmg1VXRsK2JBMzdXaU9HY0d3RitRZjlLVWxXMWZuSE11?=
 =?utf-8?B?Mld1dmxLakd3TytHMTZMYlNZWm1oSjFtajhSd3FvNS9UZzhxN0lIaW9tYnpG?=
 =?utf-8?B?MUlCUVhwR0dJc01kdXhiUHkwbmJSaS9ZendFQSs5S1JxcE9QamJGV0NLNEJy?=
 =?utf-8?Q?20KTLGFVH/KT8+hIDJyAZS5Z4nulkZ8TmwoY+/B?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90cd945-149b-43a8-f403-08d90fb27be8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 10:42:30.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JdCzZDUBZsRU2zxKD6qK8nsTffMFEp8/S6BRZ9MvZvvzfKqokdEsfFUaNcMGl9siuJT0wvSqoynSM4cpdBQcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3242
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

