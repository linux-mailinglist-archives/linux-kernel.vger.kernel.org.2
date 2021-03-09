Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFCA331B92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhCIATn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:19:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48126 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhCIATb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:19:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1290BgfX045027;
        Tue, 9 Mar 2021 00:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=mA6OzM96OSwzRiPzKqRGgEyHF5oNJxgImVUa1vUDHJQ=;
 b=tiHuDyF0eVu/jrhRk8kGCSTm3Zej5a4P3K8snbRvriy3hrY3vURRZqocfYqCtwLVUm0q
 t6dfd2gViNAAFqN1gx+lWWO69LJIRLIh/tsRilNecLdlBCysL3kLeno8uJZ3vAP0ET4q
 r+ekqurRM8Yd/XOgBX6QsvgOtciE6Z7eDWBg1wTpn2EaAhp9M9N0ySR7MqqkFLT/a76M
 6ESF/W1vcvrYqinjbMqHdnd6/+LhXbRGvG1CHESS0O0ltp/CZ4qmwU1AxtVpL3MY1ZEt
 EdjXlOhBbq5ohBZw2owJC2dOYUB4T0lAj9/A92cCU4L5YjAHMlkTKj8Z+Dllt8t4XGgz YA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37415r5j3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 00:19:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12905RkM180944;
        Tue, 9 Mar 2021 00:19:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3020.oracle.com with ESMTP id 374kmxpy5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 00:19:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiLcL4h//WGxGLQNO8Q1XT6ow9tZSLEhu2ZQdy1arBow4HIUZor4yuV1kbOEvVrYwk2YJ+AUS5OWGrokHgTqO+4+J+VkfrS+QHxVw+SbiyRfzn+ArQ71WTgNo/n8AV0oF9QvldvcQ2bPreANH4GjqJ/6srHMwspqJY9bZg1ke7hv5LwXHfoio+/KxZrJhkLsFQmDtdvSGcZtn3u++1pOV2d/DWKThFzxf1nFo/hvEMJ1fhm6wytWN3DXZrMSthfN48ZkoLhTT+juhFE23D6KdUlFRbOsxVrNPpOoEPqX66YJQahLkxnqeQ7EcA08Rv+sqil1x4UQ5Xyp99x5rQdSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA6OzM96OSwzRiPzKqRGgEyHF5oNJxgImVUa1vUDHJQ=;
 b=oe6PAd0YEoyQTywhK7ofUQsFjz5t4/Sz8TbQCp725RXoS8fi/7JQdWAeRe6laGFsktNPbsiXPg213u+iAAMydJ/SDYgXZSlyKJ5PpB5dDTNt1BPSAHPFUonhRRab5mgQwg0KMWtJwL8l2r0C7Ucx0J4Us0qb1k1FxwRp00snXTRxkBLE3M8Hu1O8ZX5nr3p8BGpTtFnXWCMS40rxPewh/5kaqwpSz598R4ZDbS0MKPUCrSEdQ+kxfm9DExFdIddWNycleXRl/b3Jxd8ocRCZB2PPWed++FpaWDhR61jjkxkvhyxgZ5PwtONl2sU+cBZNOaXWw0lW79i3z+Ppka4bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA6OzM96OSwzRiPzKqRGgEyHF5oNJxgImVUa1vUDHJQ=;
 b=R+Z18fZbDaxdMZp3ZARem+Tj7P3FWxMrFvOgKMqhKYki7PHDh6DoMVhJvCmKudCBsw30vqHJnG5JCwA7jv1v+FwceAhevPgUxpaUVaGTX1QymuGbm8ab2tzXhLpSuBnUTgrUQ/hJnH8ki9End6533tuzCGp08RyoxP5kQ3oiBho=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 00:19:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 00:19:14 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 3/3] hugetlb: add hugetlb demote page support
