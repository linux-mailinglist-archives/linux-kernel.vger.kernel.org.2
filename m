Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55807450615
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhKON4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:56:19 -0500
Received: from mail-co1nam11on2088.outbound.protection.outlook.com ([40.107.220.88]:65121
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232220AbhKONyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:54:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGr5V/XRAgBpBzDym559TvoZrH5VurFQloqHJmfsTeKB0Vtjsc0oXu8Hw6c0myjtGs/tc2QuB8BFaOPnGxsc+N/Hq3pwQbCCwQUwmrPquRl+Qz0R2jJMGb66guL/6i+63k26Tj2mL52cF98g7tlpq4/g1hcZpNfI1w4IXVXaBfN45kiG1MQr+f4oI5wKz0ZQABLXLGZi1CXTfaSoYH90h+VEVzTKpCaBwhCzxMjhwVFH+ByI4wx1H6tJqsb/N8ai3EKCT+ZRCgnriNgZ0W18kPI4rxMMh9N3jQxLHnQ4nJ/TIUdtSE/Yf2Ho8M4/DIDUej/XKPyUB3mWacCIjhcBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuNxtU+KuDFTEo2u6uO9YANlBYocAyR2mju4A7KoYt4=;
 b=BPFSlg2OFOLbz8aitU6zWRu6CnotSFVc1xC3f6xRwKZxL0NJ/lHJd6hAc0y+BErn2vs9rL/yhqTuGkp+A1qKBQo9cajSXh1s4kz1UPxAanVpAfhzJE6VdS7QNN+HKki19fcDIYXU/aVQXtolRULThlS+trSwaPJg2bWQFb/7ejjF1ynm7HsRHhMM9I1g5DnYrDDOhewpK8j8vWNFRt/3+U1N/wYvJbEouJVQ2R9mmiessVeGVzhXG0I+Qy7mBBsnvk1571fXbokTqapDtaKKdzdgO0Svo3qxBC6ewgQdDyYGvCH4sCMcWcFiYN3KXOsHgE11WKXMnMwj4Vv/2MoffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuNxtU+KuDFTEo2u6uO9YANlBYocAyR2mju4A7KoYt4=;
 b=Jw/F9GIhzeHNt7i5LDZpTgddqrrSPhCbNc6j6tjoDinjlnIDWKQGr7bq4jIoCITbX4OmjPQsBVfxGe2bdgv4FySyTcqLaeNgYMhK55pqFxDMFtRWN7gUwXa5cYUSsIgLG4sai3Bb9ePug9O6sjHd+murKG3cmL2Lm88klit5hzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Mon, 15 Nov 2021 13:51:31 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 13:51:31 +0000
Date:   Mon, 15 Nov 2021 21:51:22 +0800
From:   Lang Yu <Lang.Yu@amd.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2] mm/kmemleak: Avoid scanning potential huge holes
Message-ID: <YZJl2nyumpEad9iw@lang-desktop>
References: <20211108140029.721144-1-lang.yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108140029.721144-1-lang.yu@amd.com>
X-ClientProxiedBy: HK2P15301CA0014.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::24) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
Received: from lang-desktop (165.204.134.244) by HK2P15301CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.2 via Frontend Transport; Mon, 15 Nov 2021 13:51:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a79fb7d9-a281-4026-cd21-08d9a83f07a8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4012:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4012195F0F9BAE63F3A5A2E7FB989@DM6PR12MB4012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PjKOPq0ItdEjDpm5LwKJTIM666JeqCFht5eWQFAQ5yOYaQaCscn700hdPzzPr7qj5WMgICuH5kLwICJfkdgwkijmGV2Oneo0i4EB57k0iLtT2hFPAZDeV+7iU/IerMbZQP+aL2MAYjOQr5JcHVoeUzNgDV1TeVdgJGjmNygX8Z7fn1kWK3Yu1SNcdDKczZJsoCGvrSqqIl4BQCDQsxtNeMqBjC8IWe7tzg+bv+6bX+WN30p1MyqSBhjdNrphLVSHFYVyEn9qx24XI6vIbailk5GEkdLM0kd0bFqU5hQMdQY7Tqh0aZPh/PNRKCzyuXRKes3oUOIvNOqPSCjE1L5bwruORAqtKQ7rGlpq1A5BjgPoURf6mpCGpsDFLIbLPjtTTHXOlIJ6HsZY2gpOGjX/kzY9DD/4ktMbTHUhrd7ehR8FE7PzEhkHXMSU4I+JvywVCr8DjslszFHS1oOePPUpVE3OhYb88l6nyTeqLRIQ7vBxAJWp0MmtIdmPRDt4B7Ol5oUFNkY2kvDQSbIkgpYlVTZrFtXo3BrOsM1BLEQ/hpXALu8qQagIItU5tD5iYYsnTC1nu6DHHuju/Dsl8RStE/zMlGJ7Bw52+EL+25DdobN3+4PbB89xCHkXlTfEDOYR7vMH6hH2sAkSaTzHTOjAwAN961wCjkU6a7uZ9pn2QnDSO57Mhv+hcGQnRwk6+0ynQSAClhzESHnNyJlm+TtAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6666004)(4326008)(316002)(66946007)(66476007)(66556008)(83380400001)(6496006)(508600001)(86362001)(9686003)(26005)(33716001)(5660300002)(8936002)(8676002)(38100700002)(54906003)(55016002)(956004)(2906002)(6916009)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92ytHbYthRWFcgd/mAIX+N2PELAHm/tX60JTt2obEaDkxOrU46d/kWJw8/z9?=
 =?us-ascii?Q?Rtlj1tHvbJT1XRfCBwRWczqNbpmvm9Xy/+uxItZbQDNc/IHb2OE37Kj/cbti?=
 =?us-ascii?Q?/aC5UGy8/4V33UUEbk4K0y1xLxMJ+Ovg4idHa5kbrm0CSmOCn4iiGNsvAsLq?=
 =?us-ascii?Q?T0qM2Vjq+zO4+uCs5ozoxKl/xIgr3WUkAA5bWbIaffuKu5vNxPHG5sEzWsSX?=
 =?us-ascii?Q?3mEF2RFcRvEJ2IHQMDFiaXLDtNJy67FT6ASdzida7lbZKDhzX9xXF4Vw1SMF?=
 =?us-ascii?Q?3B1c0WZhmluDUF/qPsa2aKXriMQLjZkgzQ3O8bGMh7Csxj5iGCYVjoTg+5RG?=
 =?us-ascii?Q?e/qqd5PWnbvLd0iTRWUN0umOS2/KxowCLPF/ZHDaPJSsjl0M28oTxDbM3lPi?=
 =?us-ascii?Q?OrdetJgosxiRKGCWNNil51E/vwfujPd4Crg6Y9n+JsASaIW3CbD39sG6IJXW?=
 =?us-ascii?Q?gF2cazH77CBxdCbCLWGYVsr8dA4U9wrzK+ezVtWujnGFJ374RTIggZsmN6b4?=
 =?us-ascii?Q?vJsZeia6qw1KdAKWuEoo9y5wpsJw4sDLmo8Q408FyVfXmMNzrlV3YwLA7GHi?=
 =?us-ascii?Q?x2C6dNMVjdmKC0cFlu6IyE01M0NnFBzSQa481df1B9HJU3kwpwaPfYI21cU6?=
 =?us-ascii?Q?/aT9euju0DaV9z7AkeZmit9fOWfgT0sRa1ZcW8ndv7rnM8jD3ybLKzzhDF4H?=
 =?us-ascii?Q?Tv2w9ej8s2V72TD6DGsd6GjCydUdhytcbp8NAjBu9N2QU5cO0LSdOBByOGvR?=
 =?us-ascii?Q?IC2LWzkmCAGHenrmWV9GTDjyL15WeK1KH3KMTBp8UCA2Iw+y2R08CJmyMKzl?=
 =?us-ascii?Q?oxbkv00chIEEcCD4CT2j0Wqi8+LqB1TisHEpsY/TFhr4yS8tyl8cFLKeg0fU?=
 =?us-ascii?Q?GkoWj/przzaoGDGN1DbhsATdVvUhup8nfoymWrPR54x+0jNHF1ZWCJ8wygzL?=
 =?us-ascii?Q?NvA4u5EAdIJ9Rltx56uJlRfJOfbi3a5Zt2rL7qALKgxlJu+C6GZHexjNA5hp?=
 =?us-ascii?Q?KyyyDcuFo7OiWVBAE2YGuMsIWEp/ZpoR2CeWaIDysKS67YyYLAm68KVzqzLO?=
 =?us-ascii?Q?r4/5ZwexyxF6hNHEEtXngbkkrJXRiNXwcbHpbvzKuj8j8iRfFcvwFm6Grt/s?=
 =?us-ascii?Q?EybXOeKYNTMbc/JE7YhsgX/OgJa11ZTJDb5ehv1r/KVyNF6/lwbmTAQi+9FQ?=
 =?us-ascii?Q?r1l1gqroOW3cqSvwFIiLEOHqz6sZ/RgesDrtgD8bxE6NcSwbSr78Ee1xxj3i?=
 =?us-ascii?Q?hhpj1wHmy7Ic0l5lgDnYKr7AQZ3zpqB4YaPTHQkzQmJ54ia2onJkHHfJkOtq?=
 =?us-ascii?Q?ZBYJHTp0mjwrmeUj7BSB44Ppf7DscGqGEGTERLHF2V/jG2Gem7039/MvW9GG?=
 =?us-ascii?Q?chpXibmyX4RRpvOp8eNlj4mzoNHqaIT0k65tSI71Jm0IbQ5JXg2dXkk4/srt?=
 =?us-ascii?Q?AJjhqzXPWYu3d/jM/eR1nQj+pANKpogkJyT+favK9680FtMNdvqBzwdfosvl?=
 =?us-ascii?Q?3LbLMsAoA33xbgxdEBV2hYmt8rN7lBuFMCVaE3r6s0WJHMn7it6BA+/l7Doc?=
 =?us-ascii?Q?PwbHKAIgEOIR3qTMNDm34Wf5zufD57PAvgGmej/J5UJ86KSnn/wjSqU1+ru+?=
 =?us-ascii?Q?rJlfV/l4TGoRSmKwCRvOooQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79fb7d9-a281-4026-cd21-08d9a83f07a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 13:51:31.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAA9HyokNVew3eXNbtFD5gGnB7WG6On75q+ZW0fb0liCxEvldWdbxZEfF9DDkZgsdrcvaDhbAE6GjZrcsrSIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping for review. Thanks!

