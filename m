Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02AC36EC14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbhD2OI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:08:27 -0400
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:22880
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233862AbhD2OIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:08:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIb1vctBjqolIguuvCxZYyJIxc3S+v5CDL0IcGdOwFq9T5ues1o5pg98VMJ3pOmmsGHA2Q3NoiOIUuOzRIPYzkMrIp4tCoiOnRnBjE3cN4Y35UTNhw88dS4sQsHqPHjj+TC6IE9CANwDwTWkKmLwuQOxS07OjWmltzWzHpasBnLSLFr5Lg53EBZwQbvUg28ls0aj7L1AymZWJ6BZnc/kBXksymDl2aIQWErGfQ5evOkr/of3A+XQ0k1Fdp6CxLIebJoWC+vXQHUs7X1C/ZEqvUAgC0XzdW5RsBNW8mSxsn9HS03JiGYAYnmHIaGu/Vsp2O3/FU/tp8yb60/06YNnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxSWi+oRrTUtnImFGOpgwPVk/Kvbo89mJy2eQDQZVtM=;
 b=LWmvbA7JCT5VzRdPL8lTsepA5eigQfuwrNhzJR0aoWwW6Guw/1vhHrNNcECKtMWxGAb7wfIHb23HJot/bBLJXGa+3j6YiUcjmE70o4pHW9DVK43TxfYKOVO18rUfhlJevEVRqUMCN7z9otv8rsJQ9JXRZh3vfC1L4zWuZT/Uw70VE+kH/w819ExPlk8tG6sfAZP8Xg2qbnoLz5vby36rLkvXnlNdGPwgx+fFPCWmrLQgZK/IOVUFfKLjK1EHGISQQi+jwZ+UFFZitHSF1FAT2UhwKI5tGFteH4BAuLkVxlKHz+s9Nf6c1Vq2ZLctenzFBYmNueGewbw/HcQCsQQqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxSWi+oRrTUtnImFGOpgwPVk/Kvbo89mJy2eQDQZVtM=;
 b=pf8NZssJxaWAD5iSROE+MCG2CEqSc7zPrnTJTLddQeb0v5Rc/xOp7Kif/8tnYM7vOziFhtPLEglNxLT5GEE+OIV4T0R4TF3mAoU1AZOXjylGsgGCp3D2fgF5Dtu4LCqesL0F8PTZ8sqBw4NSsRrVIaM0N1za14itGJJBbm+NJVX4yRVN1GTBCIalwt+llL539E2CvTzbgWjuh+K4tdiC+EWsicdOoYidfmYsR57Nj0iig48pyuQ4LNZjqWqj34mq8NAIKWHi2NOY2iypj2wsshbSx/BJ0dOiwanASrVkueCFen/ltSjsCG7GItP7UQ5kbTRh4jspJTdgJX3UKmeGRw==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2315.eurprd06.prod.outlook.com (2603:10a6:3:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 14:07:35 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:07:35 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>,
        =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v3 2/4] nvmem: bootcount: add bootcount driver
