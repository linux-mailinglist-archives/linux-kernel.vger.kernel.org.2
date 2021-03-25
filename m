Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267F93485E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbhCYAaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:30:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39920 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbhCYA3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:29:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0OviV093935;
        Thu, 25 Mar 2021 00:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=r/8OLNAJDeRx2ccXwm1+xJZ3IzsTZihzPyH6mnbq5ro=;
 b=GyN2zOZ2XOTpyotA0ewWqpcQ7JDzkFAfxHLwhq5jqllM2iPdIJRbM852zAO57Pgbqzke
 YVG81KGecYNmdENQwq3CdoUezCCUGuzTymA3uDU4qpD7uoUyoAcgeIYjd1P1h0xC6C0t
 cCdNluL/F6TH5YJlFgVgrCTZZcOp50Ovm6/2yEPVH5LUfPxR8RpmABUwgGKVZZAvD92o
 soIFGxrNJ179b3TkgYqTd6upzgwkKNMx8xsmPFnKyQz33JC9UhuwucnHlAGmVIPZFISu
 m3A+ZWglly2I8ABfMEeXO+B5sWoQwC+TzogU239pUnTG8u7WQqZoF+84CoH0Mu9vfNeh Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37d8frcn7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0QTDS040331;
        Thu, 25 Mar 2021 00:29:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 37dty18p2t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7Y0DtsLKuf0QXu4QLa9yEguXWO4eYtg7aGz8PTXh+Nkz9t8u1kmctoiynRleIpVSY3XqqSCzvKfUrFkVBrgnfNDAMg0u5dbEg1aWyxTGdF1uBJups+zJx1jNnXKc7vmce/xmH3KL5RpZca0aVKp10y4CfTVOAAZEG5TaLF1XH/xIuDUpm+qdfnE7QLvtXP9zHMQhatj5wq+W8h3on3zh+QSOm1d9GV6zfFGxvu0kvzNTmX6XBnagGS6bB5iZPWMptP3+Zun01OpjD9jZI/tGxtMD/I9qEwo+xZ14O1FS+fxB2lwxmaQdqmUMCtUhXP3DhbecXt8Lz1NKSs31cc4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/8OLNAJDeRx2ccXwm1+xJZ3IzsTZihzPyH6mnbq5ro=;
 b=oMPke/CnyOwUOOt3gRF7VDcTpkAGGQQjVpcw58TCwmARXHZ6Qf0y/xK+8SLdPIlNK4xmb+JxbyYqM8a6ev69frcNwQVTXCIZRirDR6hKWGD1nCMeuMzCOiqV8Hut4sa3wF1FE4z251G+0az7r6kNxtBCHc7OF65gQm1BBPrd6fiGzpV72oIUQmk44Bl81ahspy6gVlXQCL3eULwXK4H4QOH9PBtRUJKdpjdu8GZUFkdrGEsO+K2tua/XSUGsVdQKariyGzCmhGeimQ5hBDGoPvI7BUbpNoBpkoQdkwOnkCe4YBSiv6OG0+ydF3MR5Esw2PuwicriAUoY3hol5rd/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/8OLNAJDeRx2ccXwm1+xJZ3IzsTZihzPyH6mnbq5ro=;
 b=W6Z7ShqWVlLitsu9XxN780FjOv+auATr0vCI9q1kWr5N5jOH0a4aYAh0RXrY8TROT0p7WK21qUylX9s0YLiSi25IxBufFLmjLTpn/HuDMgG01qYX+RreJOMV2+qUSIupFMk5LTjEIVhXssaHA8ULZYKQSRAMkKut/GRqcxfAZDE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3875.namprd10.prod.outlook.com (2603:10b6:a03:1f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 00:29:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 00:29:07 +0000
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
Subject: [PATCH 7/8] hugetlb: make free_huge_page irq safe
Date:   Wed, 24 Mar 2021 17:28:34 -0700
Message-Id: <20210325002835.216118-8-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 00:29:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d49743ef-cf85-4e0a-ace2-08d8ef24ffa9
X-MS-TrafficTypeDiagnostic: BY5PR10MB3875:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB387562119C4472C8D5D834EDE2629@BY5PR10MB3875.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0hDwuSaNHAxfA0ki67Qp32oOR4G0IH096T8jCmnNA9IDSEZQaD6ItLcnF5l8d+XDsSzUFnLyM15YtxAoVZT538SksjTu/xCkBKVLUj7vmjjzmiXNvUTbM16bAuZUoKCAHZmphEGGA1uwEFNiQC47ySCNzbDqWW1vawG0M1Cr21wNwRhswjm0fvE+iwuLI3SyQAwWn+eBtr58HXQpVXeGaYMUrpWjq/TPlDqkcuOotlJRiKnP8iDqm+u/noeZFZGRPt5hrTgpihCVgDlqBoGxy9WIg5383k/p2qdSJPsthiO1d8IrT3ItD9IBsrBmY5eGFsrLSDp5YObCkS2/SromRGP9WNFUFt+UwTOT/W45Z1TY6mViyW2QqAGfiWHjuTuikUhul+VeLlRu/C3Z8GPQRuCP5e27QYMFGqInbO8Bzx664VYb5Y3zZHlL3JaMO/4s4F80QeXnhLDeInz8aTVBQDU4+25k+YF2HtmYnem7UcFBtcj3vn8l10WaQiV7jKwQHzJnwmTlv6S+rZF8CmImDLXCpuIpS3WJYfqCSBxZAplVmZtokl5zjD1rFczhlH2YNTKIfZ7clUXKP9+xvXVKhgWdKQYgN4aJjRtGJZ8Y+kHy/Ep3gW6WgxkvGC/vM7UHCrHsQgQoyigML72qN+cp03/E1VFROfFutXPC2iBRF3LC3WBmv2VA43x86u0zpxAkiCqWkvw6o508tfCQHfO4I+Iv1bX5nGkLtxNfQY4BHuhlnSTUAQSN/9Ph3JjTWDi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(366004)(136003)(83380400001)(6486002)(52116002)(186003)(4326008)(66946007)(7696005)(2906002)(26005)(16526019)(66556008)(6666004)(5660300002)(66476007)(8936002)(44832011)(36756003)(316002)(478600001)(30864003)(54906003)(2616005)(8676002)(1076003)(86362001)(38100700001)(956004)(966005)(7416002)(107886003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xOXSlXxTktwBszMTT5G8Hy7k41S85cf4MAll7PoSh+7x3ewesM7uUlwZ46i6?=
 =?us-ascii?Q?WLsQaqlUy4fmI0k5trzjdcZS4h3p1JzogsNFwMLCfu7++8G3WTWHBrvQqJHt?=
 =?us-ascii?Q?WHoWcpO+z8E4AXBJvjq8ymr8MdBjp+j2CmnjFlbmAHdr7sbNlF4vI8MZoO2m?=
 =?us-ascii?Q?/Eg+gGtFTww0W5PBR2OMd8OFP92E0rEBm2+RFKCM28HQjLPbh1Mpa2y2HEg/?=
 =?us-ascii?Q?PFv60ushDmAgmYeendFaWhM2qYIKE787izr8vkJ41jupTJ9cyjtUhHvgPOWd?=
 =?us-ascii?Q?kFalhHTPmSXA+qwSl3xI8aU/YHX9H98X0xAjDCKjc/dnLuOcAqOX7NH4NOO/?=
 =?us-ascii?Q?CBPbUD4eRzV3/QBOomXD2f1YKHrh6PpwfqfXnAZpvQ/9tcmFO8rso3Ffhbi8?=
 =?us-ascii?Q?z8iwjAmBZchXcXdpl18Tu7pGGS7cMojhjGy8YMEaN8tsLXfQklMBiIT+JCrw?=
 =?us-ascii?Q?VeVD4oL2/bUj5ZzNg82ApTMJGMp3AvxSffSnPo7B4aawYL3mA+S9w3kQEPnE?=
 =?us-ascii?Q?q2gWRPmqGWQRjUKU5q5mHuPDP/vb8Z5um/aW6D+OtxR8al56bLgmS/vn8LOn?=
 =?us-ascii?Q?O1PxcJepIhuO4FFmGouJfQOlWkDMa8/iDRLDig99S0j4AIUyVvw6N4hOeVLc?=
 =?us-ascii?Q?VRwqIvoizUPo/Bpe9sqMNwqSUpCio8A2qsQYsIrV0yFtkorI0ZQXVubG4RhK?=
 =?us-ascii?Q?rwLK7YoK0NENOrvZYU70oSaN2o+3NwfMHKulfa/e049ypxNAEcqKRzqL825Q?=
 =?us-ascii?Q?6CbbCPjnJ/neEtId8aKkTal9ipQuCy04JdTO0kc4jzRE14n+ooKvexyTdmRh?=
 =?us-ascii?Q?aj4p/uKJumu0oQt6lJk5OVYCdMiZt1OpQkenhpFKiOeFBb/p3GzU4KM/2uYj?=
 =?us-ascii?Q?XGabvBj/wkZWG7zQI2CoBDL8NeZo512jjnotn7bAT1mUTk01LaGNiKgHWyti?=
 =?us-ascii?Q?XkhCezk78qu6UkANbiCUkpJBClbWf4Z7VyHdmSxdw07FulcaL44du/vtm0JE?=
 =?us-ascii?Q?0yoW1DcZhE+fWiu6exphe0DK1zpOiIu4nxDCaGZrLcviFd2Xc44tP+uizlLU?=
 =?us-ascii?Q?sGaZW2ZCzvcfWwB1yP/rw6Ia6UkrXbuyhJMiw65krSOPSWd0HOB+sal9nMoC?=
 =?us-ascii?Q?XOFXRBBmjyyFCbBEyq8F14b0Jx/RkmAXFGzQSur8TR349Yf4uSmScQiuFFpH?=
 =?us-ascii?Q?4WFrp4NVFualxoGqBE4GeKdAkKOSPH21c9hhjBp+Xl1jsY3wKqLggYssI845?=
 =?us-ascii?Q?OGewxTiFTK+xOajeflYcyzOe2sJXXQbarFqxtfNl7MpSbPo4IylGyAtD8snL?=
 =?us-ascii?Q?JrW3ktR9BrSmT2ifVIHqDBX2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49743ef-cf85-4e0a-ace2-08d8ef24ffa9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:29:06.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndNQZ29Aepf6PmTRtDQBTi5yw3Xh38devvc2qnhE13yZoBJgFGBGrD0Pk7hI8dJOJKWBJB2i5JHkJcyIR0E0LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3875
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
non-task context") was added to address the issue of free_huge_page
being called from irq context.  That commit hands off free_huge_page
processing to a workqueue if !in_task.  However, as seen in [1] this
does not cover all cases.  Instead, make the locks taken in the
free_huge_page irq safe.

This patch does the following:
- Make hugetlb_lock irq safe.  This is mostly a simple process of
  changing spin_*lock calls to spin_*lock_irq* calls.
- Make subpool lock irq safe in a similar manner.
- Revert the !in_task check and workqueue handoff.

[1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c        | 169 +++++++++++++++++---------------------------
 mm/hugetlb_cgroup.c |   8 +--
 2 files changed, 67 insertions(+), 110 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a9785e73379f..e4c441b878f2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -93,9 +93,10 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
 	return true;
 }
 
-static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
+static inline void unlock_or_release_subpool(struct hugepage_subpool *spool,
+						unsigned long irq_flags)
 {
-	spin_unlock(&spool->lock);
+	spin_unlock_irqrestore(&spool->lock, irq_flags);
 
 	/* If no pages are used, and no other handles to the subpool
 	 * remain, give up any reservations based on minimum size and
@@ -134,10 +135,12 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 
 void hugepage_put_subpool(struct hugepage_subpool *spool)
 {
-	spin_lock(&spool->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&spool->lock, flags);
 	BUG_ON(!spool->count);
 	spool->count--;
-	unlock_or_release_subpool(spool);
+	unlock_or_release_subpool(spool, flags);
 }
 
 /*
@@ -156,7 +159,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
 	if (!spool)
 		return ret;
 
-	spin_lock(&spool->lock);
+	spin_lock_irq(&spool->lock);
 
 	if (spool->max_hpages != -1) {		/* maximum size accounting */
 		if ((spool->used_hpages + delta) <= spool->max_hpages)
@@ -183,7 +186,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
 	}
 
 unlock_ret:
-	spin_unlock(&spool->lock);
+	spin_unlock_irq(&spool->lock);
 	return ret;
 }
 
@@ -197,11 +200,12 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
 				       long delta)
 {
 	long ret = delta;
+	unsigned long flags;
 
 	if (!spool)
 		return delta;
 
-	spin_lock(&spool->lock);
+	spin_lock_irqsave(&spool->lock, flags);
 
 	if (spool->max_hpages != -1)		/* maximum size accounting */
 		spool->used_hpages -= delta;
@@ -222,7 +226,7 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
 	 * If hugetlbfs_put_super couldn't free spool due to an outstanding
 	 * quota reference, free it now.
 	 */
-	unlock_or_release_subpool(spool);
+	unlock_or_release_subpool(spool, flags);
 
 	return ret;
 }
