Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6902330DE43
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhBCPfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:35:11 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48262 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhBCPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:32:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FU2tu170314;
        Wed, 3 Feb 2021 15:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=dDSvXFLqGyd8yc7kKwQd94CPeGrb5eN6DibXHxRru2o=;
 b=mMXu4BkNh4ekaqBif0Mu9zYA+x0FQJGT0HwgHGe65PP4lb38GCultmyz1BOM1L2Cppb7
 U+ao0JcR4PtOVwDtDYak7jMkHlhkstl6ztTH7WeR5LntvKrGaY8/YLO4RnOqFTN/kPkR
 mpdCytKkk1B5+nz1r5TedJUftkZEM3fXcnV/JVKORADzIBys5bhipbraEmHR3brrhQLU
 vO1uGdr+X9R8fudZkHm06fQf+EO9pcY6ae16psdTaUCcLjxj7l9LxcPX+lKCkskKCaXB
 HlJ1isemTYmMLCA2mC59ii1HqaDzWKY+UXgl+kxLtRJNuEtp8LxtY/iDK/LXszLMkhY6 sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36cvyb0u6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:31:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FUbsp172064;
        Wed, 3 Feb 2021 15:31:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 36dhcyudue-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANQmjDpF4dfUxtSMLqMbJQjnfyrGLvBceezYsGwOFcltxedAxFy2rX/gF+T8OYnSgW9Tr9IAh+bzAK1zaNKb95EAWML6JfhB8fSiH/Ass1IWWL+wCt/JqnPSk1LH7tmvchZvdLnnL8KnW3wDWdPi/iccgxVZlNJ0xRY6DoqyItFR9DXHf3U8SMJ9CsN6pncZUrSPON1C2Y5n73gbxjen6JFYdrkMP7Qky0LPHmUxUJg5EEOO4YUjY79RKrnzlnUZvuYjw1bvztDqNK9rm0jki7yG3F8B0fpeTujgFf6jx3LsK9LozzFW0iF9tgIJJb5+N8TjNcr3aNBpkB8L9bh/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDSvXFLqGyd8yc7kKwQd94CPeGrb5eN6DibXHxRru2o=;
 b=lcR2N92i+1WlgkY9+B4tYwapJXCLAH4GSohZZ10Ay1qW31CUalRGuKi+Q4W/wcHiaCVOj2gpCwj601AZyKWQyVEp+WcWUhHTghpSovtcAnrmgk5NnJYohKnb9kixxnoXbae8cWIUI0vzLmie9GxlFxxjEvrm9D5NlY9siBBhPRm5I7sk90RAbTanBftUlL3ge+HECT7GtKV2Gjfvxx0Jt+LQbei4RSoznkK6qkCHmF+xfLQc58Z04i2nOlXS+h3MwizXxLSQakXY418ut2nVIZplkoN38oecJgDC0byBv8GnIZFUExAZzFsWC4es3azu7Pw4ePEbdEuk2E8aNEqp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDSvXFLqGyd8yc7kKwQd94CPeGrb5eN6DibXHxRru2o=;
 b=oD/7SX8CxNCR/vRtuDcrxY0iOflSmdUJ6yP9/Cq3OkbOSJyXn+8BWHYb/Mf1pBUDcCpUsiBozoI1pR9JYj4tAumK97fh0INjGQIBj/WyYnTiIcap0DxXYr3RcBoDCPXMiwishK+flbjPlgdt30ZdJC3nhgYUOzBHeWWrj7FXIZE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Wed, 3 Feb
 2021 15:31:29 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Wed, 3 Feb 2021
 15:31:29 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andriy.shevchenko@linux.intel.com, bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH 2/2] misc/pvpanic: add pci driver
