Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D025319C55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhBLKGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:06:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50898 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhBLKFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:05:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C9o1DY040310;
        Fri, 12 Feb 2021 10:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=mVAjWdQMnJRK8cbzJivayWbNXRaMe1ChWkarbXTdObY=;
 b=RZtU7I+XfZ8mxFZELC5GjhWk1578w7dWq5DzppKdLwEM5sVaDX41ReCxvvescdP61QpM
 JqZ7vD4LGLzX05G66rChLCbcqOSVc6Bo+F6NwRhevWrQ1ZBe4Cq8pnOSXMmSY2jvsf6O
 uPNdrNbBMnfjRjZtWp8UMe4Qtkm+sWUZn4+lPniQNAeH4wliCAxqn5H6VUBP/LHFz72g
 jtnEpO3YsRO51zHwNYnZVrN6oNTOrOibkKaiNPBH5lw94Q1L/Mjn4dJO/UDQQzzrM2dj
 OqUzv2j8ze7rMWhjuG5HYql1e7DVXY4vhAvQhmFfT9SX5C/34KeJvPkgwLLwMLQ5pF2N 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrnakvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 10:04:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C9pbSt163731;
        Fri, 12 Feb 2021 10:04:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 36j515a2qq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 10:04:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP924h3NSqrC0Cdh26mzDmq7EbHXTqHLmWFAINa2miiPYAeBg8JsJgM6SQMQ02trKM9o9KdswUDb9iJahVyB5Wcsw07GxYHXtGhMozq9PbRNwLApRilaHFq0tPrEWaBIYT9sskIXuVAj89qA36do2sc+S8NoaUq2DmzRFAb2Uq13s+RqUNgLEAEZZIVoSEJzsiRNJui0hJrdzCZTHGTn6giFOv8WXK9Z0f4R3VZChGt6tWVLISHK1fsWAec8UjS4L2b5M0y2onC8djyOcz3MbXZAmu4ZIGktfYzYGMOV6Qi0xPoO1xAvDIuHp3gaKq0P8rkzzjD+o49jL6OHmjBcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVAjWdQMnJRK8cbzJivayWbNXRaMe1ChWkarbXTdObY=;
 b=gHYY/yKDWrQOLgvi3RizJKW9AnLGjjwicMPAleJvX/cj9o/UNFjjzE6jaGFfGQgMjT4Uuj6iglLM3iDTnhjGMG8GtwYpHLauC6uZwWVZOJCpCQ0cNmUmYELWPYf5BENj8wXjOviOXz8kJSpVXcC0u3ieZYwWEm86r4v1kaFwsp79p2dzr+LaDb3kgW3k2pUdmTs5Hp0aJx3SCecg5LmOesKa5+Jr1AoGGdsw3gUHUDSqPC5CCtlBzw7iMSa0ycHC4d/E7XJ9mTJlOIP73QDTPsg/MOq+9TsqLtiI9NpvA/f8NSE45sOC8pM4pOLYvd3EDBEFIQtJWfT2X46P3vCgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVAjWdQMnJRK8cbzJivayWbNXRaMe1ChWkarbXTdObY=;
 b=EueATqIUtPJBV4cdbESNOale6xkzczHV6jRl82WPPeuZrD+jCmSDhs3/ME4GSKQVCK8NugYpJt2vGHGLpb6Ige5bQ4gkPGsjeZRmcfZwWfb07VJsQ4e71uKyXidSJvxuz0KAEp1B9gPP4YB2elT5mUrXYgp3wH5fY0e8SKW/OMI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4611.namprd10.prod.outlook.com
 (2603:10b6:303:92::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 10:04:49 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Fri, 12 Feb 2021
 10:04:48 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v2 3/3] misc/pvpanic: add license
