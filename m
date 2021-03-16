Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA233D49D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhCPNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:10:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41578 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhCPNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:10:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GD4521123841;
        Tue, 16 Mar 2021 13:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=JQb0PZT9znVyhkNd47wP05cCaF3CIzc6XBZ50Rz+9Fs=;
 b=PFf/lmj3OLl70u4IaL2//ILqwBomF8kxAZpiSL4zIhatYRx4labQk6u2Ie0VbS6qkN4H
 SVL5zSpbBLpMB6p53B93Vum+hoI6aKrDKCp9sUcCIvOx1GN8/o6WBk5HXPKRR9E8VoLB
 vYqM+SzgH8WGs4u2nNqITxk8sBnEkYn0b5JZX35x/1EwEFBJNWz8+N4EQiRgal1pe1Bl
 FLD+V0QEX7kTKb0uej10pOzHnxkNaTiKM59URxIyzTXVE88krgeeFheQ8YvF13kSvXSk
 YfIly/xVUncJI+0GOgC/ybD7IEjAV76ayciVHLmKJfIF1+4RtEftq42TO1n4MkJFXnOk Ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 378jwbg6sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:08:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GD5pfr091066;
        Tue, 16 Mar 2021 13:08:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3797b02470-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 13:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeESUjXUlQlw5QDWjHwGsUghDtcnUKAYhagU366B9dFSDnwSiUpp5L605dBs/+ss8GHLUO+pLNV2i9KAZVn6NWzKYGWaMLPVdtqkX+q3VyUOVfDY6Fy9NQfL/gufyFPVoLyOoh3Y8IiYgnLictIlE0XOR9OUR6ybH8pmyNMU2uOMXQvD5Zb0ESeFbqpb+VFiy13Jn9kOT3J58RTkJ6sUQj3eUf3qS9VeJXNE8DFki4QVkoWia/rI4liysFLDo/e7Ag68lMIumCCLgF26p9qVVlpRlFcgMkFwGhDOxc89Dq0X42V2mB6PMbY2/jr0osNfmQSt2yB6tcrvpXPXGzI7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQb0PZT9znVyhkNd47wP05cCaF3CIzc6XBZ50Rz+9Fs=;
 b=LE4rGW7jlc/ah8IxitEnihsG+69jN8bNxhI7o+SBgoV1uyi8+bRFOfxuILs+2VT4j/AFQO/BK1Ff7e+VNwZAKJApUJKb+cKWJkJXf6TF3puLUsnwQTpZWl4fQ9ubVbIPOnjA/as1s199Cn6dcENZxzASTHAa/IX9Y/TxOWh9c2Ez9ey/93lKSKTFZO3PVVycsHPH0qG9T1vOlNm64V7Wp85eWedAe7RXAsWO4pkz8HmQu5XWsgQHgJUCM9GAlJzQadZ2YRSfEJGNDg4Py5j12s0ILX5jFTsOWlnOO0B605TzvnfMa7FZ8Kf28EJ6b9OFSF8LydzoPzNaKtu47uKZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQb0PZT9znVyhkNd47wP05cCaF3CIzc6XBZ50Rz+9Fs=;
 b=hk0x2OnyHVJwu5geoAxpsx++JXI2PWBJe7+aPgMXZc2lAQm46PeO+WnKjn310Fyy5yseg4xXckNotUBCzc0YuXWJGbUrU1k24o3gYE5vmSZf/5MqBVvNKN/7RKdK0bT1HgbmGXkSESfJdVlEyJ4AjFYY8Mn6S2SvNyOXpgy+YmI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4435.namprd10.prod.outlook.com
 (2603:10b6:303:6c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 16 Mar
 2021 13:08:27 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 13:08:27 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v5 2/3] misc/pvpanic: probe multiple instances