@@ -1401,7 +1405,7 @@ struct hstate *size_to_hstate(unsigned long size)
 	return NULL;
 }
 
-static void __free_huge_page(struct page *page)
+void free_huge_page(struct page *page)
 {
 	/*
 	 * Can't pass hstate in here because it is called from the
@@ -1411,6 +1415,7 @@ static void __free_huge_page(struct page *page)
 	int nid = page_to_nid(page);
 	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
 	bool restore_reserve;
+	unsigned long flags;
 
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
@@ -1439,7 +1444,7 @@ static void __free_huge_page(struct page *page)
 			restore_reserve = true;
 	}
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	ClearHPageMigratable(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
@@ -1450,66 +1455,18 @@ static void __free_huge_page(struct page *page)
 
 	if (HPageTemporary(page)) {
 		remove_hugetlb_page(h, page, false);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		remove_hugetlb_page(h, page, true);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
-		spin_unlock(&hugetlb_lock);
-	}
-}
-
-/*
- * As free_huge_page() can be called from a non-task context, we have
- * to defer the actual freeing in a workqueue to prevent potential
- * hugetlb_lock deadlock.
- *
- * free_hpage_workfn() locklessly retrieves the linked list of pages to
- * be freed and frees them one-by-one. As the page->mapping pointer is
- * going to be cleared in __free_huge_page() anyway, it is reused as the
- * llist_node structure of a lockless linked list of huge pages to be freed.
- */
-static LLIST_HEAD(hpage_freelist);
-
-static void free_hpage_workfn(struct work_struct *work)
-{
-	struct llist_node *node;
-	struct page *page;
-
-	node = llist_del_all(&hpage_freelist);
-
-	while (node) {
-		page = container_of((struct address_space **)node,
-				     struct page, mapping);
-		node = node->next;
-		__free_huge_page(page);
-	}
-}
-static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
-
-void free_huge_page(struct page *page)
-{
-	/*
-	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
-	 */
-	if (!in_task()) {
-		/*
-		 * Only call schedule_work() if hpage_freelist is previously
-		 * empty. Otherwise, schedule_work() had been called but the
-		 * workfn hasn't retrieved the list yet.
-		 */
-		if (llist_add((struct llist_node *)&page->mapping,
-			      &hpage_freelist))
-			schedule_work(&free_hpage_work);
-		return;
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 	}
-
-	__free_huge_page(page);
 }
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
@@ -1519,11 +1476,11 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	hugetlb_set_page_subpool(page, NULL);
 	set_hugetlb_cgroup(page, NULL);
 	set_hugetlb_cgroup_rsvd(page, NULL);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	ClearHPageFreed(page);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 }
 
 static void prep_compound_gigantic_page(struct page *page, unsigned int order)
