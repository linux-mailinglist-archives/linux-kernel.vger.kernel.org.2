Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BCD332F2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCITjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:39:21 -0500
Received: from mail-co1nam11on2046.outbound.protection.outlook.com ([40.107.220.46]:22442
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231272AbhCITjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:39:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2RFTbqeZtGIXovsjlVVtL1yaJW1ljghbxA/m1V3fFHOoSdLx2ey4EIrusBXyX52HHS83L5IphTDHWjBPJHGr3gxkyMLVeFDCsoO37mLfQ/2jVNPPZe4kKaBx+lXvDB9OEIaWjXgGnL2eIwc/F8lml+kWX+SkBjCHI8wMN8hegYDikIbF0x/H9KJLEHtX6UTQ0Lemrj3rL4yVEDqt/2y46U4NRgraIO60smlUs+qNC9ZvG8vq+nDR1q7eoQ5Hutf5nEwmRJtY4frqgCuaAQZqjUkXPZ5bHqZl0J7sgTOw0f4ni40kfoUIOCTwgISNUeApo363E3cvCdKBomIMx/yZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItFpEWRkV1vFsk9Zaf5B4lOvu40CjPOE5TEjRzauqD4=;
 b=FkWN7ZTjveYXKCTgtnC7nOyF1g5BePvK3z9uYkna4oWZg/Hm/Xonq7d6spsWNX7tjRVS6t7iPIwC24VcSV/zd144lxvYa8HUiSBwj5zCy1HCBhoMk+TnuQvGtEK5Ji2bEewI0Zpd+NNQ7uxbmvMxkcwXSGiiekq/T0AzWRKKevJibpKu3+JVX0CrJR9SLS8wGD+TN6uScje4V08T3CcJ8ei/KJ6uvpPkhwsKORi+GU1Zc5ZZaQ/lMbVQ7wdctZVCsyP+S2UYyJLUS3ybkg0g/xm+Q2jciK3Q//tnmdJBkYE+VpDb3wS5hi1gPd74EYdxIQ3/P5ucpZOIGAAp7FeLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItFpEWRkV1vFsk9Zaf5B4lOvu40CjPOE5TEjRzauqD4=;
 b=hAlFdtH5+nUnr4398zgjTPAIfmxwxGp0H60fKnvQ21EabcvMfiqDbDAJkrSaomCW2RPKbrCKc1Ex9xUkCqiNv3gkw28zWwF8CodCWa6goPyXduvM0xzt5or/Q9shLJNz0DHVRJz9s3NpwTxoAEW+ldhjWmGa0YzJeC2axVh8jzVC5dq5mZoxFPHVrgd/Zcd/G/zTfMoGFbvhFhTyssAenZeKUHOfnNd+wjlnKLFzbdUwaStRzNcz6x445AW2z9E2bUMAauSYT14B7xsWgO9gUefZRuHc+EZielBTF2taejYMOVYtpzmZCeec0ZbVjKj4yZvCYoqUUPF6rlN6D4e3BA==
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 19:39:09 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 19:39:09 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Oscar Salvador" <osalvador@suse.de>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        "Michal Hocko" <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] x86/vmemmap: Handle unpopulated sub-pmd ranges
Date:   Tue, 09 Mar 2021 14:39:02 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <380379B8-5331-447F-84E7-FB55EABA1C51@nvidia.com>
In-Reply-To: <20210301083230.30924-4-osalvador@suse.de>
References: <20210301083230.30924-1-osalvador@suse.de>
 <20210301083230.30924-4-osalvador@suse.de>
Content-Type: multipart/signed;
 boundary="=_MailMate_FBA2B802-F970-4A91-B52E-74509C1B90C0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL0PR02CA0114.namprd02.prod.outlook.com
 (2603:10b6:208:35::19) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.49.51] (216.228.112.22) by BL0PR02CA0114.namprd02.prod.outlook.com (2603:10b6:208:35::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 19:39:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edd3de9c-5f97-4a80-3913-08d8e3330219
X-MS-TrafficTypeDiagnostic: MN2PR12MB4469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4469D3BE22879AA24173934EC2929@MN2PR12MB4469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtOwfj6sbOvHeYtq85RmbWSl2xLG2I+oT6UZI0/Fx0w1VIH5iBSBbj5M8KWLtqi78l/q50Wnj8P0IoD0PD+v1T0RgXWRf3hJh7mejvFz9bYzyC3guZrB2ahrdsF92FjNQR5DpCAomzG+DibxC988wkLkDsQ4zFt3CYOa1HbGptrx9iVZH/EzOWAUNEQXrVOq4edremlyOnJAv6o+T5WYLTTWA3Yj2K6903P45GMkI77hiURTrxzXhmqAG6JFWKjj/W1V7cdoj+vcrl5wszU6f7fa2kDR2oMZm/SL8qhIjCwATrx0mW83X9QR/YnuwDlpFnbAnXDmtQ9Umk1IWFdzlPDgwWR8QuvLAs7p7oshDLQ4310kzM1TNtj1VYdqQjZQkqoK/uO3aqDaKcpaJ1hHUchhoeEkpQI5lE+qC80OEO5WCgVjwnA5iHYnTM5EpHFvSahSlnMqSRW5LtdIHl39jpVlldX4zC4KXdWC39L56NqZI+A8bWxI+qFmSBVFstszn2wKx02nVAuf7e/vBuXxq1l9TCb7dZObg5RM1iHx3hkmdUF5Ms3xTFEO+M28v4/rsuT1ypu+QWi8xBumtNf/Wo30LmFshFZ1O61p1j4jKG8Eg2zQcey2m/9C19IBNn//BSN1qJ01opmXBzWchLaiz3xhrDiPl5yIk88233UMr8BQcCC1ULsl3/7YXDatjhWm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(83380400001)(316002)(8936002)(16526019)(2906002)(186003)(235185007)(2616005)(5660300002)(66946007)(6486002)(66476007)(86362001)(66556008)(956004)(54906003)(33964004)(4326008)(53546011)(33656002)(6916009)(26005)(6666004)(16576012)(7416002)(966005)(36756003)(8676002)(478600001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SXBSVlpPaUxXL2hGcU5NSmVwSWdIbUZMb3B0UW1qaDJENy9yL0RscmVIQy9s?=
 =?utf-8?B?K241ZUhTQ1hWV0V5Y0hQN2tBSkJudGpXRUlMaWt6djhxZzZqUjRqQ25Kd01t?=
 =?utf-8?B?aUhtVnhaa1F5Z1ZOdzFibGdOQmprV2d5RUpBYTlJYmpyM3UvWXdNQUwyUWpm?=
 =?utf-8?B?cW9HTDMrYWN1d05CWWptYVNPdktxdWx3ZHlPdWJ4RzZ6Q0Q0SnV6YmZlNDB4?=
 =?utf-8?B?OFZtelVhRHJSQXIvUk9lZDRUY2k3NkJiZTExQkdiSVRYRHpmM09JMVhINWZj?=
 =?utf-8?B?UXFjYTlIcHhSUjRzT0tob2VCTVBtVjFtNEZxSHVOVXV0eFFkREhzWHJ1aCs5?=
 =?utf-8?B?RGQ1Zi9UUjFycWZ2ekp0RG9uUVhQTUFvRVlrYmVzYXlzaUhLVmJ1Q2lwSFZM?=
 =?utf-8?B?d3F4SDgvMTFKcFNLRTA4TGN2Q3BCc2svZzJpbThEeEk1VE9mQTdxQjBnZmU1?=
 =?utf-8?B?SFZYNWtEOTR3YkdFdEdCdWNmZlArcUdYOGRlZW1paUhOQmtFeEs1dG1yaXVS?=
 =?utf-8?B?YXFpendSdVROWXJPSzI2c3ZxQVVjK29XSkpJYjBLVGFXZEVUTlZ1S0ZvWjhj?=
 =?utf-8?B?VERUV0QwRnc5aGNWa01GL2hpcXJPZE5rU0cvVXZFYmM4N29LZFJ5MnA5aVQy?=
 =?utf-8?B?S3ptR0dhZ0RHSFpBUVBITUpTbUpGYnBYUU94QW54UnpNQlU4M2VzRzZTanJ5?=
 =?utf-8?B?N2NYSTVTZjE0dXpPdWt5M2c4NGkvVGNYbEVKU2Q2c05QdUxaeTlrNkVOeFlC?=
 =?utf-8?B?YkZsVFFWd1lTVnJ2TVYzWmFpR2RDeUdZZ3pOOEJQNjJ4Q2hQWXZOUXdoWVBC?=
 =?utf-8?B?Y1QycHRHRjJ1T1lxV3pKT2ZzUTBvYVNIeG90ZGp6MkxjbUw4ei9zc0phSGhm?=
 =?utf-8?B?R2tORkgvRWxmc1lJK2RmYWlROHRRa09OUmt2SDk3MDFLTXpxTGljZXVpakQv?=
 =?utf-8?B?R21yOERJaTNuUE9FSG53WnB5em1mWkVrNFlZcEVlMDBsTTdyWjhPdCtlQ1M5?=
 =?utf-8?B?Qy9mazdsMjhBdk1ibkRyNSsvejFPd0E1dmg1RTRZMkM2bmd2VGh1TzY0UURa?=
 =?utf-8?B?d29sWTFFS2pyNDBUQ01XLzdKazBNME9ibi9rNFkzblpFZlkvdkQ3ZkZIRHBO?=
 =?utf-8?B?UDZWbjVrRWFJNk91UUE1SXhUMkl2YjErbjFIcHczV3BidzRzUzN1cklaMzFR?=
 =?utf-8?B?SW1vOXhlMXhnYzQyalJLbTJ0WUZ5ekVwNER4azhGUmp4Q2VjUkVoTUtQeVZo?=
 =?utf-8?B?UjJUSDJFME1GdThkWVhsczdUeFJNS2hYb05KU1hzb2JaQ1N2OU1DTk1NanY1?=
 =?utf-8?B?UHl1WWFLdyt5Y1R0TmFmR0hzZmFGRC9YRk5IeE8yaDVIN2xxRkNKL3F4MEZF?=
 =?utf-8?B?d3JnNVViR2N5RWZmYm42UDIyb1FTWGV3TytOdEVHdmwxYTFVbUJlM0p3K2lG?=
 =?utf-8?B?VTJZTU9NeWxkUzZpZS9mRGt5blA1MjFLb0RsZ2tHQXY0OVp4eFlIS2Nic0Nk?=
 =?utf-8?B?RDhYWGdwNk1rZk9MSFZoRXVIYzNTbmJYN1hYRkV3eEJpRzZrdHBvS0Q0TmRo?=
 =?utf-8?B?cWZVSitCbktGVnhpRDlyajB1SXplSHFydGVWZ2VuMm9ucXd2eGJpYkxvR3VC?=
 =?utf-8?B?MW11N0c4YWVpRWNCUkJuL08xc2lTSXZsaW1JWEpZbm1MOGdTbWovWXJ5UlRF?=
 =?utf-8?B?Q1krckx2NmFveXpJNG0wVlhJcHlxcCtFRndPQWVoZ0JYL1hwdDFuUDUvU0NM?=
 =?utf-8?Q?hjjLO6BiRnORNmzA2x2iQOkb29UGURnCCjqcsyb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd3de9c-5f97-4a80-3913-08d8e3330219
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 19:39:09.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDtmpVPqQkEarYSlTrprWTtyuFOnvem5lZgdgjB/H3hQJ/m+ZDEzowFbW4CJESNX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_FBA2B802-F970-4A91-B52E-74509C1B90C0_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 1 Mar 2021, at 3:32, Oscar Salvador wrote:

> When the size of a struct page is not multiple of 2MB, sections do
> not span a PMD anymore and so when populating them some parts of the
> PMD will remain unused.
> Because of this, PMDs will be left behind when depopulating sections
> since remove_pmd_table() thinks that those unused parts are still in
> use.
>
> Fix this by marking the unused parts with PAGE_UNUSED, so memchr_inv()
> will do the right thing and will let us free the PMD when the last user=

> of it is gone.
>
> This patch is based on a similar patch by David Hildenbrand:
>
> https://lore.kernel.org/linux-mm/20200722094558.9828-9-david@redhat.com=
/
> https://lore.kernel.org/linux-mm/20200722094558.9828-10-david@redhat.co=
m/
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/x86/mm/init_64.c | 106 ++++++++++++++++++++++++++++++++++++++++++=
++++----
>  1 file changed, 98 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 9ecb3c488ac8..7e8de63f02b3 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -871,7 +871,93 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	return add_pages(nid, start_pfn, nr_pages, params);
>  }
>
> -#define PAGE_INUSE 0xFD
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +#define PAGE_UNUSED 0xFD
> +
> +/*
> + * The unused vmemmap range, which was not yet memset(PAGE_UNUSED) ran=
ges
> + * from unused_pmd_start to next PMD_SIZE boundary.
> + */
> +static unsigned long unused_pmd_start __meminitdata;
> +
> +static void __meminit vmemmap_flush_unused_pmd(void)
> +{
> +	if (!unused_pmd_start)
> +		return;
> +	/*
> +	 * Clears (unused_pmd_start, PMD_END]
> +	 */
> +	memset((void *)unused_pmd_start, PAGE_UNUSED,
> +	       ALIGN(unused_pmd_start, PMD_SIZE) - unused_pmd_start);
> +	unused_pmd_start =3D 0;
> +}
> +
> +/* Returns true if the PMD is completely unused and thus it can be fre=
ed */
> +static bool __meminit vmemmap_unuse_sub_pmd(unsigned long addr, unsign=
ed long end)
> +{
> +	unsigned long start =3D ALIGN_DOWN(addr, PMD_SIZE);
> +
> +	vmemmap_flush_unused_pmd();
> +	memset((void *)addr, PAGE_UNUSED, end - addr);
> +
> +	return !memchr_inv((void *)start, PAGE_UNUSED, PMD_SIZE);
> +}
> +
> +static void __meminit __vmemmap_use_sub_pmd(unsigned long start)
> +{
> +	/*
> +	 * As we expect to add in the same granularity as we remove, it's
> +	 * sufficient to mark only some piece used to block the memmap page f=
rom
> +	 * getting removed when removing some other adjacent memmap (just in
> +	 * case the first memmap never gets initialized e.g., because the mem=
ory
> +	 * block never gets onlined).
> +	 */
> +	memset((void *)start, 0, sizeof(struct page));
> +}
> +
> +static void __meminit vmemmap_use_sub_pmd(unsigned long start, unsigne=
d long end)
> +{
> +	/*
> +	 * We only optimize if the new used range directly follows the
> +	 * previously unused range (esp., when populating consecutive section=
s).
> +	 */
> +	if (unused_pmd_start =3D=3D start) {
> +		if (likely(IS_ALIGNED(end, PMD_SIZE)))
> +			unused_pmd_start =3D 0;
> +		else
> +			unused_pmd_start =3D end;
> +		return;
> +	}
> +
> +	vmemmap_flush_unused_pmd();
> +	__vmemmap_use_sub_pmd(start);
> +}
> +
> +static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, uns=
igned long end)
> +{
> +	vmemmap_flush_unused_pmd();
> +
> +	/*
> +	 * Could be our memmap page is filled with PAGE_UNUSED already from a=

> +	 * previous remove.
> +	 */
> +	__vmemmap_use_sub_pmd(start);
> +
> +	/*
> +	 * Mark the unused parts of the new memmap range
> +	 */
> +	if (!IS_ALIGNED(start, PMD_SIZE))
> +		memset((void *)start, PAGE_UNUSED,
> +		       start - ALIGN_DOWN(start, PMD_SIZE));
> +	/*
> +	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap o=
f
> +	 * consecutive sections. Remember for the last added PMD the last
> +	 * unused range in the populated PMD.
> +	 */
> +	if (!IS_ALIGNED(end, PMD_SIZE))
> +		unused_pmd_start =3D end;
> +}
> +#endif
>
>  static void __meminit free_pagetable(struct page *page, int order)
>  {
> @@ -1006,7 +1092,6 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long =
addr, unsigned long end,
>  	unsigned long next, pages =3D 0;
>  	pte_t *pte_base;
>  	pmd_t *pmd;
> -	void *page_addr;
>
>  	pmd =3D pmd_start + pmd_index(addr);
>  	for (; addr < end; addr =3D next, pmd++) {
> @@ -1027,12 +1112,11 @@ remove_pmd_table(pmd_t *pmd_start, unsigned lon=
g addr, unsigned long end,
>  				spin_unlock(&init_mm.page_table_lock);
>  				pages++;
>  			} else {
> -				/* If here, we are freeing vmemmap pages. */
> -				memset((void *)addr, PAGE_INUSE, next - addr);
> -
> -				page_addr =3D page_address(pmd_page(*pmd));
> -				if (!memchr_inv(page_addr, PAGE_INUSE,
> -						PMD_SIZE)) {
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +				/*
> +				 * Free the PMD if the whole range is unused.
> +				 */
> +				if (vmemmap_unuse_sub_pmd(addr, next)) {
>  					free_hugepage_table(pmd_page(*pmd),
>  							    altmap);
>
> @@ -1040,6 +1124,7 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long =
addr, unsigned long end,
>  					pmd_clear(pmd);
>  					spin_unlock(&init_mm.page_table_lock);
>  				}
> +#endif
>  			}
>
>  			continue;
> @@ -1492,11 +1577,16 @@ static int __meminit vmemmap_populate_hugepages=
(unsigned long start,
>
>  				addr_end =3D addr + PMD_SIZE;
>  				p_end =3D p + PMD_SIZE;
> +
> +				if (!IS_ALIGNED(addr, PMD_SIZE) ||
> +				    !IS_ALIGNED(next, PMD_SIZE))
> +					vmemmap_use_new_sub_pmd(addr, next);
>  				continue;
>  			} else if (altmap)
>  				return -ENOMEM; /* no fallback */
>  		} else if (pmd_large(*pmd)) {
>  			vmemmap_verify((pte_t *)pmd, node, addr, next);
> +			vmemmap_use_sub_pmd(addr, next);

Hi Oscar,

vmemmap_use_new_sub_pmd and vmemmap_use_sub_pmd are not defined when CONF=
IG_SPARSEMEM_VMEMMAP
and !CONFIG_MEMORY_HOTPLUG. It leads to compilation errors.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_FBA2B802-F970-4A91-B52E-74509C1B90C0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBHztYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK0VsP/jxwSSczQz4BODvi9viMfArpsep7boIMw4qv
0P2yG0o4jHcXzR54gL8EKP81/xIVNqOScyzShX8a8ejvT0hoApIIMgQSzPQ9Aq77
JGgaS/KPWbiuupm6SrNzABes3Gw0KqNLcInbKiLrDMW5vGx/2oQnzSt2TdY1yqEc
xfTBOzqTk4hhOjQA/qYF9hU/KTheJe1RDYljVTyqHVmVk6fuBqbU33W4tQKvXIX4
tpy8Fq5jNXheAK7wuNPA8ACzNzNIIRrsSGra0gcZTlKUB9Lcb3601TKoq+WgcOdv
3LPFYqphqRtLR/LyNqg/sjmN+j0JbfX9gOlK9UlmF1JlB9XfmHOm3syN7bo1a630
LrDfMhYCgLtMQakm6LN0LpCIPrb7pCh6k8Cj6/qIyNvWyQooBnzMF2xY50Po1Hs8
T1ceafccLZIOIn3NbsNt710P4T70fwtNLl/XOhnT33OrqS1JiYceMg7ItyOLOhvA
LcP/LHmdmWTHL3axzG5srY8xwZyheJUSDpEy4hLdUSl9mzzwDNUXHDrYdQPVGh8S
B2C5V0H/4CwBMJvzztMBWwdR5dAHkkjN8VyJWbJzsE25enfs2vBJvI/w8ZWBLblN
fD87NUDyYjBW2aGNaNQbQCZZ5F6PAFBYmQOpmRyH2cDFKSFSJWJlaxcVhn9u/7VE
haB9V0MP
=LBaS
-----END PGP SIGNATURE-----

--=_MailMate_FBA2B802-F970-4A91-B52E-74509C1B90C0_=--
