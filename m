Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D779E344D67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhCVRdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:33:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35822 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhCVRcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:32:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHTnuE094082;
        Mon, 22 Mar 2021 17:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=MOd4bxUmGFI6b/sZ6nSUzKN3WGaFSm/dkoMX5MG21MU=;
 b=q7xfRaF8KVQerqvkNjXi4mcQNRy6Gyci+ghMtOME764ZFR/hzb3TKk/Bqg7wsu0wUywn
 VAJa/7dg2UV4A6gqDMk8dQMXiDl079l3UZi9uvm/VQ8YaLbdvidEq1Tofu3RicGwks9o
 t8ub9WBljElWkqBc5hRyrhomDaqS5ewKslhDHMlribnEfXeRsruzdU/LF0QzbskmZxIG
 R9Ptps6kCx2ilFrA85lMTyn6tOL0m0EYGs6mRM7Wt+3md5uVkolNMsIRX+sDLvXUo6mh
 MymuFzUZh7D5qJyHSAKFKiy+FbAGkj/MtH9o+Z/oSXNzQD3gq13sil+EETjFjX4iQmE0 og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37d90mc910-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:32:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHUddv113076;
        Mon, 22 Mar 2021 17:32:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 37dtywcepc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:32:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVbCwMzXgvymGZaVWh39sWgzyPBlx5QGXh5N1vXB3puSWst5MOuAgZs0IThwtvWe9BvL+PpxJoPnfWMjoHF9dRbxa1UF9KBE1VB+primTYcjDlDUnBFsQHuIwHc9zL630XQLDfUWJx856Mm9OWgVF/AxaMWYxsyLoJPDdIfeagM57JGVum4mOnlv2DYdYInBXWoIeiK0uAzm13414U3kFDR+wRKfLpGiucZ+DlkSu2XsgdRcpS88l0jnXCwEwVi+B2rK6YE8svqT/9nDklorhQVEHK5ntso4AXcwlRapBrlEpW5iB3LmYQEhcx8FjvNbiG1FP0CNzXpo7yaAU0/zGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOd4bxUmGFI6b/sZ6nSUzKN3WGaFSm/dkoMX5MG21MU=;
 b=IGHbqsvAdgepZ16nwpllCsmQTsXqSm8Xc5lmyQ01BBYnJDvz/17zRiFy5tue7QQELsym0XCtDGVL1busply57fhrWBBfhEqX1WF1amf8r2BGyyKMJuoBOsRteei8skCq4DSGHA5UjHXKiut5k335wDacM8CItd97a0Tn2EBi2xmPNFWaJcWSuaBNlrwYDYQoOmQXDKgcQS5BD5j+DRKvApGq6rkjyi/nVr4YT0szDfej6et/yp5J+c/INoxkKyNll540SrRDV3rMeCxV3BZTpecJUR4m8wNMQIO7VF+9d9h26yKKhs03I9pAyCZc58brkEvTg1aJxcYrIQiS3wcMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOd4bxUmGFI6b/sZ6nSUzKN3WGaFSm/dkoMX5MG21MU=;
 b=iYxxcwbJ3eMVTrkWf6CL4+ZuPLqyw0wntOy7cpiYhgDlQkKcQX0ZCj3VUjASUZW7Y/eyYDWorwffipUFYGKZ1vSmm6wOrbTWE+cQ3+zacTLV8wgaym7GI1U6EciZqMX2u9bJFSnWD3KXm6Z75oEWXNPrMssS9JyUO94flGrTxJo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4451.namprd10.prod.outlook.com
 (2603:10b6:303:96::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 17:32:35 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Mon, 22 Mar 2021
 17:32:35 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v6 3/3] misc/pvpanic: add PCI driver
