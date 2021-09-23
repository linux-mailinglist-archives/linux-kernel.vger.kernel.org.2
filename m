Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B0F4164B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbhIWRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:55:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60020 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242611AbhIWRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:55:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NHmCNA003111;
        Thu, 23 Sep 2021 17:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=WA11bhVNJt+pm6dGsNJmWCrn0r54C54rTpw+ZUm0VJE=;
 b=cMgh0VPTjeBySHadA7mZPZBzZIwTu/rcRzvAKX7QvkgRF5DunNliuPglyhC1dtRerRTt
 p0zy3XtrrDkwQpQGgw7bcZIfmGLbWiVUOZugiAM6bA32VTJDkRUviuoBXcNpQNtTRG+7
 ZSTkqoSzMgswvSAKHyYOmmJkvHLg41EIRkj+UYYssEuiyA/jxtbZd3gyicNHrxrx4o/2
 SONfpTOgmFk/B8KEta39Bhv4Uh2VG+b+p4W6TbKk684yqIbGqsd090V5VnV9kau/ZlqP
 Iwn9Q3ryxBBK5/1vYl40X5gaTBmDn4uhUFD1rPovG0FzGjAids8fGK2iS2LHE7U8kUYI Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8qvuk6qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:54:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NHoQlI041678;
        Thu, 23 Sep 2021 17:54:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by userp3020.oracle.com with ESMTP id 3b7q5y7een-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 17:54:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA/lCveX0ZlkthqLLUeuYNPHp6uwZez/3TOsFYGeqSZT2+/w13GVcPGv786t/bXRj7++RvgVaL1mPYH7uiQSkN/Q1jphisZRPdIvhSvA9J3dVu0QK/o0Wjg0Gz2POAPuMoh7KnLx297153dhCRPLnoZF0p/0cuVDFtww6w+Ej4vMceyEQkzrcRYBFhif7cpVOHMPpfKnf416SyPDZU+MEWSmcUzG3hOSPuj9b+kbA3CF3bd+LilFu1oyCz8sGYT/DT9SHY+fiH1sywT6nyN3cs/CNAqk3eiMIYDfU1dGOLecIDZvxI9v+PogVX5alhwnGd6SeczcSxEoL0sIrQwdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WA11bhVNJt+pm6dGsNJmWCrn0r54C54rTpw+ZUm0VJE=;
 b=K6CZhWjt9+gmwc3yC2X0+oQ9jF6rdcMwAkrQKtYJi8M8lELVn3mpWM3v+ukdB1944KuGjuDtiNLgJ8j1TDxelai8AaOg/mMGAoLF8Z11RANBwEXzamzuEMdhzUM7iiYGsO1t2HRfL2iqEw/ozw4lmLf1ik2pF3Z4kFZTrao6AwmYnB2vpn+ykxwVm9XYKe9jQcMH+3gwRgyCpJhx+DzjOJYLUFKhZl1iIdtYurwqFkaLr0g9toikHMN8pFFne5fPsaj0VH0VaxTrvld5wyUdr3jYH2tMKxQbpmVyQSF5sTOwwuK5QD5iMSutiCDhJAkVUqXDfaftgN2QCC9c9eKaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA11bhVNJt+pm6dGsNJmWCrn0r54C54rTpw+ZUm0VJE=;
 b=TTqcb0oVPKpSb2ztuYZ3HQ3IeTv7hmlhHBOQKQsR18+38E4yt4DujLdLDy+G7Lisnz0UFEsMfXaS963ddcb3BGWOXMOqUV728Oc/1QpgV/4Oz5Qx5zTajUMBMKlDVtdqZ4y6EN/oUcVTQpMqJMG955yKJswLL2iP4uSrDmJXJcw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3447.namprd10.prod.outlook.com (2603:10b6:a03:8b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 17:54:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:54:02 +0000
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
Subject: [PATCH v2 1/4] hugetlb: add demote hugetlb page sysfs interfaces
Date:   Thu, 23 Sep 2021 10:53:44 -0700
Message-Id: <20210923175347.10727-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923175347.10727-1-mike.kravetz@oracle.com>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 17:54:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2576aeec-6491-471c-d002-08d97ebb2091
X-MS-TrafficTypeDiagnostic: BYAPR10MB3447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3447DB2CA3179F1628568AD9E2A39@BYAPR10MB3447.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFgpTMEaZaiv9+dJXLojAYzmT+ihuO5gkJYqfBNTwe9p20ZQbqsR+yeSICQckxDE619StzRTW4qyaZiYvQMp4itr/D4eu5Kl7gjfKX8zizMu2fLoC7ri6BHs2i8qF/v+0w00ZNY5hI4pfrAT5iSnuY+3hHQSVSQOckmp95e9gxnumG2Pe2SodnuGdAUgE/Gg5s9dnLT1D/ftubkqzsvBtrHa4lL0GjXq2S7RynKJ+yZLoji4bicsCHz0Y8qJfD8HUSsRFVx5ZZH8iT6Tm2ztmW696LKewmU/WRHbSOh17ArPyGwb2/zKRfzqlpeJdrAyLEyaBVtXELgBfAr49KIdZG4hRG6qxj/nRJxINvzzDwUdDUVDOBqBltqEvAm5E2fczauc49obyycPOLu1alwH+4jZP+aZBxBvFHcJXHyIhC7VShkAfeU6vc8zwKZxX6N4/XB1s5xX0vV6EW2zuKARmik381PcRsgt8iStNugY8A+B5cVg9rxZkS41SrOaKFHMoa8ZnJAVvNY4hBp5XSuhjD7CcaUxVQrjCMHorqpXri++/6D7b88mfu4WhzOmJeqmVodLv2eYaklXooPAW7dEqdjEu2qlIHdrB5wEHAm+nt+QwrQheu52QSwCXItyQM3TzopSRt5BuGA8KGpZYOYpGOCOvMv9Tbbpq9p6VBQVf0j60guXZGFbrLkdBPSN9ki/cvOcRkQ+Wd+ElS/UnJ/dXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(38350700002)(508600001)(26005)(6486002)(1076003)(7416002)(36756003)(186003)(52116002)(83380400001)(2906002)(66476007)(5660300002)(8936002)(4326008)(66556008)(2616005)(956004)(44832011)(54906003)(7696005)(66946007)(6666004)(107886003)(316002)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Dkj/V1JWgeBkkTH9WUlPsW/SxzE61oy5Cev6nhzn3Q1/0Y32gD/g9De6KAB?=
 =?us-ascii?Q?lezeJxccS81HhG7uMX+oeZTpmJAlnyrKwfbFy/sbbphGU6hCAnaq5QJb5Dgj?=
 =?us-ascii?Q?EQNAOKWll5JnvTQ1P7Vq3sP3DjAjW4GlmMCWbypeoxZsgqU/ch23j4cLnfiw?=
 =?us-ascii?Q?emR890/ekSYfgtSbT9k02FGMccou3v75bcco5FXMTgRCd9Thf0A8WOlzuADZ?=
 =?us-ascii?Q?BcoVyFdW09q2UezqD9foQ6vUTJWkmQkde+Yr4T1Pg5vUcxz2cedn6LYcm4k6?=
 =?us-ascii?Q?1z3qat7wmXnHGOSsqSuWLwnXPmfNBPe+yKF1pcTIWnKWASobEJ+BeMUFWwq/?=
 =?us-ascii?Q?kbLlo9usNmLwR3RGb3EkDHloVmg1PdGG7QQEvCy2+JvXyBHDJCLKKI2W5QFF?=
 =?us-ascii?Q?oxdTVEalTuR2X23I0PTiu6Ad8ZqQ8OgMxQrITtcAsb7rs1R3zdvdRkk2fJwk?=
 =?us-ascii?Q?Nf6Othiu8zIa4ubkX7X5GS1F7Ug1Ow90QPtS5bTjYMtM8iqNoASaN+/9XgLv?=
 =?us-ascii?Q?EvKdAEKG0ZBTV9YCwvGJZLfSPU1V26iL80lDkLywbjtJfwxipwjKxMgTW7Nk?=
 =?us-ascii?Q?V0g69cq+KfRh6FBGakXEcF4B0ePxZqa6VXw14BSAsigZuNM2AFz+EbtwOfyk?=
 =?us-ascii?Q?dTSvJJBaLU3qPRpxGpO/ljJjC0YS2pm8RquhX86M4YcMgkepb1rMlfl7Tity?=
 =?us-ascii?Q?Z4MSCU1PNpqn7rMqwmdZyph36MvqCpKoOzTS8ge11hsO6dFZUzxyC3ONYzP/?=
 =?us-ascii?Q?h9JkW14qBs0zrUgslAwUdbQJ3S6yFl4S/ODvKGpeOMFttP7MleBkbw8WQDRP?=
 =?us-ascii?Q?QJ+O5YHnN5m5OdhwVq+A6oG3yc7oswBQOWiwtfi1n7Nmkb2i8TPDxAJp6f6X?=
 =?us-ascii?Q?gvNRQShHr5oSnLKXjrgYSDoRCjMnIImMMvm/Y74s4MCwNcgMYi4cCFJrj2/g?=
 =?us-ascii?Q?xaz46NdnkhKLidrq6BnFiQ65WHJhWu38LQQqg1wcmryUDlk2fG4lr20jTRRB?=
 =?us-ascii?Q?1Y98nCRui0V465f0VQewucwkcrv92rVFyMhZ/lhmNckVrfTMTVxjFeiWV50l?=
 =?us-ascii?Q?3YTPTmvVGvWHqfWVhn+s6267mhCWikR40iAmivYKOvnZc6b7+C/eQMAfvxpm?=
 =?us-ascii?Q?KAxF6PWGdJ3fwqu6q8keB0UJqZU6qDm/DqAO/MAPj7tUL0mlXiHrvOqpOy6t?=
 =?us-ascii?Q?Y4ti37BHPC5DTcNGomGEBgBvYOY8Gx1lSGMeb2g884QTrtO4tjkL4xv5UWQn?=
 =?us-ascii?Q?ZLzVbD7X2XOs/DV0ierMwamziNb+RGy69PoCaAqBRJ8l7G7SKy0u1GdFpZxl?=
 =?us-ascii?Q?x16DyoASec60XoV3WI9uwGL0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2576aeec-6491-471c-d002-08d97ebb2091
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:54:02.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4BAj4sYBBXgTolo6091WGardAp7FkSl4fW9Muc3/EceeqSHlDU9uQq7YLBrXH/n57JRzEkr3G3Hk5Hk9hcllg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3447
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109230107
X-Proofpoint-ORIG-GUID: kffuToGzzrkIIPgozuBeBfDQ1zzh0ncl
X-Proofpoint-GUID: kffuToGzzrkIIPgozuBeBfDQ1zzh0ncl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new sysfs files are added to demote hugtlb pages.  These files are
both per-hugetlb page size and per node.  Files are:
  demote_size - The size in Kb that pages are demoted to. (read-write)
  demote - The number of huge pages to demote. (write-only)

By default, demote_size is the next smallest huge page size.  Valid huge
page sizes less than huge page size may be written to this file.  When
huge pages are demoted, they are demoted to this size.

Writing a value to demote will result in an attempt to demote that
number of hugetlb pages to an appropriate number of demote_size pages.

NOTE: Demote interfaces are only provided for huge page sizes if there
is a smaller target demote huge page size.  For example, on x86 1GB huge
pages will have demote interfaces.  2MB huge pages will not have demote
interfaces.

This patch does not provide full demote functionality.  It only provides
the sysfs interfaces.

It also provides documentation for the new interfaces.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst |  30 +++-
 include/linux/hugetlb.h                      |   1 +
 mm/hugetlb.c                                 | 155 ++++++++++++++++++-
 3 files changed, 183 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 8abaeb144e44..0e123a347e1e 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -234,8 +234,12 @@ will exist, of the form::
 
 	hugepages-${size}kB
 
-Inside each of these directories, the same set of files will exist::
+Inside each of these directories, the set of files contained in ``/proc``
+will exist.  In addition, two additional interfaces for demoting huge
+pages may exist::
 
+        demote
+        demote_size
 	nr_hugepages
 	nr_hugepages_mempolicy
 	nr_overcommit_hugepages
@@ -243,7 +247,29 @@ Inside each of these directories, the same set of files will exist::
 	resv_hugepages
 	surplus_hugepages
 
-which function as described above for the default huge page-sized case.
+The demote interfaces provide the ability to split a huge page into
+smaller huge pages.  For example, the x86 architecture supports both
+1GB and 2MB huge pages sizes.  A 1GB huge page can be split into 512
+2MB huge pages.  Demote interfaces are not available for the smallest
+huge page size.  The demote interfaces are:
+
+demote_size
+        is the size of demoted pages.  When a page is demoted a corresponding
+        number of huge pages of demote_size will be created.  By default,
+        demote_size is set to the next smaller huge page size.  If there are
+        multiple smaller huge page sizes, demote_size can be set to any of
+        these smaller sizes.  Only huge page sizes less then the current huge
+        pages size are allowed.
+
+demote
+        is used to demote a number of huge pages.  A user with root privileges
+        can write to this file.  It may not be possible to demote the
+        requested number of huge pages.  To determine how many pages were
+        actually demoted, compare the value of nr_hugepages before and after
+        writing to the demote interface.  demote is a write only interface.
+
+The interfaces which are the same as in ``/proc`` (all except demote and
+demote_size) function as described above for the default huge page-sized case.
 
 .. _mem_policy_and_hp_alloc:
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1faebe1cd0ed..f2c3979efd69 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -596,6 +596,7 @@ struct hstate {
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
+	unsigned int demote_order;
 	unsigned long mask;
 	unsigned long max_huge_pages;
 	unsigned long nr_huge_pages;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6378c1066459..c76ee0bd6374 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2986,7 +2986,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 static void __init hugetlb_init_hstates(void)
 {
-	struct hstate *h;
+	struct hstate *h, *h2;
 
 	for_each_hstate(h) {
 		if (minimum_order > huge_page_order(h))
@@ -2995,6 +2995,17 @@ static void __init hugetlb_init_hstates(void)
 		/* oversize hugepages were init'ed in early boot */
 		if (!hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
+
+		/*
+		 * Set demote order for each hstate.  Note that
+		 * h->demote_order is initially 0.
+		 */
+		for_each_hstate(h2) {
+			if (h2 == h)
+				continue;
+			if (h2->order < h->order && h2->order > h->demote_order)
+				h->demote_order = h2->order;
+		}
 	}
 	VM_BUG_ON(minimum_order == UINT_MAX);
 }
@@ -3235,9 +3246,29 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
+static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
+	__must_hold(&hugetlb_lock)
+{
+	int rc = 0;
+
+	lockdep_assert_held(&hugetlb_lock);
+
+	/* We should never get here if no demote order */
+	if (!h->demote_order)
+		return rc;
+
+	/*
+	 * TODO - demote fucntionality will be added in subsequent patch
+	 */
+	return rc;
+}
+
 #define HSTATE_ATTR_RO(_name) \
 	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
+#define HSTATE_ATTR_WO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_WO(_name)
+
 #define HSTATE_ATTR(_name) \
 	static struct kobj_attribute _name##_attr = \
 		__ATTR(_name, 0644, _name##_show, _name##_store)
@@ -3433,6 +3464,112 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
 }
 HSTATE_ATTR_RO(surplus_hugepages);
 
+static ssize_t demote_store(struct kobject *kobj,
+	       struct kobj_attribute *attr, const char *buf, size_t len)
+{
+	unsigned long nr_demote;
+	unsigned long nr_available;
+	nodemask_t nodes_allowed, *n_mask;
+	struct hstate *h;
+	int err;
+	int nid;
+
+	err = kstrtoul(buf, 10, &nr_demote);
+	if (err)
+		return err;
+	h = kobj_to_hstate(kobj, &nid);
+
+	/* Synchronize with other sysfs operations modifying huge pages */
+	mutex_lock(&h->resize_lock);
+
+	spin_lock_irq(&hugetlb_lock);
+	if (nid != NUMA_NO_NODE) {
+		nr_available = h->free_huge_pages_node[nid];
+		init_nodemask_of_node(&nodes_allowed, nid);
+		n_mask = &nodes_allowed;
+	} else {
+		nr_available = h->free_huge_pages;
+		n_mask = &node_states[N_MEMORY];
+	}
+	nr_available -= h->resv_huge_pages;
+	if (nr_available <= 0)
+		goto out;
+	nr_demote = min(nr_available, nr_demote);
+
+	while (nr_demote) {
+		if (!demote_pool_huge_page(h, n_mask))
+			break;
+
+		/*
+		 * We may have dropped the lock in the routines to
+		 * demote/free a page.  Recompute nr_demote as counts could
+		 * have changed and we want to make sure we do not demote
+		 * a reserved huge page.
+		 */
+		nr_demote--;
+		if (nid != NUMA_NO_NODE)
+			nr_available = h->free_huge_pages_node[nid];
+		else
+			nr_available = h->free_huge_pages;
+		nr_available -= h->resv_huge_pages;
+		if (nr_available <= 0)
+			nr_demote = 0;
+		else
+			nr_demote = min(nr_available, nr_demote);
+	}
+
+out:
+	spin_unlock_irq(&hugetlb_lock);
+	mutex_unlock(&h->resize_lock);
+
+	return len;
+}
+HSTATE_ATTR_WO(demote);
+
+static ssize_t demote_size_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct hstate *h;
+	unsigned long demote_size;
+	int nid;
+
+	h = kobj_to_hstate(kobj, &nid);
+	demote_size = h->demote_order;
+
+	return sysfs_emit(buf, "%lukB\n",
+			(unsigned long)(PAGE_SIZE << h->demote_order) / SZ_1K);
+}
+
+static ssize_t demote_size_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct hstate *h, *t_hstate;
+	unsigned long demote_size;
+	unsigned int demote_order;
+	int nid;
+
+	demote_size = (unsigned long)memparse(buf, NULL);
+
+	t_hstate = size_to_hstate(demote_size);
+	if (!t_hstate)
+		return -EINVAL;
+	demote_order = t_hstate->order;
+
+	/* demote order must be smaller hstate order */
+	h = kobj_to_hstate(kobj, &nid);
+	if (demote_order >= h->order)
+		return -EINVAL;
+
+	/* resize_lock synchronizes access to demote size and writes */
+	mutex_lock(&h->resize_lock);
+	h->demote_order = demote_order;
+	mutex_unlock(&h->resize_lock);
+
+	return count;
+}
+HSTATE_ATTR(demote_size);
+
 static struct attribute *hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&nr_overcommit_hugepages_attr.attr,
@@ -3449,6 +3586,16 @@ static const struct attribute_group hstate_attr_group = {
 	.attrs = hstate_attrs,
 };
 
+static struct attribute *hstate_demote_attrs[] = {
+	&demote_size_attr.attr,
+	&demote_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group hstate_demote_attr_group = {
+	.attrs = hstate_demote_attrs,
+};
+
 static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
 				    struct kobject **hstate_kobjs,
 				    const struct attribute_group *hstate_attr_group)
@@ -3466,6 +3613,12 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
 		hstate_kobjs[hi] = NULL;
 	}
 
+	if (h->demote_order) {
+		if (sysfs_create_group(hstate_kobjs[hi],
+					&hstate_demote_attr_group))
+			pr_warn("HugeTLB unable to create demote interfaces for %s\n", h->name);
+	}
+
 	return retval;
 }
 
-- 
2.31.1

