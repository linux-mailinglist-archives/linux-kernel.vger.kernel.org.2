Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02D6347CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhCXPiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:38:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43286 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbhCXPhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:37:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OFZGaV043592;
        Wed, 24 Mar 2021 15:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=iNpZ+88S9HlszyEXJ0a9ukY1Rmn947c/BeblSOLiFs0=;
 b=nUrPIgzd/RAQ0artw/x6SatSHrEcJla9DO3OPCDMEVrspz9/P6IRcPEwfjL40/n/34PC
 0ovXkt3U1SHM/GTGQFqJA8GpIgskhn5Cvr9eGw2Ns7pRK43rm7j22h8Q8Qm440vM9XLM
 qHumIymQXZc6/1fFxlNlWkh7gSlOD5G5tMS7dEPnW9Dznm1GTIaTTbSqjhphqes+U0/r
 37S45duzq5IK9e4ND1B/W7JlaUhSCETAY4HBRZUDrWpMrUUf2FD0HBe2MTlowvgDbW59
 WZYfp5Vmo3KGk+vw09f5qI50etFoZ08+iBHpSbwHv/+I4l8APsE8Unx98ncrbh66PRS1 Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37d8frb7jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 15:37:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OFZEXX157496;
        Wed, 24 Mar 2021 15:37:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 37dtmqyg13-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 15:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTTXOXzG0cfIEVSm6slNzKsYHJUvv0op0uW2H/WyyTXNdINnBYSEcTOboiZOtA8PvuVhvSJZsClepBwuWnLaJ5pi8gb64ixwjaL7lB5vIK1Tx6sg/95Hdm7WQb5xQ/geUzkHfew+Hc6NYAsBm/MpvxsKY193glJKYCRixJftSdEHtcIeabNQ2cVIHbsI6mBXA243dAEz1NJBF7pfpB/afkaMu7WJe6V2h38pHCpm5ikMu1Le8wNlYg32C9odxNCZYMYl2PWEtGU8kVGL/NaSjtAnob+wYrccWsf0ba2mfZhljWvN0syc8BKLeH+IFCd9P9jo5UMw7snuTxdZ6UZwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNpZ+88S9HlszyEXJ0a9ukY1Rmn947c/BeblSOLiFs0=;
 b=S6nw/R6S83aQdmVkh7MchWnzl/dOXeeSULhQdXNeiQvi8XrJwPrseD3m2rqlomg/bW2XcgiV0ReMnwf7wyz2YvwGk5SrC3qj/oxVgBla5mF5MuwBPlRmUYJ82/ss2ar5V1yMQOW03Ym9fECPZWFYXqxOnTjsadhbYbzwKFeHlmmesxNaoDQJgw/IyAaN0b1Q8QOifZpdc2FtyKMbaqdqwwNqT3YQXY4aJffNBWHdMlYU4JawxBvOoWKVSVYslf890aJkPGFPdOoyR0bCaDc+w/a8YqUPqjrauYsZFOp6YaNw1CYQFwbeUF3Kr5oEmSNGhLrtT2xO4NH6p4SIDr6QMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNpZ+88S9HlszyEXJ0a9ukY1Rmn947c/BeblSOLiFs0=;
 b=bqSBQVBljCNxQitrgKcfrI68IOBsaWzH+PjpSrKVYF0AVnhuEWDSkfWZtqFzVCk3Yy99YZHcN6IlK1kMwTBSUu2NhNQ271ZXvlhw6QZV4XbuTry0x4D1y8jsPN/+E2LdphexQuIXCWYJ6uwBF+v6cO5OehIZ6uzthySDVojkJPg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4579.namprd10.prod.outlook.com
 (2603:10b6:303:96::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 15:37:26 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Wed, 24 Mar 2021
 15:37:26 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v8 3/3] misc/pvpanic: add PCI driver
