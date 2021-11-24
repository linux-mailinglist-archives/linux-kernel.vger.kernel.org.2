Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718C345B862
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbhKXKeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:34:36 -0500
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:62337
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241151AbhKXKe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:34:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba7ChoeKaxSLl+JKfxKdBdCxTx0p49/yrbhOBA+fKP9IIGC58GOuAEKLtu/3pxchZY5fHzK8qhsK6fH7dgdcCjxseQXl/2CY8blTrGsg+aU+KQQbBrFhtABaqiKooDfOwIDXfGMWFxrLzJAI62r5krWno8/QWdFctoXC0hG0h0wMaUr7jHs83zXwM1IFNh7PFCQvk01G3dNClRlgZfjhDWIuUBuS2bHf5xSmMUryUFKaeoba25jWItdVaTdLFkyb7RYif5koDL2pn1799l6WcNSlAnZLgQm3Goog3byNpeXFgbPaaEAYOh2TF2LwstcDAybBmvzX+uAKOJKOdg9eig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikzhdT0UOro9mwoVLV4sbePKO2XU2pNFvQ6PDm72w40=;
 b=YfVRCIX6KaDcKwUjn2sD8mnSBwP+RZqTpyGyI+lrvtbk5Qp3s5PUDbCouev1ECnHhlBD+w/eYVli+VYSJY1juq7DP2Va1zOlEU+y8vih7VQuiA0grUQKKMV0w371J7bnPXL2fCrmZOysArjl4E78tQKKYIqsj/cjRH+SJgSljL8C2Kpbyjo63ZGm6V//Ma47a2vG2m70OXQkK3E4fRIjYSiPjMCGFgqOa+3GKRUihfAzZzR0s9Wxj3tAe0GPAqfjq7ybZusVw/6z22gB3Itok+veJxfXtzS7AansargAscnJ3v2CaWZyReHtkyytFH52XStATeXTJ1tsIhR1cQHnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikzhdT0UOro9mwoVLV4sbePKO2XU2pNFvQ6PDm72w40=;
 b=0uLVRyOjjH37VjvHPdfrF6YI3T6iERygOL0mP3zor+gb4tp7LGIl24NWwEPbYrRIljMyeuzDHeg2mYCunVWfpoGkuNIZoZHRmYa0SJo/i/aE32AqpsWjR1eyLoFm6cjFH3iqTrI0w7IqHGuTIRgF9hBKJaVyTzCHbShI5bWTmaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 by CH2PR12MB3942.namprd12.prod.outlook.com (2603:10b6:610:23::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 10:31:15 +0000
Received: from CH2PR12MB4247.namprd12.prod.outlook.com
 ([fe80::76:d8d6:eb30:ca22]) by CH2PR12MB4247.namprd12.prod.outlook.com
 ([fe80::76:d8d6:eb30:ca22%6]) with mapi id 15.20.4690.027; Wed, 24 Nov 2021
 10:31:15 +0000
Date:   Wed, 24 Nov 2021 18:31:01 +0800
From:   Lang Yu <Lang.Yu@amd.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/kmemleak: Avoid scanning potential huge holes
Message-ID: <YZ4UZZRq6MrfbPoL@lang-desktop>
References: <20211108140029.721144-1-lang.yu@amd.com>
 <8bca8139-8a6c-77b2-c295-9698d3662251@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bca8139-8a6c-77b2-c295-9698d3662251@redhat.com>
X-ClientProxiedBy: HK2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:202:2e::17) To CH2PR12MB4247.namprd12.prod.outlook.com
 (2603:10b6:610:7c::20)
