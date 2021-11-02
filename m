Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417024435AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhKBSjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:39:51 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:22560
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235022AbhKBSju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:39:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyshSSjkRCWkLXqDLyVBaL2cunJnfmLsjaye2xTt+IsnAcgqpo+9zY4IGOJU6a1jncR5e191rMvfRs4bg7p/LrHmclTHN9nEdtGTaH5AkObTWirHvHxpKPmrdzM75A/5AOSWooONdHTYZlNmlwvZzTSiapxKatNNw++rVXSe2ITVGZwPrLt2z5vVKYx/iFLgpBLLutBFuTETzcvgQc6zE2SZbYUp7yhfeSos1xBfeePrkdnmBSCnV68MTLowwQO0V9EByHUh1OTtAquTJKfJhHOHDTNMa2r/Dfov92ITjGu+IZeVeoZzre9v2YdqtyAlL+he8Fa7RqUorhXi+4q3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJ1G7SBYO0k5QJxOmWdZ4wKquzhC9UGZAOayu4nV1bc=;
 b=NDLW9+Y1aTuw3jal6iVgCwQm0q4TBzTn0I/GU6v7PHjc+kWYwVVMx5m8vRqsmQeuC+z1YZNd5zQwTmVPEWcLJU/uWdKspaerS5PpzaNsoHnI21d93GZPNQsG6JH4xK380578IFXrXysrgPyOjh3hbhPUXlfCo4okepyj4Afmxsih1DfVrBhkaVsI/UMpwRuHtXwAAzHyHrAqS7KaCtnPqjGE0gPMQlg/ue1IOIg4fR+QcsgpjAWk7nX4KcTKDo+qdH1IQhWR1pw4NxjdvHAhF1BZRyu64oQQ8TEAeTJTii9yvzX78z65MYhcZrCQi+rPMFxLlFdAmMGnG3009i13Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ1G7SBYO0k5QJxOmWdZ4wKquzhC9UGZAOayu4nV1bc=;
 b=LX6Z5NApML8F57sWUJIBJVxkgSF4Bq+ml/E6Gh6tqartcgl/eGrJEj7M7S0VY0hOFWt4oXzjtmBQ3tg4fsXKypzTobSyZYyoIafijfXJYonXaXMYuemLblCS4cRlEpm/k0goe4sX4MGgJWnH6Hs5BA1EchO9cLnRNVpEmev83oZGfdhHr12Kl5uyxDG44ZDGqnAJKsrpDNix7hjVLspb+R4cnDoNl6NlszIeOHL5n21gXezjftc1ImVPvWos7ede3SOTmZi4TZK+KR8bMJo8RmmgWR5Ot6OaVImbys8MokJDtT6qi9ELsIPDFMgxuhxxJOVUA8DhZIvDp2321o6WwA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Tue, 2 Nov
 2021 18:37:12 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%4]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 18:37:13 +0000
Message-ID: <6ba0f3d0-cf93-9fb3-d691-962e1cb65eb4@nvidia.com>
Date:   Tue, 2 Nov 2021 11:37:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] mm, slub: emit the "free" trace report before freeing
 memory in kmem_cache_free()
Content-Language: en-US
To:     Yunfeng Ye <yeyunfeng@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     songmuchun@bytedance.com, willy@infradead.org, wuxu.wu@huawei.com,
        Hewenliang <hewenliang4@huawei.com>
