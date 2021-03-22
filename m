Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5344A344D68
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhCVRdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:33:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35818 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhCVRcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:32:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHTP2f093936;
        Mon, 22 Mar 2021 17:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=oEd6jJcb5DAYC72d9K/kGuMAem3BIV0R731c+AKaB4s=;
 b=eg4chJkKsZNRQT0MPdCk8cochal52eRE6pj8guWInPgMmr/SYPUhra4i/66gkwzCOiSs
 ohXDVpfrA4NOHK+4hlSfye4aFXG71v7P5jRFt1+mKITaLzyb5UNcoOxZbkHc8aRyPYvm
 xTu4N3I5VZ1+S4hOqUa0FspBQcCPAhZ6X/9Erdi6F8fovkk37Vvn6nqF/I/fDZhzJvWz
 iX8HcL826EaLj50o8RnSQXH1ho7Y/5XDKwrFHKk5Q1nnsXpRQayFYsG4o17WjZb2nitu
 klT754vFkJJNRAt2K6KXlmplKLZ/k0CQJSXANtaczWJHUrMonSNQH7qR4CGrbdZmRqNa nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37d90mc90x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:32:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHUddu113076;
        Mon, 22 Mar 2021 17:32:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 37dtywcepc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:32:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIjYIBuo//XkPRPdUAZk00AdqR3UnzSfA8F5Vkyn0D2BkDtFj81Fv+H+6H+UWq0XCqYvEprsdwsbbTxH5ggbNA9V0k0ARkllehLDi7ZiN/ccEHlctMuaozt1/RiVFvZoDl3bX5gUK8u5J514OHtqpXQ4KRSkvpP/v2qI12V4q0fRFYFRoHqPNbLQ5EV1d1nBJe3eNj48c43Y6vxrj+SUwCwFyWxqauYN7c2NOHGwcQG2K/MVNQUflrFXf0UKylB69NgR0p8IUIaYVS1ezfveWjfTeu31KKY05fWtZ8bQwXUBrI5RmutrmS/TY1YyFtztRV4NyfvL2qMZPknt8ju0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEd6jJcb5DAYC72d9K/kGuMAem3BIV0R731c+AKaB4s=;
 b=MXItv+eb/9d8+I87BGTRNixJKbkyHipAXlJTGmis3/pl65QbGQ99bGlrIzE3IJNWvBbqgXH5yYp/UkupIeHjck/v1dBh+8ufO5Hny2wb+jl0sWnM/95n9nu3ht+omLit+wCDrRg1FKdKOVr3szlFsm75mAlFlvWlczUU352vessl830zClH0qzLwbRUICEUaqyoSjNnT6c50AVaBQ4u2D0RnA7QIe7R/EB9e2FejAl71+Pc807FXuZG00tmIi8mMy2BtpdjD9YelDMKtdsZLGdirvCpAzH5CuyUHzgNVpZr/xuzOwsG21wXDUH4rm+NbxO5j3qOZiJYD/3T5OzGiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEd6jJcb5DAYC72d9K/kGuMAem3BIV0R731c+AKaB4s=;
 b=qKXrfye5SKhoENQQqWTfxnUcuO9PNE3irVFS5hANTYBwEuvzG7rb9QYAM1sNOiCkKNMMiczRf3ZylD3aPQxD6WG+wyN+plu3in2aRcOu39ojoxQLJv3vlWSyIt/c3d99lirzrz5T/uCrtEdrx4qP3Je5JhFFw8yJCQLI0UVHCFI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4451.namprd10.prod.outlook.com
 (2603:10b6:303:96::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 17:32:34 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.033; Mon, 22 Mar 2021
 17:32:34 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH v6 2/3] misc/pvpanic: probe multiple instances