On Mon, Nov 08, 2021 at 10:00:29PM +0800, Lang Yu wrote:
> When using devm_request_free_mem_region() and devm_memremap_pages()
> to add ZONE_DEVICE memory, if requested free mem region's end pfn
> were huge(e.g., 0x400000000), the node_end_pfn() will be also huge
> (see move_pfn_range_to_zone()). Thus it creates a huge hole between
> node_start_pfn() and node_end_pfn().
> 
> We found on some AMD APUs, amdkfd requested such a free mem region
> and created a huge hole. In such a case, following code snippet was
> just doing busy test_bit() looping on the huge hole.
> 
> for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> 	struct page *page = pfn_to_online_page(pfn);
> 		if (!page)
> 			continue;
> 	...
> }
> 
> So we got a soft lockup:
> 
> watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
> CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
> RIP: 0010:pfn_to_online_page+0x5/0xd0
> Call Trace:
>   ? kmemleak_scan+0x16a/0x440
>   kmemleak_write+0x306/0x3a0
>   ? common_file_perm+0x72/0x170
>   full_proxy_write+0x5c/0x90
>   vfs_write+0xb9/0x260
>   ksys_write+0x67/0xe0
>   __x64_sys_write+0x1a/0x20
>   do_syscall_64+0x3b/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> I did some tests with the patch.
> 
> (1) amdgpu module unloaded
> 
> before the patch:
> 
> real    0m0.976s
> user    0m0.000s
> sys     0m0.968s
> 
> after the patch:
> 
> real    0m0.981s
> user    0m0.000s
> sys     0m0.973s
> 
> (2) amdgpu module loaded
> 
> before the patch:
> 
> real    0m35.365s
> user    0m0.000s
> sys     0m35.354s
> 
> after the patch:
> 
> real    0m1.049s
> user    0m0.000s
> sys     0m1.042s
> 
> v2:
> - Only scan pages belonging to the zone.(David Hildenbrand)
> - Use __maybe_unused to make compilers happy.
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  mm/kmemleak.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index b57383c17cf6..adbe5aa01184 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1403,7 +1403,8 @@ static void kmemleak_scan(void)
>  {
>  	unsigned long flags;
>  	struct kmemleak_object *object;
> -	int i;
> +	struct zone *zone;
> +	int __maybe_unused i;
>  	int new_leaks = 0;
>  
>  	jiffies_last_scan = jiffies;
> @@ -1443,9 +1444,9 @@ static void kmemleak_scan(void)
>  	 * Struct page scanning for each node.
>  	 */
>  	get_online_mems();
> -	for_each_online_node(i) {
> -		unsigned long start_pfn = node_start_pfn(i);
> -		unsigned long end_pfn = node_end_pfn(i);
> +	for_each_populated_zone(zone) {
> +		unsigned long start_pfn = zone->zone_start_pfn;
> +		unsigned long end_pfn = zone_end_pfn(zone);
>  		unsigned long pfn;
>  
>  		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> @@ -1454,8 +1455,8 @@ static void kmemleak_scan(void)
>  			if (!page)
>  				continue;
>  
> -			/* only scan pages belonging to this node */
> -			if (page_to_nid(page) != i)
> +			/* only scan pages belonging to this zone */
> +			if (page_zone(page) != zone)
>  				continue;
>  			/* only scan if page is in use */
>  			if (page_count(page) == 0)
> -- 
> 2.25.1
> 