@@ -1769,7 +1726,7 @@ int dissolve_free_huge_page(struct page *page)
 	if (!PageHuge(page))
 		return 0;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (!PageHuge(page)) {
 		rc = 0;
 		goto out;
@@ -1786,7 +1743,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * when it is dissolved.
 		 */
 		if (unlikely(!HPageFreed(head))) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			cond_resched();
 
 			/*
@@ -1810,12 +1767,12 @@ int dissolve_free_huge_page(struct page *page)
 		}
 		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		update_and_free_page(h, head);
 		return 0;
 	}
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return rc;
 }
 
@@ -1857,16 +1814,16 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages)
 		goto out_unlock;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * We could have raced with the pool size change.
 	 * Double check that and simply deallocate the new page
@@ -1876,7 +1833,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
 		SetHPageTemporary(page);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		put_page(page);
 		return NULL;
 	} else {
@@ -1885,7 +1842,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	}
 
 out_unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return page;
 }
@@ -1935,17 +1892,17 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 		nodemask_t *nmask, gfp_t gfp_mask)
 {
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
 		struct page *page;
 
 		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
 		if (page) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			return page;
 		}
 	}
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
 }
@@ -1993,7 +1950,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 
 	ret = -ENOMEM;
 retry:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
 		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
 				NUMA_NO_NODE, NULL);
@@ -2010,7 +1967,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	 * After retaking hugetlb_lock, we need to recalculate 'needed'
 	 * because either resv_huge_pages or free_huge_pages may have changed.
 	 */
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) -
 			(h->free_huge_pages + allocated);
 	if (needed > 0) {
@@ -2050,12 +2007,12 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		enqueue_huge_page(h, page);
 	}
 free:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	/* Free unnecessary surplus pages to the buddy allocator */
 	list_for_each_entry_safe(page, tmp, &surplus_list, lru)
 		put_page(page);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 
 	return ret;
 }
