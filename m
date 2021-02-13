Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C87D31ADF9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBMUdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 15:33:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39824 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhBMUdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 15:33:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DKUAeH140578;
        Sat, 13 Feb 2021 20:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=d1SZEFiNNbETceCbAC/ALUZEaPMsafqP7NbZkBnxOuQ=;
 b=OgnC28bQRao+QMGM5j48mLPOxJ11pJegknq5cArjOtzKVZZydxJd9WXRTXfnpU9K+PNa
 7vhQz8VVwdFvzozrjV8CQsEiWPgduVo/6QTeCae7a49MDXk6+lqeEn82Ldx1C+kKkD+N
 iHDU6mQD8jAPryTJfYY4kPl05n39wNu+7HwxJ5nRv1s+GWsKsn5gLwBVpc5+NPq1Tk8S
 foCnt12AbnO7gzEpAX43Lm0tvUfmM8wpZZkuafzojZ02S3co2+6W/2C0wcNRWORhZm4w
 pq4Aru0RFdiGl8sFVki3lxCyFPR4sHKN/+FzqjnUaR+3gVRzKQaKGpbvE2TONRzlietR 1Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36pd9a0ger-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 20:32:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DKTuq9093977;
        Sat, 13 Feb 2021 20:32:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3020.oracle.com with ESMTP id 36p6k0226r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 20:32:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb3qoFxsdH1xTiIlx0WvN5Rb4iiF2BQWBipfC5wenG0ugTlidLyYd1OSSQ2nM/uNQkSj0XnLm94161FomPW1NzTzG0IaI+MGll6mIjL3tKyRjFwVUdSOT14/V/9j6r64Xqp4Urh5c3pKOcYHYF3cEz1ZjN3VRFTrCYMiQ1/hBN1zR9Fkg7FoBYPIRs+//DbylIposPcDJKN9OBUJfh7mCLRSQpQqW5kPuigunuNpM6DjeGacFv5/tFA1thYKF8atD9WNdx+hj0v1C0wtDKVGNLpOQ+tyzjbiCDkqbvTPCdYOPKqmGh5vPQUkr50qvAbOWxgxuwDJSyxB5BzlC4LRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1SZEFiNNbETceCbAC/ALUZEaPMsafqP7NbZkBnxOuQ=;
 b=QCI4MIftnwU0FEunt1sMCLpa+jd9/k4jVO1OxUzpvw9huBeRtkbBBDskzsBje3S64H0NkUYoJc0+SmP2oVFXlebBUDJjLMLnonHKoT9TBiecj1Kremd0FwQIjpvRGfZ+Ev8okZrarv6wGg9DZP0URztpkotWViwofEK8x1vZiHmxovSvUhFDCeViI/Vsl4EjYVVnFtBmDcWjQ4ytvosf2GRSTvVXHXDH0hJmGvom4geqzwjqZSwMB0d+lD0uJ4KZGKZBB/d6KzCgF/OmEKp07Kew6cib9/+2LVIDOiO1M8i1169EZW77C8t4EgYUD2Vi26S6FAJYX9VVAl1/oYjk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1SZEFiNNbETceCbAC/ALUZEaPMsafqP7NbZkBnxOuQ=;
 b=lelM5XkFwkBDF7EZcDee3D0gUa7HGKZBf4ixmlMZ3i7ycxjejuYNVFJZrT5Ntatnyg0U9QOdsqca1f0rvtDIkty5ONYQrBDtWmN7YclV6CiczAffd9lYeoNewOaeqvxAqL4ge27Wv2H+l8//Z7gGfPH+dwlYCXVddnbZ8N7I7Hc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2286.namprd10.prod.outlook.com
 (2603:10b6:301:2d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sat, 13 Feb
 2021 20:32:05 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3846.038; Sat, 13 Feb 2021
 20:32:05 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v4 2/3] misc/pvpanic: probe multiple instances
