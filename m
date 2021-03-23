Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8D3461D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhCWOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:48:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55560 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhCWOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:47:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NEjRVu041799;
        Tue, 23 Mar 2021 14:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=n+PGh/Wc+L/bO5HuqYvoJ0c5AtlGxLMiY70FVMOhV4o=;
 b=UXiPFLLdMKJeupyLe5DKaGoxtyq55bzZlmAtoDTsxMoeVCXL7CykTrqfzuFj8MIGC/6e
 sxwUI0Jxk2lkrvswAHYd0Yl1R8LY8RjcxcxW18bZf0Y/QV8uE01SnSXuu9CFucsmxyWs
 s5JngY6CYckPuSCFXaOAP8sNevGBxrhfthQu4eGQcbtETm0Cs0pQq9A3oSEpd8mmNZKy
 kyui/5UdbLV8XxfONxqt+j88gwjt83vQ+jvAZsRdMCi3AyxDPJdQlTcrLyxBVscGE3JY
 VJmEFbaGC8e3LCzCViTRPOaRGQ1ZeEPa/xXSbMeKHbyb8WVo/SMopYjtAczvlaWONSyA yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37d90mf9sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 14:47:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NEij8q126464;
        Tue, 23 Mar 2021 14:47:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 37dtyxhf8v-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 14:47:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1GmaCr+jEhbuWAXfo2niU0nBoSViVTbQUt5midFioM/TnaIBSPR5SKZxs8n0O54fyYKijj3oGdPj0jbjzl3Y90FeZBiMMlDUymwVv/WFbIB8ZFBtLHvLB3bGOI2HBweqX0Tt14LZ+cZ6d/x3KG/nA9tgoXa7y19h0Q0i5Do1kxTVPAGuOuD49U8nHpXYTtoI/G1SsPgz/mAcaCgU1nIBfP3uAIfMrgm266m5bMOCkJWkPJGAXDXQ+0OZ8beo8d9BTJNpdZ1KYHDLaw/sKrUB0BVXJLj08aC5Lfcbp0DLeye/fiir9WW16z/Kl3z4sSxflJSZ6iHlqPwwMlYSjFxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+PGh/Wc+L/bO5HuqYvoJ0c5AtlGxLMiY70FVMOhV4o=;
 b=aXsNe3mfJ8esDR9BUQwYvoavcOUCis2eKA74F0xH5HtpCZtpajvewkCQ+Fo7AbtBHU9WqgTJNlJ0uqo9lfRQgB9zYR1FT+nad8OLzgzC+u/Ut1GcTv+uraHAWLJM0hDcPXmEicsZYUB71liA6lSZPD+D0M4aZzDz8mYo/ihu5Dx8cCJvkTjyxWvhEMx7xGvzN/so7eQHMRxsi/0TFOgr4NRYyb6UTsjpGO+nhB53LBdJa2k0thws2Pkq6JJGmL1PfGlRLawiaAwe0+cG3tJiALupMl/ABAfHT9WzmSOrY0xGHikQGkJETKso8Fo0cvznOu83vJfJaxKYKEqjAyzYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+PGh/Wc+L/bO5HuqYvoJ0c5AtlGxLMiY70FVMOhV4o=;
 b=m7M/tETV/nVQjonJTzSFBcEZwb02C/3pAK56zFAYPRa2BJ8nHMZO23yEyJFfeGnFZ/WKC70D1MPSrlRYT58DsnCsgpHDdVvYtdHAPz5Ri6uPr6NhlDINlqYy3K02eMnEgmaBzCZSC3tpYABrAA2YYt3oRAfxNNYU2epAyBEcHNw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2304.namprd10.prod.outlook.com
 (2603:10b6:301:2e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Tue, 23 Mar
 2021 14:47:36 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Tue, 23 Mar 2021
 14:47:36 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v7 2/3] misc/pvpanic: probe multiple instances