Date:   Tue, 16 Mar 2021 14:20:28 +0200
Message-Id: <1615897229-4055-3-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.200.25) by BYAPR11CA0045.namprd11.prod.outlook.com (2603:10b6:a03:80::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 16 Mar 2021 13:08:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c1730f5-798b-407e-aa74-08d8e87c969a
X-MS-TrafficTypeDiagnostic: CO1PR10MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4435E3636A6BE904B9C7F33E886B9@CO1PR10MB4435.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+8IHUKFwy6J6qmzzJmNh5y4nEggb5gWe04qfRxKXtaa0QUYsItjVKbhX4brH97JBeeuXdN9iq24XlM1DRrutNSiAPWFlU5vL9PtkL4Y9cHGYA3NGKcW02oku0XsMccX1tmy9zIRYvsQ+6Vbs4m5AEWY6Ni1BqXsRFXcgTufpzHhytomqrrxroaP5vBCsLdSIw11dYCEW+QvarA3U7XSf4Y//bhL9aGtFCR8kldMVraqMNPW0+qiPdUkIkpsZdNU051zPLKnLdmHRoqpwTe0pgC9s/IfrMeob4itCXfEP6FjJTcl/27+whR1Pkb3w2XvMcgO65jkDFxrQDXjLjJ+nO8zJ8m7fcxIFTvC/2XpWjzBHKvIvUP/PEOgolwMnjCvf2SdZay8K4bDLdneObJbWuHaRqihgGVElFSN4x/vE0IeH4folQL+uff0ZkL+9ZhqTygK8qvsHLJMWE15tyY9DJybmt//05XsgbKmDqp/uhcWvRo8UXdoV0+b6/XiBfO5EVNZ+k3mt0EGNRPhoAcClIN/Ouaop7/+2s/LvLDEORWpogiohEwRI34r8M77r8f3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(36756003)(2616005)(956004)(44832011)(8936002)(6916009)(107886003)(83380400001)(52116002)(6486002)(186003)(16526019)(6506007)(66556008)(66946007)(66476007)(478600001)(86362001)(4326008)(8676002)(26005)(5660300002)(316002)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nkpr4AVqZz6uj7uDKsT9j4QTiZB454PMUl3h0ylYSxD1vNkRZFswVIMg7IFy?=
 =?us-ascii?Q?MoTxcEB5xViTihq6JfNTkNG50P4NTr+Aa2uLE2VvZ6cdHFAleRUcuOeP6jlG?=
 =?us-ascii?Q?c5zIBzpRWy+LpAXKaRHP6GlX6PmsioUk5X6naR9UvYUFlAW5JJF2PH10uL8n?=
 =?us-ascii?Q?C5sqNJ8HX3MKbiMgyR619P7/NcGadVF6E0mp3eGrydfk7Y+dnZZ9jELjFXbZ?=
 =?us-ascii?Q?NP3ciSAlEcP/efIJexyIDtRH/uXab7wrDUrvEqzOUFP5kpHvTE6vuAU4I22G?=
 =?us-ascii?Q?05DcaUxOvZsPvqpk1o1QkVAEPVoxmiVwz3sPFYgTHlVGgDQgM2/Oc5Id2ahG?=
 =?us-ascii?Q?gDOPPkrIX0FhZUqnLIjjbbsL9MmVDst91efs34eS1uYY4smxDwPk4TzvpSkp?=
 =?us-ascii?Q?BBM+vRP8GQTWAEg2qwqadrPMZscEddkx2KotGv2WKAHzjwV4e0qpXyLqB8qP?=
 =?us-ascii?Q?9QeKFJvHOURPAJ499R/GQtzlRma1AW8fL3slmHfLg7hA3jkkD4RZtQZloa65?=
 =?us-ascii?Q?hciCau9S4J+g4uV0QRqlrKJeRPPlGAfS60kMDkAaWW5XCp0nR+EfATJ4VZbD?=
 =?us-ascii?Q?g9Q45FB9oX3Kz3FdzcVEV0pdRpTkNAyQMpU8GKZQKtt8IJ6hGry9QneBENIO?=
 =?us-ascii?Q?/60SvlvI3CYv42+MMcSgjyorg0dKyroOPeRgexMCvcDqcXeDkCxSLgDJNhhS?=
 =?us-ascii?Q?R4FEUvzNUWdaJE8Key2BwIr3Lq834R6Nm55FLORd9yE5t65IB78lSWP+KWNf?=
 =?us-ascii?Q?Mx/4rR1dPUAdi9IOfHadMP/xJ0uzaex9jJpVARe90q/dxbGsNbhvd6DeVg9e?=
 =?us-ascii?Q?nOICxuLXEFq39w+D06f8RrdzdjZil0eLYSjp2HCl4WUyyHN/q33YdtwTct8j?=
 =?us-ascii?Q?WBaObQZDy/Y/AyS9ZtoAuJCE6MjnXf4RZZhOhfb6wpKMwxLZAZucEWc2YYJH?=
 =?us-ascii?Q?jTC2pEIdPROmNitVdOZ5Mq0q5QKYYwEy58nXnfbUQPqeWrxEkQJlHc79P483?=
 =?us-ascii?Q?iVXu6SOBBdJW0oK+w6EckpCiaK3xJxjtk/B3+9PXNQXyztUJdZzD45WCBXDP?=
 =?us-ascii?Q?9lMjuZkqYySEjdy+rKOGrOnh7/tkcLdItkhgvrqoYj6OT/whylxbYZIHlCZD?=
 =?us-ascii?Q?rWyPtWPvBT/f3s+m+3OTU1F8M9Yh/fHuH/lNkG34RJoxOrbGrZdLrTW8Vpve?=
 =?us-ascii?Q?nWvww2PuIGCBCe+MvSPDnsBgTeQ4H352Jmw/JCerY/ltiDFPvntxBJoHJAZF?=
 =?us-ascii?Q?O5Hg2xPpkJi3U9ho4Fpx1GMn8PY35kjK6ECU8f1NH4v79lP7U1jZ28tWwm04?=
 =?us-ascii?Q?dTf0nZv0EkIFVQ7A8DBHOgak?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1730f5-798b-407e-aa74-08d8e87c969a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 13:08:27.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLHR1Ym74otWLY4D7ErVP64NBcnwekB+GAHnA9+sX4Z8O9hp7hpZ/ulNS1GKh+6UsJdWf9HpNbYFyjAQnET3h5+lYJJK/XeRpzIj0QR513I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the mecahism that allows multiple pvpanic instances to call
pvpanic_probe and receive panic events. A global list will retain all the
mapped addresses where to write panic events.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/pvpanic-mmio.c |  11 ++--
 drivers/misc/pvpanic/pvpanic.c      | 105 +++++++++++++++++++++++++++++-------
 drivers/misc/pvpanic/pvpanic.h      |   6 +--
 3 files changed, 92 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index 801d892..62ab8d7 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -54,7 +54,7 @@ static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
 
 	events = tmp;
 
-	pvpanic_set_events(events);
+	pvpanic_set_events(base, events);
 
 	return count;
 
@@ -72,7 +72,6 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	void __iomem *base;
 
 	res = platform_get_mem_or_io(pdev, 0);
 	if (!res)
@@ -97,17 +96,13 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 	capability &= ioread8(base);
 	events = capability;
 
-	pvpanic_probe(base, capability);
-
-	return 0;
+	return pvpanic_probe(base, capability);
 }
 
 static int pvpanic_mmio_remove(struct platform_device *pdev)
 {
 
-	pvpanic_remove();
-
-	return 0;
+	return pvpanic_remove(base);
 }
 
 static const struct of_device_id pvpanic_mmio_match[] = {
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 11d029c..73a82d9 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -14,20 +14,35 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
+#include <linux/slab.h>
 
 #include <uapi/misc/pvpanic.h>
 
 #include "pvpanic.h"
 
-static void __iomem *base;
-static unsigned int capability;
-static unsigned int events;
+struct pvpanic_instance {
+	void __iomem *base;
+	unsigned int capability;
+	unsigned int events;
+	struct list_head list;
+};
+
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
@@ -49,29 +64,81 @@
 	.priority = 1, /* let this called before broken drm_fb_helper */
 };
 
