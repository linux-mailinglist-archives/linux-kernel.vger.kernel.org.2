Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0741F3D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355655AbhJARy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:54:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25094 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355583AbhJARyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:54:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191HHgjs012502;
        Fri, 1 Oct 2021 17:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=1iCDNTIR8jU85nLXzn+Ia5d36yp3z4Ajp+MgpSvw5kY=;
 b=L/Uf5yfDmiswNYVSchq8iJb7NaEzopDHBM32VB2Z6QPIHXx+F3UpQlLflwm3gMHsVKgx
 dh+k6I+Jyw2AWvTxUddKsP/D9YvulrgaoMZ1ZI6LlVSUYVri9uLatMSsVG8eAJXm11NU
 OnIp/qusWL9+C+qqEVD4QgS9ZtCwhneuwe8c7TUHeP0JnX2ETYMLGfHoyTRYgexH72Cz
 EJMyK1YHLPRiFiKEdDCFLfsetZ1zMP9+x/Z4vG6Gt+uMOjN0X9gkLSk59Iv4aQAZ0AFH
 DKNTIybyEUeWo1LqjYWa9yxEVeCCj7ybsd3HokAvSBDTMSRylaG1fWPvmVxAxWVQ1zyv Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bdevvg5qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191HjKD2123599;
        Fri, 1 Oct 2021 17:52:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by aserp3030.oracle.com with ESMTP id 3bd5wd0eqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/AoGx+yXyHRoRqbLOUbpLQVB9VTCFRVvQkiJHXEN9vb8kBsU/LEPQdE43RDYd1V+t29CMQn30uGXuD3z0U1BrBJAg2ZdjCLDkIg8tLDAREB8o+FcOlB0wH9wC/M7Co+8qgSwKQ5VN49K/JMmHbugAljrhL5mAuYeXFy1EAjoDzO4vSiaSk5AQj/Yp2BfjMSbXgqmeE/m5b38JzTqculEkLuEFXkRtnCvrjye7ZDML0KM2RQmm3p8Eql1EOLZZ16r+M5GTfAX/5l8am7uwxUtbnEBh5zX1nHUegEkKarW/npIFmg7r4a0nRKrJeqhU5cc3fcC3b3gVYOtN939PSLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iCDNTIR8jU85nLXzn+Ia5d36yp3z4Ajp+MgpSvw5kY=;
 b=BoZVqz7RkYUTsu3ptTU4XSLQ9LCp0prXbQqCBRWubYhWF/ilA5i9NRrU/7znZMLtZjzwgpUTsyWNKoEHoSQs5LPyMo4acmqTztYO0iEUqYilQm6dKkhULs0i3uo9/LEAT/1GZvXCuZI1fkYYxLRUt+C5Vw/TENquk2V6hirRPEjmivQO013SxwL5lemv4us7m+7Mq9txo/zySbMRd4O8iS068e1NpSxUxx0/7LS45VG5s0FyEaxOY8TIQ5YkUmlX8Ky3w5abOq13GQOFtXw/n2NxL8b2KqpLMNOWH4OaAViXbLfVBsGLvdA7SR1uThA6NGRkmS60koIZfosJl26CLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iCDNTIR8jU85nLXzn+Ia5d36yp3z4Ajp+MgpSvw5kY=;
 b=Tz+p5JV3LJSlXznQsgfsi4x/k1ytfNnfEHRwY2DuYVFmbJydn4djLQYd0Mfdf1d9mk7MuWAPsSwJJeQhHyMNbt7W15+AOHXcl7ty4um4hR2Vy6C7vHQD4JjcpqReKinoTrqowiwWRum+T9CNaU1+NnG6RiPZwYz3mgdfbpIeSXc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
 by CH0PR10MB5228.namprd10.prod.outlook.com (2603:10b6:610:db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 1 Oct
 2021 17:52:41 +0000
Received: from CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73]) by CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73%9]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 17:52:41 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 5/5] hugetlb: add hugetlb demote page support
Date:   Fri,  1 Oct 2021 10:52:10 -0700
Message-Id: <20211001175210.45968-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001175210.45968-1-mike.kravetz@oracle.com>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0060.namprd22.prod.outlook.com
 (2603:10b6:300:12a::22) To CH2PR10MB4200.namprd10.prod.outlook.com
 (2603:10b6:610:a5::9)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR22CA0060.namprd22.prod.outlook.com (2603:10b6:300:12a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 17:52:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a75fcd4-7137-4040-eddc-08d9850443c7
X-MS-TrafficTypeDiagnostic: CH0PR10MB5228:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB52281F1C7B0954005984F0F5E2AB9@CH0PR10MB5228.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYjFci1EB7mmkSt7lzxWh4gRy/alMrwcTxp9G21O1B490MoDGAzkrvVqz5nZ0AdDtRxpd72R+UagP3yucenZNoOl2iXjcCdFIXkB4puC+ToLwqJqDo7qftDKK35+tgDB49f7r7uBAQmIHQkqK3lKAxEwnAXKlAmphB1byJ/mlXH1JUcQe3ZfTAlcUxglm571izxLjI0sreEdG4NBu3SAHmC9ys+YJsX7DQVI4sHun5GqyjmKZGMIrnp02XXGxx7yYyJyVbIgS5KFTYg8iCjufp5Ue1m5lXAotphOFwx0dJvfw4nxtBgR2M2ZilOh/KGIrTahCbQEWQ96r/M0VcbruurTx+Ci4OxgpdpFH0OnAc03jc+2s1NzM4XsFvxETvgk2mx1QglpvDlyeJ5jT4h6JN3kp3P87nyj5AWkfzuvUA+5lsBwOkhzf16UaFA8HYq5gtgR3nI+NROLH2W0ykw7YCyVGm6UV8MImOcE7Q7Uosn10jQ1hRLwQaMhFxoqLGvm02lxgiSASx6FHEvxjQCIV6aOARFOzzoReJVpmYJUX5tyW46nbBiu3qYF2iw+312DB4FOjxGwiDjzPh9gp+QlhtL6KN3FENwcp97cmqlxEcx8Zkn+cJVOV/hBMYrBPEykCDkxxBE6aJum3YpHk/8FlpSzPJjiCITttvxQImoTZZiaOOmTUimgfB0n4gS30qyitnpCr/MxjEbbPZ+mAY2O0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4200.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(508600001)(956004)(2616005)(1076003)(83380400001)(66946007)(66556008)(66476007)(2906002)(26005)(86362001)(8936002)(44832011)(186003)(107886003)(4326008)(54906003)(7416002)(6486002)(38100700002)(38350700002)(52116002)(8676002)(316002)(7696005)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DVcpYOtz5anrMjTr2UcTy5hVT3NI8UMdJJWB3VWIdd/8uzOti/ZwnGwqiQzn?=
 =?us-ascii?Q?8WmHUe5JZTtBwNblZjQHA9W3lC4AWi35LR6HWu58CLu3Yxl7QsGn0QXO5sec?=
 =?us-ascii?Q?V6xlZYKnX5PClLqX1y7pU1PG1DTE6DGX7OpD2E/cwrFmeweA52o9daPjnVwt?=
 =?us-ascii?Q?UY3yZT9D/gzx101H1r6K/qPPjb6fb8dc6/sls3xMwSsoe9A0bAt9hB8l3aPq?=
 =?us-ascii?Q?9HS6g99P+J279cQRMod+gV7SemnfW84xnu8gUsMdWrHsjQ4jcvsa8ZySHigV?=
 =?us-ascii?Q?k04tZw5DdSIdj+N1RsyLwN0MaYfgDToWqAggQkNdEuc+npfQdxbDsbrHDYn0?=
 =?us-ascii?Q?5YP73Iu/4LFzSVCpe5VTsai5kfRWJtBF7ttr+5zm2dtUcLQN+brOtLqwyP7Y?=
 =?us-ascii?Q?ONj1bzBI8FA/8+p5lCn7nN4SZo3b1Nx+QBs51BYprPOiHJ9vICKaIWGG0pbq?=
 =?us-ascii?Q?7LQWMSGpLz1lPEMQRsojnOIs22A7TK9SfkQy34VYpd+bYXTxu1kV5nsvow36?=
 =?us-ascii?Q?Mww2TDvwhytZR95RST9bl1WejiFcEk3VpAX0JSdCHA2RSc3UG+eiMkCVBZmb?=
 =?us-ascii?Q?5TlhUv9JfeqJdK+y+Ky/msdlwV2DYYBtsX7zKarnwOB+IUju/bd02laFtrXt?=
 =?us-ascii?Q?HQjQJgqMbgLc2sZLW/oPUOp8MYy140uOMsdmzpBUib1+5WRjwid+r1IDsCy2?=
 =?us-ascii?Q?7o5vbfaVyu0RiasleSfjCf3LNS1132LS1vpsxKwrAiBACRZ9JCAUcQK5ArZe?=
 =?us-ascii?Q?DYq89+VQ6N7d4NM43ogmlctoSgemBj1P7tYHeECVTpDdvccqfqrzkM+A6wKP?=
 =?us-ascii?Q?yJl9ThKK4bmOycx2aA5G+9pYXq0F+jQT7Xr/5F+CuWbvDSKzIYLgDcULeTYU?=
 =?us-ascii?Q?0iMB9e79tRj7KJjUhYNalvs3tmfu9/C/jY+D8YxiViPkNDTd4FJKsIOCEfEz?=
 =?us-ascii?Q?wTr6cZ6xypF2jOf4vtMJJHd9FmWbRtG2cg+EBwvpOV806nlx0DTZyiTo1RPy?=
 =?us-ascii?Q?NBGZmx7/aKHY/YfEASmAM+ZbazcZHTOAL7gX5bTGPRrDWgvKf9Y8+CSOyVaY?=
 =?us-ascii?Q?/7ezzAKJI8v9LTyN4QKUoS0x2c0oaV+F8n6cjGdaehGMo1HSRbbgKrocwQ+t?=
 =?us-ascii?Q?3iXnSN5Gadig+/NOCAeZEhKwKeTXqKR6loHtfHeS6Vx8kgbiouJVTV2ikeLm?=
 =?us-ascii?Q?88gqjxG28ItCiNKvz0Hm0FIGblGHafTGY636DAq7iiF8qPPQq74dtspTdLlp?=
 =?us-ascii?Q?c7Wc0uOd7bwNZgwameW7C7t0xnwsHjc4Ac7AfmM7yY7y1X9ovwwBJSzBw24N?=
 =?us-ascii?Q?YyLlmXb4pjZd03A4xoIMjSuq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a75fcd4-7137-4040-eddc-08d9850443c7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4200.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 17:52:41.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYVBGG+xJCbacu04jFo9CJ+8sew0bvdU+UzaSioGWyO4pFmnPU1QuJeppnYfiYaEfz3NIrDsObYc8tzj8G/RvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5228
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010127
X-Proofpoint-ORIG-GUID: St_A1tA4ghp0wTFPHsH-OJbtmyb0w3XQ
X-Proofpoint-GUID: St_A1tA4ghp0wTFPHsH-OJbtmyb0w3XQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote page functionality will split a huge page into a number of huge
pages of a smaller size.  For example, on x86 a 1GB huge page can be
demoted into 512 2M huge pages.  Demotion is done 'in place' by simply
splitting the huge page.

Added '*_for_demote' wrappers for remove_hugetlb_page,
destroy_compound_gigantic_page and prep_compound_gigantic_page for use
by demote code.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ccbe323c992b..aec2e737d0cd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1270,7 +1270,7 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
 		nr_nodes--)
 
