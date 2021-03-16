Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E8C33D498
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhCPNJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:09:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35346 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhCPNIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:08:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GD3adZ015908;
        Tue, 16 Mar 2021 13:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=jb1AX5/+xBIKOP4d+uiM45R8E2m7ecPrJ9K2Tca9qJI=;
 b=aL+Uzijg7TabiHDz6EHMbljxiB68+xMsCSeGHARcepS2FP13YCsof39jkK3AyzcHzRgv
 GxsMR5Gp06l/x4EcFpJyv6FMGTWZfxHXzw4dyiTVkfAbpKN2jYq61urMp78A8pxrmZAM
 +pJ+g8tPQXl6ypDcQ2uqmNNgSw+nTkDaxPkvDNgKfgwtvKmOLuhcLOgLaIGK/Wur+vA5
 Q7w7xaLYf61HRichSs1Y+7Zt3Oac0oeFCwLrkddTiHPRgsoUBT7aLxZ8ts+PsAMl60Q0
 nN1ZuQAeB3bq168+Rmbgy9u5tHscdwlztdeQpQSKmqAuejT2LKbTCVtfyvjvzvly69zG 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 378p1nr33n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:08:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GD5pfs091066;
        Tue, 16 Mar 2021 13:08:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3797b02470-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAXiqIHemxh1s6CWRDD68npoAZ8N/5ILsCXdWOS1hbmgw/4wko15yTDQK9cZYN6JujNjE/+pqJSgBxvGOL6lNZCYdATJAE/IMnYuNdQhenlKi+NaUj2Qe4+2sdHpieHD7HyYhDH/Eglu92rl95hHHUFE/SDRASO5tFGhrCUIGIdd8kgFPViAVCeZlLEDmTYFzHPUHgrl46vsEB6CsW7y9947z+CZTL2Hujucq95Nc0nLS/yV1TwJBp1BSKSQreU++OAj8QLUu+StLqETr159bUU1lcLtfc0BXgsG+FMBucMorZ3i1RQT1b03TsIIIlQHla9d2JsY5eMDy3wqfkfDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb1AX5/+xBIKOP4d+uiM45R8E2m7ecPrJ9K2Tca9qJI=;
 b=n6FsBFrxjCVrQNbaT7mdLN2K+PYTl9XfU7TCmHNhZqaWKuUDXxpxekQKaIBExwsBCwoKlpgR8x/MbMJoDlIe6SxxICWycrMjeAlrjIIPxgT5Bbpx5rGyro6ZEMa4U/xWeiTIK/fd/GGcNHrHJxYkQWEU89VWu+86BjGAeG3Wb8f2uHkafvfiDlA2QDP2qwxI0j8ckm0RX9Iqk2arjji5fje1TORekqjzACQY/UUUHoPfT4NXAOmoxqfeqznVUdQY7bT/e3XBN5VK9Bb8xgMdR3KSciiARioBCaNkvj7vsSYHbbUsVLBWhqcp2nKaZB7lHEMrMFr8tKSUJlbdnArdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb1AX5/+xBIKOP4d+uiM45R8E2m7ecPrJ9K2Tca9qJI=;
 b=j7YJ5gTcdlMNYKcWezCyrV8D3du0BslbPi5ATPBwvtOX32gSIfB0CGa6ehjCo1qW8wcSEf3tfP+LGQ1mfktaXUsbUw8eqtAaZRoO+W+et5E7Fzw+AJW5G/vwI3t0mvizdn0ujE8aHaN6g1Z8S8GPW/wK3gmts46HDjuW8kkMdBk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4435.namprd10.prod.outlook.com
 (2603:10b6:303:6c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 16 Mar
 2021 13:08:28 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 13:08:28 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v5 3/3] misc/pvpanic: add PCI driver
