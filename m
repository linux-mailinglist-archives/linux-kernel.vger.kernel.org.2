Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5E30BE16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhBBMUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:20:51 -0500
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:24928
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229870AbhBBMUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:20:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV3jldPP8eHK65URcHqofdl+ZaEphJ6x6H+qi5uEnFQeYnorOnua01kquex/U86MuCe0j2e3hEatHZ+oORs+nN4YZo2MHK7bI5vFdD68AB70bg4AZ0knGGG37R/72W+WYq8eUKrNKLzGC3sqi3kO0Ea1wmQjdI8X09FP2Pu80nkLJbzZ+t3sPoZgMPwjOJieRlL60fbP66m1/pDcjZbvCWbeXzrDz7RYv85BBwJRltQma4y3w5TvdbQz/BuhM2nEuGxqeE4cWuYoqs7ucscI3kxSNS1VdkYjrhrQBEU4eFghISZEFAHZxfl8juheR7BkmVpGOOd/SilChbR8OyrlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fngGWoq3oSRUdHPwKsQBLiLPjek1pJvSoQNul7CCydY=;
 b=h4RtEk/a+QBlofBpNMB6yfsfAsL/lKdjz2b2pZvJ3DEceJc+lxy1WFavnWu0wSBlDqJnek1/duSTlbiWgWg//MjOv5Zo09SI0TrQKQqsye/sdkjTjmCnBvT63pxZotEUFF2WNEMjFBqX+891mfKw7lRLWmo00M2KPEHLxLikMyKeGjb5o0/SbM9DhODXp65Oh2gNvKETFDJHcxdFkBUA8IECc3T5MSe+FzD9/xl4SToROzzd/+z/x/23t2ojkGOs8GZnWxmhjPosq/mYq3mBtGVO9pikCBMQPtvWURXeGLtnGPO4s9Qv7qdcgYoOcCDxecx4dxje6SfrQvsMfMzODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fngGWoq3oSRUdHPwKsQBLiLPjek1pJvSoQNul7CCydY=;
 b=hirEWarQnvRWgn7FLNZQmlXzbOmevv8IAz9l39GIrW2rXFoAf/JthPfiCofN+yUWV3VVO5mouSHXYWWqYTP05OgXS0lMiUQeXqyBaGaQRNh59zV+O77meKi1yHXWeVf3KDmvUqjISnOks6botBJf/8L5PdXPD/uSIyjBOUgPBd0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB5071.namprd11.prod.outlook.com (2603:10b6:a03:2d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 12:19:56 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4%6]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 12:19:56 +0000
