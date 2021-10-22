Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E0343809E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 01:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhJVX36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 19:29:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36788 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230086AbhJVX35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 19:29:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MKwbXc001637;
        Fri, 22 Oct 2021 23:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=quDU/SYc851cDocFw+Vuhb3xVH6Vz1Li5jCoMR8s7X0=;
 b=eAB1x+VmEZ9XWLFa4tev0a04RJtt6q2KF9R1shOxRuhHw0TZYUpfqKEswtuQkpDeoPMs
 p5EBX8sud2EnMB0w/3igK+wPz3FWcv0IAnM7t6QOwzGHBLmv+1ZsGLn6XxwuoPqGNAeW
 qLl5/w7/AgmgIRMiAqFapQ/0qPjUTH71r13AHG7xJHDVwltKoVh9pyQ42REeXsiIt4pc
 tqdGIN1id8zzm/maOGPgL45wX3mV9kbI56YBxe8lJNyAaUi7Jt9xf7dsSp9EqKNuIABP
 QNV5gJ3lurPiM+F1ABLx3o/J88Uql/J1icdDno+mucxZEerKZIk+ysLYb/3Sr89VO+eY eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bunf9cnw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 23:27:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19MNFk46047795;
        Fri, 22 Oct 2021 23:27:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 3bqkv4h890-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 23:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHOHgvRMhSsCpBM2v74VaOycK6hG4qFxfirwt+hgwGOcU9WB783Zvh6WHCVxHrqazBXJFJWdIKLEzrwBoQetEelmkyXxyUmWOHNujpiDQx36beDXYQkhOXCpchsOhWA9P7PWCjFOtZfiSLLV9QlvRHEoDurwKs3JtadjKbOqA70hSk85tEN5hdsRSwd/WaVS82USs73YkDau6kZVF0L/IaWapo+3PdY3lSrP71mUfvRME5rhXBbVLZJ7nrZxYRmXoHHnPWfzjOovpgEvGKU3g/B0syFJUsyWoYAO62bbf9h1Gy+KyW8VGp6I/ptHXkRQsZ4X+5ynZ/rLTqoGINab4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quDU/SYc851cDocFw+Vuhb3xVH6Vz1Li5jCoMR8s7X0=;
 b=X5XYg0/EP+9Q/M39sQ3B+Gk1vXNvv9TIHpX3mCcnUqLZD1FLSR67FPqjkW3JtQFAINc2ndGq4j+DQKzYO1iv8vzbVELKfszSDJW1BJDgfmhjbvvyWdMfsCU4Jp0yJhmU2kBAyw2IS8kN581FPZwCHVd8Y3q/CwKTA06T6E2ynBTYEqik4cVYIwYrGqC9qiy0ZXXCq4LBTq+CtzydCApNqXsXjKuqQlY8xZjSuFkC99JpbZtUYeY1TUZ+lO2j/BBrzV2Xph+R6LYkD5l9ZkhMggq1BmXPnEBsQyPURnnMTyaL1S/lGysStACJwEdcxuc49EtonpTimLU5dZvtPVyZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quDU/SYc851cDocFw+Vuhb3xVH6Vz1Li5jCoMR8s7X0=;
 b=h71PC+DAECt5uI5i8YexTehfg1RUNeaRnkIwkNJgyMxo/n8kmj5rEZIKN8NYLt9UYlASHx6zo8+FwU+5ZEtGAIQXT3dGrHiWwI2WY5NzBMfiryaGYF9CGtkQnEkXBmCv9E762jNJbi0+e4pE9qUbWZu0b69FZO6tH7BLdTHgMJw=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by BYAPR10MB2519.namprd10.prod.outlook.com (2603:10b6:a02:b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 23:27:05 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::8057:9886:f19c:a025]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::8057:9886:f19c:a025%5]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 23:27:05 +0000
