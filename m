Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E590344D69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCVRda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:33:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35840 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCVRcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:32:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHTle2094073;
        Mon, 22 Mar 2021 17:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Mn5EQRwQCJgub3nH6W5hdJejwI4P/1jAOnNWwouxeJU=;
 b=UU3tg3p88PKxzXlK8FT3xA9f2hWeoypSmz0z/O4RNi8NO9Vt8c2jUtqDr89+ooYlTdO3
 vFpIBVNEZvssqUvIC5b9BPTuinz20/1ezNwQww9WxwaFedELsoOoo1RQbGdBes2YLuO0
 u0XRQ57YxqE8K33i3VUbbPO1lnJVN0KR8VYVAKul853mqcXqOeTyIlH34/kg12l8V6jW
 lTKge2S/3rOSno8SrAr1gQw/6771G/1dyzVZXQVlyeR1ZGvTBmoXyWJxI1FKtRsMrjNf
 aO9R/Sebepyum19e1cyrnlWfG5T87Vsepiwz+9A6Mo5JDTAQsX/n29sWt6f8lOjhXNOb RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37d90mc90t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:32:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHUdds113076;
        Mon, 22 Mar 2021 17:32:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 37dtywcepc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:32:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRGUmZm3OgoVeUz6FWkrY8rKrC5UIarJz811zLtIFpdeHdXb9EhTRrrdyKB+WRRz/8dinuFoafdT4MVeO0siI63EAAUfZVeA8WC4d+Q0AbqUP2YlLn2AK5XaegVWfSbZl4pFWZuMcykn1DD3igQh/u6tlsJaooAbimR21ueQ+9zkiCtPkEMOLpRIkc/r5hlX8GrK33d7Gj2gqNosbq47W4FFmbEoZmAVCU+GgIVhS1LNq8pRdg4+gSPugjOHydTEuCA1wgRsFOe/DHIbzTYYDbtVuAcXwPdSfZWRyzms15DS34wc5DkAuaBM4X+wlXRClLsC6/89C5bHrR5jaAAx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn5EQRwQCJgub3nH6W5hdJejwI4P/1jAOnNWwouxeJU=;
 b=ccfn6n0OAT2kwS2ZVRuO+4fUWkttQJH0zYWH1nS2CueDXF+cUWInjiOIKdmu/XLOZNN3lW3TjFkhxdYD5eU18XXVJyJZuRleN4LNSqJHIgSpO6gfw/i3TebUm+V7L9ZjSx/CY/Y1+Td3bPbkTEtVPYO3j1bELpBmM0wIJmHjQ4xx+6MYbKBpiyBBG5kice9FmPHyL72UukI0KUMp0EeUlXh/KU0O753SCNVifT7mjlpZh82JyVz8KaDwgBBEELvJcIdxwW1uJMOGhTA7LSdQW3uJXvszH4qcnwL646/y3EDt8Yco5UhyxdzcK+1eDvhvHXZ8Ki7VcM+mujY13iCA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn5EQRwQCJgub3nH6W5hdJejwI4P/1jAOnNWwouxeJU=;
 b=t8m9h+D6EZ2FXtFpyfeXKRAdqudrxpeYQNo4j+V/fk6E2Lit/DLe2C0z3uY0k8/ScVPf5ZU8OurvQ1Vxy94tWoz8h2VwzRy3UUh6EdUak9mLCrVQMM25B33unDQOQ0BPAkQe9VC6iS5II3aB+7R/NNhJTBgExDqyo4GyEwkGYEc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4451.namprd10.prod.outlook.com
 (2603:10b6:303:96::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 17:32:33 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Mon, 22 Mar 2021
 17:32:33 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v6 1/3] misc/pvpanic: split-up generic and platform dependent code
