Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5431831A5F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhBLUVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:21:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41968 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhBLUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:20:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CKIhLY111019;
        Fri, 12 Feb 2021 20:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=X5QZwbH4WYyS8CXz7BM2YAQskZn+y9pX7V1ze0U6Sok=;
 b=BvhcF5ETpZeZgoClmyBoo77+0/1Qz0dOCt0TKZMuN2ekTrQvipHCJV5eLl7yJ6gtm0ky
 S1glTv0OjTYb9k9Ih1ptfKj5xxoGZA2ghHuS9MyY+/uOQyc8wU/v+m0LdslI08WtxMMT
 g3O3PHDlRQE4VidNZYq4fveNKn5lsjLwI8R/0Eu7R7auKUea/SeD7obFMExMWRsl01Ur
 Hei84APrKxRO/QPMcRrf1jAdE4ENPElerLmsuxJ8kfP78SXtGFVerVaA8QDl3JziTSeW
 Dokw2HpPRXQig8JDSGYkCQGWBf82q3daTSdmPE1zkpXyV4ayGOkcOAHbAZ48Y0nS8vbK 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36mv9dxqfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 20:20:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CKGob2175506;
        Fri, 12 Feb 2021 20:20:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 36j4vw5k9r-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 20:20:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P70Hi4TxPXtW/91453DL3tLz3cBEcORhxNVp1f9ZNg3o0zAsHkce9NeUchw6A4xtfiyjlLfXKN+CrTDxL5Zd/6slT3OwyBzgqBebG7DAMXvuG22ZeGUHMsvAW+gBK26NGIDEXvESwbBhdmzhgBgItLkRQP2niY/uUrXDmN8pBBpR4pCA/Jj78M8gwb6vBF/ay4h8N8uxyloibqMWWBXS05RbWXdcZkX9l0e1ePlKvuGUaPnwpcxQ0iaoe+fWGfV95A2vlAIO3wdxGF0eeJoB05YWOFtYXDuXG+KjNfIabq9ulDrKh33vjKcX31CFr46NHLQIR/sk5udNN4KTX2WTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5QZwbH4WYyS8CXz7BM2YAQskZn+y9pX7V1ze0U6Sok=;
 b=ZrnDgd4mayiiCUzwUv3XJZy0lhFkTEMLGjQR0zk97bjLWsjQDC3z8CEahfhdxxcNe/rXjsWbkYMU12i3Oa+SzE583I2q+HDuAligi6n8edPz+pFl08j6AR8JIt+6ojDYZsfaSrCvzSW3qbTsIF58riJML/KROTndGp4Xkk4o8i85Mso6yGLpUvkIrQbK+UTKZ0mUg3PS4bvGw8wPY3kdwbcvCxSjNlkf/AF0s5JEKTMvNKW+cBz14otFwwAmmq95NorHfXrlTlWY2D8t10971WwufL7Np7xg+162OlxFZ5SgTurSZjEJIzRggRY4muytAyPVoMnLxGoCKptci0LLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5QZwbH4WYyS8CXz7BM2YAQskZn+y9pX7V1ze0U6Sok=;
 b=ey4VjB2HTgMtu0zrKjsB/bBcnWqzc5oG2N88haEciiT25KLW3FtJfmL/D3YD9sW+po/m+1z2xCRggA6jPPzITWxWmTHJWAcYIALZ74AvZNYjKkxlmahwCTtITQLhCGW/tLxvX2nMIxxWYb6Er0ktK0Tns7ZyUo7sZ5qrFjv3Beg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2176.namprd10.prod.outlook.com
 (2603:10b6:301:30::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Fri, 12 Feb
 2021 20:20:01 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Fri, 12 Feb 2021
 20:20:01 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v3 3/3] misc/pvpanic: add PCI driver
