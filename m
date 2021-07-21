Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3AA3D1A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhGUWZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:25:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33474 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230394AbhGUWZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:25:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LMvJWF031212;
        Wed, 21 Jul 2021 23:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=TEWj0W18GtlHbGvGCGpiQIhisDaq0wLV7EXt77Rlnq8=;
 b=RQBylKXzOUqWSqM04ItRNNcuUR/aTg76ikqbbk5cotojqATZRIZTVilMSDKCxZvCNdrn
 npBVVye9Fw90v6vBishipXXkNUJnnEXB+J6uDbzyi1i8OjmGdCksL3FI3NMV6hh37CRy
 6lBU/a6e6UVAVKMdv3W8ynjK9SHRk45ZgafFGkx2whLTJ1WVFEBQhW+lLYBnpaA1yU4t
 jQFY2izr3k0751iiTKTcHdgN+yJCTt1sBAH23OSsOasaD6UUkreP8DZrtizASjaycP4a
 ieQi5XAqqKbuy9GbmkWaxpCt9eSnai4d6VGgv64oy07ZuIGWtQqkPvZpzs3sC7VVuh+N Sw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=TEWj0W18GtlHbGvGCGpiQIhisDaq0wLV7EXt77Rlnq8=;
 b=WTRZXYI8e1cgSN+mKEL54E9Hh4OGU4h0QwLeZK+2n1pEAOiJp4VLjTFRxGzzp+NV98hr
 qJKFA5LiomSxEkUVhETU4EF0Gof3CVmxU/nyz6XyecidlD9HrJ/0tLgnQfn4+kg2yANt
 RckJPgtuhAvblMaTDJj+77E0a12RtWO1yLOLPJPvzc7db8EbiBOM2/XLO+yvCgdGd8sB
 +406AHUok19JyFvSQy060x/a+aJTRbe/UDMJ6FdYAd0Nx/1LjVbTEOhLvWhbkMc/IeyA
 AJj/cD9MS96cp68nEjdx26Rc/EVY0WZwmEZySCcn6TVJDeKryFEEtz78btTZd9MUN6yI vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39wwmtuxqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LN0Umt098951;
        Wed, 21 Jul 2021 23:05:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3020.oracle.com with ESMTP id 39v8yycrjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CX+9uRPbecGY+UZ1fsQGAGbPrnZxLmkEjGl2EK2o4DQlJiYnxaMZyRyOxXYj25ttbJ9jyfhgAq9LTJY4tvQV9BGSzvucjNITfMkfIPc03TW4MTGGmNhJpaymVmX8n7YW9x8+1YIa8a0rxmOda2NIFrDC4ey4Zx0ckiYHO0dqwZWweNOTBGamFPmkdAq/MX9G9G/UaD8G3fPWtM/XpCXrpOyALwZ/mxG0mATOTzjxTp4OKJXKnMp/NPfpyV93mjo50alDoy8gtW/C4vilBLV3rePxjsxM1Dy9Jd3sUkqhvwP6+WaQWJWUTw4IbwplgI/eUjcMhSedSnpfctl4VGJ/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEWj0W18GtlHbGvGCGpiQIhisDaq0wLV7EXt77Rlnq8=;
 b=G0iEaDZmDMxmABAI7Rv6D6OPAt5aGGRLGQ+OvrA9dJBgjvJR3OVVU3wQFJqHE2OCWjLKJXHjRVqR/ez3aewYfWf/ja7twfJfR1025vJ97aBQE2oQAxHLcsM/yLxeUtwdQJvB/FVM9LT/omxrWN0HLI80GTYwBIyUY0SP3ltsIVzVkkcoAy/AJb9ovX243MYyOHoAAUCl90hXytFTNzElrpoE1XAfaHUUde7K7ZIcSvRyfS8leYrgjz7lu3E86w52TN/M3Yksym3TUGAQwkzeU0HmhuuODzu1hPq8h6BAqLQpHG5N3/RpnlvIsS55lOwSgUnfzaRc7wibXv9mW1oUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEWj0W18GtlHbGvGCGpiQIhisDaq0wLV7EXt77Rlnq8=;
 b=P/JZRA/0ipRIQA6mXb9pIsY+EekCAZaDyinr5QztmvghcHC+6Z55joz1YVPzPevrKxWLn5f9BXPl8LZloKrYyOSTpJS5My/Rvk2wkZjWS9915NKc1UmXRBVD3ByWFVmDyMWSxp8g9wN8yV1sAJj1+T7lzUeAfmR2/sLacDwS4to=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 23:05:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 23:05:30 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 4/8] hugetlb: add hugetlb demote page support