Date:   Mon, 22 Mar 2021 18:44:26 +0200
Message-Id: <1616431467-14173-3-git-send-email-mihai.carabas@oracle.com>
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
Received: from mihai.localdomain (138.3.201.25) by SJ0PR13CA0092.namprd13.prod.outlook.com (2603:10b6:a03:2c5::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Mon, 22 Mar 2021 17:32:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e3086de-98a7-4735-8eb2-08d8ed587a74
X-MS-TrafficTypeDiagnostic: CO1PR10MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44519C979938A1EE0C95A59388659@CO1PR10MB4451.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wY6jQk2CAl7YNYD7LadGTMY/+8gp1kjrlQ1M32Go3PTadVVyBtH2MkA2zMiV4mzdGS8nl6Qjgjxp+8fcN48wD5AbUKt9kQCIxZ+qCwtPYIMyHHyGXcFB+86kHl2lZRgxxJnaVz5xQd11bncTA0/suwCuLWd/UXYRrIZR1gOV5B6Ct/B+tDEghyVDHc3TT+eDAlh28FBnPhHd3YWzeT1WGik5gWUTSf/Mm2wfIs/htFNwYuGzIngaVBI6LYn4SRCi3qa1oLwMW+7G4Abv2TOV+Q+prJ+Ae1PpdYIXqxxrwMojjqrsfg8Jx3TZndZt293I0iPM3IRhvYrfr9uONy5+5Ml6XDp4F/tKsm4/q+VloarI2LhebtZM/z1MED3Zl1h78eVWdzRBlWbNEdtBKctkKbMlQddI+Vj4uBNMLB0Jb8kghAfz6dfVs085X+2rROzD5s3/0NJorC7LwvjNO0ThqcjdQ0KxRXM75Js9V/MTIBdHYk35C75QFFnZWKeDBJFI1FKfQ6ZVD3nDhkeIXUzmCzc+I91kbjl/FGzdGxInwcCGESH2VwzWvUHbnc9XLaMT0Rm0CyJGBOuqyZU9STA8EwZMrxT8ESLd3OgdcQslfn8bw6FC6Aa2h54RtBRpn7aoQu36ZGtG8DEzIRV4Lyo/oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(346002)(39860400002)(316002)(4326008)(2616005)(956004)(66476007)(478600001)(66946007)(8676002)(107886003)(83380400001)(8936002)(38100700001)(36756003)(6916009)(6666004)(186003)(6486002)(2906002)(16526019)(26005)(6506007)(66556008)(52116002)(86362001)(6512007)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LzaoCltdvyAaOMeG77Vq8kiuE5icY3rFbMjeXLXgSDXX+4D7LwPo195O7EmI?=
 =?us-ascii?Q?cIJ3WVP8ZrlQTTUat62P4q3wieCoz0crTvrod/GB8zRG/jd/ESy2Vck7erQz?=
 =?us-ascii?Q?qB4R+XHUORAm0xY+2UEOGTFreT75Mz1AyvT9Cza2NDPR8eUPSzFhwG5Js4lE?=
 =?us-ascii?Q?EaGJ58UYRyC+PoQXSxv2PVihj6bCItUE4TSEgbU4l4zE1G+GlvaeKXfVWb1Q?=
 =?us-ascii?Q?p6OUSZN1NPoTYaL6WF0vajuC4alvwb3i1ROCIjF4vTjCxB4mTzHvQf4ydBY6?=
 =?us-ascii?Q?fYy07J8MR/jPQ0EdrZj9abK/qLiDKdxdAF1a3cpB1acnsekf1HrOlAhCszg7?=
 =?us-ascii?Q?rOrmRJzerRy10hyYC/2mRsqEohPS3G3KTAh95IJ0elKv/Rz5DTt332yTH2LU?=
 =?us-ascii?Q?ykLslLWCmO6ZMuk5lWSjz3B8NJAue+wjjBtdrcWaSgVM4SjrF8GMdu8aeZ8O?=
 =?us-ascii?Q?ZumwO5t+4SA0+b5venEtpvIv0Rjn/NU/WcIGd3p0PZKdL8G7cLeSRjI7ybE2?=
 =?us-ascii?Q?SHe5GoSl01z4IiN25SihvMm39bwZay8OQWZlL7uGUkx3G76NPZsQI+sBk3QG?=
 =?us-ascii?Q?ndwKXXBzVYxEF2uyk4MD4ojenMf7rPUovZNkx9sW4jOisCkY3Ereox20cjsb?=
 =?us-ascii?Q?gczyFR4kfexoViUSe9XvR1BwCHtEm9xZ2EM53Oyey3zh9UQ2Hknag6CYzcyt?=
 =?us-ascii?Q?mNgU7g1g53Ktm6OPxFUMAdHZSXPACVizMgUlivcuVKfqY4ZU2Dr3v6tlqhSw?=
 =?us-ascii?Q?8P6uW6NaYh48XYbgtWnCZ3PzMJFDagCVuJhT4mygExdtwosKwUlEQEUl3gzQ?=
 =?us-ascii?Q?m74UicBx1JGTdAt9JxREJTE4pqdTN0U7bR9KQ3hPapzHiklpis1A+VysKVmd?=
 =?us-ascii?Q?Pg0yZZJNbKC+hFDJu8W4xCIHDxe/VlJNVeo+ifKQwiU5/B7eBSDkL6/53OdC?=
 =?us-ascii?Q?Cb0t9ju8JrGfboEhPhnz0R8xooQ5fdTlgb/15OpC2eXl3JGxrP8HNGokBc48?=
 =?us-ascii?Q?6k3ULwbnl3lSzKerTxUG3xeftIQxAgFKiHKLEGQ0ExZUsdcX2bycJzSO8FdB?=
 =?us-ascii?Q?LH8Zf5gEcgvKwuTBnYzkmbC6aAfnYJ3DeOsUecl/7Dgs28KhoqC+uacOF2L3?=
 =?us-ascii?Q?LHTH+egdUFtHZktJy32ovXGu9vybwfHjhoPRlpd2pQQoi+RP/IQ7lT3jegJh?=
 =?us-ascii?Q?EeySZgHwkJEJ8ONxrkF+0w5JsEGUg+ah8wlZU16+oU8gyDh0B392owsXjyNa?=
 =?us-ascii?Q?ft/Ah6QzNotyoiKYIgrNd8A578EmxDdZri7r+akglGrW7TNWVhdhhpJ/R/x5?=
 =?us-ascii?Q?97t9aP+UgOyibRm4CASUuw8E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3086de-98a7-4735-8eb2-08d8ed587a74
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 17:32:34.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChP5PFnKjL+rPStQzsyskMu0r2s/eQ22kTGYnGV6tanKTY+U+xySKjLTXx/64XX9J+D8Gey1e4ZTofwvT4ShVsPQQfN5b9UoNN/B692V7yU=
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
index 801d892..0dd0e35 100644
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