Date:   Fri, 12 Feb 2021 11:17:06 +0200
Message-Id: <1613121426-15585-4-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.200.25) by BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Fri, 12 Feb 2021 10:04:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05b9da80-7e58-44f4-f4d2-08d8cf3da199
X-MS-TrafficTypeDiagnostic: CO1PR10MB4611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46116A749E9AF3738E797960888B9@CO1PR10MB4611.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLwuC0iEwlOcpYBfrpZ39rE+6diI/undfSIr6sDUWQrqLtEcPy8fW+jymBTn/O+gnaTEHIPSXGgbgJ/x0ZVxUVcnD7XZ0+i3Z3QSKtdIncf+ORANZrZjLE6DrIuEQ+XsJeLpEgfRxyf21sQZhMR3lhHIEly4twsa4T/0eH6ouS/UsXFYZb7T7l+V0frSTr7j1ZnFHS7bfYCaJ6Egi9Iz743+ZnPQSvTucZ3GRkvte6lpfBrnDKYrLDxkr6qD5a+r5M4xINNENdMQIwxBBCawc68ziiGW4JTEb7ERRIbcCUE9WiS+IaTiC8igdBXNdJmZ1Y3cs9VSfpWA2HtTiFlnt8PQ9yVDqolonA/nhHHJ6DCtgbDfTk9oF+m9TLsw1uZef0XmGtu3qqxngNvSTz/XA/zQQR2gvJsuhoocHm7V3Ejz321We6r9RBiYm+n49VONjUCHvmD0qQerIUi649LVN52lXY3F4c5SLp0MlJ9LKTj2eg9reGXHeo5s7yxloHju89XWyEPdN3afl0YyFawBUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(136003)(366004)(86362001)(66556008)(66946007)(36756003)(66476007)(52116002)(478600001)(956004)(2906002)(2616005)(186003)(107886003)(26005)(16526019)(44832011)(6512007)(316002)(8676002)(6506007)(6916009)(4326008)(8936002)(6666004)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u2gDwEzRDyAzIYhQPKqSUo1jWeJTjUbyropoZLDcGB0WoK3mAwURl6gQwEZI?=
 =?us-ascii?Q?72p15FGCUDxeUwOvGTpxjMCHcOEQf//IUs1pcFU43qjcuFVipMVDm96kK9/W?=
 =?us-ascii?Q?lRIXDbWtVIFj7EIk471bsoQE9kBf+WuAQt5WuMRsDj38H99dLgH0o+NO0ha+?=
 =?us-ascii?Q?6KCbgZT1vLvNeMRKjYXlzOvk7kVzYQM+hmfiOmMCiStHeSdEpmN1rPsBUXqA?=
 =?us-ascii?Q?QzcOsWuTWKUjEjbVKDIoc3Cfvp3ZyBbZcqv5CQ5qpU1jjuqU+bR06uQAK2iv?=
 =?us-ascii?Q?dy4GT484fcApCrRXl5syBaXsM2hoZcqd5OWcCoGpcI7/rxUUuAfRUxirSjEC?=
 =?us-ascii?Q?h3sKZYFCnObXlhGqIa+ZEuorIDOGn+PRRwMC1Yzk6r53H0z5DdJXFCDEDVpI?=
 =?us-ascii?Q?yAcHBkpy0QIOUDXGFQb6GEW2C5fgyq0t1AbAWXfgca4d54BPVeNmWZt9Kjz7?=
 =?us-ascii?Q?hwh8g6O6DxFG67BrShK5uPF5OgY9bgXGBN3vCmkQFLXKonPCHVB5oL505vxl?=
 =?us-ascii?Q?0+Q+XKDwZTOQQ+0klGWw/DhWaCFj9Dgd7Oc5UMhaKA/0AXBL4H4eB+Dq1fyy?=
 =?us-ascii?Q?yFLPHf8Q9f5zGbgWXqLhELw18Z5lCdchZwBwbR1AfWfNUs5bkhFaBnQS7XrA?=
 =?us-ascii?Q?0BRds8OdXKCxw1zUXYe+SvKyBwP4VQkqpSPKVQaFhO7eDsyYwwGxzpUrRrgN?=
 =?us-ascii?Q?FqRBzKy0uZq2Lo56ypV9mb2QKuGEO3uPqjwPQbB5jNXWXpLmZZb54n+X91Di?=
 =?us-ascii?Q?YTh1aAlDygvhdLXfvnXwC0i23vCAYj1IgtDy9IG+ejTF4Did8uNvACRTBmml?=
 =?us-ascii?Q?iQozQs7T1KwBoPgSFizyfpTc4Owypc/mzJey/crAAB8Z79OsMFtAQOP/XgX8?=
 =?us-ascii?Q?0JfDQnwebAjF/KASCAKQ6qnnVQM9DcQx5XviKPkDDUU0QQHz+4odQn5FUJP7?=
 =?us-ascii?Q?VvDYwufidFbx48QRXYQgoweafBA06l1FE/lC2PmcSjLdALJt6Wwm2Ab2krZo?=
 =?us-ascii?Q?Olv984BrQ0Tcr+eeuyiimHNsOVqrMCZnL83Frv3nXfrdRc5ogBo6Wjd5qRdT?=
 =?us-ascii?Q?x5atPh+hIqCgYoJGT+X4ev8MPHQBYnuOfdB2t+17GcDhT1ceaP7DB5WUlTNJ?=
 =?us-ascii?Q?AC1tPPOFNLucYe9X0/NVC+CxMnoFjLiZtnzGAkj2MVaHt0EpnHBd7WhmOCL0?=
 =?us-ascii?Q?7kVK76gpoL1MtfIcS69PrtgZzhZi9Z7zKzdLk4jdi8JavON5MamqdrbqvpXx?=
 =?us-ascii?Q?xZuGo5kNf0gfy/qH2JtJ+jCRRozRMnUkG9rAD2RJidItGdBv/ElwUzOmjhLo?=
 =?us-ascii?Q?fi5O2iqIf12vXwjz9ZS5QW0U?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b9da80-7e58-44f4-f4d2-08d8cf3da199
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 10:04:48.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5MhhxPr9FtciNLCr32gEycBrKpD3mp/To41dQh368q1CSnOaQsjKNt4WPMZj+Zv3BCZAg6mrs6+MTKuZq7GW4pu54Fgb43dWVJFYCq62ZQ=
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

