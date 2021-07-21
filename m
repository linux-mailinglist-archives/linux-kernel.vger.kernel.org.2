Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C145B3D1A29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhGUWZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:25:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29092 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229659AbhGUWZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:25:11 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LMvG6r009329;
        Wed, 21 Jul 2021 23:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=OEk2me/tuxVjQrtAfxnZ0WsH6lXIBG8II8327vcDUO4=;
 b=M2vy+PNbHaVv5gAGiKdJvxi2DUSViuLSFuPyGJ5IBZ4Rnrv7THgRYCt5TBcyQQtA1JTq
 VVCkKxTOs2GxBQ48w09oRLUPaZSq6AV/s5Mfj6lyZ5gqZjb34er1pm7FxcbZE3uVCS9b
 BmNLPn0OblTh8iLZvZnJ9UcN0tKvpW1y5BYIpg3mOiMtPq7eWkRuGcA/i5qsFATWkCW+
 nA5534i6FE46D0V3cyEPodNm60YX6r1t/CHrBD3pOr7yGwbWSWQ6XFM4EqjjhltiWxZE
 BS1gMAqlESv22d2TYdcHNrmRwxr1Rn+lRpU7N1izC6SStSHUrjPSUd4f1a/UKBm9+dPE vQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=OEk2me/tuxVjQrtAfxnZ0WsH6lXIBG8II8327vcDUO4=;
 b=raESjYOrSYg4LPzUZW5yvmrcFBplGnJjPQfFXVIDmKStR/kUc/8Kw/04mnsvdVzzoY2o
 x2t2Zot0IJtukl/YC0p7IuamB2J80pqTcM8jf1uz1yZjhdOf0V9mVIf1PabLXPHwjhc4
 WMnv/smd3iWn3B8R23SWr3wMj7hwSbb0IcRcKmneY7e38XBf8pIEzpWY13Ac4fYsGu7g
 dpa/lnKJIVcyT/BlvgQZIj9PxB2GSb4Ap3YjHAnKtoLN3t3UEv2LbftWylpzICp9dVps
 vOyQirh9QXcQTgOJBBo1zbtbTcIFUsoxsR2onMQm/KSaYhvIB1sRJkTC7pSaM5Ksyd7n ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39xu2fr5wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LN5NPm103248;
        Wed, 21 Jul 2021 23:05:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3030.oracle.com with ESMTP id 39wunmv2ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 23:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKuC3oTfg7rKh08C4YpTt56KrVxjjTuD782qyuIB5JtraFelquSVbnQyJZ7ciwHZ1/kXLbC6VDCyhK/wJDeZ8RRbhIczSciC6D7CLrU5Vc7ap4PFRtcet2rjoE5LSxZgrdXZDnZ0kWMVyoKPkjq8aZ6ax6zOPi2K0HR6zF76DxXD6Y/6GEBeVQ1DwRODC+ReKF97pydoasWCp3Pi8M+b//qunaOmxnvrISeq56RGtEyH1kkhCxozuB6UQNLAtiVBTix2NNqmMHHatpJw1JcUdq938ptsxuO1KCR4BGQpr5rbpO0twUSHdP5VQ5Z5Mg7CkgBt0MktHbSHT2Zn2ZS+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEk2me/tuxVjQrtAfxnZ0WsH6lXIBG8II8327vcDUO4=;
 b=D4YLEjMWGC0ImEe2edvt6OTxh38R0evk2mYeIfS7hGhquTIJ0woKegu/0CYudc3ITrydnE6TvClLJXBuCORcuR8VmEpJV//wWg5NLBu3+sr6MIFXnpKhSeriZ+kkjUoRXtfRHG1cwQiAfvQmhby6mjn6WQuUR2+YD146tpZPzkpgFLY9h2x/C/DFQE8VnBUj88IunFodHFrNnK+/W049mJHNWBPoO8FFPLa3JDYnGVFubCDOJ9qUw1YkEZVSFjxbo89S58PBZzSyOVBWVJ8kpU38Ih9p1jTGZscZCFaBmQMIhn0XnxD04e+sn0b/3KbgV6UhJeq5mGsOzAxiKC5z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEk2me/tuxVjQrtAfxnZ0WsH6lXIBG8II8327vcDUO4=;
 b=J6YmGsb42KjluhfbKFXwqXrEeHpJPLMPdVT3orsOqCZfDy02UGB1YesP1/sNXfcihNAtqnWVT2J6NqjgPBJ827UEVOSPGlrjhQxgiUNjUGZZ35EW4hVmwNa4e7yoVVBaMcmKcudx8oq+Eod2XktA6aKwxSIIipQ0TUtTaQlfvGI=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 23:05:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 23:05:21 +0000
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
Subject: [PATCH 0/8] hugetlb: add demote/split page functionality
Date:   Wed, 21 Jul 2021 16:05:03 -0700
Message-Id: <20210721230511.201823-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:301:4a::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR1201CA0021.namprd12.prod.outlook.com (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 23:05:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fed741b9-e4b4-4933-cbdf-08d94c9c0387
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3735658F9FD1F97D46EE15C0E2E39@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83HbP2V28dAkV2966gAxCW+gJbkcJb1CqbS2z0ZC4kRRtlacSzjjQgdfZ2Piao82Xj9KvGoXTJWE7xBRLvY3P5j+4UfdeE4fXzfekFhDyXuTKNUZWUS31IKX5dDb2I6I9eM4j/t1Yupw9+9GHjukva4swPu6tqshy50RzmwkWra5fTv5QQFgzMF3WmcI5yRdDicETRZ1oVfQ54tEhC+CGxkus739mghKIYiLGd4lftB0XzHP01C1AftC1tI4e8crt8Ds/ngYPSnu7yW9pQ4repAlTEmGO04vwcvx2qWeDmTc1Y/CieVSfDtxen+b1jHeBqX4Gpxbj04BfbNgN1WCzuIm0OAUuXPY66/4I/IWBcmHjJc95n3aTPvkfVZB8IowKJ3WS1Um/4bJVlWHWpuYGKOiP2CUMBcG5cwRdqDNxb89PBtdDGVFaQsJMmwU6935ZILXR2QKaaNsV4twvap7uwUDUJHTpALQTtVGCO8muWw9hlZw1fugW9L98u0cFGd4fRCgEGduAHQinFvpRhoTCylV/JMaIISIDm7UykAhO/FnvqpfBP+Zb5Cuel6EdQ5BJkj/+GSq3bL3vYWnxJEz5/mlWG54e766b2bVzM2VJ3W2/ymPyBuMmhEz4XYW9cXkCFPWcTTsu5dqmR336pirxgHU/wY7GND3T61rmJyUBjQutqmYOl8QWKYfUPA0cNC2WSUHECWoAlLBhJeUq445DoRNfOzFD7ACpCBH6G/haVswU6yGcloWPtZ9MG2E5/k2irYFBIOn60WTn08RpbMYyB9b4DyTf3noPuqL3sPBpmWw/lKKuJPdQPWn5pnTlrOnbUyiS5+aQE2EmS9VxQ6l0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(186003)(66556008)(478600001)(52116002)(86362001)(2616005)(107886003)(8936002)(5660300002)(1076003)(4326008)(6486002)(2906002)(66946007)(66476007)(956004)(6666004)(26005)(316002)(38350700002)(38100700002)(7416002)(36756003)(83380400001)(7696005)(54906003)(966005)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLUKqWfinaiUoUeI1S8HhCYsR//cCG/EK8Jw0ry+++m3utYIMb1ZAeOYd9+k?=
 =?us-ascii?Q?FipDg8BGP73LX9RBhats6J1kluVJ92OG+HQShTclyWEdeUr6/2gcTvbEtOmO?=
 =?us-ascii?Q?WOJhqJHldrw7r8IUouI8fwCF+Af22B1uU9F4OPEV7H9zfJIEK7Sgnkx68Qnc?=
 =?us-ascii?Q?QIVEYCBmQUd57zQ/GOG+74CRo+RSOZQDdhc/TsRL7OesWJ3C/skpUsr5wCwp?=
 =?us-ascii?Q?Nz9YMavl2dLjXAqwZ5+gRk0KJK2VwQnDJBLgcuoMFM1WVUx2MWwqRdpZsWMY?=
 =?us-ascii?Q?HwMIeuSzeWex2M5lAeenkY7+BHhMD1r0XRSkoNi6+h8dX9oLl7JLab1roJ8k?=
 =?us-ascii?Q?rE4+FRF9UOA3T+BBwMWfSDEx+Tl8LkoRvUZiIo5y+n2GiwOPQKROW4zOVk9E?=
 =?us-ascii?Q?l+v5pgSMU4l5ikxght7fo3nEhaiRUTRkhLJKyzsVjx+oDYTzr6SY/JLS/Gm0?=
 =?us-ascii?Q?lor1osWC2Ye8F01YLRL5X750t77qmPzNh1vBx87eFxhWAu2pusB+Zdk7FnSE?=
 =?us-ascii?Q?w2V6RdrPsNJ5oZmMPNJKjQ7VeuJV8WrvsgDvZZjUMQey96eYK0qapJ9jew5d?=
 =?us-ascii?Q?0rG8DdNbSaSN3tfyMgQDRvHkrLw/MeRkYtDhjJUQ7Mv10tCsVhi43gvlLIIm?=
 =?us-ascii?Q?yTSu0hdKms3v40a5Tkph71wMcsfOq5uPPYn7vbT6+fkUMKo4eQvu1zClpcMr?=
 =?us-ascii?Q?+Uta7mrO7xDL600oj2qOXt3WNnZvxA2wpFXkG3imVS1VkkC2KQq5fSyNnVSQ?=
 =?us-ascii?Q?LjnsXEh4xYAq+zrWcKgx4ZNGW0fbSwRbIa7MM1R2YdZWUrJkKTcqT0AvAILW?=
 =?us-ascii?Q?nOszO9+qWE97PIgRVN7ffb+DJb+nsigFOxpEf6cSlbj/takWHsDfl81wTd2z?=
 =?us-ascii?Q?p0OyCOMrf8csJszuArub3hLT389gSHv66cSTAHHc67TZbxWu5a9rjfoGaCY/?=
 =?us-ascii?Q?mqcgxYlUR1dOn9EDZeudROSHjvh87CUuz6IjyV1fWKLxeu6gcYlqIPko7cYi?=
 =?us-ascii?Q?1n2wZ87KgCOrpWvrkAiaB6GdtZyih5UCYxB1eDKSThp3s18/Wk9uk/GfXKZ7?=
 =?us-ascii?Q?edaWpMsYqlus+4SllIcFbVQXf9QGuneSbuzYeyfZ9j37JjgHeFNi0EVmebSs?=
 =?us-ascii?Q?L/Pz/QDaWItddy1CF1XeYDa0V/lC202pihRHPiEHNMo7LbHfbKExnUrjidUZ?=
 =?us-ascii?Q?Ni8OjiYNRr0KZX+hdJkrxdCjHFCA6wLrbhC8nvsPxyLWxh4VibThp6dBUMa6?=
 =?us-ascii?Q?NIpM57u6RxSmQBQp6022gOV2Cg1RSFuc9RaGzQLfF23J+HCMKEhi9JW1SiYg?=
 =?us-ascii?Q?Q2LztU9Z2pghamKHeNIPwOWO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed741b9-e4b4-4933-cbdf-08d94c9c0387
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 23:05:20.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4irN4HvLW6I9VCLGZTQqqjN9FDsbnOz9hD5p+y5fCSxn+KbG3Ymno1OsFqSQ+lr1VL69uTcypmoGMFb0ab7oNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210138
X-Proofpoint-ORIG-GUID: XZG7f0dbjawrbugYreERjOQ-NsaMNVbR
X-Proofpoint-GUID: XZG7f0dbjawrbugYreERjOQ-NsaMNVbR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The concurrent use of multiple hugetlb page sizes on a single system
is becoming more common.  One of the reasons is better TLB support for
gigantic page sizes on x86 hardware.  In addition, hugetlb pages are
being used to back VMs in hosting environments.

When using hugetlb pages to back VMs in such environments, it is
sometimes desirable to preallocate hugetlb pools.  This avoids the delay
and uncertainty of allocating hugetlb pages at VM startup.  In addition,
preallocating huge pages minimizes the issue of memory fragmentation that
increases the longer the system is up and running.

In such environments, a combination of larger and smaller hugetlb pages
are preallocated in anticipation of backing VMs of various sizes.  Over
time, the preallocated pool of smaller hugetlb pages may become
depleted while larger hugetlb pages still remain.  In such situations,
it may be desirable to convert larger hugetlb pages to smaller hugetlb
pages.

Converting larger to smaller hugetlb pages can be accomplished today by
first freeing the larger page to the buddy allocator and then allocating
the smaller pages.  However, there are two issues with this approach:
1) This process can take quite some time, especially if allocation of
   the smaller pages is not immediate and requires migration/compaction.