@@ -2107,13 +2064,13 @@ static void return_unused_surplus_pages(struct hstate *h,
 	}
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	list_for_each_entry_safe(page, t_page, &page_list, lru) {
 		list_del(&page->lru);
 		update_and_free_page(h, page);
 		cond_resched();
 	}
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 }
 
 
@@ -2348,7 +2305,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	if (ret)
 		goto out_uncharge_cgroup_reservation;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * glb_chg is passed to indicate whether or not a page must be taken
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
@@ -2356,7 +2313,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
 	if (!page) {
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
 		if (!page)
 			goto out_uncharge_cgroup;
@@ -2364,7 +2321,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			SetHPageRestoreReserve(page);
 			h->resv_huge_pages--;
 		}
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		list_add(&page->lru, &h->hugepage_activelist);
 		/* Fall through */
 	}
@@ -2377,7 +2334,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 						  h_cg, page);
 	}
 
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	hugetlb_set_page_subpool(page, spool);
 
@@ -2591,13 +2548,13 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	}
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	list_for_each_entry_safe(page, next, &page_list, lru) {
 		list_del(&page->lru);
 		update_and_free_page(h, page);
 		cond_resched();
 	}
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 }
 #else
 static inline void try_to_free_low(struct hstate *h, unsigned long count,
@@ -2659,7 +2616,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 
 	/* mutex prevents concurrent adjustments for the same hstate */
 	mutex_lock(&h->mutex);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 
 	/*
 	 * Check for a node specific request.
@@ -2690,7 +2647,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 */
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			mutex_unlock(&h->mutex);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
@@ -2720,14 +2677,14 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		 * page, free_huge_page will handle it by freeing the page
 		 * and reducing the surplus.
 		 */
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
 		ret = alloc_pool_huge_page(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		if (!ret)
 			goto out;
 
@@ -2768,13 +2725,13 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		list_add(&page->lru, &page_list);
 	}
 	/* free the pages after dropping lock */
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	list_for_each_entry_safe(page, t_page, &page_list, lru) {
 		list_del(&page->lru);
 		update_and_free_page(h, page);
 		cond_resched();
 	}
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 
 	while (count < persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, 1))