Date:   Fri, 12 Feb 2021 21:32:28 +0200
Message-Id: <1613158348-19976-4-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.200.25) by SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.14 via Frontend Transport; Fri, 12 Feb 2021 20:20:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d98e22aa-8029-4bfe-712e-08d8cf939382
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB217669E74DC4DFC69E0FB869888B9@MWHPR1001MB2176.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4VX7QZTF2bghnRPok9etBcPAi368VoLBStLuhNhbeQWQhVDI2Q1GOTSryvukfExWvWxLM5bQioELMR6r+MVzcuGN0OHYTeDXWehKo/vrg0tpQ0tzt2cAfQ/wCh8VCufBJfpLTZhz6ppwPH9kPbbA236OscI1tfCczWYlqL1pMYrtIALCIxaNuPJW78R/jU1ruCyMEQJ37n2pIFp6p1rGcHGGp0Tn8Emm3GxBi127F/BrsMvp7euwzTSB7PRKS45eCfm3GDuzU97knsDE4V38kgSnEUylQa4UA/TupFCfqQ1vtggTacyaV0C2jGWvAgVVwsNLy3EVwVVpSQkM+t1YeabdMcMaafQpA6Ua6Jf6/Ak04exCfYtLWbbHFc/bvLoyNalyyclFsyQdyw4olucMPh1XDBCTU66rs0vfxJDb7AydAkevQHpmpLAiG0l4SdjXfSeUM9epK+5FIMqAbRpKC/HhTYLlWh7LLQMMNtMDYHFTyPP/OGAGgSzmc/ss6YruepLjGoT9enXwtfMeVc7BbfY8yjEwMs6A27uMBKnfO/r7Oz0m9VBzpPt9fdBrMZEzGlLDlNwJXE9GbNVQ1V2h0/w9kMS+g3+wHFdBUomxcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(136003)(376002)(6486002)(6512007)(26005)(316002)(956004)(44832011)(2616005)(966005)(16526019)(8936002)(186003)(6506007)(86362001)(6666004)(8676002)(6916009)(107886003)(2906002)(66476007)(66556008)(36756003)(52116002)(66946007)(478600001)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fFjwGLmvtk6kNeqIxSQiAlukP9AmKNm0tryeZCapuR94B0CiH3oaJou+U0I5?=
 =?us-ascii?Q?XpT26TAzpOutvxeiKCK9sLBGaxGssQuGEUQotqjh259N0dQGKRJW8qEw7Hfl?=
 =?us-ascii?Q?07PyVTJF8gAeJQXApxgIa3T6W7uuzRtPoaIipiTKpbVJ0Sr214S+xG5uHr5Y?=
 =?us-ascii?Q?IXXuwTMpjWD7c4xkvVmO27MDKbKnFcyoyNGGbslKqQ1WOzCpXKWHs1wVU0yx?=
 =?us-ascii?Q?K5yJTr/K6NqaqFS5crvlOXk1U42KoC03BnejOnUy42XM91ZqLdkSWLJk0qkO?=
 =?us-ascii?Q?JvH6+99Dsna1xsDnX4+FJ2qthMr6gK6TNy/c++BEu4oLNhwP4rBBYQ93/llo?=
 =?us-ascii?Q?O+SuwvnQcFXXx7UPHpoQGtpRtb/9CGjz7LpQwm/6r73UZtKKPtcEgP5NYk3W?=
 =?us-ascii?Q?2ymYoxpA/ioLTKtReW205PX/zstjrgif/O++//4bTQ/xdicMqRgbSf/8zZa2?=
 =?us-ascii?Q?+D+OAoACagvbKzM//tC/TDyNTua9CcRsjKerH7X9waqRORtQt6R63Dk7W51f?=
 =?us-ascii?Q?ey/6QG0fZn9P8XoI72wI9e++sb3W8uCGnoleonCTgZNrShio7A9bR8BcXUdY?=
 =?us-ascii?Q?9WlBfe+q1moi+zyrEhIfceamLv4y2SJDM58jalrw882lleJeyZnOe66woyls?=
 =?us-ascii?Q?HMs5559CWTtWatZLDWS39wFgbiiLbjP7kK/Kkyt8Qgy/L5lYfmQKHq26E4Zx?=
 =?us-ascii?Q?NFiU7pupjGmhKP3APPQGIpOHRpdTmixJOxTJx4KV+AeOAjlMMLWJa/L2UL/N?=
 =?us-ascii?Q?P8ZsoBt+0Ji+xuh5untNUCp/j+aY4IxehxICi0CJdJJrbWSOhRMHrOZoa0+q?=
 =?us-ascii?Q?XW6o8HUCED64QG0LESUoyOvLKHFqdwNT8XzX84hOiDOVa4e4jC2ARUhTu1ON?=
 =?us-ascii?Q?SWtSUFx4A/qwB/Scf3edBUJH+l9EMuIQ8CCte5mkeCwDP9CNGpwCHvFepra0?=
 =?us-ascii?Q?CzquZdYmZVA6MrE83Zs1SExkXtN3v0q/qKyO75bsBLh95FXco+bMDsI4Yfkx?=
 =?us-ascii?Q?0f9JL2jA0nPjBK/VHp8T0gr/unsnX7pbgAYZccI77jTQOdzv/wXYTHKL+pNg?=
 =?us-ascii?Q?LhsZeo+dMGvqgXPtHuLUaG326zrEtaQM/vPTbxlQOasxNAsiiRr8+bpoAPmj?=
 =?us-ascii?Q?DLZy1cNrFSJ8iXdJTb0UJy8bWfaYei4fx0J+1LK1MPzk2kYKeK9es1aVIzza?=
 =?us-ascii?Q?tszPFSI4hCBy4lOUxQG/zG1j34uQ0wvCfA7grnLwV+xaRrAjfzjHTH1F3/E5?=
 =?us-ascii?Q?k/Lz7YDw+Rh/NgIYUWVJVnY6aWrJsIDomn3QtUknhlqOLknY/HM+Ub6z0M+M?=
 =?us-ascii?Q?2bLUPHrecWAE7rSQDNw+K1Ry?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98e22aa-8029-4bfe-712e-08d8cf939382
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 20:20:01.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQoX6BssyIm6hdeWa/HK5p1vmR8VmjvBNj9aum6OcqD6YI3beKmLWYL2xrubcT96/hUjAX5vKm5gvBvlFbctbCxkwgNtMCZM2et5dGQzZhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2176
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120150
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for pvpanic PCI device added in qemu [1]. At probe time, obtain the
address where to read/write pvpanic events and pass it to the generic handling
code. Will follow the same logic as pvpanic MMIO device driver. At remove time,
unmap base address and disable PCI device.

