Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9DE3E4C61
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhHISu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:50:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35794 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhHISu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:50:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179IkMkA006791;
        Mon, 9 Aug 2021 18:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=oKJUDB2Wy7QvwHTcImdp43Gkc6hzN7+WTJmshclrgtk=;
 b=Sxx5PAq7LobREs4zI+LZMukepvmIuZ2Gpc7WF2eZTNlaYYF2gxxgNUIG6ray3AvJMoRy
 O+qrJWRLODdFGkEP/d+Fg8fb1Oik620TQ11bJ9xp1pvblgXLgTXbImDvQPpm2slxL9Gd
 f9dJuyjEWmu13kyZNMXuRaiWYGXnuik/itAJI9a8tgLbNdJrCCfGBX2FwJRavJiT0m3u
 3FJw1Zhp4LZ5r9g15WLpPeJbFmhUN6AyC45xMbOYiN448EtGUDxewEqgoAS+77oW/lNT
 3yeiIc9PH3OzpWcGmq6fj/nx1ctU4mUYokNeGXTaYoKYq+r2xvzp1dfIsUEcPqz6CHN6 JQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=oKJUDB2Wy7QvwHTcImdp43Gkc6hzN7+WTJmshclrgtk=;
 b=YbvjlL8PasGqp2hhtn03L/4ehZvfnad+BX4isuack49EWWetw0K+Eb0ZHWI4llFuVmFT
 LIaAn2baVuE7bWnT5ylKn5frlRzwbHSCLq6Zwu8aEBXDedzdWj6yvulxgQdJMhuys5Zk
 p4NxI1HahM2OpzLiYB7E9d/fhKUR3siBIOck3Cfnn8r5swwoWJUBVBc+C4IBhehN2yXC
 g+bPWHZbvNqZaKR3S0giv5BAX8DydYh/tO9GX6ypl2f5xZ9D4IGv4V2qI9Z1XlYprEqE
 8b4w6Ftz0HJMtV8S1V3iOO9Krr3+Rpy0nhkR8TCWorX3TN2fnWc1pMlv0WJ1mPkp1LzW yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17dsd7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 18:50:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179Io53r164818;
        Mon, 9 Aug 2021 18:50:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 3a9f9vgf74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 18:50:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZDsdu+PPvKm/WK7qzkXSbirFKALscQPbcfzI+TjwJLnZ3ohdjl63sUMcvBAX+Cyop7q9476EQWDSrrEg2OarU9bXYcPV2SkAYZql01uKEXq657cS4wAKLSb+pWXFBt6rURM6KWH+gwHI5IsEeH8UupKAKnuFHzrAx1sFrXxpo2bdxR8xlwyAljec8MnCxW1NVakQcE8Rb+Y7b35EPdZPAVqfiF+2YRyf+mbbk26lYXH5Oy5SasUsFTsTmJiZf7WXfvJls1bPZmENMiLYRpMNt17jGP2mqtDDOz1fpEL8OPlVK7PWYqQpLheRGSu5/O/P+omxsyF7ZSWA5xbGpAEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKJUDB2Wy7QvwHTcImdp43Gkc6hzN7+WTJmshclrgtk=;
 b=JRljBX6+KURMAWJHAKdfkZa1SdFVYEparLvmT7lBzeb7HWr4gJQoSfTzv6GWlOxW7Hp63wAV1N0W+uJZqIHLatJ2gkhK12CP5CbhWg9sqO6sMrbLttA91S8+lfYOo/ZjvHxeRugTlTV9hno+n2r+EMJHG/aCb58ELhubm8daKL/hXelpOxED4b1jLqLpoGlFOSjHEyzrI8UHTo9itZnuoI2ykRCLFb4TnoQIpqnPAuwlkrfEB2BAdhxKeXDyURnO+9HxCtvTc09qQwuPQ0AGYhZxCumZUZkd7/p2S2QJlXOjmJJvRTrVUkyHttAD4l03UyGFP6kRlC+9GYfUMgYZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKJUDB2Wy7QvwHTcImdp43Gkc6hzN7+WTJmshclrgtk=;
 b=mK2fzljQkr3RzAFFENaWnGOxfETIr2MByA2tuV5vWpYzDATcUKVs2s26g+YtWhSaBZJHsAzXE2Mu5SWZQVQNU0Ny+bPzcjRGWHunHmtBTS6j3GYmU+kB9OOYoNlZUeWL+65641BgB0D/4XDToVNqcexyX0h5C/QKzCH7CYxDANk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5455.namprd10.prod.outlook.com (2603:10b6:a03:3b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Mon, 9 Aug
 2021 18:48:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 18:48:52 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 3/3] hugetlb: before freeing hugetlb page set dtor to appropriate value