Date:   Wed,  3 Feb 2021 16:43:59 +0200
Message-Id: <1612363439-26656-3-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.200.25) by CH2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:610:60::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Wed, 3 Feb 2021 15:31:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 159b3560-06cf-477b-cb1d-08d8c858c6b1
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2351DC11CBDEC1873DE821C188B49@MWHPR1001MB2351.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsywIK1xeXpbVGUVIao8UBCDsu8SSO+ULmDSuFmNGledPoMoiXzV6z4ByC2hVeS/poa4iRDB769MRWXoZxlxN18oDpQFk8i790Ve+FTnVhj+8mICGxU5QLhgfS2VUeYm8+zu5r6W2G9jn6usPeOSIg99jkbEWw32kT9qfgrpaNoGYqiBM9jeh75SFCT9/joGTZZGu5RcIVTrFJyian1jYrp6pH+ZPSacVlmRNHdR7lRQUbSoeS8YbjgQKMFYX5eABMOeTDdTFC+KXAH8dDWdNYaqG6CatHhVytysYVduX42vAwEqKb15gLjCDW7H38L/DtKa2MVE46o50sZn1v5qe0F34E3CfyZcCdc78ZBP3Ch8+AvbUHx4a4IeC3VNE/KuTLSyq1uWaYNcO+VS0EswAm7kkLdyhFM6Byge1qjEZSXwlK0zeBwu537wQPGuYZalm5GLGhL6P482uqVgGpC4XPq7/Edvr6jeiLaLzImpOuLeVpFs767Gl+mbZXR8HHk7IOKGmA31ZFZns7SKMcsDEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39860400002)(396003)(346002)(6512007)(107886003)(36756003)(52116002)(2906002)(26005)(478600001)(86362001)(66476007)(66946007)(66556008)(6666004)(6486002)(4326008)(5660300002)(956004)(44832011)(16526019)(6506007)(316002)(8676002)(8936002)(186003)(83380400001)(2616005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/RU9qMbZdHrHSfpjrVZK2zspNqExTQBK9QUrSN2LJ4ULPDHwsEyhaDtkS407?=
 =?us-ascii?Q?Zf1ZTl1+xlIgG02vm0yTORFWcAx5pCjw9K3RU9KPH9wOyQtTofIS7OvY+t/7?=
 =?us-ascii?Q?6shhzTOAizwhRGQxYrFi/M/56TMI/MZ1JT4VhvWBSgG0X5OFrRuuYuvkqnjN?=
 =?us-ascii?Q?1VuzVEktLHAFJ7tJkL1eVnw+6aR6JgscUvqc8SnAB3eCgxxafClipfU61NUV?=
 =?us-ascii?Q?Wl7TqT0TqSgdDzEWvYfm/shCJOPtzW4VwSVI1+vbTNHfD0d9Z3ejOAtaZjRh?=
 =?us-ascii?Q?aeV4X4nTFLlYg/7d17ITyKpLcbGBoS+gxZiLaI6J662x7ICRYejxmHLEa4+R?=
 =?us-ascii?Q?T7t6KSZTSRv6kjironjKN/ML5qpNEU6JmcoSZC4hAoX4XRxnpJLstYCqz65b?=
 =?us-ascii?Q?Y2gy1TblB+OMUuFFbRkAr7cXL4wx5L9F/UMWNVCfXJjC/qq9VMN3JIWWfYo+?=
 =?us-ascii?Q?u86v1+Q/ET28v84K1om5hkKDWcY+GmnuKKAERenptxzRB4LjB6LCu5W/UnWs?=
 =?us-ascii?Q?Xl/cz3ASlgsM0xD8Rcw7zRWE8+Uz5r6Fcdb7iXyFTxYgviwnO4xAzxnOPtOc?=
 =?us-ascii?Q?L0QNgp3Y00ZAmKIrgrYH/D6xtBamoyBgVHtCFCgHzjDS1L1JwoVJRB97/BqR?=
 =?us-ascii?Q?2+G7W4yPZwdZl6fV3++IIsBICu+8/Sk9xCVS7wA5mUAMK82td8OftwZMFKW5?=
 =?us-ascii?Q?mPNPgSofHgoFWnioUjrTj08AUbrO4wV67EySpOICp8t1OTSr7k+z6fiuJUVo?=
 =?us-ascii?Q?MAVGxfkvD43APZVectZE/99dZgsKlaSXqFKCjna0DkHa+9RXdPny7ut1G+5C?=
 =?us-ascii?Q?UBU0486Yb18QQ2Pn0hRLz9DenHT7uiSAoikiRImmN3fw5/1HuQtuM96IKFPu?=
 =?us-ascii?Q?VuajkQn1WDYDuoJVhcq2ooR0Qobv7SSDrq7rzD5QUIGOZ0eBsWSLvioLDmjf?=
 =?us-ascii?Q?IvytQ+8KfRZk0+dA8NSe0u1tqlJkr5yDV4OHj3IwcrQmIYjq1Zqq+ozT3kYv?=
 =?us-ascii?Q?kDuVXMKgi6l42s1nb+TMAP8NGzzy33Te0NdN9au8pkmVkiyg7Bmo+Rm0fUwi?=
 =?us-ascii?Q?Dm4DrE6d?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159b3560-06cf-477b-cb1d-08d8c858c6b1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 15:31:29.3240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSFUa2eiFJAXDtVSIGbwZxR5+dz1xu3whAm08/Dkbfmmk4NplMTeyOD8FhuSNAgy5ZXjzFcMg4SZfiwL7pqOwn0C30ynPpD1N8JT0Wcoyr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2351
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pvpanic pci device driver support.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/Kconfig       | 16 ++++++++++-
 drivers/misc/pvpanic/Makefile      |  7 +++++
 drivers/misc/pvpanic/pvpanic-pci.c | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index 12bb017..4a96e8d 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -1,6 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# pvpanic device
+#
+
 config PVPANIC
 	bool "pvpanic device support"
-	depends on PVPANIC_MMIO
+	depends on (PVPANIC_MMIO || PVPANIC_PCI)
 	help
 	  This option enable generic code for pvpanic device driver logic.
 
@@ -12,3 +17,12 @@ config PVPANIC_MMIO
 	  This driver provides support for the pvpanic device.  pvpanic is
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
+
+config PVPANIC_PCI
+	tristate "pvpanic pci device support"
+	depends on PCI
+	select PVPANIC
+	help
+	  This driver provides support for the pvpanic device.  pvpanic is
+	  a paravirtualized device provided by QEMU; it lets a virtual machine
+	  (guest) communicate panic events to the host.
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index d08379b..fe57d1f 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -1,2 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for pvpanic device.
+#
+
+
 obj-$(CONFIG_PVPANIC)		+= pvpanic.o
 obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
+obj-$(CONFIG_PVPANIC_PCI)	+= pvpanic-pci.o
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
new file mode 100644
index 00000000..1d25d11
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  pvpanic pci driver.
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
+	void __iomem *base;
+
+	ret = pcim_enable_device(pdev);
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

