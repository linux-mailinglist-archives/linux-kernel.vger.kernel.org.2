Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D5433D49A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhCPNJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:09:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57758 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCPNIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:08:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GD4UXr049575;
        Tue, 16 Mar 2021 13:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=fU/vfzlBOyJpVbCppOTwW74shqaal2p1vHC0UsBJncI=;
 b=IM3L5YSP/t+rNGwOQojZuwod95+y/JOn7T5NCXeNqflSQ8ULaEOEhMH1Vcbwgfsu3ATk
 DSpuCeelGjjoZHEivFFvbpzGmIuv4mj+ny1qWOC17wCssw77HO1u//FPBy3HfR+oNwOm
 sNO/FVfraexTvE7xYn/PWHHLKOhHbu9DqluvNIJ/9ym0YLuddykqi8mfcdyu/eSDmvjN
 yINm7lcsF119JYiLWpEKJSA0+Sny/qb956Cjyr7baodDvZ0JL/Gg089rzFKqibwwiObS
 qUAhMchv3urg2plR3vypk4WgabNxJJQnHwEP5Eq5nKPN354b6l0X/YPYRoltUyfLrcra hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37a4ekn2am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:08:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GD5pfq091066;
        Tue, 16 Mar 2021 13:08:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3797b02470-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe8HxMj68qDVaM3T9VUvOa59b13Yf+rJZ9L5SHHD8BqvwfwJ2EpeRJ82pK9ioAwwww5e89/merRgoRKbhNiYIb7vVJU8s5xEj6gbIYIvO3I1b4kXSCx/UY/wV5qPKss8E4ltUbZhdDAsFMwqosiR6XfyFB2JXLV9lrOseljhTsFO6GvV9E4+fLwCgpGGUIk6U8x/fvwvQ8+ihI74MHHvW4Oa9YGl4ZOrJQHTWt6GpuAS+w7/SLses8+H29AR1Y7xivj3T0+7x6p595xk8lrtTFrwdhR7kqqf7r7+WBHarZcR+BOrYvrbxiHfCV/SWFlcaCkIQzlYxXElQn8IVuIhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU/vfzlBOyJpVbCppOTwW74shqaal2p1vHC0UsBJncI=;
 b=VLi3Fb5UgB5imHEDPPfcAxWL9uBHltmhwfj2DOW9E7V5dIRR0ZHcawKa+46hehen/WfYY75+FhrDWtmylFK1KlBVXgWSQQTJ8hYai2wJzam2KPFBqdRU1CCwQzoxhN8emWmZ1tUk0RbX7eh2DQhWqSkVz4ctM6iNuhPmyQhnX/ZDINGRAwnhEQ4XXe443RWzZOFohI6DTHRBgtINnjlYKymvywwMvbP9coyJmKiI8s1o9dhk1WP+J4I+i0dXB1NzAZcAodNUBQwBgWDiVpWMBe96Ew0Nzw5Nx2v5xkDpTQIaftEGCAoG33AWYpeqkjUBkENo7fXyonEd8mfbPchIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU/vfzlBOyJpVbCppOTwW74shqaal2p1vHC0UsBJncI=;
 b=Uf9UpR9Tuwwax4PYWdNzBwfJKo95wyy2R8KKbx3BAVbcXtDAWZc2Rz8hkI6gb9R1MpVAEcokUpmxqLMybscalURxvk8YkvbiBbzrs2ScVJB/uc3Wim7qdxlh3rIZccjum6WzbTaDI2RYnmLEB4oMbtXGYZO9165Qv926Z3rxr88=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4435.namprd10.prod.outlook.com
 (2603:10b6:303:6c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 16 Mar
 2021 13:08:26 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 13:08:26 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v5 1/3] misc/pvpanic: split-up generic and platform dependent code