[1] https://github.com/qemu/qemu/commit/9df52f58e76e904fb141b10318362d718f470db2

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/Kconfig       |  6 +++++
 drivers/misc/pvpanic/Makefile      |  1 +
 drivers/misc/pvpanic/pvpanic-pci.c | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index 454f1ee..9a081ed 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -17,3 +17,9 @@ config PVPANIC_MMIO
 	depends on HAS_IOMEM && (ACPI || OF) && PVPANIC
 	help
 	  This driver provides support for the MMIO pvpanic device.
+
+config PVPANIC_PCI
+	tristate "pvpanic PCI device support"
+	depends on PCI && PVPANIC
+	help
+	  This driver provides support for the PCI pvpanic device.
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index 91d816b..b02a95f 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -6,3 +6,4 @@
 #
 obj-$(CONFIG_PVPANIC)		+= pvpanic.o
 obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
+obj-$(CONFIG_PVPANIC_PCI)	+= pvpanic-pci.o
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
new file mode 100644
index 00000000..af94ab8
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic PCI Device Support
+ *
+ *  Copyright (C) 2021 Oracle.
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include "pvpanic.h"
+
+#define PCI_VENDOR_ID_REDHAT             0x1b36
+#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
+
+static void __iomem *base;
+static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC),},
+	{}
+};
+
+static int pvpanic_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *ent)
+{
+	int ret;
+	struct resource res;
+
+	ret = pci_enable_device(pdev);
+	if (ret < 0)
+		return ret;
+
+	base = pci_iomap(pdev, 0, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	return pvpanic_probe(base);
+}
+
+static void pvpanic_pci_remove(struct pci_dev *pdev)
+{
+	pvpanic_remove(base);
+	iounmap(base);
+	pci_disable_device(pdev);
+}
+
+static struct pci_driver pvpanic_pci_driver = {
+	.name =         "pvpanic-pci",
+	.id_table =     pvpanic_pci_id_tbl,
+	.probe =        pvpanic_pci_probe,
+	.remove =       pvpanic_pci_remove,
+};
+
+module_pci_driver(pvpanic_pci_driver);
-- 
1.8.3.1

