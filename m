Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE431ADF7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 21:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhBMUdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 15:33:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55816 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBMUdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 15:33:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DKU6EA192639;
        Sat, 13 Feb 2021 20:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=pM6JLdJyYlv/TNdimrXi/9PlpzaaSKWGfKwnJPMSQ8A=;
 b=YVETRaigLBnzsJZnJ6a1ewnzgDktsyHtimTpsXcdIWhYCCJr1n/okrBQ4WXGvKkOKZCI
 1/d58wX+wQlfeKtaXZe7cqD5gfhd3h9yZqGKQbDv1i2u+wDZuCFG3qVuOOqjKlhgyHVq
 OmLKD4RPbpeII2w2NLv0JJiwZDj9bPNpOr4Mh+WBq54QgR/EA4pTQSNUjnM/Gf5EEg9i
 +7zSX/vwxTCqfImyE4TUF9h6r/JjLEf/17Dcf3bXlklFvgp57EaIYbhypO0qJMVJ2k/V
 cOpZnxbWIyS+hOcaZceShR0NzWXscY5ypnv/Bj0bc+DfmK9wAJ33W3E0xszV8KvWT3Z/ rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36p7dn8yag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 20:32:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DKU650107009;
        Sat, 13 Feb 2021 20:32:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3030.oracle.com with ESMTP id 36p6bhhyv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 20:32:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqJ0oEqINvyEBrMbUyaesGH3JegS4sWBASbZsI9HxQh2NxBDrJ2K83KvI9/nqBX4258wJ9xTroaVSFofr/iIPVlfBmMXKh3dpIuI35Uf8tqXiWBRm0T4JLhPq+gknGkXYEJkP0hTRRLDyd5B/at8Br+9QFgNpNTO2PWS+Bg5FquCfWBkhDeD5k4xwDB2eMx+HZHRg3VpiSXrlw8HAF9vSweHdvpop0aaQPBGe2M7xIsCD3G8iwjaVHd2DYwMwQD2IYUmQsxQiYcZ5gBHhae9kYMg21Q9LgyEKTTQARmbGhXZPrN0IC/EdvhLGRS7r4GyQEq89Qb+BlwK55m9nxexHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM6JLdJyYlv/TNdimrXi/9PlpzaaSKWGfKwnJPMSQ8A=;
 b=Ta5H8pjVzqMbdWS5+dervsxsxz97c1hhBRvgKW9KcgyKoRaqjji2kw4hWTfTsMzBFOvIxc74JY0c9hU9WI31r8QC5BT6CmfoFpvIKr8C1wI0PJpPhgLnEgXZrReDf8oQSqG69VJkmdCYsCdps+YHTr48r2OZ3P32lyp3w42b+fG5cLaTgayLh51D96YjPqIw+G+Yo940F4UhNDZKq7+oMU0VDvEMvkAhFLkOMWUa7AJxnCHP5is6t6jtCFSe5hRAH5h/NeG4U0HfdtzC4U1RjPlK4JUDMIFl7O7Bxqbli4xUA0J1B5dMZW1yfuX4bcI0I4fdTSvV/5a8taQmkq/ziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM6JLdJyYlv/TNdimrXi/9PlpzaaSKWGfKwnJPMSQ8A=;
 b=ivayf5GqbtFWw8H9H9qLLufulcjiSKiK4A2pX0blu0IwCc7fxSm7xG8JQDCiqv2vcE/FwcijuO6FI6LLRjnOVxKLuIi1Nfqk0TTR3APXoFKfcjadbbPG4UCCBgXgt+O6emUkGJsy83E7QTRQpDY43NqDB7uGfgVSIpfsHmrrq/Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2286.namprd10.prod.outlook.com
 (2603:10b6:301:2d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sat, 13 Feb
 2021 20:32:03 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3846.038; Sat, 13 Feb 2021
 20:32:03 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v4 1/3] misc/pvpanic: split-up generic and platform dependent code
