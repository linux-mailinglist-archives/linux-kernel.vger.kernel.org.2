Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CE234DC67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhC2XZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:25:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54204 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhC2XZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:25:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNOK3s074256;
        Mon, 29 Mar 2021 23:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=l1MGVnvXX5XZLTEdq/dQIWxlrE3poh+6I2f5BNcsii4=;
 b=uIHiavUBmeKuOAlCmHZqhvUCgqEk65uH0DVTNDK1Vn3ChgQiO3JIq3ndhPKAjkwuQ3Fe
 wpnAXEj/poPWszozq5LP+fteYwk2JjWzK8F7uVpsQRNGUdCECJSe3wbf/YgvXjLsJvDk
 adxn2iQevIadVR36imVl/YpYu9BRzz+ZtBmpJus+gu71XzjyAFG63y3gBo/Fy5f+cly2
 Jvq8e3DalCgD0HiXKmVvNUut8jbp5X+J4w34FmVHTFZsMythdc2JqmkqlmDC7bKEOW3x
 5nOczE6oGz8ObbDz220pC102Z2wxVSEjAjABZgTQGCNPAqe4ucL9HdQe4QZY35447m/q Iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37hwbnd6tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TNEmAx088315;
        Mon, 29 Mar 2021 23:24:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 37jekxsr9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 23:24:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaVPK3Lel/jzpUmXy83SnPGXXiRDmWlEE99HnsiaKf1oqsQfriZBHzwRbQokjmeb51gA6SwiVnmlZFXhVNIbTWmIc6r8HWCgMvvkdZgu9f+yTT2Fvq8B8kEHvRYaqpTkI5uXl6CFu/NnHau4fGC5N7nIqsu08tlOLnUhbPS1YBzt1+qBtpU4hFCpMKeqGSotJxnJVLKW3TQDsvD9xeneTb7ajtQMqfGFWjVDIuOdkiixFfTbocLfQ9WtDOOeAaULkn9zS692z+b4qOnuTGEG2al2NZk+5mKul0JKkFxqX1fL513hqYqVgjAKQontLPc48yvIzgy8HYk8Us65muXUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1MGVnvXX5XZLTEdq/dQIWxlrE3poh+6I2f5BNcsii4=;
 b=fONDyymA3JT4mCHgGmsm75qmSuH3Psx6jGEH7s92LcgGD7am3lPvw2hsd46bPJX9xSi/S3FoeIrTvlCcUDsFyctwUDUFrhnWaZq+b10ybqv/c4vb04duN+AHxaEioxTm7tmsJjORVcW8Wx2qhK64znU+XfCWwxhKD1HAc/83BPpv2BHYWdSM5XhYnyrK6NsxoJVwERzMSHolee96LS0IhElFzqDLVQ2cA6bCHq7wtmbTjCEhaH0jcgkYsFVrL7Igl2jXvTGh8jdOrKFQTNXiYZHpx7VyPJp3rzFg7YOpZyNhYN0K1bMCOhAXMWE7XzomByJN3j2Dl4JmUxYZ2zu+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1MGVnvXX5XZLTEdq/dQIWxlrE3poh+6I2f5BNcsii4=;
 b=kWwncddqXQoZWQLsWiyL/wBglKhe3ZZYlnerFMySroiPiCaZNbUUlkdwZtj1duf7+rvGA8YC/PlyUJTHsdEQwoj45Ll5EKrVppeGpwaRg2rwnFpSbtgV9EGa/12oxEWUk09+Phrjp5Z/mzXn4Z0ZNhouF+SBpAOdIK1oeWNAh0Y=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 23:24:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 23:24:20 +0000
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
Subject: [PATCH v2 2/8] hugetlb: no need to drop hugetlb_lock to call cma_release
Date:   Mon, 29 Mar 2021 16:23:56 -0700
Message-Id: <20210329232402.575396-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329232402.575396-1-mike.kravetz@oracle.com>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0065.namprd10.prod.outlook.com
 (2603:10b6:300:2c::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR10CA0065.namprd10.prod.outlook.com (2603:10b6:300:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 23:24:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 368e27ce-c047-4a42-cbd4-08d8f309c7be
X-MS-TrafficTypeDiagnostic: BY5PR10MB4148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4148D442626930E817545610E27E9@BY5PR10MB4148.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8FJa9kgKwidrG/8eR+gcO+oOGscanrAjo3YLk9neddh2u09XxOE/hIEO6hwShModqlB+L7vKGbWR2UMSChpM+jmqNaCLrMCEOEFFGAstD8vWSStrcnwois+aIq8OR8jZhAIApeV/4t/erk5Ho16je0KhrmLb9Ri5QazC/xuEjL2bDJ6SC0u5Z2JWYPx2j1vnVuNh9Di1iCV8foe5N9j4QjFw20ZVJ+m+5lkG8FoOoSWyXE/9ILwFsz8xcTRXXn/sRDaYD7nZDF552BKcR5G1MKsCnDtFvsQxvJ147gS3abazBD5A0nYDTr0znEfNW0OmFs54IjOmMYtmfT9K6ViZo3h6DODz6q6nzYiiBrfvrHnab0kS9wyORfgfCvcN6+ZN2cQJaNspsXHCfBs4bbB0060CGWxEJW9Cw3vLKhIMXVCQzbiWUp2oiRzUKS3n0dV6A104Fqp0fdP6mqTlVLn8OITu8VX4jZ8NTGcVBmD93mwkrH+rHuiWeZsXMK54A6R1FUq/RduPetTIy8DOViruNnfAY/Z++HYU/dtHrYyYlUJUGA3QtzM9zif8vf60hNfXmqeGNdMSVtayLCUoop5yQZln8d65wEPi+IiuSsZk+M9++4AvydUPOCOIHuI6orWEAEmcn8BNUO50BDZcX34WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(16526019)(44832011)(52116002)(26005)(2616005)(36756003)(186003)(7696005)(7416002)(956004)(478600001)(4326008)(6486002)(54906003)(6666004)(86362001)(5660300002)(66946007)(66556008)(1076003)(4744005)(66476007)(83380400001)(38100700001)(8676002)(316002)(8936002)(2906002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PYEke/HQphU4VhSHbPr419OVppvRl5PmOw95hXzlC+YLmRsgtqPikmUivV2x?=
 =?us-ascii?Q?EefTgZ9LD1Dq6YdlJ5UjgaXZBgvSSPlnf5KUP+DU+TrRGznZnW4zANZcPzzB?=
 =?us-ascii?Q?RJAyXx90r44cxICtLXkmHrj9t3Qw6jrT5rGyXdVdjPU54PMA+kQmUw7Uawwi?=
 =?us-ascii?Q?cA7uYrefAZkrwsNQ/ef3hOP6mxFL+oLV5KVu9ayc6/ZAUye0SY2d+b4l4lEY?=
 =?us-ascii?Q?oFNARVC4LxpO6L2LPmYwlh09TJm8us/BPiRK1ETOtRLcqHduLVXYiP5WAHYC?=
 =?us-ascii?Q?UrpJtDgT1fvks9VU75MrdDNpq+BaX+ZTKkQLRCFEBqDT4vPWWQetWEXmHW7R?=
 =?us-ascii?Q?mqdUPD7s/y1oWCK4NOWpF07WspzdCW52qvcpO3l5xJeGiY5O7wJ8szLdcvy4?=
 =?us-ascii?Q?S4NhOAQ+uFZCwIRyC1Q3ZbNIqejVZ57bc8ehcBNX9G1vXE8VTrl4Oxda25yH?=
 =?us-ascii?Q?zTdlVgGSnmE4cFMqGSTHmHGGFRU4KWGjEqYM2B9unQIc4DPiBz+WWO1nhiOq?=
 =?us-ascii?Q?ty6Kmyv246Ty+RKvTeH0r89a0lpzhzW+waAOEBZUcfxE2afpT6nyD9nog5md?=
 =?us-ascii?Q?2hjxsmBJxODItJnDCBw4KSJIHVsNlmVeV2lvTKoEc0FWJFoAzt6hRnj89sfo?=
 =?us-ascii?Q?7lPlPuhHY5x64vE44euefm+jdxuRQfoZs4WV1lM6xGBbvj0GVIgxyY3Z2eQD?=
 =?us-ascii?Q?7KI8lOh90ewfVxg+LCqGsL/Snl5VziUuoj3S+qQWgZmcdBpDkhEoHfh7b9T6?=
 =?us-ascii?Q?1arI5aMuL+FLF8IZlbdy7TeQrkAr4eek5MzfS7PT+IBfoB1E/pCLkir1F7WM?=
 =?us-ascii?Q?3f7TIeCDeM1AcpNplqW4DhTYKcB19fde6hksY5F8mPYLc5BeFUs7L/ZhvgIE?=
 =?us-ascii?Q?EMJwpStlVoKhDE9nksvsRzLw3FHiH/QehSoH8O8XZbt0TTQffurDls9aEPSy?=
 =?us-ascii?Q?Dq/Pj8XO9IOmwoalz4i8/UueRXvRwBAwrlRdxhiucNvy7fblSwjOq4bZW1X4?=
 =?us-ascii?Q?bWk610NSTr0RgbGzq69VE1gO08sMw++bHBFh0QohAb4x8+el3alu1pegxg2h?=
 =?us-ascii?Q?3NiPggqCbmqJvA3iF8wAhAjr3rgEXeQgG0bb6ukfk8IRUZbEji4x/JXkgRln?=
 =?us-ascii?Q?GrSRP95Eyd4haocXbijcP2Sm7jK0mz+oOvp+dkHWxdagJ46J2wvRrLLdUtP/?=
 =?us-ascii?Q?xnj5/AJjtZOj7JoC3S6xbto7UYtuNVzOzs8dLOAiVOpzZ+HscVkjggUDaNCU?=
 =?us-ascii?Q?8p9IlF533TM1Ed/8SdcYVmiiKo78BnUxjSd+D+yZNQwyRbalNK25+aYLFqt3?=
 =?us-ascii?Q?nzAaizWhOAhdwU1AzBdIxwQM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368e27ce-c047-4a42-cbd4-08d8f309c7be
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 23:24:20.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhWYsA2ZT7xXWxHBPhclqrpKw00b4SgIV2mbikpzi/+TMko6+x7Cp+CXaVoZI8W8IXcde5iKzIWTyoWVLtyySg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290173
X-Proofpoint-GUID: rYtRNA97Q4qVHxkxfj7CUsMR25DaKGHx
X-Proofpoint-ORIG-GUID: rYtRNA97Q4qVHxkxfj7CUsMR25DaKGHx
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290174
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that cma_release is non-blocking and irq safe, there is no need to
drop hugetlb_lock before calling.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3c3e4baa4156..1d62f0492e7b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1353,14 +1353,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
-		/*
-		 * Temporarily drop the hugetlb_lock, because
-		 * we might block in free_gigantic_page().
-		 */
-		spin_unlock(&hugetlb_lock);
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
-		spin_lock(&hugetlb_lock);
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
-- 
2.30.2

