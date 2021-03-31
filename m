Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB15034F797
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhCaDnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:43:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhCaDmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:42:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3f8Q9038105;
        Wed, 31 Mar 2021 03:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=ztO9NuDcGbIfIeVAyvt8JiBahWGkgMKLgC08KIhDAXk=;
 b=GnOEHHEg2sXW/vYn+00d9w51axfBEdhNJXiEh7YjDaLHVOBHWDaWN7rnBjZjZ2LvUbjh
 nE96PB7zHrseVC9SG2TKRw+SkdlZwBfVwiQ3DnwL2D9BE0VZMbe6dURnl442xscqvlrb
 jr2oQtB9iUqRdUfUSbMJbNIyxur3f1yu7DANIq7OWdfwocvWLayXw4v5IwCdCHX9hydD
 K4EjuAkRtwuqg9z/MnOFWgm68Wqdm7G04LcTvU+OhwoNe5pvb6Tjon3Dwgs/8q6932Ie
 5dKJ4VQPC+YAdY8qXyg4GRJcYB/BXcBbO4k2KTAZ5ULa3ANgcjye9PSGso6AooOtTFXk gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37mab3gsm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V3eprx182355;
        Wed, 31 Mar 2021 03:42:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3020.oracle.com with ESMTP id 37mac84eag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 03:42:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbmcvzwEXZNZSgE1wifRCdc0d7IRxQ8hsL7knoTsHqOLJIjsXKNMSe5lWBb/9n8AkBXK6JOicwKM4u/VyKWkFnUmrEDaqMKoplLhSsdti0ciYz5RxGB1XakL91qS1fHIAhqrgEcYJOY8DvYN6EkTX00fT56wXJfG3/vHuhFUM2Y3BKyBbCE4HqP8YVUBqJUawpDe6WitdeeRO1k2NW26lZYv2uksGGRvCgDkq8phFJj2FBnZPEKda+l0lDrHKabNtPN5HwTlridgrejve0PZmsx/0vq5nQ5J6g5EyGGjYHPIbMFqTlsdSp7NCniFsMbW0f9Ivo/f631mN94WBTllsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztO9NuDcGbIfIeVAyvt8JiBahWGkgMKLgC08KIhDAXk=;
 b=EU9musQ1mIR+G4kFt5vhE4shG65mi8XBP3cHJRwSI+KcBnw1AWTGttkZNPl9p5w80NFTWVC+WSbpUbtkCgCOn8wBzTDei1KPlx4zHhLARcusuNpAVV+06EjBJtS9JDS8nf/3lMeWcIMOGuRTQ8xTxVvnz7h2IMklF7ALCndhw+AIRH0H0O9aDP+Lo6hqFNYo4MVxbpa+EnnVImRQ61n49KcorAK7KJ+yRFJ6CdkgwlRPdi4gEHn3O1zP3tkMZ3T/F5GW2b+g2jLIEXQ0tWoCSAapspdK/td1MpqRnE6eslHqYj9Apy6ASGjCeiyU5uHKxnVlmjBUqNSs7l66SxyZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztO9NuDcGbIfIeVAyvt8JiBahWGkgMKLgC08KIhDAXk=;
 b=Q3Fk0aKnhgM8uevwT/UoD9TROiJcPdDxPbteCj7+YN+zVt2SjuDGcLNXx7zSKWqVRIz3CDGCdideRt1xRrIgmforONu/mnMrU21xijs3Wra/OngfdJSU7/B4D9MM8/yk9uCAcmnwZaOPelir0wbunmu8zNZpir1TOvAQm9ofdF8=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 03:42:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:42:04 +0000
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
Subject: [PATCH v3 2/8] hugetlb: no need to drop hugetlb_lock to call cma_release
Date:   Tue, 30 Mar 2021 20:41:42 -0700
Message-Id: <20210331034148.112624-3-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0202.namprd04.prod.outlook.com (2603:10b6:104:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 03:42:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4180fee8-e192-4fc2-7967-08d8f3f6f366
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4462D4B013BEECDEF849D327E27C9@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8pSo8W4M376yGgAI5oETEcCDYTZGPcTvZ3J82gA2HAeHyPdGe58KFUEEqa/RroKDrVkv0lXaToVPB7MFEZ3417toyLZXDpVIaCYDuwx+EhMj5g9r7nlbObfNezFlquKJOiiN8+9RoBDvZTlRmKw/XOzToMT23Wv8GqinChlnaFxIVq560AhnMHsIgNhhDbi1GZXTqWvN8IH/ptfcvJ3Wp1TCGk4CclHo358gK/yPyD/wKdIUEwRA08LBodQCxBhfLsDPBZRO0K9FGJQG6dg5xA0eBY09lZreDcU5piicbM3JAjRHVNK8C6VT2meb9hMRJpqxAlc1+zpGdFY+ZArPRLljfnTU2nHsDPZY81nZCwu+WT1XxQ0Z32hivx/6Fic+aK6lmOHuGXA2heSF/7q46BxNqDZwd9IaDvq4/VJLRCt0n0oZ4X2cDT7YmxhnaJ2lL78G7aSLy7gau0LYBPsqP47IyUTUAfScfOBf6oisiqeeja6c0yoVShgVNNWW0aZIObLiNs4XGJ76aPtbP/h4p3Z8Gtrpc/YPTvosj+AEyCqubzt3IbeakZDgrf2RNSQ0YaHEqtmzAev0R3OU2oJNgGPRCvFuGIoi+uztQFiG10i8vK7KY0rYwKOkDERYQHRChz4DF1+TlhRyzkMPpzY1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(86362001)(36756003)(83380400001)(316002)(52116002)(7696005)(66946007)(54906003)(66476007)(66556008)(44832011)(7416002)(4326008)(8676002)(1076003)(8936002)(4744005)(6666004)(956004)(2616005)(16526019)(6486002)(26005)(107886003)(2906002)(5660300002)(478600001)(38100700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uUxfLbKlJjRl4YCsLFvDP5ZG/0PkeYARZ2gLMxORXUTb+YwxBW6SnGeQ5kxX?=
 =?us-ascii?Q?1Sjdzv/q6Ahp18SB5sUwk6C5jFuf93IZG2RsrUIkbRPQv/MQ9Qcepb9fTK39?=
 =?us-ascii?Q?U2uhHHxCe/cYN1bg9jAZibNTA/dhDXn9m+UFNwzj2wUJNG+TC47PwxrE19lw?=
 =?us-ascii?Q?GolD8Gr0EO++YlbOQO9DoY3vqvzWxENuoxH5/kCQz7OUvFRGKxT+8OHZf4Lq?=
 =?us-ascii?Q?zc6Ntv2PXO2hsNW+XzM+Pn5nSd/MDMh1X4/L2qySQb5k7U+EEt0giJeuxDRe?=
 =?us-ascii?Q?IUoxNJ8kij81pqFXdHZKq75deNt9XvmcDiKOGY+BkyGRo6i7oeX7qCDlVbz4?=
 =?us-ascii?Q?Nai6KBUsEkZjavEio88pn0qSrua7FDIfrx1RsXPkflJxdUGm5xqpa34tB9OR?=
 =?us-ascii?Q?TXsBrvNOHFN2thtpCiRSyWrEZnOyGYe3fwqZMJIgxhvOJ1UGE8i5V30/LWGM?=
 =?us-ascii?Q?erF49go07NFRPxOwauYn6VMlRcZ/otwrGsjNETS8853+a/mYp35wAJ/6J6nq?=
 =?us-ascii?Q?nnmcddsCRnrH4zqum7C2puxM9xk60dI/rDfcwZnx4sIOKfiMbgyiD0Qhu/AB?=
 =?us-ascii?Q?Arsi3w3kd8DuqO05LVvEEM116yLxVqTMgMx4G96WSsDeWwM/oDgVRCfX+sEu?=
 =?us-ascii?Q?2PnilC93qHCMDGAHKSENX7iEyucxSmlge8vkLVEzC+wnqbEOzwwSWw9GOuI9?=
 =?us-ascii?Q?NZQrGpiCyIcg5KngkVeEvqwHfjPjfDxILo2fJufvUaKwqaAo9H9zVre4hVBr?=
 =?us-ascii?Q?4VfWoGQota+r9dfyOwrh/gSe5Iz+xQn6JzZ5NqGR4LN0bL6vhsBRaGYXNua+?=
 =?us-ascii?Q?ny1frbYrZoYRJlaLBBrPxpFm2pg8WiYOkMG3RiGBVIvvg8KZm9sUraZHSjll?=
 =?us-ascii?Q?GlNGMMmg3122vq94ELZ+NXmnufKWiSL8QQCSzqdOUXTa6zG01eFvNr2TOluU?=
 =?us-ascii?Q?ZkmYXGfzUteYl5ulF5DZdpYyJVHQfZ7TIg6J1nI2l9CzwD1/Muo7IdsioLO5?=
 =?us-ascii?Q?KPkpSet/AY25LIcKmNZ063HohKDBQ059qJIP2B5oJyPrpd2H+efhyVUDNtim?=
 =?us-ascii?Q?UKBpTogLY6kaH42nMFgaqVTaWXBKUvthEIn7I8+8GW/Yc07Kg6HOZXCr9EKu?=
 =?us-ascii?Q?LurGZRkyJLrnNGPxj5buGBW4sjNOXFZB1A9LnlIfwFoPASEdjX6CpczLGs1W?=
 =?us-ascii?Q?aoMAI+0UaLiQWwdcbZNgLu94rnsTOTPiOhumzLyZ3CQZRGQVqwK7qqt+RNs+?=
 =?us-ascii?Q?91Wsro2S3hDxT+JSr2jI7zTA8MGYuEu7M/emij3cRzwSTAKs+nWsNEfuRvJR?=
 =?us-ascii?Q?gwiM+nShDnGlh3HMgJv3qO+C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4180fee8-e192-4fc2-7967-08d8f3f6f366
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:42:04.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnj9NA6YUqNCIFlOzpPpn6r5UWt9mQbovdquy3Mgl0r4/0S90ft0uFP5Mb1WGep/blnWym05gYT2YTjH9wI5RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
X-Proofpoint-ORIG-GUID: n4CrRllyLjYg16eA8R0Ep51D5dLrEg8J
X-Proofpoint-GUID: n4CrRllyLjYg16eA8R0Ep51D5dLrEg8J
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that cma_release is non-blocking and irq safe, there is no need to
drop hugetlb_lock before calling.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
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

