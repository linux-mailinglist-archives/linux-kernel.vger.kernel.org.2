Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD0347CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhCXPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:38:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55410 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbhCXPhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:37:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OFYH47030447;
        Wed, 24 Mar 2021 15:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=9nCXxuS1u7zurigJbGkJOLeW8AWe1OaGbTJG8CVZf/c=;
 b=byZYdHfUdfdcbWN7S2Pvvtc8R+xq48bvDCUhwUKBTdpVsk1pc/P4NoqgMQmC6le6rLRB
 rWlP9AVX/V2h4f4F3dYIWb1eQm5pV3q68V60b04rbujKgCatwexiwvpkmXnnFXj2D1T0
 wEr9BEh185fdy5EzO8Mk6NkXbmx87jlKRqPW62dSILJiWVQAoGnjrZzrJqMTUcaowXUb
 NXxiGS6DQ1Bc6EmQoBOl+XMIEE7RPPWamKcuZFI3hRFLSH0RAV1wXqNPj2dXYIaTr5hw
 36ptV3dy35yCpQRNj1eWSTx3WA6ZTD5tw6CiW+hSftKcfb6QHbISm6W+SeYlFo/DHYYK 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37d6jbkan5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 15:37:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OFZEXV157496;
        Wed, 24 Mar 2021 15:37:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 37dtmqyg13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 15:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eL106vlfvAbEugbvtik0FeLMQPgh5EzH+O2aWYUWv80IWpmU4r0oKUiq1kL8+UiTUBMuU3bMlRCo7KQkZt8YycA3Rd3SUs6rENuj6KEOpybIwwg7keYrprqudRHVqkZAw8TDcjasi4If1TV6SLhwmTQh+oi1rFXFZWq1aD6TQ/AKhIwEdEFsiLd4D2cM6urU8KPaES6FM/M69fesQIWsbTbYvazVCkpfAkbuovCt17kYyWL+1JmrzQNWHfvlOvfNYeco1PAfvUZXida79bZEuW9oYa+If0Guut5OTXZpVUVTZs1t8GYCHVru9c7xSer5iK9v7V/MJ9CFjijEs2nBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nCXxuS1u7zurigJbGkJOLeW8AWe1OaGbTJG8CVZf/c=;
 b=YU8UQ6I1sa7ZzH+udWv8pZhEiQKcJZxaSvjjcswZzQPoe0bsQuPPTQGK/PsD1OJytWix4yVzzYPb2ie04CWzj3aVwPh3NH5hlxBeAn7koCsFJ/b7Qj4hUIZoYiXKfS7dfjGULPNSZdql3zcjtJFGEmaJj/yAvFj+EitP6AbhKX3+bgSiOlxHwAvA4hegZUmBXO0G04f+8rsmDL8fRajVXI29VOuQYo86Gbri14OZEUU/aelhBAcbpzbC4zH9F6BtYZxf9MaHiINhRA8jiH0ErIAeKrfklY/B/kq6BLIjD5Y8eudjaEuR8otpSDkqjp9PJXk5iiL3tr8hZjTa8xmoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nCXxuS1u7zurigJbGkJOLeW8AWe1OaGbTJG8CVZf/c=;
 b=J25/Xa0jd5pTZL/Hvb1PZYt8fRnjfuUIPKitRljBelOyafTNbVm1wiVFE1GOaTBXjva8JEteIhaxKWBKXKjoP/RG/NBK0LYpJB4dlbbvK0kJ9et5qa//pNuYDIaSid9vi8bccPEzmvBRkgdQ1D6oy5A5mtmCqzLqSKTOY9vU4AU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4579.namprd10.prod.outlook.com
 (2603:10b6:303:96::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 15:37:24 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Wed, 24 Mar 2021
 15:37:24 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v8 2/3] misc/pvpanic: probe multiple instances
