Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0FA393903
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhE0XOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:14:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36642 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbhE0XO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:14:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RN97xR146826;
        Thu, 27 May 2021 23:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=FvvKFMkQjy+UvjtT+9o8xiGw1n1aHX7MgLG8GjJnFWM=;
 b=D1Mk234kgPfcGMJxBY+kMTvMZpkM2SJrh70OTN1YJIxeLkuZgRIoqNNmcDg4tOfHLqkt
 q4gEJPcp0xQ1kfIj+NZ6tDlRLiUEe9NPOve9ry1A0BzmHmJto9tq3FJlYGEoy5QudCaF
 MdeH6aV9fhLXGdx5GEMRI6EKz33sN0Kr+fJVs6Q1PdRiSpo9ybeELDIVmw48DqKZ3J+9
 skR1vGYyTxq/Qw98EQpn7CQcIHEDEHeKZGczS7LONTLfn2KAdUpPGEMnVdCUqLJBPJA2
 29Bx6MdjwTDnsoqRw1E0z1ZVACvHp/LCoHeGrOCHZDyGujG/tcwJGLee3HCI4Q9i7VW1 lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38pqfcnkwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 23:12:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RNBZ3k050942;
        Thu, 27 May 2021 23:12:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3030.oracle.com with ESMTP id 38pq2wvsr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 23:12:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDEyYvkSucS6s9N6o77kstYc1sAQRwF6UEGaKoX1zCaUJDKx2RuvUUTjqck8l4zfqZHYl1WfvuDtVYDBT2n741vTcVy9j5VIdWvt/0q1FpDhkLxnXHl4vo/BgTW2NmxmIzLRaRRbOx2wlB1gTMVYwuC3VWERrxocS27nxOPbMH1+tfyWp3P/MeeaIQPDHLCKW6Moog/OC1kJVTqd2vp+TyrgjCsx0sXjlCjqGuRr36DMqO7cP/7t0mspPajyYtVXyrqUtBmOt1qeEQ29/H/ztPYEcC8EFe3eReq0XOomFbXhUiCH24YRntqgfMmOvYDEmJAeH+w+3zI4Of7GITcIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvvKFMkQjy+UvjtT+9o8xiGw1n1aHX7MgLG8GjJnFWM=;
 b=fbOn1RFPneSACoJAuqH+P72+1/LfUA8dtfLOGC7aahTA4dzz0OvgtOBQEYWXUFRyY6rmnm2B5Hshuee0rzPl1q2tQYcf3zh485bbszO5pcCBZJiCRD+Dq0eJWfNKNyP7BLv+PgN5JhSxezVGgmfdAWkJKIy1ZNF40RlWLvUwWoENt/PcbMh/aJckc5GYFGCBICeKqUq1fDbvZEiomvIvADKxXfg17r7IntcOsdgN5DfteU/Xhqh8KlirM77/kFciHYnUXRlaq+G3Z8y68DOhQ3qeBCfTXG+ToEdUCwv7BxOeGTuUHOR+cXvoaWc4BzLoi4pCnwa3pq9hAdgZN2hHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvvKFMkQjy+UvjtT+9o8xiGw1n1aHX7MgLG8GjJnFWM=;
 b=qo8hwuNrgJfYkFwDLvYeqqqIcfESgMVbFYZCdmQnSu/h4PJqUZ5P0589fVxKOLzvVZGblZziTevvESh/c+Lpw45CeuAtGj6a3M+LbfjcT7Vw7xF5IPl+zl0ypwPe7TU5A/ViO6BiEgvYtYkvkE2N65M0a1eNHM7FgmCFvjkSVNc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (52.135.55.87) by
 BYAPR10MB3000.namprd10.prod.outlook.com (20.177.228.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27; Thu, 27 May 2021 23:12:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 23:12:36 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm: hugetlb: fix dissolve_free_huge_page use of tail/head page
Date:   Thu, 27 May 2021 16:12:25 -0700
Message-Id: <20210527231225.226987-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 23:12:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33a64d04-ab32-42c9-cc35-08d92164ea1b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3000A2159311B45ABE9C9DDDE2239@BYAPR10MB3000.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mE/0MzvQiymFDL5QmmIR1X5cLncItaoBXXOHgOQnNvnoP34yxIgSKoNxrvdGCg0O991JYgvjsmj7JFCdCewJGgI7k//4cIRTonCc6RUyhieA1RJ9JNH+9kldlHBeQVLaLOo+laXvIrNvTJ5B3yi5xgdi1c2JVbkAqwg8jF9gDO9pYtznDH+MvENWzWKY7nThNy+O9o7L+7oMlK+Mc058YKo9DFlIS0RmM9RzG3nay4E1zGkviYDvIDx8BY8IqOcSSn6n0/Rkfurs9HzlNx+NydzkkLrm2XoOkqxpiReIVS6gKlv5WDHPK07d+rcTpmDoCEw75fmvIbCp805zmNQf0dPAB7QJ3tAkVM6eBxZTCAhxWMITP4O+VTFweSwYZrS8pjNQJhItotCzLxV0pmmtv37J0p0QAxZUJMpBrn9adk/0Fn5H0ewdLfrOtsI9HMBYo0nhbCFku+W1y4ALJM95VgCtx458fibze8DbFaBXuSkRs4WYUiv1o0ry3TWc0ehebyvugKc26HDzqT4mwVW8YYcOLwXEL3IQtXhHVSjuaBJxw59l29IJSO6cVRxZrfPQFxh34LIXaoV2YAP8+M9c7O6fws/zABMwAwYyi8BbUwq+olVX0ZkZHb4pQEILNvEPJn/Xmx3KsM8oyHHKcSxP965aa5XGbnvICiTrBW7UARuTZOMi6uGZbsL44kE0pUeQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(376002)(39860400002)(346002)(8936002)(66476007)(66556008)(6486002)(83380400001)(7696005)(44832011)(316002)(86362001)(66946007)(16526019)(186003)(1076003)(6666004)(8676002)(52116002)(5660300002)(107886003)(26005)(2906002)(956004)(2616005)(36756003)(4326008)(110136005)(38100700002)(38350700002)(54906003)(478600001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nC/MLbcA6GqP9YMxi2pvKvl127wYvbyo19qAQQ1vzjAlg84CDSrQ1P60pNnk?=
 =?us-ascii?Q?iozgZKMgqqgSOKVyvEkL+T9rD5jbKQCIdIB06IxiYinBJpmLrNBXYD2DRlCR?=
 =?us-ascii?Q?hsN7LTXBdSBjPKdRu8cXD50a9B0REvTQPt+DrkvHDgDKA546pq1VXsnbqGAv?=
 =?us-ascii?Q?mvyacNRvgzQoiKb/KBUkZni8QTx0ttNlujN9kamrYKiRqmgMllL1L4/A8CMq?=
 =?us-ascii?Q?hBLGAxkWV2mQpBM5a/MxzqLNwoEVD08g6Fc5KMzKVXqh6zqtDbuo3s5pbg1Q?=
 =?us-ascii?Q?G87S+pa8LJ22j06FzsPTNeLyLM9HUC5bttAyA6PECyQCIxLS/m5F+DFj3YxF?=
 =?us-ascii?Q?46tvLHKSZKDwZWvofW9lkBYs/f6x7VtCw1cM1cUe+DsrDI4+8b7oFbdmsrU9?=
 =?us-ascii?Q?czcd4Vu91hct7YhEO5NMXkeLt4011/qbHa4t9wyCzWTFt41qhOdwA52FQQFT?=
 =?us-ascii?Q?CWYpaVmqBuUi7Ca7wz0X0laBvojrE3iT3o+idGtERAvSBx3haqqFKpUlH9al?=
 =?us-ascii?Q?IKlZqK4JaVBgoWkD9rWkNWRuH1f4TTf4n+khazvQbEu+B+djduQnEGdckQr8?=
 =?us-ascii?Q?BiHtwmlEogWedVHUs9DU8c0veuajeGAk7fLE1oN+BD7CyMP2r7Pf/sSa+ktC?=
 =?us-ascii?Q?/ZDJl+Fr6UCbNnMd5H7OXxr0FP2WQw69Rk9jcODZTZrd7or6VlTMnixBLqy4?=
 =?us-ascii?Q?WnYGXBkh9z2mnyMKkqIzznZJ7rljde3naUQ2PM6PSdxxA9tSVhxQPYcPi6hH?=
 =?us-ascii?Q?buArctGQNrK4qrA/Zn5hzOqfoKzuyVFNuOzuQ1t/dP8PVjVZfUgBEhPoCmXB?=
 =?us-ascii?Q?Yn0UZEuD1ttmNxEq3b1PCBwCsavVzZ1MUIb+dhpt9P9rkU1nWP+KGTzKtjf8?=
 =?us-ascii?Q?qpWZA0W4JuU7Sm5GgHgz3Cd0ayOHEwGhlAF7TiBDvEmgULLz3pQk3skoZCjV?=
 =?us-ascii?Q?MUnrgs3stFfh3gzRYlwSjj+LXDJMNwisWLONXPq08CjXB1jbcXMMPIlmKNvm?=
 =?us-ascii?Q?DXtpBABQBeEAxdttRTBeuRoJFibVd/YQyhntblXrC1jENKhzCzCL3xTeBHHe?=
 =?us-ascii?Q?bIBuBg/toSYzqOmD+cSooNt1L26/7tU05ogmew2GDNj2ydM7PxBec7c61F6J?=
 =?us-ascii?Q?mOACeOBnZiceJRO7SC7hyCgCxvKHjRhC8lLu1aL3wT4ZWmNZzKhyOu3CFyFO?=
 =?us-ascii?Q?20cmvqrdOHMkLZG7UqHcOkObAm4f9mcjo+GzRTcmMHidCM58aHl9z2TJu9wL?=
 =?us-ascii?Q?lZbpbjElaAL+gL+gWRdXCyYDCL6hAgRqN5nhSQ1BVgVurrx2l8hOGIWGMoXo?=
 =?us-ascii?Q?JWdpH6KjlN7P7OPWdq/yjjAZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a64d04-ab32-42c9-cc35-08d92164ea1b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 23:12:35.9265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3xUPL/8lXu/e4asK/R2zBOmjsjPd1q1j7M+BDe3PfrJQKeGNCvWg4X3evrRgVsC1/J4o9IrWskF+SX+5SmZJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9997 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270150
X-Proofpoint-ORIG-GUID: pZjKPc8MGpTCxDJm3R3iUCojW2VFdS_o
X-Proofpoint-GUID: pZjKPc8MGpTCxDJm3R3iUCojW2VFdS_o
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9997 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine dissolve_free_huge_page can be passed the tail page of a
hugetlb page.  The tail page is incorrectly passed on to the routines
alloc_huge_page_vmemmap and add_hugetlb_page which expect a hugetlb
head page.

Operating on a tail page instead of head page could result in addressing
exceptions or vmemmap corruption.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
The code with this issue is only in mmotm (and next).  Specifically
mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page
Andrew, I assume you will fix in your tree.

 mm/hugetlb.c            | 4 ++--
 scripts/rust-version.sh | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 scripts/rust-version.sh

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 69a4b551c157..d2461c1f32dd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1954,7 +1954,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * Attempt to allocate vmemmmap here so that we can take
 		 * appropriate action on failure.
 		 */
-		rc = alloc_huge_page_vmemmap(h, page);
+		rc = alloc_huge_page_vmemmap(h, head);
 		if (!rc) {
 			/*
 			 * Move PageHWPoison flag from head page to the raw
@@ -1968,7 +1968,7 @@ int dissolve_free_huge_page(struct page *page)
 			update_and_free_page(h, head, false);
 		} else {
 			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_page(h, page, false);
+			add_hugetlb_page(h, head, false);
 			h->max_huge_pages++;
 			spin_unlock_irq(&hugetlb_lock);
 		}
diff --git a/scripts/rust-version.sh b/scripts/rust-version.sh
old mode 100644
new mode 100755
-- 
2.31.1

