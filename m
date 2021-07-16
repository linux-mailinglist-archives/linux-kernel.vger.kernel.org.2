Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968B53CB213
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 07:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhGPFyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 01:54:19 -0400
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81]:9328
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231877AbhGPFyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:54:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N84D8p/dEPWJYB0hDR1Dyx7ulvcIZf+vCxTDPH51f7oIopInxTquI0ZlQgNrVP5M0wajpbuBGY6vKoQPg60fETHFEbDlel11Bb3ncDDCNqdrojargXd8Q7o0tLeHZTpjeqyAEowz5iUrLuDklWoHC9z9lsV4oFvm3s7A0Hy/5+zDmTrs4CldmAFkE9wL2kakWXRTbK0Ukq2/gBYRK2k0bpSCbKlyXQ3KGTzD+NXDqQgjz5l6c179LZWikOeAVpO3n6jItZEgwdCOqN6SikjJ5YnIq1C59RL0hxZ1MMaaXqtc6kGYVyIp5W0zhwD4MJ4AS6heV8YiQ9ZC66V3NUjH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obaOxJlIdRbJ/EM7SakLYXWL7mmywNXl2IgB5T1TXIA=;
 b=Yq/zDXJhU2ub0n4dJtCtYyNulalSIWyDfoQiZ1LYdaA+V4Cl3zDeNiEpCJo/6IAQ7AMmWIESFLwUMwrFiXgX0H/baXJSkO6ifyctP5mdV+xLiPPpRXC5zcypR8irqY6QMFbZ2GaWm8elubF3ZYSCNT7xrLYSLJ4Do9i92NJ0dc+S+f13qZkBmb501lnWw4iMlYoqKW+OJF9RGTOYneLjbZGc9Jv+hxFKaSeRP3qp9bK9OPIL0whvowDzmGZrJXm+3WxsjJd96DEDS23eoIVv2EEah/SdejOeSJOaLvvPeoM4e4xR3WIWVZB6kvnOfKO1pX0cDU+/98X/Y6U9kLWx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obaOxJlIdRbJ/EM7SakLYXWL7mmywNXl2IgB5T1TXIA=;
 b=I/JhAoW9BXaLiSgFgx8w40PrXz3MYRa1rTgDIVKndkyrHpe+R6Z2Gi0bcRtrIlF4iVV5gDToGNI6iPuu1+5mBQyenijLpwA3hYSt2hFd8BgB+eYDzRHn0xL2UDkvYEgFje8OpFBA2WPOBNENZ6qtWT8r51TPGikeSZ47S3qK4Xne4mX6MtceaHZ+YWMr18OGQn0dCujEmD2Si2Irc/RHTCfFPRHInNFdan03Nus36d/yqTQKhGDIaxf7SS2uQvQK42+SgN+fB6U/cTfLCx6uvzDlGvpKgGClpcZNjIyMhERnwhTCaMXm9xibJzW2TU3yudItySlxozkuIgUBtDY5bw==
Received: from BN6PR1201CA0020.namprd12.prod.outlook.com
 (2603:10b6:405:4c::30) by BY5PR12MB3667.namprd12.prod.outlook.com
 (2603:10b6:a03:1a2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 05:51:21 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::6a) by BN6PR1201CA0020.outlook.office365.com
 (2603:10b6:405:4c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Fri, 16 Jul 2021 05:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 05:51:20 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Jul
 2021 05:51:03 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v5 05/26] mm/swap: Introduce the idea of special swap ptes
