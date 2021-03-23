Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE13461CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhCWOsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:48:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52942 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhCWOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:47:58 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NEiUle082409;
        Tue, 23 Mar 2021 14:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=IOe/8yVFXJFacHMh8/jwRCNWHWZOmGc/37sICsfSAaw=;
 b=N7FSEbf/oH4TuEuAkpN6AQDkglIYary7K1zAd5YlHWVBgXWcurqkW/aglMfe1UKBn6bm
 yQIREv34Y46pdDd98VOiasu1c8FXqItL0UKyD0QShWl7XZmn+uwDZN+D6gOzIjL0UX8C
 2HSkFH6fApIXGXoTMRZnA1IJRrF7NUsuC+1Yw996W9gK0BsG74flxB8BQj1yR8icvpUJ
 B0Vfn67viGEkz8QnLEHjW0YZQjM9eCINSyhqKYWHf88PW8Gi66ya9sqOygoomQKgZsAw
 3oR5urSvCCL8otrJ4SPPjY7LKTvW9l4Bl+E0CQ6nPhtJOXFpcI1Wg/Zms67FWu6HiR8s JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37d6jbfdtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 14:47:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NEij8p126464;
        Tue, 23 Mar 2021 14:47:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 37dtyxhf8v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 14:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuUaPIrt0tOSCxkKTL0VIlvw/BMFfA9b5KZZ78bos9J+BKZha87hi87sB1XgiPTGSAg7Bd3LlLTaV67VZb0Oynh0TWSj8UG2Ey9MbxjKo2Xc0NREQ2KJqkUC+Qm0grdJ/JPVf2/JZtbVd8TOGKWvBuZuH3pKbCS/s/aCihEI/c79JMcopZ9NynO+B9IjUt4CO5dPHFX76hbgANpIHLHAjLT7VzOaE9GmOjnz4BzGBmxAhZmovaCTqnfD5HH3rceoiRg7YvLXBM0zfCQHtFMySd/V9XKTXAONUbtsMh3JzC/hHo2PYW7Lq63R1ffhXbOEWV7YUbgDWYb9jv2s+9R6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOe/8yVFXJFacHMh8/jwRCNWHWZOmGc/37sICsfSAaw=;
 b=CFi3elJG0MKFUFLPe+g5Zh9/vip4gJsSnZTJVEHGGej182/FfSsNxnaKn/6UcxMSaJRxrc+dO4hUOH9ygqSXCwb9dLlSkk7v6SfuwzWjgbVDqQYoTQO77aalmVkwJ3JBVdxgmVjIN3VSlJWcLqCV3/RlSq1Ey6KGwT2RseIr1FgjiZH6BFC+r+Toa75rpwLlwJW5g14jnshGObpznV+VIAaufHnAW9vJqwVaJXNz0yIVpawWqwDlh0r/mrclypJgtPzZ1I0vdCiOBr/9q6NYGhytfX/iKfe5KVyrVKFfNcZUERmth5/d117KNq2p4b0nt+C7akt810tW3NCdhlQSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOe/8yVFXJFacHMh8/jwRCNWHWZOmGc/37sICsfSAaw=;
 b=LBFiiQXSIBlzfjZC6YYRi0yp6y5WV7x9AupjDmVgp9Y17VvBMI/NHUkYwEXFkL2zlJYd/P94spwY2SCJoaa74Qj/rdfCSYA2lwqOqfHuC3S16habJ+7KF8QkBK60kzRiYmRSVOyhhzaNY3JdijkQhv3pin9J6Yf3oEocEZK5ovg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2304.namprd10.prod.outlook.com
 (2603:10b6:301:2e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Tue, 23 Mar
 2021 14:47:35 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Tue, 23 Mar 2021
 14:47:35 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v7 1/3] misc/pvpanic: split-up generic and platform dependent code
