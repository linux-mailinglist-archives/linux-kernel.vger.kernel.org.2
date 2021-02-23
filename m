Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D197B323384
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhBWV4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:56:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhBWV4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:56:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NLseqf064773;
        Tue, 23 Feb 2021 21:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Da7AtyOQQMu+mjb1/mbuGj8yPqJQW6qeCYq3blEwwKg=;
 b=aqZNptEUS1ELaKu8EtIsPwbcaPdTXdaZYuAwM7Kzj85FPwI0HDYsNxWoYX9SMz870sYc
 gGJ7k7Rwr+lvnBiZPPO9Kv4zxVSxQNLpgZHdHFod693wrqvTiycHPtPL3SytyK4A+uyE
 6cpcfVCU4OoQwD7d0ILapMf7QNB1IqVqazlmx55vMEO37DiUbGGFzoIRa4eNdL0gjB++
 plhsoMCQK8Z3LDUtmu0uYQxO5EelFNAxa4YPmk5Ydavqqd5BdGQ8SYS4nRESAkkNKAGd
 K0oIxJJ+S/VPNWwWQ1JnNh7YXd3cx4nMitXLMgS1GYMdffZ94fv5UsEadTUw8PWfn7qG fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36ttcm8yk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 21:55:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NLoadg113328;
        Tue, 23 Feb 2021 21:55:58 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3020.oracle.com with ESMTP id 36ucayy33f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 21:55:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIaDbRKRpOg3z3869DNt4+fphdnCaaM5v3VuNFfE3VdaH1JMMqrHHh+jzxlZN63wtbHGrgA6eFFsPUwkUPB5mXx6shkzD5MHJsvMQv525iqhTWOqLey3avDNUKMAdgUvz76SaOiRor4+MrHWF7Wa70AQVnv1y3wOEMyU+VuOSxsAnaXDrpb2u7+jRjxGOqq6srxZTSEUjIi0X6YezY8SlGbtIzIAOvSI1kN8sWqDY34DobfeEAihBZq78GSxbVJSfrehXt9/6DJhWbecHnahzPRNGRiYawrcdDuIrw/XBBt7MYWxjZIGYMcMgyeFfgDWrMjAT89hBso4ew9KZRt+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da7AtyOQQMu+mjb1/mbuGj8yPqJQW6qeCYq3blEwwKg=;
 b=X7iiZDePvVoRsxj9tuDtMcn68OskxE9AKPv12nSBwoktuzJJ1VSWqxEw4wX1Lfo40U+v1Ai4cSOOc3oQBf1BMYa2+0ybjwz11006xW1P2Us3CskepLQS0SfAqodAcRkyYuVBapdxul1Y7hNDj0+G4eZWwax0+saagtwqjkdlcbA3pWzI7iZQ+dcEWwInd7Iq4nI1lvq19lWf0DSDywvvJcVi5kN3lGpSPNWXnyitU+wWQmgu2fZGAZFVwGbzTUWWrQa5aNVDWlNyxUuglmCDr9Qw8ibsVkjmosqzbLQa0Ut3FZ3iLlH8i5AZS5aqUwmAEwcsf4bbDmEn37osX+Cxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da7AtyOQQMu+mjb1/mbuGj8yPqJQW6qeCYq3blEwwKg=;
 b=cLpvALNWLaLnIahxF9LqyqJ7C3NuoCdRrqiFgGCKWcWGXGQvJ76QqbmYjHY/O9IEW/xuN5m0IAYavXn4jBuI1ipHJIvepE9GVCzFqKWQSkcbcTlfSYBycGkpxML3kiW+TmhM7uzCL9J19BHM5TKndNRI6BZSi8t7SeAur4dTDTc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 23 Feb
 2021 21:55:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%5]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 21:55:56 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlb: fix uninitialized subpool pointer
