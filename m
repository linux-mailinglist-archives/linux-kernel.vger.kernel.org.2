Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE531A5F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhBLUVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:21:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48116 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhBLUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:21:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CKJPRE173331;
        Fri, 12 Feb 2021 20:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=uC6wtKGc0Vi5whmfb5l+LHhWSKYAwJIUuf2eXOGHtz0=;
 b=b/Pexf69KKtO0SOhQ4P/qTQQGZzVV0Ms8k1La6+lfRFOZIpUpvzzi1CuXG+OlFiyVgwL
 Vb5SRN5KPN50H8OxCLl2/BHuCVbTjqfOMykTzbCjai25OkmMpkJCg28MAhdkyM3A1PDB
 gCK05p+tQyQFYvcyVKLUTQc5khmr21jwhp/zOQfXipWPZ0oeqALB/rOiDiXcloIP3QYL
 vfXfHhVJF9KZwdBK09emUYintrhLX18UGCjZGWtOUuQ7FquMZW3NwxMYeH5W19lRZ2EB
 STqnaiAfDl0NyP1KxEEJYMYaxYsOlCCXTDgoe1fC8Tha2pFGhB3f1oYes9cr+NohbHD0 YA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36m4uq32dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 20:20:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CKGob0175506;
        Fri, 12 Feb 2021 20:20:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 36j4vw5k9r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 20:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beAem2DvzEt5hBrCwp4WHRw8zcXsvlj9NX8+qIBteEu+JERD9YYcy16wC1LbGXhJq1hJe2bIN95YUCgZjVhQV8DcDjLyHU3MiyXsSn2feeSbY3mcQ57yH+aTD4qMxPkXv4alK5qEen63lnbPE5rwH6KH1U3v6Z45vNalbe+GnEmxMuN43FsF2AD97vPKvAk/dHkC0doxnXgfjgvmlJHyWQANdI+vMEHhSTUQOhUkoW8KXlmya+pJosgpSpFHsXOtzP0jG5I9k3IHjRrsfJfeb55X1hQY1hdGmaOgg746cNfjERhOOlnaz1x+qWm0kpg7aSbQJoMOws5XJfKLQXrGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC6wtKGc0Vi5whmfb5l+LHhWSKYAwJIUuf2eXOGHtz0=;
 b=aTOqtkhiqJ77UqGZ1CTXLxBli7dK2rcFe/MP6Dwp0b4RiKy7zwzkSZu33L0YZ7ylbwj1llcMNJ/oOu5uWUKUOOHhx64Y8C9sqdEAGIbdAOeiRQB38Mye3mCM1RL9YF8HvXaYEn4nuvO3Fiv0SIKrx6FvcyaCW8DyvpdQA/aiD59kSrjcRLRg1R7rjIwNnONRnRiOBYt6VnUtuUYn2MereY4UfZXl7pOGyqzZVJhBLo8Afa/FsAdEfBHhPU3NW1TraFYGldYHzoXfLTKv0TbA8LyyLu4gSO3AbO4iESob4vyrCJKngBJQ84V0cB5yVJ6rKxCePsqmwZDlyH+3KSxW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC6wtKGc0Vi5whmfb5l+LHhWSKYAwJIUuf2eXOGHtz0=;
 b=jOF3ljTwtokuoBTEqiCthjkOkX/eRffjEirzFzbSBKbsMKcSwnFFJ0lSjYMCWyzT50YsfTCoA6JYJelb9uSV/lBsQN75glIDyZmXwxQcBpGoWyNebvwaTXe+v5UHTNJX+8ia1YOVbfQTkJyGgfFZ+4oMLO69gNk6UynVRJEFIHg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2176.namprd10.prod.outlook.com
 (2603:10b6:301:30::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Fri, 12 Feb
 2021 20:19:59 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Fri, 12 Feb 2021
 20:19:59 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v3 1/3] misc/pvpanic: split-up generic and platform dependent code
