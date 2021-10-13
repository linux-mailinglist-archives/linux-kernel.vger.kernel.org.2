Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB5142CF82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 02:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhJNAZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 20:25:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38986 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhJNAZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 20:25:10 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DLSgrR032068;
        Wed, 13 Oct 2021 22:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0U+XHhgvBxpksYQTBwNqY71Yxz1vzt/b2fpfRf5+lQU=;
 b=zGKUWYMr4jMuXjCtVD7XFN0JgWJ03do7SQAF9i+H69Uzm+zsvsBxAcA5PEoeg/cLwqEd
 3SD7umOeUlOyF+36G2o2yFZTZpJTLim6mahGuW2US5X+/gO5en8S99SZVv54AOLNUVcB
 +lk1xAw2rlBaJUFqcjJkQYyJyULjKWZhYyF/U5bwf9BzbxVy4E/KdGtg+6LmPmc7gLhK
 JR2uo6UAwPbmTYdEAMb1RP424K9D53xvBLORZ5lOrM2YUQp0Gq8j6xq7v5rpodxkmyiS
 /0U99d1P+kOGpGL6aiqxpbXxxbBvZnn8l4nmjqSJ4a4OqBoz5OPVXUde8qBM0/SzKLIo lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbjfxw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 22:06:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19DM0VWx192530;
        Wed, 13 Oct 2021 22:06:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3bkyxu8d7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 22:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWJH1V/Kaw7hHjDX+z3kiJrtXuTcZ4NhgIhbgAOfDdSd5m5U58UkpCHlsKcF5+6SMFu4V+zy9JDrfrKukVYFIB9N9JKDusR/r1KvN+PCj2weilZkxHLrdos20vQqhoz8VQan+RHVcqCHqDka5iNHBge6van9XHIt2PxA/Xh8j3pvIKYP3cVUzJYRNDDBpndlxJB6OOhAIsIpRTs0mnyzmHcfqGQTR+k7BBEscnwKQ5icNeFtEjqiTLMlkUsnK8aR0EZiDf/mrdBBiygU2Ux2jyBQxAnvtQwJFjNOM08xiUSBiOmOQzdyh/LCI8f0xRXZ+EsjLAj94+5o1kti15iF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U+XHhgvBxpksYQTBwNqY71Yxz1vzt/b2fpfRf5+lQU=;
 b=JvJuZhYjJypMTAWF5Xj7DFECI2ZQN+slnmo+iJ8JRIETSnomsWIP3MDYngyMufamv5CvI2SAz9ACgX7oeewuKhXIgilOeMwk8MEIKMnjyou4x/bClKcY7cl/osxPB0i48PgXmBLdQkPQ12oOEDwbRMGr+dd1TiVjEYH026AwxAdSCXRel88/a9n6qQHBFiZ2ncnk2TL8oBUG/d9tS2XWl8ZdtmQmniakeMtjfMwGD4cJfLu11v6P7nLk8Qd046ovSPrxdKEhedQ1f+Xdj40JbLySxNSMiSjvqASN6IcHB1H45+/YNkJue0vOFwxS5KmesurGJ5lJoXjgoVQS+/1JBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U+XHhgvBxpksYQTBwNqY71Yxz1vzt/b2fpfRf5+lQU=;
 b=bU4F4YVNdJ+KireWR/Q0YrMYjWLtB60lZ39axC6bxXXvfPtw/oBR/wvxbk1i9NN67nUPfaKXRQRjVyTsl1ZI4iZvX3Y0JMWX6xuCQNsAAFSIYSrTujReIpKTH8rqJZeEyy9Nu9GL3FmmpaQt2kuKk9uKuM6v1A0lrXq+CTWqXBM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4671.namprd10.prod.outlook.com (2603:10b6:a03:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 22:06:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 22:06:34 +0000
Subject: Re: [PATCH] hugetlb: Support node specified when using cma for
 gigantic hugepages
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mhocko@kernel.org, guro@fb.com, corbet@lwn.net,
        yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <1633843448-966-1-git-send-email-baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6bd3789f-4dee-a184-d415-4ad77f0f98b7@oracle.com>
Date:   Wed, 13 Oct 2021 15:06:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <1633843448-966-1-git-send-email-baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 22:06:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7003b93b-3e7d-439f-00d9-08d98e95b7c1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4671:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46712429A787239354FDC2A2E2B79@SJ0PR10MB4671.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:356;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khWx1hrgTrT5HinBXtF8b3s/aihoa26Pc1NgsuQRALzo4K3et5HW3Jc0ML03A4l5hfGWuXdAkAoWjqrzWGf3d4n+2sFwPG0khvRYESyJutwSBmo+aPr/NaCwwgKc95k6SvukpFjpyoesFFVlgTkooJjL9t26UTzkRARbCemUbcm+ipId5pm/oYITu1ec8veOHCDmTCE9Uf9/v/MuqLp/EmkU9oH3twk3ztSEijQdMsS4pVcvCwOxBGY9x7yOJJ9TawZKA7H05JYg3bgMMOQck9I5jF0xQWkWTCvtBp2/ZbZrpc7bYQ6/1OsrtW8QVwqltfUvIn26nFj3W9cKmLrR6/++j7oSpd1g0QQkdCDDwcw1WmQlU3FolMwscQmY8uEjfXhiaoft9YwMqh/Oz9R3nJwwP8O4KPOE4vd+P8NKLKvbMx2x5+vmt62iAa/A7BE09V9xefK5WSZalkmRFy0Gl18MLylWYBN92rgTEYKrdrpZ7vptHOsNgi9ft0a9SNdwp1woi/9Uk0+U5Iz6WxKi0/CTuVh9JmwRqDezyV8KIcsqsdkag06695fdOnKS6OvOHixnsh4WYG/tweYr1+ATM+gPnTZnm8/xx4ARA6ppDqjAue5Na2j5Kn8ZSwoRL8Txr2ghDxhbmdgMRpA25T3w1eEdOgzAq8WSiD6uQF6W7Xd6TsPPAqmNz5Y+joAb90Z2qqdVSkeE412ooHJL2GN23nnSbf1I6KYLe2z+Ki6Eq6Oc5/S5LMJL62s92lvnKwy3d0SXkp/djJiD8nENqRwmt2eXSDZot+UaRaRxTGPbuykMgNH6Rrd/OLQiyEjP/DZ50RE79Fr6ZMWwanw6oklHUiaEpFyHFbuOGXDzb1u9fjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(186003)(66946007)(31686004)(8676002)(38350700002)(966005)(508600001)(6486002)(38100700002)(66556008)(26005)(31696002)(66476007)(2906002)(86362001)(36756003)(52116002)(4326008)(2616005)(5660300002)(316002)(44832011)(956004)(83380400001)(8936002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NXbE9BMVB4Y2FhdGVycTFNZysvT25OUzRLT3pqM3QrRkt5aVlGOGkwQVNn?=
 =?utf-8?B?MDFuOTBGUW1UWWJDemZyRDNlVndYVkNOZWhMVWIwdXJLK0lta0lwWHJKRDM5?=
 =?utf-8?B?NXF5bWJnZUhtN1UzMjl2Ky9vcTNUaDlDYXEyYjQ2UUY0T3MxMWp5UkN3OFlK?=
 =?utf-8?B?c1F6ZEE3Tm0rcWhFRit6eHlabXQ0dGJvK052THh2S1hHTnpVUndjTWhITWV1?=
 =?utf-8?B?R3VuQ3d3R3hhUzdFUE5kWitKQmx5TVN5S2hjcVRROHY1MVAvUE5xWThrMlls?=
 =?utf-8?B?b2tNem44UTM4bzRMR0xZT1NjcUxEQjN4SkJRSk9pd28yL0tHaGFRT29ELzE4?=
 =?utf-8?B?QUR2NEkzS1MvZmhIMXdkWlhBTUt4eC8vNmdSamM1T1NycVo0SXFtNTlzang5?=
 =?utf-8?B?SjY3V3NGTjBYZ0o0alU1QzNtN2xyNzdjbmE1SVEvenREUnl4cFY2eXdsSjFy?=
 =?utf-8?B?V1d3ZHV0NmUxR3RBbVY1RFRLK1pvTXhMNU5oT3F3bjY0MXdVS2Vwa3JzUjZ1?=
 =?utf-8?B?Kzd1RWU2UkJjZlZSQWVMK09LVWlOVEFxTWZKVGwxUEJEZ1kxRW9ialZETTlQ?=
 =?utf-8?B?NUovYTcwa2ZsUTExZ2h4NU9vSWxLVHVSWlBrRGF6V1VpRUtGa2dQdzFJZk9a?=
 =?utf-8?B?M3h1WjRac29aZXJLNFdWQkl0cFlEVXZBaFp2T3RQclpCT0ROQStpN3dMK0lp?=
 =?utf-8?B?WHZGNzZQdmZKZENNN0dxT2k4c2gvRzNTMFdKZjl2dTU0bHRxeUU5MXNvMFB5?=
 =?utf-8?B?aE9YZldLMGJzRkJFdHZvdG1takt1dVpNYVJMSGROQ3laWVZja0grOW44YnVw?=
 =?utf-8?B?K2FSck5LU2lyWEltVkc3ZTZQVHR2UkpyTHNhdkpMS2tUZjZpbTl3OWFjYWVr?=
 =?utf-8?B?bW41ZXk0RU12UGZmdW1KaTBiUEY0bi92MWE5ZDU1bFpsODRsNHVIR0ZIS1RZ?=
 =?utf-8?B?amtOV2IzUTZKMGRGYW9XZ3h1UU12dnBtNjlHcEtjcWRKRmRqSkdVbEc2akQ1?=
 =?utf-8?B?WjdRNDZ6enJJbUtWdkhlN3IralczWjA5aVppUGs0V3dsSVFIK2dwWFRqbEJJ?=
 =?utf-8?B?bWJKckVuT1ZVR3BkKzh0RXArR3g4ZWY3ZXI1d2dnOVBDZ0pJVTlRVEw2bDBh?=
 =?utf-8?B?MDFCVGlQQzBhSmtYQWVjMmMxNm1yNkVYdEhXUzNSMTRMUUtXUytNb1luQmlh?=
 =?utf-8?B?N3VOREN0ZWRWSUNjY3JjbnAraVV0bnlEcW9mNWJnOGNDV3ZFYWxYdVZhL1FY?=
 =?utf-8?B?aTlnRUpsczNDaGJHcE1Db3ZjcEdtOEdCNHVtRjc2TUVDQlljWlBqeWZCMUI1?=
 =?utf-8?B?YkpwMisrNFRRR3dqMnFyS253ek1kbDh1N1NPbTF4TDB3ZU9YOEpyeVdnQkpW?=
 =?utf-8?B?d3dDRDNkUkwxTDdqbzlTQ3cycjN2TDI3Ymp3d2drdEd0SVI5SWRNRHcxODFx?=
 =?utf-8?B?eUltYVovdWJwNTg3cGs3aTZYRmtZTGt3MFpVeDlYSisweUp4U0lpZ1Y1bDMr?=
 =?utf-8?B?bHc0SUdmcmhPbHlnWDZ1WlNXcDg3MFV6SmF3aUs2VmNWaTJNSlNxTTJoU09H?=
 =?utf-8?B?N0hJUjFVSDhvaGlaaVBtMFlHekZhTnVoUzNEU3hMVnhHUnE4SldBVU05UXlh?=
 =?utf-8?B?Z2xJTlJoYWRsMis5T0FROFZKTFBLaGxJTTFaOEI4a3JvZUhzZHJ4aVRhUUlJ?=
 =?utf-8?B?MjhHdFI2MWxaVWlyVy9FNENGaTBzMlR1YUNGQ0haS00zQWdORTVqRXE1NC9G?=
 =?utf-8?Q?CTOroAF9TPuRYfD+VJ8AclkTsoDRd5cM6utJS87?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7003b93b-3e7d-439f-00d9-08d98e95b7c1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 22:06:34.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0Aio58tdUaioMHo3NqhbmlvYqeDeiMt9aFQOl1EdsMl0vPjFX0F6gtb0eSTC64wQvX9omqNEBkqgGUs+zexLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4671
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130133
X-Proofpoint-GUID: 9prkCZb87ROd_cHCOZSmS3cr-CyBTGC7
X-Proofpoint-ORIG-GUID: 9prkCZb87ROd_cHCOZSmS3cr-CyBTGC7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/21 10:24 PM, Baolin Wang wrote:
> Now the size of CMA area for gigantic hugepages runtime allocation is
> balanced for all online nodes, but we also want to specify the size of
> CMA per-node, or only one node in some cases, which are similar with
> commit 86acc55c3d32 ("hugetlbfs: extend the definition of hugepages
> parameter to support node allocation")[1].
> 
> Thus this patch adds node format for 'hugetlb_cma' parameter to support
> specifying the size of CMA per-node. An example is as follows:
> 
> hugetlb_cma=0:5G,2:5G
> 
> which means allocating 5G size of CMA area on node 0 and node 2
> respectively.
> 
> [1]
> https://lkml.kernel.org/r/20211005054729.86457-1-yaozhenguo1@gmail.com
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 +-
>  mm/hugetlb.c                                    | 79 +++++++++++++++++++++----
>  2 files changed, 73 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3ad8e9d0..a147faa5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1587,8 +1587,10 @@
>  			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
>  
>  	hugetlb_cma=	[HW,CMA] The size of a CMA area used for allocation
> -			of gigantic hugepages.
> -			Format: nn[KMGTPE]
> +			of gigantic hugepages. Or using node format, the size
> +			of a CMA area per node can be specified.
> +			Format: nn[KMGTPE] or (node format)
> +				<node>:nn[KMGTPE][,<node>:nn[KMGTPE]]
>  
>  			Reserve a CMA area of given size and allocate gigantic
>  			hugepages using the CMA allocator. If enabled, the
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6d2f4c2..8b4e409 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -50,6 +50,7 @@
>  
>  #ifdef CONFIG_CMA
>  static struct cma *hugetlb_cma[MAX_NUMNODES];
> +static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
>  static bool hugetlb_cma_page(struct page *page, unsigned int order)
>  {
>  	return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
> @@ -62,6 +63,7 @@ static bool hugetlb_cma_page(struct page *page, unsigned int order)
>  }
>  #endif
>  static unsigned long hugetlb_cma_size __initdata;
> +static nodemask_t hugetlb_cma_nodes_allowed = NODE_MASK_NONE;
>  
>  /*
>   * Minimum page order among possible hugepage sizes, set to a proper value
> @@ -3497,9 +3499,15 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>  
>  	if (nid == NUMA_NO_NODE) {
>  		/*
> +		 * If we've specified the size of CMA area per node,
> +		 * should use it firstly.
> +		 */
> +		if (hstate_is_gigantic(h) && !nodes_empty(hugetlb_cma_nodes_allowed))
> +			n_mask = &hugetlb_cma_nodes_allowed;
> +		/*

IIUC, this changes the behavior for 'balanced' gigantic huge page pool
allocations if per-node hugetlb_cma is specified.  It will now only
attempt to allocate gigantic pages on nodes where CMA was reserved.
Even if we run out of space on the node, it will not go to other nodes
as before.  Is that correct?

I do not believe we want this change in behavior.  IMO, if the user is
doing node specific CMA reservations, then the user should use the node
specific sysfs file for pool allocations on that node.

>  		 * global hstate attribute
>  		 */
> -		if (!(obey_mempolicy &&
> +		else if (!(obey_mempolicy &&
>  				init_nodemask_of_mempolicy(&nodes_allowed)))
>  			n_mask = &node_states[N_MEMORY];
>  		else
> @@ -6745,7 +6753,38 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>  
>  static int __init cmdline_parse_hugetlb_cma(char *p)
>  {
> -	hugetlb_cma_size = memparse(p, &p);
> +	int nid, count = 0;
> +	unsigned long tmp;
> +	char *s = p;
> +
> +	while (*s) {
> +		if (sscanf(s, "%lu%n", &tmp, &count) != 1)
> +			break;
> +
> +		if (s[count] == ':') {
> +			nid = tmp;
> +			if (nid < 0 || nid >= MAX_NUMNODES)
> +				break;

nid can only be compared to MAX_NUMNODES because this an early param
before numa is setup and we do not know exactly how many nodes there
are.  Is this correct?

Suppose one specifies an invaid node.  For example, on my 2 node system
I use the option 'hugetlb_cma=2:2G'.  This is not flagged as an error
during processing and 1G CMA is reserved on node 0 and 1G is reserved
on node 1.  Is that by design, or just chance?

We should be able to catch this in hugetlb_cma_reserve.  For the example
above, I think we should flag this as an error and not reserve any CMA.

> +
> +			s += count + 1;
> +			tmp = memparse(s, &s);
> +			hugetlb_cma_size_in_node[nid] = tmp;
> +			hugetlb_cma_size += tmp;
> +
> +			/*
> +			 * Skip the separator if have one, otherwise
> +			 * break the parsing.
> +			 */
> +			if (*s == ',')
> +				s++;
> +			else
> +				break;
> +		} else {
> +			hugetlb_cma_size = memparse(p, &p);
> +			break;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -6754,6 +6793,7 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
>  void __init hugetlb_cma_reserve(int order)
>  {
>  	unsigned long size, reserved, per_node;
> +	bool node_specific_cma_alloc = false;
>  	int nid;
>  
>  	cma_reserve_called = true;
> @@ -6767,20 +6807,37 @@ void __init hugetlb_cma_reserve(int order)
>  		return;
>  	}

Earlier in hugetlb_cma_reserve (not in the context here), there is this
code:

	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
			(PAGE_SIZE << order) / SZ_1M);
		hugetlb_cma_size = 0;
		return;
	}

That causes an early exit if hugetlb_cma_size is too small for a
gigantic page.

On my 2 node x86 system with 1G gigantic pages, I can specify
'hugetlb_cma=0:512M,1:512M'.  This does not trigger the above early exit
because total hugetlb_cma_size is 1G.  It does end up reserving 1G on
node 0 and nothing on node 1.  I do not believe this is by design.  We
should validate the specified per-node sizes as well.
-- 
Mike Kravetz

>  
> -	/*
> -	 * If 3 GB area is requested on a machine with 4 numa nodes,
> -	 * let's allocate 1 GB on first three nodes and ignore the last one.
> -	 */
> -	per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
> -	pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
> -		hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
> +	for_each_node_state(nid, N_ONLINE) {
> +		if (hugetlb_cma_size_in_node[nid] > 0) {
> +			node_specific_cma_alloc = true;
> +			break;
> +		}
> +	}
> +
> +	if (!node_specific_cma_alloc) {
> +		/*
> +		 * If 3 GB area is requested on a machine with 4 numa nodes,
> +		 * let's allocate 1 GB on first three nodes and ignore the last one.
> +		 */
> +		per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
> +		pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
> +			hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
> +	}
>  
>  	reserved = 0;
>  	for_each_node_state(nid, N_ONLINE) {
>  		int res;
>  		char name[CMA_MAX_NAME];
>  
> -		size = min(per_node, hugetlb_cma_size - reserved);
> +		if (node_specific_cma_alloc) {
> +			if (hugetlb_cma_size_in_node[nid] <= 0)
> +				continue;
> +
> +			size = hugetlb_cma_size_in_node[nid];
> +		} else {
> +			size = min(per_node, hugetlb_cma_size - reserved);
> +		}
> +
>  		size = round_up(size, PAGE_SIZE << order);
>  
>  		snprintf(name, sizeof(name), "hugetlb%d", nid);
> @@ -6799,6 +6856,8 @@ void __init hugetlb_cma_reserve(int order)
>  			continue;
>  		}
>  
> +		if (node_specific_cma_alloc)
> +			node_set(nid, hugetlb_cma_nodes_allowed);
>  		reserved += size;
>  		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
>  			size / SZ_1M, nid);
> 