Date:   Tue, 23 Mar 2021 15:59:37 +0200
Message-Id: <1616507978-15661-3-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.201.25) by CH2PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:52::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 14:47:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 056374e0-7bca-4f3a-963f-08d8ee0a9953
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2304FE924CBA34551BF7496388649@MWHPR1001MB2304.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ellToB+ZkZ6OY+ZH+Op53vZDEWb9+VNkHinsDsa+UzC8DTVqDhIHU6qMiuqZAS70JdvMXT9fMq8JiPePbAPoEKNghesNAw9t7K7dvti98fQRajGLG5Ed8GyL5VPcUdcrLhPSE055fLMGQLcjeo605/jpXBcH9lA8l2O+QtCY6UZKeTFwood2VHtro2OEGnCn8Nil04/QXrKWNeXbRZ8N8jSWyJcmX8FUDIrWcoqJj2UGcbd8Hd2pLZo4i88moiESuv/VWtBNSPFO8RI1nfYVW5v7FqpRbULdOo0m0qHfbjdLb2fnM4liAvLXnl3xuG2dNz9bkXCCO5ywAzZmYXEJZhXsh0Kabpg1rU1sN7VyTNhyxhdW+7fEgaHs0GRen5Y9Rt2Ew1z4KVYBwk3hj/2ABXCn87OKP4QBn4HJx7VWokGvbEyMBjfub3ihI+LXcvhAB0DP2rxvcaDP0OLkTjjT8ClnhQjoQ8fzodoElyIkK1kBDn8tHSL7onrofNpl/ZNpoZEFdBzBDqo1rVXLKLYnesfK2wjE/nR9QQqkaDAl0oXmJ48oWZu7HhtHgD370xMwgcA43htKtlXi5+VZJSuPWMgjGL48xiU9tDZaqs+/uQf30uCZbt2tgar+hqVAMJHweuw6prKnr2QqmX6Vy2pcDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(478600001)(6916009)(83380400001)(66946007)(5660300002)(6506007)(956004)(107886003)(2616005)(44832011)(6486002)(4326008)(2906002)(66556008)(16526019)(38100700001)(66476007)(8936002)(86362001)(36756003)(316002)(52116002)(26005)(186003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N8EVbMNkqDJWY0ArLzKewqrB/629oeMM2kDhDFZnJ2SDMgTEVt8fD2xHiVqO?=
 =?us-ascii?Q?DoCd47xG74ieP5CDZoauOv5yQa/PtiwdyjSSxpYVIU90whx90vEgV8ivgRQU?=
 =?us-ascii?Q?Ve+xUnYWZAQq4Z8Ja9OSKvOxPG78JPBKjPzOs+7kejVAgXH0e199ukMaJLkG?=
 =?us-ascii?Q?9PxLCN9y9MUWYMtB+phv6qUcMv+XJYC3WGQqZ6BsW0mjDLHjBUbP/j8p+ZPy?=
 =?us-ascii?Q?9Cd5NqSixw+qeHbBfBl2ApkVVm68WkkG8VqOnomJzQdyLLFZ549XmuMC7DDp?=
 =?us-ascii?Q?X2QGFtrrL5WTjaQ0mEkoqN2+Lsy/ao+k3PY4IvJNDqikv0+Y5PjbjS6a9uEC?=
 =?us-ascii?Q?OrtngfR8QluhJOWDhHW3S54vr3V0jesWatRJwymDLZlWOvWL1EsuM8eS3kcT?=
 =?us-ascii?Q?8zKPixAYWZExvNYNMr4RuTx1YlSJCrVKdF6RFIwXSQcaoh0nOBUXkvrBx5Bg?=
 =?us-ascii?Q?kyjnCic5063u/j0xf9qMcVvLgedE0dD88J4TnRliLvjasdPUAZpkmpA/ryI5?=
 =?us-ascii?Q?1nYNZ11Q7pJ87UcHHleYkFZmxnX2F1adfZqmS4kpUDB8Wui13OEZXQCPFSgH?=
 =?us-ascii?Q?kh2jQzoW4F05TRExBg4Iej3WtQbcFUGNWpo2oZlLNZyqbrfmhbxfxCRh5Gx7?=
 =?us-ascii?Q?hhV7YwXU/tS655OL8Z0abh5pVKbkE/Yh57SwKYXYe/ALRDfnWW2hpyDIerbH?=
 =?us-ascii?Q?2kFfmNN1MyeXj40LNf49uG0fGsdaLE6+J8WjXzf0cA4chOBqXFPRyIu7t7sV?=
 =?us-ascii?Q?nI+CT6rmJHet7Osg5M03FAhMwR9zFrJIL3EdQC1tshJzbvCGE8Kn7gSXAQ9g?=
 =?us-ascii?Q?Yp4NE4H0kgBObe8iqfiJUEz1rQ8vMY9vr+0Wyg0JHf4WsAQDFkq0dzOGKWDE?=
 =?us-ascii?Q?lTBrQqwLjsUDvo7J2GaMeHq5spG4CqDv3kGBfZwRVILdbKVagyEiVVd5MYuL?=
 =?us-ascii?Q?Oic8kB7Ehcn1ySEH7Na3gq63eaTCbJtt69GjUCw6lC/FyH00BNdOuLXXsm2k?=
 =?us-ascii?Q?cqJTv+4LglkwzU+Fiyf18yAX58Q4sScUmkEPQ7eRYum/j7CqLyGKLuC5RR7H?=
 =?us-ascii?Q?Eff40+/7uWJT1g+3Q0JfeWU6E850/5LCkrcWszTn1PmfObDMKRok49kJKv0E?=
 =?us-ascii?Q?m52072ilLxSRvVXKruHVw+Gllkdu2fqZi5XdEftGN3H6dhp9OBGYm73btBY0?=
 =?us-ascii?Q?PpIvUiPF5paSr3sHpB72UgyaKpTO9cg9MmIbYwmw4XSAjP5K660VqftkhlEj?=
 =?us-ascii?Q?G2CmDPy45pMeSXuAWcMSZUQXPzUZYarUckSYEuTkuFB5399pB99UyvrfBfR8?=
 =?us-ascii?Q?chpae0bOv4ssouLZLbafP9pb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056374e0-7bca-4f3a-963f-08d8ee0a9953
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 14:47:36.3869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWnlw8evXHQED4bYsbw2EUOXh90CNLiBl0HC/H/2d8JVhN8k0VH8RdCmkTee0KWccUtoGu5G0StRKPxCn4GGOg29gsFjzrJTUoPoNoJyt9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2304
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the mecahism that allows multiple pvpanic instances to call
pvpanic_probe and receive panic events. A global list will retain all the
mapped addresses where to write panic events.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/pvpanic-mmio.c | 41 ++++++++++++---------
 drivers/misc/pvpanic/pvpanic.c      | 72 ++++++++++++++++++++++++++-----------
 drivers/misc/pvpanic/pvpanic.h      | 12 +++++--
 3 files changed, 86 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index 4cb6f0f..3dd5064 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/slab.h>
 
 #include <uapi/misc/pvpanic.h>
 
@@ -23,25 +24,26 @@
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
 
-static void __iomem *base;
-static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
-static unsigned int events;
-
 static ssize_t capability_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%x\n", capability);
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%x\n", pi->capability);
 }
 static DEVICE_ATTR_RO(capability);
 
 static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%x\n", events);
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%x\n", pi->events);
 }
 
 static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
 	unsigned int tmp;
 	int err;
 
