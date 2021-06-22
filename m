Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D281F3AFAED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFVCOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:14:12 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:10996
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhFVCOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:14:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XalghEaApP+UwaSe+MV1ymWUCPzSHKjs3uCZLkY0GW3BobHlXuwYzijaI8RMuODb/SctpWf6z1G/iCqh1RpATqeow+UtNZ4/esW0/DmG3W7SVgCgRBlxdT0xjUCIRb8mYPLx8E7HShoY1ddbnjyHT5zEc4HKKy8P8qFKb9c+qCQ8Z/D//l784S9zI9VZTANyeZJvMgoqCDpzlRtx2qu0z4yo+lFvXHXz91uCyjGHJGzN2vTeo0H1M1/w+c8rW7dg9N0oiwENmOc809LJchjGRKSrfZ44xMZfc9Z9jw+Ga2EAx5Zix0Ai7WkvtI8SdVfj7S1tj93g+aZ8ZFus8N6OzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok8wifWY9++RPdie6U49Ww/p6ZrCYVPnYBauhNZy9dM=;
 b=fSXGIBHjA8yvoeSnbn1fZJMH9a+mcDWfiYRpFI5dCVF6JJfgWM9dpXwhoMcMq83ChQOKA0I6EPzefwsyqLZ40sT8JVzetmcoUV0Gm4u2itPhQjLs1xruu/P3sO070FW3Cv7+XZwW3L3tKIzEW4cGxIHNPg5FCKYfKzV3kd4+6/PcW6Dd8+TS3wf2dSlVfEgQ4F28XAu+Fg+TEFsEiJRvWiRxFYew8Z62plhbjv67RQJ/nOa983iKcsnjmbMf0D/t135DfbmF0An+rYqK+WgGzZ8GBRtLVQI2/cYF/sk2jrTZVJiLtP/yn0pasM5F5HzTt2FTvw5ao38ZPW+/KXmDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok8wifWY9++RPdie6U49Ww/p6ZrCYVPnYBauhNZy9dM=;
 b=HoBRoePlO/oF9DW+EgFFWrED82gKSMVarpXyr8Xn9zMwDaW46TyTrbafHvH7Cv2OzjlLQ/a0p7kyrx47Wr7Ie/pNCyvb7qv7PIlK3oYeWo8/hr6hMWLAkC7xshvmrpTBIKUoa9bsEm4tzFhh7GVq4SSHnK3lHC3wgmm8cgWLtUqTSxkH1zNWV1w25linDGP+EHWg/KvYnfTdSdPry8Q4rp7724AqiEBFaewlQvIEkTMwt+4L/PeCk1ZS6WmzVa2HDia2ZkINWs7G0ooVJ0HgEQGcz4kRleF7QcEJA9ON2UAWx9a7HcKvEJrtBToqQk70T/N+fLyfcH2xX4gqcWhF+g==
Received: from CO2PR06CA0068.namprd06.prod.outlook.com (2603:10b6:104:3::26)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 02:11:54 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::18) by CO2PR06CA0068.outlook.office365.com
 (2603:10b6:104:3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Tue, 22 Jun 2021 02:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 02:11:54 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Jun
 2021 02:11:50 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 09/27] mm: Introduce ZAP_FLAG_SKIP_SWAP
