Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD53319C57
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBLKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:06:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44342 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhBLKFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:05:51 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C9pCxc025498;
        Fri, 12 Feb 2021 10:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=kYTnjdxu3dHdFbUNxV/LdNyXKwgmQdFcl4xbh4Xpf0Q=;
 b=aBzsOohA/e7e4PQnS1xCW9WbfjfJJqFY9QRvlNxXFrSJTF/UFsRjYjXP4zkiJmpptDFm
 3ZjosHDNkuPC27UIYEIl6Id9/rfXynN+UjjsTVDZlImnHSAbQrcr8DuD9PvMWVj8Vp+D
 jkm+M5TP1VsDtOihqExfZK3hD8WJ8PQGXhIM7gMp7VW7VyGv/vEEw/7vo/PuhZAwkHr3
 pYaqzurxxhuUalHgT6IkeNN7ureXrNKtJ4IinJFqkD+XTUZGfUnSxXPecQq9oXd+71HH
 qHZNOMwMbSnAI82hSVJwmbfVutiqVaUoBEkp7R0ZhjOhcj0efQJpbFFTGU2lVSQwTFTT tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36hgmatspd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 10:04:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C9paxj163609;
        Fri, 12 Feb 2021 10:04:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 36j515a2pu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 10:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPLPXPpoReFnu9e1fSeQenSoxr9TNe6kjDr4xaRbNKSQTynae8eKkbIK1MlpZVLii5d/Y99eBtAkKSx49y41BGatzztg9zEDFEw9KR2UKsAQixMEmnBbJV8WNaLUm4PENKUOos3UQuT4YZGjMMMJNArQuHw3OznCUomCp61O4W2WRRxHiW3nSAzGLFuIzUwZkMdbg0tYFeZd/JybI+IQ0e5/iXfDjNmZ2pchgce1KhrE3XQK/O9VgV75X1CCnqDOW+gZqy7frDAzw7+1QiwvVU6gG1bGi4jD9fTv0+XZsx2YsE36EiRE/8qMSPeGe5F3K7UeUcxRtgiF1GUg/Uz/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYTnjdxu3dHdFbUNxV/LdNyXKwgmQdFcl4xbh4Xpf0Q=;
 b=gBtWVgJN2S+9JMPjaOnuY6Muw/S8lbeSzTUr2SiV43WRSYkCDg9BvI8ZPfOrqd2gnIn2Uk45BJjGhsUjIwC/D/bpL667+piRv40G2njCI++XhA6OYsIAFOs6D7kSyrTDePhtrPzmzTeQBYGeXeG2q9JhDzMG2P0da6Ps8IOVkWxCuiOLho6dvn0Y1jy3lUKjtLmmsw4Jp2kRC79Mps0dIyRpf/TXCtGj/XNMtvZ9Em9AmBMn3sCJgg5pfkM7dbr3TvV0aO+uiAipulwWxCYPJlon8br6lMn08M4LiTBn16mLVsNdpq+7Y+ZFdficG7lzsc2H2cyBUA4GjJ2wQTGbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYTnjdxu3dHdFbUNxV/LdNyXKwgmQdFcl4xbh4Xpf0Q=;
 b=E0nEQ6XPqnO1cQuyCXhc/WOfZ4Bxzbo3YXN3ocDKVZibqBr+hzy54nEFmOoHHk3vLWzsd8QNlS6h6qKvk2NKujJNSVKqkuQ2Pfo9mKOLbnvPlVauYDCJFIMdNI3B4wvhoaqyqu60OjgPto3puqdOeDkg7cevf2GXblhL7q6tG38=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4611.namprd10.prod.outlook.com
 (2603:10b6:303:92::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 10:04:46 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Fri, 12 Feb 2021
 10:04:46 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v2 1/3] misc/pvpanic: split-up generic and platform dependent code
