Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EFD45B254
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 03:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbhKXDBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 22:01:30 -0500
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:32480
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240056AbhKXDBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:01:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W67vmn/8CKZkfZMKCXIsWIG+4MiL06LHCoYpun0hMVFGdiPDvFxtax5wQv7RGDMHpwwe6ODnX9XBEjIFZdNmvFuy9FeFD1ApcMyUjla1/W65y2ZyRQfABjc/A6KnEYyZuwyMoTHeTDjX/lWJFQyYL3WcX8i4RiWFdtx/EpN32qpyIMYLHFwxwEVWR0hOeUg5FMWrkxrE7G2/vF4lkedNu60DNYOfXhJ8FFCBgiEbjwJmKLpS5bjkqQuKlPzab82aD5Udhp/B4cqbN3EqiRli/24BamllH6CL4FmqCXOYQ8lsmNYBFIA+6Eqj8HAZKj5hkb+r6zp7rYD4x/iUugYarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI+eXU1VntdcRk5SV8BfciR1JTun8FdhJrcRMPm6ZO8=;
 b=ePAhSvXn1wiIPid61lzl8MFWRePMZqitaYor7Cz7T0htaTv4oONSSLE2/W+4m6H8sS7lDS//8QvfO5b3Enh6ob0mv2DJTXKf08h4XD/nmkTLH3/n6kp1i19REZvIby9Wdn0gO0yk1d0oyOU3nWUMpOC1ImYGHHGxGb3oAjqozypmY/Osf7wMUuU4XIb9qDduVBdm7YsU/yE5aPj6Cpz8W2F2D94TVO0gwbfGcI9AuRlTV4vvWaKclhe6zwh7opQsrAlN3xSa1H0M14dvrjNVag0lIXgsKz+vxe+TOkPyvasr5PQVkYbBVtm1P7lZJJPicXyyVOtvgk1YXFI0EkDygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI+eXU1VntdcRk5SV8BfciR1JTun8FdhJrcRMPm6ZO8=;
 b=T3il3wrD+JZYl1hb32WW+KcAoDWP4ugopb2S7b8ZyU5v00fHecTMJeMQNBZVOXNtaII3RyKN/eCwVlOa7mvj8IfOvkeu2McFNNuQmtPt9kkE+LhzGFHXMrRXsRBDYU5DuSweoXtSp1akKs9hvHOHoovainPncLMJw7MxFNERug4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Wed, 24 Nov
 2021 02:58:13 +0000
Received: from CH2PR12MB4247.namprd12.prod.outlook.com
 ([fe80::76:d8d6:eb30:ca22]) by CH2PR12MB4247.namprd12.prod.outlook.com
 ([fe80::76:d8d6:eb30:ca22%6]) with mapi id 15.20.4690.027; Wed, 24 Nov 2021
 02:58:13 +0000
Date:   Wed, 24 Nov 2021 10:58:01 +0800
From:   Lang Yu <Lang.Yu@amd.com>
To:     linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2] mm/kmemleak: Avoid scanning potential huge holes
Message-ID: <YZ2qOWsWBoo/tgGk@lang-desktop>
References: <20211108140029.721144-1-lang.yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108140029.721144-1-lang.yu@amd.com>
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To CH2PR12MB4247.namprd12.prod.outlook.com
 (2603:10b6:610:7c::20)