-#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
+/* used to demote non-gigantic_huge pages as well */
 static void __destroy_compound_gigantic_page(struct page *page,
 					unsigned int order, bool demote)
 {
@@ -1293,6 +1293,13 @@ static void __destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
+static void destroy_compound_gigantic_page_for_demote(struct page *page,
+					unsigned int order)
+{
+	__destroy_compound_gigantic_page(page, order, true);
+}
+
+#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 static void destroy_compound_gigantic_page(struct page *page,
 					unsigned int order)
 {
@@ -1438,6 +1445,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	__remove_hugetlb_page(h, page, adjust_surplus, false);
 }
 
+static void remove_hugetlb_page_for_demote(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	__remove_hugetlb_page(h, page, adjust_surplus, true);
+}
+
 static void add_hugetlb_page(struct hstate *h, struct page *page,
 			     bool adjust_surplus)
 {
@@ -1779,6 +1792,12 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 	return __prep_compound_gigantic_page(page, order, false);
 }
 
+static bool prep_compound_gigantic_page_for_demote(struct page *page,
+							unsigned int order)
+{
+	return __prep_compound_gigantic_page(page, order, true);
+}
+
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for normal or
  * transparent huge pages.  See the PageTransHuge() documentation for more
@@ -3302,9 +3321,54 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
+static int demote_free_huge_page(struct hstate *h, struct page *page)
+{
+	int i, nid = page_to_nid(page);
+	struct hstate *target_hstate;
+	int rc = 0;
+
+	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
+
+	remove_hugetlb_page_for_demote(h, page, false);
+	spin_unlock_irq(&hugetlb_lock);
+
+	rc = alloc_huge_page_vmemmap(h, page);
+	if (rc) {
+		/* Allocation of vmemmmap failed, we can not demote page */
+		spin_lock_irq(&hugetlb_lock);
+		set_page_refcounted(page);
+		add_hugetlb_page(h, page, false);
+		return rc;
+	}
+
+	/*
+	 * Use destroy_compound_gigantic_page_for_demote for all huge page
+	 * sizes as it will not ref count pages.
+	 */
+	destroy_compound_gigantic_page_for_demote(page, huge_page_order(h));
+
+	for (i = 0; i < pages_per_huge_page(h);
+				i += pages_per_huge_page(target_hstate)) {
+		if (hstate_is_gigantic(target_hstate))
+			prep_compound_gigantic_page_for_demote(page + i,
+							target_hstate->order);
+		else
+			prep_compound_page(page + i, target_hstate->order);
+		set_page_private(page + i, 0);
+		set_page_refcounted(page + i);
+		prep_new_huge_page(target_hstate, page + i, nid);
+		put_page(page + i);
+	}
+
+	spin_lock_irq(&hugetlb_lock);
+	return rc;
+}
+
 static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	__must_hold(&hugetlb_lock)
 {
+	int nr_nodes, node;
+	struct page *page;
 	int rc = 0;
 
 	lockdep_assert_held(&hugetlb_lock);
@@ -3313,9 +3377,15 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	if (!h->demote_order)
 		return rc;
 
-	/*
-	 * TODO - demote fucntionality will be added in subsequent patch
-	 */
+	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
+		if (!list_empty(&h->hugepage_freelists[node])) {
+			page = list_entry(h->hugepage_freelists[node].next,
+					struct page, lru);
+			rc = !demote_free_huge_page(h, page);
+			break;
+		}
+	}
+
 	return rc;
 }
 
@@ -3550,10 +3620,6 @@ static ssize_t demote_store(struct kobject *kobj,
 		/*
 		 * Check for available pages to demote each time thorough the
 		 * loop as demote_pool_huge_page will drop hugetlb_lock.
-		 *
-		 * NOTE: demote_pool_huge_page does not yet drop hugetlb_lock
-		 * but will when full demote functionality is added in a later
-		 * patch.
 		 */
 		if (nid != NUMA_NO_NODE)
 			nr_available = h->free_huge_pages_node[nid];
-- 
2.31.1