Date:   Tue, 22 Jun 2021 12:11:48 +1000
Message-ID: <1872169.zzk7UsulPy@nvdebian>
In-Reply-To: <YNC9r7Vvf+pdX2t5@t490s>
References: <20210527201927.29586-1-peterx@redhat.com> <5565576.ugXqPVlkE4@nvdebian> <YNC9r7Vvf+pdX2t5@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2cb5dba-54f7-4554-30a8-08d935231aea
X-MS-TrafficTypeDiagnostic: BY5PR12MB4194:
X-Microsoft-Antispam-PRVS: <BY5PR12MB419413238FB460E2B139618CDF099@BY5PR12MB4194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLbwLRPyABEYpSGEtj5OHu2H7E7WutS4yOXih6bpe/THDfoQpD5sGL5ugLqD0+pxZ7wRQfsaplRdTYMSIk4CrG5OWNdL+HEnioawPJglMlO8suKZuDRCZwhJ7CHAvOxdAR7W3RSlScJtuuB00qpzJlDjaOSc+/mCzBXSHP3znZ2n63/7R9zrSkNgoibUj0GeOg5Byqg4x7r7yCrsBkfSFA8pH5zjY/b5q1EicI4EtHgIoTBLh7lffUe5325gaVhj/gPgh/ZqPwdT+0I5akmhDwlS+hJ/SW18e7qc8nU1yegn5jp/mNyz6pDzNB3u0pZHZ2pYn0RUsdb1lYEBDluwepRnyxI+pdn2TBYfmxy7WIulsvcibvE6rju6wFbg0psAzRlX5A/Epxqgv3a1Xt8sqFxjORbV0QmkIS3fz6xOgkYj7jB9/eu5w6xmIEqDx5o5j7tkdgsswvKobimdwfSP3Jprh4M0jRMvFPM1hxBxn9dZvsk/FJVo7Wg6G9lL8iD12ltIc91a3+PyxagVOeFJlmJhYuz5/2iYQk9tYX2LCvvNH+Y/LnhxZS6Ek4x8iLgxjnuMZEihMVKgTV8QiJ26qY/F03iOLSZXR20KgyJtG6QQnrVbmhbqyFpi3C3KVmEKYCyBWog13U/beM5RfhVOsO/6NdMebewDENnPD94wtUohcjQw8AMZ3YBf4qZc1IG4
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(9686003)(478600001)(70206006)(82310400003)(356005)(5660300002)(7636003)(6916009)(7416002)(70586007)(2906002)(8676002)(8936002)(83380400001)(54906003)(36906005)(186003)(47076005)(26005)(316002)(9576002)(426003)(86362001)(4326008)(82740400003)(36860700001)(16526019)(33716001)(336012)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 02:11:54.0329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cb5dba-54f7-4554-30a8-08d935231aea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22 June 2021 2:26:23 AM AEST Peter Xu wrote:
> On Mon, Jun 21, 2021 at 10:36:46PM +1000, Alistair Popple wrote:
> > On Friday, 28 May 2021 6:21:35 AM AEST Peter Xu wrote:
> > > Firstly, the comment in zap_pte_range() is misleading because it checks against
> > > details rather than check_mappings, so it's against what the code did.
> > > 
> > > Meanwhile, it's confusing too on not explaining why passing in the details
> > > pointer would mean to skip all swap entries.  New user of zap_details could
> > > very possibly miss this fact if they don't read deep until zap_pte_range()
> > > because there's no comment at zap_details talking about it at all, so swap
> > > entries could be errornously skipped without being noticed.
> > > 
> > > This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
> > > but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
> > > "details" parameter: the caller should explicitly set this to skip swap
> > > entries, otherwise swap entries will always be considered (which is still the
> > > major case here).
> > > 
> > > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/linux/mm.h | 12 ++++++++++++
> > >  mm/memory.c        |  8 +++++---
> > >  2 files changed, 17 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 52d3ef2ed753..1adf313a01fe 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -1723,6 +1723,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
> > >  
> > >  /* Whether to check page->mapping when zapping */
> > >  #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> > > +/* Whether to skip zapping swap entries */
> > > +#define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
> > >  
> > >  /*
> > >   * Parameter block passed down to zap_pte_range in exceptional cases.
> > > @@ -1745,6 +1747,16 @@ zap_check_mapping_skip(struct zap_details *details, struct page *page)
> > >  	return details->zap_mapping != page_rmapping(page);
> > >  }
> > >  
> > > +/* Return true if skip swap entries, false otherwise */
> > > +static inline bool
> > > +zap_skip_swap(struct zap_details *details)
> > 
> > Minor nit-pick but imho it would be nice if the naming was consistent between
> > this and check mapping. Ie. zap_skip_swap()/zap_skip_check_mapping() or
> > zap_swap_skip()/zap_check_mapping_skip().
> 
> Makes sense; I'll use zap_skip_swap()/zap_skip_check_mapping() I think, then I
> keep this patch untouched.

Sounds good.

> > 
> > > +{
> > > +	if (!details)
> > > +		return false;
> > > +
> > > +	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
> > > +}
> > > +
> > >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> > >  			     pte_t pte);
> > >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index c9dc4e9e05b5..8a3751be87ba 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -1376,8 +1376,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  			continue;
> > >  		}
> > >  
> > > -		/* If details->check_mapping, we leave swap entries. */
> > > -		if (unlikely(details))
> > > +		if (unlikely(zap_skip_swap(details)))
> > >  			continue;
> > >  
> > >  		if (!non_swap_entry(entry))
> > > @@ -3328,7 +3327,10 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
> > >  		pgoff_t nr, bool even_cows)
> > >  {
> > >  	pgoff_t	first_index = start, last_index = start + nr - 1;
> > > -	struct zap_details details = { .zap_mapping = mapping };
> > > +	struct zap_details details = {
> > > +		.zap_mapping = mapping,
> > 
> > I meant to comment on this in the previous patch, but it might be nice to set
> > .zap_mapping in the !even_cows case below to make it very obvious it only
> > applies to ZAP_FLAG_CHECK_MAPPING.
> 
> I wanted to make it easy to understand by having zap_mapping always points to
> the mapping it's zapping, so it does not contain any other information like
> "whether we want to check the mapping is the same when zap", which now stays
> fully in the flags. Then it's always legal to reference zap_mapping without any
> prior knowledge.  But indeed it's only used by ZAP_FLAG_CHECK_MAPPING.
> 
> I do have a slight preference to keep it as the patch does, but I don't have a
> strong opinion.  Let me know if you insist; I can change.

No insistence from me if you want to keep it this way, it's all pretty obvious
anyway.

> > 
> > Otherwise I think this is a good clean up which makes things clearer. I double
> > checked that unmap_mapping_pages() was the only place in the existing code that
> > needs ZAP_FLAG_SKIP_SWAP and that appears to be the case so there shouldn't be
> > any behaviour changes from this.
> > 
> > Reviewed-by: Alistair Popple <apopple@nvidia.com>
> 
> Since I won't change anything within this patch, I'll take this away, thanks!
> 
> 




