Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F563D0DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhGULAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:00:09 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:29886
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238022AbhGUKsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:48:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4+WnrkCifBozco+vyDWkgz6INnPSf61x8eDh56XK0ysEiJvt0OdkZ1/JY/4vkyh+xIXUu0cufrqSNP0/bCesu+56848CKoVQXEE0m4Pc4k1ZIoBsWRZacFsnjQ/1kOyUAfgxwb5/6TWdJMkPACAOnAa80JQBP3MxWfUMkIVwGutEBhW/vc8RSiSsVYAZIsx7gESSk7auW0rJKJIX7v9qJW0xeaYWY05byMDVdrlNGb1Er90k+mcgkXrzbzf2BfPK1jhamp6y+/Ml4LTPSRBZhgZffua2ie1bG6SLqxripHA4Yq4u6EwvC3Z6zF2yFR6rEcu29S6UAqaX9Yi2Ltz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF6SHkGfmVtcYPSE+o4xlhadoHc5IkV6eCEeFc8lX10=;
 b=NblfldAeBiJ7J2VwYjzAyQy2WBcFNLX3UCUg7D+AxFI+gVujw50dj0nU4iED7jq4vN529kFgiKxjPQ0M3ow3je0hk6OT7080bORO5bDrTpVxuz20CGZ868RmAcWAsSLmm568PSl6k//w5YaAqItjGCDgfUTzr7gR2Vb4YJT303VDU4ecX99X2UsMNxkgSbQ3FuhM+eRoDJ97XlBkco4xghAx/LexDbvDy8jqGw4lbmjhUQYi2zDa0Dvs01y34Gb0o7BH267AyirQXEtdCZQTeja80Qt0j4YLb336HkmXGfaj8Kx2fSwCamuh6EvBbQJxhggY2T1IzFHwJEYJS0JafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF6SHkGfmVtcYPSE+o4xlhadoHc5IkV6eCEeFc8lX10=;
 b=tcdzUzM9+rlThCkOnLbjHtyu7hkrs53/tWszhYQZwljOO4obCETeLjPpfl5d2F6plD0Uxpwe1gLOFrdzDJAwDIZk/pvI9fysqADdG3uPxrx1Ra+ibKVE9nvrResgSLGfIV1IosoizMO26qKh3Ugk8rFGnZYake/pNmDpGYyaT49qffJIHlHKObv5yeTcqdu+FNq/V8g5gFy574r+/tRy5RJ4jvNhT02R0yseSxz81iFvlVvdp2hTq4Tgn7e7Y+lIeqgzVKvR2Ps3/IEJwzDS1PPhoArZDDN1n5wlggzk3/P/WgFUHmm2lvvgnraShxo+XdNc4XccVXv69f+7R+NdIA==