Date:   Mon, 22 Mar 2021 18:44:27 +0200
Message-Id: <1616431467-14173-4-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1616431467-14173-1-git-send-email-mihai.carabas@oracle.com>
References: <1616431467-14173-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.201.25]
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by SJ0PR13CA0092.namprd13.prod.outlook.com (2603:10b6:a03:2c5::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Mon, 22 Mar 2021 17:32:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23a7383b-9129-4609-42f4-08d8ed587b44
X-MS-TrafficTypeDiagnostic: CO1PR10MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4451D3875593CA371E0A246288659@CO1PR10MB4451.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHO+vAkTNq0JdPIaMBokpfG/ggiRC+BvBf93jnQcO3sj1Xyhnnbp+1oigSFssrWfW4E+8DTtm0dcVBM+k1uRmGes1AyIYKJgEeH99nOpCnqcxwyrldV/NCChSTuwgbvBuMRRwod4YT3NTVjWZZSKuldVjcdfSRRnyBXBtua4PNYKllb5VDA40A+58cGK1AnOAQuIri+CMJDsVJajUxpD1KC4i0KMzfZ1uCjdnD+g3mfPOxpclwrmYNC/k+icmQA28SerBdM3qh9UjAYNOYo0Wl4NbjTKyHj+nWcB+9vJpEHPpZEQwgQ97wIs6iY1vbI+lJ6UevIrfsS/pka2pcJQFHLI2bdSW8O3aJQGJCCxU+sRjCFEhvnveFUrHHE6RXIRn3eiwZ8EWyZcI3KDWwyC1zF+576nWqdd0hoVvIE73Ak45EY2EQ8qxD76V9jVBGDrGGoi63yrSW8oyqo3l9w79r+b94hMxDnhyNpslv4A8hFV7L+/iOX0hJTaDQKJfnsFIXcpNYwFB1qr5LD6Wq5JOedCvlGcpltfXifGfczz+jeIhoOXJSWizze9A9WKlM6XAmqi0LLfLrZ3EOFmB708e4JCiw+YUcz6uj+BW2euONcNMGpQ/w5yGSnv+BWDAsoFGZica5J1qMnAumOuQd/t9xx2WyybtLOqQOM6q13P2xPZpOeKcklCi4uM4Vx6CU3vGw/tBUBCOVS1Fb5AgajB2PWCmDR2KS58wzFlG9tQ5Y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(346002)(39860400002)(316002)(966005)(4326008)(2616005)(956004)(66476007)(478600001)(66946007)(8676002)(107886003)(83380400001)(8936002)(38100700001)(36756003)(6916009)(6666004)(186003)(6486002)(2906002)(16526019)(26005)(6506007)(66556008)(52116002)(86362001)(6512007)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C2FqKHbAxwCiKLpifEw/6yfrbHHySyRBNZNhbjP5gw1sUsGigf5o9iSKoT7M?=
 =?us-ascii?Q?vpVrvEmfvEakRQYgcKRevQhwT51iF8OiU3kkofGCVG9WKmTC58ei0dZrYhf8?=
 =?us-ascii?Q?r/ey2Ie5RDhrW4WDlO3VLHf9weQD/Z3VYIV9nvhBIyBJYJ04DJYmOU0nWL74?=
 =?us-ascii?Q?KwsHZeEjBXeCnSqJmXZKDEGcTFeSfgaQt+f7GqF1s9d2iU+xyURcpIBUFwir?=
 =?us-ascii?Q?c2H3GUPlUxjdo/YbZB8er/z0T4T21DEdkxjFDiqWWWsuINkloxFzNTlweORY?=
 =?us-ascii?Q?lMBMxKMzQG9GRP9jU8VGYDzCbRzYqdRdCTyxVc3xGH9YKs6oPO8fTizFQ0r4?=
 =?us-ascii?Q?FSef5gvanamsa/gmyMpbq+OA+Lo8R04vldmPwZ5IinQhlaytlx+JtUs8b+b1?=
 =?us-ascii?Q?Xrtu1/52N/SnTYdVspkqLMck+dw04BZynO1cCfEVS8/+XbMRmxLbfGmAuIhr?=
 =?us-ascii?Q?5kisvJ6hct33BtzNkLR7i22oQq/xVg+is+jfBlgK+ewguZzWuhnEVYlOD7iy?=
 =?us-ascii?Q?TuBBHmRFi6rZAjmzqCuMe64DrliTz+PGU1clxFL8vxKSpuRKEc2HFfbLRUDW?=
 =?us-ascii?Q?5nVVbdWIwnOmWkxM1NKEtpq8vNLiST2vJDgFLrkNNEhcD19BoRBmj4oqVUGN?=
 =?us-ascii?Q?6XTryQWwsiWvEU2KIwomlSGzYpbSs7PZKXQPHk004HfDRoTU/jUttIZirjrz?=
 =?us-ascii?Q?A256+VpcSRLXGLzXw3+oSk0VAYYrLIchWRZQ2JGoU3ykmWuZewVveB6KdbkA?=
 =?us-ascii?Q?GlXciQxX2+znA5YGgxEKhaPbWtaXCvfxSqTbUYbg71Gkp3oWmMhQ9eChBTAv?=
 =?us-ascii?Q?/b++0rKJToToRnoXsOGCovokrl44nyqug92ccOmdHLRBpQDM3w1hBXgTbKeY?=
 =?us-ascii?Q?uiVRPRnDnBjTypaxtVOm6h3O9J4NmlZqxMvLfRpHEO1PPEs/jp3GoD6TRWJs?=
 =?us-ascii?Q?dV5JixkKtc28+35eJsBts1d4Ry6yqA9AZJrpBlBRV9IKwujl/tDUWARwCH/l?=
 =?us-ascii?Q?CdSaVnpX5q1BbxZQTFGO131zKvRQwI2CfyYnTaKfgEso3vR/wGKMeiMXdq+y?=
 =?us-ascii?Q?NhcagTW4Wq67ppD/9MlnGEHpUoo3t4rYzwfCAO+D9i/7Xpo8upgiF6eyadih?=
 =?us-ascii?Q?y78fbsFOIOD8teHfUAGwu7JO4t/BVpGFig1Z97XDodoZ2B5KZ44FfURDCobS?=
 =?us-ascii?Q?htdABh6KHPWx6orzeW6lShhLxxIE0bI8085xaSgNnSNGrDcg6DRbO7N0g9yp?=
 =?us-ascii?Q?5S0WZs7w+lrYjXUYaRoNjm2GXdqV7LDo5u1JUmcrTpZeNdOwYS4Vo+xa6+pF?=
 =?us-ascii?Q?zpo3d8ItZbC4N4zGh0R/247p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a7383b-9129-4609-42f4-08d8ed587b44
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 17:32:35.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o60vUnmMtJI1y8JtiQxcfJupZAvjJNFjRgGFclr5QK2p2KO/sNRKs1D8BxyP1P5yl47kKkHDSPTCBvMC+3D68nJQK+uuhC3irDO5YWWubUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4451
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220127
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
 .../ABI/testing/sysfs-bus-pci-devices-pvpanic      |   4 +-
 drivers/misc/pvpanic/Kconfig                       |   8 ++
 drivers/misc/pvpanic/Makefile                      |   1 +
 drivers/misc/pvpanic/pvpanic-pci.c                 | 121 +++++++++++++++++++++
 4 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
index 1936f73..4ec03cd 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
@@ -1,4 +1,5 @@
-What:		/sys/devices/pci0000:00/*/QEMU0001:00/capability
+What:		/sys/devices/pci0000:00/*/QEMU0001:00/capability for MMIO
+		/sys/bus/pci/drivers/pvpanic-pci/0000:00:0*.0/capability for PCI
 Date:		Jan 2021
 Contact:	zhenwei pi <pizhenwei@bytedance.com>
 Description:
@@ -12,6 +13,7 @@ Description:
 		https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/specs/pvpanic.txt
 
 What:		/sys/devices/pci0000:00/*/QEMU0001:00/events
+		/sys/bus/pci/drivers/pvpanic-pci/0000:00:0*.0/events for PCI
 Date:		Jan 2021
 Contact:	zhenwei pi <pizhenwei@bytedance.com>
 Description:
diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index 454f1ee..12d40a2 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -17,3 +17,11 @@ config PVPANIC_MMIO
 	depends on HAS_IOMEM && (ACPI || OF) && PVPANIC
 	help
 	  This driver provides support for the MMIO pvpanic device.
+
+config PVPANIC_PCI
+	tristate "pvpanic PCI device support"
+	depends on PCI && PVPANIC
+	help
+	  This driver provides support for the PCI pvpanic device.
+	  pvpanic is a paravirtualized device provided by QEMU which
+	  forwards the panic events from the guest to the host.
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index e12a2dc..9471df7 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -5,3 +5,4 @@
 # Copyright (C) 2021 Oracle.
 #
 obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic.o pvpanic-mmio.o
+obj-$(CONFIG_PVPANIC_PCI)	+= pvpanic.o pvpanic-pci.o
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
new file mode 100644
index 00000000..da64268
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic PCI Device Support
+ *
+ *  Copyright (C) 2021 Oracle.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+
+#include <uapi/misc/pvpanic.h>
+
+#include "pvpanic.h"
+
+#define PCI_VENDOR_ID_REDHAT             0x1b36
+#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
+
+static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC)},
+	{}
+};
+
+static ssize_t capability_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%x\n", pi->capability);
+}
+static DEVICE_ATTR_RO(capability);
+
+static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
+{
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%x\n", pi->events);
+}
+
+static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+	unsigned int tmp;
+	int err;
+
+	err = kstrtouint(buf, 16, &tmp);
+	if (err)
+		return err;
+
+	if ((tmp & pi->capability) != tmp)
+		return -EINVAL;
+
+	pi->events = tmp;
+
+	return count;
+}
+static DEVICE_ATTR_RW(events);
+
+static struct attribute *pvpanic_pci_dev_attrs[] = {
+	&dev_attr_capability.attr,
+	&dev_attr_events.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(pvpanic_pci_dev);
+
+static int pvpanic_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct pvpanic_instance *pi;
+	void __iomem *base;
+	int ret;
+
+	ret = pci_enable_device(pdev);
+	if (ret < 0)
+		return ret;
+
+	base = pci_iomap(pdev, 0, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pi = kmalloc(sizeof(*pi), GFP_ATOMIC);
+	if (!pi)
+		return -ENOMEM;
+
+	pi->base = base;
+	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+
+	/* initlize capability by RDPT */
+	pi->capability &= ioread8(base);
+	pi->events = pi->capability;
+
+	dev_set_drvdata(dev, pi);
+
+	return pvpanic_probe(pi);
+}
+
+static void pvpanic_pci_remove(struct pci_dev *pdev)
+{
+	struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
+
+	pvpanic_remove(pi);
+	iounmap(pi->base);
+	kfree(pi);
+	pci_disable_device(pdev);
+}
+
+static struct pci_driver pvpanic_pci_driver = {
+	.name =         "pvpanic-pci",
+	.id_table =     pvpanic_pci_id_tbl,
+	.probe =        pvpanic_pci_probe,
+	.remove =       pvpanic_pci_remove,
+	.driver = {
+		.dev_groups = pvpanic_pci_dev_groups,
+	},
+};
+
+module_pci_driver(pvpanic_pci_driver);
-- 
1.8.3.1