@@ -2782,7 +2739,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	mutex_unlock(&h->mutex);
 
 	NODEMASK_FREE(node_alloc_noretry);
@@ -2938,9 +2895,9 @@ static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
 	if (err)
 		return err;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	h->nr_overcommit_huge_pages = input;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return count;
 }
@@ -3527,9 +3484,9 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 		goto out;
 
 	if (write) {
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		h->nr_overcommit_huge_pages = tmp;
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 	}
 out:
 	return ret;
@@ -3625,7 +3582,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	if (!delta)
 		return 0;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	/*
 	 * When cpuset is configured, it breaks the strict hugetlb page
 	 * reservation as the accounting is done on a global variable. Such
@@ -3664,7 +3621,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 		return_unused_surplus_pages(h, (unsigned long) -delta);
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return ret;
 }
 
@@ -5727,7 +5684,7 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 {
 	bool ret = true;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (!PageHeadHuge(page) ||
 	    !HPageMigratable(page) ||
 	    !get_page_unless_zero(page)) {
@@ -5737,16 +5694,16 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 	ClearHPageMigratable(page);
 	list_move_tail(&page->lru, list);
 unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return ret;
 }
 
 void putback_active_hugepage(struct page *page)
 {
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	SetHPageMigratable(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	put_page(page);
 }
 
@@ -5780,12 +5737,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		 */
 		if (new_nid == old_nid)
 			return;
-		spin_lock(&hugetlb_lock);
+		spin_lock_irq(&hugetlb_lock);
 		if (h->surplus_huge_pages_node[old_nid]) {
 			h->surplus_huge_pages_node[old_nid]--;
 			h->surplus_huge_pages_node[new_nid]++;
 		}
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 	}
 }
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 726b85f4f303..5383023d0cca 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -204,11 +204,11 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 	do {
 		idx = 0;
 		for_each_hstate(h) {
-			spin_lock(&hugetlb_lock);
+			spin_lock_irq(&hugetlb_lock);
 			list_for_each_entry(page, &h->hugepage_activelist, lru)
 				hugetlb_cgroup_move_parent(idx, h_cg, page);
 
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_irq(&hugetlb_lock);
 			idx++;
 		}
 		cond_resched();
@@ -784,7 +784,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	if (hugetlb_cgroup_disabled())
 		return;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	h_cg = hugetlb_cgroup_from_page(oldhpage);
 	h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
 	set_hugetlb_cgroup(oldhpage, NULL);
@@ -794,7 +794,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	set_hugetlb_cgroup(newhpage, h_cg);
 	set_hugetlb_cgroup_rsvd(newhpage, h_cg_rsvd);
 	list_move(&newhpage->lru, &h->hugepage_activelist);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 	return;
 }
 
-- 
2.30.2

