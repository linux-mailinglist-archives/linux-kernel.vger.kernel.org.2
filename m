Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B040447C82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbhKHJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:09:29 -0500
Received: from mail-dm3nam07on2068.outbound.protection.outlook.com ([40.107.95.68]:36832
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235592AbhKHJJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:09:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiWGCMtrdOMZ7WZzecquryZ+sjE0hHvvQNFn6/ypECl4SYjg42f8ptSdbkueYlPG6nAClXtju5SV7QmCGyxF+2RwwS228bB98UAWmebT7UAvJT5h6t5TasfZrpsrwDgmwWnDJX2w75f7KsqmfcDcC9EefAJXIRc9SX2ZgfF3SPEvYRNLAr+XUgu2Zthl537votieqg3qk9v/H6Ns03/TndWy/NVt6XFMT0WLeCHyO4pVkr52FkTwn0BkBRTXTtQQGB0Wh/owcckymp3MSUluhgFURSYtjy8pOQ5rq1vNoxOXm8xd/cQTtOj4vgeJ/GjEmUGUddyCgbXLxQp6mv7QOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKZc2dwdxGRvbeEJQYN1d69pvsyWuQHjhPEnLvLGnL4=;
 b=OuJGaKya0VdotzOPaEVa8POSzx1Pz1YGowiAq2NM+XgpWNXzW1LJQe2dHPjHbG2HxGRFr07+xyGau+mEQVOkPQj0XPU9EtkqEBNXaJbr2dqHRcnGaqU5BZeQXaa0QYwWleoiM8LBA+Ft3A0bzBeFCbjr1qc9sGhBJpPr96TbdBtJDkHzvjEMiROl9MjfeyoCyP3nHCJQc7lUagzM9Ggj8UGIATJjKMMfsg9l+T6byC98+j8oCvgFu30pEWYQ51IETDggZoko1qXPrpxVWRWT+zXMDC0dUcxzBZ2ioV1H+ym5w3Fhzz0AX6I+aq8s1WJmP2spMh6rvhnTM/XkFGz3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKZc2dwdxGRvbeEJQYN1d69pvsyWuQHjhPEnLvLGnL4=;
 b=leKO+FUm1gRG4BY+j2xGLITvcsh5DDQ/NAjTGURW4+vJjG18kkDJeePOYrrxfP4sxwzke+4quROYaYdBkSgdbEmHsNU2W0yJVDrMNIbVi3zijm7FogUrB2+1t4UnETSd7ohlWgdWgjmAiYBqWn2yDQL7hceTRSLeLXdKt2SSmz8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10; Mon, 8 Nov 2021 09:06:43 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 09:06:42 +0000
Date:   Mon, 8 Nov 2021 17:06:33 +0800
From:   Lang Yu <Lang.Yu@amd.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: Avoid scanning potential huge holes
Message-ID: <YYjomTdnLg4L6ppm@lang-desktop>
References: <20211105035241.1239751-1-lang.yu@amd.com>
 <db19fb83-7a96-605e-65ba-10e01391530d@redhat.com>
 <YYjRcGEW+snSyppV@lang-desktop>
 <52d4711c-8034-d81f-865f-ff45e4359cad@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d4711c-8034-d81f-865f-ff45e4359cad@redhat.com>
X-ClientProxiedBy: HK2PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:202:2::14) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
Received: from lang-desktop (27.115.119.85) by HK2PR0401CA0004.apcprd04.prod.outlook.com (2603:1096:202:2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 09:06:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81014218-a03b-4162-02e2-08d9a2971506
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:
X-Microsoft-Antispam-PRVS: <DM6PR12MB449890CBBAD785DCECD98820FB919@DM6PR12MB4498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9zsG7meeLiu209KOLPFCC0onFbXFVI40uun5vgyL+q/xT5B0lgyv28fZputZj1lurHThGC3/wTEWwCqztQeIhKPeol9JE6pbDTLz4GqGtvS3400TQe8778D/KAFd2nZjPHjxRM5Q2ZNNWhKczeQCzL6lfgQVBzxAUSBcKZH09ssVPRTOumIugh2mE8R11G9qt/Ain0dQHTDazpTR1RRVAh7gavhThPeknyDAGlrXU0IZYB9tSafXZ5uaTBqaD1xzsGMNHNCB7KkVbv2qA9Z63xLJ7lezOuan+FsrxbAwzsbm5nhVMQKSBUt/JgY3QeNapt8y7CiyoQ4jJaGpIPeP28gHPheXeYh3wkRbBFdoiM0h4S+tuLPFQE9kFpzp0mlaDWAqrSGBCJhZdoirREm5eM6hwAJzu1e+8+DKNLM0muCmoF5MphgRb2rXEOuDiKwTEoLWLDKjeg1BRNjBM66I95NHNLE13nH9miUnQ7FEtrAQZUkGdRRwDJjXzodw4KaMbc6NSaXJoS3NZ3yDmUJdiIEnhoi9X7JbQ01excsXprmjDuEFU+kQn++YO73Q26Svb+DCxmo67JPsHRSr+yT3I6grRc17oYs5O5trkPD/GWpmCwl2j8XuZd7uPUSZTtPDwAwmxcs0KjF8/OZQO0DaTjRTqhUVl61AUG7XqAd8qs22U/JqQzOodpEcGw1ZS4N8hjuoxbVJvlNu2M9t7zCzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(53546011)(6666004)(33716001)(54906003)(8676002)(956004)(6916009)(66476007)(5660300002)(66946007)(6496006)(66556008)(316002)(508600001)(186003)(2906002)(4326008)(83380400001)(55016002)(8936002)(38100700002)(26005)(9686003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPVTIOmEjHfrvXFseSNifmhggGFKk6mw7w71lBHGw4eHi25WcHVIocSv5OZ0?=
 =?us-ascii?Q?M7D1txhJGu0fekE7wOMkqXkwQlvz1zjdrH6a/JpKgCH24pkjV3fGJvsoMzJ1?=
 =?us-ascii?Q?/e+2nCEjcJqc73Sg7vZFFMOGrq2U+0cGpPJ3yKKl+mDlvps3KstZhHjnlaL/?=
 =?us-ascii?Q?tYj27cQHbAdcpLRNPvEC2lrLD9QXQDLsWQLDaw3G1HZ5+Bk5qV7v+rtruV0Z?=
 =?us-ascii?Q?hPHmVU1n7Jt5F+nZoXBe5zmrgM13ahNuWnyYLC429c/C98r7ZMh+SvjVFy9q?=
 =?us-ascii?Q?onuhEPQ06KJ3ywKvWojhOHQUTQ7v/eDqfYpMy+BecCwVnqpxuMWUk+7fwrX/?=
 =?us-ascii?Q?n/BGK5k8GdMzXsT9k4BTqiOEdtVmzhV10chqtXwPx5RQt7d099zBOleN82D9?=
 =?us-ascii?Q?ShCN7P1TBfi4PV1u822mTwuBlmKu9h4ye7RqiQiY6XhjL6PyRsT2BT4dTa3p?=
 =?us-ascii?Q?y1b2sCWJseCLLrgyBHk34q1SGyyGWiO/nH38AlKzM6M/4dSKkR247zgA+eHF?=
 =?us-ascii?Q?lfbtDApeg+NMm+c4eSi3K56aFFZwdJW5ZlBpkR67whSLfs1FN6QixxmhiezW?=
 =?us-ascii?Q?KGG0Ly2xLz501Mm5Tb8WeiZDt/5D0YfFb1947TvyBacZM/pdfwtRvT480fzo?=
 =?us-ascii?Q?K0KjwClMjQCa1TqA3HlZOLl2zz54gTMPsPCnQGe7491Sbye13x2xnPIETgn3?=
 =?us-ascii?Q?p8gVEXdK93BP/srKYKO0s6b+UQyp/Q43gkoHJ2QOq02AREAffr0znXsTMk/I?=
 =?us-ascii?Q?o6kIkstajZYKe2JcBApIBkyrXVtS0WhKeno2pr03TcHm76YuQXE2GPNNw3MB?=
 =?us-ascii?Q?dGbziLhsl9NZV0+aicYeuP/DZA8djQUrEgHDDDXUWKugDOAdE93l2PbBzSrX?=
 =?us-ascii?Q?EHA0wsHdmsTYwqBOBWT+OE2Y0F9d3KffEjZkRUA76vuyADdORdSCY9Rq1rVF?=
 =?us-ascii?Q?cEqRWIlUVxZd58DklFClNfoaRDurOno6ugVbD+gpPjWeMPec57UcI++DlYDp?=
 =?us-ascii?Q?q6k94MTPkJX21rsNPSfZjfpJpAsI0cehDnlY1ru8bMkAz80GvDzGgKXCCpW7?=
 =?us-ascii?Q?NOJjB6A2x7aS2UCOZK6FMlk/meJ2iBzkxfXy1xDD6g3Vxiky4ZmuZHr+gwrB?=
 =?us-ascii?Q?oHUqotoObVsTPxcWsNgKwYGBsrfr5XW3SmvywJeFMj5QA3SGbbtUGCbVewRx?=
 =?us-ascii?Q?Xfj1T1vh3LDYcrY/44gkQU3u6knRMI3G2SpKD71X0daOJBCTxp13QlhjzBIV?=
 =?us-ascii?Q?KbzwWTeHRNEkp+INHaZ/y6NvrK9HlGgmwmLHogoY2a5xuaLdCVhc9Ws+OlvW?=
 =?us-ascii?Q?NMBpAA+uBoZSlAjexHbWxrxRVKYGBR1ThXmQuRSa2J+zGXZ9AcfOTf6bS3F7?=
 =?us-ascii?Q?2z//xSovQ7nxiFxU4E1rdh9C6DJZcKl/R1MvZmE5UmadZD1b7lXas8XaV6ef?=
 =?us-ascii?Q?iM6PXxAxVwSNOEG5TOvaFACcK61ZmvN8tvfkItaN0SMZQCAUGUmYwLtsETCm?=
 =?us-ascii?Q?asB11d64kSAPi3t54w9A6K7UntzY6/RWQa0BNksTcF8N4aDGcFfKWMlj3opJ?=
 =?us-ascii?Q?NGqY24/G/i73vWXANRnUYMGc4xL2wlGWn5M4a3byOXaRDc7Eab2TDwnMkEV2?=
 =?us-ascii?Q?1FgdjvKzy7s0XsiKLllNq8o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81014218-a03b-4162-02e2-08d9a2971506
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 09:06:42.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk020lKBQBoSqJl9f0C9NANxv5BRA0X53ZbDGtgY9XOLxhXi/mObD1xz73Nufw0aSx7eTYEMSt0F2JCkjqlPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 09:23:16AM +0100, David Hildenbrand wrote:
> On 08.11.21 08:27, Lang Yu wrote:
> > On Fri, Nov 05, 2021 at 02:14:50PM +0100, David Hildenbrand wrote:
> >> On 05.11.21 04:52, Lang Yu wrote:
> >>> When using devm_request_free_mem_region() and
> >>> devm_memremap_pages() to add ZONE_DEVICE memory, if requested
> >>> free mem region pfn were huge(e.g., 0x400000000 ,we found
> >>> on some amd apus, amdkfd svm will request a such free mem region),
> >>> the node_end_pfn() will be also huge(see move_pfn_range_to_zone()).
> >>> It creates a huge hole between node_start_pfn() and node_end_pfn().
> >>>
> >>> In such a case, following code snippet acctually was
> >>> just doing busy test_bit() looping on the huge hole.
> >>>
> >>> for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> >>> 	struct page *page = pfn_to_online_page(pfn);
> >>> 		if (!page)
> >>> 			continue;
> >>> 	...
> >>> }
> >>>
> >>> So we got a soft lockup:
> >>>
> >>>  watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
> >>>  CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
> >>>  RIP: 0010:pfn_to_online_page+0x5/0xd0
> >>>  Call Trace:
> >>>   ? kmemleak_scan+0x16a/0x440
> >>>   kmemleak_write+0x306/0x3a0
> >>>   ? common_file_perm+0x72/0x170
> >>>   full_proxy_write+0x5c/0x90
> >>>   vfs_write+0xb9/0x260
> >>>   ksys_write+0x67/0xe0
> >>>   __x64_sys_write+0x1a/0x20
> >>>   do_syscall_64+0x3b/0xc0
> >>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>>
> >>> I did some tests with the patch.
> >>>
> >>> (1) amdgpu module unloaded
> >>>
> >>> before the patch:
> >>>
> >>> real    0m0.976s
> >>> user    0m0.000s
> >>> sys     0m0.968s
> >>>
> >>> after the patch:
> >>>
> >>> real    0m0.981s
> >>> user    0m0.000s
> >>> sys     0m0.973s
> >>>
> >>> (2) amdgpu module loaded
> >>>
> >>> before the patch:
> >>>
> >>> real    0m35.365s
> >>> user    0m0.000s
> >>> sys     0m35.354s
> >>>
> >>> after the patch:
> >>>
> >>> real    0m1.049s
> >>> user    0m0.000s
> >>> sys     0m1.042s
> >>>
> >>> Signed-off-by: Lang Yu <lang.yu@amd.com>
> >>> ---
> >>>  mm/kmemleak.c | 9 +++++----
> >>>  1 file changed, 5 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> >>> index b57383c17cf6..d07444613a84 100644
> >>> --- a/mm/kmemleak.c
> >>> +++ b/mm/kmemleak.c
> >>> @@ -1403,6 +1403,7 @@ static void kmemleak_scan(void)
> >>>  {
> >>>  	unsigned long flags;
> >>>  	struct kmemleak_object *object;
> >>> +	struct zone *zone;
> >>>  	int i;
> >>>  	int new_leaks = 0;
> >>>  
> >>> @@ -1443,9 +1444,9 @@ static void kmemleak_scan(void)
> >>>  	 * Struct page scanning for each node.
> >>>  	 */
> >>>  	get_online_mems();
> >>> -	for_each_online_node(i) {
> >>> -		unsigned long start_pfn = node_start_pfn(i);
> >>> -		unsigned long end_pfn = node_end_pfn(i);
> >>> +	for_each_populated_zone(zone) {
> >>> +		unsigned long start_pfn = zone->zone_start_pfn;
> >>> +		unsigned long end_pfn = zone_end_pfn(zone);
> >>>  		unsigned long pfn;
> >>>  
> >>>  		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> >>> @@ -1455,7 +1456,7 @@ static void kmemleak_scan(void)
> >>>  				continue;
> >>>  
> >>>  			/* only scan pages belonging to this node */
> >>> -			if (page_to_nid(page) != i)
> >>> +			if (page_to_nid(page) != zone_to_nid(zone))
> >>
> >> With overlapping zones you might rescan ranges ... instead we should do:
> >>
> >> /* only scan pages belonging to this zone */
> >> if (zone != page_zone(page))
> >> 	...
> >>
> >> Or alternatively:
> >>
> >> /* only scan pages belonging to this node */
> >> if (page_to_nid(page) != zone_to_nid(zone))
> >> 	continue;
> >> /* only scan pages belonging to this zone */
> >> if (page_zonenum(page) != zone_idx(zone))
> >> 	continue;
> > 
> > The original code has covered that, i.e., 
> > only scan pages belonging to this node.
> > I didn't change that behavior.
> 
> Again, you can easily have overlapping zones -- ZONE_NORMAL and
> ZONE_MOVABLE -- in which case, a PFN is spanned by multiple zones, but
> only belongs to a single zone.
> 
> The original code would scan each PFN exactly once, as it was iterating
> the node PFNs. Your changed code might scan a single PFN multiple times,
> if it's spanned by multiple zones.
>

Did you mean a single PFN is shared by multiple zones belonging to the 
same node here? Thanks!

Regards,
Lang

> -- 
> Thanks,
> 
> David / dhildenb
> 