Message-ID: <cb85b8a6-b82f-3054-5d76-57af018d6b2a@oracle.com>
Date:   Fri, 22 Oct 2021 16:26:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v2] mm: Optimise put_pages_list()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211007192138.561673-1-willy@infradead.org>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <20211007192138.561673-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:802:20::18) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
Received: from [10.65.154.122] (138.3.200.58) by SN1PR12CA0047.namprd12.prod.outlook.com (2603:10b6:802:20::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 23:27:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb50668b-631f-4663-2a7a-08d995b3759a
X-MS-TrafficTypeDiagnostic: BYAPR10MB2519:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2519DC0FC75E1D99BBC39EE2EC809@BYAPR10MB2519.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iuutip/rjQOUq2A5dvmwv2ZNRvEHZWXrRUXKcyf/29n2fbFrmJTc9XU4fzhBeUSFasIfS2bAHKZA3Gki8+Mzlj0t3zEElPMBwBGX8MMdeT4Rnuk++WTg+1kaThRsanaz0zvPbjwoDz8bnCw4MHdqN5sNErKysg5lHi5Tcm0GkeF5F1hSJPTm1HhosThER0ZOCbYb+mug107YTHDdqWUVrzEI7hS90AR/6I9uLb9bni786RVjOgw8iiXSVoEFtHUEEKUY7aU0cgGzfAEeRykykUjs6OZHXbTB1IKrt82qId1n/L6wiCISyUU1igu7cGXRyYvkqeriOovYu0BPYEBMPwbWpquA48Cehpbd9X/0yfBAV0QOeBtUmWGr1GmkZJM5fFeDBq2sFrRc8NwsbwlJCqa0IrpUIez2iD36ujQPnwGC4wp2BLUHuE9AfHOkV52KxOFVfIl7mxqLqXtL69YNso8iGEwqlOhvB9EDjkAkFNYvvoZSYnBAm5zh4dU14Je/IPDE1N0hTFwNGeg+vtonIcrHVjR/2QGdpxRTP3lilJ87IehtHZFovFIY7ptHOR0YymSF9hpmjpYPVuHo5yaTA7huAAL9PVqCcYqb+ru7+/Wx8r14L14I51NNsBAQDVCo872qU3/5Oi18vE7OCtIkRKwVvJOb7pOaRrpsXP79JjHj+qdIC9bMEsuHpqFkBAb3HG/rXGdZe/kQ01V7S+02QNqr+WTQ+rVpqdbP85lrWyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(508600001)(110136005)(83380400001)(956004)(186003)(26005)(2616005)(316002)(66476007)(6486002)(66946007)(8936002)(16576012)(2906002)(38100700002)(66556008)(8676002)(86362001)(31696002)(53546011)(31686004)(44832011)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1gweGY5dEsyR2YvU3ZmTllVSlVqMVc5UUpXaGgrUEY4N3c5VDVLRVh2dDVF?=
 =?utf-8?B?STZiaWpEcllGbUYrcGZod3NnR1N4dCt6c0FzMUtyY3NGNVNSanF1elJhbjhC?=
 =?utf-8?B?VkMyWTBnWXhvaEpCSnVSbFF0RGdHMlgybk45a1FTcXpSNjEvTmVxVzZqNk4z?=
 =?utf-8?B?ZFhyQm4yWVg5MjlsMVp3b3h0anIxTjU3TWZoUkFWYmUxNW9KNGJsSXA4bjM4?=
 =?utf-8?B?ZXV0RWd1dXhyTG9IRmYvMkhOcjJtdWpLZUlNVGZrUUNjaWt6Njd4bVYvWlZJ?=
 =?utf-8?B?VlhxV3Z2V2VaWWEyVGZ3cjNNZzJxWDlpN21HMGZSblFaSXNnZEVneStxOExJ?=
 =?utf-8?B?RUJjS2tNRDZuaVJiUy9oQ0FxbVppSU5SM0lnUUtBV2luMGFVd1dJUmMvNnBM?=
 =?utf-8?B?UldxVHJmajIrNVJ3T2hVazVzZFVHdWpMQ3NaL0NQK203cFpnZnhYa2RLV01K?=
 =?utf-8?B?d0NRcndUclkvTHZJZGlLVzdwb21KeDhBdHdpdmc4VkFNT2NJdk1mcUEwR25K?=
 =?utf-8?B?dkxiYU02Q01LcTB4eC80aUcwbXF3YnhiYWxhcjMzZ281N0diN0RuZWZJdW9i?=
 =?utf-8?B?NytVbU5UdXhvMXUvNHNwSXdkMnFQdllVcG5OcUtOamdaMytWVXg2K2ZzRVl3?=
 =?utf-8?B?YlJxVUJ3RHNZeTlaSjlOVWxIZ1FDT2VsdUd2QjQ2V3h4Y1AzSjRUZVFLa09X?=
 =?utf-8?B?cXM5eTJyR0xCL2QvN2tqbEV5WnBjZVQwdzl5Q2NzVUZDa0NlZmlTMFg1N2FX?=
 =?utf-8?B?Z0pHbjhoU1Mxd2ZOUnV4Zlc5S2t1dTRraTkyL2d5VHVSRXFtclNLeSs3S0Jn?=
 =?utf-8?B?N01ycWl0b3VGWGhtZnFaR082ZisrNSszQ2JhUS9iRldmVG11RjhlQTJsSjg3?=
 =?utf-8?B?NGxoMGJrWUpadFl2UzBKUEYwOWUwVXIvVEJuUTFTU0h1Y1VuWGk1MDJpUU5L?=
 =?utf-8?B?UXBCZG9SOXJhV0hFNWlNT2ZiVUI1VjVQc1lvcnEzMWVrd1c2K21RdGlKaEc2?=
 =?utf-8?B?VUNEQ1RSL2M5TC9BS2pzdWdWL3VOZ0hzTGZmMUk3TGhPOHhGeTdCcjQrcmxG?=
 =?utf-8?B?aXYvaEs3aTNIdExleHk3b3RKV21WSzhBQm01Y1NMaE9UZm81VHdQVEpWKytk?=
 =?utf-8?B?RkJncEFxN21tdEI2S1JPZ3l3bi9xd1ZVK2JzNk44azBtTmFsYXB3dlhua2Zv?=
 =?utf-8?B?cS8ycDhVS2F1dGh0V1k5OXZCWWIyRS9sS2Ywb2cxWGd0UDVNdUdjMmpsakh6?=
 =?utf-8?B?SmU3Zm93UEptcG5xajlpMGJBLzFnZUlwakZQeENJZmw4YnBRNjhRSDRBRXNn?=
 =?utf-8?B?aWJRbElJazUvSCtva2lQMWRER0t5dnBzQVlyQU9EVTk1b1JzekExcHBKenNs?=
 =?utf-8?B?RUE2Y0VkaTdHbVZhWTMvc3dNOWJVTjZ3Ykk0bW43emhESlhRRldaZUJrVmhv?=
 =?utf-8?B?Qko5WXRQSU11bUUzZG1TOXFKZ1hqMU9OWjJrYzZCYWMvRjhGdnkycEREc2Vp?=
 =?utf-8?B?NXViMnRaeTlHaWQvYkplQXRzcnNGdmR4SUxTaHc3bUZKMFp0MnJCTUFQbVBi?=
 =?utf-8?B?RjRTQVlqQllsZkFzeVpINy9KMEpqcnAyZzlCWXJHMmY4cUtFa25KbThzMmg3?=
 =?utf-8?B?ek5CMGYxakpjMVpUSFRQdW1mUjdzTVBrQzVscE9PM0MyMkV4emxuaTdjRHJx?=
 =?utf-8?B?ODRKN0hhenJtSFZDSEQ2MGdZTTZWemRqR2w0YXhhdlNKZjNwOW1OZzlGWHFt?=
 =?utf-8?B?d25od21RejVTVkxuUmVKTkFFY0xLb1U3MEZLVXYzakRDbmt1dWYwQ1NOeUgv?=
 =?utf-8?B?L2F6UDg5TEE0QlFkdzc4NUJSVkl3YU53ZU5VY0d2TVNTYmY0WUZCdzlxNmcx?=
 =?utf-8?B?ZnRWdWJ2bE92QVRyaXpvd2lSa0Fad0ZydmN2bkVvdVNnZmN4aU9ISCtXUFRp?=
 =?utf-8?Q?IItLSqP3opP4gnOY1IbVXh8uBB2DEN6f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb50668b-631f-4663-2a7a-08d995b3759a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 23:27:05.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anthony.yznaga@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2519
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220132
X-Proofpoint-GUID: h33Z5M4C0-NxyHfn2rwl5qNfh52uA6a-
X-Proofpoint-ORIG-GUID: h33Z5M4C0-NxyHfn2rwl5qNfh52uA6a-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/7/21 12:21 PM, Matthew Wilcox (Oracle) wrote:
> Instead of calling put_page() one page at a time, pop pages off
> the list if their refcount was too high and pass the remainder to
> put_unref_page_list().  This should be a speed improvement, but I have
> no measurements to support that.  Current callers do not care about
> performance, but I hope to add some which do.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2:
>   - Handle compound pages (Mel)
>   - Comment why we don't need to handle PageLRU
>   - Added call to __ClearPageWaiters(), matching that in release_pages()
>
>   mm/swap.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index af3cad4e5378..9f334d503fd2 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -134,18 +134,27 @@ EXPORT_SYMBOL(__put_page);
>    * put_pages_list() - release a list of pages
>    * @pages: list of pages threaded on page->lru
>    *
> - * Release a list of pages which are strung together on page.lru.  Currently
> - * used by read_cache_pages() and related error recovery code.
> + * Release a list of pages which are strung together on page.lru.
>    */
>   void put_pages_list(struct list_head *pages)
>   {
> -	while (!list_empty(pages)) {
> -		struct page *victim;
> +	struct page *page, *next;
>   
> -		victim = lru_to_page(pages);
> -		list_del(&victim->lru);
> -		put_page(victim);
> +	list_for_each_entry_safe(page, next, pages, lru) {
> +		if (!put_page_testzero(page)) {
> +			list_del(&page->lru);
> +			continue;
> +		}


I know that compound pages are not currently passed to put_pages_list(),

but I assume the put_page_testzero() should only be done on the head

page similar to release_pages()?


Anthony

> +		if (PageHead(page)) {
> +			list_del(&page->lru);
> +			__put_compound_page(page);
> +			continue;
> +		}
> +		/* Cannot be PageLRU because it's passed to us using the lru */
> +		__ClearPageWaiters(page);
>   	}
> +
> +	free_unref_page_list(pages);
>   }
>   EXPORT_SYMBOL(put_pages_list);
>   