References: <a6824ebe-a0ad-fedb-ada3-c362f9c8f363@huawei.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <a6824ebe-a0ad-fedb-ada3-c362f9c8f363@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.57.12] (216.228.112.21) by SJ0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:a03:338::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Tue, 2 Nov 2021 18:37:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d9b8d31-72ef-4919-a89b-08d99e2fc952
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3189207BEAD8C328C3703AA5A88B9@BYAPR12MB3189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrosMo9BRMPt/PWIOetCmToVvOdueLgeKxws5IGnRW3GbrOzknZTN0lDNowV18PgdPwa65R9gd17NBcgtucQ6FAi6QhDC7CueG16//ids2xKzdxYGlUC5GPXr3VNav8T3tB7QY9FxDOrs0YqvA44mYGyE5HWD31/jauEyPpgQy10lYvgyqoEYDTs2EERJgI3Jw2aYk0UiDWadjSjqjKuKC2k1zFU/Ht4+jtkqxjxfER3cgc098u1b8MRYUd2VlCY8LrfWGVmUkkLcFL5S4GyIZKcTwYQ3QcYdudUGpRMztblfia2+J+pD2hr3epcjwkDR/SCDM3BzKZAfjejN+kOmuOd7/0ShCcuk4uTyGZQNKIG5xJP2KOI3Mxozqc/hvVi925ZvpI/qFF6LrARm5rWn6uzbPgvvDCTNwk7Guty0K1j0gJGg/6FyVI9oMK8VtBp+nCbwQ/eenzjFGrjVVDvRUkS4pnTzacGB8P8b8ROx3aae49r9tIsIFgg+I9QJT2nNMOFqMlJ7cBe2UazyEUc/WxVvf4MoqoLEVEBO0TpVmNxGQbWs1F1ascBfbXeorrHuLN8iy7lhK3mhIjjLRfCHZfQrfTy2Xa89bMdfAEx50pGETgDz50EIQX18kfNK9NJH7JUI/QTYDLQQUo4TQbpoJ5g+qA1vMyCd0iMPIHvniQJVE2fic8ToJec98N3D7T4zfIaSn45lmWW23eOj36ICvo8XRtJ4YXxqCHrRM3ePDmX/PN+wNMSftOGUezmC7AY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(38100700002)(36756003)(110136005)(8676002)(4326008)(16576012)(316002)(2906002)(53546011)(31686004)(66556008)(6486002)(26005)(956004)(86362001)(66946007)(8936002)(66476007)(83380400001)(5660300002)(31696002)(186003)(508600001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZ3QUFDVTNaMW9QRUhzeG1SckZuK0ZPZlZYbDdxRC9zTExxUTdKWkhCdjBT?=
 =?utf-8?B?ZWFndDBMbTM0VU1NUHBwcUgvQm9nWFIwY25NMnpEMktSN1p0VElzSlM0SXFJ?=
 =?utf-8?B?bzNFcnM1ZVhYMTNOQ1hWRktrMnJpUlMzeWpzdGNEU0tZN0ZIL1JneVJIMzNj?=
 =?utf-8?B?UkdyUHVkZVVORC8vOXBtclZxTkxST2RwaEZIaytjRERNVk9hZDFpTVV5bzFM?=
 =?utf-8?B?TktaNkNjMTk2RWpNdXJ5ZnBuWnZLMHIyZGpJT0RWaStOS3FEMjZGREVpSDdY?=
 =?utf-8?B?Q2JkakpBcE9sckxXdGpodkxzSEdycXlOODZFcHRvZWN4NDN5NjRUY2FoTlRx?=
 =?utf-8?B?TGZmS0RhbW10aWhRaDM4cWZPQmNYR1NGYkdoRDBzV0c3dWJ4UU4yUVc4bGEy?=
 =?utf-8?B?RWF1ZnZQSmZndHc3ZzBlMXVIMHZSRTZxUlp6cnJDMHEyekpCcXVFNk1pU0RZ?=
 =?utf-8?B?ODNIenNET1V3djAvV1Jab2hXdXpmN015RGtpNkNVNUFGeUJYUkhSWGtBWjBL?=
 =?utf-8?B?c0l4b2d1N0MrQjIzUzlMRlV1a0lxNlNzN2tGY1FnTzhlSTVoN28wUkxzS0pR?=
 =?utf-8?B?eDFDdFkzdjhGUGlQZTUyTm1VakFBcTUrRlpxZCtPN2RBK2JvalhzdU1IT3Mr?=
 =?utf-8?B?eFEzbndVVFN4a2JwcjFhdThab3YwanV5V241R0swajZjaGxqbE9wTmFnb3gr?=
 =?utf-8?B?UTVUaG44NnlLUCsyQU9scm5GVmc3djVBeDE2Z25qUTRaeUNCUTRPVy91cU94?=
 =?utf-8?B?cXN1V2xrbkhwRDY3d3QzYVl1S3Q5YTEwbnFoSWtsdVQ0MDRXQ1lrR1FSN1N5?=
 =?utf-8?B?d3hOaDhhbG1kS2g2ZkJ3QlVablR2NkxCZXdYbXlTRVNjZjVKNWZkZTIzZXZ3?=
 =?utf-8?B?MkFjcWpvSnZmNVBjMkRQY2E1STE0MjU5Q0ZrOFM1Rnp1c2R1K0ZBclZDQW8r?=
 =?utf-8?B?YXA0MkY1cGppZitwTFBwa0V6bjhjblJwTmxSdUVtc0lLdlo3bDlpU2oxam4r?=
 =?utf-8?B?SGxITDhvZll1UUNqblFZTHkrYzlseHRraWRYdldUYThmK2RUU3dneVBtcW9B?=
 =?utf-8?B?aXd5cjVTdUtTZjJGREZGb2dML0NFdkJxVmJCRmw2akp1YUlZTW81Uk5IZEVa?=
 =?utf-8?B?cDAyMm5WMkpqQWsyTmh2VDl6UmpiQ1lqVFhkajNhNHpoWGIvbnV0bnV4eGFQ?=
 =?utf-8?B?OFF4cVU0MzVsaVJhMi9LWTZVRHcvTXMzdTFUNk9ySkdFV0R3K0xPeDNNTGYz?=
 =?utf-8?B?VFNvbU1acDkyczRrc3lETVFCNVRaZmxYaUdCT1VPWHFMbHdsNkZkSndCQXdB?=
 =?utf-8?B?WGtpek1MMWU0dmFReGwvUHBRRloyYWN0WTVvOWVnYVJlM1MzWnFoeVBueGk1?=
 =?utf-8?B?WHBZanVoQlRnZTA0U01WM2xSVS8xNG9kV1RyazB0SVhkYnlxajJaV3dHOGcr?=
 =?utf-8?B?QWxUdzBScmVCNHJaaW13dDhyYmdRL3hkWk1NL0xxcmxxWm1xOGZaZkRMTGps?=
 =?utf-8?B?VUJGVWtDSmlHdm1BQmdDcDIrZmdxQ2JqeU9EQVJXZnlDWkdyM0d2OEhRRkN5?=
 =?utf-8?B?dG1vYUFNbXpMRE5hQVQ5STVnZ2Q2cmFCcVpRN2puWFJ4NVZIZHRlTTk4N0Ra?=
 =?utf-8?B?TE5ySUlCVzBFeFJ4TXNHd3p6SVdHRDBRQWcwMTJtbm55YWlnKzFMWWtIZmVP?=
 =?utf-8?B?WURIS1k0TWllTTIxWSsxcTVkR0FEM2FvQVJIME9MTHQwRmpqM1IzRGFHTlFx?=
 =?utf-8?B?L05LTXZmRjNFa0tqT1pGN1R6STN0SmhWS2lrYWxrNDBIWG1pL1ZBYk10T1Q0?=
 =?utf-8?B?bnNEU2l6Qkh6MEdRVGRxaEJWYzZVL0VoYS9xOEl4VlFmSkgrVFlOSjYwM21D?=
 =?utf-8?B?OW50Ymx1T2hWY2xBT295TE1MVXhnenJpV09tSndCbno1cXk0TGN6YTMwZzdy?=
 =?utf-8?B?Nkc0ODVZeTdIMjY4bHZseWI4L0Y1Y3l6bjNBdlY2TjBQa3EzUmhVL0RVZ0c5?=
 =?utf-8?B?WTFWaW9lUEwxempwcG82RldjUUtGUGZEUVZxaEpQR1NJc1FwRUZWaWROdng2?=
 =?utf-8?B?OXlvNEVEMExnREdxVW1hZmFNcHNZb0NmL3MySXF3REhweDlBUkY2bWkwTFVj?=
 =?utf-8?B?UWdtZE1uOHZ1NTZnR2xLd3VRcmVwMng5bFF0U0R0L1FGQWpMVjlncDBJU0hJ?=
 =?utf-8?Q?7ak4FEz9r7QV94ioVtvVPo0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9b8d31-72ef-4919-a89b-08d99e2fc952
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:37:12.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dPcy4/vMK8Rca7KgWpY3pBdzu66rnqNUSnkX5ryTGqSZs4xWfL85WDvVoWrNwU9cqFzLoSO7cy2brXR2Iiu/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3189
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/21 04:43, Yunfeng Ye wrote:
> After the memory is freed, it can be immediately allocated by other
> CPUs, before the "free" trace report has been emitted. This causes
> inaccurate traces.
> 
> For example, if the following sequence of events occurs:
> 
>      CPU 0                 CPU 1
> 
>    (1) alloc xxxxxx
>    (2) free  xxxxxx
>                           (3) alloc xxxxxx
>                           (4) free  xxxxxx
> 
> Then they will be inaccurately reported via tracing, so that they appear
> to have happened in this order:
> 
>      CPU 0                 CPU 1
> 
>    (1) alloc xxxxxx
>                           (2) alloc xxxxxx
>    (3) free  xxxxxx
>                           (4) free  xxxxxx
> 
> This makes it look like CPU 1 somehow managed to allocate mmemory that


I see I created a typo for you, sorry about that: s/mmemory/memory/

But anyway, the wording looks good now. Please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> CPU 0 still had allocated for itself.
> 
> In order to avoid this, emit the "free xxxxxx" tracing report just
> before the actual call to free the memory, instead of just after it.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> v1 -> v2:
>   - Modify the description
>   - Add "Reviewed-by"
> 
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

