Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE2B3CFAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhGTNEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:04:04 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:31201
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238615AbhGTM40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:56:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=armf0TPMnVWpZaxXvw27mbI+KaddFka6xqPdp1cY5Xw8/mt9JrcMKSjCNfTejksSu/FXmTOQVOpdZVXIM2yz6Z0wMNGqmRkUGNWeqBisVHDCAX9rRInTp3bx6NUm0fMvNMFo1sIqSC4gAojcR7aWeyvnPYuzJ6xreTaWjULoFAt5mCMPiuKvz5q90YVStRF8SGDGX71+woJr7k9ihkBwYQSp6g8DgAvsJd/hkmZsKyGxqWwHayvjTM7/LJ0ddk6b1+EqlCtAdOaymu9PsC6/RyefW8Lj205/ZzCvijkf9TIVsfMOPo2HZ7UGOb0vTdCaW1AR+Tie46ovp2zP9fYRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DAoHBcSU3hUMkJNO/wWfTBTq7hgniAiC5XWMWFCLSo=;
 b=Scdp+zk9uHWjrb193Ph6/pzqzoJF8/CThw2LZ6kORn5pIYWwfqj1EZaMJfyF8HWUormw+LNbEPHhCxlNgNn1l2dN8c0W4aGZYu3pDA3+9jlSsxWWPmnNhNzDE1KGUxpNJgTx+0BswwM7+JIZtiSanDU4XyYilJaiQZzKea+zDG5f0+5RdfXYdhrWkALDoUzFKt3N0Ic2VUzf3qu1DsPc/gpBBo1HrW3LssGZq6LQ+luD53C1U72fvxWEFERBpNtj//xFaW5OuzWDvHvab8vL/EG+LEzm/XlZV6cVbdBxrPBqSX++nXiEwlXjfVuqZAcakKaHkfdLBb5U8N+h4jP8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DAoHBcSU3hUMkJNO/wWfTBTq7hgniAiC5XWMWFCLSo=;
 b=UP8QGTeR/gCfWfd6Asskwad9A6XImK7wHlmM4wW2NSqMQHJA3RhDgwfrObo+SwlL2J9ZQgOeYEuVM/yMQvJHzQmYVV4XBuiFbdoZUw89N3zhUhprRyDgYGBxJEJ+SamijyEzx4MzQnsBTyZ8vS++m9Mm1hSWPBKFtruWw3VBosMfuIKjZihEGlMk1wYUX2mcfSWqDkHZQGkVgtD+J7N7Zkd33yU1QfxH4/QS3uquw/M9prQbIKoLq5jOSf9jzfhKrbEvTn1LUmMQSqsfEnfm3DhUBFAeb+er0kpyjhohPMhQwkVu5aTOu1y/dkbvlwZbSPoFieO/VqnluO8ov4iHAg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB2819.namprd12.prod.outlook.com (2603:10b6:208:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 13:37:02 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 13:37:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mel Gorman <mgorman@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] mm,do_huge_pmd_numa_page: remove unnecessary TLB flushing code
