Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC68936C0C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhD0I1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:27:42 -0400
Received: from mail-db8eur05on2089.outbound.protection.outlook.com ([40.107.20.89]:21985
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235028AbhD0I1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:27:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHJI+UFICxq3B4uuJh8KVYqsa4ygJMjlnyYEM5NKmLjqrJfsXY7DW4gf6wtW+lV0gAngs1FaBrPJs/teQnLrNTQe8qiS4vZr1pOgdxKejLtQOltof/ei7/GNW5pVHKE8J+P1HdVrMfzEkBlQn0pJLPd4dq7c3woy8D0I2sgHM/1Zca0kxJEDwnAecIM1y2Fx20m3X1FnSTmqeh9LRU4ecOKSpPa5xQ2DJk2mXa5vomZeBmMP6zMRnLof417lNCAJlaE0ByU/6+OEflfJdWeL/2ed/O9KOFbxxIrsv9figY0jTddBpReH1k8yNWEMfALHnGlNvyuUP6wNGXuKetCJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxSWi+oRrTUtnImFGOpgwPVk/Kvbo89mJy2eQDQZVtM=;
 b=SGx+UNPngsvyLL9eVZO5t2yA3MWHWwOP00QMO5TrXLtTcwaQwzf3Kj15fCO0K7DXzwbPI7/SCDxPKJkQQPcvo169b96PO5Ra98/wBDaR4/2+kb1BLLxU8PdVs+birjUWRV9zu3oDWnTPLPaSa1HLvN82nQYzG4TZAar2wwDDjx0MYdbpFTwnCwhmn9lIpE65FI6hN9XTNV0ncCMMY4DS2l8lJ5v0AHg3e1YG2QdP17l+wAtd+qopAJ5FeFaQ03cY7fEE4k3NS2DCIXCOS/67+/kLZwbECCShD0gbwnSp4u8c1K0C7YbsDjUJhX9cWKIqTZbxEyBcvQqMy4V2hfBAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxSWi+oRrTUtnImFGOpgwPVk/Kvbo89mJy2eQDQZVtM=;
 b=25FT5+h/Qjh9iJX4Syq+uce0mIG/BjXjAJvNMzD1PtSM571kwkWXYns3Cmn0cCqNvbsDkeY2kBtdTc5D6H8FUf7oQTEn4HAqrsE2EjCgM8kUZkxhDTaeP1tHVgFeRrhKUtBzQqz3C2bAiie+ZEl7qvsYruuSdCKGVESuW31SRy/dfSMD0h7Rteiqd/apk/UvMAB2xfLgvTg/cwCn1tgkr+oVgFl1U5/u1icuZ9A50TDlGasz0k9FA8rtjWyTyLmc1cgyvtLrqhSTervBqahfiAluxD7HJq6WziMdUV37xhd2a+YEUn0x8VZoTKWmllmrf5WMNEzavwjwlNDzXgJ/9w==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2315.eurprd06.prod.outlook.com (2603:10a6:3:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 08:26:52 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 08:26:52 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>,
        =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH 2/4] nvmem: bootcount: add bootcount driver
Date:   Tue, 27 Apr 2021 11:26:32 +0300
Message-Id: <44105288768b12eda1be3597d634b49a3af30d74.1619511801.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619511801.git.nandor.han@vaisala.com>
References: <cover.1619511801.git.nandor.han@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.136.150.171]
X-ClientProxiedBy: HE1PR05CA0162.eurprd05.prod.outlook.com
 (2603:10a6:7:28::49) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (37.136.150.171) by HE1PR05CA0162.eurprd05.prod.outlook.com (2603:10a6:7:28::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Tue, 27 Apr 2021 08:26:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 356618ba-48f6-4375-3628-08d90956358e
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB23154EA8745491017A79BA3B85419@HE1PR0601MB2315.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUbN/6kDsV9ZKM9vs6JJj7AKHtVnTgHEsm/XIapIY/SoW0gYbFrvGmdggrBeYym0i5T6QK2ta11GyX96KVX+IOhF5Nij++mInBOuCPdhbslUJCROz7WFDLFGtCDRB6CLcvsnXZtlht3KfaKsJDHhNC6KeXTnPX0t3+teISeyAS+oqGWfE2IjwCw5WjRfZbh6XR0HprosFPeA+6qXNmGYue1r5sG5syhQw9HOVDGheD0qDQF2QibIBjZx8UZVJ7myl+eEiNdB7wV1TIkaAtUYElrj67+Vtzbelvoo2rpWsWY58+CoVoobvovJUJWV+B7FoKyoIH/1SGHRM0KG9rgxlRPB2cBLSdgWbLFuJAgI6ckoAo29FNaCRonGpdHsKVJFSRJkfCe/J4g0wkm/zWHF9cq9RNyoymcpS5sP5y6B53+ApYw7kziZ4PRUZvu0K/ygbu6QZ5penGuGikAI+1RzyhKA0EKkTISyVn+5xtB/ckBo+Ie4EqQPLzoLVF1UKLs1NtIGfb1NrT6d8u3CZIjibkjVH/XJ3SHgvg/If5g4vNuBCNE0lfM50O4kGYNLE0IdfBI7Fu5oiLVniKyV7lA0S89q2XUz2JUEncGxcwvaPw+0cvJWf8ghCn2M/jzl21D3Js/oYykP803jCKjjHa+4NQLl4MwRTgsVRM6daR4V+7LMED6vNX3d22cNe4aczsP2wGl0RHKajNZKmt/b5xdbDJokY9xWw+6BhMglg4CIA+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39850400004)(346002)(136003)(966005)(66556008)(66476007)(5660300002)(44832011)(478600001)(26005)(6486002)(107886003)(16526019)(186003)(6666004)(2616005)(54906003)(316002)(36756003)(956004)(2906002)(4326008)(83380400001)(38350700002)(38100700002)(8676002)(8936002)(52116002)(66946007)(86362001)(66574015)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OENqdjFmVWpTZE8yWnFITEhrTjhnalhJUnNsNE1oanJKb3J0aDdqU0syUHNM?=
 =?utf-8?B?aW5vdlJWQXk5S2hmaHNLYyswMUpySUlmUVJjZW1yR2wyc1ZUNXpUSFhRTlFY?=
 =?utf-8?B?d2MzYkxqVWludThhYVQ1VHBpdzBsY3N3Q0dHZkVYODJwWW1sWHFGL1lzUldE?=
 =?utf-8?B?SnQ5WUo2Y3JOQzFRUFozQVRmZGJSQUEyank4enpJU0cxUkt6MmlSb3QrTWFa?=
 =?utf-8?B?V2N3dmxxcDJNS3lwWWdISVVpS2xpMkFLSFU3cFVkTFoxWFlpOTV1SFREWmUz?=
 =?utf-8?B?K05od05GVTVoaWR0RjJ1WDlUdmRiYmc2aU1mTFhNUTdiV1N2RUJDcmN2Vmg1?=
 =?utf-8?B?Mk83cGpVQi9objV5K3ZEOUlMcDJvbC9POXh0aFBkeXNqUmYvQjFVT2tkR21p?=
 =?utf-8?B?V2lUSjBFRWpQOFBadjhXQlRiUFpGeDhXYnFDbDlQRDNFdllBZHdhTndwNlNo?=
 =?utf-8?B?VGVxeVAyOWh1ZFNGUUw0RE5DZmtTaDZYWlZxMUdzWDB6a3Jxd09ZdTMvd0lx?=
 =?utf-8?B?dEhxWEdJekI0V0Q4cnhPSnYwMTN1NWgvSWU0cDZFcVl2NXgzU1dXL1RaTDBU?=
 =?utf-8?B?Qnh6UGdJdE44OW1BVXY3b25FZklyazJ3MWNzdG9WanFxd1NpTFUxRXdMeVNk?=
 =?utf-8?B?N2d3c2N4SlVTTW1jSkdkeVJnRnk4SzVJT2N1ZWlsZ1ByNlpieUt0WE02QmNO?=
 =?utf-8?B?UGRqMEh3MGxUWURXS0theWQrYVl3ZjlxNEFBbFA2aWxxY2ppUEo2WkFuUnNL?=
 =?utf-8?B?Y3Y0Tmdrejc1OVN0MHRaam5vdTUzM0hnbE03bjBQaU5WRlRxUWZrenVPVzJ3?=
 =?utf-8?B?K2VYWTZjaksrbnFlelRsS1JuTWxpZHFka0dnUkZ5SzExTEVUN2hJYUh4cW80?=
 =?utf-8?B?L3JZeHphR0tJTE55VDVLRDNPa0pEc2NOaVhoUUdQa3QxL012MjA5T0F1QmNj?=
 =?utf-8?B?OUYzSmlaQjAxWW1TRmFicmcvSGxnZVFIVFFpTEJ2NHJaYlY5TjNwTHRkWDQ4?=
 =?utf-8?B?WElqNWlYOFZ3dWlpY2VIQlBFY3NVbjZBUDBWaStMOFJSeDM2WGlEdTVqS2k3?=
 =?utf-8?B?RTBFVlFobkxvYjlYcGFBREs5Z2RiaEE5RVpKbTAvMmdpN3BRU1JZQXRnTnNX?=
 =?utf-8?B?ZC9QakhWTG5Dbm5LaHduQk93cVVDV05iY3F4SmIyaDVQZmNqQWRnY0NFWDcv?=
 =?utf-8?B?bkdDRHQ2TklWUUZNU0tRRVA1V0dWcjc3QVY2dEd5ZitUNjBZb0VJL3piUlNl?=
 =?utf-8?B?bW44ZmRqZEtOK0tJdnZuYjQvVnJRSnA3cnpHckkxbE9YWkN4d1ViZXk1b3JV?=
 =?utf-8?B?alpoTFlzNTdxMExjM3JSSVVyNDNFajFBVkxFNmhBc2pIazFZQjc1ODZRY0JP?=
 =?utf-8?B?c01SVzZONDJDSVZaQUdvcENLL01XTndNOCs4Y2U2ZHJzNTRqUWV3WURENndk?=
 =?utf-8?B?VEwzcFhHT0w3MnpHdnZnYVljNTdkMDNXVmIxUHNHRmVWRUZUekdMY3d3MzRx?=
 =?utf-8?B?M2RrSms4SnRhd2lDQWxwbkw4a1ExVEVFZFBDRGRBc3JaTE41aW1PaUhZWG1a?=
 =?utf-8?B?UGNuVk9VZXRsQlhxRUM4d1lpeGJmbmFvSFBWcEIxb3o4ZG44RERreTJjeHY2?=
 =?utf-8?B?S1ozakRxZlU5ZGlHeDFoSEtZZ2MvVlFDNFNkbEovUmNIbXAvaDhtc09QZVdL?=
 =?utf-8?B?aXZ2RzNrVFZxRjQxMWlyQ2tYaUtOVHNNZVBwcWdEdHFTY2Y3bkRYZ0ZDcWxs?=
 =?utf-8?Q?fcaMt0ebklu7noPGHB8u2+oqGufW3qQoLneMwDi?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356618ba-48f6-4375-3628-08d90956358e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 08:26:52.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZ1HEiPBvugpDQoSm2Hk19YXTswnu0l7OvXuKxELMEPo7OpXAHljS6GCk3ZXmbY1sAjmoBNEhgBVA21wHi59sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2315
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