Subject: Re: [PATCH v2] mm/hugetlb: remove redundant check in preparing and
 destroying gigantic page
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210202112002.73170-1-yanfei.xu@windriver.com>
Message-ID: <1d700a57-24dd-7448-1d25-11c3e355f5fe@windriver.com>
Date:   Tue, 2 Feb 2021 20:19:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210202112002.73170-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:202::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.12 via Frontend Transport; Tue, 2 Feb 2021 12:19:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a064af9-8018-40d3-9b56-08d8c774da0b
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5071:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB50714B3E07B31466B8688FAFE4B59@SJ0PR11MB5071.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUrFjV216s5701GmT02hgrGzv6S/vtUbH/90b4BTHRz8VzLJdKczbBKqk+Cq6T+yzJevWns1mYfi7h91YYLIS2qMUNFH6mdU1ao64j3oaJMzVP0rhxYjrY+7TSRq2VbQlxpNh/MprqoN/9jE/wdS7HA3R6Qtbm9jl3DbxrwLtSjOOujbYPIokizdkbdtAaHk5S8RkVRY0BRkAwXvYZS+Qy9TcCJ3GYQ5YYLqIZMuRTErmNmVDMdoxCIFKMoxI2byy7OEmndzCvRemG3Sk1ZFNKNCO7IncIfIVhzOM8VxLm7uMtX5zy7PVdzKhc4bySDUVnwxDTCXrhw3B/gYfGGoh0vSapsMClrR79yuTqlj6JKvzYTIw3Y3y3tBBAqAsf9Ej78On9nLINWO9lFuHC7k3NCh5ODEfFZewcztEMYEBeATdtCFU/GAZle/qx5AX114bTE0S4Af16Wvqs5RqFbUijovIZRihJKhIBpow0iTxXbUsT5HKe7qMbf7+2kLXl79cvs0H1VMtfvfyDxDne6NLqpHavLBzdR1BW/ECdSrRJn5GD3FkD4maD+OXT4mUviZ4DKShSBOsdjcG0BkFa5xkcgIyCFiDAcqXb8xfoO6PkYIwpt+Au605EyoH18JNSgs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(376002)(136003)(346002)(396003)(2616005)(956004)(52116002)(66476007)(66946007)(83380400001)(8676002)(53546011)(16576012)(186003)(4326008)(6486002)(66556008)(36756003)(2906002)(6706004)(26005)(86362001)(8936002)(31686004)(6666004)(5660300002)(6916009)(16526019)(316002)(31696002)(478600001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ekVnT1c3NG9PSUpUQURpRVp2aUJEYzQ0YzA1ZGZaUkpFM293cXZvMmFjeGQ1?=
 =?utf-8?B?QVgxN1RRakh4amZrNFJMRjdxV3VyTjFiRVY1dm40bXp6TFJRbDFoSXgvZ0U2?=
 =?utf-8?B?dEkrUFo5cWdUTjNSSzRzNDRYcXpIaWYvbm1rMHBSOWsyYTJhTUs0eDN1Z0Rn?=
 =?utf-8?B?eVF0bUY5YjlzcUV6Q3hhTklnd2I2TVUwMU8wRVBqNzhYcWJCQ2ZIS2NUTkcx?=
 =?utf-8?B?eU9pOUFDZjhLVmlCZUd3ODRXK1BQSlZJL0xSb0pvMnN5MlpTMlpodDVRVlRi?=
 =?utf-8?B?WHZsOTZmRjkwejcrNXVxRGRYSngxV3hWU1RaWWdKb3poWGEwMmhUQVFnM0lT?=
 =?utf-8?B?dks0QzFSVXhkYTBEWEdxVDNTV28yOENQWC9XM0FzS3dydnhHbXMwL0doUmcw?=
 =?utf-8?B?Q09YTE50Y2VscTBhMnkvVDdaa3VVU09OTlRtVzNVYkNCZGQrV1piRzlWUGRF?=
 =?utf-8?B?c1l1UTBFSHBPRWdSREJ5SW4wakZZcGRrYkJLWFl6SGxLWnV5ai9YVU0zV0Zn?=
 =?utf-8?B?NFFORGl2b2wrcWRmRG8wS3QzNHRaWjlkQVVsa0VtRzJoQ1ZoWmROQitzTXB5?=
 =?utf-8?B?VUwxSncxREZCSnczajNHZDNicHlYOGtKay9vRGYySmU5cE8rYUhwL1pwaTdt?=
 =?utf-8?B?ZDIvazVmb2xXa2JDV2YzNHR6N3JvYjRjSGtkbkN4MzdxYkV5MCtmUHNuRWxv?=
 =?utf-8?B?SEw2ZjJ3em1IK21XNTRVdEVQNkVZeHVmcXRTSnB3VTNXdG5BN3NYNGtNY0t2?=
 =?utf-8?B?U2ZoYnY1KytETkJkNSsvQkxzcjVLNWpsd1JkREZNZTlkSUFqT0RmbHJIV2VN?=
 =?utf-8?B?RDVCNG5RSUdlS3FNSjVRNFV0ZkxQSTYrOXFTWjlIKzJnaEVjK1ZwamxiOHBJ?=
 =?utf-8?B?KzBJRzFPK01zOGRJUnlOUTdjY20rVXQxOVhYQ0JlcVQrNXNhcTBydW5DK0I5?=
 =?utf-8?B?c05lbnFNTEVFWDZMZnhGWk9xalZOT29hbGwrOTVZNlhJL2gra2dmdU11MW55?=
 =?utf-8?B?NW1BRUpvUVE4VHJJVTJiUzlDb0RkemZsUjVjNVZnRnpCK3cxdlEvYWlOaEk1?=
 =?utf-8?B?ZGNEU2IrL2NLdG5ZbVZqQ1lobjNjWWtMMUNKRGhEc2hVUzJGWTJKVXRHVncz?=
 =?utf-8?B?RlJlVDA5Sm1QalpMdmRGSXFlaU9zeUJZSW1qRXNnRGRhSkFmdUFjRE1ZeW5K?=
 =?utf-8?B?empiVXdUazNIajgzOHZ5TnUvZE1EczhhamlMZmVYcFlRdjRlVWZEblRUdXJ1?=
 =?utf-8?B?UHJIbit0L3B2cE1SeDdPNzZyWGVrc1kwQmJlRnArRDlTZ3A3YzBWMEdZQzJv?=
 =?utf-8?B?TndZZ0tZL2NRRFcvcEZCWDNxUDA3ZjV4cS93Kyt5ZlpDbnBHY3g5emoxamZY?=
 =?utf-8?B?TFZIbFpoQ1hHd0s5bjFPNFNXcndQRk9uNTg2K0l4aEFqaWRrb3JkMWVxVlVN?=
 =?utf-8?Q?xWf6GZnu?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a064af9-8018-40d3-9b56-08d8c774da0b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 12:19:56.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lechwENTB7nAaZZD7NUM/Ux/xCIQFs7eD0gkJLbvP9/CT3BNYGP9DIYYn1iV+PTPuBpG5tJEvK1s/g0kOSh4cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry for forgetting to add David.
Now add David ：）

Thanks，
Yanfei

On 2/2/21 7:20 PM, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> Gigantic page is a compound page and its order is more than 1.
> Thus it must be available for hpage_pincount. Let's remove the
> redundant check for gigantic page.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>   mm/hugetlb.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a3e4fa2c5e94..dac5db569ccb 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1219,8 +1219,7 @@ static void destroy_compound_gigantic_page(struct page *page,
>   	struct page *p = page + 1;
>   
>   	atomic_set(compound_mapcount_ptr(page), 0);
> -	if (hpage_pincount_available(page))
> -		atomic_set(compound_pincount_ptr(page), 0);
> +	atomic_set(compound_pincount_ptr(page), 0);
>   
>   	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>   		clear_compound_head(p);
> @@ -1501,9 +1500,7 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order)
>   		set_compound_head(p, page);
>   	}
>   	atomic_set(compound_mapcount_ptr(page), -1);
> -
> -	if (hpage_pincount_available(page))
> -		atomic_set(compound_pincount_ptr(page), 0);
> +	atomic_set(compound_pincount_ptr(page), 0);
>   }
>   
>   /*
> 