Add license to the newly created files in adding support for pvpanic PCI device
driver.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/Kconfig   | 7 +++++++
 drivers/misc/pvpanic/Makefile  | 7 +++++++
 drivers/misc/pvpanic/pci.c     | 7 +++++++
 drivers/misc/pvpanic/pvpanic.h | 7 +++++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index ce8b93e..004c2b7 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -1,3 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Pvpanic Kconfig
+#
+# Copyright (C) 2021 Oracle.
+#
+
 config PVPANIC
 	bool "pvpanic device support"
 	help
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index 1763450..898a731 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -1,3 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Pvpanic Makefile
+#
+# Copyright (C) 2021 Oracle.
+#
+
 obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
 pvpanic-mmio-objs := pvpanic-common.o mmio.o
 obj-$(CONFIG_PVPANIC_PCI)	+= pvpanic-pci.o
diff --git a/drivers/misc/pvpanic/pci.c b/drivers/misc/pvpanic/pci.c
index b672727..d1c1ed9 100644
--- a/drivers/misc/pvpanic/pci.c
+++ b/drivers/misc/pvpanic/pci.c
@@ -1,3 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic PCI Device Support
+ *
+ *  Copyright (C) 2021 Oracle.
+*/
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
index 4d6c221..7e75dce 100644
--- a/drivers/misc/pvpanic/pvpanic.h
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -1,3 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic Device Support
+ *
+ *  Copyright (C) 2021 Oracle.
+*/
+
 #ifndef PVPANIC_H_
 #define PVPANIC_H_
 
-- 
1.8.3.1

