Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BADA3A3D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhFKHaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:30:52 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:18593
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231132AbhFKHau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:30:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL3X78uZYtU6FmQ6k5MSpMZi4YgbOU92qYpBt1Ewz13wWAy/kJB6AbnbXgLxb+i8F6nUXdmZdD9iaGWxFHA4la+CYlDE2PbWNm6YSt8QN0lM0wOISs5PlCUWVND1fs5gvMgY+2PHJNtNYG9LAzxW2S/hiNBy7h6l2gSA0g/ud3JyzBuobheih+Shq+IN+SZnR9seXTHVnIIwzZ5YWopnPm2NeronjBh8W4bbuQ3GDyKxVxQzgCDQ7Oty6ZKqCKLETJQ+ZDMOGlgdnfqnkAIez/cNx4z6yyc5uPNT+NqzSt60PNubwf5pa2SnIxCAp1CCwSzcnMF60uX3KDUWo1ZO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+ajJDunnk/SepGF8KrvpAd/3+hjXVyxuWffx7jVoZc=;
 b=faFBHEKrlY31A+jdEuI84oBXM3bHy0wjUjlju52OtDt8gYYMOUP2C0Mk3gEx24abqtSqUrLdWmC8jOvzvAbxAuYG6PprGkp91UwQmmQpt+kcZxMHcyQPcBx2QMVFjWMC3Q73hiQwCnSv9z/09Fvwl5oF8olKGQ08tLGZrNd8QPsnig9IEfaPcnss/hFb9kfLvdjeNoCOKpxc50Nq9JUkQpY9/xVO4MhvvfHpGT/1QfLn01k/UMHIpMUUXNq9kLuCNayWucWIWRQVKp4vdBOVzw0jIAv5bQxaJnPaXTxxs+NxPiutOLB0Qaq+CZf4Mfci6RVnNdB+3bITi6Ogcs9+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+ajJDunnk/SepGF8KrvpAd/3+hjXVyxuWffx7jVoZc=;
 b=Hyh9/Q9A4SAl1Sko8eiSM6GKkm/l/zDcwdB3ywcIYenfNXll5DazrCoKa4qzIFGwjMglGpBEj9J+mPsrxKvZ9vTDYrtphL9gQES+6+df+DFcuk6COzB53tBSTpqRfcneYRLRhh03+hZ0Xy/+8WxHTZUKiMBf9U4+0cYo1D8L/b25A1LpQnsVWJc+JgrHPVSds9cLwDnHlPnfB/G+omAf5paczMSHyUng9zxQGfun68/ZRPWIYDyKxRVZUQVAR2SiedqJOS1URGUp2CXF+T9DUA21IuI7TS/PaQCUJcgBkK54CI9G1PzDDk/ncRnz5+mcV1uMor9fSq4b5gNE9zBbgQ==