Received: from BN0PR04CA0197.namprd04.prod.outlook.com (2603:10b6:408:e9::22)
 by BY5PR12MB4833.namprd12.prod.outlook.com (2603:10b6:a03:1f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 11:28:56 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::7) by BN0PR04CA0197.outlook.office365.com
 (2603:10b6:408:e9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Wed, 21 Jul 2021 11:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 11:28:55 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Jul
 2021 11:28:52 +0000
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
Date:   Wed, 21 Jul 2021 21:28:49 +1000
Message-ID: <23927325.GfNbO0Vjio@nvdebian>
In-Reply-To: <YPHZ5cCv+I/hLO08@t490s>
References: <20210715201422.211004-1-peterx@redhat.com> <6116877.MhgVfB7NV9@nvdebian> <YPHZ5cCv+I/hLO08@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ab829a5-52f6-46fd-6db0-08d94c3ab9c9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4833:
X-Microsoft-Antispam-PRVS: <BY5PR12MB48338B7B67B5839E3E59B28BDFE39@BY5PR12MB4833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/zkk7S9sTluom82KI/enZKSIwXZO5PJhynqY2oWXysCmiSzJ5S7lTePkkpC30eN35AToe3R82Iq5FTr18tniuKm0b7GiPMMdWkWls4Eagsz3LaBZgG/2zyfJ0wrWGxoIQ2IWJzdT5Pfe4vfmL3zcl9iAhAI9rvquU4NOhpWCpiBAnuWQRUFD0BPnIu1mSEMxIBpgKcrCKkCeFkFG1PP/vK5xVbMb3ojHcT8asi4Q99mSfxoFzaJNsF72jVfCNzBiiTT+Q5Awc3i27/KI8fdESFdzVTRuJKajg+fX/Bkh6X7ZJJVPvCzJXVpKqIuCsotv3lJwTIq9Q/pAsnugKTYm/kcS2guO+UM224BFYOdU0nvBTCVlVmEGE/zlgQUxRRbxAzrHDis85NdFWzKS9jPWFIDMkrFMm3l4225Plu6c14AeCstSonxfNREQAmrWwSgF91a6TF0QND5hbb/yVkFRbSpGbRfUjWHrX9CkarGbu+wtdCoDecVA9KKWIbHPd10zXyv7kWE2H8SkR7lM9rQFHvsSPB4iaeKb0HMVIq1tGgv83ioxyCc9mzNoWWa4zrQA3bzPBL1bEgEHa+CtGQdkYwowEU33NeL5alre7lmuNtS6z6BnFrx0mn38NG6LEZnLI3zLMfATZUo+fAnPXUsEfb2MDOJgy2aT8BWXw2FSoaZkymAaS6+UEeBk1HdGPJJLTNGn5+mBuadJtGUo5SsIRsznFFPfKA3uc0pzpGq7M8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(36840700001)(426003)(316002)(36906005)(82310400003)(8676002)(33716001)(47076005)(54906003)(7636003)(6916009)(70586007)(70206006)(478600001)(5660300002)(356005)(86362001)(36860700001)(2906002)(336012)(9576002)(6666004)(83380400001)(26005)(4326008)(7416002)(16526019)(186003)(9686003)(8936002)(82740400003)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 11:28:55.6866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab829a5-52f6-46fd-6db0-08d94c3ab9c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4833
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 17 July 2021 5:11:33 AM AEST Peter Xu wrote:
> On Fri, Jul 16, 2021 at 03:50:52PM +1000, Alistair Popple wrote:
> > Hi Peter,
> > 
> > [...]
> > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index ae1f5d0cb581..4b46c099ad94 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -5738,7 +5738,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
> > >  
> > >  	if (pte_present(ptent))
> > >  		page = mc_handle_present_pte(vma, addr, ptent);
> > > -	else if (is_swap_pte(ptent))
> > > +	else if (pte_has_swap_entry(ptent))
> > >  		page = mc_handle_swap_pte(vma, ptent, &ent);
> > >  	else if (pte_none(ptent))
> > >  		page = mc_handle_file_pte(vma, addr, ptent, &ent);
> > 
> > As I understand things pte_none() == False for a special swap pte, but
> > shouldn't this be treated as pte_none() here? Ie. does this need to be
> > pte_none(ptent) || is_swap_special_pte() here?
> 
> Looks correct; here the page/swap cache could hide behind the special pte just
> like a none pte.  Will fix it.  Thanks!
> 
> > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 0e0de08a2cd5..998a4f9a3744 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3491,6 +3491,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >  	if (!pte_unmap_same(vmf))
> > >  		goto out;
> > >  
> > > +	/*
> > > +	 * We should never call do_swap_page upon a swap special pte; just be
> > > +	 * safe to bail out if it happens.
> > > +	 */
> > > +	if (WARN_ON_ONCE(is_swap_special_pte(vmf->orig_pte)))
> > > +		goto out;
> > > +
> > >  	entry = pte_to_swp_entry(vmf->orig_pte);
> > >  	if (unlikely(non_swap_entry(entry))) {
> > >  		if (is_migration_entry(entry)) {
> > 
> > Are there other changes required here? Because we can end up with stale special
> > pte's and a special pte is !pte_none don't we need to fix some of the !pte_none
> > checks in these functions:
> > 
> > insert_pfn() -> checks for !pte_none
> > remap_pte_range() -> BUG_ON(!pte_none)
> > apply_to_pte_range() -> didn't check further but it tests for !pte_none
> > 
> > In general it feels like I might be missing something here though. There are
> > plenty of checks in the kernel for pte_none() which haven't been updated. Is
> > there some rule that says none of those paths can see a special pte?
> 
> My rule on doing this was to only care about vma that can be backed by RAM,
> majorly shmem/hugetlb, so the special pte can only exist there within those
> vmas.  I believe in most pte_none() users this special pte won't exist.
> 
> So if it's not related to RAM backed memory at all, maybe it's fine to keep the
> pte_none() usage like before.
> 
> Take the example of insert_pfn() referenced first - I think it can be used to
> map some MMIO regions, but I don't think we'll call that upon a RAM region
> (either shmem or hugetlb), nor can it be uffd wr-protected.  So I'm not sure
> adding special pte check there would be helpful.
> 
> apply_to_pte_range() seems to be a bit special - I think the pte_fn_t matters
> more on whether the special pte will matter.  I had a quick look, it seems
> still be used mostly by all kinds of driver code not mm core.  It's used in two
> forms:
> 
>         apply_to_page_range
>         apply_to_existing_page_range
> 
> The first one creates ptes only, so it ignores the pte_none() check so I skipped.
> 
> The second one has two call sites:
> 
> *** arch/powerpc/mm/pageattr.c:
> change_memory_attr[99]         return apply_to_existing_page_range(&init_mm, start, size,
> set_memory_attr[132]           return apply_to_existing_page_range(&init_mm, start, sz, set_page_attr,
> 
> *** mm/kasan/shadow.c:
> kasan_release_vmalloc[485]     apply_to_existing_page_range(&init_mm,
> 
> I'll leave the ppc callers for now as uffd-wp is not even supported there.  The
> kasan_release_vmalloc() should be for kernel allocated memories only, so should
> not be a target for special pte either.
> 
> So indeed it's hard to 100% cover all pte_none() users to make sure things are
> used right.  As stated above I still believe most callers don't need that, but
> the worst case is if someone triggered uffd-wp issues with a specific feature,
> we can look into it.  I am not sure whether it's good we add this for all the
> pte_none() users, because mostly they'll be useless checks, imho.

I wonder then - should we make pte_none() return true for these special pte's
as well? It seems if we do miss any callers it could result in some fairly hard
to find bugs if the code follows a different path due to the presence of an
unexpected special pte changing the result of pte_none().

> So far what I planned to do is to cover most things we know that may be
> affected like this patch so the change may bring a difference, hopefully we
> won't miss any important spots.
> 
> > 
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index 23cbd9de030b..b477d0d5f911 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -294,7 +294,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> > >  
> > >  	spin_lock(ptl);
> > >  	pte = *ptep;
> > > -	if (!is_swap_pte(pte))
> > > +	if (!pte_has_swap_entry(pte))
> > >  		goto out;
> > >  
> > >  	entry = pte_to_swp_entry(pte);
> > > @@ -2276,7 +2276,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> > >  
> > >  		pte = *ptep;
> > >  
> > > -		if (pte_none(pte)) {
> > > +		if (pte_none(pte) || is_swap_special_pte(pte)) {
> > 
> > I was wondering if we can loose the special pte information here? However I see
> > that in migrate_vma_insert_page() we check again and fail the migration if
> > !pte_none() so I think this is ok.
> > 
> > I think it would be better if this check was moved below so the migration fails
> > early. Ie:
> > 
> > 		if (pte_none(pte)) {
> >  			if (vma_is_anonymous(vma) && !is_swap_special_pte(pte)) {
> 
> Hmm.. but shouldn't vma_is_anonymous()==true already means it must not be a
> swap special pte?  Because swap special pte only exists when !vma_is_anonymous().

Oh ok that makes sense. With the code written that way it is easy to forget
that though so maybe a comment would help?

> > 
> > Also how does this work for page migration in general? I can see in
> > page_vma_mapped_walk() that we skip special pte's, but doesn't this mean we
> > loose the special pte in that instance? Or is that ok for some reason?
> 
> Do you mean try_to_migrate_one()? Does it need to be aware of that?  Per my
> understanding that's only for anonymous private memory, while in that world
> there should have no swap special pte (page_lock_anon_vma_read will return NULL
> early for !vma_is_anonymous).

As far as I know try_to_migrate_one() gets called for both anonymous pages and
file-backed pages. page_lock_anon_vma_read() is only called in the case of an
anonymous vma. See the implementation of rmap_walk() - it will call either
rmap_walk_anon() or rmap_walk_file() depending on the result of PageAnon().

 - Alistair

> Thanks,
> 
> 




