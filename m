Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1671323662
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 05:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhBXEJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 23:09:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50146 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhBXEHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 23:07:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O44pKt028303;
        Wed, 24 Feb 2021 04:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=jMq/Dh2MOzbOWzs60nE1Yf9+H4kunBzFkbI57kbN5vM=;
 b=eRc/IzvTblRcI+lgWja2GtKTL8K9NX23CUKgngO9pT/CwJzRHBBJsOsnt2DfxQuf2xxD
 f20uWkXv0rUFbzS86CeGJIJE45rNXNUbo3Uf235jiZPyAPlOA4A2d6OTAN8JDWfIV8rE
 1AaEc9tkKW1+0pk/sbfl0MXJaUu2KTwsO1v6okMYPZHVwD5+n352tp8fzL0/goDMj0at
 BaQqDZV3QuiooaMmChPmTIXY4m3WjJcoYoaGruafMuG/jPxswIDfvIFZy16pRN0Yncs/
 53lhlY6ZzEUgr4nqZ3rs//rIwNVOastRX3M2b90CvxVk743rixEEyPvgNuQlw5VfAt3T Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36ttcm9hph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 04:04:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O40UEb112601;
        Wed, 24 Feb 2021 04:04:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by aserp3030.oracle.com with ESMTP id 36v9m5ebvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 04:04:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I74WKCqXJr5Zpuw/P8ScbPSAAMIqF/uqo81TcsmbnpTPfFPzMf9KHmmiwVe3159x16JC03lV+pCfdLERv9kSLLx8HTFY3dsXr2ZoXNiG5avjiFrukfmdB2qQH6qJZJEt6FPARsTU6rmxps34nOewjXA1qo2fWCKesfi+tx8bM7EAwKme1hWFPtLoM9jTIlxKcYb37Ppqn0w7RVJisOB5bWG/uzvhEECELgXiTfqXfDreJ4zEkUxKR2DM6eRMe0f4NgPwE5tFJFPmfdQjSjrnrRn83NsmKkOOwsIeXrbAo8AvUffjf2H82ZiGs/nqrFwwsln59fQRm6mb8v1f+Ezv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMq/Dh2MOzbOWzs60nE1Yf9+H4kunBzFkbI57kbN5vM=;
 b=mByKGDwChIVXZNWtgs6m94X0jufKrK1IHrt2XCxKZd0uGNRsXdRW7BxYzlz2iOhNlJ1sGq4EBKZIzJLkpfX7KcBo6jOQhIp9QsJJPUaGib0lgizIclK//qJ6QwSVZzAvadMnn9WnOW/JURYoCGFwDu5zvC/frZLSVHRNjFKE/arbBv9jCIxCsw8XaiNW1g/MNHvjPOpjlA+5ccAC2y/3kTA00azj7QHVICxalGLYvp2+lGpqI6wQsaiK4/Pk6lqeTiyPVx8S1yTgQohQEBODMabQKTIJawxJS34nvMH21EzwgOn5bdvZKI9gVMYEeT0LAnrwO7PG4vwU+cv2d97V9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMq/Dh2MOzbOWzs60nE1Yf9+H4kunBzFkbI57kbN5vM=;
 b=WZT9BmU2gPXpO0V5Mc+YE+N1cqYA283x5XF+P7EAS6LGY6aunek9wZi4zl4C+mazwNb/U/LooMRpPKdJrXDESJLCHs8x92nxrFz5foQO2FibdvEd1uknlKbIwmIZEsfdmtnKQD6nMbeol5T7Immlr7hM3cIMCTAGT1sF/bM5fwI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3493.namprd10.prod.outlook.com (2603:10b6:a03:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 04:04:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%5]) with mapi id 15.20.3868.032; Wed, 24 Feb 2021
 04:04:49 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlb: document the new location of page subpool pointer