Date:   Sat, 13 Feb 2021 21:44:06 +0200
Message-Id: <1613245447-21495-3-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
References: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend Transport; Sat, 13 Feb 2021 20:32:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf677858-c251-4088-9131-08d8d05e6cbe
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2286FE73AFB4C89F22BF0016888A9@MWHPR1001MB2286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9KJHMfwrwTn/jgHt/pBOXtVl2wZjZtL8yINfz0jSME0TdhWl7Bh7BkSaP5ITSPnGgWkHtS/P5befZpQLAc0MLiH3oFwqy7Ys9Y3TeVZvhicR4FY9wE8oyw6o8hFN3deM1Y582dFq9L+quYw8TPo68nFV6ybny291y6bp2iEgn89YP+B9fVRB2oucljSEAiuvjTyi9/iNjaUkyUQyOOEyNFM6LxCnZ1bkm+uKMueYtof27wrQJ4LMTvjLp4AfuLEPKZqaa5WdNb4HQ3yUGBQUcKsWXp58DFpw82O96E+2acPvI25InPipyLQX6nW7ZZtZGty3oGTLiycV6ZbzLNllHpQsKbdNT7t6jrDYQuH67CUiaK8nru4n5GX1CG8qWbzHCaFWX+PPwsJgteO3kgOorQp58myFe4UeJeNUzgtonKUDq5fQ9nJOEmuWDFUz+qlXIvdgUVO8FTLGUG4AgfqnnLH+PundBzMLz9VYZy/Clcbrjs7XgE156cV/fJreUovfpcxdQNeMbFHkLBfDuMLSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(83380400001)(6916009)(66556008)(66476007)(52116002)(478600001)(86362001)(66946007)(8936002)(4326008)(36756003)(16526019)(26005)(186003)(6512007)(6506007)(5660300002)(316002)(107886003)(8676002)(6486002)(2906002)(956004)(44832011)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zeEck8S81ZD7PAwUAp0xJRuexkQWsV7uhaNAKTuLRYVXuPvxo1TBO9E7bxoe?=
 =?us-ascii?Q?mHfOaKDtGkXP94V4Vkxl80Zhu0M0dSWRF8thDLVvfaM68X/5txhRMCqdf9t5?=
 =?us-ascii?Q?xZZA0P+UoZ95+RacM3k2PCSktQgcs4HEHqyigirIQI5+++sooKBKV2VIctJY?=
 =?us-ascii?Q?UuNMd1QtY9lVxuVbavfwwSL9/RKN8AEf+qSmWPiH8Z3kiD9REMnJL2mn09k8?=
 =?us-ascii?Q?hANznlw3kl/7h0UxaOJ/9m2uUJXKatBFSh0R7X05hbp7ueJn9wM/kFRyYx8Y?=
 =?us-ascii?Q?NcxcEyn47+86LUg5tQD/FMAVvjwaHBESSl5nbDPSXdr70E+iQm3COUneb7qh?=
 =?us-ascii?Q?w7q8DqFrP31PBNG1i4d8/kbyJVWd+jg7ZmMxhIJlIp7nEvdWn1GOXrCkAuXp?=
 =?us-ascii?Q?K2rkIpdnQ8d63U97XcL90/f4sXlRE3yeRiKUYSxqMCxmCwC0s/LJ0LDWOCtf?=
 =?us-ascii?Q?SsZ2qaLC1K/wi6Y8N5j8iNAAKIVkwNIkHwnlBgT/X4lmbj3XexI189nZUK2I?=
 =?us-ascii?Q?luKZkK8BVxykSTpjg450whqv7odEXHYRp5LEZSgGXJLmOcJdFImqBIuPSaOl?=
 =?us-ascii?Q?p/RdEmNSCGc0+lqxY+Mp41Upt4KlGyAUqK5jTf3CPFgcatzR4WCEcMbGXVN6?=
 =?us-ascii?Q?7ZS7JnOuL40BpK+gbI4hrgXiK/X4dX8h/PJj9VAxSm68Oi/cThafDHQM7LWR?=
 =?us-ascii?Q?E+dtp7EbmUv9oU6knt1jxTbpbueS/s+geJj4imLCy3FSsvOu4s53860R+ahW?=
 =?us-ascii?Q?wrnejiQkuLzFqWZ3g/s/fEDCxmrF6Z51nOWirGNzEJUXF9Nw6EXiBd1D2njz?=
 =?us-ascii?Q?lHXokiBPdaSG9RjJmJFNy2L/WLEBjWKq6Piof76ht6Ql0NMLxk9bW0jfUP4K?=
 =?us-ascii?Q?7kTI+WNThd8Zu4CviF9Pz1c6thU4mJxP0Id4Yc2WPDJF45CsWa+bucR0E8LS?=
 =?us-ascii?Q?9gxFW9Fbhh+yZE9OQ0u4V3BC4gYI2RBIDWT7uUipaX/OfmGKXb5ivBDKTeZh?=
 =?us-ascii?Q?NUR0RD/2F5Y/J4jKv2vAoW9iyiBJAA/5bKSRRB2OIEvJIxTiJHCdTH1Tgr2N?=
 =?us-ascii?Q?a66LeoPnDqGki+eLMmwYoxDbVXA4HxZR1nCS9/laXztAWEnekY02VpoAttMU?=
 =?us-ascii?Q?sC4d/jt2LPj47nb4h61t95EHSnCYIYOdHQcTXTF+biy7lQkSVgEjaRRRNX6p?=
 =?us-ascii?Q?VOcin/YjB7Ue39p+gWXBpcGGRoRgIIXuTlJdqGIpL8dUB8nylZsWRx2lbEex?=
 =?us-ascii?Q?NC51wxGc72Nj1vkcWYFrbHKUuKHC9q3kP5AFAyseusMpMUGAG9QAOMZGoPuk?=
 =?us-ascii?Q?T9a5usd7gYidxMsfazuKzqfV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf677858-c251-4088-9131-08d8d05e6cbe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 20:32:05.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S76JA6poBTMupHt25WFRvLj8y17MCTa/Dp5/EAN1//XKRdIV1plZpIWykeCI6tvGTqIaVx7p2hgTuE7MQQpkFIH+xBG8rynBmNl1dpUL7y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2286
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102130190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the mecahism that allows multiple pvpanic instances to call
pvpanic_probe and receive panic events. A global list will retain all the
mapped addresses where to write panic events.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/pvpanic-mmio.c |  9 ++---
 drivers/misc/pvpanic/pvpanic.c      | 76 ++++++++++++++++++++++++++++++++-----
 drivers/misc/pvpanic/pvpanic.h      |  5 +--
 3 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index 7454eeb..5425369 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -22,11 +22,12 @@
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
 