@@ -49,15 +51,12 @@ static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
 	if (err)
 		return err;
 
-	if ((tmp & capability) != tmp)
+	if ((tmp & pi->capability) != tmp)
 		return -EINVAL;
 
-	events = tmp;
-
-	pvpanic_set_events(events);
+	pi->events = tmp;
 
 	return count;
-
 }
 static DEVICE_ATTR_RW(events);
 
@@ -71,6 +70,7 @@ static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
 static int pvpanic_mmio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pvpanic_instance *pi;
 	struct resource *res;
 	void __iomem *base;
 
@@ -93,19 +93,28 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	pi = kmalloc(sizeof(*pi), GFP_ATOMIC);
+	if (!pi)
+		return -ENOMEM;
+
+	pi->base = base;
+	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+
 	/* initlize capability by RDPT */
-	capability &= ioread8(base);
-	events = capability;
+	pi->capability &= ioread8(base);
+	pi->events = pi->capability;
 
-	pvpanic_probe(base, capability);
+	dev_set_drvdata(dev, pi);
 
-	return 0;
+	return pvpanic_probe(pi);
 }
 
 static int pvpanic_mmio_remove(struct platform_device *pdev)
 {
+	struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
 
-	pvpanic_remove();
+	pvpanic_remove(pi);
+	kfree(pi);
 
 	return 0;
 }
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 11d029c..ac41edb 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -14,20 +14,27 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
 
 #include <uapi/misc/pvpanic.h>
 
 #include "pvpanic.h"
 