Date:   Fri, 12 Feb 2021 11:17:04 +0200
Message-Id: <1613121426-15585-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com>
References: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: BYAPR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:a03:60::26) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Fri, 12 Feb 2021 10:04:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 457199d3-eb26-4cd9-08b3-08d8cf3da012
X-MS-TrafficTypeDiagnostic: CO1PR10MB4611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4611F4A51734BBE85ECD26DE888B9@CO1PR10MB4611.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNrObgyc7JDSzueZAuxfdx6DihpB9Hj9lZUIEzzwS1+90JrthDw/X1TmXQ0hPcbJkBwBODZr/SryqL7r1INV3DQVwrGB2UxIav61WN4jBnxmEzXpIVpl/Z350tuuEdyHv+iGoEoM/7Td150AFwD3CXHLfdCkgRsBQSDr+mUZYuFA/I5hXXx+snCOjZqna4KpdNHrpP1/ASfTlFUWZr8RD+hOAAd7hHl7SQCwqklOaOIFw+RQ+ccUnqSAJtVnv7mYoih0yQxzFEDSTcH35UodmTjVAB5EmDOkcH5oRtNmjgvEHmvaeMsFcAFUghEhaNuoKoxP6T0b9YmvkSJ/J1MX4epriRHd7uHgINmZSKm3J7SZyZ2Lsx63DGfKHjv/+iJ5fbaNEYRoumZS3BORzQeYEDhDP5fzXRtzL1StkXPtOFZcX9g8KhrBMXn0dIFSADu439g8UpnEsgxh4+1g09Lezbbyc5qfyApQULGwem9VJzyHv8udC0dXdN5cIRUodLKzi1Ld/l3ub6k0IWcs1bve+YcfOmSVw66hnFapIyg+PzMRZsCMKtQn/oGm89fl+qjK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(136003)(366004)(86362001)(66556008)(66946007)(36756003)(66476007)(52116002)(83380400001)(478600001)(956004)(2906002)(2616005)(186003)(107886003)(26005)(16526019)(44832011)(6512007)(316002)(8676002)(6506007)(6916009)(4326008)(8936002)(6666004)(5660300002)(6486002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uFQDxPQcI1dZIxVVkCE//Itb8lxXeeOQKmo5YKr0zafJ4SqYjPSoKYsoIyGw?=
 =?us-ascii?Q?SRa/5jz5NhXp1I/CqWlWZYX/UerP1gmMkv8PjN3gBjWk3Ws01c6mZM/KQM/u?=
 =?us-ascii?Q?JK8PEHBe+Lro8ReInOwKXXFVrmpU2trrMYrMgyRJVRcnst98A7LYmuUWr7uc?=
 =?us-ascii?Q?SEqk6s6KcVAHXIqoCSnKdAsfMe0SneXlXJYg9EtiAD4m4MJCp1RFyntvWlxz?=
 =?us-ascii?Q?rjuQk+FhsFV2NbR/CTmNU/O5NZQKPTdV+vS2uW6i3lJQ+T7NX6Lr19wZaHg4?=
 =?us-ascii?Q?yr27WnOPg0t1wGtw9eaQu6lI98DIiBG6Q/Aw3ol7VxP3PHrf0WEYNX9RWoAA?=
 =?us-ascii?Q?VlKYUg5+/Vi2MbRWzzUVq5iZYmlJlvSYkpcmKrBAgcTvhrQSUL6+X+2w8+VB?=
 =?us-ascii?Q?DCL7/wfLTIVxEBNPTxZmbgtzvDMS1+Lq+Dz5NYExf3+8mEgbmP3s5ARq5qUt?=
 =?us-ascii?Q?34xMDwOeJR9wW40zcCocXnwTl4yje3AWOuhYw0D8rjQj5dDGZ7xkV3ZUqpVg?=
 =?us-ascii?Q?ELKu9+oH/qOPB/qIwpVCcFT0LnB7F6CEdmtdLhzZe58JTV4kte++zu5JUQsL?=
 =?us-ascii?Q?k9zoU1CD8d/vyjRk/hfoj4ncdv4Iv+QC0QSx2QxYpnX603qpQJU1cFMbcTY2?=
 =?us-ascii?Q?8UGCqQArCHqR9YJG1MA+NV/DksN8amG/oIxGFcXgERoNMWrgTb/YZ+ed7Faa?=
 =?us-ascii?Q?x53xuSa14btf5G7FwT4Ubgd7Bhk5AswiBc9Gxg9/f64hz4FlhEjttGgRrM/D?=
 =?us-ascii?Q?GdlGcXpHeRq18qYnp8iwcFaX6BHDk2YZnmeVR2W4J+lI7cMJ0OrrIEH2Irh/?=
 =?us-ascii?Q?o58K5LytyFiqvaT8hCeHhbsfPsqCPIBZXMdXE+QuIjaTHLW7OP2RdQejMr3l?=
 =?us-ascii?Q?Pf0irk+LWVAoM+qRP024LwOZsbv22R1KYFNlAvXDZ4wKXzxxVSW46GqBcBAB?=
 =?us-ascii?Q?0w3z/7PRwPY1hFgBYXDvox6VcAPXAJob9/gfRV9l8/pdICMowHpssOweEaL/?=
 =?us-ascii?Q?Sb0AZqPYE1t0tw2Vu71jyHrQV714dKbN7jEv5BrmR/ysTP8sb0LJGp+x2rXM?=
 =?us-ascii?Q?D//PZQMdkQpH/NjbOm256wR/dPVSEMEd5LvtygqRgmoXPK4ZASQRSQ31BJwv?=
 =?us-ascii?Q?g9NXOKRK1BIvJJVIDdjqnFXgtLUqfKov2B0k5E4AXIoEJPymW9fgDDyASfrQ?=
 =?us-ascii?Q?6QTNtyL5o4/nUu2yhfZFOkNQBZWVHOVnVSeBlnYJz1zHay49CGbsklyxT2F6?=
 =?us-ascii?Q?aBhttmBgI7XXKleaLUNRdaxQ3ZcGeFSiWbBEFWDkcYJfXa6VjQx5JQAartQM?=
 =?us-ascii?Q?jRGhYzCD1ZipU77X/rvJ9p3L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457199d3-eb26-4cd9-08b3-08d8cf3da012
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 10:04:45.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zk05xRPvRChSyg7U2gX+Nya34bV33BwneYrxC6S8eJxp0DNZxQQZJ+Qv/xM0K74L470ghHIwlRYBen5HynVjMMmHuIxbUEpeYcvZBVmLjC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4611
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120075
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split-up generic and platform dependent code in order to be able to re-use
generic event handling code in pvpanic PCI device driver in the next patch.

The code from pvpanic.c was split in two new files:
- pvpanic-common.c: generic code that handles pvpanic events
- mmio.c: platform/bus dependent code

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/Kconfig                  |   9 +--
 drivers/misc/Makefile                 |   2 +-
 drivers/misc/pvpanic.c                | 111 ----------------------------------
 drivers/misc/pvpanic/Kconfig          |  12 ++++
 drivers/misc/pvpanic/Makefile         |   2 +
 drivers/misc/pvpanic/mmio.c           |  83 +++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic-common.c |  60 ++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h        |  10 +++
 8 files changed, 169 insertions(+), 120 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/mmio.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-common.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0..0273ecb 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -448,14 +448,6 @@ config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
 
-config PVPANIC
-	tristate "pvpanic device support"
-	depends on HAS_IOMEM && (ACPI || OF)
-	help
-	  This driver provides support for the pvpanic device.  pvpanic is
-	  a paravirtualized device provided by QEMU; it lets a virtual machine
-	  (guest) communicate panic events to the host.
-
 config HISI_HIKEY_USB
 	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
 	depends on (OF && GPIOLIB) || COMPILE_TEST
@@ -481,4 +473,5 @@ source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/pvpanic/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e..9f411b8 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
-obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
+obj-$(CONFIG_PVPANIC)   	+= pvpanic/
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
deleted file mode 100644
index 41cab29..00000000
--- a/drivers/misc/pvpanic.c
+++ /dev/null
@@ -1,111 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- *  Pvpanic Device Support
- *
- *  Copyright (C) 2013 Fujitsu.
- *  Copyright (C) 2018 ZTE.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/kexec.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/types.h>
-
-#include <uapi/misc/pvpanic.h>
-
-static void __iomem *base;
-
-MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
-MODULE_DESCRIPTION("pvpanic device driver");
-MODULE_LICENSE("GPL");
-
-static void
-pvpanic_send_event(unsigned int event)
-{
-	iowrite8(event, base);
-}
-
-static int
-pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
-		     void *unused)
-{
-	unsigned int event = PVPANIC_PANICKED;
-
-	if (kexec_crash_loaded())
-		event = PVPANIC_CRASH_LOADED;
-
-	pvpanic_send_event(event);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block pvpanic_panic_nb = {
-	.notifier_call = pvpanic_panic_notify,
-	.priority = 1, /* let this called before broken drm_fb_helper */
-};
-
-static int pvpanic_mmio_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct resource *res;
-
-	res = platform_get_mem_or_io(pdev, 0);
-	if (!res)
-		return -EINVAL;
-
-	switch (resource_type(res)) {
-	case IORESOURCE_IO:
-		base = devm_ioport_map(dev, res->start, resource_size(res));
-		if (!base)
-			return -ENOMEM;
-		break;
-	case IORESOURCE_MEM:
-		base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(base))
-			return PTR_ERR(base);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
-
-	return 0;
-}
-
-static int pvpanic_mmio_remove(struct platform_device *pdev)
-{
-
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
-
-	return 0;
-}
-
-static const struct of_device_id pvpanic_mmio_match[] = {
-	{ .compatible = "qemu,pvpanic-mmio", },
-	{}
-};
-
-static const struct acpi_device_id pvpanic_device_ids[] = {
-	{ "QEMU0001", 0 },
-	{ "", 0 }
-};
-MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
-
-static struct platform_driver pvpanic_mmio_driver = {
-	.driver = {
-		.name = "pvpanic-mmio",
-		.of_match_table = pvpanic_mmio_match,
-		.acpi_match_table = pvpanic_device_ids,
-	},
-	.probe = pvpanic_mmio_probe,
-	.remove = pvpanic_mmio_remove,
-};
-module_platform_driver(pvpanic_mmio_driver);
diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
new file mode 100644
index 00000000..0dce6ef
--- /dev/null
+++ b/drivers/misc/pvpanic/Kconfig
@@ -0,0 +1,12 @@
+config PVPANIC
+	bool "pvpanic device support"
+	help
+	  This option enables pvpanic device driver.
+
+config PVPANIC_MMIO
+	tristate "pvpanic MMIO device support"
+	depends on HAS_IOMEM && (ACPI || OF) && PVPANIC
+	help
+	  This driver provides support for the pvpanic device.  pvpanic is
+	  a paravirtualized device provided by QEMU; it lets a virtual machine
+	  (guest) communicate panic events to the host.
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
new file mode 100644
index 00000000..9ea3355
--- /dev/null
+++ b/drivers/misc/pvpanic/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
+pvpanic-mmio-objs := pvpanic-common.o mmio.o
diff --git a/drivers/misc/pvpanic/mmio.c b/drivers/misc/pvpanic/mmio.c
new file mode 100644
index 00000000..7454eeb
--- /dev/null
+++ b/drivers/misc/pvpanic/mmio.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic MMIO Device Support
+ *
+ *  Copyright (C) 2013 Fujitsu.
+ *  Copyright (C) 2018 ZTE.
+ *  Copyright (C) 2021 Oracle.
+*/
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include <uapi/misc/pvpanic.h>
+#include "pvpanic.h"
+
+MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
+MODULE_DESCRIPTION("pvpanic device driver");
+MODULE_LICENSE("GPL");
+
+static int pvpanic_mmio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_mem_or_io(pdev, 0);
+	if (!res)
+		return -EINVAL;
+
+	switch (resource_type(res)) {
+	case IORESOURCE_IO:
+		base = devm_ioport_map(dev, res->start, resource_size(res));
+		if (!base)
+			return -ENOMEM;
+		break;
+	case IORESOURCE_MEM:
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pvpanic_probe(base);
+
+	return 0;
+}
+
+static int pvpanic_mmio_remove(struct platform_device *pdev)
+{
+
+	pvpanic_remove();
+
+	return 0;
+}
+
+static const struct of_device_id pvpanic_mmio_match[] = {
+	{ .compatible = "qemu,pvpanic-mmio", },
+	{}
+};
+
+static const struct acpi_device_id pvpanic_device_ids[] = {
+	{ "QEMU0001", 0 },
+	{ "", 0 }
+};
+MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
+
+static struct platform_driver pvpanic_mmio_driver = {
+	.driver = {
+		.name = "pvpanic-mmio",
+		.of_match_table = pvpanic_mmio_match,
+		.acpi_match_table = pvpanic_device_ids,
+	},
+	.probe = pvpanic_mmio_probe,
+	.remove = pvpanic_mmio_remove,
+};
+module_platform_driver(pvpanic_mmio_driver);
diff --git a/drivers/misc/pvpanic/pvpanic-common.c b/drivers/misc/pvpanic/pvpanic-common.c
new file mode 100644
index 00000000..395ccae
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-common.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic Device Support
+ *
+ *  Copyright (C) 2013 Fujitsu.
+ *  Copyright (C) 2018 ZTE.
+ *  Copyright (C) 2021 Oracle.
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include <uapi/misc/pvpanic.h>
+
+static void __iomem *base;
+
+static void
+pvpanic_send_event(unsigned int event)
+{
+	iowrite8(event, base);
+}
+
+static int
+pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
+		     void *unused)
+{
+	unsigned int event = PVPANIC_PANICKED;
+
+	if (kexec_crash_loaded())
+		event = PVPANIC_CRASH_LOADED;
+
+	pvpanic_send_event(event);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pvpanic_panic_nb = {
+	.notifier_call = pvpanic_panic_notify,
+	.priority = 1, /* let this called before broken drm_fb_helper */
+};
+
+void pvpanic_probe(void __iomem *pbase)
+{
+	base = pbase;
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &pvpanic_panic_nb);
+}
+
+void pvpanic_remove(void)
+{
+
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &pvpanic_panic_nb);
+	base = NULL;
+}
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
new file mode 100644
index 00000000..4d6c221
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -0,0 +1,10 @@
+#ifndef PVPANIC_H_
+#define PVPANIC_H_
+
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+void pvpanic_probe(void __iomem *base);
+void pvpanic_remove(void);
+
+#endif /* PVPANIC_H_ */
-- 
1.8.3.1

