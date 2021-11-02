Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA116442768
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhKBHFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:05:53 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:52832
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229616AbhKBHFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4alfEhMpmCRqtN448PXMy71pUBw71EiI54/kEphRnVQxoWYdOJlQ8wWMvWdOlhZW+lzWUBYEdpfqn+VPrUwZ7WYh0EAMQ3/51/JnagqBkTErjDbXpz6ib5ODqVuctyWPyubj9g8UQK2pHeKb6S18sJDdk/4StLtnv/xIhRtDovBOd6h+om7ELVTIvGkbeGXW1F+Bx0i6koaGk3YQHm3dS3SASMxHX594oHmGuWoTENF0XpPk9uQfV4LxTAdTtoVSjGpiaqr8JGBcxcLx1CLETGe7Ur9cMviw1v2cjKfKggyD5YVqsu7GipDWtr40gjaHDaN/sG2GEL/mUr5I3IlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/UtYR2bRF51ovAQKrlf1Ked5JXVj4QBIedeuMRM6jM=;
 b=NGcRfY2PHQtoOFtroG0rnHpn6F87ksEb9jGYkevhHvUeih5jFNuWELzqu2l0FrkOIWPcfYN2tKdkFTBMNBW8bxnJuBd1B9KpwKO9UtWq6uDc6vnNkRRGE6cxxDs1ZJBmei+UVTfxnHwIVHVamdSdaPZ8NnZwpuWoy0ad12gpvMICCZGkTrgU78PPQ+azZwkjvKKZ2SvDIbCPBgAS5VczSJD//21e1cgM2N0m1+fpiRjDprunYSO++A8QoqwMNAzx96ukafvpQCNqDu7yU21JRcHkQMhwZRXqaffEygNAqExQ6kvdxPVP5MYFeCMS53bPzlTOPg8kOgwD59DeTt0iPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/UtYR2bRF51ovAQKrlf1Ked5JXVj4QBIedeuMRM6jM=;
 b=jmibL6LVo17JbUwtUhxu3Bmkms7IyVxD46r3wiYjCVSh+2dNW/CkknAlrx/Rg00ROLinBQlr6hQ5aNB3My2l+ySVLc35jh++wWUmXCsSAt0N5lwYuLU8FHYNncMzbQdOly53LFO8O72vsOi48KLlgKZJjb8WMFjoLKn+1sHGm0UkXEJnKIvxTX7fQ5Wnuem3MnFlPirKgvjKEVJlFnl78KtZRnV30kJBOf9kWsIew8UEWLKPnZjFNL+PKthnYnFpLByJBmEpx5igaWDoniL8djzU1Fz/RuMyPqaBmdEHbAkNS2hsDISIAv2Et6kEYTHLKGrar8h7wX3qb2HhXUD++A==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB4696.namprd12.prod.outlook.com (2603:10b6:a03:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 07:03:14 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%4]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 07:03:14 +0000
Message-ID: <df216633-cc14-6c3b-29ed-cdce136402eb@nvidia.com>
Date:   Tue, 2 Nov 2021 00:03:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] mm, slub: place the trace before freeing memory in
 kmem_cache_free()
