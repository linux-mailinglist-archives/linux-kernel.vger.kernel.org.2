Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE99347CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhCXPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:38:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55442 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbhCXPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:37:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OFY9II106144;
        Wed, 24 Mar 2021 15:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=M5V6zNNGrEXvP+Ha3gMl0tuvhhBbQm8LpiMMKR4coyk=;
 b=WXYjZj41KNgQm08SkRrAqtWjG/m2XTlsNici+uwDC0D5zO0iu2SeTKrXPShuYeHaMfBW
 ep211veUfp3fE+BFuP/ytlk/jiBxdK2o5vR4ey/Y98lfn2CCoj+WVGSYuvUCTe/9KHuk
 5ISfBxYd1uQVbNIun98pYk3OKJYmE9jaFs3LP/pZ9d7XJHC+NnrieEU5qm+IRb5DV+HI
 2tam0tgSNne9jxelAvpkSGrxafqK2njesxt3uvTAJPw80SyvWTBEiG/xCmv1STVfzFh5
 J10LevWeg0ysYICviQrBPIRsey/NTnuMCwCgTTEd4nH1mOS6V+MSQ9vMxZpwpvBB8o71 2A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37d9pn358m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 15:37:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OFZGtp157900;
        Wed, 24 Mar 2021 15:37:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 37dtmqyg00-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 15:37:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC5pH5P0WMlMLucj7ywojUcdsoT6wxihsJ7W8rmOEldRaQtIqAvcyzrARXNS6/DPqicv/Do2iGuqF4IoaRBZ40mmLI8tnhqwdBoQuw/SUzjtkHQWAVQlev0sVYWMlKlxRdOpZrnedfLCbwZKVtS3N3dKLEJLfSxKHgC/iTU/xc2iq80dnfezFyaU6qv5p6YYSaTvy1PY7rMOLjCG1Db2ahs3yuub7ZcDVsokqdRwAPt4rhK7Srn7A5DGBYrc5KgFS5/c2MUATLbfOV2Xll37jYgi12z01rLrRcIP9zRdod1JEeQxUcMx5pr3bfUSRiWo0UDDhkS7SCCBy/itN1ewZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5V6zNNGrEXvP+Ha3gMl0tuvhhBbQm8LpiMMKR4coyk=;
 b=YsusG2A5m7DWP6W8ZCA2oLL71EteD3Z4g8plFd7uudYrsJZh6D4MRY0xTBF5dooFHJgnDMd8JrPL2nfWfAQaDFw0qSVJyeUE+KgEztrK3OAxTje//ZhEpk9BOuhNAlyhI8nxGBI0hSwhCDtlNOHrvPliwtfpU6cyspWvIQwaNOt7eZwyt+RqD+R7LjASHgQudNwcC9Nx7XDVFtIOdymEMPhp9z9zZEBW0buoRaB9CxtSfv2YOIHPHCg2NhkIbx9Ts5s4OiBujDHBy395eFXpq6Gp/P2tJvBGEMJdRYIdDcuV4JIRcYufc70nkkJqKqM5SiUP8toMOSEB707gu8NeXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5V6zNNGrEXvP+Ha3gMl0tuvhhBbQm8LpiMMKR4coyk=;
 b=tn5tdeKke8Cc3ONDlwuy/Er1zIhEkqlxnDpyFfwDhCgxTk4fmuO++fXzjpTd64eeABU93eToYhVbLIE7y1ccqSLEqo9dohLvW6VwdbHb2YPGqi0vnCoYGoxAY0ypxZHB6mgkcjnmWf4FAxJjT+lBX3kbNPjgKgnCirwQdnTVz0w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4465.namprd10.prod.outlook.com
 (2603:10b6:303:6d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 24 Mar
 2021 15:37:23 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Wed, 24 Mar 2021
 15:37:23 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v8 1/3] misc/pvpanic: split-up generic and platform dependent code