Date:   Fri, 12 Feb 2021 21:32:26 +0200
Message-Id: <1613158348-19976-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613158348-19976-1-git-send-email-mihai.carabas@oracle.com>
References: <1613158348-19976-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: SJ0PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::31) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.14 via Frontend Transport; Fri, 12 Feb 2021 20:19:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6afd18b7-221a-444e-b2e3-08d8cf939211
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2176882E72F4A2928BF56542888B9@MWHPR1001MB2176.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7k/pmwoe82rrJKRy6hxfkMjoB+WD/9fu/3fv+8eKfKxEfyf2W4KlCrdip6LVou8wZIKhuYWe7SM34Z0pzFgnLH8/53hL/yyluSMvng66Xf2bAC3+ZVxrEPmMSm88O9CCtA74nRSrfzqk1ZBO1a9Fi/u/6I0M/FphflFO9zbt7AoBbTU1kTm9D48LPgxHe3T4wQObsTnYGS/IGpr9CMnftsLz2MJnl2pL2Dt8GFHJ7yCCc1Km5J7LpAF5kCUM2B44Jm/KZLibg1Nt6rjv7SNfOszT9UnVYzeUWw0BFgbhvTX6Opdx3ID7cfLR677j8mYt4hIWttX+vWJwSMvlgxFhN4FTvEHTYJajnEJDYLC5Pvxaw6CAOMcdNxJ4TzJ6XqoUufOhZyzjif50dLOZMIshSMWFwpcMe343xg54sZM4/Ue3E2Ne+UniuvvO49EGOecldy7uOkRtmprHuGQy6VWwdQd1CzHi1M6DAGeXOurQ6Iyv2m4wKtYtL+7kv+TzwSPEU1mRWie5vEBtZEyfMcUlUJNoxVZ20tBWX0QCIKzW2wceM0RTLVUKYiYMFbnrhDbq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(136003)(376002)(6486002)(6512007)(26005)(316002)(956004)(44832011)(2616005)(16526019)(8936002)(186003)(6506007)(86362001)(6666004)(8676002)(6916009)(107886003)(2906002)(66476007)(30864003)(83380400001)(66556008)(36756003)(52116002)(66946007)(478600001)(4326008)(5660300002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Gl6euPAVz4WKPlv882LNPxTg8Axiv09jGDsp9Aouevy8VvQOq3WpXaCl45qq?=
 =?us-ascii?Q?pV+R5/wex31quw0dedLGyUUOwTAHO5X3rL1wGFDutykmUg+aCwHoLYpBA1aA?=
 =?us-ascii?Q?JBRXXM3U7FiDv7J8bLPI1bzcUVgKIX26LAIfZyrRlBL268WVOyggi5Fh2D5v?=
 =?us-ascii?Q?xL6hoEtpfq4udN6fbxjdXjrVbxOmb9/6poGoa4KRINPcSY8AXHJ4xU9dghiV?=
 =?us-ascii?Q?tYbpBTKZOFrZ1xXRIkhrzWNOkv163VjQIhTGGq64nsc3tAWRA+MzOQJnKViH?=
 =?us-ascii?Q?hGlm9tRDkYIAWvQjk/A+qdImjMgFrnahDAfuBsk2zO5dtH0kzREQpU7oPpHE?=
 =?us-ascii?Q?VdI469Cdh4H7nweRjS6LfrOUlNR6B8Ooqu1ogA/ClzmVsZkgAuNf1QPDq897?=
 =?us-ascii?Q?gJ/bizdi+2InCEqpPv6QAwETyEoXyu2wkx07HMbI24QFaJbQh+8yLnOj3Jhs?=
 =?us-ascii?Q?e4Lz3BtyWdSCv4E5ftTijmPoliRsH8BKUSOS58ThpUPCNBCL6vtzWa+5VL05?=
 =?us-ascii?Q?PI/7GTJ1X5OSAmLXC4J8Ttu2U3e0lu+TxcK4fV8xvYTXzcRIVyK00/60BTcq?=
 =?us-ascii?Q?4rpx/Xo9Xj19IphlDr4THyqUTkrVRTWaY4KmITpTrcjTk2MkJPUxaxmEIwSI?=
 =?us-ascii?Q?MACtZNBYFhTaD+Qgpzb0KgGHsz+6N+x75fddEiN8awQDbPTEQ/RQDm66/JUN?=
 =?us-ascii?Q?92l2Ph8HAd7mcSYDRuUcf+VwajXGyAdGcuiZvenuXndRgEPRtWQckv7VvOsU?=
 =?us-ascii?Q?dR6G6zC55QwOVCyQPTQK9GaT1UKUoXlG0xcyi4vQ7abl/JJ7L45tV9b0lkJt?=
 =?us-ascii?Q?YO7UE0qRKBpAFFgerpxPtQkVHTwSBRIvgZjhn8CgNYAb16XaGkc4YeMzMXIR?=
 =?us-ascii?Q?4R2e1NKYRf5mgRuYx+63AFpZfTJ9MB0IFx5jmN0Fc90Arq68/nQyLCzIi1Pc?=
 =?us-ascii?Q?/rH0o4snKe1ncgAGBs/NxE3wF52wgu0ZPhLkA0GUYF8P63qZjnbHnWcbRbNV?=
 =?us-ascii?Q?9lkATtMAgpo0koDKo+onZsnPuaBWLP3zT9wnCSfkZH6MkiQUzfocM4p/3wPN?=
 =?us-ascii?Q?FmaJRVDBr6TijGICdNG7NvgiRUdOwwlu1U80Js4AmzkBPk4z/2RbQTkhirsR?=
 =?us-ascii?Q?FxXFruZMzDIzbXWNj0ZQnJ0RxE4ELsUuQeQ3ibXtdBj78hsJWkhvUOY00j8c?=
 =?us-ascii?Q?rPLLYUZosdjfTSGG29ueoiYQ9mzlK+LwDmUUe/ZLIzjxe4WuPfT/DPZQrPDd?=
 =?us-ascii?Q?hZqLyL24leYWf+idmAh6Cz5Sx+mjRZihexGOFiC4FGvG/xyiP3sDzwLwjTAb?=
 =?us-ascii?Q?xMPHl5KOKGC5OE3HYjEpfuu4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afd18b7-221a-444e-b2e3-08d8cf939211
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 20:19:59.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m20ZOk/MSKwkkOmQ/txoZe5nOKq42iFqbBmvyPr6OecFhwdCbV89XbtaZTdZlqIwLmpLR7JVOeV1DuH605uhFvTz7KDnmW0VhlDDTJoPdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2176
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120150
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split-up generic and platform dependent code in order to be able to re-use
generic event handling code in pvpanic PCI device driver in the next patches.

The code from pvpanic.c was split in two new files:
- pvpanic.c: generic code that handles pvpanic events
- pvpanic-mmio.c: platform/bus dependent code

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/Kconfig                |   9 +--
 drivers/misc/Makefile               |   2 +-
 drivers/misc/pvpanic.c              | 111 ------------------------------------
 drivers/misc/pvpanic/Kconfig        |  19 ++++++
 drivers/misc/pvpanic/Makefile       |   8 +++
 drivers/misc/pvpanic/pvpanic-mmio.c |  83 +++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c      |  62 ++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  17 ++++++
 8 files changed, 191 insertions(+), 120 deletions(-)
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
index 00000000..454f1ee
--- /dev/null
+++ b/drivers/misc/pvpanic/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Pvpanic Kconfig
+#
+# Copyright (C) 2021 Oracle.
+#
+
+config PVPANIC
+	bool "pvpanic device support"
+	help
+	  This option allows to select a specific pvpanic device driver.
+	  pvpanic is a paravirtualized device provided by QEMU; it lets
+	  a virtual machine (guest) communicate panic events to the host.
+
+config PVPANIC_MMIO
+	tristate "pvpanic MMIO device support"
+	depends on HAS_IOMEM && (ACPI || OF) && PVPANIC
+	help
+	  This driver provides support for the MMIO pvpanic device.
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
new file mode 100644
index 00000000..91d816b
--- /dev/null
+++ b/drivers/misc/pvpanic/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Pvpanic Makefile
+#
+# Copyright (C) 2021 Oracle.
+#
+obj-$(CONFIG_PVPANIC)		+= pvpanic.o
+obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
new file mode 100644
index 00000000..7454eeb
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
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
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
new file mode 100644
index 00000000..652ae01
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -0,0 +1,62 @@
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
+EXPORT_SYMBOL_GPL(pvpanic_probe);
+
+void pvpanic_remove(void)
+{
+
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &pvpanic_panic_nb);
+	base = NULL;
+}
+EXPORT_SYMBOL_GPL(pvpanic_remove);
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
new file mode 100644
index 00000000..7e75dce
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic Device Support
+ *
+ *  Copyright (C) 2021 Oracle.
+*/
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