Content-Language: en-US
To:     Yunfeng Ye <yeyunfeng@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     wuxu.wu@huawei.com, Hewenliang <hewenliang4@huawei.com>
References: <867f6da4-6d38-6435-3fbb-a2a3744029f1@huawei.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <867f6da4-6d38-6435-3fbb-a2a3744029f1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.57.12] (216.228.112.21) by SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Tue, 2 Nov 2021 07:03:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67528f35-eff5-4ae1-a05a-08d99dced6af
X-MS-TrafficTypeDiagnostic: BYAPR12MB4696:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4696CECEB24AE9DBD5C29729A88B9@BYAPR12MB4696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BylqfRvttN8ux0npomci1HhlMoBevxVJNLdfNzHD6g7J2m1mCuFDiJgkJRklOXzogEC8/DNYET3pJoNPnGZhW9UTB5LUlCYZlerm9YaxE17sWEy7mitsiFqdk8ohiDOtsCGIBVx7zQIbjI9LFbdsqmHQ0FG7fuCUalTUAUGN7SIB/iGvu+VByxyPVRjJStOziBamT5scRRBNZN+OJNRH8RaMM7QRRy8RTXT20ZA47G5vUiVUmse3+EVtqRdXCUEgDtRRaN6Zy/Hr28d4ZhCVCdZB1uOv1fBU3QPUY47901VYCwYXR1BsqDgX+Mvgji36xU88mt2u9+sfrwItwERL5d91aGhVIHRxQHV3a7dUzZkZyFJ69dy8jKfjOuaBbfD8UF3N1jlcRIq10j9E/ohAZ3gt4ZRts9T9IezPGe1aDwq9pcaEajY2u3VYBa1AtaRPQuCQ79fIy8CrslmN1nBzrFTPetMDon2bla0v9D/RovpYXwx9b9UtFf1WZLud2zqsobxIsnkXcTWpPk+xf5aZsQWcnkdL0jw4hA8k1iwb53Djl0Sywa/a2jODRmU2moMK5G/4YYzr4rGp1AlCvfhCSF0vLeYkdxTvUbAgQL3EXG0wR7VzL5gj6f2l5LzXimH5A7Eo+D/mDhKDApWZiKKCkyZFR2CC5sg9sGcF802tRIAQGRNQRtohhjFLyhnAMLE7zJLWqMwH2TOwLzC9T2ay2ZYHpKI8j2JO9tJjiYJpGzi482ex/sUwG89VxDHbfGNm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(6486002)(16576012)(8936002)(83380400001)(316002)(31686004)(956004)(38100700002)(186003)(2616005)(31696002)(4326008)(66556008)(7416002)(66946007)(53546011)(2906002)(66476007)(508600001)(36756003)(8676002)(5660300002)(86362001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzN6T242b3V2KzVOZG9CaFFzM3dnclh6TzJTcmRQZFYvWXpTT1EvRi9YMjNP?=
 =?utf-8?B?bjVpL1RKN2VTWHZkZ21uTEdwcTFIMkNpZmo0SnBhVUJ3YjFhV2cvTkxWUG1F?=
 =?utf-8?B?MG1LZkY1ZFJPQnNWRUdzaVQzWkNKWHZ5TC9jVEdCUW5zaFdSajVGOStvd3o3?=
 =?utf-8?B?dlNJVnBxY0ZTajlrOWFPOGczNkJ4eDFVYWE2WG5yTEM0RWg3eEJ3VFNoYlhL?=
 =?utf-8?B?N1J2UTNaWWp2Q0E5NHNydVZFSG1mSy9Hb0hxN2wrTU5TRVh2TURuRFptVkt3?=
 =?utf-8?B?NGtxVVFvaTNJKzFraytLN20vRzZOMWNrMUZISEdUYVVoQ09OS0g4U2tOR1Bn?=
 =?utf-8?B?c0hSTjIyVEdXU3dKNFcxay80ZXdEdTFmNmgxQWJUMmM2MVUrVi9oMlhVMjVN?=
 =?utf-8?B?d3QwTFBqNUZOaitLSWZJYXpUV2wzY0Zwd2kxYXQ5M1F4RXZLNk43S3Y1YW9s?=
 =?utf-8?B?NkpnbEQ2TWI3RE0rQzhwOTY3K2w2dUl1MElHUmFnZDVtNDBMb0lNQVV4bjdt?=
 =?utf-8?B?dVIrdFZrSDl5QXBtbUhYK1RCYzR1cUdIMzFHaG9iV2Q4TDlaK1hNNHZGb3Vn?=
 =?utf-8?B?Wko5VzltSUNNUlEvVGY1VExzd1cwb2I3Uk53MHlNTExTVUFrRFFvWmMrdWRY?=
 =?utf-8?B?T3lRRCtlWjRNT1ZZSVRSeDZLa0dYc2pIK0duSjhScUM5NUVxSDFjQm13WjdU?=
 =?utf-8?B?ZUNmb1IvTG1ZZjc5WkdtOVRsWWJkL3A5TFFDY1ovN0Jjb0hxVXpwUmsyeTRk?=
 =?utf-8?B?c2pnbXFFQTJLUmtMZlNtTThkT09rbHNGOGQ1YW1lSjN5OWlXKy9IdWlYVWw3?=
 =?utf-8?B?bWRQb0lvTVQzOCtxTnVDbjdMTk9kbDFNM3JkOTZmVGU1Ym9CZVBmTTFNYWlZ?=
 =?utf-8?B?NERTZThIRHNKRVJDSS9WdTFJNXpUVm0weWRlZnFKMTNDTHE2KzR6TnY3R3Zy?=
 =?utf-8?B?YmdjN2FkMm8vUDVXNGQ0YU5iRnJLTUJxY0RYWC9kUFhxMjA1M2RzdDNoRVI3?=
 =?utf-8?B?UWRCTXFmTkZ2WitDVGNGclNuaDRjQndZalVmVFpObHlPbU9iK1hVaVhWT0FV?=
 =?utf-8?B?bm52WjUySC9TZW4yZEszWmhNQmRteWZjYnEyY1laTVRhR294VTVwSjlqRVlC?=
 =?utf-8?B?QitXMTB4Rjg4V1JXVVYxYTJFQTJucFJwUFJuMDRKOU44OWpraDhqc3BSOWNB?=
 =?utf-8?B?dEZ0OGI4YTBSeXVuZVBZeU9GYVh2ZmtzNnM3ekFWSGJISTFXYXBLRTROcGhZ?=
 =?utf-8?B?akFaYXJhSHBSL05UTHl6enVIeWxlQTlGUjFJQW9SaWFoSXY0RFhQVFNqU01O?=
 =?utf-8?B?OG02TzI5NElaNTIyZDZuZFp6b3ZJYTFZVGhjUEg0Ui9pZGtNSGpORE5tWlNi?=
 =?utf-8?B?bTh4SUh2bm9ER0FhWXlkRW43M2krMkp1QTdkODMxTi9YNGx1b3ord0hOOU5y?=
 =?utf-8?B?b0xmUXNKNkdNMENNemVSZDQwNlpwd1hrTjMycjdVSElzZ0xKeS9veUhTeWF1?=
 =?utf-8?B?RGY3OVZoMVlMM0k4UHlEcjlkUGs2ZXJEUXVWV05BOFlib0VUUWZYSlU2RlAw?=
 =?utf-8?B?QUl2OUtqcDgwRmVTSTYyYUQydGd0UWNJanFVQ3J1cThEMWZOTzlZWVJvZGdU?=
 =?utf-8?B?VmpJWjRnQ1ZPeUs0TzFMVm1iUFFOSWxUaXoxWGZCQVIxZ1RTZEM5dDlNK3FJ?=
 =?utf-8?B?OHdFblRScjhhMXU3Um5OdUJid1BxKzdjSTg5cG5GMlI3SXdNQ3c0MFlKaitX?=
 =?utf-8?B?RWdGd1VBbFUvVUs4SFAraHljWFk0VGVaYW9UQ29Nb2dUWUVJOWxzZ0dGQmJy?=
 =?utf-8?B?cEhFdEU1TndzbGFFSkkyK3V5ZDFDNUpPclJPSjlxRU9RY29tT2RnN1daQ0w4?=
 =?utf-8?B?bjN3Q3BQOUc2ZmpWLysyZ21nMHJRMDJidGw2eDJGVS92K0FFeDkwaE11cXQr?=
 =?utf-8?B?OVFTTHNGMndDN2ozMkRWQTlXbytjenBYdmkyMUVjNXEzOGE5ajlXUFlqbG83?=
 =?utf-8?B?Z0ZOd3h3RGlBdHdBZHlnM3VYTUsrVmliVmtMNGNsWE1ldzFMejBFbGVnZm9L?=
 =?utf-8?B?RTJERFVEK3FENU5qRzRTTEEzQUg3MGxqZCtyK1pQOXM0bjhlSXo1OVdYcTFx?=
 =?utf-8?B?WnJaZmJZSlZ0R2hMNFpGWDVhOCtHU1ptdjRhdGoreDlSVDRDNHBsSGRxMllE?=
 =?utf-8?Q?/S/35cUouO9RSYY8pk3TeyM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67528f35-eff5-4ae1-a05a-08d99dced6af
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 07:03:14.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPKuHyydLfGRKW56lGIAVuZ16Qg3W/VB8ledVqjGweoro2Wr7s88Gpx0o84egJkvGXY0kkmMKf4tGGn6DiwqtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4696
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/21 03:11, Yunfeng Ye wrote:
> After the memory is freed, it may be allocated by other CPUs and has
> been recorded by trace. So the timing sequence of the memory tracing is
> inaccurate.
> 
> For example, we expect the following timing sequeuce:
> 
>      CPU 0                 CPU 1
> 
>    (1) alloc xxxxxx
>    (2) free  xxxxxx
>                           (3) alloc xxxxxx
>                           (4) free  xxxxxx
> 
> However, the following timing sequence may occur:
> 
>      CPU 0                 CPU 1
> 
>    (1) alloc xxxxxx
>                           (2) alloc xxxxxx
>    (3) free  xxxxxx
>                           (4) free  xxxxxx
> 
> So place the trace before freeing memory in kmem_cache_free().

Hi Yunfeng,

Like Muchun, I had some difficulty with the above description, but
now I think I get it. :)

