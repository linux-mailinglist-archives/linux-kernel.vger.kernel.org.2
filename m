Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA21E32AE50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838119AbhCBXEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 18:04:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37674 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360382AbhCBWTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:19:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122M4VxQ088896;
        Tue, 2 Mar 2021 22:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5ojvwrGmW9ZtAzsjvR3BbRHrLa9vA3r1TEXYbBgTTmA=;
 b=gvCm2emchVCYHYX5Rts3rpzwCWOcWuYJBKBWdwe+bpsj/1fqn+OxdckecFb+FHPwGKiE
 3XufpJ1Q3iASVgjCYRN2lZg0ztDhhqBk6DjOUj6kTqsZ9rZwORSv5aibeOD4SjOB/u6W
 K35jCWvSOpQB8BtPHgclr03WmUkjai1EzVPA8OhEBasxvfd4JuN0AAVU6fA/WbNO7iA/
 BiHejHbz8gt9YX0NanrLPHalESiDxmPrVb9hPfE0aEYI2hlmQgIAeUUlRXsuu5/fkrzy
 UEgimqEdRUlSkFaL4EawsImSEp06ECHTK3GLZHJE4+s2SIpIvWMf6Qib7PBzrZQod8wc Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36ye1m9cbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 22:18:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122M5Eh4084780;
        Tue, 2 Mar 2021 22:18:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3030.oracle.com with ESMTP id 37000xmhs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 22:18:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiqhYicwhQmGEaO1d9+rYcaj1mbvqp+rD/XTO+4Sif0UNkWIVPgXn6+6gzJOkUldggDzEivP6lFiqoPJh76ni6YNArtLQGKW0BrFAzVgDA4rlej5Db5+ZiJaB0Q0tQxGzEVkyjp2ap5JbkVh7LvmqQnrpwthZFsnB3NHiCRpjfAHkROTVwd4H8bE+7e3PeQLYbJDBP3a46djte9LE+CPjQs9nXuKNmwPgzk5lwe23k7kmL2g1/Jr3Vv9wBffXAjmr8tnZ9AHX9Xw+1e6Zvsbo+jGkAQnbS8DEs2lZHKn+eaELXIM3pXeKCt4gFyKzQeFUS/NDpYdAb8sLVfMbFFh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ojvwrGmW9ZtAzsjvR3BbRHrLa9vA3r1TEXYbBgTTmA=;
 b=P/atbTwEXHjwd+JwzW53jzC+TJBuMpC4pWJeZahLWfxNyrhhtBxoh9Egj128DOF3WVIfSRgd0ZBZ1pEui1SO3hkrtVxZ98F18f4Te1KHAgHsBTdLedVHwKu636Tf/dxowOdAZlW8YWBEmkEcPlNGTiHkRoataKYLvKk/VVnm7s4IpNsZfoa1i0umR9NXqodfc4KtQxKBNBIaSe5YS2WiUzC1Y1EujVWKVBkXvLM8hYO+I2h2XO7YpNGJnyb34shE1CjocXf4fS6BHPk9bioeSP9gXuWPtsmllxd1K3O5BLbnyzV52ZPgsLICF+QjVqttoNrKvV1SM2GirjoF1/JxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ojvwrGmW9ZtAzsjvR3BbRHrLa9vA3r1TEXYbBgTTmA=;
 b=LKfvPCesewvvOvRcC5zoJO5P1fbujY0L2aKTKbb8QWogjgVjtqX9kS4L7VhUmGIPnWxgOeX3bXkVo/eoK/e+OYpeKJXXTEgQEs0cw6xte0J7JeRVFLlatYpI3VqFOFPDyQ62EUIolGlLnVodT64hlXHY+Dsm2qJjLLNg8BCLqhY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3159.namprd10.prod.outlook.com (2603:10b6:a03:153::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 22:18:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.017; Tue, 2 Mar 2021
 22:18:55 +0000
Subject: Re: [PATCH] mm/hugetlb: use some helper functions to cleanup code
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210210065346.21958-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8fe08844-3f03-539b-a442-580b7b258f5e@oracle.com>
Date:   Tue, 2 Mar 2021 14:18:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210210065346.21958-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR17CA0080.namprd17.prod.outlook.com
 (2603:10b6:300:c2::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR17CA0080.namprd17.prod.outlook.com (2603:10b6:300:c2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 22:18:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fa93414-7886-470f-960f-08d8ddc92af6
X-MS-TrafficTypeDiagnostic: BYAPR10MB3159:
X-Microsoft-Antispam-PRVS: <BYAPR10MB31594D0E8B244AAD379A9422E2999@BYAPR10MB3159.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMlrOx0l16OQpvlMbMpG5q2oMX19AEl3DYHy9WH2GtH65+UKwuKtA/8hA5SRqMqDem53bKJE2JrokedOwy0supXi5VcW3pCvgwU1qaHYI5fcXySJo/nDlFC16yjReRodvqbISkLyBkRz5bPpgbkfaBuJF27o8VS2ldJg/wXCAQ9amC1OP9qD13up4BdsvJEcSChVEAE/zxQnE0WZEqwT4281+c7SCDM6RvupkkjXAogWLcJidfinW7OsxhujkMFUd8gXjXSLlcSmli0NZsjcShFpy2+SzM8rctpGyHMt8FVsGby5EtNRBrmNoamC/X1GgPxCSvcRc1tn7npzAiWI38rycHYoHTfq2pYFgqIKdiMT5O7mpbbZFkx+uNGk8yG/dqL1w04B9uCqhiLK4LCr3wFH/I61QVvE+ZmYQwK3UQuM6Xgp/xYWBDjVhSErB1XZ1oxpTCNJMxIw5xjC7AiQuf7gNKDYcFA1JArbALmLJ2IVEru/L4LAqe9qCuSDlNqPJe1zpOmv1Ro0DLwf75YDxO/XF3235ASV09iC89hKXnMdEa1wXH2UROAbTH2BsJT6op0k0m4SdVU3WrVjiJFC7bZVib1dJVM83nXhTPQaWPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(136003)(376002)(53546011)(36756003)(83380400001)(52116002)(186003)(16576012)(316002)(16526019)(26005)(44832011)(5660300002)(8676002)(66556008)(66476007)(956004)(2616005)(6486002)(478600001)(4326008)(86362001)(31696002)(2906002)(31686004)(8936002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?REhibWVLWUQ4R0Vka1lScGpXU1FNUGR1SStINDV1ckxkclFiNjd4T1o0SUJD?=
 =?utf-8?B?OTNYT3RvcDV4MjE3dzlScXBGTWptZThZVzNqek5BbC9zOU9JZ1dPUFNSWmJY?=
 =?utf-8?B?ejU4eUFYR1B6NGx6a3ZUOVQ3MU9YbWdKa2QzUEExemZLQlEzSzNoS0FYUUdR?=
 =?utf-8?B?SUZST0hvU2MzUDdyUFMzMkQvUnJtWjlQbzN4bkR3aHdyeEhZazNxY0pLaU9w?=
 =?utf-8?B?U3p5dXltblJza0pxa0VsRGMzM3ErZm9Xbk9zZlE0MVVtVnZlR2pheEJiL05Y?=
 =?utf-8?B?a3IxUG1lVTl0TGt0bXVIcTJZQmZZM3FsVGE2Zy9Cd0ZhdjluMWo1SzBvT3FD?=
 =?utf-8?B?Z0VJQVFXVVBXR0NzcUZZWnRaQlpTSU42YmtUNW53UHY0QTNxK1ZRMmVkQUk5?=
 =?utf-8?B?dlo4bjRIbWR0dW5yM05iVzVOeGxqNHZlb2xEVkdxRllIUERJYmFZTHlmOUxK?=
 =?utf-8?B?UDBqK3QyVGN1VFZya0N2eXV6SzVmN2RKTHNvamYrd0NQZGV1akYrazd0MytC?=
 =?utf-8?B?RVluR012THBOSTFQU24rZkRUYTNsSkN2RUVXK0tqMzFHK1h6dHNKeVl3U21N?=
 =?utf-8?B?TnA0eUxDd3JiQklvMUl5MHgzbUdOY3lqRXh4dTlPdjVSTk92a0ZaeWNBV0M4?=
 =?utf-8?B?L0huaXVoK0tDQ1JReFZObXdYV1Zhbk9DNHdOOUxSVDljR3h1Sk1aOC9Oa3B0?=
 =?utf-8?B?VVBKbUtxSkdUVHBRU1cxVzFFak1aaVdwS3E5OHcwbjlLZXJiY29oMG5KWXNG?=
 =?utf-8?B?VmRUdlJEa2hmQjE2U2JacFV1ZHQ0S0IvZjJjZloyYzZJdDkvdk9yN3RzR2VY?=
 =?utf-8?B?NWhNT0h5MkZXZ1UrSlF3b3gzWW01cjdTaC9JbmFMZm82L1hZV2JvK01USU1u?=
 =?utf-8?B?OVVZdFdEWnhnTkt6RVVocHBIdG5QV1dOYW5CVmI1K1N2SjF5M2gyaXkxNFRk?=
 =?utf-8?B?dGVlQ2RDVWJLcFJOVGVGTTF4TTN4UHlkeVFmaXQwTWo0KzRhMytqcjZkOThC?=
 =?utf-8?B?OXFzdkdWQzkwTHpTSG4vbzRsSzN2eUpIa1N5NUpsaGxoamlBdWEvNUdMbjNW?=
 =?utf-8?B?bjBKaHVFNS9IWFoxNk00U0FIQmRFaWR4UEF2TzVTRm1JZVk3enNVV0l5SVc3?=
 =?utf-8?B?aHBZeXFKU0hWdnJGR0RESTY3cGx1cGhOMkNVMFVCbVl4b29LUU4xL2Q5amVi?=
 =?utf-8?B?RzNIVzFwUGMvdmhiT09FZnE3UUJweGhZY3V2c1M5T1plVG5EQk0wOWlXaEIy?=
 =?utf-8?B?UTlINnJTMGFrdng2anErVG50WTE0L3hycExmUDBDREptNElFMnlORzUzNjkz?=
 =?utf-8?B?R3RqWmRsakhZYTNZS1h1Z1lqaGhERjdLaVNKT3dTYzB0S1NZYzJIb0FSYU1l?=
 =?utf-8?B?WThoaTB1UTRFQ2hvSVFOVVpOZzRNYm1PblRoaDNCZzhqVStCZ1J6SjQzKzRI?=
 =?utf-8?B?TFZnSHp1Y2ZYeGl6azBqNUdFK3JJSkh4NXFjZmhEZ3d5MzJidGtTUHZpRzJS?=
 =?utf-8?B?d0dEOUw2SzNCUlg0T3NNTlBBSDRydlVnRGF1K3NTV2tId2thT1A4M1VwNmxP?=
 =?utf-8?B?c0pGclo3bHZJNDdsU2pVVytlQlliYzNlZGdPaUVESjIvTW51cVNaSXBvYXB0?=
 =?utf-8?B?dDlGVUNNV2EvN3FZZHgyTnljdU01bkkxbXdJMXZJMFdHLzBJakQ5elpIV0E4?=
 =?utf-8?B?UzJXVUlJYVAzZEs4Q2FJVktWUWpwSkhCRDNGelhPaVZrVFJ5WFJnSk01dTYw?=
 =?utf-8?Q?WQYrkEUBV5MEc8raSAczzIbZAPdk0+YIKoO7Gy1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa93414-7886-470f-960f-08d8ddc92af6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 22:18:55.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsG8hRd28KukYdGSSHk8H4I9FBMButyiGt77KqeVWb9e5LlWhgyratK4j4CrcEjzTc6NTsMNIlHGLGmeVAkzZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3159
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020165
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 10:53 PM, Miaohe Lin wrote:
> We could use pages_per_huge_page to get the number of pages per hugepage,
> use get_hstate_idx to calculate hstate index, and use hstate_is_gigantic
> to check if a hstate is gigantic to make code more succinct.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

These are all straight forward substitutions of open coded calculations
with the appropriate helper routine.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> ---
>  fs/hugetlbfs/inode.c | 2 +-
>  mm/hugetlb.c         | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 701c82c36138..c262566f7c5d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1435,7 +1435,7 @@ static int get_hstate_idx(int page_size_log)
>  
>  	if (!h)
>  		return -1;
> -	return h - hstates;
> +	return hstate_index(h);
>  }
>  
>  /*
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8f6c98096476..da347047ea10 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1271,7 +1271,7 @@ static void free_gigantic_page(struct page *page, unsigned int order)
>  static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>  		int nid, nodemask_t *nodemask)
>  {
> -	unsigned long nr_pages = 1UL << huge_page_order(h);
> +	unsigned long nr_pages = pages_per_huge_page(h);
>  	if (nid == NUMA_NO_NODE)
>  		nid = numa_mem_id();
>  
> @@ -3262,10 +3262,10 @@ static int __init hugepages_setup(char *s)
>  
>  	/*
>  	 * Global state is always initialized later in hugetlb_init.
> -	 * But we need to allocate >= MAX_ORDER hstates here early to still
> +	 * But we need to allocate gigantic hstates here early to still
>  	 * use the bootmem allocator.
>  	 */
> -	if (hugetlb_max_hstate && parsed_hstate->order >= MAX_ORDER)
> +	if (hugetlb_max_hstate && hstate_is_gigantic(parsed_hstate))
>  		hugetlb_hstate_alloc_pages(parsed_hstate);
>  
>  	last_mhp = mhp;
> 
