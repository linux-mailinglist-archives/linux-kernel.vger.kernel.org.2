Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50DC31A5F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhBLUV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:21:27 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhBLUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:20:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CKIhwV111040;
        Fri, 12 Feb 2021 20:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=d1SZEFiNNbETceCbAC/ALUZEaPMsafqP7NbZkBnxOuQ=;
 b=cICwOim4WhCrYEchpf1VKTeDBO8e8KSOIp9hMArUJ76JBNbVH6WXeFkxhc3dLi9Qoe1z
 dxxqDqpDtkx17Ii/gmcEPhbfbt+WMwGjkDI9ybjI6l65bgLgu6kg/nXkJTqZeluZn8jK
 oDAbDwzm+ibZJpWidEG6FdsMdNxT8HswtEGL9EMkJDZLNFfc3sooR8IDFcCzuLA/mU0h
 F90zSPZ9fO0pmc/lQQVVnUjKuohZxajFMAvFNllUATCLCbexZ3t47YGdGjI9tfEjjvNm
 2fSckYH/nvDPHImgs2Hfn07HcspQCN54Tizp9yNoxSpOklflUsqNYCDCBKz0SvzIvLTt Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36mv9dxqfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 20:20:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CKGob1175506;
        Fri, 12 Feb 2021 20:20:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 36j4vw5k9r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 20:20:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCQ2mZnaPNaYWCuUQ3TthTITkUGUKzV2r4PgXYCrNqAi45JhZkE/2AqeBISzJGoyqZumyx4AyItQnhX6IZaiIBP7YLT0kaqARswwiJA0pAqIFMsFEB8PouNBvKvfw7rXHGqXN9rRdTzIMReK5dIow2urcRrdCYG4jXGOkxdl4nw95EvPYH5ggdMSYfFW904XSgdWOYOlYjEWnZklfwQ9fdRuewoI46EH++Lqv+A/5Zo9kao7QjKK8Vwg9Sc5Smi8yna1Y0RcDDepeXSyrLrEuC5zDcCxD5iiqpcC3qX6Vcs6Ex/wuABZbnz2eqlaYshEVTha24usc+7Bpc7OkVEplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1SZEFiNNbETceCbAC/ALUZEaPMsafqP7NbZkBnxOuQ=;
 b=Evleq3MBZ73ilPhIgBubR9xYJyz0eXXpi8A3J6FpjZzHlztrHmZC0MkCyPBlS19Rg2ntktJ5QgH6U8sR/apahubBjtTAhrhdXdZm12odZHJZeXKdDtPfPmCHkpu3GzbB6j012Z27HZMMPvy3aSAYH9EAbsDEdi0jmVqV2rquS5z3XQ6K22zYaAoCBE3Zgyeln1JJeqvYBi33CpXQtnvLLOMcboVXU63C+tdKkLvXxOpsH3L2llIDC8TKFcssPwAAVlNnDMw5a3Tpud1Y3YprPGSbJPjavpj2EBKymIJW5U+PlZPzCu0M9Q4QLMitmNa17VNV7B7284MLaZYHdej6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1SZEFiNNbETceCbAC/ALUZEaPMsafqP7NbZkBnxOuQ=;
 b=Xolpa9SZ8vFxWB+pNAEy7qZfjRoRtFZ9raF1yTfqLUrzIr+7M6NCFILqOkDtmUENO6JAR7Nu53JUVh5lk3d8/8a8qhd1I3evbU4vF4uD/1hdqyXKBhSnqbS08Pw7CiISffuJKtrr9cLl6Nq2GZ3/LRy3nAL1Um2VEIs+cfBxHsQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2176.namprd10.prod.outlook.com
 (2603:10b6:301:30::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Fri, 12 Feb
 2021 20:20:00 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Fri, 12 Feb 2021
 20:20:00 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v3 2/3] misc/pvpanic: probe multiple instances