Date:   Fri, 16 Jul 2021 15:50:52 +1000
Message-ID: <6116877.MhgVfB7NV9@nvdebian>
In-Reply-To: <20210715201422.211004-6-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com> <20210715201422.211004-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12377b3a-1d84-41d2-609e-08d9481dbcfd
X-MS-TrafficTypeDiagnostic: BY5PR12MB3667:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3667099BD799B0BF162621F9DF119@BY5PR12MB3667.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xpyDzhnTNfnC4ouNrcSrwDoqFyqJIe65ODFziryLNnamuM1MtEeGtlTQwSAuVAAKkQTLnsCqZ1ZfUKm4kb/syhJOxhR29PEzyKLTqEySjkpOyj8S3w7QC5M7r0W0L57X74jimIYdj8vNAkaVelorAPHoO75xOoK7JigdGFjT/fZ9nmEIZletWNgOgaFfQdeM4OdXJ0+/MeS2mQ4mp6RMDPmWdBPvmT/gGUUhNvdMH/vpDYFeNmkLY9ov1XsGGrmLm1I5oFoRIjBI8b2nCfE222sn35AV1ApHFFzmBuCX769llSjIZ1H0LzZWIJ3Ty7TzuzeRzBnEx9L1gCYy2vuGsaaQGlvb45F84FH8W6TeuCAcZwAMAVR/BUEyll9fsNXY6Xd/ZrJp1gg8HhX58UrpnLrKVhzbb14DKtzMGBAhExexioAwWItBtXrR+ZMhu/HTR2T3MzDd0wqtO7o6lHSoAAL7OKoRsr5E/y+/HHdUlm4Jao5qKQj8DA2h3WF40UNGcKpP0v4yPQKnmZtP9kjTjUp1TCrFtLAtD2aU2pE1mo5ShhAkevDIfeORmGAoCF8qvGXGlrh42gNX/Bu/xa5WqqfGGO8M4V2Qk8vixR1LYFQXOqKLTkc4B+YqpuVFwP7qsgcHMb15xmbGYG2AspPzvsLd2X9ffMPyqBTMweR18++UA4W7aGB5A10BwsFri8Wv3Zteni6/npUzVY9OpEi4h4lQIpA4GEA+xaxPzyAfGXE86WI6rA2PuiXAuB4xlwRQXImbdm9yWyD0UXK6MfuXQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(478600001)(7416002)(70206006)(8936002)(82740400003)(336012)(70586007)(86362001)(426003)(6916009)(26005)(54906003)(186003)(83380400001)(4326008)(47076005)(9686003)(33716001)(16526019)(36906005)(9576002)(8676002)(2906002)(7636003)(82310400003)(5660300002)(6666004)(356005)(36860700001)(316002)(34020700004)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 05:51:20.9680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12377b3a-1d84-41d2-609e-08d9481dbcfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3667
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

[...]

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ae1f5d0cb581..4b46c099ad94 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5738,7 +5738,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
>  
>  	if (pte_present(ptent))
>  		page = mc_handle_present_pte(vma, addr, ptent);
> -	else if (is_swap_pte(ptent))
> +	else if (pte_has_swap_entry(ptent))
>  		page = mc_handle_swap_pte(vma, ptent, &ent);
>  	else if (pte_none(ptent))
>  		page = mc_handle_file_pte(vma, addr, ptent, &ent);

As I understand things pte_none() == False for a special swap pte, but
shouldn't this be treated as pte_none() here? Ie. does this need to be
pte_none(ptent) || is_swap_special_pte() here?

