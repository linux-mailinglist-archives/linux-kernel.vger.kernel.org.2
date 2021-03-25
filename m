Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3B63485E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbhCYA3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:29:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52482 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239243AbhCYA3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:29:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0O4dx143453;
        Thu, 25 Mar 2021 00:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=FNlo68BHX6lihDW55viDAfC/BJhdtoMlsCflcTEe3wU=;
 b=s0ngk8ShMOjVtmvBO08UkCG21FiSDil7J1Ld/nG+2XMM8AdOtgAvLqQRIyYR4xvp+W3H
 MCeBzi/IVAvqvyEWz/GdYRfd2hgFU1as/aldoGpAUr0MAevRggF+B/GeL30sAo0YIZJZ
 syH4cspKCgh91Zz8rJN57ufhch//weB34mXhX7sTxD1tGYAAVYeGVlNVG15BXQz3DXnw
 tAzlTEPqo90CWx5tZrjg0DessMsRrY5Ahldo8EqT7PyGU5tdJG2LwVCqRk0c0W0rHnay
 DQqU/OjiQWVqQ77dlDwJV0S4ZxTi1EHQZnkrEDr715MxPXu9gsgBqbjMomRLl6iRGsg3 iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37d9pn4k6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:28:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0PEnf162585;
        Thu, 25 Mar 2021 00:28:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 37dtmrgq90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmIndY/47P4lO11WnSMojfhUcH7p9Nk5gruYzlEvYWBt+QMjzSlgRGSI1iTupEH21K8PpgPeoqAZNsiJuWFFr6FFmDT5pivfmUx8Z6dyOiHk14PYLcKkzuetZwWlaSnT4GMZ1jpVz+K3iA+FKSquNRGcSv0I0yeudUMYx414n2HO48g9VmPhpXuNA6UYNrEMEK6f3gdt/vhwdmaINTFTbDA8qPusAU4JnqOAX/i5avGW3gNaAs9j78EQwwGs0aGLHL8wfH8ELFz/aWZD8l+IXC46ESG3kTqJvB3qivRxMzFHFXkxnrkBwVruHJCYxgXBzKPI0eYaNpKzCoej23goTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNlo68BHX6lihDW55viDAfC/BJhdtoMlsCflcTEe3wU=;
 b=YfVwzHTevwBB1XSziMN0OcDs4xF0LiyzaxGNb1PC0QcUoD2o6f10HHJ/Y5buEM7ji3lRRwqvGGm5XRq+uv2qYa1SfJR7CzRyQYsOYn4TXsSqMToj20CDuctlj9NQVqxFmJ5k7HSZGh+saJobeqNFStLjc6aI652d+LB5Vm789L239aV8NT3f92r5TPY9yj38ks151StacC8sKZtygF0liOOTrDk8GORWQ63DFW3d28pFUCmC6hweTXs5JNGcIoC4QXhqRbbocHpbVpe0xSw2jBsoCNVc/3bPyLWbL0lEZq3mGL16wUEa3Na21Uy1rBgbZk10QgI0nMrmMuZomYB43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNlo68BHX6lihDW55viDAfC/BJhdtoMlsCflcTEe3wU=;
 b=OgfiSvLXX6AB/VYLxjYgHi1sBU59LGsfGRI6VeP19qsWY4+4mrRYjbLrrZCQCNcRsw6ClYmBDE3ClNZ+9rNzo4uwai0Hx5BbOa5Bp6v8aD8Mh/rLUE0RGKifEB2iDCbMPKR0BMqIwiQFWQ4bcto7GO7dyuFLSLkasPYEOMS9qFs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 00:28:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 00:28:53 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