Date:   Wed, 24 Mar 2021 16:49:15 +0200
Message-Id: <1616597356-20696-3-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.201.25) by SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Wed, 24 Mar 2021 15:37:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c347bd0-4bc9-43c9-b0e5-08d8eedab8e5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4579127BC01F2CC2EBE85D1088639@CO1PR10MB4579.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfvYC6xIxKmPPVsX0K3Rs+F4ccoCSeLxb7JAxeMGfQTb3YXy5zhhu4uzZqp4egF0+71xA0nIQcInAATRx3AKDlmlvGAV0qO+Z7I8r/u4XknPyoqmLKqiJvjDiCcPypvDM00UGYH1yO/FqPfBmmN7/tcN7A8ePzqKEiG/CkJZ4iRAcJMo+WaQpMNZzlOFde0WOXTH0XacSoCBbcV48OooSPj3bGya5qIyGU6nkMjj54n/boFaCo2xaA2rI4ad2p2ON3IUNSZY5kDXy4DRtXa7CymgHcCtwLDFyqymKTErgRg9rJLdazLXoI/3IfKnzeHn0CIb5NJIyprShzquDNoz2auK+x1H2VD7El5sOgjnEZR0qCxZ/cZUdtUqfeiy5AFbdoMsnCpJn2oFZYyU8vb2XLyovPop9VVxt1BTj0loVdf7V/OXG6vhYKkE4GlhVpMvYlXkYYtv+gM3TY/kimdzG1JGFym54qeH64MUCXLj7MteewNY6BVw9DqdMkzR/RCBDQdZB47iZ2lWPb8SWy0T2zXbFOygmgRA43mS4PDkpMD/1G/nof7Vi8BMptrX3fedwHWupx7tuO0ltSp26OxAkb8emmYdKFg0EXIo/q5ZOc1rGApfoZeVPkZea0y1Tqu+v6Zah4uFzPVNaM0O/jVLUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(956004)(107886003)(83380400001)(16526019)(2906002)(5660300002)(6486002)(2616005)(66476007)(8676002)(478600001)(6506007)(52116002)(8936002)(66556008)(36756003)(6666004)(86362001)(6512007)(38100700001)(186003)(26005)(6916009)(44832011)(66946007)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KaMzLuXECv3qe33zn800WDfPw+NJwINHPUSr7sCIv7HxonhVyTjLaemTefJW?=
 =?us-ascii?Q?P/jXIce9fp/9k2xPmAVP9PMudx9oKMukc2G6/SHSXT3LCyd1scK172WY88KY?=
 =?us-ascii?Q?c+oaCc8Q10JCp7jhyPrxHuQbwDb5KXvS6fVHTFKy1/9Y2m493zHk2VMqUUIw?=
 =?us-ascii?Q?LeHPEh2eYrhM9KZk+U3M/MtmKaZ/bvmDmtD4Q2e7bs2Pejw4jDCLOUUi8exM?=
 =?us-ascii?Q?KWEscjDzuse/1Cpa0V/KDceI3F00PLix2HLX3i2xeFWJIkCGYKwWewa8K+Ad?=
 =?us-ascii?Q?qR4bpeA0tq+6EICj9zEaZOmOCNyDBBXE4abXmA6oa7oS1AbuB964Yh3OGuK+?=
 =?us-ascii?Q?WA6sZTQ/3ymGALuhqNm1I2X6oFzFaFBi0rFPcYF3qj3uyX5u4P8oCosnu913?=
 =?us-ascii?Q?WPEIMohIT1sciZ7dNcizfH9kdwjkWa4AbtTSktgdN7fJfo7IxUj83B3gPZx6?=
 =?us-ascii?Q?p/sL+hkgCxLzKomD57WNUcSjnPwq73cEwZKgZBObjBxS0kKCagorC+IOsN5W?=
 =?us-ascii?Q?Kgiro6xa0s1b2vIMvEzn5rMt7GxMFPKgC2g/PlUMcViqTm0Wz3RT0E0UCKoo?=
 =?us-ascii?Q?BHYu31Mf2NojYjBzY/l1eSMuSfQtWB8TXO5CuZ5ky1dCroDZ7fyLdt13vfeF?=
 =?us-ascii?Q?3vGeayKIZaVAul32k6ItPDxjx1whQcnMNhg/Nh7/4nf+EyyOGNZ0qRoFS5Kp?=
 =?us-ascii?Q?3gOKVRE/9CUK6ns9LrghnJx5f5/ak6gHoKIeaBXFfAneM0lD6KeIzOCTzvag?=
 =?us-ascii?Q?B0AzKfgKLHJIVB8vya92gyMwi+Oxw/iWPDgaAeAPzoUyTsM4nfb6NYzeFW5F?=
 =?us-ascii?Q?FuykSAjOS1lb+ovpNmfZgXC5uvHedzGujv5+eC3nZJ9ea4iv0z4nhjalpT6B?=
 =?us-ascii?Q?7bKaacP8HWZ4bCVpDWUS5ElTMwR6w5tlODx/6MHDqWwJr+N6gIzXo1wt6g7K?=
 =?us-ascii?Q?w+oLJlADkwyx9H17q1Rsy7K6H0jJjue90Q6yrIqdMNKc0bAlzXyC/OuXY1AS?=
 =?us-ascii?Q?IFHrNjaHUSl1McPWqy0SMF6AO9b05xs0V/VlQcIiebuxtXCTd5N6Cr4N6mj+?=
 =?us-ascii?Q?11Vf3n1vJkK3EtaeG+fm832H4cBw8n9BD+GOwshKIrK6IwE9Z/ovjh5DBRiw?=
 =?us-ascii?Q?A10S3bdNG5vvG8z/FZo4YdFbpAOJpYM2anoUcFX0c7rQX9TnQQDePHMUHvCX?=
 =?us-ascii?Q?n1UXXvwMXIhlMX9DeWewtNJRzKu/q1JYUA0YBNgGtI3PqWaIK7BSoxjXIljD?=
 =?us-ascii?Q?e3U6/zXKxIyl9emKurYlDMB+MTf75ATDxpPI/xSCk7/qUPfi0a3IhhXaKJqS?=
 =?us-ascii?Q?8e/RjRkdhfPYIvt9hMGEqlGT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c347bd0-4bc9-43c9-b0e5-08d8eedab8e5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 15:37:24.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHmaKyzNKVrNs8ZUl14i1NBValqFjHNZYy9r6BE1KCC+xSHnm0dWTJhI+RiKt1bRF8ut7NLSe4F8Yi/s5o04vtDXQiJT1OEV7v/hGl65KhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the mecahism that allows multiple pvpanic instances to call
pvpanic_probe and receive panic events. A global list will retain all the
mapped addresses where to write panic events.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/pvpanic-mmio.c | 42 +++++++++++++---------
 drivers/misc/pvpanic/pvpanic.c      | 72 ++++++++++++++++++++++++++-----------
 drivers/misc/pvpanic/pvpanic.h      | 12 +++++--
 3 files changed, 87 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index d7bf7db..4c08417 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/slab.h>
 
 #include <uapi/misc/pvpanic.h>
 
@@ -23,25 +24,26 @@
 MODULE_DESCRIPTION("pvpanic-mmio device driver");
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
 
@@ -71,7 +70,9 @@ static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
 static int pvpanic_mmio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pvpanic_instance *pi;
 	struct resource *res;
+	void __iomem *base;
 
 	res = platform_get_mem_or_io(pdev, 0);
 	if (!res)
@@ -92,19 +93,28 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
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
index a9605f9..804099c 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -14,6 +14,8 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
 
 #include <uapi/misc/pvpanic.h>
 
@@ -23,15 +25,20 @@
 MODULE_DESCRIPTION("pvpanic device driver ");
 MODULE_LICENSE("GPL");
 
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
@@ -53,29 +60,54 @@
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

