Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34C430DE3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhBCPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:33:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48114 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbhBCPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:32:33 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FU2tt170314;
        Wed, 3 Feb 2021 15:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=SmQCd6k7Ms1SJgR/B2tQKKelhvTO22chggy/y/Ycggk=;
 b=UBxbBJwSJkR+ioP0uafJkTXUOJt+IPI9HLgiCKJn4sPOpJP+F8cEtvb/0ueCmBybJsRH
 jNUs7GML3PXhbj5Yvf63q6yix9TLOrE2ulvnmY9dgEOi3heGm5/sWBMqiXmhK+blSBzs
 yGjGNjYl9baD87pForW2P3jGsHIGJLxL8JcHZszy1k3d6pW3O+r7ueHPeac/o27flVks
 w2UCzi8xD3yb2Q0W6OH/UGdDzkgoIAFfJyoo1RTDaDsFiKOSj7nW8bt8zVkKVFWwf7xu
 h84XvgVUd5vCk046Z+v4y9zPcUPZYqudY32ddKiiTqPxeDAXxmejyyNiLd+6iQnrN7vq Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36cvyb0u6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:31:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FUbso172064;
        Wed, 3 Feb 2021 15:31:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 36dhcyudue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1AoAcrtqbSKSc7k7dG87E+GhAfxcrEfuJXhEazc/tv02nLDtEcnFV7CLSVj5ZAsOXec2nNy31E6XHF/9YzRy0g6M0jhKH/PtYH/4i/SZumbPYkU88B4sCeDxoQtpvfmGRQEAs1w3EQ/r/by4GRF42SIuJRkX+jQCej6JdFfWc3KKm4qrNXYTSl0Li0Bl0O3sa86ShLBRmMG6PDwnaB1e4C8xe/N3l69XnfcbK6d5hHV3TnXvXSd+13vZvE3X8lYxGIW3+WmFEu9OnkUJOSt8TX8v21AsMAArSU7I+PAvR27LthErDLfy3QksPVt0vOnVgwoKr0tODLC4RiTkzWC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmQCd6k7Ms1SJgR/B2tQKKelhvTO22chggy/y/Ycggk=;
 b=ZEll2lEsFUXYyIP08/SFKChxK+tLkGFhx1LB/W/2BGmhtAGnDyd0oUf4OUbuAi7aMreyCkk/B0QOt+ty7ODnBGnILaznb/Urt8a03dGOVVu1iIMm5WpV/9uRoZJx/fW6JP7vWwgURZd8tIgsgGZWb+yUHrfSPAjw6ia1eECgfO4HBwca8VuO2qxNjhsfZNZkCOrLWp9jp+LHKv1owWekJF+6GGfef4vY6Pc8TTXz6RTGMbY1OIdux+lFyJni/L6HvgHDIf9Pn3M2VcGAEvXN4730SIFUZ12mgoL+NIY4ksTpegT73saV1Kzc3l9EqTPYzDGcD7XvIhfl2Zlbnruv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmQCd6k7Ms1SJgR/B2tQKKelhvTO22chggy/y/Ycggk=;
 b=xahJexX5TIVf4oCs28elDMQAazlqI9Yikds72trQndWm2If9GSIJJEJqzDEWpnW4swMxbXMPx4ulC2M7VnljpUuMk/3lmmzxa6acXkNSQOtbTEvR995aHnJ90IK/iIWviNf7Vqz3dq4bQmuCiIJ1eH4mLqGXUnELSggYcy0/weQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Wed, 3 Feb
 2021 15:31:27 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Wed, 3 Feb 2021
 15:31:27 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andriy.shevchenko@linux.intel.com, bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH 1/2] misc/pvpanic: split-up generic and platform dependent code
