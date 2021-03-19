Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0775F3428D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhCSWnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:43:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44434 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhCSWn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:43:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMZBiI128000;
        Fri, 19 Mar 2021 22:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=cUKW1HQalMJtxv8VJaWBtV7q/POIHFn8Vai9tFs6JPo=;
 b=MG/WCngVoZq9GLq1hevdAxA1qJcimW5Ki5urtJ1+J7wCZcBb0DYIQ2fdg7hFuiySk/kA
 IGRGCq1mUvttY+zwckQ8cC0oFjFUTlK7UsQu76BzMAa1jh7sklnnlHFV7NLCR3FL4+mG
 nsJyhEuFVm2NA6aZgek74UWfSY0e6hnrC4fI15xeQuSz8kU3+wnnksp8KdKLpyDUdur/
 KWaVz81PquqlKHjp6sLRKI3Oi5PasrTaC+gy477iZ+eWyAw8dIoTCYl6DBpIOEc9oyPV
 EE2aVNnYtr9ymczg5adL4uoo9IrI2/JmhjtHskcQdR1z/FPuDL9ZqQ17rkyYoxrUOy/1 qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 378nbmmg7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JMeGb7155442;
        Fri, 19 Mar 2021 22:42:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3797b4sr31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 22:42:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkiqgLELfct9cxf+6PqO8bS0bSD3NA0qj20UhzZTO3FmHZf01RzIUjn+8OvQqUrz5IkRbTpV/sft2esmbTSABPD9diwXY+JGJTnj0y1ofkyIA7kUdsenE/dja33SLNspwPUvdjFQz+V2gDZ1CCvwN/kUieloTwSWf5+jwHpyZ/NUdr+sVm7jFuxaDZhn0Pce8TMHb3hsPzcedXHXu/5FztREXnnrmo7nej9ueF3H0ml4EMHXYRHLVJeJHpKewmSXpWJ7tLSudCIJqyIg75wXA2/rvJMxe+s1oTvxLisroKjHx17se9rcSB29b4ISuYRtvfBA8SldKD08J/qxY6EooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUKW1HQalMJtxv8VJaWBtV7q/POIHFn8Vai9tFs6JPo=;
 b=kA/SaXljtyBCExoSWHn4C26zWRjoRzdiAOJCGN7iDeFrLsh/V8e48oZafj1CKlIsatcMbu92vy9gK4U06sg/7Tty318yfycVja/5YlPvqIlrwPzhA7wrFdBmn1f3U7JBkOhb4EkJbXtJfcXEQxcsONh8O5zF5icJIwHmZNmlEegv2zNonKOfmTRG7eYRT8S10FVWdgDRETSQCwAN9ejmagS1DPusRyr4Ws0HxMKLEF1eLRs5i4agfffYZT6VzALtKxt3uz94TAH079uZUlKVi2cTp4riZD95VFVhqVsm+vO9QG+rS60hlXAapKRV9hQMQDaA7ODfxKkoKj1k5ERkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUKW1HQalMJtxv8VJaWBtV7q/POIHFn8Vai9tFs6JPo=;
 b=sfOZ27xN4Se6bxGCzVNU89My46pezxRcWeTZkgLsE7B0+v2CPeUwT66DjxxFj5dIAnAHvpWora+3LrOl5AXEaStSdWPB0OHMYsa82ZOFC1q6qt9PidrJSqE2fVy80eg1v+6AQH+elKj1CxMi8i6eNJU5NdaVTWqSMIQP6Apm3p4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 22:42:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 22:42:26 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 1/8] hugetlb: add per-hstate mutex to synchronize user adjustments