-static void __iomem *base;
-static unsigned int capability;
-static unsigned int events;
+struct list_head pvpanic_list;
+spinlock_t pvpanic_lock;
 
 static void
 pvpanic_send_event(unsigned int event)
 {
-	if (event & capability & events)
-		iowrite8(event, base);
+	struct pvpanic_instance *pi_cur;
+
+	spin_lock(&pvpanic_lock);
+	list_for_each_entry(pi_cur, &pvpanic_list, list) {
+		if (event & pi_cur->capability & pi_cur->events)
+			iowrite8(event, pi_cur->base);
+	}
+	spin_unlock(&pvpanic_lock);
 }
 
 static int
@@ -49,29 +56,54 @@
 	.priority = 1, /* let this called before broken drm_fb_helper */
 };
 
-void pvpanic_probe(void __iomem *pbase, unsigned int dev_cap)
+int pvpanic_probe(struct pvpanic_instance *pi)
 {
-	base = pbase;
-	capability = dev_cap;
-	events = capability;
+	if (!pi || !pi->base)
+		return -EINVAL;
+
+	spin_lock(&pvpanic_lock);
+	list_add(&pi->list, &pvpanic_list);
+	spin_unlock(&pvpanic_lock);
 
-	if (capability)
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &pvpanic_panic_nb);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pvpanic_probe);
 
-void pvpanic_remove(void)
+void pvpanic_remove(struct pvpanic_instance *pi)
 {
-	if (capability)
-		atomic_notifier_chain_unregister(&panic_notifier_list,
-						 &pvpanic_panic_nb);
-	base = NULL;
+	struct pvpanic_instance *pi_cur, *pi_next;
+
+	if (!pi)
+		return;
+
+	spin_lock(&pvpanic_lock);
+	list_for_each_entry_safe(pi_cur, pi_next, &pvpanic_list, list) {
+		if (pi_cur == pi) {
+			list_del(&pi_cur->list);
+			break;
+		}
+	}
+	spin_unlock(&pvpanic_lock);
 }
 EXPORT_SYMBOL_GPL(pvpanic_remove);
 
-void pvpanic_set_events(unsigned int dev_events)
+static int pvpanic_init(void)
 {
-	events = dev_events;
+	INIT_LIST_HEAD(&pvpanic_list);
+	spin_lock_init(&pvpanic_lock);
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &pvpanic_panic_nb);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(pvpanic_set_events);
+
+static void pvpanic_exit(void)
+{
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &pvpanic_panic_nb);
+
+}
+
+module_init(pvpanic_init);
+module_exit(pvpanic_exit);
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
index 3abe15f..1afccc2 100644
--- a/drivers/misc/pvpanic/pvpanic.h
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -8,8 +8,14 @@
 #ifndef PVPANIC_H_
 #define PVPANIC_H_
 
-void pvpanic_probe(void __iomem *base, unsigned int dev_cap);
-void pvpanic_remove(void);
-void pvpanic_set_events(unsigned int dev_events);
+struct pvpanic_instance {
+	void __iomem *base;
+	unsigned int capability;
+	unsigned int events;
+	struct list_head list;
+};
+
+int pvpanic_probe(struct pvpanic_instance *pi);
+void pvpanic_remove(struct pvpanic_instance *pi);
 
 #endif /* PVPANIC_H_ */
-- 
1.8.3.1