MIME-Version: 1.0
Received: from lang-desktop (165.204.134.244) by HK2PR06CA0005.apcprd06.prod.outlook.com (2603:1096:202:2e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Wed, 24 Nov 2021 10:31:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec533375-12f5-4018-8159-08d9af358b38
X-MS-TrafficTypeDiagnostic: CH2PR12MB3942:
X-Microsoft-Antispam-PRVS: <CH2PR12MB39423D9738C65BCF6E25ECB2FB619@CH2PR12MB3942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cadDvscMVZg8uV6rWPinqff+lYDXm7x74BKIpKIPwqJ8+kUfib0yDMMeQE6XqIaYqQkudT+VBfib6ZM3k38lSBdXQ/yPNQ/aEWDCdyHS3j4YER7Xw/1TI+kW9TssUHx5xcMVvsMp/MXXKONGPR6+sV0Fr9eNGxgrOBWddDf1pyS17oQ4xdrqWG3/jUMfJvmzHYSdlof92jrfGmwK8D3NwWOBCdkIkyn/5gB0o7kUaxVp2hv6KDcK3njRRNjQQLUZ7j60eixFGfMATNl7Uh1bBkQld21S5Md32IHnHtKym/7L/QrjMnyQmvBz6XOLhjAEZsEXOIbq3mCg1qmUE3u9PWQcg+TthmRuhQtcoF5qi/annpqQ+eV3VpL4ewFMac0RU1zLJ78p6bktcwUeCV2aIXyhPe/KhdM7qN0muCesYjFfYn2Coyk5TCIFHoanXLY7Bdu4AJzPE3fNRAlIVyLP7d0YM1tVT8ZUbKCqwvkhYKx0bXBFr/3FRmMPqk2mmEBjTZTlObNahW+TRdm/sf7881Y/F9h/Jepr4SM6iIrIYGr3K7TWN6LkQTzyjHW4DzpMmB0CD3PjihFEm/R28gjeVIUf5K3ky0oOQpfndiz8TLWh3wqgNzl7xuifTtbriB27MVeXdKHfMk252yyaXSmYR4xQFZg32ZKL5ivlvc0ucFhG95SC2sRawMeqx0E/TBDC5fBLeq2uxKAu04dPED93mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4247.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(83380400001)(316002)(33716001)(26005)(5660300002)(8936002)(66476007)(9686003)(55016003)(38100700002)(508600001)(2906002)(8676002)(66946007)(6496006)(4326008)(53546011)(186003)(66556008)(956004)(6916009)(86362001)(6666004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?22mWYWBNySUB+TllGPBEbeOmdsCceesCemlLVG4036izLYcw9oFc4ZedC23d?=
 =?us-ascii?Q?09+M5BiccmjP8pWjB997enbVpR7cmv1InEn6WQbV21En0QLLw3UAspzTBM/l?=
 =?us-ascii?Q?fc6zs2Wby84Hr8PjmWPMAj4JGhnOjd1BOfAeVoZRv0e9Q+KrjX/lXWmk/jf6?=
 =?us-ascii?Q?nsGyKZGvp/ICDw9EhPrFCwnSIamVBmVEHs1TT+VPsXYiy4vc9yIH0ApbpA66?=
 =?us-ascii?Q?IviMvPE/HRoyFe1Uj1hmPwPuTSYETM2NAtopaCA7u4/dzE5I57ZpmrHFZ4Y0?=
 =?us-ascii?Q?nl/9j9liQBItXijI7bwTQav2XQIpZTF4/gZ98aDBwJ773oCSFMUxevVV3+s+?=
 =?us-ascii?Q?OcR95N14ximyTRTDVfR7mogud8IC2JOAo+nHxwyFU7lqoZv5aR4rK064LGBe?=
 =?us-ascii?Q?6qNR2BDiK3v6eb1MKdAJiL7SC8cEqfngepRjDUjSidjYimn9o7shXhnZz9s8?=
 =?us-ascii?Q?428QkQRwhiGaLP/lsx6Ib7syIPEs5Gy9cAyWpQ8oOyGdL22tCZaQR8Gkx5VI?=
 =?us-ascii?Q?JSGuXr3OWZ7UsoqUc/wJ68BDJ9AuCXSW3u6IkoDiN+Vh7VDZUuW+oikM+ZFU?=
 =?us-ascii?Q?6pxspEJwV3kh6HgPbT98Ky8unsaTW+09N72WcyKa93+GSij0sBZ8RYZsOXmr?=
 =?us-ascii?Q?UzDBWOfVPJpKcGzumDJrJmmQdz0563CW02Ija2CFs5hcrtJHW9UAECWkgaz0?=
 =?us-ascii?Q?AaC8jQoQC4knj/jmYJ2Wk499TgjXM1LrK/1oDx9toy07ROXpOfMezxbx4Pvt?=
 =?us-ascii?Q?mGbb9gTfDo6OrV39KOu1hCfOrUTd+2yJTLb+ZNywRtjCx6m5VncfnZHaifwK?=
 =?us-ascii?Q?ZV4BPOm9OJYlsVWkpiSnow4lmOaJF4o7fv7e6BbtVmTUr89gO5qL8n0movxg?=
 =?us-ascii?Q?hCQoDgDX08m2cEUO4CXkbdjg8PUnBFso7H6yW9AcHRC5od+P+5syfLNFsYq3?=
 =?us-ascii?Q?Rh7MQ51n7N/BPqXKPLJiYpBu50Sm7wb5Mm5WA8q2XM+y0NFHGrldKraD7+iI?=
 =?us-ascii?Q?aQStVVN3TKPVc05rUszln2d2ar8vNvZolfrwXzdyY418a967rqHCfxqajyeF?=
 =?us-ascii?Q?cJ+tRbGMZyjUFebNcFzzdQ2yrlCww0vtZZ7saexfM0tq4J6fo1AM0bkQ3+or?=
 =?us-ascii?Q?G4bGrWqVtEfgYNnJYg6tsAwGCGV44WHRjh8yazdOqk7Dt2jPshmS2SOnpUM5?=
 =?us-ascii?Q?XQJXCwo1W0HUCEFJkavhpKdkcbujxHWFa6w53La/XJMvvv6MBKT/82Dp5RK/?=
 =?us-ascii?Q?KpukuumENIVPhFEjK0Du1Ao06m+9ivFoFxnhLQcHpzuc2I+of45ku3gZIdU6?=
 =?us-ascii?Q?AT41n3aoEkErEi1M8KAlbGAwPyuTtYLx45XpUf5dyLgI1Ld3CJ8A00jWxdB2?=
 =?us-ascii?Q?ftrI3VapXUv3JTtjhsK4uy8wdqbv+BXC3i0B1Bd9ef8qultvP9F1t73cphtn?=
 =?us-ascii?Q?SRU7zGUar7T48Qx4kNKl58ndDU393RMOBZOL5an4B/Md/GRPzC+f811NBktv?=
 =?us-ascii?Q?6lJz9Xo7+LBNDlB7cPLq8iPdN0ggbVgvYe0HoW0sSr7czTOt2KzwT1sD/mJw?=
 =?us-ascii?Q?jlOpMw31+pDHgWz3Lf3XpTSm6D+63zrbnaRFfcYkikRgdLJIusvqDfq94zhl?=
 =?us-ascii?Q?WNNYhS4LIfQDGMcNqrNEeRs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec533375-12f5-4018-8159-08d9af358b38
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 10:31:15.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VyvtcUW2j9vXj3WcFvK2TN+SOZYiDKmE3Hz1yHR8J4v35kCbk5sYc0nmFDqngiUYbbX9zZKoM3Aa60splXEFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3942
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:07:57AM +0100, David Hildenbrand wrote:
> On 08.11.21 15:00, Lang Yu wrote:
> > When using devm_request_free_mem_region() and devm_memremap_pages()
> > to add ZONE_DEVICE memory, if requested free mem region's end pfn
> > were huge(e.g., 0x400000000), the node_end_pfn() will be also huge
> > (see move_pfn_range_to_zone()). Thus it creates a huge hole between
> > node_start_pfn() and node_end_pfn().
> > 
> > We found on some AMD APUs, amdkfd requested such a free mem region
> > and created a huge hole. In such a case, following code snippet was
> > just doing busy test_bit() looping on the huge hole.
> > 
> > for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > 	struct page *page = pfn_to_online_page(pfn);
> > 		if (!page)
> > 			continue;
> > 	...
> > }
> > 
> > So we got a soft lockup:
> > 
> > watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
> > CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
> > RIP: 0010:pfn_to_online_page+0x5/0xd0
> > Call Trace:
> >   ? kmemleak_scan+0x16a/0x440
> >   kmemleak_write+0x306/0x3a0
> >   ? common_file_perm+0x72/0x170
> >   full_proxy_write+0x5c/0x90
> >   vfs_write+0xb9/0x260
> >   ksys_write+0x67/0xe0
> >   __x64_sys_write+0x1a/0x20
> >   do_syscall_64+0x3b/0xc0
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > I did some tests with the patch.
> > 
> > (1) amdgpu module unloaded
> > 
> > before the patch:
> > 
> > real    0m0.976s
> > user    0m0.000s
> > sys     0m0.968s
> > 
> > after the patch:
> > 
> > real    0m0.981s
> > user    0m0.000s
> > sys     0m0.973s
> > 
> > (2) amdgpu module loaded
> > 
> > before the patch:
> > 
> > real    0m35.365s
> > user    0m0.000s
> > sys     0m35.354s
> > 
> > after the patch:
> > 
> > real    0m1.049s
> > user    0m0.000s
> > sys     0m1.042s
> > 
> > v2:
> > - Only scan pages belonging to the zone.(David Hildenbrand)
> > - Use __maybe_unused to make compilers happy.
> > 
> > Signed-off-by: Lang Yu <lang.yu@amd.com>
> > ---
> >  mm/kmemleak.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index b57383c17cf6..adbe5aa01184 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -1403,7 +1403,8 @@ static void kmemleak_scan(void)
> >  {
> >  	unsigned long flags;
> >  	struct kmemleak_object *object;
> > -	int i;
> > +	struct zone *zone;
> > +	int __maybe_unused i;
> >  	int new_leaks = 0;
> >  
> >  	jiffies_last_scan = jiffies;
> > @@ -1443,9 +1444,9 @@ static void kmemleak_scan(void)
> >  	 * Struct page scanning for each node.
> >  	 */
> >  	get_online_mems();
> > -	for_each_online_node(i) {
> > -		unsigned long start_pfn = node_start_pfn(i);
> > -		unsigned long end_pfn = node_end_pfn(i);
> > +	for_each_populated_zone(zone) {
> > +		unsigned long start_pfn = zone->zone_start_pfn;
> > +		unsigned long end_pfn = zone_end_pfn(zone);
> >  		unsigned long pfn;
> >  
> >  		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > @@ -1454,8 +1455,8 @@ static void kmemleak_scan(void)
> >  			if (!page)
> >  				continue;
> >  
> > -			/* only scan pages belonging to this node */
> > -			if (page_to_nid(page) != i)
> > +			/* only scan pages belonging to this zone */
> > +			if (page_zone(page) != zone)
> >  				continue;
> >  			/* only scan if page is in use */
> >  			if (page_count(page) == 0)
> > 
> 
> I think in theory we could optimize further, there really isn't that
> much need to skip single pages ... we can usually skip whole 
> pageblocks. (in some corner cases we might have to back off 
> one pageblock and continue the search page-wise). But that's a
> different story and there might not be need to optimize.

 I agree with you.

> 
> Also, I wonder if we should adjust the cond_resched() logic instead.
> While your code makes the "sparse node" case faster, I think we could
> still run into the same issue in the "sparse zone" case now.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> to this patch.
> 
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index b57383c17cf6..1cd1df3cb01b 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1451,6 +1451,9 @@ static void kmemleak_scan(void)
>                 for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>                         struct page *page = pfn_to_online_page(pfn);
>  
> +                       if (!(pfn & 63))
> +                               cond_resched();
> +
>                         if (!page)
>                                 continue;
>  
> @@ -1461,8 +1464,6 @@ static void kmemleak_scan(void)
>                         if (page_count(page) == 0)
>                                 continue;
>                         scan_block(page, page + 1, NULL);
> -                       if (!(pfn & 63))
> -                               cond_resched();
>                 }
>         }
>         put_online_mems();
> 
> 
> What do you think?

Yes, I think that will avoid any potential soft lockup.
But wheather there are still such huge continuous pages.
And the run time may increase a little.

Regards,
Lang

> -- 
> Thanks,
> 
> David / dhildenb
> 
