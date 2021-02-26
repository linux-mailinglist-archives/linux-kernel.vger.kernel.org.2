Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EFE326607
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBZRD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:03:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:8775 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhBZRD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:03:57 -0500
IronPort-SDR: jKyd1eKmaLtJrl8dSiwf3DCPFsQ995Pf2dv/R4aPmHP2WwyNk4AYeHh/roL5ZtvJNEpJuxGv7U
 FOBrRXbQSHMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="173578634"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="173578634"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 09:02:49 -0800
IronPort-SDR: ReI+MBbVQEBTQiTBgijphNyVsN9PMQvLjXWg9g0Fli0A+nknkgedIMoa7QP8sH8Exv9XWbxY9u
 JwuOWuWq3Zgw==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="443137334"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 09:02:48 -0800
Date:   Fri, 26 Feb 2021 09:02:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [GIT PULL] Kmap conversions for 5.12
Message-ID: <20210226170248.GH3014244@iweiny-DESK2.sc.intel.com>
References: <cover.1614090658.git.dsterba@suse.com>
 <CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com>
 <20210223192506.GY3014244@iweiny-DESK2.sc.intel.com>
 <20210224123049.GX1993@twin.jikos.cz>
 <20210224175912.GA3014244@iweiny-DESK2.sc.intel.com>
 <20210225131252.GA7604@suse.cz>
 <20210225163234.GD3014244@iweiny-DESK2.sc.intel.com>
 <20210226142339.GK7604@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226142339.GK7604@suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 03:23:40PM +0100, David Sterba wrote:
> On Thu, Feb 25, 2021 at 08:32:34AM -0800, Ira Weiny wrote:
> > On Thu, Feb 25, 2021 at 02:12:52PM +0100, David Sterba wrote:
> > > On Wed, Feb 24, 2021 at 09:59:12AM -0800, Ira Weiny wrote:
> > > > On Wed, Feb 24, 2021 at 01:30:49PM +0100, David Sterba wrote:
> > > > > On Tue, Feb 23, 2021 at 11:25:06AM -0800, Ira Weiny wrote:
> > > > > > On Tue, Feb 23, 2021 at 09:13:42AM -0800, Linus Torvalds wrote:
> > > > > > > On Tue, Feb 23, 2021 at 7:03 AM David Sterba <dsterba@suse.com> wrote:
> > > > > [...]
> > > > > 
> > > > > > Sorry.  I will change it.
> > > > > 
> > > > > Let me know how you want to proceed with the patchset/pull request.
> > > > 
> > > > To be clear I'd like to just drop the 2 patches which use zero_user() for this
> > > > merge window.
> > > > 
> > > > I've already submitted some additional btrfs changes for 5.13[1].  I can rework
> > > > these zero_user() patches and submit them through Andrew for 5.13 as separate
> > > > set.  That is what I meant by 'I will change it'.
> > > > 
> > > > > I
> > > > > can play the messenger again but now it seems a round of review is
> > > > > needed and with some testing it'll be possible in some -rc. At that
> > > > > point you may take the patches via the mm tree, unless Linus is ok with
> > > > > a late pull.
> > > > 
> > > > I'm ok with delaying the memzero_page() change to 5.13.  There are a lot of
> > > > kmap changes to come.  But I'm trying to do them as smaller series just for
> > > > this reason.  I don't want valid changes to be denied due to my messing up just
> > > > a few patches...  :-(  Hopefully you and Linus can forgive me on this one.
> > > > 
> > > > Is ok to just drop them and merge the rest of this series in 5.12?
> > > 
> > > Ok, no problem. Please let me know exactly which patches to drop, I'll
> > > respin the branch. Thanks.
> > 
> > Drop These 2:
> > 
> > [PATCH V2 5/8] iov_iter: Remove memzero_page() in favor of zero_user()
> > https://lore.kernel.org/lkml/20210210062221.3023586-6-ira.weiny@intel.com/
> > 
> > [PATCH V2 8/8] btrfs: convert to zero_user()
> > https://lore.kernel.org/lkml/20210210062221.3023586-9-ira.weiny@intel.com/
> > 
> > 
> > Keep:
> > 
> > [PATCH V2 1/8] mm/highmem: Lift memcpy_[to|from]_page to core 
> > [PATCH V2 2/8] mm/highmem: Convert memcpy_[to|from]_page() to kmap_local_page()
> > [PATCH V2 3/8] mm/highmem: Introduce memcpy_page(), memmove_page(), and memset_page()
> > [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
> > 	...
> > [PATCH V2 6/8] btrfs: use memcpy_[to|from]_page() and kmap_local_page()
> > [PATCH V2 7/8] btrfs: use copy_highpage() instead of 2 kmaps()
> > 	...
> > 
> > I would resend but I'd rather keep the exact commits you had in your testing
> > rather than potentially messing up the rebase this late.
> 
> Got it, thanks. It's easier for me to delete the patches once I have
> them in the branch, that's been updated and now pushed to kernel org
> again (https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/log/?h=kmap-conversion-for-5.12)

Looks good.  thank you.

> 
> I'll add it to testing branches and let it test over the weekend,
> sending the pull request next week.
> 

Sounds like a good plan.

Once again thank you for dealing with this.

Sorry for the mix up,
Ira