Received: from BN0PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:e8::6)
 by DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Fri, 11 Jun
 2021 07:28:52 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::f9) by BN0PR04CA0031.outlook.office365.com
 (2603:10b6:408:e8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Fri, 11 Jun 2021 07:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:28:51 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Jun
 2021 07:28:48 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Naoya Horiguchi" <naoya.horiguchi@nec.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] mm/thp: fix THP splitting unmap BUGs and related
Date:   Fri, 11 Jun 2021 17:28:45 +1000
Message-ID: <1697169.ADtCEf3Xva@nvdebian>
In-Reply-To: <b27e866-a06c-d32-20aa-3b16f58549@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com> <2014832.e7zRqyNrDn@nvdebian> <b27e866-a06c-d32-20aa-3b16f58549@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e146d20f-d5bc-412b-dbb1-08d92caa8ff2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3433:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34334F48D84FBD6B905DFA8BDF349@DM6PR12MB3433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8PCMMSqwdNvejLz0+ksSQRdBc4jtoaLRGsdaVwC86pEqbKvwFBomhEBWwm/32oTe1/nLK9miGlN0f5N86ARr2eRcyCocLxlShU1DIthXTLYagRGfpaCQuknWU4c/FCi8O5yc8XJoXewy+pUxcqR/htlPpwVky5IlSsA9mAkWwZWa1n0fw8z6QJ3dLwNkPzsZGYjHa/K7lPRT/eWejxGUHiD3kxRGf4e/UujZzsssLOx8+oqzux6Kkvihjpydj5054QhoxLNpaZOvvl20ND3g4J8XvnNpBU2ZKtgy9QlTY2ri8BlybKiKaguW4vtdV53eDAvVSxdFxUnhe9i5pvNrPT8L8HBlvPEWOGf3u7j3qrL9xHhP3jtExm8lhnsV1jWDCc+pS06cX7LlEfQVrgCeYMIa0y4fKXk33TqOEP45nLCiqdqGszcAHNzyGpSOxOtwixkweDs14XbvW+qyVmgJCA3QHRIH87SM1X+3FRpZ4rzY1hsim346bHq0e8ti5PbSolcTc5pWRfOVicx6HtGQTJtiHcp9sbuLlk/tj94u+9WykPKx5KxPRSfiyhAmJi7AQ2PZwacS8B6hr+wJ9UgnY3RwY5QyEZLASOkl3/i4pCsielImMBaEgTwj3G2M9P7P+wE8XxKMbipRm5Bb5G0OpCdeEspOAvHoaPAHUuDxm4tOogEReoHXekbB63yABIiXyYpsATkrrtAkrCQB25R2fgkG62UDXDaP3QD/vmVSaUWxkQjgl8A0ULCucjLVS2tiV7njM1UsxxhzE6M/oD+bY3RINEc00m996pqnpqV6jdWFE+qmnWyzykCjaMtPtiu
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39850400004)(46966006)(36840700001)(2906002)(83380400001)(356005)(86362001)(70586007)(336012)(478600001)(8936002)(47076005)(8676002)(6916009)(82740400003)(70206006)(9686003)(4326008)(6666004)(186003)(36860700001)(5660300002)(26005)(82310400003)(9576002)(966005)(16526019)(316002)(54906003)(426003)(36906005)(7416002)(7636003)(33716001)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:28:51.8387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e146d20f-d5bc-412b-dbb1-08d92caa8ff2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3433
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 11 June 2021 10:15:51 AM AEST Hugh Dickins wrote:
> On Fri, 11 Jun 2021, Alistair Popple wrote:
> > On Friday, 11 June 2021 8:15:05 AM AEST Andrew Morton wrote:
> > > On Tue, 8 Jun 2021 20:57:34 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:


> > > --- mm/huge_memory.c~mm-rmap-split-migration-into-its-own-function
> > > +++ mm/huge_memory.c
> > > @@ -2345,16 +2345,21 @@ void vma_adjust_trans_huge(struct vm_are
> > >
> > >  static void unmap_page(struct page *page)
> > >  {
> > > -       enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
> > > -               TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> > > +       enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> > >         bool unmap_success;
> > >
> > >         VM_BUG_ON_PAGE(!PageHead(page), page);
> > >
> > >         if (PageAnon(page))
> > > -               ttu_flags |= TTU_SPLIT_FREEZE;
> > > -
> > > -       unmap_success = try_to_unmap(page, ttu_flags);
> > > +               unmap_success = try_to_migrate(page, ttu_flags);
> > > +       else
> > > +               /*
> > > +                * Don't install migration entries for file backed pages. This
> > > +                * helps handle cases when i_size is in the middle of the page
> > > +                * as there is no need to unmap pages beyond i_size manually.
> > > +                */
> > > +               unmap_success = try_to_unmap(page, ttu_flags |
> > > +                                               TTU_IGNORE_MLOCK);
> > >         VM_BUG_ON_PAGE(!unmap_success, page);
> > >  }
> > >
> > >
> > > Sigh.  I have a few todo's against Alastair's "Add support for SVM
> > > atomics in Nouveau v9".  Including
> 
> Sigh shared!
> 
> > >
> > > https://lkml.kernel.org/r/20210525183710.fa2m2sbfixnhz7g5@revolver
> > > https://lkml.kernel.org/r/20210604204934.sbspsmwdqdtmz73d@revolver
> > > https://lkml.kernel.org/r/YK6mbf967dV0ljHn@t490s
> > > https://lkml.kernel.org/r/2005328.bFqPmhE5MS@nvdebian
> > > https://lkml.kernel.org/r/202105262107.LkxpsZsV-lkp@intel.com
> > > https://lkml.kernel.org/r/YK6hYGEx+XzeZELV@t490s
> > >
> > > So I think I'll drop that series and shall ask for it to be redone
> > > against this lot, please.
> 
> Thank you, Andrew: that's certainly easiest for you and for me:
> and I think the right thing to do for now.

I guess this is where I sigh :-)

