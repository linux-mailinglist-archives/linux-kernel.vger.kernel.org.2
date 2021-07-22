Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F063D1B43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 03:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhGVA21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 20:28:27 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:23980
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229953AbhGVA20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 20:28:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyhrpeAAw7iwxOoClzb5gXMQWSf0x88+t9Cy9/HFjpO2U/W/XWtYSpIsyjXkDkLZesD3qeweNVBy8GyabOylpQKugGsB8Tilt2e6RkjfZIauFexibfj6MZV+TzJrhnWIyaaeMhFBMIrG6Jx2yJL0WsIoPVx3mHwInTrr6ja60LagH03nkzDdyob4S1Jz1aATbJvkKLSrWBt8UInR8Xd4gfWdAarkAdEEAeLQABSeCfSK/k78u6yA8ddVT3tFDlNUkOMXLz4mF1agDZp2CPhPWopqgsR65YgALaMdSkrmf7wEHDGrRiVBHiezr9RknvLFvIQjKV8bFlo8tZMM0mNWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiszBOqxTR1jk70o72Wqjt+PR9Nj8cBnixAWk6uM0tk=;
 b=iSGdUTf67VWEiDQQ2jhNfNBWdqstmz/dShlk3b0CA3AUP7gx5EWHkX3SmUA3p6eotvh1Zf5PunNQ3BFnTpmCDsptBwpCG/vT8AYYmKM0I5Hgr1ZjWvFYjG5CaRvIOYl68zh7tsjPcwhJ48wWezXqk/cCPY8dHo0uDnZwVMt8w+f4qkkbYjF9bQY8sCi/OukTU0gzoVHft7e/s4TTIdGlcCWG2ixSwGTqN8CwEuKJ7l72D8VJMJFEC8AwRufu/kFywZzMkWP+hyJZIJ2lvTluubQjYrVWIL/trKgworl2kU3Ix7WGC9GGbVkY++GHjqXRkFoTdKISht9orWyhYTWCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiszBOqxTR1jk70o72Wqjt+PR9Nj8cBnixAWk6uM0tk=;
 b=F/rMEfd7q6ZleEFg4NUoDFwEsHfbMeX8kIY0xJO+bJp9+Qo+kH5Z0ljzJsGuuyztWBDgEEv8p2dnsNJO/pzPAQ8LfqqhHqoL6GAfug+uYZEol8eURbHgVHOFN7eFy2RL8mAzTEV+RYuRVLhWa8nYRdxsFeVAcEf+jQRm5yUK5i80tTqd5gjg0OMVbWpebVLcfQGMhZf8FGD+GRcqACVWFRxCPKMPYfOG8pimNXc4bL4uq3K5TFymK4ubLAa0ckS1XoJGTMY5en56wDsU175AjUZT6icl3LkWgGe/TsbV50wuZsfvA098/uhG6P4+JQwIQfPRGIhoEf0JXRIjo0koPQ==