Date:   Tue, 23 Feb 2021 20:04:39 -0800
Message-Id: <20210224040439.351882-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223180820.ee39f1544f2630d0eecf3a57@linux-foundation.org>
References: <20210223180820.ee39f1544f2630d0eecf3a57@linux-foundation.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:102:2::42) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO2PR05CA0074.namprd05.prod.outlook.com (2603:10b6:102:2::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Wed, 24 Feb 2021 04:04:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85dd3989-4316-464a-43f2-08d8d879541f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB34931618AF3D0149E7227F82E29F9@BYAPR10MB3493.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6ovDLQdF1gK3rhjfSAk5XlyM+HqpG5u1fLn1Rr80XD+K0dzSykygGC0tQK5C4OwBPc3cTWlbq4dQuGku/H2ORtu7SeMvla/zeALQ319LZH4PIKqRUhQfEf6N7OcAJDCkUN0mHvyaiahFQNUZSepRaEbdo7LKMbuQW52ESKBvQe511DT5nMCBOxSItcrpoDskdEpOZomUdpZ+bqsFpNJ43Enf/Nenvm7g8Jcoi/r0rkrUSX1a6WZZ87/gxl20q0UzA3FL8v0C+ifaFfx/QzU/AIXe6DNkwEY4ev/yhsecPUisuODqsFRE9xp0N+SR0YBkr3JVGDX/V9nSCw/8EMqF1tlf6PbB+78nwXsb8jkckt7zoALuoVuq62ChhermcNTh85bUEouDNPWBQm7k+s1dWX8/m+VSVV2BaQrmjF/9lFPwl72cEIllwypY0Ye9ZrjoO5tTlQWxpG9FjLS+K73wq/FOGPTTnQFtMqFflkFqrfDP3tnE9yFKUWODvf85NZAqZ6QFx1togR5mtrFAhKuQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(396003)(39860400002)(66946007)(6486002)(6666004)(7696005)(66476007)(2906002)(86362001)(16526019)(4326008)(52116002)(66556008)(44832011)(36756003)(316002)(54906003)(956004)(478600001)(83380400001)(5660300002)(1076003)(4744005)(8676002)(26005)(2616005)(8936002)(107886003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?A9RlcjHOj17XIA5+DpWQ/W8DxbJ38ap3WsdtjyHbVU1TEoQLJYaqJu7Cr4rF?=
 =?us-ascii?Q?4ni0R0SM0e9Rtdqz6bzuKAqB2gW4BjA5u02Jfk7H4jAiR2cky4qbLx+ejk1A?=
 =?us-ascii?Q?4qx99LodnJP527yiY/p69Bade2AHwyi6h7moOIb9c5GQ+JamFy5tKn1MLzg3?=
 =?us-ascii?Q?3VUEUzuTTkUjErvJr2uU+i9STUB+/FzRUbirRPM++HrsvdDmgY49cJELkcxX?=
 =?us-ascii?Q?Nen0ij74PUfCF+3bel1Uzf+Q6PUrtUc+8hK2hoIGgBzoJgYNPiwUchLE32WB?=
 =?us-ascii?Q?2O2bSZMz/5kZ2y7h7a6nZDyuCLrONbGb/HtBnvHnqrt2zkd/BZ6KuURZk5Cl?=
 =?us-ascii?Q?XVqO3cCnqDDPUU7ITLLgwRxrU//NwFcQ/l9FOcgOx3X2MlUKvyeUrRqnKIvs?=
 =?us-ascii?Q?R706gm4DVgkMYwLfI+M5tbA68q4ke5FJM8yQS0znfNxAn92m0xykbK1Ye+sL?=
 =?us-ascii?Q?sAUUp40+ZYJ5/vKUNQf6J28wQX6fHyztKXZtrOiOuoxeFBuW5AEWVsr7L964?=
 =?us-ascii?Q?YYQjCjeGheXrJgA67BeLgpQ6nZt4B/pMn/8j8yJ09JzQNtrNRpx0IJQNpzhy?=
 =?us-ascii?Q?IGy3ez/c1pqr1VHIMGKhc4+dfah7B7HPb+HkeNjA4eJrZl4FFpCmKpGOi9z8?=
 =?us-ascii?Q?Hx+jc2mwgR4Nv0vch1SJ9ph5iJPZZWzJjsuDMjtbRmS0w3WBAkeZ2Q/75Vbz?=
 =?us-ascii?Q?QmPNDH51RUCBS63whQTQkiRfMigSz4JRnqaPXQQCnpLOTGaNDrmO6Q8yiLPI?=
 =?us-ascii?Q?2kL0tGmKEVVBzgmMVbnGMW9TbEuN9GOsLOmGg3bfGfkT1e+QsaHSrJ4Jg7sA?=
 =?us-ascii?Q?+ilO0/8JmTXuO65KFDgBf834Z0Lzjyu1NClEwhOrdWOGDKkwwR/fWO2r2B54?=
 =?us-ascii?Q?rNcvRyAA4c79J/w2yUP/p9GwHuuqZ8mQeeb2h/vFY5ztTJgr72UCQFb5F2S/?=
 =?us-ascii?Q?ErHDy66URMU6z9XrNCVTNarKZp4HGw4Cd+7RBs5YLFrUoesoUgd+LL9LCC9e?=
 =?us-ascii?Q?porsnjTPSa87/3ysdP1C+iMjeup1cGkHva4A6ndMtGH+fLdZHb4zxLU9cbph?=
 =?us-ascii?Q?LB0hWqXyQ2VxrTo9gH3DZRLv/B33WYdSgLGXxw7AG18xKAAMLOpR3slw3v24?=
 =?us-ascii?Q?2ulwOsYLWkikdWzKm9nQI/dWiii6yB0Ds/vdeNqEQMeCG8JhFWYXIsJcpUAf?=
 =?us-ascii?Q?do3Sc0iueSIKAbdw0FOOmk2HM5ZehsdAM6Cunun14kmsFGGMrHRjgJZ+7n1c?=
 =?us-ascii?Q?BGnrklmAoOZFsSKj7h9/Cc2zPL8ve8xpyoJywrgF+6t4Qmf68dN+b9FVKQmr?=
 =?us-ascii?Q?NxQHZiKgwYV1UHR7axcNgdIR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dd3989-4316-464a-43f2-08d8d879541f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 04:04:48.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slPDAGAwtZVk5J19DOpXw02hGBkf5msop08zB7rMiuYRP/AMJkXWB/3bB15fMtcy6rYg31sKNN5PmpqVn8GaTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3493
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240029
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand comments, no functional change.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cccd1aab69dd..c0467a7a1fe0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -476,6 +476,9 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * huegtlb page specific state flags.  These flags are located in page.private
  * of the hugetlb head page.  Functions created via the below macros should be
  * used to manipulate these flags.
+ * Note: The hugetlb page subpool pointer previously located at page.private
+ * was moved to page[1].private to make room for flags in the head page.  See
+ * hugetlb_page_subpool().
  *
  * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
  *	allocation time.  Cleared when page is fully instantiated.  Free
-- 
2.29.2

