Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071C932640B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBZO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:26:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:32896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhBZO0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:26:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F5C4ADDC;
        Fri, 26 Feb 2021 14:25:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1867FDA7FF; Fri, 26 Feb 2021 15:23:40 +0100 (CET)
Date:   Fri, 26 Feb 2021 15:23:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [GIT PULL] Kmap conversions for 5.12
Message-ID: <20210226142339.GK7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <cover.1614090658.git.dsterba@suse.com>
 <CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com>
 <20210223192506.GY3014244@iweiny-DESK2.sc.intel.com>
 <20210224123049.GX1993@twin.jikos.cz>
 <20210224175912.GA3014244@iweiny-DESK2.sc.intel.com>
 <20210225131252.GA7604@suse.cz>
 <20210225163234.GD3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225163234.GD3014244@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 08:32:34AM -0800, Ira Weiny wrote:
> On Thu, Feb 25, 2021 at 02:12:52PM +0100, David Sterba wrote:
> > On Wed, Feb 24, 2021 at 09:59:12AM -0800, Ira Weiny wrote:
> > > On Wed, Feb 24, 2021 at 01:30:49PM +0100, David Sterba wrote:
> > > > On Tue, Feb 23, 2021 at 11:25:06AM -0800, Ira Weiny wrote:
> > > > > On Tue, Feb 23, 2021 at 09:13:42AM -0800, Linus Torvalds wrote:
> > > > > > On Tue, Feb 23, 2021 at 7:03 AM David Sterba <dsterba@suse.com> wrote:
> > > > [...]
> > > > 
> > > > > Sorry.  I will change it.
> > > > 
> > > > Let me know how you want to proceed with the patchset/pull request.
> > > 
> > > To be clear I'd like to just drop the 2 patches which use zero_user() for this
> > > merge window.
> > > 
> > > I've already submitted some additional btrfs changes for 5.13[1].  I can rework
> > > these zero_user() patches and submit them through Andrew for 5.13 as separate
> > > set.  That is what I meant by 'I will change it'.
> > > 
> > > > I
> > > > can play the messenger again but now it seems a round of review is
> > > > needed and with some testing it'll be possible in some -rc. At that
> > > > point you may take the patches via the mm tree, unless Linus is ok with
> > > > a late pull.
> > > 
> > > I'm ok with delaying the memzero_page() change to 5.13.  There are a lot of
> > > kmap changes to come.  But I'm trying to do them as smaller series just for
> > > this reason.  I don't want valid changes to be denied due to my messing up just
> > > a few patches...  :-(  Hopefully you and Linus can forgive me on this one.
> > > 
> > > Is ok to just drop them and merge the rest of this series in 5.12?
> > 
> > Ok, no problem. Please let me know exactly which patches to drop, I'll
> > respin the branch. Thanks.
> 
> Drop These 2:
> 
> [PATCH V2 5/8] iov_iter: Remove memzero_page() in favor of zero_user()
> https://lore.kernel.org/lkml/20210210062221.3023586-6-ira.weiny@intel.com/
> 
> [PATCH V2 8/8] btrfs: convert to zero_user()
> https://lore.kernel.org/lkml/20210210062221.3023586-9-ira.weiny@intel.com/
> 
> 
> Keep:
> 
> [PATCH V2 1/8] mm/highmem: Lift memcpy_[to|from]_page to core 
> [PATCH V2 2/8] mm/highmem: Convert memcpy_[to|from]_page() to kmap_local_page()
> [PATCH V2 3/8] mm/highmem: Introduce memcpy_page(), memmove_page(), and memset_page()
> [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
> 	...
> [PATCH V2 6/8] btrfs: use memcpy_[to|from]_page() and kmap_local_page()
> [PATCH V2 7/8] btrfs: use copy_highpage() instead of 2 kmaps()
> 	...
> 
> I would resend but I'd rather keep the exact commits you had in your testing
> rather than potentially messing up the rebase this late.

Got it, thanks. It's easier for me to delete the patches once I have
them in the branch, that's been updated and now pushed to kernel org
again (https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/log/?h=kmap-conversion-for-5.12)

I'll add it to testing branches and let it test over the weekend,
sending the pull request next week.