-void pvpanic_probe(void __iomem *pbase, unsigned int dev_cap)
+int pvpanic_probe(void __iomem *pbase, unsigned int dev_cap)
 {
-	base = pbase;
-	capability = dev_cap;
-	events = capability;
+	struct pvpanic_instance *pi;
+
+	if (!pbase)
+		return -EINVAL;
+
+	pi = kmalloc(sizeof(*pi), GFP_ATOMIC);
+	if (!pi)
+		return -ENOMEM;
+
+	pi->base = pbase;
+	pi->capability = dev_cap;
+	pi->events = dev_cap;
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
+int pvpanic_remove(void __iomem *pbase)
 {
-	if (capability)
-		atomic_notifier_chain_unregister(&panic_notifier_list,
-						 &pvpanic_panic_nb);
-	base = NULL;
+	struct pvpanic_instance *pi_cur, *pi_next;
+
+	if (!pbase)
+		return -EINVAL;
+
+	spin_lock(&pvpanic_lock);
+	list_for_each_entry_safe(pi_cur, pi_next, &pvpanic_list, list) {
+		if (pi_cur->base == pbase) {
+			list_del(&pi_cur->list);
+			kfree(pi_cur);
+			break;
+		}
+	}
+	spin_unlock(&pvpanic_lock);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pvpanic_remove);
 
-void pvpanic_set_events(unsigned int dev_events)
+
+void pvpanic_set_events(void __iomem *pbase, unsigned int dev_events)
 {
-	events = dev_events;
+	struct pvpanic_instance *pi_cur;
+
+	spin_lock(&pvpanic_lock);
+	list_for_each_entry(pi_cur, &pvpanic_list, list) {
+		if (pi_cur->base == pbase)
+			pi_cur->events = dev_events;
+	}
+	spin_unlock(&pvpanic_lock);
+
 }
 EXPORT_SYMBOL_GPL(pvpanic_set_events);
+
+static int pvpanic_init(void)
+{
+	INIT_LIST_HEAD(&pvpanic_list);
+	spin_lock_init(&pvpanic_lock);
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &pvpanic_panic_nb);
+
+	return 0;
+}
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
index 0e90f4a..e1d15fd 100644
--- a/drivers/misc/pvpanic/pvpanic.h
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -14,8 +14,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-void pvpanic_probe(void __iomem *base, unsigned int dev_cap);
-void pvpanic_remove(void);
-void pvpanic_set_events(unsigned int dev_events);
+int pvpanic_probe(void __iomem *base, unsigned int dev_cap);
+int pvpanic_remove(void __iomem *base);
+void pvpanic_set_events(void __iomem *base, unsigned int dev_events);
 
 #endif /* PVPANIC_H_ */
-- 
1.8.3.1