Date:   Fri, 19 Mar 2021 15:42:02 -0700
Message-Id: <20210319224209.150047-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319224209.150047-1-mike.kravetz@oracle.com>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:300:116::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR07CA0013.namprd07.prod.outlook.com (2603:10b6:300:116::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 22:42:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31d705ab-dea5-4eae-d482-08d8eb284532
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB316073D3A616D9E28C9BF112E2689@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4e4WXJcbT4RmiKO7tQpewKR56jMVnHgEszWSjRgJGRDJLbebo+x0HqbLmZBwfbZ6cyFrNbRpasthz6HZcYvUoD0UVzEV5tzR5mmkQzaDoOqh3w6ElDhYK/PSHlQRuHEV00SPuQ75rHXvj4xVv9SdrezCpMeEKYye/y2jJGHqnUnjVptMti/YuDp9MvZCGgNI2IAzUkewADhrTOYukRA7DHMKPBSdSvKxMpBcnZkeRdUN1bMjXWue4xEMm2/ClCRO4WdnXwpbAPBVtwNrF1/tMx5QIbsdFXjR8OoJ0wwYWEW+OppXcpAjnLd/Op7w430y7ES7iMjCySEipu+2J61eUmHpOavorFqAQjxSdqQxeWPCpTtU7u94NGFhJB0iKZH6OFwPECp97XdcoWUxwKrC7zhAt/f2BIFw1835aVKKjHY7wPiW1LjmkJEUVMJoDKNG6THMcqjkCFFobQGbxIckT1SBJdQu43auxLH3vNLYFDE4SRHksM05Gkzx71Ofddu0beZDPEHhlb3kFON0ZgxSsx18qUEylJfUX3uszqSI1IThcfj576zlKmD88iLcezUErrs6AJZhRy9nUkmiUKq/3AsWS2U1n1Ttei7wmqA2skbhuHu2e0zIkFQMAHAJ24JJuOCk66wrweFAcfybd/jTcOgPpuStHXgcdMECycwMVFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(366004)(376002)(8936002)(316002)(5660300002)(66946007)(36756003)(4326008)(186003)(66556008)(26005)(66476007)(54906003)(6486002)(16526019)(52116002)(7696005)(83380400001)(8676002)(956004)(44832011)(107886003)(7416002)(1076003)(2616005)(38100700001)(86362001)(478600001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B0nbODihgoaokyVDxOoN3Lry6cPs3o9pSrdALCz0aSS4e9sr17mHZN0D6JIL?=
 =?us-ascii?Q?JFcYVDkkLqc5hD3ad6LUYEc/ykis09OF///yMjWFS7FpwuXLUu3N08K1emPS?=
 =?us-ascii?Q?Y6G/IhxnD0Ozu6KK4RtuZCCU+jbB7xK8NAQID21uaJP0UDSOSpveBEMHES4H?=
 =?us-ascii?Q?Z1dW6vpwGfWctIkv2VuLWKgGt61ANU0n3U+x20e284YDdKPy62urMjR5VPzd?=
 =?us-ascii?Q?ykupIaIAvuvkG58ihiKDVFfVocMiiRsMeFE9hgeuukniP6ZnpZVOWVkAJ68D?=
 =?us-ascii?Q?bkWCvBtzSpNfhhgpDFQFrquotiJ+wChXIuQ9rcuZJZPjxj3zlNEFBa0KVFB2?=
 =?us-ascii?Q?rW/qhRDwn/uuQyKFfB8NTZblRVM10o2RQRUsF1q+qV5NsrwltsSvUScvKGSc?=
 =?us-ascii?Q?B2w1sxeltq1EKGgQFMc4Y4p7fteS5CaM1iHfdrZiMTuXnThj7ClJTryk85xz?=
 =?us-ascii?Q?+YQyElUva2FWyKlx6bSBKLNEJBgcsVLj/2aJocLMNnj+TaFg05ReDbD2vV8V?=
 =?us-ascii?Q?POS/jHyWf1h7aQAAxRQdwPh3+4fLRVAr6n4MG1Jyh+A7D2rlY659MdE5+J9J?=
 =?us-ascii?Q?/gb/kFG90z+nUIVd2wspiIl5qXa5XNc/ATb3eMgBpPXoVtJWEuJkwFkk5WYf?=
 =?us-ascii?Q?8ZWghn1sojFNVRDcIykvUBP+rFnGs2EUFx7t9M/qvwR9F0arJJ45DUSM5ZSb?=
 =?us-ascii?Q?f7Fxf/fIzmrGeYG3wBxzgC7VsNE+stWW658obZskrYQnq3OZwNVU2R0Fmx7v?=
 =?us-ascii?Q?QFvbK63psLF/39QsPwOb22SKUr5GmRcj5doo7n0Tim1zzPkG1WyVGacgaPzz?=
 =?us-ascii?Q?UjLj+nEPqv6/6Mqsp1fgS8TjE1bFm6utgIWP8w6LiSpByaT6oPDAV+955lUy?=
 =?us-ascii?Q?sCjFI8Qf7tmYC/iMC1CxssnOXE5wzjGrBMIVgiVHUtuBXkpHOfpi0n+4q9Zj?=
 =?us-ascii?Q?lTQH3lxZHHGFm1CBRom+OcNQujBrQOBOif+rwq8CzlZktx1BwkaOnD9yhM+0?=
 =?us-ascii?Q?DMaw0UVjHL0VlvdQbjeaJyRk+ji+YyOwjL76HeCJ06v3tHMDkMzsT0GHJgrO?=
 =?us-ascii?Q?UCA2E/zBcK/EtudWsBM8w+dK3P2laYnfRz3xTdUuyMyoH8fWqe90IJRjyHXa?=
 =?us-ascii?Q?enV1umte8Sy5BBUDk9SbRCl8MQQvDLkYloaFTeyvHPqPNxC2SZyg3oQq1xxo?=
 =?us-ascii?Q?rISJXtD8SDg13DtIaOyXA34kkr32lxoa9CTahOvGch1Wj2O8hlbRSgoRtzI1?=
 =?us-ascii?Q?peS5loD3XNyJp5+IoGnqCOFJZOJCgK4A1ufcXZ0kKIoiNVf7m3lUnPTAJG3F?=
 =?us-ascii?Q?8+awJJqQltT2r4D1YNiSVgBm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d705ab-dea5-4eae-d482-08d8eb284532
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:42:26.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FY9bAJwQUYfY/W+dz2hQTq5/NHldNowSM2Y4aUeZ8iV/FjvXYL24MEZMBI+tg5lVMaVDhqxq7YCZwbFKig65ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190156
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of hugetlb pages can be adjusted by writing to the
sysps/proc files nr_hugepages, nr_hugepages_mempolicy or
nr_overcommit_hugepages.  There is nothing to prevent two
concurrent modifications via these files.  The underlying routine
set_max_huge_pages() makes assumptions that only one occurrence is
running at a time.  Specifically, alloc_pool_huge_page uses a
hstate specific variable without any synchronization.

Add a mutex to the hstate and use it to only allow one hugetlb
page adjustment at a time.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 1 +
 mm/hugetlb.c            | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cccd1aab69dd..f42d44050548 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -555,6 +555,7 @@ HPAGEFLAG(Freed, freed)
 #define HSTATE_NAME_LEN 32
 /* Defines one hugetlb page size */
 struct hstate {
+	struct mutex mutex;
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5b1ab1f427c5..d5be25f910e8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2601,6 +2601,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	else
 		return -ENOMEM;
 
+	/* mutex prevents concurrent adjustments for the same hstate */
+	mutex_lock(&h->mutex);
 	spin_lock(&hugetlb_lock);
 
 	/*
@@ -2633,6 +2635,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock(&hugetlb_lock);
+			mutex_unlock(&h->mutex);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
 		}
@@ -2707,6 +2710,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
 	spin_unlock(&hugetlb_lock);
+	mutex_unlock(&h->mutex);
 
 	NODEMASK_FREE(node_alloc_noretry);
 
@@ -3194,6 +3198,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order == 0);
 	h = &hstates[hugetlb_max_hstate++];
+	mutex_init(&h->mutex);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)
-- 
2.30.2