Date:   Fri, 12 Feb 2021 21:32:27 +0200
Message-Id: <1613158348-19976-3-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613158348-19976-1-git-send-email-mihai.carabas@oracle.com>
References: <1613158348-19976-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-Originating-IP: [138.3.200.25]
X-ClientProxiedBy: SJ0PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::31) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.200.25) by SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.14 via Frontend Transport; Fri, 12 Feb 2021 20:19:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 593e1365-3859-434d-4683-08d8cf9392c4
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2176192545B3042927E4851E888B9@MWHPR1001MB2176.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuOQNJ4KSl/1D0f0gxy1cMFQutI0FTKSDEDoWuIiu7r0i9cmzSmStrQ3LGoAdG46EujmhcZfE0CwAg70Hr7TD4xPsfvZbrT9YgcZSNxBCar2WkpxA30fjR1ZBgTffPy3/yGRZdrc7Io6tUcGMv3bVuRgV81GHM72j1f2JGvvHPf6O1zyfQEDZer0hJ50rTtd2LVQs8wzSaqUKK8zhTjgH8f8ym52bo5NQc3wp7W/hsenkgHOIl9/wFmv+mqE9rrUZoPCZ9rK9nth1w8SmCWUvJ4V7AhPIsU7XbbWamA6rqZk63DOLZGi96+7+hfgSB+AdEPz4knHpOJrMe0b6ccb+Kx6G9ArTEKOEWBlDq6xhvgXMQwA8W42SMqhjpVnaLtwYvyQAlwwFAJvNQqXrJdA57BaK9NC7iI0Ot4W39FgytUiB3aLWfevfU0tPsHhaigPWThCS8ehQEOFVM+qgqcWfT4QVWPea8p5zVIxRJphf65kHTOB+vpVPqNGD1ewsJCBZmBqB/ySeQ4XDLmhO/aCAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(136003)(376002)(6486002)(6512007)(26005)(316002)(956004)(44832011)(2616005)(16526019)(8936002)(186003)(6506007)(86362001)(6666004)(8676002)(6916009)(107886003)(2906002)(66476007)(83380400001)(66556008)(36756003)(52116002)(66946007)(478600001)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YFiAiw7/ab3u7FM1G7XkGFEyZbJkKT6Hm4mbNChH3RdReUfc8rF3bmwjQHKp?=
 =?us-ascii?Q?OvHaQFK2nvbgwON22z3dxw0QkPT8qrCmFUvxZ4puavtPqb7vgLOc4NOFpmgA?=
 =?us-ascii?Q?GqIka4o0gdkzI9K/bjzixUNF3Xsh8rUD1pC5degjkGinMVFBJ8/NYiKUDCJy?=
 =?us-ascii?Q?0u0w0ObS9bWVia00psYQh537MNe8sY6Dd6KZVDeEkTJtwfsSMhNO5f04n2Ue?=
 =?us-ascii?Q?Iv8dVkP4EUrWwX/phyrlQRmV5qddIFlSGJaa1j0qN4nOz180wBb4PKqU8jnt?=
 =?us-ascii?Q?XP8AzV7raYYuwPO++au+PmJuZMiTNb+N0ijaumRRbMftXyqwEeDz4as9bebL?=
 =?us-ascii?Q?PIbFXuRYKIgv7/ykMLRKKse15dJGKfomZ515xZ4csfcPDIGX0MRSZxcz0OCd?=
 =?us-ascii?Q?lvvG4i6ZxMyp4Qj0RlolRFgZBrzZHx7wldjaEBB5pIZa1Zb5Ja9hjF6Mzr1g?=
 =?us-ascii?Q?ZmDqkuwKVDRt+DPTSCMeW5LgK6PPcMB04n8ukq+RlGDp/4RU5QucZmhnAIi/?=
 =?us-ascii?Q?TprWmYPNVq3eXMn2XFr0G7OEq9eWGHJzQH0eF1dgNaAEn+0U8CIhS/kDyH3h?=
 =?us-ascii?Q?bWmP+UcqPquHsqnbUh93x105WGNy9sSrDfpeDdlL1L+nuhmthh1OpKtyZj7Y?=
 =?us-ascii?Q?zomQYfdrVj4Q9nYwRvTaPWe/Zt4RkeYvBmLoN8GTtMvX/pLZ72153a9q4nd9?=
 =?us-ascii?Q?8uBE/rzX82C7IBx2ivY8OojW91gAXBjsQR5ftd8vUN+9a/1y3ynMIxUppv5D?=
 =?us-ascii?Q?iV9dx57vTwJOBX84J86Xkw4r/S0vP/1I7T7YiqXmsB9mJnLBgBAdNWdRXj+8?=
 =?us-ascii?Q?K5gyRc9I7FU44cxhrv9FL9kWfwbEOYaqPGGgLJcqkhn89XxrWj5j0aKWk68t?=
 =?us-ascii?Q?oQ2U64kA39jtt1DUjwd/06FNj+3x7KRycHiUiPkTlsCb+lBduCd/yId5uE1f?=
 =?us-ascii?Q?qYDJRyyOi7gTTODJioGi25oe3InyeDI82yg4uM3CChtqufbRGqCsVy34JVpC?=
 =?us-ascii?Q?NgL4h3NQsiRCf+cUP4aLndnu8ZhdK2l5ffRmw4AYeOWAvFxBg2Y32r3scMfz?=
 =?us-ascii?Q?Y/Qsfg+oWE4XJeQIVGw5Vl/JZvefWOiNaVpipEy0qxxgrEXdRrnxeinn0GLw?=
 =?us-ascii?Q?1mgqAKlZyTH+ncUK0tWbRINJPWolvEuqnqtY6MNptxX/f709J8EhbE76jh1T?=
 =?us-ascii?Q?TZJsJuovSXibCJnTa+7lDDlrKS8QteXafC+l5RlsSYZqsliCqSXZN0UCTnkU?=
 =?us-ascii?Q?jqV1SPeveaB0/iU6b3CW0pnCcAfCd2E4qu+aqERJadoKbXo3s6fMOGR3kRxs?=
 =?us-ascii?Q?ANk2qt//tRkaoLCdGGTj50MV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593e1365-3859-434d-4683-08d8cf9392c4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 20:20:00.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFSE+wjLKWu5IqS6Vtwk+t+i6D9TA2s9/YYnScxYdB48Zr+3Axsa9OyzCMYFA9Z6MbzTz0z8zKZgWbfgAubqqTJZ3oDTcTCPxOKY8S84tCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2176
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120150
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9893 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120151
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