Received: from DS7PR03CA0160.namprd03.prod.outlook.com (2603:10b6:5:3b2::15)
 by MN2PR12MB3262.namprd12.prod.outlook.com (2603:10b6:208:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Thu, 22 Jul
 2021 01:09:00 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::a0) by DS7PR03CA0160.outlook.office365.com
 (2603:10b6:5:3b2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Thu, 22 Jul 2021 01:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 01:09:00 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 01:08:56 +0000
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
Date:   Thu, 22 Jul 2021 11:08:53 +1000
Message-ID: <5071185.SEdLSG93TQ@nvdebian>
In-Reply-To: <YPiTJLGxqiLXjbAU@t490s>
References: <20210715201422.211004-1-peterx@redhat.com> <23927325.GfNbO0Vjio@nvdebian> <YPiTJLGxqiLXjbAU@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff90a4fa-46df-491a-85b6-08d94cad4a39
X-MS-TrafficTypeDiagnostic: MN2PR12MB3262:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3262ABF11295BA7743AA552CDFE49@MN2PR12MB3262.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Neb1maVwFSCxEH4/9yrWgBfCJuIKcI3GZBvoaCigtUpa2GdoNtLmAJ0Yrf/SxCAQ7+pysHP2aTTKLezyBc3XpX1q3x+lfxd+DwrdhaB0fhSh/M+evcBPjNHdpFeeXuFZ22z08/v1wwV0N/jgSljlYt6afyNKMvtwBNKUOAOreA/txwbRGutCP7kZaEN4DnubQlWZfGMJ3qML7R3dEXASUkDQgEJNzDjklnDMYBfyqEj+/d+4zm4TjlQeoJZloSf2Me+uhyu747AMKg9Zp9SBUsak8ZJiWh0U1tdmdaNZ0EOLaJUVjOZoaBrVWFTwKQvBk/8Kh4eVv/cPyomNd4JuXc0A7ZMdSKp6VICLCzbs/dapVjf/PlRl7Pe6sKwfKI+PIjCoJ/yJY5mHjWROmuqsnl0ECHAsmcjLG81d1lf1YhWo6X66EqfDGBckWsHDXrFjdK4Xp/veiqIa7VQ8UnLHtTUUAeMn/nTQSpE07CEkPEDim+gP2gy/Go/h2Rv24+wzV0sv5Fk0mcr96mLovnk9/bh++zgQ5UG1o8xibniwp/ECgZ6JGZLA3TO1eeKzL9FvQsa2Xc+UgglJ2LN5SR2vzkMZVFw52QOSQNfUI6d8UnyR5zD+XM/IVo+Hcl9Y1A9NBlvqlhPwWp+q3xLP8GJKowFqGNUmTWGuIt5qvKdXsRhkVJmEDdkqJs/WehAuG31D9cZNVP9QcHvhwgnrUYyA4w==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(316002)(83380400001)(7636003)(8936002)(86362001)(36906005)(82740400003)(7416002)(70206006)(478600001)(9686003)(5660300002)(356005)(47076005)(9576002)(54906003)(70586007)(8676002)(426003)(82310400003)(36860700001)(6916009)(336012)(26005)(4326008)(2906002)(6666004)(33716001)(186003)(30864003)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 01:09:00.6523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff90a4fa-46df-491a-85b6-08d94cad4a39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3262
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 22 July 2021 7:35:32 AM AEST Peter Xu wrote:
> On Wed, Jul 21, 2021 at 09:28:49PM +1000, Alistair Popple wrote:
> > On Saturday, 17 July 2021 5:11:33 AM AEST Peter Xu wrote:
> > > On Fri, Jul 16, 2021 at 03:50:52PM +1000, Alistair Popple wrote:
> > > > Hi Peter,
> > > > 
> > > > [...]
> > > > 
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index ae1f5d0cb581..4b46c099ad94 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -5738,7 +5738,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
> > > > >  
> > > > >  	if (pte_present(ptent))
> > > > >  		page = mc_handle_present_pte(vma, addr, ptent);
> > > > > -	else if (is_swap_pte(ptent))
> > > > > +	else if (pte_has_swap_entry(ptent))
> > > > >  		page = mc_handle_swap_pte(vma, ptent, &ent);
> > > > >  	else if (pte_none(ptent))
> > > > >  		page = mc_handle_file_pte(vma, addr, ptent, &ent);
> > > > 
> > > > As I understand things pte_none() == False for a special swap pte, but
> > > > shouldn't this be treated as pte_none() here? Ie. does this need to be
> > > > pte_none(ptent) || is_swap_special_pte() here?
> > > 
> > > Looks correct; here the page/swap cache could hide behind the special pte just
> > > like a none pte.  Will fix it.  Thanks!
> > > 
> > > > 
> > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > index 0e0de08a2cd5..998a4f9a3744 100644
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -3491,6 +3491,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > > > >  	if (!pte_unmap_same(vmf))
> > > > >  		goto out;
> > > > >  
> > > > > +	/*
> > > > > +	 * We should never call do_swap_page upon a swap special pte; just be
> > > > > +	 * safe to bail out if it happens.
> > > > > +	 */
> > > > > +	if (WARN_ON_ONCE(is_swap_special_pte(vmf->orig_pte)))
> > > > > +		goto out;
> > > > > +
> > > > >  	entry = pte_to_swp_entry(vmf->orig_pte);
> > > > >  	if (unlikely(non_swap_entry(entry))) {
> > > > >  		if (is_migration_entry(entry)) {
> > > > 
> > > > Are there other changes required here? Because we can end up with stale special
> > > > pte's and a special pte is !pte_none don't we need to fix some of the !pte_none
> > > > checks in these functions:
> > > > 
> > > > insert_pfn() -> checks for !pte_none
> > > > remap_pte_range() -> BUG_ON(!pte_none)
> > > > apply_to_pte_range() -> didn't check further but it tests for !pte_none
> > > > 
> > > > In general it feels like I might be missing something here though. There are
> > > > plenty of checks in the kernel for pte_none() which haven't been updated. Is
> > > > there some rule that says none of those paths can see a special pte?
> > > 
> > > My rule on doing this was to only care about vma that can be backed by RAM,
> > > majorly shmem/hugetlb, so the special pte can only exist there within those
> > > vmas.  I believe in most pte_none() users this special pte won't exist.
> > > 
> > > So if it's not related to RAM backed memory at all, maybe it's fine to keep the
> > > pte_none() usage like before.
> > > 
> > > Take the example of insert_pfn() referenced first - I think it can be used to
> > > map some MMIO regions, but I don't think we'll call that upon a RAM region
> > > (either shmem or hugetlb), nor can it be uffd wr-protected.  So I'm not sure
> > > adding special pte check there would be helpful.
> > > 
> > > apply_to_pte_range() seems to be a bit special - I think the pte_fn_t matters
> > > more on whether the special pte will matter.  I had a quick look, it seems
> > > still be used mostly by all kinds of driver code not mm core.  It's used in two
> > > forms:
> > > 
> > >         apply_to_page_range
> > >         apply_to_existing_page_range
> > > 
> > > The first one creates ptes only, so it ignores the pte_none() check so I skipped.
> > > 
> > > The second one has two call sites:
> > > 
> > > *** arch/powerpc/mm/pageattr.c:
> > > change_memory_attr[99]         return apply_to_existing_page_range(&init_mm, start, size,
> > > set_memory_attr[132]           return apply_to_existing_page_range(&init_mm, start, sz, set_page_attr,
> > > 
> > > *** mm/kasan/shadow.c:
> > > kasan_release_vmalloc[485]     apply_to_existing_page_range(&init_mm,
> > > 
> > > I'll leave the ppc callers for now as uffd-wp is not even supported there.  The
> > > kasan_release_vmalloc() should be for kernel allocated memories only, so should
> > > not be a target for special pte either.
> > > 
> > > So indeed it's hard to 100% cover all pte_none() users to make sure things are
> > > used right.  As stated above I still believe most callers don't need that, but
> > > the worst case is if someone triggered uffd-wp issues with a specific feature,
> > > we can look into it.  I am not sure whether it's good we add this for all the
> > > pte_none() users, because mostly they'll be useless checks, imho.
> > 
> > I wonder then - should we make pte_none() return true for these special pte's
> > as well? It seems if we do miss any callers it could result in some fairly hard
> > to find bugs if the code follows a different path due to the presence of an
> > unexpected special pte changing the result of pte_none().
> 
> I thought about something similar before, but I didn't dare to change
> pte_none() as it's been there for ages and I'm afraid people will get confused
> when it's meaning changed.  So even if we want to have some helper identifying
> "either none pte or the swap special pte" it should use a different name.
> 
> Modifying the meaning of pte_none() could also have other risks that when we
> really want an empty pte to be doing something else now.  It turns out there's
> no easy way to not identify the case one by one, at least to me.  I'm always
> open to good suggestions.

I'm not convinced it's changing the behaviour of pte_none() though and my
concern is that introducing special swap ptes does change it. Prior to this
clearing a pte would result in pte_none()==True. After this series clearing a
pte can some sometimes result in pte_none()==False because it doesn't really
get cleared.

Now as you say it's hard to cover 100% of pte_none() uses, so it's possible we
have missed cases that may now encounter a special pte and take a different
path (get_mctgt_type() is one example, I stopped looking for other possible
ones after mm/memory.c).

So perhaps if we want to keep pte_none() to check for really clear pte's then
what is required is converting all callers to a new helper
(pte_none_not_special()?) that treats special swap ptes as pte_none() and warns
if a special pte is encountered?

> Btw, as you mentioned before, we can use a new number out of MAX_SWAPFILES,
> that'll make all these easier a bit here, then we don't need to worry on
> pte_none() issues too.  Two days ago Hugh has raised some similar concern on
> whether it's good to implement this uffd-wp special pte like this.  I think we
> can discuss this separately.

Yes, I saw that and personally I still prefer that approach.

> > 
> > > So far what I planned to do is to cover most things we know that may be
> > > affected like this patch so the change may bring a difference, hopefully we
> > > won't miss any important spots.
> > > 
> > > > 
> > > > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > > > index 23cbd9de030b..b477d0d5f911 100644
> > > > > --- a/mm/migrate.c
> > > > > +++ b/mm/migrate.c
> > > > > @@ -294,7 +294,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> > > > >  
> > > > >  	spin_lock(ptl);
> > > > >  	pte = *ptep;
> > > > > -	if (!is_swap_pte(pte))
> > > > > +	if (!pte_has_swap_entry(pte))
> > > > >  		goto out;
> > > > >  
> > > > >  	entry = pte_to_swp_entry(pte);
> > > > > @@ -2276,7 +2276,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> > > > >  
> > > > >  		pte = *ptep;
> > > > >  
> > > > > -		if (pte_none(pte)) {
> > > > > +		if (pte_none(pte) || is_swap_special_pte(pte)) {
> > > > 
> > > > I was wondering if we can loose the special pte information here? However I see
> > > > that in migrate_vma_insert_page() we check again and fail the migration if
> > > > !pte_none() so I think this is ok.
> > > > 
> > > > I think it would be better if this check was moved below so the migration fails
> > > > early. Ie:
> > > > 
> > > > 		if (pte_none(pte)) {
> > > >  			if (vma_is_anonymous(vma) && !is_swap_special_pte(pte)) {
> > > 
> > > Hmm.. but shouldn't vma_is_anonymous()==true already means it must not be a
> > > swap special pte?  Because swap special pte only exists when !vma_is_anonymous().
> > 
> > Oh ok that makes sense. With the code written that way it is easy to forget
> > that though so maybe a comment would help?
> 
> I've put most words in comment of is_swap_special_pte().  Do you perhaps have a
> suggestion on the comment here?

Perhaps something like "swap special ptes only exist for !vma_is_anonymous(vma)"?

And I now see my original code suggestion was wrong anyway :)

> > 
> > > > 
> > > > Also how does this work for page migration in general? I can see in
> > > > page_vma_mapped_walk() that we skip special pte's, but doesn't this mean we
> > > > loose the special pte in that instance? Or is that ok for some reason?
> > > 
> > > Do you mean try_to_migrate_one()? Does it need to be aware of that?  Per my
> > > understanding that's only for anonymous private memory, while in that world
> > > there should have no swap special pte (page_lock_anon_vma_read will return NULL
> > > early for !vma_is_anonymous).
> > 
> > As far as I know try_to_migrate_one() gets called for both anonymous pages and
> > file-backed pages. page_lock_anon_vma_read() is only called in the case of an
> > anonymous vma. See the implementation of rmap_walk() - it will call either
> > rmap_walk_anon() or rmap_walk_file() depending on the result of PageAnon().
> 
> I may have replied too soon there. :)  I think you're right.
> 
> So I think how it should work with page migration is: we skip that pte just
> like what you said (check_pte returns false), then the per-pte info will be
> kept there, irrelevant of what's the backing page is.  When it faults, it'll
> bring up with either the old/new page depending on migration finished or not.
> Does that sound working to you?

Yes actually I think this is ok. check_pte returns false for special pte's so
the existing special pte will be left in place to be dealt with as normal.

 - Alistair

> Thanks,
> 
> 