Date:   Wed, 21 Jul 2021 16:05:07 -0700
Message-Id: <20210721230511.201823-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721230511.201823-1-mike.kravetz@oracle.com>
References: <20210721230511.201823-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:301:4a::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1201CA0021.namprd12.prod.outlook.com (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 23:05:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4de894ae-193e-4d92-dbe7-08d94c9c091b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3735C8459FAED64DA36D389BE2E39@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHGYBRyUF94uGhmRsAbv1jPmaypVdTIIbc1mJEk1KmwlkFShPv/RpyfqF4gM5QZbdfbmhMie7L0JnFRcuwhhh9bCmBfaskZqcV71ZctlXTFRwhNW06rCZ1kTr40d9Zv5PbYWV6Qy6cVhWlE+LplwzMIeMemiHe/8Syr24HCZB7+u1XlHR5vzRt1+CR6v6W2inotqgJQnq/fu4e5sekG33WfbBgc6HomOTIKoMX+aq/1ni/LLN3g2zY4NN77lL1oU48I7Rh/GTbdDafSo0r2kh3MRSbH4rphFLqrr659hMbtQdoqO1CO6IVucI1Nv+/2NJWrl6c5f+mmGNylR3x5/D6IeEnHiFiyniSvt3mDrDw6jbmZ2ppUe5CWKuSIodhEG2atk16eAz051ExqHAvrj2PQd3fFoX+o+Xt5OF52NIDTbn8vXGjArY0juaYFigFZ7FDfA0pSL7uDWlXSfV0IN6COkbmB3ywtHaAdbui8Bgmg+B4TqsISajXQJ2WszSsQ55IiLJWwwnG7wWwd0v9HdZfnKP14gaTeJbZwFAPa6SCJ52ZpfTbCbq5jkHz3+P/2fb2hj+a00wGToDsEIcKV4xmkyzNgDAp8XDKYe3Lng46xaJA8Uo1htjjougQws4Ms/bZyalV+KbhEEZM7ifO471PxlRB/Srz9Mx5iAz4ORUTMc02PvMr4PEYYf/ysgQcPP5enGI396tmNsWORfv0jISQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(186003)(66556008)(478600001)(52116002)(86362001)(2616005)(107886003)(8936002)(5660300002)(1076003)(4326008)(6486002)(2906002)(66946007)(66476007)(956004)(6666004)(26005)(316002)(38350700002)(38100700002)(7416002)(36756003)(83380400001)(7696005)(54906003)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SJvcJzjcdKTOX7QqR2YNNQZ8RgrEbGFHJIxGE36CHR6Mt4PFKd2uua0sa1FC?=
 =?us-ascii?Q?GgCGzaZLzn9SObJ4QgOfOZ9BoxhOo/c2WM/nqZyRJY0ae6hJ9KtXjFnAS2e/?=
 =?us-ascii?Q?OYZJu5RbXHjlkthgNQPIF+ukbuqWnNiwhmM+QQK6EJtY5epBdgxR9xRUvQDJ?=
 =?us-ascii?Q?6E/Tvu0JTVzT+9hmGNJV2QtgMQ8m4JLSsW2NrhznD6XMNhm2Ax4qNRCmuGt5?=
 =?us-ascii?Q?AqYILo6YmA1ttUiGpDxc4Ou3onSSRF9WdYF9f0SrWWwUsz1c4C2j7wIJMEnI?=
 =?us-ascii?Q?qm914dmlv+QTsMIKk3S5zF8OukeuxKxmHf1jNs1iY0vMQlv3bo4HMm9QoOwv?=
 =?us-ascii?Q?8ckIZ7oDNcxgiVK4SGjR21MGs7jmSyMMYEtDBws5rmhsRuAM3ysQGXY5dxOg?=
 =?us-ascii?Q?KZ3+V6F3MwnKE9AsyWTB2RqVXjb0H02WUTBInCjlGFptRU33B0p61f4y5EUV?=
 =?us-ascii?Q?cihRvWz73ipMocIrYHKqd/mSr+hCeDO3csuto1+IiG37mP04nZicAfpZ8/1h?=
 =?us-ascii?Q?BBkaZFVT75ET9ZOkqLMJJCVl9x7bsQCsOj3X2HStzvJSJ+oM0gmp34U3P1oI?=
 =?us-ascii?Q?MiK5ktoFBX3Yw7l+KE9JkHdcfItnsyC9X2w0ppjBpcgu+SxtWTMac1pmNht9?=
 =?us-ascii?Q?WxPdmG2PekHxJ8eFhcb++6BaH8pfjU0XBGPowiAVs2MswI2XmP9flIoWC6SC?=
 =?us-ascii?Q?gfmmkzBnGamwZY+Z87Xbpv0oiJDwLgePs6LTgzTcTuyszvIlNHqVcQ6FnLEj?=
 =?us-ascii?Q?cNdPttJj+L+nmh0fcoUhEPnQR9jFwzG2IbHHG1TQYAEmZCfR1/+1DxLx4tvj?=
 =?us-ascii?Q?83y89EOS36CC2Ln8sMomqgvL+NrixKes19HbjB/0JK4oqSMG6Nei6qwW18ZM?=
 =?us-ascii?Q?B9aFJuS2CFYp4bJx6d7ElAjZ40xyE268QSBPSc00ig8ke+PA5zV+64RnFV7+?=
 =?us-ascii?Q?SPFQhG0ZxOzWv6z2uk0hjkNEm1Gj9hazkpptfdi6haAMlFBzE+spZitWbxTd?=
 =?us-ascii?Q?ZeGlLSCAyEdbtqnAioSr7Lg3q2nX14GpoHJDbdJGSTa5gbRpPTVf0dWa8mUC?=
 =?us-ascii?Q?AAUKS/OKTiikcA6Ey8+AhIu9MBJvKVToaj9Jk0xhI73yiSl41ydxZsX8D+/p?=
 =?us-ascii?Q?3jvpdGkWCGlJTyMyZ5zwU9BSRGtRzwcXMisYaa7M1/RVVajLsldPFjNmmUXg?=
 =?us-ascii?Q?F6+3d27EaQG1LC/z5A5m+g3vcIxL3qELrtaPdlwut+//dWOhmaZCUsWq4FPd?=
 =?us-ascii?Q?sEOnBqwLYmDw0QPDK1WfYwswBvJQ/vsWf7AvjadZMMjetd8VspRyLSD22X++?=
 =?us-ascii?Q?KiekI1Mu0wWNx/eVwFMb3eVp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de894ae-193e-4d92-dbe7-08d94c9c091b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 23:05:30.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTTSB7cXXKv/a7RwlE0OM4kR23bDOKa2EzMoSxGzWJlcUYr1xtMmmLT/CXGm8LqkEx0IYjf0Aqe/nikBHRMFrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210137
X-Proofpoint-ORIG-GUID: dBhsLCujzss-5qDBFDXxlv_qxCySU_wp
X-Proofpoint-GUID: dBhsLCujzss-5qDBFDXxlv_qxCySU_wp
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
 mm/hugetlb.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0ad75e7775dd..9bbfeba3e1ae 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1279,6 +1279,12 @@ static void destroy_compound_gigantic_page(struct page *page,
 	__destroy_compound_gigantic_page(page, order, false);
 }
 
+static void destroy_compound_gigantic_page_for_demote(struct page *page,
+					unsigned int order)
+{
+	__destroy_compound_gigantic_page(page, order, true);
+}
+
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
 #ifdef CONFIG_CMA
@@ -1418,6 +1424,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
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
@@ -1764,6 +1776,12 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
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
@@ -3271,9 +3289,55 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
+static int demote_free_huge_page(struct hstate *h, struct page *page)
+{
+	int i, nid = page_to_nid(page);
+	struct hstate *target_hstate;
+	bool cma_page = HPageCma(page);
+
+	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
+
+	remove_hugetlb_page_for_demote(h, page, false);
+	spin_unlock_irq(&hugetlb_lock);
+
+	if (alloc_huge_page_vmemmap(h, page)) {
+		/* Allocation of vmemmmap failed, we can not demote page */
+		spin_lock_irq(&hugetlb_lock);
+		set_page_refcounted(page);
+		add_hugetlb_page(h, page, false);
+		return 1;
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
+		if (cma_page)
+			SetHPageCma(page + i);
+		put_page(page + i);
+	}
+
+	spin_lock_irq(&hugetlb_lock);
+	return 0;
+}
+
 static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	__must_hold(&hugetlb_lock)
 {
+	int nr_nodes, node;
+	struct page *page;
 	int rc = 0;
 
 	lockdep_assert_held(&hugetlb_lock);
@@ -3289,9 +3353,15 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 		return 1;
 	}
 
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
 
-- 
2.31.1