Date:   Wed, 24 Mar 2021 16:49:16 +0200
Message-Id: <1616597356-20696-4-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1616597356-20696-1-git-send-email-mihai.carabas@oracle.com>
References: <1616597356-20696-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.201.25]
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Wed, 24 Mar 2021 15:37:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff83e8f3-4b0f-4861-29be-08d8eedab9a4
X-MS-TrafficTypeDiagnostic: CO1PR10MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB457952D5A33343D80C4A176388639@CO1PR10MB4579.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVwPuHDwi0cwKe3y3EX6yoPSWa3FzIFkeZabEad3eSAmciLn70XlqaLrn2NrhEMlLOcO1Gr+dcpOY9YEHKqQv9YvB9fv6xhYCpxm8HD+aWeIVkt/lcwrgYd7vRCvi6h2xWSntfYKWuAUHVEHxvgNEIadTxskcnQXh7YAAPn3y6SLfkcmDqa9uerPJFm2EKiD4ryhG14YpjQv3SZe88hxcPgZt3CkJPPb00dYHw3xhDpKEynJy0afHpkd0jhejXR2O2YYE2jDymUZuWIuhHCAU1JWfE12pbCDLIegAwKweRdIg2vPJDiBMs/1vsm+4FFmYJBs5RdrkkKwReyNBVU0nxL19mMqulf5M8MQPubXb4mXCO94tBb8jWF3Nsc4M4o58yp4r0555J3P+pzqyo64ZcwH5fwhK76ILELcRsMMLomMlG453kLOLsP+YzWSiCEozMRW8//Ddm4G45V03s2e6Ubj2nId47nHKIqtbpbRfWm7WzfQ1XwfU6Ght06MoVBF4y5N48wuMhw++EBgRbz3If4zypMdbre1qXv/nEZEij9Xr4AcPx3Gtt1yTo0jnBkqLvrNqyTeTr9fyCKqylk8TviqlOLBFbvtE1ENtfA5pMD2kn19YnR1A0tIa0IzQVqqELX+KoBzpjbxk2i+9aJMVdTyWgU0QFinF5uRB35vJtBQvqGuS4zGfnAfDkG+g6KPg6SpXuuRYbSDXUB0nLt+X/6TLiGDuM/Vy+CAjIYsA88=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(956004)(107886003)(83380400001)(16526019)(2906002)(5660300002)(6486002)(966005)(2616005)(66476007)(8676002)(478600001)(6506007)(52116002)(8936002)(66556008)(36756003)(6666004)(86362001)(6512007)(38100700001)(186003)(26005)(6916009)(44832011)(66946007)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bfUHZM9ahB5BTU5U1vbpa2/tc9JGYoW7BczTVlJct55Ls0eRbxrMGklKSv0v?=
 =?us-ascii?Q?6/cBx0lRryxgRv+0wHQ86+0ajBWVhrqvIFlalpmKSp9Z3wZjNTQ8WtAF3g0Z?=
 =?us-ascii?Q?LAed74v4u6dmVknqMl3ZaMrz8NGW2XGZUHPdYTjuy8fNhH3vKt6eOtHBB2mP?=
 =?us-ascii?Q?Dg782RJZ/myQIxvZhzmI+MEqGWe8yHFAJfZSyz+4WeqSmJeub++h1IWOTygr?=
 =?us-ascii?Q?A5c+dDwp4nRd6Z7aabsB3PwA+AMv6+L6mScsz/AlrjvIdcalUr+ZKyfGeV6A?=
 =?us-ascii?Q?NW56oz1JvhTMTbZNuaMxSXnR2LFGc1No3y67cwmxS2aBzpmA9PPOORVejHBs?=
 =?us-ascii?Q?7J08P/IGNpMMxxFsbJDpwv4CI30O8NLSW/8f1YqFXyrzMu+LLaCcEofE/Yo9?=
 =?us-ascii?Q?8Jn6U/QjQ2CDfng/y4fZ4QOIHFja7zIWqDDx28vMBsbQ0fbQG9AVtUfMsmWu?=
 =?us-ascii?Q?9ee1DxR4xlEZRRrY9SMhFKdj6Mv9e0IcN2Z5B1JqeJ0+XDZJan1LBzcKONZc?=
 =?us-ascii?Q?K+MMssUWkjmijQCVbHgy1YDPggMZ3aR5oqUdsiJv5jBGQg8YmvNjxyp8toiH?=
 =?us-ascii?Q?DZeyDePabcfjE3etNcC9K97pa5gXl4bHJWUurnc834RSEEFqHj3tRxS31PQn?=
 =?us-ascii?Q?N3nYHubTby252TCzA7jKpNf2jmhCxBL2J8Dmdk4lWLTQk7UH90zbThTA6hDR?=
 =?us-ascii?Q?EYcQDKnPv6CrCEJlmkKXB67fYEVD1ydMo5Ptwm8xNjNrVWszD0EahjzaOOpp?=
 =?us-ascii?Q?WnoIBPeTuqH4v9Mltg/CDJnkv1Z2vneJNeqRCcy7jHLiC+PLKs2Py1o480Tr?=
 =?us-ascii?Q?Y0H1kZaDlK5wxx3Rx2+johohvLxy8S8qugwVlsj12eWqpV633pFyKEkNfSin?=
 =?us-ascii?Q?7wf39TJcmNJHYLUyp7Pd/9PD/mVlfbO4zqxoZn0gldGcuu2ctEtZ5e991ynY?=
 =?us-ascii?Q?mb/9SW/NAS3UMgxI0iw6q9f8CV8fyGsKahr6vS/hyex08zMM3ehdc4nfhNiI?=
 =?us-ascii?Q?qb5S23rfy754FPXWfdUeanj0g0bQ6ZTBYldXT6eUkALeKwsQUHb9LmVKN/u0?=
 =?us-ascii?Q?OyLPrnSbUCO0rUyD2AgjGHy4moUnU/aj2ZuhIs3RnC7Tri/BSFjeDRkh/JxC?=
 =?us-ascii?Q?Dfrz/q2bSCREaRfVQrBR62NPd4uo3Lc9ANDfzmEQeRRCJeP/MXO3pR72hPh5?=
 =?us-ascii?Q?3wJqnwwOkNmaSXHnsowfJlLirZm6020OIrzkXYzZqvHhMw+fCyRFWNl+TLyJ?=
 =?us-ascii?Q?KsE/dQDxtAybKzTKunXBTJPm+XX0p1wYuNBHLOwP0rtNZK2nMS6bYrq1oAYc?=
 =?us-ascii?Q?WqmEq7l63Cdc47qVLT5e8c3r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff83e8f3-4b0f-4861-29be-08d8eedab9a4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 15:37:26.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdoWO7zzHcDikpn/D04p4WJAUqJUk2r5KZq7DvbWVxdK/UJ+t6g/iDDrp+2DzaxEEI2BsheUj2ccJuymmgacd0FBKgbBkYvX0TkzEfRxDTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240116
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
 drivers/misc/pvpanic/pvpanic-pci.c                 | 125 +++++++++++++++++++++
 4 files changed, 137 insertions(+), 1 deletion(-)
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
index 00000000..f38a80a
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -0,0 +1,125 @@
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
+MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
+MODULE_DESCRIPTION("pvpanic device driver ");
+MODULE_LICENSE("GPL");
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