Date:   Wed,  3 Feb 2021 16:43:58 +0200
Message-Id: <1612363439-26656-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1612363439-26656-1-git-send-email-mihai.carabas@oracle.com>
References: <1612363439-26656-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: CH2PR14CA0016.namprd14.prod.outlook.com
 (2603:10b6:610:60::26) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by CH2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:610:60::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Wed, 3 Feb 2021 15:31:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e7b7cd9-34cb-4ffb-da05-08d8c858c5a5
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2351694E1F06922E16C8BB9488B49@MWHPR1001MB2351.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aZR8LIy/VDmRlp3CLE4bDewIq94l6DLirHhUWSOkQxoZHBRO6JWaSD9K1vcOKwkyR3Hxm47L/mpvio3U8BHNMbvJMZJts9qcpstqJWeTPqP8S+DE4+F29HChV5oUsDG3FL9XRd1s8NSCG/HCNiU0a2cXhSfmEmP/AgG98lL87l27M9QNvHyH1xycGskuTLuQMrUSDztHdWlD9bmRmbrFvxjq1XBE7wGdfqHULhHWJXfyVBgyeG+jkXz/vCQzS+FSPbEFYWp60AE/2MwIb5syUAcybuAnOhzp8r/yxAmjEGzC56KdpKQTYjzMRayVzcSh28lqj2NVuCXm6wMrYO+vILCaRAM3tEG/hPTxkTCAHtSICfZUWW7aj8wHrZIcSQ6i2UboQQwTSffAPdVCivFijb4VXYj9OBFnAu5+Oe1PYKFvW5cOOGQkeDq08Uvi2GfpPNT4PUhG8MpKxUbYIMcDNoQIWs4LVy4GI00DlTL/W+UjN+Y63EhIzwihIyw6EoW8vLI1SqgeEIykbzPsKZMSYzDOB4kJ/jvpu8PhcEyU0uHVPW7ML6YV60wiNM6L/tH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39860400002)(396003)(346002)(6512007)(107886003)(36756003)(52116002)(2906002)(26005)(478600001)(86362001)(66476007)(66946007)(66556008)(6666004)(6486002)(4326008)(5660300002)(956004)(44832011)(16526019)(6506007)(316002)(8676002)(8936002)(186003)(83380400001)(2616005)(6916009)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Pin9McXB2PPdKEiQ6dKQ1EhUxXiSBYianulTixgPkKfyBem4fIymuNpwbSU5?=
 =?us-ascii?Q?KY2VVJVApMJF3medN1uKLoTU3APeaYnnGRj6ommYTFEduxO51/QqyjiIkiEE?=
 =?us-ascii?Q?bMy3kprbDBya4sWQnkWz8D3WgxJrXhRuLQCnut3FQKf3KZQfYOh43LJkDYA+?=
 =?us-ascii?Q?ymTcP3ZdJQSclsGgyM/U0pxWPcyCS+o6L78r6D3cqSp3Hetncy5hqkbuHFV/?=
 =?us-ascii?Q?Xwdn9dQHHXlil+b/v+jmkoIgnK6Ity3z6221JnFJe9eWsSDkulOQPi3PeZh1?=
 =?us-ascii?Q?/+T2ZUlDbQnxRh5qitRej5u3DwDuFI316uTE7yXQQpV4Z02ZgpcN8upCnpxp?=
 =?us-ascii?Q?5gw5X6x7khuLn7n3j8rZHN+zHGbd6Nk4H+brnKs4ywg8Id9MOp3+p18vNjxw?=
 =?us-ascii?Q?UdCvvVOsEuDWJV0oL7y3FxMYhm6dlDw8itiX1lwx0dFGDQiT51r/g0e3JECY?=
 =?us-ascii?Q?g1FX4X7emJ7cZQ0tuU2KJWUxWDoQcL9uVdXam8+EUp6qKGrq0mfwVrhzrdLy?=
 =?us-ascii?Q?9+awNYmFHESfzlMnv94oope9VPqe9Ook1VIdUCRZuGneFueLJDJ4IdD2vWwr?=
 =?us-ascii?Q?0zpgZhh5zwcWvEJ4LVq7g/VpwwvZBKq2uWRpbPuXL6ozakSLaf8gOPfOOiui?=
 =?us-ascii?Q?rxBzg75N16Wx71I2Nsv3eW9WCud7rtthKRF8BE6jYXFmjbhZR4LyFLfldKWo?=
 =?us-ascii?Q?lNIPTStYW1rvL3XJtet0N1qeGwbsbnIjANh6xN7sTvzt4B4LgobEIA7DQ6uZ?=
 =?us-ascii?Q?udHGOa1wm+qKdmdJ+vvYwOFDGVqRH4eeMbBbYdg3ka6c6NIEmDKk8N/O6adf?=
 =?us-ascii?Q?iOjYh5zgNFDqelqiG2wJSucBUfAJ7HQ02E7ucr0L8kG70QAr+PVuDimO+ccZ?=
 =?us-ascii?Q?2lASJJ9vA9vbSG96FyTUnCqhsY5E4bw6BdVdj3mhKCF+crzVTQRDQBaqgXwm?=
 =?us-ascii?Q?rlGK0hYCdwRkJXi31MMsHCMPInxyNPHP483VRoqrIYIMqRQkU1k8OXTdyzm9?=
 =?us-ascii?Q?/9UZa157PhYFSuQD07fARnrChHy/FlB4Z945CyauWhnQFhXqeH7eBrqs5LAV?=
 =?us-ascii?Q?gz95TBl0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7b7cd9-34cb-4ffb-da05-08d8c858c5a5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 15:31:27.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smxJV+Tkm3qM2VUkyAb5ZaREeWx/HhQUIIjvVBJHhY4he4Pqb/gsfc7dchHZeSzCK+EZbiYwcOYklOeIwfoxsKFmEq3gKTyZqbdNjcR03HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2351
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split-up generic and platform dependent code in order to introduce pvpanic pci
device driver later.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/Kconfig                |   9 +--
 drivers/misc/Makefile               |   2 +-
 drivers/misc/pvpanic.c              | 111 ------------------------------------
 drivers/misc/pvpanic/Kconfig        |  14 +++++
 drivers/misc/pvpanic/Makefile       |   2 +
 drivers/misc/pvpanic/pvpanic-mmio.c |  83 +++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c      |  59 +++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  17 ++++++
 8 files changed, 177 insertions(+), 120 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/pvpanic-mmio.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
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
index 00000000..12bb017
--- /dev/null
+++ b/drivers/misc/pvpanic/Kconfig
@@ -0,0 +1,14 @@
+config PVPANIC
+	bool "pvpanic device support"
+	depends on PVPANIC_MMIO
+	help
+	  This option enable generic code for pvpanic device driver logic.
+
+config PVPANIC_MMIO
+	tristate "pvpanic mmio device support"
+	depends on HAS_IOMEM && (ACPI || OF)
+	select PVPANIC
+	help
+	  This driver provides support for the pvpanic device.  pvpanic is
+	  a paravirtualized device provided by QEMU; it lets a virtual machine
+	  (guest) communicate panic events to the host.
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
new file mode 100644
index 00000000..d08379b
--- /dev/null
+++ b/drivers/misc/pvpanic/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_PVPANIC)		+= pvpanic.o
+obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
new file mode 100644
index 00000000..f361747
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic Device Support
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
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
new file mode 100644
index 00000000..b4e5bbc
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -0,0 +1,59 @@
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
+}
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
new file mode 100644
index 00000000..a3aca5a
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic Device Support
+ *
+ *  Copyright (C) 2021 Oracle.
+ */
+
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