Date:   Mon,  9 Aug 2021 11:48:32 -0700
Message-Id: <20210809184832.18342-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809184832.18342-1-mike.kravetz@oracle.com>
References: <20210809184832.18342-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0341.namprd04.prod.outlook.com
 (2603:10b6:303:8a::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 18:48:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a3f5e15-3f32-4235-967a-08d95b665551
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5455B4133E351D73F3DC1015E2F69@SJ0PR10MB5455.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjxX1bSSYlvmilhtvdsA5fpdnvFksYd4IfGGyfxdsiBUyGTcMP9ddehJzM2lSZXBXbRwB+00sHxdeSYsZzewDuMEyY1AYLs+Vy5DQ+1M/gOlR3XUCVjjF1khpGKpgtNWQV/p1cB60RhWLFFnxoJ/6UbJw1n7Qgp8XWQ4w2EOfGzqyMwpFizmduDFJJWAgJawtMDLgtkk5mzarSNT9BS3JBgLU5rR2RToNadmWblkepw1CdQwvR2gnZyPbMHePQb2RxP2xyHvbKxnYP5+BKfInIM7a5QN/8yhR2+umbqmuwi7qNoBAg4dAQ3l1KTcmZ0vZY9rqLydbYHenEGj6rC4E6lMflEGSLG1RcPN2iogW7rDeP/zoX7SmHE4yhx+9JVuAtm6qQQN8LYQAF0HcQkQRq+nlLQCEbZTKBx0bG4A+9W+5V8i9Jy2DaGY8m95nKIrrtRN0ItxZ+vobHf/vUl/zcQ8jzSKU3BuJpNG3JIs0v3TO4wD4ob1PUd77m6gf88c5jLeS5pmlWMSWXEf5yVXg3ydZZofOyCYyYYuSaKgrg8QRO2H8QODh8nUIaAQPBHXfFPkWFICEeaA0MT6Obimfzr19BQfY1HC6VIvyu9gsGa4G3lkO8RKO8W8387G4nlcxRyD1A6TX7t4f1C9eqPQIq940NjzZg6QFoR7EX/8HW+A+wqxfhJHLSCpYRumXnKn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(396003)(136003)(346002)(7416002)(83380400001)(86362001)(316002)(956004)(2616005)(5660300002)(8936002)(1076003)(38350700002)(6666004)(38100700002)(8676002)(186003)(6486002)(66476007)(66556008)(107886003)(66946007)(36756003)(4326008)(478600001)(7696005)(52116002)(2906002)(44832011)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m49t77PVQq2xSCHAN17BZMRQHYyNhtXt+3K1LbYZCrEJz5I/RXRV6jG8Xfcu?=
 =?us-ascii?Q?Pm5fMjmsN0ws2UcSegVyxl9ycS1pVqyvFbWdBcZfGLlwqQSzIJUHluoZGG9B?=
 =?us-ascii?Q?75ZUf/LpOlCEX8RzWzg9sXfsuXrP+BTUDO7ggQkfEsMkxFrzUCns+RV8jvT2?=
 =?us-ascii?Q?CvdTCfmGloMbV+7tb29QZnXIm+vuAdes05jgTOdGa6OLPyZwueBTrb2gtUuA?=
 =?us-ascii?Q?HYqY1W95pcDCRhGmsaW6UkmOD0BuOamSvfDERivTR4IHZDAVm7oI9gatwIgg?=
 =?us-ascii?Q?jwkmU6cDp/jY8sBSJ2oRYM+DeEoY1dv+YRZR3/9ZxtdAyMn8FFlkRc2uitFl?=
 =?us-ascii?Q?0Jy4qKGaIuPycz2qRl8aN8ZUzDWfiVvMqefaDPOdUTFaDJJTuCmUY02UagCw?=
 =?us-ascii?Q?lD67j1IMlNbILxGerqPR67aq5wszOuJsaQtQO1xorVR0b/3K+j20C+GCxgxx?=
 =?us-ascii?Q?Z3w3bzfxmcnejbsYhnH6qnEVTPXqQShAtjelKiy9XxXpKG0Ajp+7rBpH+Gl3?=
 =?us-ascii?Q?VE5pdLuXZArraSLR0JZ76RNgz8vyn/D2Lex+6PyOHzWN2kiSNXRyHEWo6ZVP?=
 =?us-ascii?Q?gW3pMwU342SfG870t49NNMcVhdSPQ8GFuMxOU2wllg+S+BpQirrl2WD3qUiJ?=
 =?us-ascii?Q?McaVBQjMo+kQPjMfN6vDXcYJOBp/DKr7OVWa8/jh1EfcXzo4F3weGIYt9vst?=
 =?us-ascii?Q?39NdHk3Gtu4kkRG6Za1znZNWIbvycBjn/V6Fn+6pi+DRYob5tCqETXVYUg4A?=
 =?us-ascii?Q?uz99vmqAWwpSXdtD5QaKJIhJL+ASDwAtENrGxGZd0UDAMs81DVRw+9+KADqD?=
 =?us-ascii?Q?9OHVdnd25fbKGMbZR51tkSJ+51xm2MfcTeg9TN/dIJtTGCAAYWLpX3oI04ze?=
 =?us-ascii?Q?wxflNlJcV4RFDk3qADxtijcz+v2mQKVxIptNS356kwGh6QNjxEYV5r/kRHHJ?=
 =?us-ascii?Q?i74cUgsXCrgCdzZK9Kte94hbuTXW1vpp08xpO3VD1zN5asC753oa2MfB1EO3?=
 =?us-ascii?Q?gv+E812XUzwZTcyuKda4gAQiPg91vv0Z99htg19JJsDF6a/tUEJxpkBdVhBE?=
 =?us-ascii?Q?GhNKk+Cne9rXUMiY1d96qbcWEQ51bmZRHRPsGOfaHxV8idp1T3hkIdSZyyB8?=
 =?us-ascii?Q?Vgu3RUVLg0yyBQx8v89pqAl8fkBMF8v0SKxyFBPTrcD5TDVjBPFAo5+NWNPE?=
 =?us-ascii?Q?ydKtM51yKFbJCePLnPHKiDBA8Qr6txKrKMGCfaivviJ+BeXsPBiwl/vNT+Hr?=
 =?us-ascii?Q?sNaSwBnT8ukcQv8Lgi2Z0/Ps8h7F9binDuqpHI9hu+S2FN5Fm15F2fYG750U?=
 =?us-ascii?Q?MuyRVYp0iFzUOzeNq8jG2k3+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3f5e15-3f32-4235-967a-08d95b665551
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 18:48:52.6763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fsA5fgxFnZ2I7haR3QKr3ixJJknvDONB5Y3gu6fGAmpPs8+bKP+eOo5JrJ7Ok+x4T/WSK1fQo12rob6Tr/zSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5455
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090133
X-Proofpoint-GUID: JqyZyoyrVN_yv7KLKO_i3um5mEjHYuhm
X-Proofpoint-ORIG-GUID: JqyZyoyrVN_yv7KLKO_i3um5mEjHYuhm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing a hugetlb page from the pool the ref count is set to
one (as the free page has no ref count) and compound page destructor
is set to NULL_COMPOUND_DTOR.  Since a subsequent call to free the
hugetlb page will call __free_pages for non-gigantic pages and
free_gigantic_page for gigantic pages the destructor is not used.

However, consider the following race with code taking a speculative
reference on the page:

Thread 0				Thread 1
--------				--------
remove_hugetlb_page
  set_page_refcounted(page);
  set_compound_page_dtor(page,
           NULL_COMPOUND_DTOR);
					get_page_unless_zero(page)
__update_and_free_page
  __free_pages(page,
           huge_page_order(h));

		/* Note that __free_pages() will simply drop
		   the reference to the page. */

					put_page(page)
					  __put_compound_page()
					    destroy_compound_page
					      NULL_COMPOUND_DTOR
						BUG: kernel NULL pointer
						dereference, address:
						0000000000000000

To address this race, set the dtor to the normal compound page dtor
for non-gigantic pages.  The dtor for gigantic pages does not matter
as gigantic pages are changed from a compound page to 'just a group of
pages' before freeing.  Hence, the destructor is not used.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bde324e69276..214a02232d6d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1370,8 +1370,28 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 		h->surplus_huge_pages_node[nid]--;
 	}
 
+	/*
+	 * Very subtle
+	 *
+	 * For non-gigantic pages set the destructor to the normal compound
+	 * page dtor.  This is needed in case someone takes an additional
+	 * temporary ref to the page, and freeing is delayed until they drop
+	 * their reference.
+	 *
+	 * For gigantic pages set the destructor to the null dtor.  This
+	 * destructor will never be called.  Before freeing the gigantic
+	 * page destroy_compound_gigantic_page will turn the compound page
+	 * into a simple group of pages.  After this the destructor does not
+	 * apply.
+	 *
+	 * This handles the case where more than one ref is held when and
+	 * after update_and_free_page is called.
+	 */
 	set_page_refcounted(page);
-	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
+	if (hstate_is_gigantic(h))
+		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
+	else
+		set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
-- 
2.31.1

