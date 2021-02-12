Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC77319C54
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhBLKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:06:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50908 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhBLKFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:05:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C9npgn040276;
        Fri, 12 Feb 2021 10:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=uVsyx2qLp6fM12FUBQ27ZsKeAy7V9Je/tKMRxWxooh4=;
 b=CiIIOVpUeknaZtXB/qQbthq4PCmZXq8dLoVwMwHwrbBB1OmFr30yqNenroM7+DfsZ/Ot
 YULCQ8K5z49pHiZojlXO9Sq1HGtPuZPcKx7MMbf+ixuMM2/hJIdQ8bXOPE+3nqFqWnDj
 i4oaz3oNl+JEEibA3r+gP5zbQMEeblHn4oAaUQZ/C3dEk1awfuYM+24tPk1HXaPlS5MY
 q0zVl3sjzfuWzAjairc4cVWlqbaRRaq39yxGCjdSJUU6ec/vxAwAM574vuYcYctt0b2w
 pbqz8NkKM9L0npwsjdxIWTHM8lTi9Ra0bUJWh78Vg43MIcBBfbOR0S5Z0s4W8Op1c6aU ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrnakvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 10:04:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C9pbSs163731;
        Fri, 12 Feb 2021 10:04:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 36j515a2qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 10:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxo6LLZG1u0Evg8+HBBmCC9xRQj357MrC16hn/2AvD3HMSQ+wWJTfaiCQVC0JzkfEFIbBbjj3+XQDOWQNCGXFhFLuQKI3m1Oqq39FkMbqAQdk3mnboZcR2728qC548gqCzLggDjqwuNBOcEAQKBY4TrBq+BeH8saPnx57pPZSSEhTFzpw8rEYz8NKWAVZA2XyujV4l7NdYh4nI03Bp6SoYyeiuzGAyu0dimm11Wb880vEgabYu55IouVDzWV9RTg4eR3XJAWrKBI6CQVlRT2JRY8REvdNFDa2u7sP745s7W5ahricWDH3UPP/yaZt4WOWTynUA8Ss3EOiCe7g6NG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVsyx2qLp6fM12FUBQ27ZsKeAy7V9Je/tKMRxWxooh4=;
 b=dBOcemcBWXZV6OeIKHPCFq0n+tWx4tTii/vhVjGqDOrhEU5ptt88GkGlsO0y6E5bwNDYmS5KGq/x2YGqibx4puGrAM20GdAsPaHoG78fYtQWgSf7Y6IdYHzV0pandeG8VeSPZn/aMx2RvQq9ZrBiF9t202sBASSuZlQJQiWpOr6UEHE4Wptm/BjnzFtXlmLRLmX8xS46DSZtHmxeAhmk8H0MECinykDcrUO9/qWM+6pfvDNAjxVykXGmB6lwVHLSTxJaf6+/sAi1p2IQovwin/B2Q7O8oTQ7KJjeHkWDxbPVFbYWoptj4Zb+jrn+Vt/o/PxHdqN3KCL+hfQQaEVx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVsyx2qLp6fM12FUBQ27ZsKeAy7V9Je/tKMRxWxooh4=;
 b=fgUbMCcQJX2p2XF/HzqKqSnBLPYwjPGIeFJPo/mjRkYmFqNL2nvkwZUialJYywY5DVXZtU3ZAHOigw7vNVV+QKu9XUG+Ob/0Vy8SVlqGGjJTzbPkwl4TNRyt4LoeG/VucWByaNRdrxONqFkG7HW2ubXArm/j9Ko5UFg3Z6VEvzo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4611.namprd10.prod.outlook.com
 (2603:10b6:303:92::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 10:04:47 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Fri, 12 Feb 2021
 10:04:47 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v2 2/3] misc/pvpanic: add PCI driver