MIME-Version: 1.0
Received: from lang-desktop (165.204.134.244) by HK2PR02CA0146.apcprd02.prod.outlook.com (2603:1096:202:16::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Wed, 24 Nov 2021 02:58:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 212e4bc2-0a14-4db1-8945-08d9aef6412f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4294:
X-Microsoft-Antispam-PRVS: <CH2PR12MB42942A15A70561282F4BDE46FB619@CH2PR12MB4294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3i8kHaVXBeQKRpab7Zt7/CJDx7YaWFhgb8meF6M2QJ1O6ykUWCYK3BPf31wpZw6uQddiRUhBGKrSE92syIe55n3gVtXyzVS7RlQlYAQGn+JlwJ2dwTucSLnmyTsb2mtTby2x1hIrbwjF5+0z7gaJy4BsY4fUszFtl0EBZDHIQzt5CMjsQE5dTHMSD7wEXusFcwE9FgDKUxT5NxefJyvjQ9C9AH+Z6QDA9iwOlOleDUTk3MabupRXMzUbjmBVbmLOkpkOo+l0cEbY/hfbzNF8tAz4e7aQ+/NApRrp03QPvMODMUzD5dyqWTh/hG50d5kxBBBmBds32w5hAUVCD6DI+BuQ7AtPvfkEdLbEQoc6dpqHZOhxHr5LCyBj/wFIRKv32a4n0YZoCjQ3JM2+AZ6Wp1qDvpWG3ifG/q1an/gUWWNR0FhE2rCece0rb9ydHjLj+ry83PE6oLqJWMvRafx6KByKjpkcV/d9CTD45t27ofBid2nOurQw+kZQwR3189vlEcriarR2M6Zii4GihTElbb5uCLzRMRgb5oSEpYqxleCNB2kpHy4HWewwdWr0C2sPyNPTwVBBDEstp0dFAJ+PQGiQxplqvxMTPQ1ObbVMXtuYo5GalsNfX2yCH+LUKtq3JEWPlItto7q34H0FscsqJs0xWidcfQQ3X0kdx+AYjwUKbeIC7YRXkZnaMj71pYBbGoWlYjseq7fhhCpaP27sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4247.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(66556008)(316002)(8676002)(38100700002)(6666004)(66476007)(4326008)(9686003)(956004)(55016003)(54906003)(508600001)(86362001)(2906002)(66946007)(33716001)(83380400001)(110136005)(186003)(6496006)(26005)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jxUut6Iv5GWv5fl8cXMD27AaWiIHGvbbSC0YpNMBzbRfQUQihRYkBABfBQs?=
 =?us-ascii?Q?ogxE/6kW5p9mrFmCFvdMzUn/wVg69ht/inKTZNMSp+Z1VtcJk62pqmtcxnHC?=
 =?us-ascii?Q?gHJ61NW6Ag8J2T3Fb0nu+dWEM7JR+FrL6Ggj1gVuTSUqkbhvgVJcIZBB0t9e?=
 =?us-ascii?Q?g9tt+eyf84pLVoao8S5cxJwKDW36S3/T6XVt8k+bUapXhMBGttDA9tl++y5d?=
 =?us-ascii?Q?9jcyZ8Gfq8fEKS5in0kWukg7kQbnlm1p8dtAuKJq6x+bBC4Z0al3QiKxD1jM?=
 =?us-ascii?Q?DvmgGYk+WTAWFjaqDbVameyevt2SmGHmdUdBCYB1D/50nye5VJ8/WdmC8ZV3?=
 =?us-ascii?Q?2Ljid1rXpl4EB6RZ2HHJoa3Qv1oW52zvAv7Oklv42kCUX14BbKew7dZ1afMs?=
 =?us-ascii?Q?DZ2ZmfUyQZBJkKI+0yTNblVShg1k+X3zhVlexYId4X2qARPF9VbzFW0w2SHH?=
 =?us-ascii?Q?gxQwsEV6LnWF06momXhKVmTNmex4VaG52DjvOqb7rkFiHPYPcEi4ojHQ2RJO?=
 =?us-ascii?Q?EmNAsqXILw5APVDdLyg4Hr/6RlbNLmX7xKka+EqDOdKG7pTQsCd2gAmGk0+p?=
 =?us-ascii?Q?ZR5ImuB+EjJG2HJc0AlwTYBG/Y1YEgjjlRGsTtgWNB+KebH94/J6CnePa7R3?=
 =?us-ascii?Q?1OKSkLl0uEejKenv+bwUT0q+Pnj0n+aoqNh5EZN7MBYukbaH634NZ/aj8yaz?=
 =?us-ascii?Q?9+x1AJqzTKOgUbGnJhLlaRRCOb9i+5guTF8FQU2L79n+5DmyNg3tgOtR0Kf+?=
 =?us-ascii?Q?UWZEsViKhpNvJETPHa5izcJkiJhC8FS8jjt+n2JV/cCiVeVBXrN2/aU6eoG3?=
 =?us-ascii?Q?Jxokq/Un7xlig92SHZi2Jp3YsmYkRLrFla5FjyUhcriVEXX5xCzgMhdjqPBk?=
 =?us-ascii?Q?gtxdzMZkOTd3vTW1A5g4G/JHGT7MXWk7wgdPMWhpK4uDPLK8Vj/x9kBnU1Ce?=
 =?us-ascii?Q?1ONKQoXyf+qsv4U/laynRdx9G48F3AgXXyIvZzENsqneID1Y4iOxdjefSHDy?=
 =?us-ascii?Q?ATW3A4KvxAunZGVYi3OZx8sJ8Sk9XOc/86TaFWrUVp9CBBR0xMVc9800qvY4?=
 =?us-ascii?Q?hLNS0zLi3J7naW+/brnWv9WAvBPBz/ZG32Lpsb1vAOSv1ksiLCBJm9Cvf0z3?=
 =?us-ascii?Q?X6BJ24LCLPswVnLnFtzymGMhRVAWd9B2cFer4hlz+oYWMGbospuiYLv46uo6?=
 =?us-ascii?Q?NRqJ310iutImp5s1pTnTKiMtnOeJr1Bbw1vmctGW18bEP3XRFaeQyZP/se4g?=
 =?us-ascii?Q?62Yfrz/nzs8bClSVHR2GhoxTFVZByhOxhqG/1oc9ERtHWvD5++E5Kh89bhK8?=
 =?us-ascii?Q?Sl1Izj8Fw8ZI2ct6VBuNI0yClAwXWbyM6tP8OCDK1KDuZIU8ckFP9jkELU7x?=
 =?us-ascii?Q?+2emcelCmK/hswgMlevACnuqEsteT3ZQ2NI+KOTJ9C2zX8Q0YiezOjUmW1vO?=
 =?us-ascii?Q?6+MYFUdvr2Tg0+u5kqsUMHePX5qKPKMe3WeWQN957f699Y0Xj4GbuceaeUZf?=
 =?us-ascii?Q?DkujHga5u9IvbEpR2P6/1dk9+CRjbQqYHxUF5YAYh3SIXRs9vPFT8s2VQwPH?=
 =?us-ascii?Q?pO6h2KzJP16EUDzzUKWnIq5YafWJRaFKNrag866AP6kFaS7NieFKkqf9QsSX?=
 =?us-ascii?Q?8hWZAq+34DO3HlmB8wnySiI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212e4bc2-0a14-4db1-8945-08d9aef6412f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 02:58:13.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GJcdjoTKIKEQsa/4iO9IkDW0I6HQVd+1BNzNIWwZKcIJ7ufTE8m8UMyU0otEN5i1Zg3TT+WZGfyN5hvhqARNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 10:00:29PM +0800, Lang Yu wrote:

Ping.

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
