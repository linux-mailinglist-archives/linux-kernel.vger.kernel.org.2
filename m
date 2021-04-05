Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE1F354910
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhDEXCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:02:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44118 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhDEXCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:02:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MxsqS005021;
        Mon, 5 Apr 2021 23:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=ztO9NuDcGbIfIeVAyvt8JiBahWGkgMKLgC08KIhDAXk=;
 b=JqWF5zvhYEjSd9Hmm+kNRCZK3ZiZFGsptHVY1VCkX7XBtVcfvnwO+iRCbGz4sab94nhe
 olrhLDZq521FNHzokDsj74Io6yiRlbHqTaT7UnehzaLRov2+jbc+8Cp4sECPMO89ajUR
 UFubPMQGWv50YWlGkwId+0tWMtJvZ3amQjEQBKB56YBmxr0GrqGQC7BkkbhI1e8Xo0q6
 xLEngBmO4b3gnKlDsqjqLZR3cdRpAA7HKHgjNIOreXQ2FQfBTukg0kbDZ7w0sOOab9o8
 ZAMisL/E5kzkCWOeDP2BxZto2kfwBCgcJVqPEIxcyYyLjJfEzEf25ddvVOymDP/m6mav eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37q3f2bkn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135MsxPn038332;
        Mon, 5 Apr 2021 23:01:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 37q2ptgmh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 23:01:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqIP3AleReQgNvq/miwPwTnGjlb3lPZakP9dT5v2UF1i3rIsIJnjb6fkzic0Og9fx/RA4G2of6Ur3zrDcP49sYR434E2d3LDyqTtH+r+SKKdBqO2LGHfEDjI7p9m9aluZBLADSuNl699gQCOvfHHcKCccBUo0IjIg30XUxooGl6XKrRESYVx2kJV8OEcjPGOFMLEIjVzR3D1ZoSUBbMRMtpDfaei6H5qqOPuS5k/r8zssJRJG16ju1avf3Kum9I/TIuy58dKkj7s78c4svSg7EMd852HwFAp8tHKJqJVa/TyWDmej0FODbSKjoD4OVILVJhuUv3phg/GFkpKqOlc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztO9NuDcGbIfIeVAyvt8JiBahWGkgMKLgC08KIhDAXk=;
 b=Yb8V5/y6fMoaFj1H7qiaJnSAjXKUvhYd8e6SNidWgQqIyCGyc1SdtABat+ZNH/rHFJ52X99KBjm/xX+BaqoQ5X/Nw6YHggIbgoBqZ/MrUXBYD3nS1OdXnPPzi5lzXSwjNXPg8Qn8TO5+y92/5pOikOKpF0ritTCJ9N9QLGSk/LjKEYen0RqeUn/i/VToNnRQ7lVouHC+vuBn9Nxvc7rdIw8ElzEUBuu/9luqisYwZB/qv3uMOEDK5861q274gQzmwazoe8eSaF83fjgfj+Wbj8gaELHPuV9B0o4JDthQ4NBKrpzWb9q58U7c3cTAmHWNBLO8ZuopSFMTqawJ48a8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztO9NuDcGbIfIeVAyvt8JiBahWGkgMKLgC08KIhDAXk=;
 b=kC9MuvLkmzZvqxLEoLsheWD0ooEUP5zNgMBXoffpIFzRtm9UzB3/cqjgQuw67hR4CwGJAXMt9LnheQsqnjmpQSuFRYE5XN8h2HriqZ383dWKYhHx4wdoKw75FRWVhEMTDnZToBImJIEi7gc6X+o1jhoSBLQxwGoiJvbpKTbbAh4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5424.namprd10.prod.outlook.com (2603:10b6:a03:3bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 23:01:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:01:25 +0000
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
Subject: [PATCH v4 2/8] hugetlb: no need to drop hugetlb_lock to call cma_release
Date:   Mon,  5 Apr 2021 16:00:37 -0700
Message-Id: <20210405230043.182734-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210405230043.182734-1-mike.kravetz@oracle.com>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:320:31::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:01:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5c31151-acfe-4462-5a5f-08d8f886bbe0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5424:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54249DE5C49A7CA7ADE7D1ACE2779@SJ0PR10MB5424.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TJaV6WiTW0VN/4iUrdN0y/zOjd1tMfF99gTxgtucwEePEOqEJg73uXV6U6SmUHqCod/mnVeH6ofBBS7BD2DPL4AQbKD4noSPRGH4JZaDt1thxOJE6mArtF6Oq/HRD/Zm/iD+M0rNH68ZvgWi6lcBi6Klr2Pb+5nfH+Pe49d7xNpVeXZsny2uy+js5EENdsu/zk4jRn8c5mA9gwzZhULjswRBAc19EmdiGIq2rNk625gVl1qP8zUl61LX5/+/vZ/jDSAuNkNmYNdd02F9glDEzgSVPms+VVP4QboENNqxf9WeZS3QwWNo2T0B1uIMzTqftJlsdG5T7mG7tXnPDo3ZSOocxAYkqJeFOOHwyrprLLqm2zH2lg6Kz9RL/NcMsF3XVJ7B8PWev82ds74QiBDEGPzVe3pO5zjrCh/NHJCnw1lxtPIe6vL48w9DfT+iiTBJp1oR9zyocOQJIiNFwCX3vxCoLJ+ziQMmg33TfnpOAX60P16/ZWiesEZNKT1mJaOh1jAP15u/FZYEvPHdEcsqIG35IvtPn2Ya+Cbktp0bSPIhGZcFz11i08LfO5JGoLjd6SbapgmA5YuIdkL9fCKU0NvKLyp9LK7sQICw91hZukU6MFRoMKTt6LkrfTV7nT9PDhbNadNGi2l3LSLGe//sZsHQ3lMOTiH/eQmGnB5RJBIEn21r/iA1lpmovIyoIL8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(39860400002)(396003)(66556008)(478600001)(66476007)(6486002)(66946007)(8936002)(52116002)(316002)(54906003)(4744005)(7416002)(38350700001)(83380400001)(7696005)(8676002)(1076003)(107886003)(956004)(186003)(2906002)(26005)(86362001)(6666004)(38100700001)(5660300002)(44832011)(16526019)(4326008)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z4be6VyDXc0Er3fTN6P39+6T3LC+CO9r+hitB9Jo2bWZxPfk164GAW27nXJ2?=
 =?us-ascii?Q?ycOZ4eJSD1GHyREcYQwEhopYgg+7+qe2sX79tOlW4qpo7HOmwYXuMzrXplDr?=
 =?us-ascii?Q?hF6AZ0//MQNMHwQ3kWm2/43bgxYUcp1gnSVFTAGdF9i0fBPJwwQs4ioZXIZH?=
 =?us-ascii?Q?Rjy5bffk7yi8Wc90psPUANCaOXFTg7bpqCCZerCSxMGFVXHUvP0LWKZ/SB26?=
 =?us-ascii?Q?kb2hAFsJV+7wQNv76ZIHE0XY130fWf3EgAOAMzb/GEMUFsh4rEPEgifFc011?=
 =?us-ascii?Q?0z0xU+gh4Z3gFsP3+DBxRTS5yF2I2xs9g7QRHoccuGmb+KdRKZiiol0dz2KF?=
 =?us-ascii?Q?/KL4cRjUYIdb0CPJJqWsFAWYlFkh/yfJtHjL5L9TrljUlPgFrTJ3XAF4k1/O?=
 =?us-ascii?Q?2CZZao5dvf4waW5A49OKLj1FuoaDjLmjUfpTw9jvERM1Arw28MQBMlOcPHvs?=
 =?us-ascii?Q?nyV5buvDEnsDv8gj7eiEjb84/D20ItScSqAPD2iVgCJsaFFSuOWn17Kui/mP?=
 =?us-ascii?Q?u/3+Pq0sc75kZpmW2eiBOAHKaZLwu+V+Y5XY6vyM1KDpgOik4TFEr1NGzRkU?=
 =?us-ascii?Q?OpSYeDYR5ZTludI2KavtHByNCY+XydnmeteSUuFGZTfUa7Lrp4WgemW4MDtD?=
 =?us-ascii?Q?0emwP5kYYRU3QQtVwh16CwZJpwBDXG/Zbsnc01NHpCoSMoOsr7Rx2tqr8h2q?=
 =?us-ascii?Q?bwy12VeQIBMPr4dvgaLDePyE1T5EN+e8vEliwp90tIAyyPfcF2cZ7Me1QMzt?=
 =?us-ascii?Q?rPZGSeSKu9ludo0W9C05cDdMDlicJ7s8aHHo46bZc7zaq/Gmaw66nFDKpz/g?=
 =?us-ascii?Q?76z1NZX8+Qc46f+KQQhuZzwyOF66kmuB5c1ZCMpdy1HhVi1BrNhI3vMwwQQc?=
 =?us-ascii?Q?EVcEy4hZm8R2VO8pzGYCqldzbMdTF3M4FHvJSpJIGHrLHNBDHkuDcmk+rhsO?=
 =?us-ascii?Q?I8eA2DYIh9ExLj/CMpWtTqwhKZVTy2VmvFdgCPgnJlJVqC8GON8SX4EkHNTi?=
 =?us-ascii?Q?KlwSTcW9S0UO7BCYMtJymdf1lBQKfK8DyGZkaRTvmMy1VneYuS+uoTHSt050?=
 =?us-ascii?Q?B9BTNulejS5Q3EpVvsfBZr3t+Hg3exxsGTsDDJ7y/sBE1CiYDLIOjBEYJlUK?=
 =?us-ascii?Q?PIQvzv72GKsxY9c1SBMOh02LdwEbO1jr+Jvafiu1kTsK2sZH5ryth7mAKXgf?=
 =?us-ascii?Q?TNWjZNS+tvPOiCy09uOZOljAOe8N2XxyOs/zXRFOMmhEaVYbUCgQ/CTK9R14?=
 =?us-ascii?Q?4Q/X9accr+zJDOHLJBi/tXYv99TXg65UMh2H4G3xG79hgoMbffwMp1dKjos+?=
 =?us-ascii?Q?MStTgSsuV00qXu3apCflBc1g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c31151-acfe-4462-5a5f-08d8f886bbe0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:01:25.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRJ0DA6pdq8ynLklDDKubBAgYyVv2ipDdWhxGisNbI2zVEKZtcDLTAlbhSOwgIqodnczcLDlwYP964/lsvt72Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5424
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050152
X-Proofpoint-GUID: N-4FeMF-y2OmR0sLQ0ti77JjdjJ3hZ0b
X-Proofpoint-ORIG-GUID: N-4FeMF-y2OmR0sLQ0ti77JjdjJ3hZ0b
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050152
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

