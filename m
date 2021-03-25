Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD593485DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbhCYA3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:29:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56536 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbhCYA3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:29:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0P3VG005354;
        Thu, 25 Mar 2021 00:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=fDy69tQqeQmirM8UdgckDtRnyaLn8eOm9TxH2BQksXs=;
 b=Y4u1q1GG769GDBTJD0OJg/tuLvIIphmp5QLGRNmhSXRqez2wJyR54y7ZmiHrt7leGHSt
 /gfX/LJs1mCde8InzKp4M9AVp7UJWpXhL+p7gpgqcApdN60GHfFXzxNyhuEEMtTfXHZE
 mkha6bNs4pny+XwnJuoWfxqkEPRp+BBFMPpDS28SkYD2yvE1Qeitm2ykGBTq6NBu4cU0
 aPJqUwdYnc1ulmO/vOlt5KRjoWvJqH2LgZRZEo7ovVgwZnaU7x8T8eBZYuvFO2T+PycS
 mkVr5CprpKNuckP6btLRCIjiI011trpsnDCu5VzPwhWlz5MqBQ+8mYIwR+1mbnbCOxY7 Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37d90mmmcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0QTQ3040269;
        Thu, 25 Mar 2021 00:29:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3020.oracle.com with ESMTP id 37dty18nys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/iM2mX7SvELFRsS4l7HCS2KRliJl5cChw7/ss/VChvxmZM7lePHSkbqQ52A863SMhsbGyARkrJeC0zZma1EGI+k68Sl7KtqRm2SU6cGbxrcaPBOZrJgqztU73V5yqENfm5XPdYGN+nDPeyycI06PGMeeByuh9l4COVwPs305fb4X9+B+Ahb/ia70tgAhpODyJ2I22Qi3uV3vhGFHx53zz+gyUQs34EshhbNjFZMNzNsPc86s1Mi6Ta++3W63PRZ3PlrzDK8RzRQqBLqfUx6DErc2BBRTLrciYJJmnNwFi7esNWrAhp+B5ZnKaUaoR1SvT4xkJrBm4URCp2FZld4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDy69tQqeQmirM8UdgckDtRnyaLn8eOm9TxH2BQksXs=;
 b=QnPzXWaS5W7176LvkKkSo9fjjmPQN7pnHGGzUO8JBnJeDeah40hsmrNMpkMPBSrwvIQmu1A+5yYa7Tx6nue+L0E98ufXaI0FJ3vW2T7FMDUNAw0vXL5n4flYX6ETjkRyErFtiNnXbe/gej4S/VTBHxlOoEDuKiHSdbxtxZ9ilBORxTC5vLbYnqxp+XP03nrIiLZuRAw97QMNCJfymeRfUFwHpedwqsqmrPvBZv5xs73Sf9CHEUmW4J9cHaq4rvLaYb1XRqkCLLg5gY7nY/wr0hfJnrSwKwCh6xtEieXPk/YZG7NrJCqcj2G0kPrg7B2BByeh2eLp/5ocBzSsyzApIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDy69tQqeQmirM8UdgckDtRnyaLn8eOm9TxH2BQksXs=;
 b=j4Xw4hXqo4cgs+O2UiAnVJACItZJYRzFkYxIpE+h9Aa5DMU58Ul/5p5MaT1Nm5WFiQha3z0kGJYtD17WZlU0C2HoHwhZ0JHNF8kJuXepmgosC+1o6XI44E3PCIRP13f1fZfnp3gzd/LBHdRMz6v/ROJnASvmRVo1QUya3QV1Q/U=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3908.namprd10.prod.outlook.com (2603:10b6:a03:1b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 00:28:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 00:28:57 +0000
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
Subject: [PATCH 3/8] hugetlb: add per-hstate mutex to synchronize user adjustments
Date:   Wed, 24 Mar 2021 17:28:30 -0700
Message-Id: <20210325002835.216118-4-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 00:28:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fbb528-6d82-4e48-b0e7-08d8ef24faad
X-MS-TrafficTypeDiagnostic: BY5PR10MB3908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB39085A9926E04454829585A1E2629@BY5PR10MB3908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sc3vEtUHW6QOC8qoD/TuAkyWoZ8nsq1icCGXG6crzlBVEwL818EcN7a8nLtah3wsmjkCvrBDi6xC3vOmqnDTNmeBYmPOw88BONV7kkYL2s1Hm15XGJsDELVCvY2N2D3naP3TNRO1p+KeAN6FPXC8NWxUbDSFA42Ik9D1XbnsrU42osj71ZC1TNaVmtxSJHpEu/Q0/WDxM2a3v3Pp0lL/DbNCvQwG00i/cidVUBLtLYlbfL7C2YVif2aMITv6H3QQFa6ItvIEIWIfWcM7Ykw6sn0Z/AsmPinBB7bTjuykS175Snq5BLEXOx63imTvueXbgC2b/rLH25kaCjQ2AkqEpEjVKf8Dpmc0I1gFKimnstSFLZx/Yd/utvDwJGY17TcpXxDLSMuPuH3YDNKVlCAc8eiT7bmjFQxu+dtlE7VOWAx0732FO7PYHVIHV2gpOyhqiFM3zBG+VlrLqRi1I+GdRroQFoe7+v9gao5bEuHxX9y6aaowps36IfdUJNQ0+1VwnJvf5Rb3tRl0tkfiesEGyyteu6H4vKt4gMKmbeRDQQka7CdaHFVKfVpVlKfaa66x81LldpxQBQsNaJP6dV6yPcbh0V6kax2fHEJ8897LNECj99vIFTYSewdreg778g3h4y4Piu9GUOfVsXrtJlpmDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(346002)(366004)(396003)(86362001)(6486002)(38100700001)(7416002)(6666004)(107886003)(8676002)(4326008)(2616005)(2906002)(956004)(186003)(16526019)(316002)(1076003)(36756003)(66476007)(66946007)(8936002)(478600001)(44832011)(83380400001)(7696005)(5660300002)(66556008)(54906003)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/Bbl3kn2t6mPWwzPDyFxLlMuQ8NK71w/OApSASbAbHUNAbIltOyL6zT4nbQI?=
 =?us-ascii?Q?cpWFWU3Zgn/C2iEJUVaZKCmsSWAHZT8ltIzsTMKYf37exRG96OJt3sUXViZJ?=
 =?us-ascii?Q?HlWR+6Ia9QEkJ5DiGfw4Q5rWPZ4LGUGUqk3aythc7YQDoMHHtfk6AvM3mrlP?=
 =?us-ascii?Q?Kkj3O8/tA9LRuVXp08zIZvvh9qhj04F4MKQ0Yyt6L/WtJ8yRnRpC7hoUwuKI?=
 =?us-ascii?Q?AXmxPzWpkdqR3hi9r2Hx3B1dHFhhAGJ8U+pDXVUToFxvjUyeix5qAY7GKkia?=
 =?us-ascii?Q?Te2Tif0oWHRBp+dkyQdkijcG/x+lE9xZLOpxgZmMte/+sdDdIedWm3p1XrYm?=
 =?us-ascii?Q?WKDiTZYBDtxV4qM5XIDMYcbfiPzszTa0aW7MO0g+l8MK8AC2lW0/WDLErIsR?=
 =?us-ascii?Q?0cD5VKGGSxjejCYjDBAzENcjcIZErZ28qb42sc1lPVrnubQc/Co5Rg8z/Eaf?=
 =?us-ascii?Q?TRQTFVqwxAHaD/WULQK913XMpVEV+PNEaKOUevIPMmuRJPr9wwM/mNZXezbX?=
 =?us-ascii?Q?MHO8lBp/y4n2X/oFdRpKVCZeF348S0t+UE2a2gykCQGCAdA25rB9RjxpZq8H?=
 =?us-ascii?Q?jdEDSLUlF2qhuFkN7BPzqJwtFHnJXnYkhu+P4kTutsJiFoK16XNMXiQvo+Ym?=
 =?us-ascii?Q?Sh7LxsmNYbAkx59Q2bqb4ufKwIHFOM3rvY1VCEjhXKY10gz4NzeKsIfAWN9d?=
 =?us-ascii?Q?b5yfFSBI8TCGXmFnUjFaevftR9SiZH4z2Kqf4zk/CkdyFQ86hp/q1RtMgKb+?=
 =?us-ascii?Q?LjKpBzz1/2GtLSsn7Q0yCv+ZwKCzdaYcGzXDqlqrl0vhsd4kc5bFIcZujfyi?=
 =?us-ascii?Q?oj2MAOmUmk79byUUD8pKCBKw2LD6q+G4kjEVP5oKmpuPWHu/iqkjTZW6+HqS?=
 =?us-ascii?Q?lEuQ3CE/+pwpQFSvh0Kx+7jM+kEJlgGt4H9PeSx8JjCbINqGzOLs90P64bFr?=
 =?us-ascii?Q?0sILqkYsgdItxfbHfMslgdzevQB24qK0wULgNBYsPw3fCgr/ALzFjfwNzKPD?=
 =?us-ascii?Q?xrTe/tDkTwfsXfdlidOa3kwy6qkBN87FBHzpNWYrT+FPlNzMEmsEu2YTLOEn?=
 =?us-ascii?Q?6UO6+FlXVASxuEapFHdtRRSWgZIi+PzhRL79PpPlB8IntZpT6YGqp7I/jUMK?=
 =?us-ascii?Q?H1BBs09YDFtvpUNuTORrmiHZTJAdE/XxEfz2d6vW2MMY0WJI/gvE+h6eWZpX?=
 =?us-ascii?Q?USGkEapvccA4MINxbZKhuXTZtImObuNge+lfAqiUmbs3qqycxXJyhO8zcL2R?=
 =?us-ascii?Q?3xkv1wKCFpnIufB3IFWNAEgAXXObfmlUWwjZk+4FMgW+CedI26J1FpVCYe/d?=
 =?us-ascii?Q?Xm0Lx4CllLE1Bhp5jEilIMgI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fbb528-6d82-4e48-b0e7-08d8ef24faad
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:28:57.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kC5BdZ9RbJQwwYPAGj3KS0GGD0qyq9XHtqFO1KofOUaacb2xRsknJM517ZToUSn+9VcK+Y6YZpA8fxLpQx9Quw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3908
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper routine hstate_next_node_to_alloc accesses and modifies the
hstate variable next_nid_to_alloc.  The helper is used by the routines
alloc_pool_huge_page and adjust_pool_surplus.  adjust_pool_surplus is
called with hugetlb_lock held.  However, alloc_pool_huge_page can not
be called with the hugetlb lock held as it will call the page allocator.
Two instances of alloc_pool_huge_page could be run in parallel or
alloc_pool_huge_page could run in parallel with adjust_pool_surplus
which may result in the variable next_nid_to_alloc becoming invalid
for the caller and pages being allocated on the wrong node.

Both alloc_pool_huge_page and adjust_pool_surplus are only called from
the routine set_max_huge_pages after boot.  set_max_huge_pages is only
called as the reusult of a user writing to the proc/sysfs nr_hugepages,
or nr_hugepages_mempolicy file to adjust the number of hugetlb pages.

It makes little sense to allow multiple adjustment to the number of
hugetlb pages in parallel.  Add a mutex to the hstate and use it to only
allow one hugetlb page adjustment at a time.  This will synchronize
modifications to the next_nid_to_alloc variable.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 1 +
 mm/hugetlb.c            | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a7f7d5f328dc..8817ec987d68 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -566,6 +566,7 @@ HPAGEFLAG(Freed, freed)
 #define HSTATE_NAME_LEN 32
 /* Defines one hugetlb page size */
 struct hstate {
+	struct mutex mutex;
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f9ba63fc1747..404b0b1c5258 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2616,6 +2616,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	else
 		return -ENOMEM;
 
+	/* mutex prevents concurrent adjustments for the same hstate */
+	mutex_lock(&h->mutex);
 	spin_lock(&hugetlb_lock);
 
 	/*
@@ -2648,6 +2650,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock(&hugetlb_lock);
+			mutex_unlock(&h->mutex);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
 		}
@@ -2722,6 +2725,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
 	spin_unlock(&hugetlb_lock);
+	mutex_unlock(&h->mutex);
 
 	NODEMASK_FREE(node_alloc_noretry);
 
@@ -3209,6 +3213,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order == 0);
 	h = &hstates[hugetlb_max_hstate++];
+	mutex_init(&h->mutex);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)
-- 
2.30.2