Date:   Mon, 22 Mar 2021 18:44:25 +0200
Message-Id: <1616431467-14173-2-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.201.25) by SJ0PR13CA0092.namprd13.prod.outlook.com (2603:10b6:a03:2c5::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Mon, 22 Mar 2021 17:32:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7252cae-b547-465a-bb10-08d8ed5879b2
X-MS-TrafficTypeDiagnostic: CO1PR10MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB445160E2D9D76E6FD1CAFCE788659@CO1PR10MB4451.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jN6GDy10WC9BhN4JLPGYMTPCNnqNfLg8JR0O2RDqJ6AoTW8MuiTdXIcgUwcHcX4zlMExYRwyXv+lk+9Q4XiutonICXrN2utowHxVHmYzM+msYvZ7dKsUzn54mdg++KFtAZpP6D3BxKqI9JAmG/oFKGGKqIODhp/kT4g0wRX/Z7jFME3OuMnlYCgOz1DTHQoNuJAjty9on3ryWAHpTAofAxFctPaZHhL43A/GH8nRUy45LUfEitzT3/wcoiuUgyWgfgVrX0Fy8aPb1InXs5xleQeK8l0dEJdl5QSp8Wehhj/yz+3GJaIzcuKYfKWtDxnvf84NfHmJagco6WVAUvGCHanzfcngP/7W94K+Kq75I0McqTG2Oaz+ZJ0Ur6l395shgDFOLW7rgzBuS3e1PdWqEWk3a6nfdvAefFcot6re2ez5in222ppcD8TUp4W2dRllc6qlt3dCGudJqGAwnS+AHnGddJ4ixIWNyNBazo1Et/CG9SKtaMv8TIwla1cr60gWmD2J4rxNAqhXMQg6T4kM1XclKv/cjhEzNJ1DupjzDjI6twmQt4aPMzX+d7X+tXrmw6oEHF1o2yuaMEv5ZkKS3pp/y9DvUAFrQAC3OHxMjH52ZHeiXXhQmclPw3X9bS65+GRAZsdLZMDLiB6LpJGcAKTp09WTRpTM9e9rsU8U0oM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(346002)(39860400002)(316002)(4326008)(2616005)(956004)(66476007)(478600001)(66946007)(8676002)(107886003)(83380400001)(8936002)(38100700001)(36756003)(6916009)(6666004)(186003)(6486002)(2906002)(16526019)(26005)(6506007)(66556008)(52116002)(86362001)(6512007)(30864003)(5660300002)(44832011)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IjF9Ty6ltU0UXLl0nqQ0D/0GK1v3hr6I5bNRtk/aCcnJJhP8Rdqpn+ZDZNqV?=
 =?us-ascii?Q?TvCxQ4d01x6H33iuOiuiQpOX4Pin3cteQIo7zF9vodlK+VQEyZ2ZQEXqRM5U?=
 =?us-ascii?Q?TNSCfRCS0PUU67W2bu12T7UQR1go1Q5UlF5TOHRIh0c1k4wvrZhaZ0ipr3+w?=
 =?us-ascii?Q?QvHEmq6bG0JAY500uEZTkDEa+01TXQAIKd5BcWpLh1VjLXVsUusJwqgeHGhj?=
 =?us-ascii?Q?MoHHwnA7V2aGOHh7QG/cBE1kCVO+WIh9APFWb0rd0nveIP8xtC8Mk9UYsnID?=
 =?us-ascii?Q?rkwtj1gk4vPBzNyz7qmrmHWdzQU2VZp74hb79mgh08G+kuaBRkXoqiPz9MrS?=
 =?us-ascii?Q?+DXrOuxH2uKSqSf3A1AH5DyTjRHhCua017L+u2a3PLk3LO5LfD6lCONCVTGU?=
 =?us-ascii?Q?Ey8zxMT6whVoEgqqae14yKeEjfXgHxRp4I08lsBkITuseC4JKhCvLjq7mli+?=
 =?us-ascii?Q?rKBfk5PHqhmhadfvDlzETXuTIMxu1EG3S9DO3b5qT6yB4Rk/dMT3DNfu8M4c?=
 =?us-ascii?Q?BHJVrIpx2LP7OU1/URXhrr36YwBzzBRCXg2zMyXRiWr4kcbYuJz+/tF+nQ8D?=
 =?us-ascii?Q?C0kEaIV8bGyO2BEwmuF1AuYzGZOlIkBEX40Vh6+B4ME0g6oq4bFJcw7V5agZ?=
 =?us-ascii?Q?i7IztFADF+V94fOTvOxQGAAzV+3H79xSQ1L+wy6DbTYtXlj7ShA3HzzaYlOC?=
 =?us-ascii?Q?im24v1QEHdv02EBsv0tu+1UplAJTI7Nv1w7hREsfOyBPFvHaQKm5LJOc3jqw?=
 =?us-ascii?Q?RorplcWBG6lrv8SHiiLpkaMdernveK9DUi5gxHyk/ApPsSpec7Vo6hLgl43M?=
 =?us-ascii?Q?pwWfsRWERHiPcNnqyPPNXvkYGyXWlv6YFT7tGyAcv17EgdubloHmacWdsfK0?=
 =?us-ascii?Q?9Tg/IO5JsJK9NhQk6/ZrrnX1Qsma4kQMDBD6858xokPsADVlmDFjuZZ4vCY6?=
 =?us-ascii?Q?QhyJv+rxC1JE3IJ72Pmr60mhqakI6chgh7yv+tFLW+0eEmnuUKOR3rZH5/77?=
 =?us-ascii?Q?5b1lrEFjmK3CW+DRSEJb8uM5e/p8Py31gLO4rraZ2sjz1i4vaWCq+6ZkUy0Q?=
 =?us-ascii?Q?1I0nnhKXfBxpVbsNB67mbD4tMprQemJXq9de68WuykPiQ0SMH8LVxDQMm/ND?=
 =?us-ascii?Q?U9oeBVuxrblFGkyX4i+d6jhzsFqVyQUKKnaqoYRNc3fslFSt/jhupV1C3sIZ?=
 =?us-ascii?Q?iRaS3c99d7ryOlJIsWo5aEaNYhVvaIWknLw+BfBhaRXN0ExIJHWXcxeq9BXA?=
 =?us-ascii?Q?xJbEXRj8SvCWTmbtw81QDKZca4kC+j/78SJPkLKUXvyL8o+b5+1lTGC7g2uA?=
 =?us-ascii?Q?iocgWIMjNiHdM2AOgoOypqEs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7252cae-b547-465a-bb10-08d8ed5879b2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 17:32:32.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4CtdffR87ql6nl17U6SMIDyL0cY33EioghGbN+CXm2xDEY+GrhRsQZboswor5YbGKcwCOrU/vc4T7tUq/BPclyCtWfX3RVGWZwW5znuh7k=
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

Split-up generic and platform dependent code in order to be able to re-use
generic event handling code in pvpanic PCI device driver in the next patches.

The code from pvpanic.c was split in two new files:
- pvpanic.c: generic code that handles pvpanic events
- pvpanic-mmio.c: platform/bus dependent code

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/Kconfig                |   9 +-
 drivers/misc/Makefile               |   2 +-
 drivers/misc/pvpanic.c              | 160 ------------------------------------
 drivers/misc/pvpanic/Kconfig        |  19 +++++
 drivers/misc/pvpanic/Makefile       |   7 ++
 drivers/misc/pvpanic/pvpanic-mmio.c | 134 ++++++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c      |  77 +++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  15 ++++
 8 files changed, 254 insertions(+), 169 deletions(-)
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
index 9f350e0..00000000
--- a/drivers/misc/pvpanic.c
+++ /dev/null
@@ -1,160 +0,0 @@
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
index 00000000..801d892
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
+MODULE_DESCRIPTION("pvpanic device driver");
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
+	void __iomem *base;
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
index 00000000..11d029c
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -0,0 +1,77 @@
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

