Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9DD34F799
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhCaDnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:43:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49880 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbhCaDm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:42:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3erQW038054;
        Wed, 31 Mar 2021 03:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=M3ZNCNlNGxs+XGnmLc2aGc0QhYl50TNtgEytgMXfYic=;
 b=EzCabx51gdd9v+ZAgv4BKOG1G32MxCI6fIgS3M9OdsqMoIH+vAd+Ra6cy9puTVE6KHP4
 y7O1v2Lt/iaPrQTJoYXE96ojdM7bp9AYVxz255zej4qDuJuNMIiymVeeec0nF4maASKf
 NghsGUcCGFOa7F7LwQYM3NSMtV8N7X3DiPSkS5Q7OMZg6tuP/OPM4ijvAL4MvpzAtDlU
 uArzytbvoitkc7YAyt00pXoTg/Tx0QBLnOt0OoaxpXO9jqBeXSaUlaXQWkRMKLLc6b4C
 o5ycEz9iy6FzRzN/xByK6bH4YXq4n+e+gSejEWBPHiwpONUghC0mPP9/okIwxKTVF947 NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37mab3gsm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3epQs182432;
        Wed, 31 Mar 2021 03:42:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 37mac84ebd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxaUfLjR1brT2UL28Ymg2GcE9AsqNZLEuR2YRV+nDs0A7oxU1Jg2aLKZ76DZ3YGUewmW6NfRG9b2SWVi1llPKHXBXyXoI1zYWjacNNDSID/ixBvorRA7GeyOjnJuFuTliLj9TTLLpLlx7e3B4l6NffiO7I8PTdjN4cOHTGUo2EebZiXSHatPOlvLFptV+rqiB/83Z1D43JbnHaNR/2wFwRxlNIG0++flhFXohMxaNNXw8nKS9X3zjtE/HA2gOavUvfYOzTCEcvsyKFThvm7lVtEBsCetA7h4O5VK1mnHi5c6vXLzdco4W8HeK9eRA6z9PN2P9nyurXzJ+DR/wC58kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3ZNCNlNGxs+XGnmLc2aGc0QhYl50TNtgEytgMXfYic=;
 b=cQFKVN5u1zUgtrrguN7vGQMY8TrT8inltJjaKECF4PgwjPLGRDuuUrFZgpkAa1Ol5Cu8F8eD318CLIcZccP6oT9njAgYTN46Ai2tIJfbuKAsDdcYAmdr+nNRYJTPv+03z1NBMlPSJDzTr7m35p6HyP6tYqFUYXoc+daLVO8OadS18sgTNTuEBnxDXfg0/hwJMQG7eVDDAeCgMa7WUNCJgnE7Y43twbgMhcRLBAYmknJwIKD0rVIGGxVMCT8trVLaw7g990RLeK3pN/ECc/mbUXCWCErvEJieIN2Fz4ykFZDYgVVloSyTsaEOzJHwxJ2PrkbPAlEH9hM/d1KtRnMeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3ZNCNlNGxs+XGnmLc2aGc0QhYl50TNtgEytgMXfYic=;
 b=sX/d4hqmJsyk3VOE8n5YkLAi/ckRSqgPJr880ulBEklj9n+kLc7hpggzwfPxnm+s85EmFLESFoYDHxA7hQsLwN45uOMVloa6vwXH32Q7QshylRYaAMBE0A4+DnuQpHNlxMkyIlfrcHwyDl2bFsAr75TrRowfIXXefNlHGe3c9bU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 03:42:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:42:06 +0000
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 3/8] hugetlb: add per-hstate mutex to synchronize user adjustments
Date:   Tue, 30 Mar 2021 20:41:43 -0700
Message-Id: <20210331034148.112624-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331034148.112624-1-mike.kravetz@oracle.com>
References: <20210331034148.112624-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:104:5::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0202.namprd04.prod.outlook.com (2603:10b6:104:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 03:42:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c77e76e-5d06-477d-4196-08d8f3f6f4ad
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB446227C57CE47127C6F08214E27C9@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItV6EKuNXxkig8sRY0h2nPrmkeDz6Hy1tSVCBW7MvCkh3sov8Be2oEW+zmOs7gWFSrfDGfUdkC8YvVct+4k0h2yxF5TQH25iTNR00ARvhNukmQnG7klHk44G/jOjUSiqdztlBdq8ohIbNrxl3ratMw1S+ZITu+zq1ULrbvsD23mZuRFgdNQy01AR6dMuUokaTI6AQ50Jc8wlHcIS3FpCF8QA3Z39ZabpWgdP8BGDACDibL075k34Td+Cv+Pzd5G33xjiVc/4kLbTECVKEUHAd+UEQxWNZBjidaRiYbBwokHqMPSBS2DmQEIQIAKfwfm/E3LV72JxmFLwJU0jzq9LlwayEPFLtyAW5BsAVJEeOWdS9NwrDHYjlX11jacpytQN56HfyRtqQdmQnvhKea1stLX/hIaIlC1FHwgPzaIjzloYZNE29tDGtk1OXoC6eit/6HieB4fZEWYOpa83HGU/E1iaOyj55cwoZAdqnzsLa6FgbwFg8ZlEtN1IpOQJYPItMxBCDDbCx2lhR3H7AUPY634XSjxIiILIZYfKUzS4fUcVd9/7YDfp2bIQemTBxq6SO4HOXZBqOmg9gWz5r7CSjson/ypwMX4eH2lHTvPDOsIeuyA4mBK7Mmx1lkwkNqJA//FSW4Yqyvlb/X8h1tStQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(86362001)(36756003)(83380400001)(316002)(52116002)(7696005)(66946007)(54906003)(66476007)(66556008)(44832011)(7416002)(4326008)(8676002)(1076003)(8936002)(6666004)(956004)(2616005)(16526019)(6486002)(26005)(107886003)(2906002)(5660300002)(478600001)(38100700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?imOB6C6oqxTzNjm5K7IFpoZPOlW+0dhbcS/r8/2g/fqXmhawVbJ/N2MJUPAK?=
 =?us-ascii?Q?ygBulUSO8ojJToI130HPEdRQ/hgWJJcLAWXsQawwhcO04X4YvpAuiY2lsPLn?=
 =?us-ascii?Q?h94DWVHZNbfkNOCluFwmAFab0qz3gNxZskzGhvwPSt7nOu4kdy5nf9A/zATc?=
 =?us-ascii?Q?nromc5vO0scT/sOlT8wBNO3BLhkdBPtTtlXQP8EmLi081PzCGfilzV1ZtRld?=
 =?us-ascii?Q?in79tTujS5U6aEG7VhUcxSj4ceqFNVJgRrGXhgAr9FokT+B4e8zzm0TmQ16j?=
 =?us-ascii?Q?Ec4+3I/i4U12W0RLL1Rsjll+CCdE9loqzGE+ajq7FgjMIMEOIzH8LPZJjmfW?=
 =?us-ascii?Q?7hUDEBdL/owvDehKw5bmU6bdz8GjXridSuXgzv5D4rxaff04Oi3trPoSYA1p?=
 =?us-ascii?Q?0OoF2SBfxMuFbwCtTnMyxvSLe3Wr9nWXzucxgFnmvamyUz3CcK3RJNCDAQ9+?=
 =?us-ascii?Q?FDJvoWW/FHTlG2diITgXHLBoDZRt6sSaT065wRoQPO5HwuwGiS/ximWvIWUg?=
 =?us-ascii?Q?viStStkMY9g6zAT7+RFz9/iEHfcXbhhzSn3MxyYJJDUQoB0N4S3Ug0S3QZ88?=
 =?us-ascii?Q?szvFeW/aT2EF2eyBZEcvyJVgjwHYWU6F8C4Ux4zlT2lRQjIgnd7PyvgC2Mwl?=
 =?us-ascii?Q?HLwvNGmrpa5b9jocua0dShcweeQV+k3q3aDj+eP5Bly6Uamf8t+Dd9DQhUwb?=
 =?us-ascii?Q?eCa/u7OmYcLAhXcUyz/OOsc9nnR4AcED4IhGKdxyN9mO66DsZciVA3IssLd/?=
 =?us-ascii?Q?qc8fAbYUsfbwacD1TshNHabnquXdgGErEcGM9nm3vQUZQb98nvq/ARk+zuNt?=
 =?us-ascii?Q?QeI9gymwJHMc1yGqGPh5TdVziGNA4CcfH2sgijiuL4tyTFHQIfDNs1BvzRJW?=
 =?us-ascii?Q?gxZkUJGSl+1FugICRHdXneb56qc++kuMrqCMuaEbiAAxQl3bWSYpSjyNQcGZ?=
 =?us-ascii?Q?HxeFBQ2iWAg4HFbbTQDvaYy5+2YKnIjWP1Gr4v82n+oF2mZLqz21rFDN1THx?=
 =?us-ascii?Q?V8aC3J1IJMJbcVQDVlx1jKdTEH+6vXqvlk70M1uoOTMIhdLOsUWSRIm0e2fm?=
 =?us-ascii?Q?2v4lFvke/FQKMFAVhFgb2kOjIVSep9UR5CIsX8oqgT0sfr86G9xmw6MDh6z7?=
 =?us-ascii?Q?/aQ8h761489R9NZ9l/JL0JOrAK74nx+oFW1o6vZLhK4ldPWbY6tkPei6fzzb?=
 =?us-ascii?Q?qUgw0LWmuMLjarEjs7VOUuYd7MpqR3D9RJIRuxCWvLos6hooQqnZwTZpuCK0?=
 =?us-ascii?Q?AMG7oZJj9Zlin8vpKpnBVQQObOSSc0RYLsgyLQ/7+PxlW2MNJ2DroFYySmNJ?=
 =?us-ascii?Q?U9+uPzLnWKFCGjdUpXj5/J+v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c77e76e-5d06-477d-4196-08d8f3f6f4ad
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:42:06.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vx3a/45tvBLh9eU4lm6O9Y2OwGfPUCYAmHyXVO9RBTVsIC1hwCz4tDnHR0piXD/yAHc5I3N2DLe4vNOQC5xo1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
X-Proofpoint-ORIG-GUID: ZXZ5AQtMyxMn5w28XE_xWA-JDrYb745n
X-Proofpoint-GUID: ZXZ5AQtMyxMn5w28XE_xWA-JDrYb745n
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
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
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h | 1 +
 mm/hugetlb.c            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d9b78e82652f..b92f25ccef58 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -566,6 +566,7 @@ HPAGEFLAG(Freed, freed)
 #define HSTATE_NAME_LEN 32
 /* Defines one hugetlb page size */
 struct hstate {
+	struct mutex resize_lock;
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1d62f0492e7b..8497a3598c86 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2730,6 +2730,11 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	else
 		return -ENOMEM;
 
+	/*
+	 * resize_lock mutex prevents concurrent adjustments to number of
+	 * pages in hstate via the proc/sysfs interfaces.
+	 */
+	mutex_lock(&h->resize_lock);
 	spin_lock(&hugetlb_lock);
 
 	/*
@@ -2762,6 +2767,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock(&hugetlb_lock);
+			mutex_unlock(&h->resize_lock);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
 		}
@@ -2836,6 +2842,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
 	spin_unlock(&hugetlb_lock);
+	mutex_unlock(&h->resize_lock);
 
 	NODEMASK_FREE(node_alloc_noretry);
 
@@ -3323,6 +3330,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order == 0);
 	h = &hstates[hugetlb_max_hstate++];
+	mutex_init(&h->resize_lock);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)
-- 
2.30.2