Date:   Thu, 29 Apr 2021 17:07:23 +0300
Message-Id: <e2812735b5a85eae9d6dd5ece174127b1ea4d3e7.1619704986.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619704986.git.nandor.han@vaisala.com>
References: <cover.1619704986.git.nandor.han@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [176.93.24.30]
X-ClientProxiedBy: HE1PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::26) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (176.93.24.30) by HE1PR0902CA0016.eurprd09.prod.outlook.com (2603:10a6:3:e5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 14:07:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02115601-ba3f-45cd-6121-08d90b18233f
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB23157D8AA8D9D6C0C3AE3452855F9@HE1PR0601MB2315.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vaX0G5usFwUddP6CMMnZR4BQ1ufNoRNVMHUX9O8lmlEZrD945K/oKHvPvWsWfh+dILfvgQ3ZZj2espuL2Chp9CxfUakg+fwu4Yaexe9zVqTT+tt8ygYNFFM+71ScbI/jttrs+mpjtPyLD4CC8YxONRD9sbKBs6i62pLyYSSUz1zGGp1GNL6NDs62kDhZxQ5GHz1SM961gWAGiM0N8xg+UGXDBszq+hv2pf/crRrDSK9As+xAU028TV3gcz5kziJ+sWJR0Yr4ST7Qda/y109x54PBzRMKA7vi4+QV++YNMUi/FaVJOMaWIXrzyAbTCHuIUVe77jxOT56Gfvq4DturCBJeuPYYPdN/tTsyXIEbe3gb+xL36XLx6k5P++MAaXDjtsrWr5Ta5W1ZP2+NJoN4PRxn6NA84jdy9d2XGC0TJeFW4kUXqFsHB9vtyr9PQZqPob2vdINvQxT8drs7HWZSMGjA+AGmKX7bgsQUttMDr1I+2Id9M3Br3ULCIpZIrHpClHIUvT8fe21C6E81JhZ6O/MLkSUXQvmGGrUZFFnP+bsNwy9GYrUREWC++W49K5QXygnOJ85O0VeWK/+/5TqX81fM9YBVXcFIFA/ai+X/B/VU09Yi9l2FC4ibcR6bkXAeFXxuu4kgoVw6o9P43XVaFolMpKCM6FFXK0LOQgNKw19+PNF9Vfc/fRGikkgfVevsH6PfhqqiWqkad0wfeWDu+Y/Z90hT1UvMxnWCWJThR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(366004)(83380400001)(86362001)(6486002)(66574015)(36756003)(4326008)(2906002)(956004)(38350700002)(52116002)(38100700002)(8676002)(107886003)(44832011)(7696005)(2616005)(6666004)(16526019)(54906003)(26005)(5660300002)(66476007)(316002)(966005)(66946007)(186003)(66556008)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bUxkSTJDMDlQdENndDJHTlk2MTFuUmZQVHdSamVMUXgwSUQ2YlpRd0FwQnlC?=
 =?utf-8?B?MjFScHVKTmJJNzc5VFhMSEhLNXdJMmtyZGQ2ODRxWkdMdXRHbzJHZWR5UUFK?=
 =?utf-8?B?VTlqR0FxZE9RQ2RsZGgzNjdYNWV4SkVkZUJmUG9TTzlzazdveHU2bmY2bzhv?=
 =?utf-8?B?M3hyS0RmQVpmTmxFeUh5VnJ6ZkIxZG05K2d0ZTJZaUtlWElteU1YellZTDdz?=
 =?utf-8?B?ZWpldTlVbXdqRUJZU2ozOWpyOVpEVDl0WWNoRmh4OUNFNUF2U3FuQlpWUkV3?=
 =?utf-8?B?WEFUcm9Sd29lYWJCOFlIckhIcUlybjY2dmZrNFF6cUd3WmN5SGR1NURaeEhN?=
 =?utf-8?B?ajhIeEkxMmxWcm52eDB0cFhwZ2dCSWcvaVhab083aWJ4b0QySDUzRC81aVZO?=
 =?utf-8?B?aDF5cSsxcWVnckJsVjdldGlUTitNY2swVUprc0ZUL2YyZ2I2ZURVL1VlNjho?=
 =?utf-8?B?YlN6MkpBZDVla3JlTVRiamxFMDg4MnJqeWZJRFo5dGZCQUdYRkNWNzlDNWhl?=
 =?utf-8?B?ZlFLODlGVm92OTNQSUp4cU52SHgxdm1ReTVSbFp2WFdmc295bCt1S1BJZXU2?=
 =?utf-8?B?NmVIUm81SlFNbUhrNFJYbXdhWlhnRXQ2aHVTcExxS21jdEJhUUlrL05hMncv?=
 =?utf-8?B?MDAzZTRxV3VJTTZyMHB3U1Z1aWhndS9lUlhwVHpId1IrVkF4NkEzTlRyNWNJ?=
 =?utf-8?B?ZlBuTUtzNFB1QjJhTnZ4UjQxbzNFdndueWZuOFNwUFQ2YWpyUkw1bU1zQkZu?=
 =?utf-8?B?dTNDRlhpSWtOTlhaSFZjNXR2dytOY0NvMzNHaHZEYzF4VEhJNGhiVWdrcXZN?=
 =?utf-8?B?MHlyMWxhNlBsSHJaWkhyY3Vkb1J2WW5YTWI5U1BPQ1p5bkdXaXBQZDlUbitC?=
 =?utf-8?B?d2xIWDg2amptSjNPTW1ockpaa242VUpHenFCb2pDTGdxUEk4bFg3OUhmbmd6?=
 =?utf-8?B?WHdsdGxTU1dDY1hMKzcyanpCeUxaQkRuYVU5TlMzQUF3cHV3cWtxeDFZU2Yr?=
 =?utf-8?B?NVFtNWtOUEp0Y003SlY3cnRXd28vR2xGSDloSlZQREJZNkZNUGxHbElXb1dR?=
 =?utf-8?B?VTJCVFhGbVJpa2JJN0kwVTlZclkvMGdsVWxkRjlMUXlkbC9mcXFvKy9rczBE?=
 =?utf-8?B?eHZNR0t6K3BNSlBRREJaWHFqbXh3WlA4UGhYVWd0VTVwUHRxOTdlUFArbklR?=
 =?utf-8?B?c2pJcVlWVjZqOFZtdnoyWDhWTHF2ZTl5NXlBcDZjM052c1NvMVUzTmNBS0Nr?=
 =?utf-8?B?U3RTTWRYUmVCMU9BNXFKNHp5US9VMmZjcnlWM3VjU0NnUm8vOUtZRkFlT1NB?=
 =?utf-8?B?OEJLcUtsRkl0SXhod2NJRzB5Q1V0eURZNGlRbkNWVWxDLzMvRWg0dEc1OE04?=
 =?utf-8?B?b1RKSVdXSkYwLzA3RUJobnlOVGZIK2d3NnNrL0NHY1VmQm1lSVV0cjZwdnVs?=
 =?utf-8?B?SWZBRXRDN1lQUEhpVXpQbE84K25qdWFnUHp0QWVWSldOZmZFQ1JGVWc4RW5P?=
 =?utf-8?B?cFpxeFFtek82ZFc0a2YxdFA5NkhRQlV6RDdkNkFsYTNxYkowK0pSS2VGS0tR?=
 =?utf-8?B?TGZyMUNjd1JvVnhzdUM5b3R0K3ZGYWlTc0djMEpuenFqNVFVQno2bmg3NnUy?=
 =?utf-8?B?NG16YTFPYjh3YUMveitQbDNFdzVyWFRoaEV6WG85MmZTVG1lY3VpNE5yZG90?=
 =?utf-8?B?U1NRYWFueS81U2h2TWVHb2ZlbzMybG5EU2pQTmhvcmVXV1duWUFMOTFydFZi?=
 =?utf-8?Q?JB4uVhEjaLmyRip/Ifn9ZwfZfI4NAxzqer0/bAJ?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02115601-ba3f-45cd-6121-08d90b18233f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:07:34.9981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrfxGsxoaR2TfgW/mi62fgVD0dRfMJ42YBR/LTefnDmcpR2fPX6Bx4d7JulZdTS2VG2GlyI/EWQeTdTfiOx55g==
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