> diff --git a/mm/memory.c b/mm/memory.c
> index 0e0de08a2cd5..998a4f9a3744 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3491,6 +3491,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (!pte_unmap_same(vmf))
>  		goto out;
>  
> +	/*
> +	 * We should never call do_swap_page upon a swap special pte; just be
> +	 * safe to bail out if it happens.
> +	 */
> +	if (WARN_ON_ONCE(is_swap_special_pte(vmf->orig_pte)))
> +		goto out;
> +
>  	entry = pte_to_swp_entry(vmf->orig_pte);
>  	if (unlikely(non_swap_entry(entry))) {
>  		if (is_migration_entry(entry)) {

Are there other changes required here? Because we can end up with stale special
pte's and a special pte is !pte_none don't we need to fix some of the !pte_none
checks in these functions:

insert_pfn() -> checks for !pte_none
remap_pte_range() -> BUG_ON(!pte_none)
apply_to_pte_range() -> didn't check further but it tests for !pte_none

In general it feels like I might be missing something here though. There are
plenty of checks in the kernel for pte_none() which haven't been updated. Is
there some rule that says none of those paths can see a special pte?

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 23cbd9de030b..b477d0d5f911 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -294,7 +294,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  
>  	spin_lock(ptl);
>  	pte = *ptep;
> -	if (!is_swap_pte(pte))
> +	if (!pte_has_swap_entry(pte))
>  		goto out;
>  
>  	entry = pte_to_swp_entry(pte);
> @@ -2276,7 +2276,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  
>  		pte = *ptep;
>  
> -		if (pte_none(pte)) {
> +		if (pte_none(pte) || is_swap_special_pte(pte)) {

I was wondering if we can loose the special pte information here? However I see
that in migrate_vma_insert_page() we check again and fail the migration if
!pte_none() so I think this is ok.

I think it would be better if this check was moved below so the migration fails
early. Ie:

		if (pte_none(pte)) {
 			if (vma_is_anonymous(vma) && !is_swap_special_pte(pte)) {

Also how does this work for page migration in general? I can see in
page_vma_mapped_walk() that we skip special pte's, but doesn't this mean we
loose the special pte in that instance? Or is that ok for some reason?

>  			if (vma_is_anonymous(vma)) {
>  				mpfn = MIGRATE_PFN_MIGRATE;
>  				migrate->cpages++;
> diff --git a/mm/mincore.c b/mm/mincore.c
> index 9122676b54d6..5728c3e6473f 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -121,7 +121,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	for (; addr != end; ptep++, addr += PAGE_SIZE) {
>  		pte_t pte = *ptep;
>  
> -		if (pte_none(pte))
> +		if (pte_none(pte) || is_swap_special_pte(pte))
>  			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
>  						 vma, vec);
>  		else if (pte_present(pte))
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 883e2cc85cad..4b743394afbe 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -139,7 +139,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  			}
>  			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
>  			pages++;
> -		} else if (is_swap_pte(oldpte)) {
> +		} else if (pte_has_swap_entry(oldpte)) {
>  			swp_entry_t entry = pte_to_swp_entry(oldpte);
>  			pte_t newpte;
>  
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5989d3990020..122b279333ee 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -125,7 +125,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
>  #ifdef CONFIG_MEM_SOFT_DIRTY
>  	if (pte_present(pte))
>  		pte = pte_mksoft_dirty(pte);
> -	else if (is_swap_pte(pte))
> +	else if (pte_has_swap_entry(pte))
>  		pte = pte_swp_mksoft_dirty(pte);
>  #endif
>  	return pte;
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index f7b331081791..ff57b67426af 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -36,7 +36,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
>  			 * For more details on device private memory see HMM
>  			 * (include/linux/hmm.h or mm/hmm.c).
>  			 */
> -			if (is_swap_pte(*pvmw->pte)) {
> +			if (pte_has_swap_entry(*pvmw->pte)) {
>  				swp_entry_t entry;
>  
>  				/* Handle un-addressable ZONE_DEVICE memory */
> @@ -90,7 +90,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
>  
>  	if (pvmw->flags & PVMW_MIGRATION) {
>  		swp_entry_t entry;
> -		if (!is_swap_pte(*pvmw->pte))
> +		if (!pte_has_swap_entry(*pvmw->pte))
>  			return false;
>  		entry = pte_to_swp_entry(*pvmw->pte);
>  
> @@ -99,7 +99,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
>  			return false;
>  
>  		pfn = swp_offset(entry);
> -	} else if (is_swap_pte(*pvmw->pte)) {
> +	} else if (pte_has_swap_entry(*pvmw->pte)) {
>  		swp_entry_t entry;
>  
>  		/* Handle un-addressable ZONE_DEVICE memory */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1e07d1c776f2..4993b4454c13 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1951,7 +1951,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  	si = swap_info[type];
>  	pte = pte_offset_map(pmd, addr);
>  	do {
> -		if (!is_swap_pte(*pte))
> +		if (!pte_has_swap_entry(*pte))
>  			continue;
>  
>  		entry = pte_to_swp_entry(*pte);
> 




