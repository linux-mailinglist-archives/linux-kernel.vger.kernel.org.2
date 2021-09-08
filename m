Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946134041A6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 01:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhIHXPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 19:15:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50382 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233315AbhIHXPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:15:08 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LXbhY004863;
        Wed, 8 Sep 2021 23:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CjLtxZ23t1c7ye5m/HT+P674uiRsovw6Muuymn/Maho=;
 b=duoLIeEGiQntRFkUU+kaLpT5OhgC+zcTJLeS8SoOFYONa3kSwcEvebdSKRP1P+1gZdVH
 tOmHMcJTQWx7xPksjPuJaRDlLntzgq3MEs6o0qysiwaksonIOCfWxy5UueQOqPSxuti5
 Ls0BRgjndozcmNmIJWTw1gbdHeGhnVAZ9mxnkQHe9TjA3Leas4JIDQ5HqidxV9Ux85Ag
 AeCWD3ZPkImbQFcPUW+PCob+KCJ+eo02tzDLeCQumd7K7YLff4BOEaZfXXKALX9T9xuX
 BGW0M3PPMAduIrzYcSQ7xPWJpq1Se4qLmtdge3/xiX+uLaYvawoLH2nKqCGjCYsbwZaN aA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CjLtxZ23t1c7ye5m/HT+P674uiRsovw6Muuymn/Maho=;
 b=hNxc0aX6EBWV4e+k/odo8uiaiMOTkYVjBnJHuSahtOgwxxsKLHXW62MEnnrBC9wX9Hdj
 Dp2lkEyiVrmvxg8VKrWryrx15aTrOi0pTNM8yGIP7ubHgkpBf5Mz6hc2YuCbRr6X5Vop
 Q4ffCwdEM/7iy5eC/5sb6VgzwSyiEFAYaiy9SVt36aRTmm/AfaKSgsP/VTnUNHGQb2jx
 5EVPhQYhAU8eY65OqiUksw7hLA1TcZ72sexpdVgv8EM1WF9D0k+enTGarLGVE8ENWuzk
 TJk41EAH9uBpjUb049y69Bp/N7E8+pK65vlxO9Knj/En9BdZgZIRQnXe3qYR2BuuBTrE 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuqca7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 23:13:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188N6EFY195403;
        Wed, 8 Sep 2021 23:13:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3030.oracle.com with ESMTP id 3axcppdm68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 23:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiZty6J/XetkvVUCZRBOIS2WncxX5+qGIMywlbqf3vpKLIcuyAL8XrL1nJF3UUeLLbg0/wG7Rp06VSK70dzRNnHuyii8Stj95porBOkN2nCDJZFSFwcLxcrxZn+5pXiurB+DGFmzVhlLtNcg31aWwx3hq2y9DlwP3EaFxfh1pgenbeyRfTgcXK8WxzB9g9zdpOy6YOakYPndmXn1lXT7WmiECnhAvF0AIXlqIneVqgA+NO1pHt7nuzvXlMwrFaBu8+bP9tifRD6OuBgUY1VAdroMBNW0shFvTDzOKWR/2DGVmRzsHs4FMryN2wKvZLECISkvIGlooQHFDTIZmpyMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CjLtxZ23t1c7ye5m/HT+P674uiRsovw6Muuymn/Maho=;
 b=Qe0oTmjDQU/hzj0SkggfqAYILwH14/mMWIaH9dDKY5mQSqAYxmt7PUQ1ph/R5k005/agQQbvPkQKeHwCyIN9/VeMmaiRNhWcS6XzSHUyaij/roegDERckkfjauj7dq9Bj+SdXxY9rfiNtutfeLitvy5ZL/wmPubegz8/fehRs4ziq9EMcYAaIZATSsTaOR31j10wxuCR7oJVnjjlwcsu8vGe/xV2kvKDwb3AvU3lB3IrObUPhhWwgoeKZYMlmvdFUlfOQKocERjglcFsmngBDXVgaQsHIRPjsEKOjIKMNY2qs2L1wh8l5AhOS5VOn7jz3bfaST4CqoUfnEeiO0Dpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjLtxZ23t1c7ye5m/HT+P674uiRsovw6Muuymn/Maho=;
 b=lN6qtH4YoLX5ESG1X0IT05XmfbQLv2DhIasJiNJysillB3MmB0yG5tOPB/NrzZK3Mw9ab9kxp+83zOnz/sMzNgJ/kS3jmbfbLKOX+XgjCsceDZlTqihXPYQ0g3Rsfn1qfkQdVJWbBH/QAe5fnEUvcd4KaNA2OzUQOBmxp6FIxrc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5456.namprd10.prod.outlook.com (2603:10b6:a03:3bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 23:13:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 23:13:23 +0000
Subject: Re: [v3] hugetlbfs: Extend the definition of hugepages parameter to
 support node allocation
To:     yaozhenguo <yaozhenguo1@gmail.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, yaozhenguo@jd.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210902065902.81943-1-yaozhenguo1@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d445cda6-873b-5be5-cda1-1f886bce700c@oracle.com>
Date:   Wed, 8 Sep 2021 16:13:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210902065902.81943-1-yaozhenguo1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:300:116::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR07CA0002.namprd07.prod.outlook.com (2603:10b6:300:116::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 23:13:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c23e951e-2331-4c18-79c6-08d9731e4150
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5456:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5456B268FBD34AEC4CF7B24FE2D49@SJ0PR10MB5456.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8Wn23NW9PKeGY7iPUBuSjiICJ0LEmo8tj0KIukqZUHNGAmkig3l1iTGqD/MWmpNtKS41TP3OHe4goye500c4aboBf728VcfuegPWGuhsSh2QzKBMegCsaKM2jUhTMzkKvRSe5ejGP0kwPG5Y2ZxNysvv1mrPj/2pxBgsvvFHHwvMFtWKYd20NZLtvQ1lyfndvNeNp9ecbKOetmQtsh4nBURW4ecUKx4pHXAJooBy2MFAG2SYT3HrQaGdsXXIX7QyFoVX4nRrLEkf/vPx4Jb3IzOEFW2lg51J1YY38gCT3LOXdkUBdJoX9+4NDii91147wAyBQ79LOS3hF579rorRJxZ6+Sjc21sZhcui0GPUvRYkG7qFvsvFQdATnFRFYMLL2gMSU+x31yQhEGcKR7P/4SsuNWzHzgCAIyXMq/YYYL3F4FHOfYvteHsZ4SIXawjYRt/sRru/DG9fZbEW+HdCRm9D0c/mAShWBoJ3WSc3RhUUgycTrlkeb0f06pgxURcegw0pP8jSzjU3Wb5lqG4viuJuT8jseG6wddxBQKZAiQdVGQKXpnN4xws3nYRhKDTIT01529D7mh5oGjefy1zTGn9WT7cc+/oeM8GdmUh0VmT83Ac7ZM2zJkU5gIunoXqCjRMxQJyAN4nn6ABaQcDFMXLPAcJRwQv73uUYbu85Rb1K/guX58PenbwDZWbCuEdk7XveTg2in2u9dD3Qqd5Fxnf0SqOpvbXWZS4ITmEHHNykBL8gurGRKYd7ft0fH0B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(366004)(346002)(136003)(5660300002)(6486002)(26005)(478600001)(6916009)(186003)(36756003)(8936002)(2906002)(31686004)(44832011)(86362001)(956004)(2616005)(38350700002)(38100700002)(66946007)(66556008)(66476007)(8676002)(53546011)(16576012)(4326008)(316002)(31696002)(52116002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdJWEx6NmhpUUdQK3VUKy9jT3QyS0ljcWVqVCtQMDhRZXlsSmU3ZEhuUE5w?=
 =?utf-8?B?VHh6eVpBaFRzS2FZUndpM1RIQVQ0clpGcTgrRXg0dkVkbE4yeUN2cUV3REY4?=
 =?utf-8?B?UVhsYWh1UnBLQ25UMmhHSnpZOE1nVGRnVldSS015bzdXb2c2ZktmTTdUNEpt?=
 =?utf-8?B?S01RY0thdkl0VGJIVHpOaStmLzRJM3cwdmpzbmFyV3lDVmczWllnTWdzVE5j?=
 =?utf-8?B?cnJFOHZYY0xtcE1Fd25XaWZJeThIODhyL3pIcTJOU2laTG90V0tWWmorYzZv?=
 =?utf-8?B?S0JVM0dWenNzQ2w1QWFVRGNtRWNtNEpEZ2gwSVZkaEVPTnMrRGlMeW1pVHhz?=
 =?utf-8?B?OG9DY0lBb2dsUElGVmJvdmVxak5TUGFpQzlpaWRGZFdVc2lKelUxZTNBdXNp?=
 =?utf-8?B?ZC8xYnoxaVAzS3ZtcFhPQ042YWFacDN2WHNxczh0Ri8rbjIraDcvZnA5aEhF?=
 =?utf-8?B?eGtQT3ZHVndHcUt3NzdHc2dUQmtwaEpYRnBuOVAwRXRKbysvdGthSzZBUDZa?=
 =?utf-8?B?S2QvQUh6NkhCVWlXVUw2REIzbG9STVkrTXdDL0kwZzY0Y2tGZ0NGZEFqQzdU?=
 =?utf-8?B?c3FyeEpkMjhwT1MybytqRjk0ajBHWVJuN0Fid09RQ0o2UUFiVzJNTm14aVdL?=
 =?utf-8?B?ZkM2Qlh4TFJCK1VOSEplT1hvcHdPbTJlMW5Hd0M2U291QngycmhuSFdUVm5Z?=
 =?utf-8?B?OXFDNG1rdWR2M1VoTDluSG4rdVNiNTFITVJQWnVpcjBjbEQ1MkY2NU1HWUNL?=
 =?utf-8?B?eUdSejFMUzlEUXh4U3J2NVJyU1JKcy9UNXFOQVUzZlI5NlgwekpJZml0Nmxi?=
 =?utf-8?B?aHZUU25hOXV0SnlZKzR1RmdxYTdiQWk5M1hYTTVMdHZrRS8vbDlZSHhINXFM?=
 =?utf-8?B?QWlZSmlER2FrUURWWTY1eXNtR01xd2wxWnY2YTRBUmFiM3VSbVpGM2FuMUpz?=
 =?utf-8?B?MU9kMmpneGw1ZTI3cVBEbEdGQ2pwSzZJcms5bzRKbTNmdkRUcUJPbUI2c1V5?=
 =?utf-8?B?eGtBRnFDbXRwMXQxY09aaWRWbGNOb3JzdE5sUFNNdWZxTSsxTzQ2YTdNeDJI?=
 =?utf-8?B?dTE0ajQrSE1qb3RXL0JVREJMdWhsU2FwRmhNWUl6NW5zNUp3OUxUWkplc2dK?=
 =?utf-8?B?a1Y4aGZLUkIyMFo0elBPRVZ4UkxhdnhHSkdMUm83RUl4UlF2R1NDb3didjJR?=
 =?utf-8?B?Rzl3cDdndWk5OXJUVXJhUzd0S3BYc1JzRGswWGdad2UwazBvOHVOdXY0RkFy?=
 =?utf-8?B?OUhTRVZkTEp3bG5lTnU1bWpZQ3k0bDFFSzI0d0F1NHcrb3Njd2JvcmYxODdo?=
 =?utf-8?B?Z1dxQXVHRDEvWnpLM3ZZS0ErYTl6UjAzN1BvQURVU0RKVitUaXJPcmdxaHBF?=
 =?utf-8?B?azB6M3RYaXlvYlB4SEZEZmw4dWZVNGRta0drdm1TdmFNcXlOZkZOYmRIRDBQ?=
 =?utf-8?B?QmJTRlZMRjdHMXFLM0xnUVIyaG5jd2pac2tYNlNBa0d0aHNaaVJ3UzhBUXdJ?=
 =?utf-8?B?ejZ5eXZqUndZVWcwNFlSVUNNbG9SSGtaNzNVdGo0VHlpR3J4Q0hNSkYwNXlv?=
 =?utf-8?B?UlVvTEYyeWhhb1JKZUY5NVRYWW5MSjhUL1l4UEZURUtGY3duU3gwd1RDNnJx?=
 =?utf-8?B?UEg2WUZMTG5acUVQSytoamNWbkNvZjJPL1pxbVI2SSszZU1uT1ZNV2xVNWta?=
 =?utf-8?B?NG1qQ3A0NS9pWkxLbmpIZFFOaW9mYzl4U0UxeS9NTEFxMjQ3bFgzKzZIRnQy?=
 =?utf-8?Q?ZG4AfsynjOhzKfctAJeJduSjgLSv78bIjGBzz6K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23e951e-2331-4c18-79c6-08d9731e4150
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 23:13:23.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrQ0F3mjg7LtGjf/lR+AaDbz8q0SPWCC7P3X8rvMzfZfwbc06LyAsjDeTuCHCE+IRILk5JfWVHF5BTU8FwqeIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5456
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080144
X-Proofpoint-ORIG-GUID: q_CZjxJXI03qDIzNeZoIq7HrQwer__eD
X-Proofpoint-GUID: q_CZjxJXI03qDIzNeZoIq7HrQwer__eD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 11:59 PM, yaozhenguo wrote:
> We can specify the number of hugepages to allocate at boot. But the
> hugepages is balanced in all nodes at present. In some scenarios,
> we only need hugepages in one node. For example: DPDK needs hugepages
> which is in the same node as NIC. if DPDK needs four hugepages of 1G
> size in node1 and system has 16 numa nodes. We must reserve 64 hugepages
> in kernel cmdline. But, only four hugepages are used. The others should
> be free after boot.If the system memory is low(for example: 64G), it will
                    ^ add space after . please
> be an impossible task. So, extend hugepages kernel parameter to specify
> node number of hugepages to allocate at boot.
> For example add following parameter:
> 
> hugepagesz=1G hugepages=0:1,1:3
> 
> It will allocate 1 hugepages in node0 and 3 hugepages in node1.
> 
> Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>

Thank you for continuing to work this!  This kernel command line parsing
code is tricky, and there is still something missing in your changes.
I also added some suggestions to change working of documentation.

> ---
> v3:	1. Skip gigantic hugepages allocation if hugetlb_cma is enabled.
> 	2. Fix wrong behavior for parameter: hugepagesz=2M hugepages=2 hugepages=5.
> 	3. Update hugetlbpage.rst.
> 	4. Fix side effects which v2 brings in.
> 	5. add cond_resched in hugetlb_hstate_alloc_pages_onenode.
> ---
>  .../admin-guide/kernel-parameters.txt         |   8 +-
>  Documentation/admin-guide/mm/hugetlbpage.rst  |  12 +-
>  include/linux/hugetlb.h                       |   1 +
>  mm/hugetlb.c                                  | 116 ++++++++++++++++--
>  4 files changed, 126 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdb22006f..64a128924 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1588,9 +1588,11 @@
>  			the number of pages of hugepagesz to be allocated.
>  			If this is the first HugeTLB parameter on the command
>  			line, it specifies the number of pages to allocate for
> -			the default huge page size.  See also
> -			Documentation/admin-guide/mm/hugetlbpage.rst.
> -			Format: <integer>
> +			the default huge page size. If using node format, It
> +			specifies numbers of hugepage in a specific node.

Perhaps rewrite as?
			the default huge page size. If using node format, the
			number of pages to allocate per-node can be specified.  

> +			See also Documentation/admin-guide/mm/hugetlbpage.rst.
> +			Format: <integer> or (node format)
> +				<node>:<numbers>[,<node>:<numbers>]

Perhaps node format should be written as?
				<node>:<integer>[,<node>:<integer>]

>  
>  	hugepagesz=
>  			[HW] The size of the HugeTLB pages.  This is used in
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 8abaeb144..bc5f674ff 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -128,7 +128,9 @@ hugepages
>  	implicitly specifies the number of huge pages of default size to
>  	allocate.  If the number of huge pages of default size is implicitly
>  	specified, it can not be overwritten by a hugepagesz,hugepages
> -	parameter pair for the default size.
> +	parameter pair for the default size. This parameter also has node
> +	format. It specifies numbers of hugepage in a specific node when
> +	using node format.

Perhaps rewrite as?

	parameter pair for the default size. This parameter also has a
	node format.  The node format specifies the number of huge pages
	to allocate on specific nodes.
>  
>  	For example, on an architecture with 2M default huge page size::
>  
> @@ -138,6 +140,14 @@ hugepages
>  	indicating that the hugepages=512 parameter is ignored.  If a hugepages
>  	parameter is preceded by an invalid hugepagesz parameter, it will
>  	be ignored.
> +
> +	Node format example::
> +
> +		hugepagesz=2M hugepages=0:1,1:2
> +
> +	It will allocate 1 2M hugepages in node0 and 2 2M hugepages in node1.
> +	If the node number exceeds the maximum node, the parameter will be
> +	ignored.

Perhaps rewrite as?

	It will allocate 1 2M hugepage on node0 and 2 2M hugepages on node1.
	If the node number is invalid,  the parameter will be ignored.

>  default_hugepagesz
>  	Specify the default huge page size.  This parameter can
>  	only be specified once on the command line.  default_hugepagesz can
<snip>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
<snip>
> @@ -3580,6 +3641,10 @@ static int __init hugetlb_init(void)
>  				default_hstate_max_huge_pages;
>  		}
>  	}
> +	for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++)
> +		if (default_hugepages_in_node[i] > 0)
> +			default_hstate.max_huge_pages_node[i] =
> +					default_hugepages_in_node[i];

Logic like the above for loop also needs to be added to the routine
default_hugepagesz_setup.  See the code block starting with:

	if (default_hstate_max_huge_pages) {

The kernel command line parameters,
	hugepages=0:1,1:3 default_hugepagesz=1G

should allocate 1 1G page on node 0 and 3 1G pages on node 1.  With this
patch it will allocate 2 1G pages on node 0 and 2 1G pages on node 1.
-- 
Mike Kravetz