2) There is no guarantee that the total size of smaller pages allocated
   will match the size of the larger page which was freed.  This is
   because the area freed by the larger page could quickly be
   fragmented.

To address these issues, introduce the concept of hugetlb page demotion.
Demotion provides a means of 'in place' splitting a hugetlb page to
pages of a smaller size.  For example, on x86 one 1G page can be
demoted to 512 2M pages.  Page demotion is controlled via sysfs files.
- demote_size   Read only target page size for demotion
- demote        Writable number of hugetlb pages to be demoted

Only hugetlb pages which are free at the time of the request can be demoted.
Demotion does not add to the complexity surplus pages.  Demotion also honors
reserved huge pages.  Therefore, when a value is written to the sysfs demote
file, that value is only the maximum number of pages which will be demoted.
It is possible fewer will actually be demoted.

If demote_size is PAGESIZE, demote will simply free pages to the buddy
allocator.

Real world use cases
--------------------
There are groups today using hugetlb pages to back VMs on x86.  Their
use case is as described above.  They have experienced the issues with
performance and not necessarily getting the excepted number smaller huge
pages after free/allocate cycle.

Note to reviewers
-----------------
Patches 1-5 provide the basic demote functionality.  They are built on
	next-20210721.
Patch 3 deals with this issue of speculative page references as
	discussed in [1] and [2].  It builds on the ideas used in
	patches currently in mmotm.  There have been few comments on
	those patches in mmotm, so I do not feel the approach has been
	well vetted.