> > >
> >
> > I believe v10 of the series posted earlier this week should address those
> > todo's. I will double check though and resend based on top of mmotm. Thanks.
> 
> Sorry to give you the bother, Alistair: it's worked out as a bad moment
> to rewrite swapops.h and rmap.c, I'm afraid.

Indeed, but I don't think it's too bad. I've just tried rebasing it on this
series and it didn't run into too many problems. Obviously I ran into the same
issue Andrew did but I was able to fix that up. It also means try_to_migrate()
now returns 'void' instead of 'bool'.

Which brings me to the only real question I had during the rebase - does
migration also need to accept the TTU_SYNC flag? I think it does because if I
understand correctly we can still hit the same race with zap_pte_range() when
trying to establish migration entries which previously also returned the status
of page_mapped().

> And the only help I've had time to give you was pointing Peter at your
> series - many thanks to Peter, and to Shakeel.

Yes, thanks for the help there. I think the main questions I had for you were
around checking vma flags under the ptl in try_to_munlock_one but Shakeel was
able to clear that up for me. Thanks!

> Several times I've been on the point of asking you to keep the familiar
> migration_entry_to_page(), along with your new pfn_swap_entry_to_page();
> but each time I've looked, seen that it's hard to retain it sensibly at
> the same time as overdue cleanup of the device_private_entry_to_page()s.

Yeah, it would make things a bit funny to retain it IMHO. At least any fixups
should just be simple substitutions.

> So I guess I'm resigned to losing it; but there are at least three
> bugs currently under discussion or fixes in flight, which border on
> migration_entry_to_page() - Jann Horn's smaps syzbot bug, Xu Yu's
> __migration_entry_wait() fix, my __split_huge_pmd_locked() fix
> (and page_vma_mapped_walk() cleanup).
> 
> And regarding huge_memory.c's unmap_page(): I did not recognize the
> "helps handle cases when i_size" comment you added there.  What I
> ended up with (and thought was in mmotm-adjust.tar but seems not):
> 
>         /*
>          * Anon pages need migration entries to preserve them, but file
>          * pages can simply be left unmapped, then faulted back on demand.
>          * If that is ever changed (perhaps for mlock), update remap_page().
>          */

My comment was based somewhat on the commit message for the original change but
yours is much clearer so will incorporate it into my rebase, thanks.

As to sending my rebased series I suppose it would be best to wait until
linux-mm has been updated with whatever other fixes are needed before resending
it based on top of that. So far rebasing on this series didn't require too many
drastic changes to my v10 series. The most significant was to incorporate your
changes to unmap_page(). The remaining were just adding the TTU_SYNC case to
try_to_migrate{_one} and a single s/migration_entry_to_page/pfn_swap_entry_to_page/
in huge_memory.c

>         if (PageAnon(page))
>                 try_to_migrate(page, ttu_flags);
>         else
>                 try_to_unmap(page, ttu_flags | TTU_IGNORE_MLOCK);
> 
> with
>         /* If try_to_migrate() is used on file, remove this check */
> in remap_page() to replace the
>         /* If TTU_SPLIT_FREEZE is ever extended to file, remove this check */
> comment my series puts there (since you delete TTU_SPLIT_FREEZE altogether).

> Hugh




