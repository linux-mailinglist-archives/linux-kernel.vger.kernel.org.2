Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796A7437CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhJVTB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 15:01:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50938 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232747AbhJVTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:01:25 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MI2mj1029481;
        Fri, 22 Oct 2021 18:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BnkY2v0gkJxVzSk9bN/yZTL0m3+zEfzi13qlYV7WM8Q=;
 b=dmDhoqlL7UZhbCaLHdOvi9TkX59/oedSmaGGinr71kuEMDXziy4ecg5GTQjVOmO5YVvL
 byB7T9KtT3vkr2kgSxHrc4JWYL9ZjyTyVVjkEXOv0YmR4oYmK8uBVmvCfsPfKcckalZt
 SfarbqsN1IxjWUPt4Plb324UiU2lmvC+Rfv3B1TLbXxFTS6YsqiEFQrd/suKAC9epykA
 nfAn4Kq4Y2oKnvqMYFGVs0DKhZ03Gosjjctfr9WCuXxUbt/Su544J6Lw1U4d71+wBaHf
 Y8IOCk9E8J9umPQ6nh91dF5vCeMgr8yzSdA8Bw9Lx8YUC+sWk5zYufkNypdv174cb3+v bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bunvd3qrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 18:58:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19MIplaD141403;
        Fri, 22 Oct 2021 18:58:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by userp3030.oracle.com with ESMTP id 3bqkv47e8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 18:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqM1OuZ0fIKFq1cm0LHkWJj+lo5zz0UhBfB6iUvQfl0gZh7PougmksanzQVu2FILrKxptLtDGiCEs2PplxUYcdANkBFw5HIoAmJyTelLn1IjVfmcNZvpYwjyj+qcpG2hajKWHnH40h95l5jd6aiiWGYFzKYrHho83bzKvYqYch21v7+vV1TXue0160lOajYx2SfbbLq3TSrzOVQWecrBwwqkAyMentxi7HIx5Ayjh5zv8s9ThEplmosMowL+yWLAYXcZ6GugMEWmGkLUxCHz2DnPu5me3mEmCNAuf5XcMRsmB33dVlOVImp18+kp1bl0GSvVU1r7Kfg/iEkw8fxoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnkY2v0gkJxVzSk9bN/yZTL0m3+zEfzi13qlYV7WM8Q=;
 b=ScH579XGLbHTuISkkujjfc6FiaPXktFhVnJzgQFOzzFCTzykpIcuyxd/U+7SIE47Vc73L0Q+sXTyOtwLkbq9qb7qcsXC7jQDM2Z3fVq8zDAOv2dTrRVgf14VA3yklyyBqfZbpy62GdTcNzRI0DybbSbdW5FMrfOZS+dDB0tMcXZvfA6t50Db8bBAf6eicE6DBVIJtyDNYpzYFT6TWVf+UdpvHHUqq+Y9rKu/25MYhobSGfBMKwN3g4Y7trG/1WrlQEddaQot4FPg71yerE2cVqBmLUrQvjf9GYVVipYwslCcCaAujsWccuCjtwu/fAG23rV4CQ48MgTNP42v4ThshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnkY2v0gkJxVzSk9bN/yZTL0m3+zEfzi13qlYV7WM8Q=;
 b=MQ7op5DztwICQznOuNFX3nG/1Xit6byjzwf0LDbsJBsZUxpy6MB6enUveDCV4i1wvvSfema6r3xA0Wv9CRP7i9CwC5s01PIKQOnmmpbFboyJKqLLGgHJUiurNgJBQLwC05V3YLsnBRC5e10Uxetu+Lxy4XfbRd13oXx/1l7tKYU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 18:58:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 18:58:45 +0000
Subject: Re: [PATCH v4 1/5] hugetlb: add demote hugetlb page sysfs interfaces
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nghia Le <nghialm78@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-2-mike.kravetz@oracle.com>
 <YV/4ZFCvoGRn2rtr@localhost.localdomain>
 <47e53389-638a-1af1-e94f-b3c7e5e7459e@oracle.com>
 <20211018073552.GA11960@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0530e4ef-2492-5186-f919-5db68edea654@oracle.com>