Date:   Tue, 20 Jul 2021 09:36:55 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <CD7E5D4E-5243-47AE-8EAB-F9E05E19D374@nvidia.com>
In-Reply-To: <20210720065529.716031-1-ying.huang@intel.com>
References: <20210720065529.716031-1-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_7F5B83E3-998B-4F45-A611-699277F823EF_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:208:e8::28) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [169.254.91.100] (216.228.112.22) by MN2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:208:e8::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 13:36:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4847b3f5-5017-4e20-43af-08d94b837495
X-MS-TrafficTypeDiagnostic: BL0PR12MB2819:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB281954624A85975CBADD9DC9C2E29@BL0PR12MB2819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZCH6OtBX5Rguzy5K2ugwhO/QI0v9IsvIoXfFviB+W+oBKLPHSH+hrZq9eCRHDgd4DmxR+UOhverD4kctpDPwPxcXIv4HKSYPz+QSjZD+1LwKa2LXcjGV7HqwlyVWwAFraMpH7R78A/0amKd2U5Gu3vL2SWBy80N3ofPPFZVWDqc4FjCG025tCqAVUnGUUXACXLnvl9mhfz/22xh99llMGuvasjJipSg1lsD/N/SJxfDtYseoEKMD58v2nTeA5/ePFz2QuFVREQx5rlhteKkOWJGCLvKB1I/sSPbROssfQszwiCVFTBtsQDCzkVOgznAPOIMgzf3L05M/JIQJNCvLwJCWWjEu9HtXDxdBQbIrG6dz+HLkraBsw55WQ35EkGHfdNpPlcVhijmHmQKCCdqF1Y+zHfUBOZGc0q1w8vbi0yPOuPGnTfiebC/QeWP7BfQ+9BjIk+GA3lx8OmvYN+0NxQ69QdeKY010R1pQgyBTEgi8E9YttVlwokUCJZJlt6AakbGHpJ0qz+yl0Cca65DGbWwcFOTc6S3i89m+6ev22XJ989dGXBbIh/lwcGnhT/XapwIRZlcWJbHqEoJunFzRq86onidV+/KwV1DJpGB0wsLJ/5xmjNu1FCvLH7l3u+rhJIf7NsAX4c/eBsLqjTm5YM7pKXsdp/4ETnRhV8vkwnAvyknD/xI8gPUk+UuZrWTyy1GxQ9RMtoIEcH0/dtpb2ppsqUehqkdUOwa025bbXtCDhiwpxs2nGbcdRdSZftUSS6n60kpi4JzXN5DKfxtlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(235185007)(16576012)(33656002)(8676002)(6916009)(316002)(38100700002)(6666004)(54906003)(53546011)(5660300002)(956004)(8936002)(2616005)(7416002)(2906002)(66556008)(66476007)(478600001)(6486002)(33964004)(26005)(4326008)(186003)(36756003)(21480400003)(83380400001)(66946007)(86362001)(14583001)(78286007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmNPR1F0VGFINGtreEtSNXFkUHhXQnlsZkRPQ08wME1aT3lmUnNvcm0rMkRD?=
 =?utf-8?B?bkQ3cGZia3NSazJibzlNSDNESGY4WHNGOGJ2bDZkNzgvVVZFNEU5emw2QUtJ?=
 =?utf-8?B?aUZVYXBEUFV1SlEyTGxCbFE3bmF5TzNYcjBqMFlFajFxVytqYlZGQW41TVh5?=
 =?utf-8?B?ZTR3NWhwQXJYbHVpeFpFK29vMzN4Uy9xSSswOVd4VmI4eDZOTnpuNnM1MEtW?=
 =?utf-8?B?OWJLcmFyUjI2WmlpNVBOTGJ0OUhJVVB1MmZHbmcxYUpwdlBxSlB1NzJKL2dH?=
 =?utf-8?B?YUVwRDNQSHVwSURkamVSZ2RIdHVMMS9lNkFrZ2NVWWlMN0x5ampucFhGbFRy?=
 =?utf-8?B?R29rMHgzUnJBR1dsOEpOZmYzVXZPSlZ2b2ErL3o3dFZpTTd4Uy9NUng0cnAz?=
 =?utf-8?B?bTdFK00xaU81VGpQa3lLbW1Rc2tsYUwrVi93b0lZSDNUWXY1Q0dsVzVKT2ti?=
 =?utf-8?B?c2xwd0FRTmdtSUcyaHd5QnNHcG5KV2lpWjZ0MmpoM3R1Z1dFblE0bXl0WEFs?=
 =?utf-8?B?S2szN0d5Q0o5cmxIQndpeHprUVB2c0ZmWHQrWWp6RlV1bEZBRktiUTBjUVo3?=
 =?utf-8?B?eFFZVk1ZU1VDSG9kQWxIVXJaT0lWOE8vSlVrWEx3VjRzUmlDSjBZNEdxU2g3?=
 =?utf-8?B?MDIvbTRNc2lEdHArZDZ3VVZyQ2NJOXFrNzVkeGJkdzQzWkozNkVsL0g0SDEw?=
 =?utf-8?B?OW9wRURPWWRyclZmeGV2UEkzYTVZc3FUNFA0dnRIQjJpZzA2NnBGQ05pYUZB?=
 =?utf-8?B?V3FmaUMrTTkyTmo1K2wvMFl4VWRYU2hRbVBKWFpkbUFNRXhJcE0wVUNnWTJR?=
 =?utf-8?B?WE0wZFN3K0JnNXhhWlpRMXJoWmdNYkIyZGlQeVBieXR2ZklFLzdDdWJPNDFX?=
 =?utf-8?B?NlRDYlhHZTROcW1wMSsvVlI0MURUMzhrWnFCSWlUTzVVTXh5WVEvY3hvc2lo?=
 =?utf-8?B?czlDOW9JUmxpZWVVN2x3NjRJcExPRDJwRzE2UFc4a01OY20zekkrbWxFSWlY?=
 =?utf-8?B?YThEZC9Tck5sVHBJc2tyRStlbFFIYVhocm5zdm1UTnJieU9LQUdsbURQYmI0?=
 =?utf-8?B?RGs5UGNia0Nsb2xRekxOYm1MWmVQd0s4TU95VlJmQmp4ZFZIVlFKcVlidG5X?=
 =?utf-8?B?UzVqSE1RaGg0UXoyVEhCNzhPQkpUdUl3SmZNNm9HdTF4U1ZQOVplamFCL08r?=
 =?utf-8?B?RXBvUFNzUHlVVFJIN0wwUnA1aXpGQzBLUnYwelNyVVFnVlhaWEk1d2k3VTF4?=
 =?utf-8?B?VWJwdkZaZm9vK09Td3MweWY0S2dLejNPVThoR1NoZ1hidVJRWkZRVnFzNjFE?=
 =?utf-8?B?enVhWktwUS9ERVNYNHhTb2tNMU1Lc1oxS2xqLzlpUTliWFk0U2xjRHAxNWJt?=
 =?utf-8?B?QVVuR0lzVmp2bnhVVm16R3NlQzVPOXloTHZrWnd3MGp2TVBvTjZybUJJSEhC?=
 =?utf-8?B?ZlR4WGJqNU4xWVM1a2p5VjZQby8rRXhzWWJ4YmxNamJrOWRsczJXV2xDV1dq?=
 =?utf-8?B?N3ZhZ0RwcjM3V0NiREVDeTZ1UGVWc21pWHg3emlOQzVlMGowKzZRT0FicTZX?=
 =?utf-8?B?RUlrMHhPVHk2SzBkRzlVT01nNzZjbHluWXlVNXYrK0NBanNKVHpwOTFwWS84?=
 =?utf-8?B?MjhFdzBsUnZ4REFTenhwZ1NsSVMzNkFmQ2FEZy9PbzJHWlZaKzc0eEtDRFoz?=
 =?utf-8?B?ZnJaUUsxNFFWWE1KSzlCbmNFR3Iyci9HRExuLzZxb2c4ZXNBdmtjdlR6TDBJ?=
 =?utf-8?Q?DfoFGma0U+J6BApCWNqxiOlfT+NENagMYxS53bq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4847b3f5-5017-4e20-43af-08d94b837495
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 13:37:02.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1WmEoqcrOazWJqLL/r5PefcNNnVK5AxQdunhdBnrc4rQeolzjDyPZQgNoEX/cBZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_7F5B83E3-998B-4F45-A611-699277F823EF_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 20 Jul 2021, at 2:55, Huang Ying wrote:

> Before the commit c5b5a3dd2c1f ("mm: thp: refactor NUMA fault
> handling"), the TLB flushing is done in do_huge_pmd_numa_page() itself
> via flush_tlb_range().
>
> But after commit c5b5a3dd2c1f ("mm: thp: refactor NUMA fault
> handling"), the TLB flushing is done in migrate_pages() as in the
> following code path anyway.
>
> do_huge_pmd_numa_page
>   migrate_misplaced_page
>     migrate_pages
>
> So now, the TLB flushing code in do_huge_pmd_numa_page() becomes
> unnecessary.  So the code is deleted in this patch to simplify the
> code.  This is only code cleanup, there's no visible performance
> difference.

But we save a potential TLB flush here right? Maybe the if statement
is not a common case.

Anyway, LGTM, Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index afff3ac87067..9f21e44c9030 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1440,32 +1440,6 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault=
 *vmf)
>  		goto out;
>  	}
>
> -	/*
> -	 * Since we took the NUMA fault, we must have observed the !accessibl=
e
> -	 * bit. Make sure all other CPUs agree with that, to avoid them
> -	 * modifying the page we're about to migrate.
> -	 *
> -	 * Must be done under PTL such that we'll observe the relevant
> -	 * inc_tlb_flush_pending().
> -	 *
> -	 * We are not sure a pending tlb flush here is for a huge page
> -	 * mapping or not. Hence use the tlb range variant
> -	 */
> -	if (mm_tlb_flush_pending(vma->vm_mm)) {
> -		flush_tlb_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
> -		/*
> -		 * change_huge_pmd() released the pmd lock before
> -		 * invalidating the secondary MMUs sharing the primary
> -		 * MMU pagetables (with ->invalidate_range()). The
> -		 * mmu_notifier_invalidate_range_end() (which
> -		 * internally calls ->invalidate_range()) in
> -		 * change_pmd_range() will run after us, so we can't
> -		 * rely on it here and we need an explicit invalidate.
> -		 */
> -		mmu_notifier_invalidate_range(vma->vm_mm, haddr,
> -					      haddr + HPAGE_PMD_SIZE);
> -	}
> -
>  	pmd =3D pmd_modify(oldpmd, vma->vm_page_prot);
>  	page =3D vm_normal_page_pmd(vma, haddr, pmd);
>  	if (!page)
> -- =

> 2.30.2


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_7F5B83E3-998B-4F45-A611-699277F823EF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmD20XcPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKhHEP/RcrpAV0HutdZ/bePNQb+Nggiz2IDbslnAVF
xovRDEf4FmTLoGHhEh2PNRwk+JdO1hVZuzxsRyzvwykH+5Wp+eJM+zVXPZUPrgw2
Sir+qON3uZzc4r8h4M+qF6svTcjbcBcaTIPKqR+4Q0ms8p2DcIoma8fNgy0+Q5WG
bXLg+/J8ttpu2esXaLn9yYMXVgQptNr0qIsUwRnut4kU6txz/GO8pMZz+iPTvzVR
+X8uLP/XkcU6bsO3livZ8y6x+ni7q/PrcGDQyJc1tOcISD84WBjG4zrwfyEgBqe8
N94MBTuSOKJP8u872e8yuJ9oUv+zKq7QYtVbWXEi81A0BaMZGeLP4o4iXTX25KOZ
vadm047BtiVpkXmKV6D/FRq7tUQOTl97usp4SC/c6CGSYtkcS36RKnW/UTIcX8zz
yQJhkQkrq9bRF8nVpfmzI/2sZfPMNkWtRjeHhQTcckd0/lF7gpw2F4+SoOdGUG/s
XUqgjdE94OqwzDnABAE/35e2kj7u2KoOIU8oPHykixOk0SZaBSJVtXLOlwzPYNRW
OwVqXwzScIW1Gj+csvRPWext3nu9/89EXsb3J3dSDlJ7t7Ocmo55qvrLJ9cfB/8D
ZayIMIrWsYRMkQ4xuS8fHXrfVrFLJ9EzzjzUDSJb5JX0u21awqDXz4voMmrlTpHo
npI7wSbS
=Za01
-----END PGP SIGNATURE-----

--=_MailMate_7F5B83E3-998B-4F45-A611-699277F823EF_=--