Date:   Wed, 24 Mar 2021 16:49:14 +0200
Message-Id: <1616597356-20696-2-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.201.25) by SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Wed, 24 Mar 2021 15:37:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b886d0c1-72b0-450f-40ff-08d8eedab823
X-MS-TrafficTypeDiagnostic: CO1PR10MB4465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44651AFBE89409B3B3F3FF3A88639@CO1PR10MB4465.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+2vtkALU2SdjE1d9fv6MonNHpZo+tdaCVD0VVGIKWdjfG/BzrfODrskQBIEu8G01Tj2XFtPn1S/bVQLUMYiSlOyN9coLsjFkqX3swvcY3jhp5dPO1vcqJrycTyRyYAlnrO0RF/r+qEZJNV3yXnGqnG4W2YekfNuD5/EceWtLizGqix2IjQKsAst4TfW5N9B5rOhFoFSAyEAhdJogT2XkjKt2xexLETl8y62QlMdslOJAV/oOSHsycOIOoux7zt0kw7RQ4I2PZY3e3MoKuR1dxpBVPw1jm/9ssHvsOffpkfh91HRM+mVoxamd/59GWpu5wBqeX9KbCDeoFV2e6qcUCliBDSZ/lYx2bNeFoSF58iIETnZ8YhkpFJTgEA/OSv6JuifGZcBOjM5M4LanO+oQubAQDY1Wz46IF6+FYLNCq0omGCrISeyg/nh728JhTgMGbVQClyZOJOXyeQt/2FGSIVZlQMdJNm20Nx5/0xhvfMTMEKmawWS2KkJLT5umydfI9ZmNdY7a5fJRaJ2NJqLufOocMM1cdH6hkXOGSZUSubzRAZkCOfQBd6OJA9xtFlU6kFQ9NCiA2ZBqr1zu4x3N4n1M0gqu+Kz6cMKKgEmb6qIeM+u6U5L+Fdumxptlqw5B+U+X6hrXX2xatiFluMXRpTJOiTv87qtnNzj5hLRJ64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(346002)(39860400002)(44832011)(6666004)(6916009)(107886003)(6506007)(66556008)(66476007)(66946007)(2616005)(36756003)(2906002)(83380400001)(8676002)(956004)(478600001)(6486002)(4326008)(8936002)(26005)(6512007)(86362001)(5660300002)(52116002)(38100700001)(30864003)(16526019)(316002)(186003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+rsMSFpvvCXcSwJ6Q7iOwPlb/3HpwX3o96Bnd4cEjjfFRmhUodZqjr5pkv6e?=
 =?us-ascii?Q?+IMuWVr4d1Yao+etNyGffNli+6vAg+VoyCFkY73uE0ejKmTOlt5GPinbKiht?=
 =?us-ascii?Q?uMpW5gU3gg7+LS4dzoKKgeoTB7GQbpdTloRj1kYZeGzIV2RvzBb1JD1plG1w?=
 =?us-ascii?Q?U7jqcvqVEfuIftD026F6p+us6tn0AqRHlBuK3wPhg01Klp+x2/+03c9yFKXq?=
 =?us-ascii?Q?4Tov3bMlY7ym3QcQGXZZ52FxexU2fuRS69aYIZxZPqzJv6iwwKwHLh4AoRg+?=
 =?us-ascii?Q?9l5tFM2ZgqAvslTdcXWxhRVveG6e/aKb2AbUG+UPBksJjfe3dmgvfd15E3Fk?=
 =?us-ascii?Q?slk/XshnkaReP+0S0waT7maeTfA4luMG7BOwumfSctLc5fFhGSv5l2VYmxTE?=
 =?us-ascii?Q?3CCsS9PVptnfGXf+X6j67YGfSNCJw8xjhO70QBGBQbpxlXtAeAW3woxyWj3C?=
 =?us-ascii?Q?lOa4qCMseVS19segQxoP5U5VdjW1u+sqXbaPiM1vnqXZeKCocdPfmlJ3fEbo?=
 =?us-ascii?Q?/wP4lgj0KJ0YqN2OcsSRs3cQV/cfNrdsdeb2CNr6/e6XZINuJMpslHoDCiR2?=
 =?us-ascii?Q?OTZ5Y/B4pirS4XtjbgKFMXI1WViAHcoc04zMu5vuQZ+0OQtvpWo4ag4qMsWv?=
 =?us-ascii?Q?hJceGui619OM615GgE/L8Y4yS6lfqxqnjbfkg1uKZQ8+Laz8T+8vQJ7b/DcN?=
 =?us-ascii?Q?sgOzoPmBHW5jBvd4olnk0rsFznR39qYHu/8WvvFqGS+nQq0DX89yiHbXbs/b?=
 =?us-ascii?Q?qJ60IEo8wwKZ74E8WaiF0HY4VR3+C25kuNpwPMkJDZ0HMZ+4nF8EO7WvQig8?=
 =?us-ascii?Q?7JJvFW19yPd4EFWVDh9lly1uQ41DaVgS3ifs8yNqGO7eBDJWwAI6QAdvs/FK?=
 =?us-ascii?Q?j5xDMpN6Inpu9pK+6azkFbI3BxItlBWQlUTzWvsBd5cW4nOMXVOzAzHSjwM6?=
 =?us-ascii?Q?y3NNLCBaI1Gn5PgUpJfrlzgNgJMMPhJ7bw6wbwcdv5cNdtRgs2QePKfy5gWs?=
 =?us-ascii?Q?INHC2PwzVFz/MPJa2JQI7pkahghAzlql7qozrXO3nMWDFsXA8HK/O9BPRMKU?=
 =?us-ascii?Q?csd+sAAziUEq/2tZf4fIJyJKys6/MTmi7kXoXa/Is0U2jwcSIC1gC2LEomWr?=
 =?us-ascii?Q?FE12nUb2l97gv87bP97epgCVBkg1B6+5IR7/XWvzMLxqzVkOQGi3OK0EFTwh?=
 =?us-ascii?Q?AQDiLBBq9TAgMJEOSnDeaSDnO72l9+7KUCQb0tIjDM+TDmqp6dFd+Vk2oJ07?=
 =?us-ascii?Q?EoJKRmi+4EP1+gCOpYxYcgxDjobG6rFigHnuMCGhQ/j9DhGsrgutzXhn2p2m?=
 =?us-ascii?Q?o9K9xSCEMd0fqS/TEPLZqnPY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b886d0c1-72b0-450f-40ff-08d8eedab823
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 15:37:23.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frvqK5789XIgWYNGCQWQB+j4Q+qB2hQAHEi1haIsHB0F1U4tVpo0pm15IyHroRr8c08E9MSaTnw57DAYCPoB0HwVaFB4lGUzHiEnRRftHpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4465
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240116
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
 drivers/misc/Kconfig                |   9 +-
 drivers/misc/Makefile               |   2 +-
 drivers/misc/pvpanic.c              | 161 ------------------------------------
 drivers/misc/pvpanic/Kconfig        |  19 +++++
 drivers/misc/pvpanic/Makefile       |   7 ++
 drivers/misc/pvpanic/pvpanic-mmio.c | 134 ++++++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c      |  81 ++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  15 ++++
 8 files changed, 258 insertions(+), 170 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/pvpanic-mmio.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f532c59..c5f20e9 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -427,14 +427,6 @@ config MISC_RTSX
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
@@ -461,4 +453,5 @@ source "drivers/misc/bcm-vk/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/pvpanic/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 99b6f15..fd5f87e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -51,7 +51,7 @@ obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_BCM_VK)		+= bcm-vk/
 obj-y				+= cardreader/
-obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
+obj-$(CONFIG_PVPANIC)   	+= pvpanic/
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
deleted file mode 100644
index f1655f5..00000000
--- a/drivers/misc/pvpanic.c
+++ /dev/null
@@ -1,161 +0,0 @@
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
-static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
-static unsigned int events;
-
-static ssize_t capability_show(struct device *dev,
-			       struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%x\n", capability);
-}
-static DEVICE_ATTR_RO(capability);
-
-static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%x\n", events);
-}
-
-static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
-			    const char *buf, size_t count)
-{
-	unsigned int tmp;
-	int err;
-
-	err = kstrtouint(buf, 16, &tmp);
-	if (err)
-		return err;
-
-	if ((tmp & capability) != tmp)
-		return -EINVAL;
-
-	events = tmp;
-
-	return count;
-
-}
-static DEVICE_ATTR_RW(events);
-
-static struct attribute *pvpanic_dev_attrs[] = {
-	&dev_attr_capability.attr,
-	&dev_attr_events.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(pvpanic_dev);
-
-MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
-MODULE_DESCRIPTION("pvpanic device driver");
-MODULE_LICENSE("GPL");
-
-static void
-pvpanic_send_event(unsigned int event)
-{
-	if (event & capability & events)
-		iowrite8(event, base);
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
-	/* initlize capability by RDPT */
-	capability &= ioread8(base);
-	events = capability;
-
-	if (capability)
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &pvpanic_panic_nb);
-
-	return 0;
-}
-
-static int pvpanic_mmio_remove(struct platform_device *pdev)
-{
-
-	if (capability)
-		atomic_notifier_chain_unregister(&panic_notifier_list,
-						 &pvpanic_panic_nb);
-
-	return 0;
-}
-
-static const struct of_device_id pvpanic_mmio_match[] = {
-	{ .compatible = "qemu,pvpanic-mmio", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, pvpanic_mmio_match);
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
-		.dev_groups = pvpanic_dev_groups,
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
diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
new file mode 100644
index 00000000..d7bf7db
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic MMIO Device Support
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
+#include "pvpanic.h"
+
+MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
+MODULE_DESCRIPTION("pvpanic-mmio device driver");
+MODULE_LICENSE("GPL");
+
+static void __iomem *base;
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
+	pvpanic_set_events(events);
+
+	return count;
+
+}
+static DEVICE_ATTR_RW(events);
+
+static struct attribute *pvpanic_mmio_dev_attrs[] = {
+	&dev_attr_capability.attr,
+	&dev_attr_events.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(pvpanic_mmio_dev);
+
+static int pvpanic_mmio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
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
+	/* initlize capability by RDPT */
+	capability &= ioread8(base);
+	events = capability;
+
+	pvpanic_probe(base, capability);
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
+MODULE_DEVICE_TABLE(of, pvpanic_mmio_match);
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
+		.dev_groups = pvpanic_mmio_dev_groups,
+	},
+	.probe = pvpanic_mmio_probe,
+	.remove = pvpanic_mmio_remove,
+};
+module_platform_driver(pvpanic_mmio_driver);
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
new file mode 100644
index 00000000..a9605f9
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -0,0 +1,81 @@
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
+#include "pvpanic.h"
+
+MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
+MODULE_DESCRIPTION("pvpanic device driver ");
+MODULE_LICENSE("GPL");
+
+static void __iomem *base;
+static unsigned int capability;
+static unsigned int events;
+
+static void
+pvpanic_send_event(unsigned int event)
+{
+	if (event & capability & events)
+		iowrite8(event, base);
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
+void pvpanic_probe(void __iomem *pbase, unsigned int dev_cap)
+{
+	base = pbase;
+	capability = dev_cap;
+	events = capability;
+
+	if (capability)
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &pvpanic_panic_nb);
+}
+EXPORT_SYMBOL_GPL(pvpanic_probe);
+
+void pvpanic_remove(void)
+{
+	if (capability)
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						 &pvpanic_panic_nb);
+	base = NULL;
+}
+EXPORT_SYMBOL_GPL(pvpanic_remove);
+
+void pvpanic_set_events(unsigned int dev_events)
+{
+	events = dev_events;
+}
+EXPORT_SYMBOL_GPL(pvpanic_set_events);
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
new file mode 100644
index 00000000..3abe15f
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Pvpanic Device Support
+ *
+ *  Copyright (C) 2021 Oracle.
+ */
+
+#ifndef PVPANIC_H_
+#define PVPANIC_H_
+
+void pvpanic_probe(void __iomem *base, unsigned int dev_cap);
+void pvpanic_remove(void);
+void pvpanic_set_events(unsigned int dev_events);
+
+#endif /* PVPANIC_H_ */
-- 
1.8.3.1