Date:   Fri, 22 Oct 2021 11:58:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211018073552.GA11960@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:303:b7::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0113.namprd03.prod.outlook.com (2603:10b6:303:b7::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 18:58:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72e93020-da40-48dc-50db-08d9958df902
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5629:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5629590A44831E495ECCD390E2809@SJ0PR10MB5629.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFL6YEwcTBvRDUYK/bwOgS5P+ydfzCdOzjNsMqt6FZncoq87mIR5f8/50GLf6QJt5ku+KOJDHpma27JdlVpn+ms3YXuWIrQ3+hyirzme9W4UR6wzON7tDeDnzfq7C5+VKL3og4/C3Gx0jG3fZtytgLaA66s3JDlA6azSy4JUaH9Q045Hx75zVN4CB0cwZQ8VIxVKQev6KTuoZzxFvnlvKs1IjSX+aIKe1P2lHqlAxZwd6DQy03pWKVZVVucNJvn1nR/uomZvUYpFNvVsdVFbX/yNYx1IlfMtJbBTCc3V7Zp5jMls0IGOknfKFpbyamf63PljfnQ8bR5Sjb+6uu8tW5dufoZt5WgEmUY2SVcAxje4Y4Pj/wTNuF2UPynd/ZQ2AwXL3s9QcKGmqr3fjQc0y/A+XMQRPcOMkj9pE/lwVHFgI9BD7ttQ4odgi79bXKMqBEWENg+g1lPVm7xgr3BvWpLWfRASyGzqOgAlMEAhEKtYVN44F9wfc2daRU6CqwmIY3QqF5LtShHOcVhAF1WNgYXHc2p5FAr3UsZ8b1sMtGknTG6SrKC2LkDpRy2BekzfYlHckLSUoNSCMP355ZPeGWGhZKCIsaX4CbteWLcZqveSMilDxQ5x3cbu8UjoJMoYTOliP/FpMZvHmVhWsuIHu25EnAy/Ho8nLEIa1+QDVEDTcCD+zd13fsXS1PWqEU6OAflWs9BRe/fnBfgLuLG2WZ8rm0MloyZkmIL7YKq9SNmy9s/i033+hpqWwSvRa2pYqVyvCj2MaA2v4w1NFKPmJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(31696002)(2616005)(956004)(44832011)(6486002)(38100700002)(38350700002)(83380400001)(4326008)(66556008)(6916009)(52116002)(54906003)(66476007)(30864003)(8676002)(8936002)(16576012)(5660300002)(86362001)(53546011)(508600001)(7416002)(2906002)(36756003)(31686004)(26005)(316002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5kL1l4ZExhWjE3dVJTTVRmQnQwN2Q5VTM0T3dMbXUwUzRUUVJuTVhKL0NY?=
 =?utf-8?B?ZnR6cW9wdDVFcUhDNzlweGhvMUF4WXpoeURBaXNEeitnYVYwajMzTXFvaDdG?=
 =?utf-8?B?ZjJyMVBiZDBIR05nR0VxRG9wSnNzZit4dUwrZzdqMVpZMGY5S1h5V1M2QXM4?=
 =?utf-8?B?c2VqWFBvSFAwSENUSHBIQ3BZZ1drV1NiUVR4MmpQMndvZzljaGxIZjhFK2Vs?=
 =?utf-8?B?d2RoTmh2M1NJb0dIRXRvYzlTR1REZjduOVcrVENsNWFLZ2psUTdwb0hOcFc1?=
 =?utf-8?B?NDJ0SnBabHdZVTVuMGRPVU5UL1JZbFhjY1k0aVY2NWxiWDBteVRaMjFoZk5K?=
 =?utf-8?B?UFcxWUx2R3h4U0VMVldlQ2lKenpMY0ZTNEhKb3owdVY1cDJhNCt5Y1lsTGxx?=
 =?utf-8?B?blc3QjJOWVhoc0UrOVExYnl1eURsSVN5NTNjTVYySXhaYjdacm5KZzZ2OGdB?=
 =?utf-8?B?cjNoc1ROc3hXbW1pK2ZEME4xN2ZwL0VRYTZiOU5yRzg2ZXVudGNlVEdJMXl1?=
 =?utf-8?B?NnROdENmUUxoV0dYaWtWTnNOVGlaWTJlVHFBZ2g2TDJnVVR5dVpmRVJaVy9j?=
 =?utf-8?B?VWNyYnNaU0w1WnlYNllOdzNJUDVIWDdtQURTbzJzVFpxMFB6VDhaWVRvRDE4?=
 =?utf-8?B?VzhYWC9KaTM1TmNBQk0rdUJENkppN3JRY3ZZdGNRWThoUmR2ZDlvQ292U21n?=
 =?utf-8?B?a2pOVlA1emJsVi9TY0QxZlB4L3VQN1A3ZWFQdWZRSkJCcGwwUlBna04vUi9a?=
 =?utf-8?B?SW1Jc1NTeFQzMHVSUVd3VDg2M3FXU0h1Mzd3bUpkb3BwM0thMWY2bEkxT2JM?=
 =?utf-8?B?dEp0b0FnSVdOaTd4N2VHYzJDS2t1aFNRK0o0V2ZyT3F0V3E5NWp6SkNsejJY?=
 =?utf-8?B?cGJJeXJqU1J6dklDbGJIY1N4cUJBODZqTFdKaVpGRTNFOTZWdzdFQVVTVDMy?=
 =?utf-8?B?c3doV3ordWxtYUdwR0hMQjVxOW9PSmMvdzJNaXVuWFFZR05PQTVmelZVVC8x?=
 =?utf-8?B?SXdKOE9TUFo2YkhrRmNSTi83U0pNS1VyUUpFQ1R4Z3R4VjdZa3FuK3VYbmp5?=
 =?utf-8?B?ZmZtSW82L2RZNEJxbWhTeGRJYnNEeCtvaHVEOHRMNVVzQzlxYUY1WHErMUNm?=
 =?utf-8?B?VTdkZUFHRnNhMVhiY05tRk02S3crbWZFRElXSW9KYVV5dlFYWXZFcjRxWXFq?=
 =?utf-8?B?TTlvZW9zK0owK0NwM3M3LzdnTGtvaGtZVU5TUy9XM1FXL1YrNzhKaFlwdURq?=
 =?utf-8?B?NHZ5MkhPaVZLUHdCeWJMbkQ0a0hWTGI1cFA3NjJvWisydG9UVWtVRzNSTmZO?=
 =?utf-8?B?Zzh3NVVUOXpNejlSZHIzOUN2M0ticWFXQjN3Q29QL0xrZGtCSEtaLzVHS1Bo?=
 =?utf-8?B?bmF4SWxmVDR5a3J4NzFCcDJocEJuY2pvRmN3YW5SNmlER0xaWkErNi9zL2JH?=
 =?utf-8?B?ZXFnRnJXOXFRVUhYS1RoN0NVOGNzMFdEVTZ1eVM1dkFEeXRrRGZEdHVqd24r?=
 =?utf-8?B?cStuTjQrbDJza0xtRU1xTCtoaXR3bkg3cFdkSnNDUnJsbUtrY0NxWGlwUEFy?=
 =?utf-8?B?STZPU3p0K29ZSTcyaGF6K0VkejEvbFkrejNhMkJ5a2UraUF6eVJLVk80MVl2?=
 =?utf-8?B?ayt6Uk4wTzJYVTNWUUdqYTV1OStnYU1ldzlFa1VWcEsrTjl1L00xckpnYmpO?=
 =?utf-8?B?d3I0NXdtallrVmVjZk90cnp4L01idGYwektOV3VIc0FNZ1VkWWZLSGttNnV0?=
 =?utf-8?B?aHRkSFlXQ3RDMlg5bjduQUtEWDJGbGdVYWZQazl0emRPMllpQi8xNHlScGh4?=
 =?utf-8?B?SWowZkxoK3p6TmcvdXlya1VTakFkS2Rac2dxQmVKMFc4WnZMK2Z5N2xNaTRi?=
 =?utf-8?B?SnZOY3AxT3BCQitLVmlUTWhRclB3a0loVGtNQWtLS1pFTElORklNdXF0YWRC?=
 =?utf-8?Q?H5OAUe4l7Ms=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e93020-da40-48dc-50db-08d9958df902
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 18:58:45.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mike.kravetz@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220107
X-Proofpoint-ORIG-GUID: gVEmsFlJWbwq73fq_XG4fG-EpyTR9q5X
X-Proofpoint-GUID: gVEmsFlJWbwq73fq_XG4fG-EpyTR9q5X
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 12:35 AM, Oscar Salvador wrote:
> On Fri, Oct 08, 2021 at 01:24:28PM -0700, Mike Kravetz wrote:
>> In general, the resize_lock prevents unexpected consequences when
>> multiple users are modifying the number of pages in a pool concurrently
>> from the proc/sysfs interfaces.  The mutex is acquired here because we
>> are modifying (decreasing) the pool size.
> 
> Yes, I got that. My question was wrt. n_mask initialization:
> 
>  +	if (nid != NUMA_NO_NODE) {
>  +		init_nodemask_of_node(&nodes_allowed, nid);
>  +		n_mask = &nodes_allowed;
>  +	} else {
>  +		n_mask = &node_states[N_MEMORY];
>  +	}
> 
> AFAICS, this does not need to be protected.
> 

Sorry that I misunderstood your quesion!

You are correct, the n_mask initialization does not need to be protected
by the mutex.  Thanks for pointing that out.

The updated patch below simply moves taking the mutex after this
initialization code.

Andrew, please let me know if you want something else to make this
update simpler for you.

From f9c401323fee234667787a118c74d93aa185fcf6 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 22 Oct 2021 11:40:57 -0700
Subject: [PATCH v4 1/5] hugetlb: add demote hugetlb page sysfs interfaces

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
index 8abaeb144e44..bb90de3885d1 100644
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
+        these smaller sizes.  Only huge page sizes less than the current huge
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
index 95dc7b83381f..d2262ad4b3ed 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2986,7 +2986,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 static void __init hugetlb_init_hstates(void)
 {
-	struct hstate *h;
+	struct hstate *h, *h2;
 
 	for_each_hstate(h) {
 		if (minimum_order > huge_page_order(h))
@@ -2995,6 +2995,22 @@ static void __init hugetlb_init_hstates(void)
 		/* oversize hugepages were init'ed in early boot */
 		if (!hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
+
+		/*
+		 * Set demote order for each hstate.  Note that
+		 * h->demote_order is initially 0.
+		 * - We can not demote gigantic pages if runtime freeing
+		 *   is not supported, so skip this.
+		 */
+		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+			continue;
+		for_each_hstate(h2) {
+			if (h2 == h)
+				continue;
+			if (h2->order < h->order &&
+			    h2->order > h->demote_order)
+				h->demote_order = h2->order;
+		}
 	}
 	VM_BUG_ON(minimum_order == UINT_MAX);
 }
@@ -3235,9 +3251,31 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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
+	if (!h->demote_order) {
+		pr_warn("HugeTLB: NULL demote order passed to demote_pool_huge_page.\n");
+		return -EINVAL;		/* internal error */
+	}
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
@@ -3433,6 +3471,105 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
 }
 HSTATE_ATTR_RO(surplus_hugepages);
 
+static ssize_t demote_store(struct kobject *kobj,
+	       struct kobj_attribute *attr, const char *buf, size_t len)
+{
+	unsigned long nr_demote;
+	unsigned long nr_available;
+	nodemask_t nodes_allowed, *n_mask;
+	struct hstate *h;
+	int err = 0;
+	int nid;
+
+	err = kstrtoul(buf, 10, &nr_demote);
+	if (err)
+		return err;
+	h = kobj_to_hstate(kobj, &nid);
+
+	if (nid != NUMA_NO_NODE) {
+		init_nodemask_of_node(&nodes_allowed, nid);
+		n_mask = &nodes_allowed;
+	} else {
+		n_mask = &node_states[N_MEMORY];
+	}
+
+	/* Synchronize with other sysfs operations modifying huge pages */
+	mutex_lock(&h->resize_lock);
+	spin_lock_irq(&hugetlb_lock);
+
+	while (nr_demote) {
+		/*
+		 * Check for available pages to demote each time thorough the
+		 * loop as demote_pool_huge_page will drop hugetlb_lock.
+		 *
+		 * NOTE: demote_pool_huge_page does not yet drop hugetlb_lock
+		 * but will when full demote functionality is added in a later
+		 * patch.
+		 */
+		if (nid != NUMA_NO_NODE)
+			nr_available = h->free_huge_pages_node[nid];
+		else
+			nr_available = h->free_huge_pages;
+		nr_available -= h->resv_huge_pages;
+		if (!nr_available)
+			break;
+
+		err = demote_pool_huge_page(h, n_mask);
+		if (err)
+			break;
+
+		nr_demote--;
+	}
+
+	spin_unlock_irq(&hugetlb_lock);
+	mutex_unlock(&h->resize_lock);
+
+	if (err)
+		return err;
+	return len;
+}
+HSTATE_ATTR_WO(demote);
+
+static ssize_t demote_size_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	int nid;
+	struct hstate *h = kobj_to_hstate(kobj, &nid);
+	unsigned long demote_size = (PAGE_SIZE << h->demote_order) / SZ_1K;
+
+	return sysfs_emit(buf, "%lukB\n", demote_size);
+}
+
+static ssize_t demote_size_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct hstate *h, *demote_hstate;
+	unsigned long demote_size;
+	unsigned int demote_order;
+	int nid;
+
+	demote_size = (unsigned long)memparse(buf, NULL);
+
+	demote_hstate = size_to_hstate(demote_size);
+	if (!demote_hstate)
+		return -EINVAL;
+	demote_order = demote_hstate->order;
+
+	/* demote order must be smaller than hstate order */
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