In order to make it easier for others, how about this wording and subject
line, instead:


mm, slub: emit the "free" trace report before freeing memory in kmem_cache_free()

After the memory is freed, it can be immediately allocated by other
CPUs, before the "free" trace report has been emitted. This causes
inaccurate traces.

For example, if the following sequence of events occurs:

     CPU 0                 CPU 1

   (1) alloc xxxxxx
   (2) free  xxxxxx
                          (3) alloc xxxxxx
                          (4) free  xxxxxx

...then they will be inaccurately reported via tracing, so that they
appear to have happened in this order. This makes it look like CPU 1
somehow managed to allocate mmemory that CPU 0 still had allocated for
itself:

     CPU 0                 CPU 1

   (1) alloc xxxxxx
                          (2) alloc xxxxxx
   (3) free  xxxxxx
                          (4) free  xxxxxx

In order to avoid this, emit the "free xxxxxx" tracing report just
before the actual call to free the memory, instead of just after it.


> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>   mm/slub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 432145d7b4ec..427e62034c3f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3526,8 +3526,8 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>   	s = cache_from_obj(s, x);
>   	if (!s)
>   		return;
> -	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>   	trace_kmem_cache_free(_RET_IP_, x, s->name);
> +	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>   }
>   EXPORT_SYMBOL(kmem_cache_free);
> 

...the diffs seem correct, too, but I'm not exactly a slub reviewer, so
take that for what it's worth.


thanks,
-- 
John Hubbard
NVIDIA