Date:   Mon,  8 Mar 2021 16:18:55 -0800
Message-Id: <20210309001855.142453-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309001855.142453-1-mike.kravetz@oracle.com>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 00:19:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b40539c-79d0-4916-6893-08d8e290f7dd
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4541B14B1F2C9751AB7E6164E2929@SJ0PR10MB4541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BX5kN7shPjS7uRUOPXHeoMbohKpubrPAzduJdOiU5mZk3aExrT3Bf9eeGFvhWAI1b17+fy0UcIpl+SuhQ94FBhbNjCOYgWQZoM8XiiMbCF0aZVt6JifJ9O22eZF3Io4IAtWaeWSCW+Neh4mrYqpeiNHsd49huF9ddfjhFH17VpLDDeh4BX8X9j7p3U3lo33DSI3IS3mlOYX5jKS6pFNT5lbokfVj4zQNbxCmHMVd6jKVBAsynMbLtUgOeUpwArHVlG27/VYerByYK/4LZ6IgVlz0MZIj5UX+Q4cvUGQoLEtPZLqT9KNwGcUXOv5Sc6ugod0NKa1mOKjLj9gZU0p2ZkP97ckedayyboad2JsVO+XAObgeHufey3aMRuwAPmnq9uYpV3BhLEo0j3EQN6hJFYhD4mGy9xMZwOjVLkurh2YfM8X5ul8kRccUaDOptpkohJjlKTmk5zBbRsd5CqP9fCmDqJRVfixsDlqmyfuAvjtiT3ZQDQVc+KUGvtd3jg7hv1iB566C9IMqYqQNi/vxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(478600001)(2906002)(66946007)(186003)(6666004)(7696005)(956004)(1076003)(44832011)(26005)(36756003)(6486002)(52116002)(8936002)(66556008)(4326008)(83380400001)(16526019)(66476007)(8676002)(5660300002)(107886003)(316002)(86362001)(2616005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?crr7LmwLXZ8nEG1ob/FeIhYv/fjdGck1U+hrl9sZhKvos0wG4V6JNrzH3u6m?=
 =?us-ascii?Q?aDRajoOpgZrV+rR+TM1eii0JxePN/izKwKDcV55P91f8VWm2XIbwwXX7Go9X?=
 =?us-ascii?Q?p3FCkBUqrtkms1MV6jk48A8NpTAYI98xk638jZiri6PWi79x1tohe289vWoV?=
 =?us-ascii?Q?tAz3FjlEdqpiGHiM7Vjj9dTDRuQKmBA7G994ET2tP4vlXalduqECvIEF/0mS?=
 =?us-ascii?Q?R5HMu20oZBH8kLFdHnwzMLCeB78n65IUeWnrWK9SL2GRQqTGEWs9inLT5xvK?=
 =?us-ascii?Q?LZAvbNfUJeBu5lMBvHw4CwLFX8dHap2DEH/kcYE2uaPOWOrKyTiLHGSX49em?=
 =?us-ascii?Q?HhaYJKnPNeFQKw56rJCjo9kNrI6td3pMxFj9o41o/QDRYCI+hP7ak29qH5SC?=
 =?us-ascii?Q?KJdpr7LZKZP6mdDl/xMpQ1tCBfJdyZsPoWri54wGykdW+xTC0V24b/sEB3jT?=
 =?us-ascii?Q?fLp0kVqg+fLwgqJy43S/3aiRGLwWDMUALk2qGRrTGW4Z9oyfPVdSYDRCeQgZ?=
 =?us-ascii?Q?kPNcHW6w0NZuXIES6wPyAoevmC4gL2jNweWTOfNKsTlfoVWr+6FZ/4flvIT9?=
 =?us-ascii?Q?jG5ZSbAQAKcJ4HtEfWo8Rna6DXmPJsn2Am5vEtPzvckP0MReA0EkzPDX0WuJ?=
 =?us-ascii?Q?vzJabyXWE8Na9Q8pygbOEMb6KMMWQwLWUdoineU0c6GDKZgkWb9Jz24+5lnm?=
 =?us-ascii?Q?Z2WvToTAA4+vECyLCFO2dvwqleUCLB8IVfJn4vqNLP46rLmwLil4YiKMKbFJ?=
 =?us-ascii?Q?SFNWfLcpTtdAIzy+3eXRj1aYGJV7JtiGkYal2XLVh0EPikaFtck+fNrIDZPs?=
 =?us-ascii?Q?Euob1EciERq0fAPGR7gzPLJCMv/x6WjDNWuEYYn0nsJ5b0SBDyKqotUFfPI7?=
 =?us-ascii?Q?fxjXgvaRipF7zLBlK0qaWlXPc/cPUOajOxq/eND41NM2kCP6H9r8ZQPFFAIA?=
 =?us-ascii?Q?hl/gN6OtfjU6QKOERrlufRqJ6fCQuD2CMIoZ39b9F+gY79NvRZtJ5pNLHa8Y?=
 =?us-ascii?Q?c8ycEA35wMbrCqTjwcQDnKrLPkNItgP+60slrhwg/Sq3vzKh1WY1lXm4Cl7x?=
 =?us-ascii?Q?I+lUBRVNsd1BSUPR/8Pfb7hMfnYiKlyi2ZJ+Oddrx/0NfTb2x7ghiRrB1NsJ?=
 =?us-ascii?Q?5d0MDAlHm1fEjx1VyeOVj/jUHBQTfbiaU48TmsVksFebHoqHHEvvJjU9Etsq?=
 =?us-ascii?Q?PYR1OkOmBPx4bMuCjZ8uW4obkXQiXwDVFtadCgTsNm+wbB8ec63nyJPQrVvp?=
 =?us-ascii?Q?k25nHCLMrol/i/ZCXu42DMbdaP/YDMq/RRU10Zkk37kGsa8bDxQZJJuzqyY7?=
 =?us-ascii?Q?W57wrSG7PXR8T9Py00cvJTdv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b40539c-79d0-4916-6893-08d8e290f7dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 00:19:13.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS7d+V5R4oNK5woOmcKUy8OGAf8rXvraVdoXl04DjeoIHuEJTb4wTKi+ULhE3sxGr2RJ5i2O5fip4/G0HidvYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote page functionality will split a huge page into a number of huge
pages of a smaller size.  For example, on x86 a 1GB huge page can be
demoted into 512 2M huge pages.  Demotion is done 'in place' by simply
splitting the huge page.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0c29b7d0d469..33b0d8778551 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2744,17 +2744,72 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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
+	ClearHPageFreed(page);
+	list_del(&page->lru);
+	h->free_huge_pages--;
+	h->free_huge_pages_node[nid]--;
+	h->nr_huge_pages--;
+	h->nr_huge_pages_node[nid]--;
+	set_page_refcounted(page);
+	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
+	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * Note for future:
+	 * When support for reducing vmemmap of huge pages is added, we
+	 * will need to allocate vmemmap pages here and could fail.
+	 */
+	destroy_compound_gigantic_page(page, huge_page_order(h));
+
+	for (i = 0; i < pages_per_huge_page(h);
+				i += pages_per_huge_page(target_hstate)) {
+		/*
+		 * Explicitly use prep_compound_gigantic_page if demoting
+		 * a page allocated from CMA so that TAIL_MAPPING is not
+		 * set in tail pages.  The CMA code does not expect this.
+		 */
+		if (cma_page)
+			prep_compound_gigantic_page(page + i,
+							target_hstate->order);
+		else
+			prep_compound_huge_page(page + i, target_hstate->order);
+		prep_new_huge_page(target_hstate, page + i, nid);
+		if (cma_page)
+			SetHPageCma(page + i);
+		put_page(page + i);
+	}
+
+	spin_lock(&hugetlb_lock);
+	return 0;
+}
+
 static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 {
+	int nr_nodes, node;
+	struct page *page;
 	int rc = 0;
 
 	/* If no demote order, free to buddy */
 	if (!h->demote_order)
 		return free_pool_huge_page(h, nodes_allowed, 0);
 
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
2.29.2