Date:   Tue, 16 Mar 2021 14:20:29 +0200
Message-Id: <1615897229-4055-4-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615897229-4055-1-git-send-email-mihai.carabas@oracle.com>
References: <1615897229-4055-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: BYAPR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:a03:80::22) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by BYAPR11CA0045.namprd11.prod.outlook.com (2603:10b6:a03:80::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 16 Mar 2021 13:08:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe0a7d08-9551-4629-4711-08d8e87c9749
X-MS-TrafficTypeDiagnostic: CO1PR10MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44354A2F6EA0A8D3D9EF46BA886B9@CO1PR10MB4435.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evy7ascxd/W88GaplyAXe5DR3R9cf1MRkj7p9BnjiNS8+TCRUoIuFRKOabhUOO96pupkOAXx9T4exbF/NB2HOuuQSwxawt4wM7LzhG2zQDyGl5m1s+we1iB16VCCjj+wSk6yOtNpRbJxXhz4QyJXXsUz4EUcM0TQb3o9Hs0cSzBYFEJD8cf5CWsOcvpI1olUwe+ZHqyz1vWTP8M++X8+h0JL0bhySElXrjUyTmqaKrcO/tJYtYiuypel/dlsGx1NvCavIU8570uD+apbXCK6BFoa2VOJM41RHYJ0ZO4iN+A2aLgtmmwhmXWJodmAGBo5bfC8tP/tUuBuLM8MCDec3biX11cpH/JyVBs7A7bh5yRyeYCLqmH6+DJq8pscNi12j/3fGrciOG/afA/vzsgtoMaq2CKQxJA6+6DOEmm1BBMmSuHErbzuOp2AF2dIS0Ygrzuje6SQdUbtmilFrcXATMnl910Qa3ROSNWtocbj6VPqbFZo5FZzBZV2l1Jorb7hFXbMriWzjhoII35z5jOjc5ZjaO7VBbHXyAgm7EViKl7DR4aEp/sKiFREso8gZwJQGyQ8x6Kog80FeWPXYIL4EhmPAHAW5Jqu+ZmiSgajSRVusdCtQewsHmpZqc8yBsxN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(36756003)(2616005)(956004)(44832011)(8936002)(6916009)(107886003)(52116002)(6486002)(186003)(16526019)(966005)(6506007)(66556008)(66946007)(66476007)(478600001)(86362001)(4326008)(8676002)(26005)(5660300002)(316002)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Tnxhlt6jCD7iEydbqO+1lMEd+80rgCBzU0c/eSBLXXQUn6WF2Ir5HGWj7xg/?=
 =?us-ascii?Q?WiLyHSzg+upRdIzTPcIisaoBvQg3NgUlDJcmOtaWCXq87r9vCXR6iydxnVw6?=
 =?us-ascii?Q?BREwpmRGs4ndVd6vhbEo2zytKaO4og+TNnl8Vv2g938STXQOkKZ9aYmrVaiy?=
 =?us-ascii?Q?lOFHNdMMBrRHyHuD4Erto/gAeqrX3P5OP7jmWIToXJTJfA+tjZc9qfjixihD?=
 =?us-ascii?Q?uIDVHJ7B8p+MtOL1Lo5w18CTwblMSfu2Sf4v0CMi12CBZElIPfGLpIl6xikX?=
 =?us-ascii?Q?CK16YqEo6fyA+E2Jw9+sGRFhCRFNGZiX5XdiyaibjG/ZfOzXyLH0s87rTkWz?=
 =?us-ascii?Q?li5aKI5XDOvCUFu8PPtBFMEscPtohqu+GczzwxOGXZB9NwUVaTKw+cWViGJ8?=
 =?us-ascii?Q?Lyu+vHSCzrM1HpCaqeigNKufoj4PyYN+s4y/sryeiaSh9laeeec0ixC28afH?=
 =?us-ascii?Q?aGJfCHn04RZUcT80bF4Wf+rtvFrfKT65ZYXilx+ERv32AGKJ1j+D6x4FEu/A?=
 =?us-ascii?Q?q3oa7z2NPVg0eQGE2jo2ir26roVqkPxHWqWUhjAN3wP2ikN89i9hG2kAG7q/?=
 =?us-ascii?Q?/krOFViDWF8pc1ubiBPpH92L6UIrPkvCHRwNtWWBEo5NYQm6vSgj7ZEltDny?=
 =?us-ascii?Q?aott3we8ohLAQrvmuV47MIb3oTe9vr3JwGSn5dkeCOTG3akD6zGy4enRYHOy?=
 =?us-ascii?Q?0YY5VcnUmNrf3xIbpqJ3CR9aIHCG56J5GdnpiAMt6BW20pkQvIYKAUA01Dcy?=
 =?us-ascii?Q?65nm5Zq8WxUnS7stWxi0fLzAZuWuym5wzP1Tn5GfZoo31VBKiO3ezGjFRZ82?=
 =?us-ascii?Q?qMUGKYeb7oHxxsCyPDAb/s1uiX3F7o+M6y63DnVkN1zZc0TjqySO1IaZJCPA?=
 =?us-ascii?Q?CftdFw4/k+MwQaletiEPU7FrFYx1ujGdOk1MmGW7SV2Ty60eERHutb66/QU5?=
 =?us-ascii?Q?JFzM7coMpNECPUskVXkxr1AZp7sSRzIg4WFvioL6mC/8Ym+P1gARymI2fxd2?=
 =?us-ascii?Q?egnFAMGH3e4m0HHV+droJDrOgmaYX99urffmHyI3gg+VjveOrn2VC/wUL/Z4?=
 =?us-ascii?Q?JYGsdaYviDqgYqvCexjwgi/CoOWiUlMJ2ViFgE0q+IE8LLkLw4vyL89ttzpz?=
 =?us-ascii?Q?CL+GZtrOjuSv6N88XWOsSXzVOqL8GhQE5I9aEwtB9HUzQOp4R8GcriCz4VZb?=
 =?us-ascii?Q?IJ0CHt3WTETfLCL+HdT4Nk0b1okxqfbSC92MG8gZMCbg94pRdcB0M99S6Mzy?=
 =?us-ascii?Q?GbcaWAhRAEwfa3J3fTaqLao5HZ52+hE2OAB0Xgqk23ol3a6dDRA60ZksjDKj?=
 =?us-ascii?Q?Go8hu/GA32REewFgCGKBFbuv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0a7d08-9551-4629-4711-08d8e87c9749
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 13:08:28.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSvU4zP8vT02c5yS6UpoxfSh4OfTJItiMiDxsD2sN268VmOEIgzO6LLty3xIacAe3k93xrjle8JpszLv1s6+kdL4hJqlGY+93HGVHseYjkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160089
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
 drivers/misc/pvpanic/Kconfig       |   6 +++
 drivers/misc/pvpanic/Makefile      |   1 +
 drivers/misc/pvpanic/pvpanic-pci.c | 102 +++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
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
index 00000000..27526d3
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -0,0 +1,102 @@
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
+static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+static unsigned int events;
+
+static ssize_t capability_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%x\n", capability);
+}
+static DEVICE_ATTR_RO(capability);
+
+static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%x\n", events);
+}
+
+static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned int tmp;
+	int err;
+
+	err = kstrtouint(buf, 16, &tmp);
+	if (err)
+		return err;
+
+	if ((tmp & capability) != tmp)
+		return -EINVAL;
+
+	events = tmp;
+
+	pvpanic_set_events(base, events);
+
+	return count;
+
+}
+static DEVICE_ATTR_RW(events);
+
+static struct attribute *pvpanic_pci_dev_attrs[] = {
+	&dev_attr_capability.attr,
+	&dev_attr_events.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(pvpanici_pci_dev);
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
+	/* initlize capability by RDPT */
+	capability &= ioread8(base);
+	events = capability;
+
+	return pvpanic_probe(base, capability);
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
+	.groups =       pvpanic_pci_dev_groups,
+	.probe =        pvpanic_pci_probe,
+	.remove =       pvpanic_pci_remove,
+};
+
+module_pci_driver(pvpanic_pci_driver);
-- 
1.8.3.1