Date:   Sat, 13 Feb 2021 21:44:05 +0200
Message-Id: <1613245447-21495-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
References: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend Transport; Sat, 13 Feb 2021 20:32:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 810eabec-23df-4d0e-15d7-08d8d05e6bb3
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2286C56B6DB55E183CB6E85E888A9@MWHPR1001MB2286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: im0qJ8OaPzonxjgSJpq/l/AsX7qaiUEHQku/zysm6pToho+ariBn0UV+pqocaBNAsvzwrmvEqq8zzgGz3zP1/H4uihv2uLfaujDU51L/aQLVcwIo13XUwjM9wdfIuiAZMZw5y2m0yvGtZ2wRtXTe3mylotwu8qNuGi2I93TJdKAbm3ivvaGZZ0QconuF/FitAJBpljlTTmetfYKJhXm+tVH+C3HHz7DZWZ/XlNxeO5/eJ6t9RhDNfHXzlDJucUO01txrXkf9ZGS03GxPVCDzLg2lbtDIGfXsNfqVCBosu6pury9mOwrlqjVlAuTiyZxqfC1UuG/O1hWmBW9yDa4/jVrsyuxIw9rZGfeUGTKKg3xB2YUWJBxSuP7Rf14jOZrfG4SWv2wdulRSP+z3a+nNonML5p2pHAYL0iQfLvTjUY+so5DxQmeKeh3gtKeFTsFoe3FllhJHqI4mC3XNUJIdX8YdmIMnitJA+LKD0jOBR/ezR66jYXsYuahknSDQT9m8X/rY2QNje+0DydkXTX+77WlKepfggx412bVJNaH2ujLe2NkPsvNwxFfdw00WWzVg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(83380400001)(6916009)(66556008)(66476007)(52116002)(478600001)(86362001)(66946007)(8936002)(4326008)(36756003)(16526019)(26005)(186003)(6512007)(6506007)(5660300002)(316002)(107886003)(8676002)(6486002)(2906002)(956004)(44832011)(2616005)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IqjbGVR1kP+IfrQ7hnPTYq2TOkikUHVAJ6S2eWuXMAIDJMgdKF6JQeubV1j2?=
 =?us-ascii?Q?EXDNwKus/auHQ2acBq/8zJ16JH4aTykNTnukRQP7/qzLlLzFjc5k6ULbAXQn?=
 =?us-ascii?Q?9kze9INBHQiiMyzW9mtMJjURjIKRL/r8MWvNIrzcDxMGTye7h83a7azh53jw?=
 =?us-ascii?Q?SaYOMaIzeejj+2GkpfLwO7SXv/0/HZuPfvsrVWrw99ovkdHzGOqj8CUjuMAj?=
 =?us-ascii?Q?fRKOnKUYq9EwcAN+gKwIbl9280e6IY8nwJ3g2+L2CMDMgS3ZFN7L/fWw8RPn?=
 =?us-ascii?Q?+QTdKiX1a51XM2ouz0//G3eyYfiiXZeAcmRJ93MnlU2UN5HwJs+KUTif1EYA?=
 =?us-ascii?Q?W4nOSpHG0PCZ7DyYXwSyvcr1xN8KFUn/mdH10R1rMw4duSsY515zjbKV1i68?=
 =?us-ascii?Q?TbcRdxZJJQZomL8LHycP2i/3HwO0fLaJPpkVl8N/s+eGCBZr6Exhog+HQbMN?=
 =?us-ascii?Q?8kvleyJujnJErYzwoSpyImJ1zKFv3N4H/Xcdetq8IG0ednN+IutckYrtvTT3?=
 =?us-ascii?Q?rxA3fAyeqAJi66gPPzXlGcTSIFF3vg4ORSq1h48Qc6ZmaN0DTRw0ly8U66FB?=
 =?us-ascii?Q?5NtASsya/NscI9zNaAo8PagWc/GCySTVHCtwlApuexIwwpW7En8kHGRyvId1?=
 =?us-ascii?Q?gInhoj1FqLgDp711Bg+Odo5/FNP57kxdvrzSIdf/w/rrSTck5w4B8adjFcB4?=
 =?us-ascii?Q?MTQCXL9R14wZn7Dj8UyBUwrMfqdDxA6rk3EmXRIij6Lr0CL7Q2uq3hM/oG7u?=
 =?us-ascii?Q?k0vL7JiDqB07ugqdqdrhI5l0kdgTOADw7+ziK2qyq+85S98SJsnksoAVcO4g?=
 =?us-ascii?Q?3kzVWbsFFR/VmpDlhczJYb2hWCW6nCVxoL/KPmauLsNh9KcAZnKp8Cf/xIe9?=
 =?us-ascii?Q?iELERZrgUwxh1G/rfeb/Q4g4xpOixrYj9yawG4jBl9i4mpn4cMbqK0SbUiB0?=
 =?us-ascii?Q?Zz8zedrzt1bkB1x2BD5YN+AsiA/MMRmOP3h+aPfEg3o+l5TjU/usTMX4OYKs?=
 =?us-ascii?Q?Gb5LXEC/w6mkWgfWIo4FBeF+7C3rwElbjG4Bs3J8hidsyZAJSjXaek3NrC91?=
 =?us-ascii?Q?06eFOZ01pjgvdYsh1UXT9bpXgRhaYnflrELEHZztaOjLJUtJcv4+98MU+Bjc?=
 =?us-ascii?Q?C2BQ5rWtMviUzNogg3vdPe7dWpbSZBXMGTG+sjqREEBIN+woQCUGuPGG4Syk?=
 =?us-ascii?Q?xNMT4SzdRaoFieMUfiv5vj6nbG4252b+se918YZ10jAB9CmK8z5v74KS7WRJ?=
 =?us-ascii?Q?dlRtd5YZhRIRUEDUv3+7s4Fe+vH5TZn8DDKmbcpfGHr8Zzmf3UlrojYZD6c2?=
 =?us-ascii?Q?ymsmPO/0E9vDLb9HPgDrBROU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810eabec-23df-4d0e-15d7-08d8d05e6bb3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 20:32:03.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUB2qJRO/JAj+oHIuR81YbaF8oxPrxnf8YCqnFa7pac8uuo8PfBoQ4/NhZXYc5ljw795ct+rzj/vM1O051G3z/kRZii6yhr8SJCOEI4ODGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2286
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130190
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
 drivers/misc/Kconfig                               |  9 +---
 drivers/misc/Makefile                              |  2 +-
 drivers/misc/pvpanic/Kconfig                       | 19 +++++++
 drivers/misc/pvpanic/Makefile                      |  7 +++
 drivers/misc/{pvpanic.c => pvpanic/pvpanic-mmio.c} | 42 +++------------
 drivers/misc/pvpanic/pvpanic.c                     | 62 ++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h                     | 17 ++++++
 7 files changed, 114 insertions(+), 44 deletions(-)
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 rename drivers/misc/{pvpanic.c => pvpanic/pvpanic-mmio.c} (67%)
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
index 00000000..e12a2dc
--- /dev/null
+++ b/drivers/misc/pvpanic/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Pvpanic Makefile
+#
+# Copyright (C) 2021 Oracle.
+#
+obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic.o pvpanic-mmio.o
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic/pvpanic-mmio.c
similarity index 67%
rename from drivers/misc/pvpanic.c
rename to drivers/misc/pvpanic/pvpanic-mmio.c
index 41cab29..7454eeb 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  Pvpanic Device Support
+ *  Pvpanic MMIO Device Support
  *
  *  Copyright (C) 2013 Fujitsu.
  *  Copyright (C) 2018 ZTE.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+ *  Copyright (C) 2021 Oracle.
+*/
 
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -17,42 +16,17 @@
 #include <linux/types.h>
 
 #include <uapi/misc/pvpanic.h>
-
-static void __iomem *base;
+#include "pvpanic.h"
 
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
 
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
 static int pvpanic_mmio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	void __iomem *base;
 
 	res = platform_get_mem_or_io(pdev, 0);
 	if (!res)
@@ -73,8 +47,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
+	pvpanic_probe(base);
 
 	return 0;
 }
@@ -82,8 +55,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 static int pvpanic_mmio_remove(struct platform_device *pdev)
 {
 
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
+	pvpanic_remove();
 
 	return 0;
 }
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