Patches 6-8 are an optimization to deal with vmemmap optimized pages.
	This was discussed in the RFC.  IMO, the code may not be worth
	the benefit.  They could be dropped with no loss of
	functionality.  In addition, Muchun has recently sent patches to
	further optimize hugetlb vmemmap reduction by only requiring one
	vmemmap page per huge page [3].  These patches do not take Muchun's
	new patches into account.

RFC -> v1
- Provides basic support for vmemmap optimized pages
- Takes speculative page references into account
- Updated Documentation file
- Added optimizations for vmemmap optimized pages

[1] https://lore.kernel.org/linux-mm/CAG48ez23q0Jy9cuVnwAe7t_fdhMk2S7N5Hdi-GLcCeq5bsfLxw@mail.gmail.com/
[2] https://lore.kernel.org/linux-mm/20210710002441.167759-1-mike.kravetz@oracle.com/
[3] https://lore.kernel.org/linux-mm/20210714091800.42645-1-songmuchun@bytedance.com/

Mike Kravetz (8):
  hugetlb: add demote hugetlb page sysfs interfaces
  hugetlb: add HPageCma flag and code to free non-gigantic pages in CMA
  hugetlb: add demote bool to gigantic page routines
  hugetlb: add hugetlb demote page support
  hugetlb: document the demote sysfs interfaces
  hugetlb: vmemmap optimizations when demoting hugetlb pages
  hugetlb: prepare destroy and prep routines for vmemmap optimized pages
  hugetlb: Optimized demote vmemmap optimizatized pages

 Documentation/admin-guide/mm/hugetlbpage.rst |  29 +-
 include/linux/hugetlb.h                      |   8 +
 include/linux/mm.h                           |   4 +
 mm/hugetlb.c                                 | 328 +++++++++++++++++--
 mm/hugetlb_vmemmap.c                         |  72 +++-
 mm/hugetlb_vmemmap.h                         |  16 +
 mm/sparse-vmemmap.c                          | 123 ++++++-
 7 files changed, 538 insertions(+), 42 deletions(-)

-- 
2.31.1