Date:   Tue, 16 Mar 2021 14:20:27 +0200
Message-Id: <1615897229-4055-2-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.200.25) by BYAPR11CA0045.namprd11.prod.outlook.com (2603:10b6:a03:80::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 16 Mar 2021 13:08:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a79f3e2-759d-4024-310d-08d8e87c95e5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4435917B6AB68E7EE35AA368886B9@CO1PR10MB4435.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcNqO0z1iIielwagq1hZva7ThDgGhUix47vEvnC3zcCVtVZA+O95XNoiRdDRlHFvI8pz+njDrf680b8sS0tBPzPyKszeiz14NHaGizSywef6Vd4ZEP/zyo73TO0WgLEjSNILP4tKU6GKydu6FYo2rkj7O7V0nCe84L6S3mkX3nD3vtyQzyLY+j+l6xvHaWXsb05aAp52Y0aQphJiYSdAyVrc3KY9AaTMekWgQNOdlVAKeJBqJEfioL1nlJUu0EVDC+2zavR7qDGV/vbfbxfQV3iePweYscJYcnjIdAvwp5BzjTcYx6NisG3/P/PIe44WC6uOke3rMegH+kzUTk/JH1+/xjJ/T/3lALnxF2LefOLsn5UMAyVbGkEStvL3Relezbf5vLzNRkvtoENsA1WFpG4HFTecZnS9NYm4qrr58WerBMloGkECqYrThQvIj7UYr+z7TE7/l6cj7hEeoWTIvuglPPd9XnorIVMMenqq/sENRAJdGpSJwq7T97kUF57ZHc+a0qQnRoN8L23oempJ50CfnnXSUun/91/4CjivU+yhW9z283759k23WsMDgqCtG5rR4cJ4wh1IXp9S5XgTxJF2MLCDAORAmt0u6zFvmos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(36756003)(2616005)(956004)(44832011)(8936002)(30864003)(6916009)(107886003)(83380400001)(52116002)(6486002)(186003)(16526019)(6506007)(66556008)(66946007)(66476007)(478600001)(86362001)(4326008)(8676002)(26005)(5660300002)(316002)(6512007)(2906002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?drlJSQcaiMPsFQjmX1ElMGN+t2SaG10GodaTxoWILrFQqEDFHL9nq0QgMqWj?=
 =?us-ascii?Q?IWjO3CM9pDJOHTFxlbmKZLw9msVHyAtJ/3KCY2a/2vGWwC9GB2bWdE23TWaQ?=
 =?us-ascii?Q?/BVn8Qgf5+W+TN8zVBNMXYtmiBQcmx+WQanmoyEs71+Yv7MladzTLkkbR13d?=
 =?us-ascii?Q?IbsuaDGzJDH8ylEvp/0h942fHB6YbYe2kFzX3b9FzrB3Hw1bBUGQhMmxzQsZ?=
 =?us-ascii?Q?/9WG7fuAh7z7BQsVEXOtmxKZT1kUAXN8v9vB8EiRZy8XGiN10/bC97LJX0Gt?=
 =?us-ascii?Q?qtRKOzcyVEsEOqIB7nJiUS2K1zweVUkHxsHhuCgCRFcKkEo6XkbuTYF2fguU?=
 =?us-ascii?Q?77xfQ3DoPIjzV/0re1p0G2dEnhh6qziY2lbx4/EHu10mzpClosab0Y37T1Jl?=
 =?us-ascii?Q?fsltCpNLEVF8gU12+YXv/1jvcVgdKyDCN4sT7TlbkCDQ44euV/26tqNAfWxL?=
 =?us-ascii?Q?F9kzR01gcsgX64h+V2Ix1ZHRyYc5NiEchI6BiTEP+m1UGH8dpqH2KS7RvxFz?=
 =?us-ascii?Q?pbwfFZtkrsIByPYnWZypuJADPNF4nN+EtjCVZJmYoT8zMT9MnGTyTjN6kfA9?=
 =?us-ascii?Q?KO0jVPpKniwg+gwe07VKTNuhBrUN/5I+HtTh/PV3QvpRTRUeH7UWERJsS8yO?=
 =?us-ascii?Q?X4mBW9ndXZSfk8FGILmzOyQ3t7qU39oSpdB9chOXTpJmMgwRF+lfIVw2ATyD?=
 =?us-ascii?Q?AgdcryS8O+xvtxTEkxpIU/cpe5OszoR0n46ufZ/GYyA8VAzhAjjJyRD7GCBQ?=
 =?us-ascii?Q?EzX8fPmAwQWE0bM6VuwY7K2Ip5vgB9KkvgKHcH5o9rx3O1Iaag91JQyAIKrN?=
 =?us-ascii?Q?gEEOtXJmzf4bgNtutJhkm0Hqd6EvVnav6HwrtJReG2Blc3DDXTdlvE9GpAVt?=
 =?us-ascii?Q?rzbNDJt0IhesLyLp3Dm0wTQkCJpW6DtR6MKH+N7D7erzMRyDDhqNBGx8k5Rl?=
 =?us-ascii?Q?He8rtbuC5mirXbdP3CNV/9dm6EFokk7EEZW5wgxEk+vxkJnUXpg10ZgJgyoz?=
 =?us-ascii?Q?5efdGw4Wcgd4d1ujUXg4McjxPs+xJTg93HZF7ldOp0YxnO/EJJxpb7uGQ7Y5?=
 =?us-ascii?Q?HSPDhpGale1ppr84gZoBhtprr5yErDlxOQIIclGpbiqwkoBZXGYXLTrZQZwd?=
 =?us-ascii?Q?7A8QLHgSMah9xlHH6dtyZrlwwzUbwLRNgHnF2A25npO3wfzOOpx+23mmB+zF?=
 =?us-ascii?Q?/1Mb4q79wiD7dlAGFHiyZzIgJ3chLHJZC4hgUYjG396JcsHeoHzSsWdbYcUH?=
 =?us-ascii?Q?KDRy7Jzltz+/d+RmaSIGEIe3jOivsS0+3Aico+SKeaAz9Um+Vsa1BUTxkJDp?=
 =?us-ascii?Q?DclJWIFXuA7Ko9ejuO0djb03?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a79f3e2-759d-4024-310d-08d8e87c95e5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 13:08:26.3268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAH1DQSGS552HSXKkEjrKbQbt9qnXrYoTUaK+Vx2x3vIteaVILxqDDymxnkVnsMyM5WETs7q4t8j3m+W8mKn8ass467+Hz43RNaEeF/PQYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160089
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
 drivers/misc/pvpanic/pvpanic.h      |  21 +++++
 8 files changed, 260 insertions(+), 169 deletions(-)
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
index 00000000..0e90f4a
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -0,0 +1,21 @@
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
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+void pvpanic_probe(void __iomem *base, unsigned int dev_cap);
+void pvpanic_remove(void);
+void pvpanic_set_events(unsigned int dev_events);
+
+#endif /* PVPANIC_H_ */
-- 
1.8.3.1