Date:   Tue, 23 Mar 2021 15:59:36 +0200
Message-Id: <1616507978-15661-2-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.201.25) by CH2PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:52::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 14:47:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0dfb198-74bb-439e-e949-08d8ee0a9891
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2304E7E3ADE087937958249288649@MWHPR1001MB2304.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3Ris5xRY+Bm6Ai+8z2vBdJX6+gdlW/9gM2X04heLrBMfxkCXPOsyH9VGiKL/xgoDRVQEFYK4P2UeKURqAeziNI01OfWoHHIdwDf+uecNrbiy6FRnerD1BPgBcnhz09ZAWyv8nEYYfI2mujxyOJn62SkV3S5MUe78DOQrK5NynLvrRwKQWKVtWc1SpmYWINUt+YJiLyRgQlcynBm8mrdhWN3XiZSE80Z92SKTqVGIWmgNSM9hRc4inMGlSqTqL9K/BaIeZ9bFgFS2Y8im64BQdB7HqUUFcld42b1daKvnf3lGMeWIYxQiu4NN7HSq0d5nSVDNFTDWADtFMw3VK6/xp/Y1muO3l76khcSIqY+hpveVh53NBqNXYTNzCoM93de2NY7VlMR4pK8kRdP+N9GQoa2MYT9ekOa8tgOOtAmPQW4YY2bWzoKQhR8g3tzsYu+1PWTXtQTqHqQKEjiAWfIn2dWYpOE9FH1oSsPJtPttatdV3PikNietKTwSvIgPg9TL2VQfGOcTz39MwckROGRktRQd2k+kuH2zCA8TnfjaZyfYLfwOek4aEn2K5zNAJMl+DogzhCzLexlihfoj67p4LowXyjpca/HiDwy3cNQDK6dCCrdRXQbdwzIaT4yJBIRd7q0hukx80WYXjV6S3QjKdDvCc6aVf/8RW7ZrEyBqQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(478600001)(6916009)(83380400001)(66946007)(5660300002)(6506007)(956004)(107886003)(2616005)(44832011)(6486002)(4326008)(2906002)(66556008)(16526019)(38100700001)(66476007)(8936002)(30864003)(86362001)(36756003)(316002)(52116002)(26005)(186003)(6512007)(8676002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CPzinuAYVrjHJ4i/JSTlUUJPzm5Gwh6jS7F6+nTA00QBkIQrca2ZVAoW9J07?=
 =?us-ascii?Q?L6TdclaGDmEd7bsJfQu5QMegOXJrwl4MSt52cbSNHcjqpxoK8PKTOaYD7PyK?=
 =?us-ascii?Q?ir09s6B5TOZKb/v0vFvt9NXYXA8gJGX4pV9YwJZhUmzKXHjB/y0rpmw5rRqC?=
 =?us-ascii?Q?lG4V38/Pb7W5+wVHCRNRKGvQIa/hRRqMai6ZsjaqlTpYtFmrApKAYMpurtdR?=
 =?us-ascii?Q?SW38EXYATdazqPQWZSSdOYTDP+mcxQkqyHkjKH0oi6Hw3gr5XxdpI4ZaMGPz?=
 =?us-ascii?Q?vEss6Xdx7J1RhZLAP6pjVZvbwqLJtAueDw12wrMT3J5+rV4kA4bQs0U0C1fG?=
 =?us-ascii?Q?U4Vnd13pD+KrVQ6sJTfwSHlG/EJNSiIy1kwu2KneAG7VTAfSS1Zw+d1EN5x+?=
 =?us-ascii?Q?4hvAoT8887uZz+iwdipOEtUCrXreWRdPGlpL6xPm2AWfGlscjlXr2ALEE5SY?=
 =?us-ascii?Q?3ssE2uTAzKB9C+X/PbMEq2rUdVFkqW8Rh4h4vetrfXv2FyAvjLr7k8V9bWXs?=
 =?us-ascii?Q?UBwhfdqAYCh9eHBVocliIZj/rZmzrCzk7pPZbB8cAqCyT4lkIr3HLYBDQWb/?=
 =?us-ascii?Q?qFrzGEjw3XzkO+l6bpa63LNWT1tHh+jvln99pQbQEYsHAZxHi5lr2lhEjWoA?=
 =?us-ascii?Q?UtD5iFXOUI82CgqyFINp4hTkJ+5ToqDO4d2sAWjYSf+NovpC+R9HFX7x1A17?=
 =?us-ascii?Q?/F9pKatGuVG3RyUQaHGjin1b+Fi5RVhTQ2RkLB6L6zY8NPV7brVR/udht5kP?=
 =?us-ascii?Q?lI/+mvjGPmyzI6eVnyxwVIx1m9/JuMgrg8hokFPxyD9KcuP2NahnlxKoQl/z?=
 =?us-ascii?Q?IEzjypebwWfti6JW+N9bzEydD6r7V93+QHSLL15rXiIiNtNPX4WMIxZdYxkS?=
 =?us-ascii?Q?CKxclQWAOrBp7zHrg28Qxm63GhUnieVT8BW/W/8YA0bw4l+izfQ9/FAP2JVo?=
 =?us-ascii?Q?Lcxb5tW5LK16vl194T4YFhlswR0MVHbQonnSWyVyDzjcmM/pRqz6qt9DmmrB?=
 =?us-ascii?Q?gGQtTexEVQP9R7eNuVMQvQsY50zez/QG8cSSAviOJnd5aDOl4tPkDfjSB6hF?=
 =?us-ascii?Q?E3J2mbOQFQH/2ozHdUdzIRpZWAS97iJs5YDZLhqc+jHM9cxrCiskaK1c4zDL?=
 =?us-ascii?Q?DeF8fnCvPN0UckxZKgGUlxMCTFpLQdC8+juC6rO8BdE3M6i0U/a5J49WVAOM?=
 =?us-ascii?Q?sGcuBIqswopYKG8g5WPt6E6h6MyNkNStRYUj8/Yd6P4kx0lCwtToFCqiWihj?=
 =?us-ascii?Q?w/9alVmANL6bwPfeRde+w758NFZTf8mHrga9iA8jiL3xFiRYrBhkkME0EcN+?=
 =?us-ascii?Q?C+eod0UUEAjVso1mrzKd7b4t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dfb198-74bb-439e-e949-08d8ee0a9891
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 14:47:35.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZe68G9RLtcJ8wE3A8NzCohMArIDslxytpGnukPuB87YZQkaAzw6Gdm6Q1cxixny74k1kKICdLzabsoCeojhQYLzAzf2eRut9HcShbljptQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2304
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230109
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
 drivers/misc/pvpanic/pvpanic-mmio.c | 135 ++++++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.c      |  77 +++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  15 ++++
 8 files changed, 255 insertions(+), 170 deletions(-)
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
index 00000000..4cb6f0f
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -0,0 +1,135 @@
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

