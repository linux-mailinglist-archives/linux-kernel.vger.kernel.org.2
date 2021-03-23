Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058EF3461D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhCWOsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:48:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39048 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhCWOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:48:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NEioEP097482;
        Tue, 23 Mar 2021 14:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=MOd4bxUmGFI6b/sZ6nSUzKN3WGaFSm/dkoMX5MG21MU=;
 b=shvE9pHOJFQ9fHne0sw3yHHZjE2/MYpCgluA0gDqvaTROy8Xsaw/trPNUEyjPJbmPYTV
 VNxzZZ1z+UsgYa75S4nW7NkkDSTk6+VTA1UlK6IoAjowWoX1ZV7xgiBLlQw/k91YRDlf
 pLjn2HoZ2oa7DMGzaGSUe74x9Nj6zpPCBoKVmhGx+YovPy3OjAbTD9F85Qe/BhFs0R/d
 44XdO4rPBgsB/LW0xMJMvF7y+AVRUsQb4k+JMbZ7nXlElRXxFATHU+u/AR3Z1Za7NyM4
 GqJ1arOtdLvDVjjVaOKegB7qc/RexAIF5D0iEwA7WfwE9q/7rXw7MBxbA3z6QGpkm/ob Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37d8fr7aaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 14:47:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NEij8s126464;
        Tue, 23 Mar 2021 14:47:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 37dtyxhf8v-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 14:47:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InY/neO0RRafv2lHckV/v0TrIETWeogM9xFgVb/gupQsW6HKGVfnJ+crUhgZ2gA7NOM7sMOZL86mYqZSA3mw7BiIdMwCQKs0JgG2trz6GEzSkKlgCuLA4OwSZlPQ776Sic16QF4lx75SNA9yGpf2mb87VLLRV/AcXtXMxJPe8JtXyxN3BW3UTUzLvHUYih85QuH2KUpAMD7SX79SVvlCPYs2PXmhEeUVyA/NPnkUHzHaMuZ2oErzjBjoXcPzuBiWSL7o0FA655DTlqLeYPRpln6PtyFIERZ5GKyEiZEHFOUyi/Yqvwubtaxm8+MqzT6uQ6hzFqdfLBvaHLqdCBXLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOd4bxUmGFI6b/sZ6nSUzKN3WGaFSm/dkoMX5MG21MU=;
 b=PUjETRfLm25mCGuVHIE4U513lEbrzk0o+1GZjVNjO/5QzQX/HVm1XW/IjFo1B1aq1FBD2Q8YW1XKpOSCFb380Tfu3zl/rPh21WjQS06/JtkzRqSIw+XQWTzVyEpobOgNtn+rfjD78Vu+Uw0wLot63sm198Ar0v4+XzEM6nYFBVlEjCthfM5H50vdiceDBPcgK3SJ/0p8HEdWtTZ2ZSPDujt9cEaLkAhVgec8/qnieVD48OcSOxjtRBVQJGCD7TAA+ZPvfcDX3oh1yWQvlunIn6Ko+kfy4dQh5MeEFWf5s9s2g/XvuU35y/3pb1iF0bcGwHA2A1K0SBz/Sy7LiA6cVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOd4bxUmGFI6b/sZ6nSUzKN3WGaFSm/dkoMX5MG21MU=;
 b=b9cqR7DqLoP+uKYAlx4zuUE2dWZOouvRprR5CyBmaC3ohopH4snkhphHCUlmk5JdlZDQs+Rm76FgA7S0oKFFKJulzSwnWIDGlzSQwiN9Ly9h2F69kPb7vjQFCRwb3vkQAuEJQfcfA8Nn8PyEdaIxkdJGwnVpV+sEtaGMazngHC4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2304.namprd10.prod.outlook.com
 (2603:10b6:301:2e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Tue, 23 Mar
 2021 14:47:37 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Tue, 23 Mar 2021
 14:47:37 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v7 3/3] misc/pvpanic: add PCI driver