Date:   Tue, 23 Feb 2021 13:55:44 -0800
Message-Id: <20210223215544.313871-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:104:1::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO2PR05CA0098.namprd05.prod.outlook.com (2603:10b6:104:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Tue, 23 Feb 2021 21:55:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6924dc5-8ca8-4461-41c6-08d8d845cbec
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB398662E2C91CDA2DB3734EF6E2809@BY5PR10MB3986.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6pJClQKXOLfIsiKF+G3P7QrAHi7sQE8v+s2OL5tP5YwFlu3F3I+n1Ilq6G/X/j7DD3Upg38Z8eVPgUsEi4ZzsP9SgoShYCtGL1D2a8hmK0TbVb3hawT1BLIipIz1DCFYCh7Bqv03Z5tK+tZLLOIebWSw+/JpdHm0tQUFKpqlrVHGoB6rZILbBy2mMVRlv6QzQLfwjAcuJ2E2vvV7ImiA9u6kl77l46iA/oooPdPq6wRHPoENCMQ77lU7cY3LRfS/bi3ZgKpQznVSAsZTvcPujEeNcboE/rFjKT0UQnFccQ735HCa37v6cJGLQe7PbcwKlLCori3N/QM07Vv3RfyC2mAYt6lDE1gc4yAEF5aJcp0GKgPORS2yn2oYhFIUNVXWKGF6nwktIc2TbN3oEWN7Dp6WYm6TFn17Q6pQMxqJCiwje/+3bZ8l+AVKqbdFn1KxlHiJwFs1BRvJ6qK6Vg791GlqBOsUlZ7Sg3KQTRuEyrdjB/YtIY5fQ1w9WNPpmis3hTDEkvO6x6x83FyPcqU7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(346002)(396003)(6486002)(7696005)(86362001)(316002)(54906003)(66946007)(66476007)(66556008)(52116002)(107886003)(478600001)(4326008)(83380400001)(5660300002)(956004)(36756003)(44832011)(8936002)(8676002)(16526019)(26005)(2906002)(186003)(2616005)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VxSnY7rRGUFdA6pMC/7UP5gCYd2te5pRZs73CP+WLWtmPL02uIjM7ZQb1dNV?=
 =?us-ascii?Q?D/SgspvUUXYwrmfswteVznaTpzzIPsH3kulUfte3NY6CH2ET41Qa4JV1GAaQ?=
 =?us-ascii?Q?RNyI6AMiKDr5FFtc5JtXbpfQtlN1MhznuoZehPG/IJgzy4YNZw9GvyS0PUOV?=
 =?us-ascii?Q?xN4L2Z+79gA6nvH2B+ixiBpfaFVZXGwhwaHO7jpvyPaDqep/0uk4oYnx8goP?=
 =?us-ascii?Q?pHuLnWpqNOZjLsMvy3XRcyXW3ESsqfDxuXtUGGVMiHEZewTJWPVy2YKBzbbm?=
 =?us-ascii?Q?cbEyT6YlFGOlx6VwFLJx04znYv1b6FBtAyYB9Sz61RUsHT8bK/VT2dEcmqEV?=
 =?us-ascii?Q?KIyoTiP4rS3rDHQu/0R2Dzhd153WqhIUWg/1eyz3AW3BDYvuvRJVS4Yp55ni?=
 =?us-ascii?Q?JLdRwhU2619HzfGez37eGC5ZmEBGWMKNOLSkX8MqZudlM2fw7ti22BOGEgKZ?=
 =?us-ascii?Q?HsE3l08opz26B8eOaAAMHDqdflOfmzecS51puEDBR67K/Um/CIRjgPkp4rqM?=
 =?us-ascii?Q?liBI/IO4EmkFCyUjAseIQuOcYZdCE5LdcVGN+WVhFdpiTVDwATtefgKqEVxd?=
 =?us-ascii?Q?wSXAXzU5GMTKC2h81KUzuscBiwOeX4x31S0sErvKCNCtT2VsQBU5V9UhKRY8?=
 =?us-ascii?Q?rRclnq2cVAqB+8Qg/gV0AdX9R8n4hTBomqqbpZGZ8VeoQLMbhl9e0Emt8jM8?=
 =?us-ascii?Q?BHEjbnC56dGBsY026OEIsRFlsy1T4ystOv4HstwHVDZHHWUF2FjJzx0BPzpi?=
 =?us-ascii?Q?+CfyK9I/PdwWp322M4QtaCRS6hcep9jNYYuLt/6jOifw3Yurjebiu64JMC9O?=
 =?us-ascii?Q?8n9nVASavq/L4FkSFovKmGQ9XD36mCPjxptqIB6bYT/TjMUPG5liiVlb5kst?=
 =?us-ascii?Q?5XItptFgg6Fjvncywp0mSmmXdxypl7+BBV0uCvlMIMDzrPoCVYwLD40YzMb4?=
 =?us-ascii?Q?Z8dH+PlRi3kzqHyFJBbleZMpG50fEw2xs0Y0rTfK2BD6WF8tjKDaDMa7njLw?=
 =?us-ascii?Q?i0wPTkJPmfy0HBPcPvCHrzNH/6GJZveZ5oF2HSGVJbWgyO1nzMJBXZPrAbno?=
 =?us-ascii?Q?GSUIiRNCJgHW1Hmrz/RpfJH9XW6mFVkKBqS8sFXdNRjYAST6yxf+UpJnKfAB?=
 =?us-ascii?Q?6GKXQNDJH4LKoDdBPq7N5B3TIvkzXnOXU5QAj44o9GV1OG/dIplXcJpp4QqO?=
 =?us-ascii?Q?wwL2peFQbqlYgVlrr2QwgC4zo0WM52kDS4+eIZIqGjS0/9Vkdwxn1/l7UP+O?=
 =?us-ascii?Q?NgLSOAnUs6chtYFHTwlCYWEyQaLR7101FQDRSSOlfdFi4UeD613swOVwlFFM?=
 =?us-ascii?Q?bjgaFVJsQUuC3+tlgkVjBI9T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6924dc5-8ca8-4461-41c6-08d8d845cbec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 21:55:56.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSIEeGzgU2zrPvBqsWkdm+QUg3zizIz5yqSaG96BwtEWdRW5F7eokJzl3fglgvO1OVXFwjUUSXBorJDwuFRQLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230183
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230183
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gerald Schaefer reported a panic on s390 in hugepage_subpool_put_pages()
with linux-next 5.12.0-20210222.
Call trace:
  hugepage_subpool_put_pages.part.0+0x2c/0x138
  __free_huge_page+0xce/0x310
  alloc_pool_huge_page+0x102/0x120
  set_max_huge_pages+0x13e/0x350
  hugetlb_sysctl_handler_common+0xd8/0x110
  hugetlb_sysctl_handler+0x48/0x58
  proc_sys_call_handler+0x138/0x238
  new_sync_write+0x10e/0x198
  vfs_write.part.0+0x12c/0x238
  ksys_write+0x68/0xf8
  do_syscall+0x82/0xd0
  __do_syscall+0xb4/0xc8
  system_call+0x72/0x98

This is a result of the change which moved the hugetlb page subpool
pointer from page->private to page[1]->private.  When new pages are
allocated from the buddy allocator, the private field of the head
page will be cleared, but the private field of subpages is not modified.
Therefore, old values may remain.

Fix by initializing hugetlb page subpool pointer in prep_new_huge_page().

Fixes: f1280272ae4d ("hugetlb: use page.private for hugetlb specific page flags")
Reported-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c232cb67dda2..7ae5c18c98a7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1465,6 +1465,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
+	hugetlb_set_page_subpool(page, NULL);
 	set_hugetlb_cgroup(page, NULL);
 	set_hugetlb_cgroup_rsvd(page, NULL);
 	spin_lock(&hugetlb_lock);
-- 
2.29.2