+static void __iomem *base;
+
 static int pvpanic_mmio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	void __iomem *base;
 
 	res = platform_get_mem_or_io(pdev, 0);
 	if (!res)
@@ -47,15 +48,13 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pvpanic_probe(base);
-
-	return 0;
+	return pvpanic_probe(base);
 }
 
 static int pvpanic_mmio_remove(struct platform_device *pdev)
 {
 
-	pvpanic_remove();
+	pvpanic_remove(base);
 
 	return 0;
 }
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 652ae01..43b65a3 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -14,15 +14,30 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
+#include <linux/slab.h>
 
 #include <uapi/misc/pvpanic.h>
 
-static void __iomem *base;
+struct pvpanic_instance {
+	void __iomem *base;
+	struct list_head list;
+};
+
+struct list_head pvpanic_list;
+spinlock_t pvpanic_lock;
 
 static void
 pvpanic_send_event(unsigned int event)
 {
-	iowrite8(event, base);
+	struct pvpanic_instance *pi_cur;
+
+	spin_lock(&pvpanic_lock);
+	list_for_each_entry(pi_cur, &pvpanic_list, list) {
+		iowrite8(event, pi_cur->base);
+	}
+	spin_unlock(&pvpanic_lock);
 }
 
 static int
@@ -44,19 +59,62 @@
 	.priority = 1, /* let this called before broken drm_fb_helper */
 };
 
-void pvpanic_probe(void __iomem *pbase)
+int pvpanic_probe(void __iomem *pbase)
 {
-	base = pbase;
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
+	struct pvpanic_instance *pi;
+
+	if(!pbase)
+		return -EINVAL;
+
+	pi = kmalloc(sizeof(*pi), GFP_ATOMIC);
+	if (!pi)
+		return -ENOMEM;
+
+	pi->base = pbase;
+	spin_lock(&pvpanic_lock);
+	list_add(&pi->list, &pvpanic_list);
+	spin_unlock(&pvpanic_lock);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pvpanic_probe);
 
-void pvpanic_remove(void)
+void pvpanic_remove(void __iomem *pbase)
+{
+	struct pvpanic_instance *pi_cur, *pi_next;
+
+	if(!pbase)
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
+}
+EXPORT_SYMBOL_GPL(pvpanic_remove);
+
+static int pvpanic_init(void)
 {
+	INIT_LIST_HEAD(&pvpanic_list);
+	spin_lock_init(&pvpanic_lock);
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &pvpanic_panic_nb);
 
+	return 0;
+}
+
+static void pvpanic_exit(void)
+{
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &pvpanic_panic_nb);
-	base = NULL;
+
 }
-EXPORT_SYMBOL_GPL(pvpanic_remove);
+
+module_init(pvpanic_init);
+module_exit(pvpanic_exit);
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
index 7e75dce..02023d7 100644
--- a/drivers/misc/pvpanic/pvpanic.h
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -8,10 +8,9 @@
 #ifndef PVPANIC_H_
 #define PVPANIC_H_
 
-
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-void pvpanic_probe(void __iomem *base);
-void pvpanic_remove(void);
+int pvpanic_probe(void __iomem *base);
+void pvpanic_remove(void __iomem *base);
 
 #endif /* PVPANIC_H_ */
-- 
1.8.3.1