Date:   Fri, 12 Feb 2021 11:17:05 +0200
Message-Id: <1613121426-15585-3-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.200.25) by BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Fri, 12 Feb 2021 10:04:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bdedf8d-4e78-4254-75db-08d8cf3da0bb
X-MS-TrafficTypeDiagnostic: CO1PR10MB4611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB461116DED5A095AF71E984D5888B9@CO1PR10MB4611.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23aFvLEgWJV+OmcvVlYfFblo7Mf9/rIlzoTQHU1nEjBnVi1Sy9phtclg8jgoJY3LD2/cDFV/HFz96Lvsu0QLYCAIVbDy9sRJaU7Q7hmE8MrHtivtn1ZkLfmCSHBrvnsAViEYC2L7AcXKXBV/SnfYlql8l7Bcb+EoTAA4PbrvNb3OSoLo8WLgHuKEoZZSNxKOR0iw11D0XyjKsnxaCCdfMWN9yvXSClRovvIuEfvelRl8OL4oiYrho3qeNdpud5n58z3sIuO5coyWGsXM+2khns4kCw+ZTTqRy1hOx1C3NDJjHvoB1EkNUxwXpvah/XNd11+9iF5zNwVAXyJD4CmMhYfE76K5E2tcmf9P2Puo65491EYxwUlYzplpiaAj3W+JFtc8rOz7rUHOsoVEkIx38COY4xRTwANqIzWxtpvWnFhZQrc+SvtVKwopO8GamCN3gZzqcgrJAhCpX9skKyZ7fKq2tqkDvWm+gGaiVWjYFKv3WNoZEvInsCpbckaWc0aM6BVsUtJNFdaSSkp8oLTjnAf/m9bZkEvY1SC9uXrRfswuNKbs2+TEZ9ynW4V+aGUNytFIqpbYUz7tt5LuxHUG8scrSl9Iv+sA3XT8symTQOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(136003)(366004)(86362001)(66556008)(66946007)(36756003)(66476007)(52116002)(478600001)(956004)(2906002)(966005)(2616005)(186003)(107886003)(26005)(16526019)(44832011)(6512007)(316002)(8676002)(6506007)(6916009)(4326008)(8936002)(6666004)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B/0fXqvcvvY798byP4/VMe4dyYTr2htgs+gLt2cSgUn27+3z2MQTRQFG4xNY?=
 =?us-ascii?Q?vkyFz6LFAw7n56TRJx2GfXEDh+NvGMZwXU+25ZyEwZ3ZnFVJQHF1pI1pAwXQ?=
 =?us-ascii?Q?qvvPz0ZOgnmV0UDObdkIQE4LUa7vk3U9gTPxEZz+0wUQF0aQcvu2iPp3H6N6?=
 =?us-ascii?Q?EtcuW+3GQ3UTzbiM69P0PX8xI9R2WFU3Ylozy/hrhDD9hgg09G+KvJiB7lQB?=
 =?us-ascii?Q?JBWrjbe+u91jWQe94nooD5lJlotDqvjR/2nJ7bkU477yIrhNRepIqXb9sgk+?=
 =?us-ascii?Q?XYWlfW+i/U7R6gZe6G+GhaE/hM521dKXmMcAOHix9YG02tpUw1Gh6/f8qi2l?=
 =?us-ascii?Q?Q4PUalCG9uZfHPlkWzkuUL4vhhvo3R9u34JwSIyNXbWmKoXs8MK1f1derCMv?=
 =?us-ascii?Q?PNGsyrseVM62vLpVhwZMZA8e0hn+EUw5rr5OYbzvurI1X2YfloQYT8KXpNu/?=
 =?us-ascii?Q?tTG3+N23TPoeM87J/xfR96axcx3Otdn5jx27pnar2+pHFv9HHpX3+U3oXKk6?=
 =?us-ascii?Q?Ac8/Li1vCIZn/e70wviDiijQx4VTg0eFO8xHGpC6UOK6ts/kWaIQFj/W5co3?=
 =?us-ascii?Q?fK4hjD9gTtPEt+y8nk5EuMd7Xd5K6ZTixCIh9r8J/ftmbxTjo/aq4JQAN3jn?=
 =?us-ascii?Q?M3K0ITQlHTOd87Rc0J5hTGqo0gRtmqysweIRsgxj6fbDFOSjkAibM+3T7/uQ?=
 =?us-ascii?Q?0CE3d+nuT+BUZGi0oPwYANfavPf3VaeD1iumI7S7CvyB4n4JcgUYvIE5vGzc?=
 =?us-ascii?Q?zbK25bReLwlgnVrfOB74KUiLzLAleHAo2sIM8AlefL3JR+XupMDxWt5QvVTx?=
 =?us-ascii?Q?J05rDH0zqxHFxCteRx9bAwxdhvL38xY+VuzFyP3oCipGJrIs4Yaa/K3sqy+2?=
 =?us-ascii?Q?eE0WqiBNqgMfOaH8AujC9WGDK7xVTSy315JgwFI1RhF4scOtJO2zmSvfBwlT?=
 =?us-ascii?Q?jIvvZA83SSglwxcdMrwYvQoDuTqSpi59M9SAqUvu04IOrMl2I4Xp19l59Ecv?=
 =?us-ascii?Q?bYEnPFMppRnmqdNDl0mRm4tyG8Ld9Xzftk7uis/T174dtSRp6lnH3gt0bZAO?=
 =?us-ascii?Q?iVrw9IGQuLiiPhJQwPCT55Xr5kUCfy9X9RZGnD7LlB8eXtGOkZDFyx2kZg8+?=
 =?us-ascii?Q?f6484lfqu11L6HDRcOIU80nDpA+6WkOV5D5JLVPAz3m/Q5Wn0xBqHtP3Y7iH?=
 =?us-ascii?Q?dKfgt0P8q/m34uceCfmZRXApN2RzKdgSE+K2LR8w2bZ+dp09pRO9cHacM574?=
 =?us-ascii?Q?KSUJmzPlUXaYjAcZCowr8i3YQFYiZUnHTV8bUR5JhX1qjtVOKFMAvL3ZbYAw?=
 =?us-ascii?Q?nwqZQTUs/zsyllxKhL5iwANE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdedf8d-4e78-4254-75db-08d8cf3da0bb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 10:04:47.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiU2A+zlIVcB0tRZsg5f9qir4uoPWO9WrIMT0qyolkDx31wFH1vCES3zYpevBW6kJ9pHK10Z+QxYSE9aAWE8BD1nY5mf4z8iheejULexYvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4611
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120075
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120075
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
 drivers/misc/pvpanic/Kconfig  |  8 +++++++
 drivers/misc/pvpanic/Makefile |  2 ++
 drivers/misc/pvpanic/pci.c    | 49 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 drivers/misc/pvpanic/pci.c

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index 0dce6ef..ce8b93e 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -10,3 +10,11 @@ config PVPANIC_MMIO
 	  This driver provides support for the pvpanic device.  pvpanic is
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
+
+config PVPANIC_PCI
+	tristate "pvpanic PCI device support"
+	depends on PCI && PVPANIC
+	help
+	  This driver provides support for the pvpanic device.  pvpanic is
+	  a paravirtualized device provided by QEMU; it lets a virtual machine
+	  (guest) communicate panic events to the host.
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index 9ea3355..1763450 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -1,2 +1,4 @@
 obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
 pvpanic-mmio-objs := pvpanic-common.o mmio.o
+obj-$(CONFIG_PVPANIC_PCI)	+= pvpanic-pci.o
+pvpanic-pci-objs := pvpanic-common.o pci.o
diff --git a/drivers/misc/pvpanic/pci.c b/drivers/misc/pvpanic/pci.c
new file mode 100644
index 00000000..b672727
--- /dev/null
+++ b/drivers/misc/pvpanic/pci.c
@@ -0,0 +1,49 @@
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
+	pvpanic_probe(base);
+
+	return 0;
+}
+
+static void pvpanic_pci_remove(struct pci_dev *pdev)
+{
+	pvpanic_remove();
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