Date:   Tue, 23 Mar 2021 15:59:38 +0200
Message-Id: <1616507978-15661-4-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1616507978-15661-1-git-send-email-mihai.carabas@oracle.com>
References: <1616507978-15661-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.201.25]
X-ClientProxiedBy: CH2PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:610:52::21) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by CH2PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:52::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 14:47:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf0e69e-fd09-4a53-21ec-08d8ee0a9a01
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2304A171C49FFF596FACE2F688649@MWHPR1001MB2304.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9eQ+NE64hdHTjbeL+8rZkaoKpr6gb2HUVgJ4dp72+y7E+JtbMdPlVh/9540AdFbZwWWcNwJJ/jXr6nZnDaUQy2knIsWiXjhTFzu9mvCRInrhZZ//83R73xF5fEyPeiWcCv5C0iH0Vb8mGoy02KBIjxVesd/T9Gxu9FZzQLZXgP3ZMSBDWS9huTu+KBenzRSMj7YWM78cRE9OmDQNm97v02TIfRJx/L5u4ztSeuJobnALNk0uwgZ9LWuU2acJEzNUApWYVEvxwEv54JWNSoK0s8XbpCPAyC9LB1IhuQVSH9782JngZcb6fya3BYZfqlDshvwHSmvyA70rNUVUAf/eMDtln3CoBxt9WVDurIqQIX5nsjVRzvr4Etqhz+0gzbBH1kBKQLDZG5b3p7FDHs8PtkO0k1+LbVS+f/r6Hi9n5yImTwQkEMT8nbZTB2BOSz7Nt3QykkIvEMcWqZlpfWbwjVrUnOmFKIEFcX+ZinhXo4ox++q729dqR4maP8LYTpXMKQJymg2nLC3stlIWC1r2LlMG5+YuVbpZJngcXFZlYutt0hIP5/HsrUA7cemsJ611BP9j7e4fJaLfHHXgxMgX/xwhOjWHaKopbg38ICyWxXMaGP9++V8yfMu1LBSu4flV/yCAfWGycgLEoTXfGbXHTr3FbrSqLtX78U2X+2wr7WbAkhnY2/JnbqcE+j50uTOtlBTLlqjSMtuAlZOMyuQMRvXnEGIHj0IaCmECNUFBCZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(478600001)(6916009)(83380400001)(66946007)(5660300002)(6506007)(956004)(107886003)(2616005)(44832011)(6486002)(4326008)(2906002)(66556008)(16526019)(38100700001)(66476007)(8936002)(86362001)(36756003)(966005)(316002)(52116002)(26005)(186003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gjDFTlNiJDT1ukypK6h/XH+mVYVbi85k2LHnpVXq3kojmOPuQPEX39l9yARx?=
 =?us-ascii?Q?z3nn4bznVt3zg4iWpO3f7NTmD5DUUOzAovzxqBWqRZmkIjUBKDc+U3BOrIIG?=
 =?us-ascii?Q?EOiF2sOOFzzIQJrmwnZUS3e1J91W4f8SuVk0WfDyC5xBzxSK07isPWZ7I07I?=
 =?us-ascii?Q?+XoOpXyvce/wi+FyWm4IY1o13adCoEVz+PpdzB3HHOiuy/ubN+B4koFhO20A?=
 =?us-ascii?Q?qqTluV/WkWbvgTIt6qhxr6pCr//M9jumypq8vRWrrNFK1h6Z8iia6I5KW2aS?=
 =?us-ascii?Q?gb/IKqkkpfBVrcxRDduw2K95KWMybb4h3R7Gj67I2/8JtTWT64WTbkkoWSBQ?=
 =?us-ascii?Q?IH0643AOepHWjf8UyN0VJbw/IOjHbeLpg11muApRl8p+smXdLuIhBAFW+Jt5?=
 =?us-ascii?Q?3LMt3sSEF9FSzpDi/ER9CE5PdBFws/bdqq6MFQdh1IlrMUlhWv59LkgxxB4S?=
 =?us-ascii?Q?NN9ebgIq1bP0rKIfAq7bn+RzoAOYeAEez6fLnMvo4HHp6J4G3Jr92WLxE4f+?=
 =?us-ascii?Q?mGoSorvsphrNtZV7CV2CNOh4yTs4Mz6eJaa2CITHjjeWsUPqZPtrB2fSD098?=
 =?us-ascii?Q?nKIUbs1aozivHLG4wioE7ffqZ1wkXtEwPv6sx+Gzo22YEryeza/KUXcnJ1qF?=
 =?us-ascii?Q?eqizYsIu/JM+vl5Nl97CG0eoZpanklp+k3mia9+TgBKiNwzolWCGPWUduAEI?=
 =?us-ascii?Q?M2GjPJumvVZ067NlRoNmknDfK/3rb9EQFa0lGksq6OTsuuRG/KY3VtEVZgL+?=
 =?us-ascii?Q?UdsHJiYtx0IbAcRE+kbKGK2oxHuSSGKxu5FtDqNq2Rj2mZ818X2C/spUpR2X?=
 =?us-ascii?Q?VbZYd5JrrXbmPf/1BHY4+pLRT92rGh/3UvplEzB/QQ1p7v94DNjrlkKkyfF7?=
 =?us-ascii?Q?oSfb1qkMJTChjEhn/M5BIaKX2iP065w+Z35FfUVWo/LWPu4JEA55ermsrr+n?=
 =?us-ascii?Q?pXLtUlvHoNMVQEOViso4QoDbcltxHPd4Kc2ix99g3Jc+sYxn4AEoy1Jc/VQz?=
 =?us-ascii?Q?Y93yMGIr8jvnzVBK9LBul1jUKZc8L72tZSus29GT5pNiGJ4maIIhV2Nk27AX?=
 =?us-ascii?Q?ZLhfBcNEk58Le+GAL566gyybiPDm6bkEu1k5gw4XMgYFbpGMYSrLpYDZTSZP?=
 =?us-ascii?Q?3yqdKEDrrE8pxpd9EKh5NhHAKbSp2+T0aHy/AFczm+mWbWpOFhoKmFqDoV6Y?=
 =?us-ascii?Q?xOmYQNOdCzbxd8UetKtTfsXlQloMYA/FglaRVKcBgT7R4Ksm0z2+phwD6XYj?=
 =?us-ascii?Q?0tt7JVTXHWRZcNB4ac98L75Bz+MGD6MnL5jET+py8JMvF9YN3iZs1TVTzMcy?=
 =?us-ascii?Q?dyYYcnfgG3RR3HOgL3fRmyh5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf0e69e-fd09-4a53-21ec-08d8ee0a9a01
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 14:47:37.6272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4TNm0onvInz0sMcWCKvzttjzE/A5qCxczCzIfgmsJpbEhKfWqYFQGJamjJy5CKyVsmGG5B5xQscELV1BgVRizImaae7Rl78gOlUqMDi7c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2304
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230109
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

