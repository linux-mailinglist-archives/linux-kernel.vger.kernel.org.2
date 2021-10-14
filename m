Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511DB42E3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhJNVus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:50:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8472 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhJNVuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:50:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EKt3mf022067;
        Thu, 14 Oct 2021 21:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DWHUzuJuPmRid4+LdijpS/3jGG2z3Pyqn2kcBqyM7C4=;
 b=jOARDCzjmr92OXo6dMqXZ3RUHtjiDX2WqOBFWw7cDO9MXt6l3fhGHuOg8kBD7HuvoQwa
 Rz1pGslYaH7rTTIbSQDqLCHVmsQsL2hIzUDPrNLyH8Ruh9wL9n+65xZp1s0GHdXzVMz2
 qV5g3sq4xpZ1+HhckMTvWDFsE/iPdAPyCJU0/3kwyBH4GoXvy4ZahBCrfBUUP4p3Yr3o
 wCVosm5ZDXELbINcyCGQJ6oCHf21iN9cdnYNIC9RhX1zDsvig6JvW6IY73Lk4+pHovJK
 mmqPqjBctL8fgK6tKyUSFcsvrUirageu+CSU6fF2RMreMnQlx7ezhdeh1yS06r4qjH4X og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bpfvedb6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 21:48:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19ELipAR063757;
        Thu, 14 Oct 2021 21:48:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 3bmae3a7gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 21:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1htYeIA/cYPS7laq0tbXUYzDxFM7Bj/JgTcg+FMXExYnmXRSaSi8TgFXA8cxZtp5z8o5fz3dVzYRM93KZyZ0BNSRhYEWhTWqrVXhuPNAcM3k1dmqkxivQ2V0JukMWOrrF3TxDCilZJtQmOYmnkFUWF+wcaHdvcjCn9elOL5Pa+85e6f7ptsClwRnpC234CktjAQj8C/pqPQhDGz4Juy43LOvsvdOt/OxMIEoyvO+8bzheOEfqQEH2RijPe7qsS3uzF7ZB/zm9i2g92FdoTFjpCJwyHjfqyJ0552BgfpyS6IyUifQ1UJRBT9rK+Ql5/0B2gyqogKcrlVe+MLMkTzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWHUzuJuPmRid4+LdijpS/3jGG2z3Pyqn2kcBqyM7C4=;
 b=kXKgJNAftPGINp29aKUHnZ+V2fdAUgw6t6d6gOBbrQnIHYYlLleIs0gJWHlN3DRC25LzJuX6zNYDun1EfnKgT03s4NQwzowDhs7jKra3InUT965TJpHfmv7LNOXJl0QS1Iggx3O8LRhz94yY9bUe3eW6LH6JvQPveUBvxWZA4cCT2xk6Q6tmuvuyTrUa96pQuMTKmmsr70qN3E5MSVoTaanMVPhN6Nn/ESTb3inIMhudrIsoHKRLfYGOlMiKZJDT9aqRIfCU/otUrkEP3RFoRjnrBzoCjKMms91TA3p9u2+hobXq/ChGkqCicdpo6+7+Dawg4x72DYava1pBiJO/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWHUzuJuPmRid4+LdijpS/3jGG2z3Pyqn2kcBqyM7C4=;
 b=Vzn13oG88/7Mk0K3Dv5PSTsJY3/uwFoBXuxd/Ss0o/XZOCR9+VTx4Fc6hKVTPRfzyCEB8GtAhGp93LKlMOFR2ey67baCnI6+RGp9/9RZIpDFpZ2ariU0EXPYSnOMj4181uqxcve+yl59mYElW6HvccxwgBhdiB9Btiveh3DOUQE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3640.namprd10.prod.outlook.com (2603:10b6:a03:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Thu, 14 Oct
 2021 21:48:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 21:48:28 +0000
Subject: Re: [PATCH v2] hugetlb: Support node specified when using cma for
 gigantic hugepages
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mhocko@kernel.org, guro@fb.com, corbet@lwn.net,
        yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <3ba7d5a3ce5002f6718ab2c16e10441eaaf7740a.1634182476.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <424eaeb5-f2b5-89f2-f3d9-fe386ec344e3@oracle.com>
Date:   Thu, 14 Oct 2021 14:48:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <3ba7d5a3ce5002f6718ab2c16e10441eaaf7740a.1634182476.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0077.namprd17.prod.outlook.com
 (2603:10b6:300:c2::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR17CA0077.namprd17.prod.outlook.com (2603:10b6:300:c2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Thu, 14 Oct 2021 21:48:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c183a92-d83d-4f87-9a15-08d98f5c5afd
X-MS-TrafficTypeDiagnostic: BYAPR10MB3640:
X-Microsoft-Antispam-PRVS: <BYAPR10MB36404C41E1607911448077B1E2B89@BYAPR10MB3640.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/8wnvMITqPIFvokui3504jOXklnZmWkAFFdUGze92mxfCtLV0jnrK52ZCcl9IjYVDuzZHb5NqEKUv4MXMrs24DLreQPBptgyhX+tNyK9EBcxTL7fXSFIsa3j3/yFDkpCEn2ZHRFeC7xHU77Uj1F6Nec4FopEEL4H0z909s+fu//FX64Qz2C/2T7BH3i9Rq6nM8A6OLjF9tp6W2Jg3G0hGnqGg84lM0r6xS2JfGnIpDbnyeDW+DZrQ2I6wL0lP0vVU5iQhEiOGOlXF4Dcx6tQWsRZm+p7z9mkseUEvaNGqUGoshgBZm7AOLDgUr5zNEWP+BxVlKxYzedj5qHLncPtODgvv31leYZYc5lKTOCXYuHM/JZ9YLqZiZeSlfTrQx6fsDKbgYd+J6iXb7TSgbU7WzMWFaiyEIdX+tDXGXT7wjX17mfO5g4+B7Xe/xmAKHpNcirp9ODskdfipiYcCgxJgbstyHuBioioWs8Wuq7UIrVmO/NcjbQ9ex5yNCc76sRci16aVhXhMTYX1YHX/rDQVfH/IdmmSHnI0GF5UgPBE34k7TRyGcESmy65pnQL/hx+yxfzPluGCgvbS+KVSen7ufGpyUr7b1HoEg6VauoSYdQjtDeSXShWko60eB9JDyKuzKYJHC9+doTQF3OnNs+lHR5aP89IMxDWfViJ7qHCocBgVHndRdNeF9IFwslKKYY0Qmorhkaigpt5FP6i1HruurZssC9zc4C/hszaGxTdXPKK3vojkA2/4FVx7oQUuL/IoUojy7cSAaXxBT7d4rjvR4TfnzMbD2j/E339RpJIxaHryxns5+6IFFzin6IEwb+RVAsCwewHB9btNOGOV5OnXr7tQvrVUUqh2cpFRSyz8GabU/OGQS0ROqHBxQodPFyjXoooLjaJEmEfDVVrz40pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(31686004)(186003)(508600001)(316002)(66476007)(8936002)(36756003)(966005)(66556008)(26005)(16576012)(66946007)(2906002)(83380400001)(53546011)(31696002)(4326008)(2616005)(956004)(52116002)(38100700002)(86362001)(38350700002)(5660300002)(6486002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNPNUVObVdxRlcza3ZKaFdNOVBsOVQ0MlNkdnBTOEhNVG5xVmxKS2lFWU1H?=
 =?utf-8?B?Ykhha2xDTFQvWGdYN3lXYnFpWnhISE9hSVZjcWx0T0ZwaW1saTdJanArdWpq?=
 =?utf-8?B?Z0JrZ2lhV3ZUZGJVWC9oenhPRFNOOHhBTVFlOTJhaFFMU1FHZ1FxVVMxMUVS?=
 =?utf-8?B?cExmbUU0Umh1blAvNW5ZM3FOZlVtUloxTGxMenBxSmxlcEIyc2IvQ2ltQjVw?=
 =?utf-8?B?ZkxIT1UyUjdTb3I3N1BGb24zd2hic2dHVGUzTWxPbUhsRWpxNURRUU1na0hR?=
 =?utf-8?B?VGRINnJjWkU1TW1jdExiOXdZUXlnZEc4YnFRdmcwdkwrMnAvUS9PbFhSY1BB?=
 =?utf-8?B?WGFtcnhGbUxTdVNNSytpU1hRYUplbUNBWFNqdEQ3NnRDMnI0Nk1Ob2RoTFNF?=
 =?utf-8?B?NzBkemlJeStTeXluczBsZW9hZTNQMUl2YStaNDRSV3NvNVFheXNyK0Z5T2cw?=
 =?utf-8?B?Qm82WjkzRTNJam54QlNvUHZSMlM2MXRBZFVRS011dytCSjJLS1RGdGdPaFFS?=
 =?utf-8?B?aFJiRS9FYkQ4dnVubEU0TXpWbUFtZk92Znc2L0g5QTdKcEZlYi9OSG1ST1hi?=
 =?utf-8?B?UmFhMU1leHdNRXJzZC81U2ovcFdyS0p2eUpYMUV1YjZ0eVRPUEN5N3lDZHBk?=
 =?utf-8?B?SFZlQXhGa2ttcjJIRTAzV0R4U1lSVzMwZUtuYVN2NzNhZWZtcnZVNUIvaG1V?=
 =?utf-8?B?UWNxVnRrRGtsa2tVdEpiOWVSWGdQeHZvNmVnZm02SUZJNUhaWCtURVJqYVVh?=
 =?utf-8?B?bzZUOWd1dEtqOS9CZTUyOC9RWm43T1pLM0RMTEJja2U4R0hsdUtrNkNoT3RV?=
 =?utf-8?B?Ymt0QmpFU1ZtcUlOUmZveFVlVmdNeXhIWHlCZnNsUU96MEJsZDhnRmIwVlFL?=
 =?utf-8?B?UitCK2JJZm9yNjJJeUJJbTFTUkl2N1pkdC9hWWl4V1RrL0lmeG13RWJJTnRF?=
 =?utf-8?B?TUpnOW5UR05DU3ZZdlBjaDRud1czV05qTm1QcGVadWg4TUZCOVB2ZTlCajhm?=
 =?utf-8?B?QlFNMkV0TVlXV1FCbHFMNGxtRTBOOHA5M2d1NTFvQWFLbkVVenBXM2x6K2lY?=
 =?utf-8?B?ZDczcmY3dEdHTzlvM0hKYzQvREVWTmgvRmM5WllHZHp6WUt2NmJEMWwvQnpM?=
 =?utf-8?B?V08vb3JVeHFMa1l2N0YxemFHZzZOVmV0a3ZJNTA2TGNPaERlMmdNSjRpYXI1?=
 =?utf-8?B?SUVLNjJmZnBUT0FLL2FIZ3U4WklNZkFGUVRWS1NJWEtuUW9WWGs2cllsZGlZ?=
 =?utf-8?B?UEJTN20vakxOcE9OczI3ejVSeGsvVFlEcCs4anBvZk43aGRpeVdMaFB0dS9m?=
 =?utf-8?B?ZzIrOVhJY1lNUnFoOW5sbVpPcXpLcTJvdUtHZjQydGR0YVFjUk9MWVNETzJD?=
 =?utf-8?B?UmZrWkpyVjM3Q1JSeFVrZDliUkhuQ1h3U2xsR1dtcmkwZitlTzd5U0l0bGRC?=
 =?utf-8?B?NGpYNFVoTDV2eXlDT3YvKzZ1bDZaYVJ3K0hhZnVCaUFoQlVKd2pyM0ZzNzBD?=
 =?utf-8?B?RXNYQlhWdVk0Z3JKUnJFZktmeEVMSnBWYzFtd1h0a0kxUGJ0S294QlUwRFlE?=
 =?utf-8?B?bjdRQU9XaTM4bWVWeGFLSjBvZjRqMXdFYXhTdml4alp1eU5vdXlBSExmdlpT?=
 =?utf-8?B?RVFLdlVDUy9idXBFcU5uak4xOFUrUFlZdGRoMU5FczNZR0p2VFVDbzZ3a1Rm?=
 =?utf-8?B?RXpQZG5oRk5Ta0MyOWlnVk4zb2REOHc4Q0k5NDlxZ1AzcVROKzYzK3ZNdjBh?=
 =?utf-8?Q?uWQPdG5JlPjm24Y0lRKruro3y1sJdIRO16seV+C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c183a92-d83d-4f87-9a15-08d98f5c5afd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 21:48:28.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBjUddGU8iB5spu7k9trmaxw8OFYUkNd+k3iKnn5DCBo0F8I+xyQcTujrdc1ClIqnxr11q5eGhlo/QQ7H33Juw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3640
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10137 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140122
X-Proofpoint-GUID: 84w7uis-aVqNSGfDHwM_XKP3OLSfYAU6
X-Proofpoint-ORIG-GUID: 84w7uis-aVqNSGfDHwM_XKP3OLSfYAU6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/21 11:08 PM, Baolin Wang wrote:
> Now the size of CMA area for gigantic hugepages runtime allocation is
> balanced for all online nodes, but we also want to specify the size of
> CMA per-node, or only one node in some cases, which are similar with
> commit 86acc55c3d32 ("hugetlbfs: extend the definition of hugepages
> parameter to support node allocation")[1].

I would not include the commit hash here.  IIUC, this can change as it
is moved to Linus' tree in the next merge window.

> For example, on some multi-nodes systems, each node's memory can be
> different, allocating the same size of CMA for each node is not suitable
> for the low-memory nodes. Meanwhile some workloads like DPDK mentioned by
> Zhenguo in patch [1] only need hugepages in one node.
> 
> On the other hand, we have some machines with multiple types of memory,
> like DRAM and PMEM (persistent memory). On this system, we may want to
> specify all the hugepages only on DRAM node, or specify the proportion
> of DRAM node and PMEM node, to tuning the performance of the workloads.
> 
> Thus this patch adds node format for 'hugetlb_cma' parameter to support
> specifying the size of CMA per-node. An example is as follows:
> 
> hugetlb_cma=0:5G,2:5G
> 
> which means allocating 5G size of CMA area on node 0 and node 2
> respectively. And the users should use the node specific sysfs file to
> allocate the gigantic hugepages if specified the CMA size on that node.
> 
> [1]
> https://lkml.kernel.org/r/20211005054729.86457-1-yaozhenguo1@gmail.com
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Changes from v1:
>  - Update the commit log.
>  - Avoid changing the behavior for 'balanced' gigantic huge page pool
>  allocations.
>  - Catch the invalid node specified in hugetlb_cma_reserve().
>  - Validate the size of CMA for each node in hugetlb_cma_reserve().
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 +-
>  mm/hugetlb.c                                    | 98 ++++++++++++++++++++++---
>  2 files changed, 93 insertions(+), 11 deletions(-)
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
> index 6d2f4c2..ac9afc2 100644
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
> @@ -3508,7 +3510,16 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>  		/*
>  		 * Node specific request.  count adjustment happens in
>  		 * set_max_huge_pages() after acquiring hugetlb_lock.
> +		 *
> +		 * If we've specified the size of CMA area per node for
> +		 * gigantic hugepages, should catch the warning if the
> +		 * nid is not in the 'hugetlb_cma_nodes_allowed' nodemask.
>  		 */
> +		if (hstate_is_gigantic(h) &&
> +		    !nodes_empty(hugetlb_cma_nodes_allowed) &&
> +		    !node_isset(nid, hugetlb_cma_nodes_allowed))
> +			pr_warn("hugetlb_cma: no reservation on this node %d\n", nid);
> +

I would prefer to drop this code and hugetlb_cma_nodes_allowed.  Why?

CMA is an alternative allocation mechanism for gigantic pages.  The
allocator will fall back to the normal allocator (alloc_contig_pages) if
allocation from CMA fails.

This warning implies that the user 'forgot' to reserve CMA on the
specified node, or is perhaps allocating gigantic pages on the wrong
node.  We can not be sure this is the case.

I agree that in most cases when a user requests node specific CMA
reservations, they will likely want to perform gigantic page allocations
on the same nodes.  However, that may not always be the case and in such
cases the warning could be confusing.

We do not print warnings today when allocating huge pages via the
proc/sysfs interfaces.  We should not add one unless there is a very
good reason.

>  		init_nodemask_of_node(&nodes_allowed, nid);
>  		n_mask = &nodes_allowed;
>  	}
> @@ -6745,7 +6756,38 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
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
> @@ -6754,6 +6796,7 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
>  void __init hugetlb_cma_reserve(int order)
>  {
>  	unsigned long size, reserved, per_node;
> +	bool node_specific_cma_alloc = false;
>  	int nid;
>  
>  	cma_reserve_called = true;
> @@ -6761,26 +6804,61 @@ void __init hugetlb_cma_reserve(int order)
>  	if (!hugetlb_cma_size)
>  		return;
>  
> +	for (nid = 0; nid < MAX_NUMNODES; nid++) {
> +		if (hugetlb_cma_size_in_node[nid] == 0)
> +			continue;
> +
> +		if (!node_state(nid, N_ONLINE)) {
> +			pr_warn("hugetlb_cma: invalid node %d specified\n", nid);
> +			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
> +			hugetlb_cma_size_in_node[nid] = 0;
> +			continue;
> +		}
> +
> +		if (hugetlb_cma_size_in_node[nid] < (PAGE_SIZE << order)) {
> +			pr_warn("hugetlb_cma: cma area of node %d should be at least %lu MiB\n",
> +				nid, (PAGE_SIZE << order) / SZ_1M);
> +			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
> +			hugetlb_cma_size_in_node[nid] = 0;
> +		} else {
> +			node_specific_cma_alloc = true;
> +		}
> +	}
> +
> +	/* Validate the CMA size again in case some invalid nodes specified. */
> +	if (!hugetlb_cma_size)
> +		return;
> +
>  	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
>  		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
>  			(PAGE_SIZE << order) / SZ_1M);
>  		return;
>  	}

The series "hugetlb: add demote/split page functionality"
https://lore.kernel.org/linux-mm/20211007181918.136982-1-mike.kravetz@oracle.com/T/#mcb25f5edaa235b93dd0d0b8fb81ba15f0317feeb
is in Andrew's tree and has modified the above to set hugetlb_cma_size
to 0 before returning.

Code in that series uses the varialbe hugetlb_cma_size to determine if
CMA was reserved and can possibly be used for huge pages.  If no CMA is
reserved in this routine, it must be set to 0.

The code below should be fine as it checks 'reserved' at the end of
routine and sets hugetlb_cma_size to zero if !reserved before returning.

Mostly wanted to point out the context conflict with Andrew's tree.  He
or you will need to fix this for the patch to apply.
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
> +			if (hugetlb_cma_size_in_node[nid] == 0)
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
> @@ -6799,6 +6877,8 @@ void __init hugetlb_cma_reserve(int order)
>  			continue;
>  		}
>  
> +		if (node_specific_cma_alloc)
> +			node_set(nid, hugetlb_cma_nodes_allowed);
>  		reserved += size;
>  		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
>  			size / SZ_1M, nid);
> 