Date:   Wed, 24 Mar 2021 17:28:28 -0700
Message-Id: <20210325002835.216118-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325002835.216118-1-mike.kravetz@oracle.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR15CA0042.namprd15.prod.outlook.com
 (2603:10b6:300:ad::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 00:28:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12e4c502-05a0-43f9-4080-08d8ef24f816
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44625802FB7D792AEF28927DE2629@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueEutneeFVMGPO4y2kLV7l5YM0mJMydzmdLBuwlHuck0L04d9/b+tbZzs2GDL5TEefBR6rv5DpRJb8k2TEav2mIKWgJGJAJ8Ttl505tJ+xcmSzdaTgde4U5t67hwWqu0K6erVxXWpC2ZzMw+YHwLyhPOD4V5AJ82nwVS3iRU9dcaFf/N4QXT6EAMCxuB7eXwLl+rjDmKxKjqIJWFf8Qdm/HxtXb2gX2ru/5umuKOkKAUimi+704WKhJvs85RCe2SQfbeJPhzO5RN8K8d/yiTrKlCZ+w1hPK/7f7zZef4XfPoIr3T3MZqoL9xZ3xbqbWfVWrf63fzdSZvCXF5mdDAw48G4QV0SXgFvYrfG/3VAOd1ac7U4F1xaKFHkkqDrZ9jt9ggbAEV4JxcUzM7t8R7O1vK3YSKTDc95CK6YhbZ7GNONXYe2/b+S0rMF7PECtDE82wHMieWLHDtVGiz3zBUWq9zP2T45Ftbwhx4ejlmlXJDYKFsHq7XtDx2m3Y7ErnDhr5egapcF4X0qZMMhxMIzOfoU/jqf36qNvxG7fTusDkGp01BvbPQ3CB33uTcVlb/qCwRscfjcC8k+BmICZ2N93pY1f6ZQ1dJJSVUC2FYbqz6zYx51PTQIBTnDkOARANwH8lSifS4dfWxkw/dljjLJr+1wLNFi4h6Hv7OOl5rm3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(8676002)(66476007)(66556008)(86362001)(6666004)(4326008)(66946007)(956004)(8936002)(107886003)(36756003)(44832011)(5660300002)(1076003)(2616005)(316002)(54906003)(38100700001)(7696005)(26005)(478600001)(186003)(83380400001)(2906002)(6486002)(52116002)(7416002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AqLl24HnfidMAma5c5Ic2ehjFNPoZ6UdhM8XKvo3eX03G6cBksIVPkS2mvli?=
 =?us-ascii?Q?zmD00NoamUomVG0Gzgcpit/lzEHiQuovFAEJxheMepDOI3b/gp5obIw+rt6T?=
 =?us-ascii?Q?C9xdVJr7k7RldkRRyDz/y3hc3av+Mx3NtXuKFPaVTiSXDK61p7kOl4aKfsyf?=
 =?us-ascii?Q?liy0HLzor1hhmx1lGroSLajqwOpr6C3jWmkODFs0S9OUOA025FkKRCE7VPli?=
 =?us-ascii?Q?qh5yzdpB3fns0ijr1oYsW+ULceO1TnOF7TgjaY2lL8WV9wTDI5Lz44+mHSn2?=
 =?us-ascii?Q?8CTaUaww6QTaJmC1OFpW7QklEoC1XDUgMsAN9ibU3uHhzv7lt9gCd9yNPsZy?=
 =?us-ascii?Q?vF7b/vj+QK/7RF9/C3fojulUzoNO+ncnpXJN9RANHW0mbjHllgkJMYu1Zssw?=
 =?us-ascii?Q?JrLuQxC+V7pOQN3K0MRysWyCVYBzs9Ixk+XPTbNglD6391MJvmjnalFjSOa7?=
 =?us-ascii?Q?E8MQMUYcYrjhF3rRdpeaRanm91gUopfORA5Lm1g3cywUf59Kj3yTmDOjzxQ5?=
 =?us-ascii?Q?8KYEnKeQheOTO532OsWUejBcBLu2X3lPQI0fmI+/zeAiqVGe1EP/R1iXaMmX?=
 =?us-ascii?Q?AwnRxqOPv8b+F5TzzDVrMth1MdnkOP7pB6sJjZfCw5UlSlOK2kfoVGQ1ZSuk?=
 =?us-ascii?Q?IK8S2O6FG2be0z6RemL12k/D55Rl1c+1ufWhzwI5coi1Z9mF1kEz1W2iJWDM?=
 =?us-ascii?Q?PMRUvE8iboIKUexn96Iu7Zl9bncoFSgfDmo+8TLcR4gE/atavNW7yEsrtBHe?=
 =?us-ascii?Q?w4KBaptoFL3wfdAKEosVSqjozoK0mvFit7VQUFHUJzpnJSw02Qg227uNZQ+8?=
 =?us-ascii?Q?NA26Dw3IBnASzcF8RFlXkAsCOdKRDlBk5gqd7EELx2N6W1emjQMIKUNW04o0?=
 =?us-ascii?Q?8GlfkEidsEaTKAX4tO8lrA+abGTbaZwUtyWRchbY59gipdlO+qzhPJddgrrB?=
 =?us-ascii?Q?tIwILFVTIIWzWa7kjOrUKHv9lnNYQTV2HcjOMZRyinZaW8yuBuQahKtMJgXh?=
 =?us-ascii?Q?9/KzCe0v9QQBEbTo2cQTI3dgq6etvU2n31tUMAoscKW6CFQ3S+8K5E3nb4dP?=
 =?us-ascii?Q?kOTng5Fh8UeKckm2ZRgbhr2gHG/9qiJPaEJWsSWs3SeU/VCsaOK35cuSittJ?=
 =?us-ascii?Q?zKC1hj6HzFnlOTyVtJD8MQgfBdi1rzrJJmPXkZU/DZLhHGAS/e7rST3GgV8k?=
 =?us-ascii?Q?KV9/ws+xGJm+4LwLzJ+a3jHA+UNjDswEeUDAs9FplpPH+rp8B00vi1ZT9pty?=
 =?us-ascii?Q?d3C2urM1ouwOqw63bJQEjmSXSGEq5hKUpTvdWsmEvNRCqnTAo5mbfxL/KYV4?=
 =?us-ascii?Q?wP23A9OssqbsdGNVJStgwTsH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e4c502-05a0-43f9-4080-08d8ef24f816
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:28:53.6966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnJSQRiM+w5ysyrhzCbzZonCKAXpfgVd76xcycixHLPkEcTzhIU+3TkP9FCeDn61bJMTdgh1cYYZWW/+gbO48A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
It makes it a blocking function, which complicates its usage from
non-blocking contexts. For instance, hugetlbfs code is temporarily
dropping the hugetlb_lock spinlock to call cma_release().

This patch introduces a non-blocking cma_release_nowait(), which
postpones the cma bitmap clearance. It's done later from a work
context. The first page in the cma allocation is used to store
the work struct. Because CMA allocations and de-allocations are
usually not that frequent, a single global workqueue is used.

To make sure that subsequent cma_alloc() call will pass, cma_alloc()
flushes the cma_release_wq workqueue. To avoid a performance
regression in the case when only cma_release() is used, gate it
by a per-cma area flag, which is set by the first call
of cma_release_nowait().

Signed-off-by: Roman Gushchin <guro@fb.com>
[mike.kravetz@oracle.com: rebased to v5.12-rc3-mmotm-2021-03-17-22-24]
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/cma.h |  2 +
 mm/cma.c            | 93 +++++++++++++++++++++++++++++++++++++++++++++
 mm/cma.h            |  5 +++
 3 files changed, 100 insertions(+)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 217999c8a762..497eca478c2f 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -47,6 +47,8 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 			      bool no_warn);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
+extern bool cma_release_nowait(struct cma *cma, const struct page *pages,
+			       unsigned int count);
 
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
 #endif
diff --git a/mm/cma.c b/mm/cma.c
index 90e27458ddb7..14cc8e901703 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -36,9 +36,18 @@
 
 #include "cma.h"
 
+struct cma_clear_bitmap_work {
+	struct work_struct work;
+	struct cma *cma;
+	unsigned long pfn;
+	unsigned int count;
+};
+
 struct cma cma_areas[MAX_CMA_AREAS];
 unsigned cma_area_count;
 
+struct workqueue_struct *cma_release_wq;
+
 phys_addr_t cma_get_base(const struct cma *cma)
 {
 	return PFN_PHYS(cma->base_pfn);
@@ -146,6 +155,10 @@ static int __init cma_init_reserved_areas(void)
 	for (i = 0; i < cma_area_count; i++)
 		cma_activate_area(&cma_areas[i]);
 
+	cma_release_wq = create_workqueue("cma_release");
+	if (!cma_release_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 core_initcall(cma_init_reserved_areas);
@@ -203,6 +216,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 
 	cma->base_pfn = PFN_DOWN(base);
 	cma->count = size >> PAGE_SHIFT;
+	cma->flags = 0;
 	cma->order_per_bit = order_per_bit;
 	*res_cma = cma;
 	cma_area_count++;
@@ -452,6 +466,14 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		goto out;
 
 	for (;;) {
+		/*
+		 * If the CMA bitmap is cleared asynchronously after
+		 * cma_release_nowait(), cma release workqueue has to be
+		 * flushed here in order to make the allocation succeed.
+		 */
+		if (test_bit(CMA_DELAYED_RELEASE, &cma->flags))
+			flush_workqueue(cma_release_wq);
+
 		mutex_lock(&cma->lock);
 		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
 				bitmap_maxno, start, bitmap_count, mask,
@@ -552,6 +574,77 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
 	return true;
 }
 
+static void cma_clear_bitmap_fn(struct work_struct *work)
+{
+	struct cma_clear_bitmap_work *w;
+
+	w = container_of(work, struct cma_clear_bitmap_work, work);
+
+	cma_clear_bitmap(w->cma, w->pfn, w->count);
+
+	__free_page(pfn_to_page(w->pfn));
+}
+
+/**
+ * cma_release_nowait() - release allocated pages without blocking
+ * @cma:   Contiguous memory region for which the allocation is performed.
+ * @pages: Allocated pages.
+ * @count: Number of allocated pages.
+ *
+ * Similar to cma_release(), this function releases memory allocated
+ * by cma_alloc(), but unlike cma_release() is non-blocking and can be
+ * called from an atomic context.
+ * It returns false when provided pages do not belong to contiguous area
+ * and true otherwise.
+ */
+bool cma_release_nowait(struct cma *cma, const struct page *pages,
+			unsigned int count)
+{
+	struct cma_clear_bitmap_work *work;
+	unsigned long pfn;
+
+	if (!cma || !pages)
+		return false;
+
+	pr_debug("%s(page %p)\n", __func__, (void *)pages);
+
+	pfn = page_to_pfn(pages);
+
+	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
+		return false;
+
+	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
+
+	/*
+	 * Set CMA_DELAYED_RELEASE flag: subsequent cma_alloc()'s
+	 * will wait for the async part of cma_release_nowait() to
+	 * finish.
+	 */
+	if (unlikely(!test_bit(CMA_DELAYED_RELEASE, &cma->flags)))
+		set_bit(CMA_DELAYED_RELEASE, &cma->flags);
+
+	/*
+	 * To make cma_release_nowait() non-blocking, cma bitmap is cleared
+	 * from a work context (see cma_clear_bitmap_fn()). The first page
+	 * in the cma allocation is used to store the work structure,
+	 * so it's released after the cma bitmap clearance. Other pages
+	 * are released immediately as previously.
+	 */
+	if (count > 1)
+		free_contig_range(pfn + 1, count - 1);
+
+	work = (struct cma_clear_bitmap_work *)page_to_virt(pages);
+	INIT_WORK(&work->work, cma_clear_bitmap_fn);
+	work->cma = cma;
+	work->pfn = pfn;
+	work->count = count;
+	queue_work(cma_release_wq, &work->work);
+
+	trace_cma_release(pfn, pages, count);
+
+	return true;
+}
+
 int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 {
 	int i;
diff --git a/mm/cma.h b/mm/cma.h
index 95d1aa2d808a..2063fb5bc985 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -17,6 +17,7 @@ struct cma_stat {
 struct cma {
 	unsigned long   base_pfn;
 	unsigned long   count;
+	unsigned long   flags;
 	unsigned long   *bitmap;
 	unsigned int order_per_bit; /* Order of pages represented by one bit */
 	struct mutex    lock;
@@ -31,6 +32,10 @@ struct cma {
 #endif
 };
 
+enum cma_flags {
+	CMA_DELAYED_RELEASE, /* cma bitmap is cleared asynchronously */
+};
+
 extern struct cma cma_areas[MAX_CMA_AREAS];
 extern unsigned cma_area_count;
 
-- 
2.30.2

