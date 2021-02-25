Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1A32503F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhBYNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:15:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:59692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230498AbhBYNP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:15:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC167AF6F;
        Thu, 25 Feb 2021 13:14:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 98146DA790; Thu, 25 Feb 2021 14:12:52 +0100 (CET)
Date:   Thu, 25 Feb 2021 14:12:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [GIT PULL] Kmap conversions for 5.12
Message-ID: <20210225131252.GA7604@suse.cz>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224175912.GA3014244@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 09:59:12AM -0800, Ira Weiny wrote:
> On Wed, Feb 24, 2021 at 01:30:49PM +0100, David Sterba wrote:
> > On Tue, Feb 23, 2021 at 11:25:06AM -0800, Ira Weiny wrote:
> > > On Tue, Feb 23, 2021 at 09:13:42AM -0800, Linus Torvalds wrote:
> > > > On Tue, Feb 23, 2021 at 7:03 AM David Sterba <dsterba@suse.com> wrote:
> > [...]
> > 
> > > Sorry.  I will change it.
> > 
> > Let me know how you want to proceed with the patchset/pull request.
> 
> To be clear I'd like to just drop the 2 patches which use zero_user() for this
> merge window.
> 
> I've already submitted some additional btrfs changes for 5.13[1].  I can rework
> these zero_user() patches and submit them through Andrew for 5.13 as separate
> set.  That is what I meant by 'I will change it'.
> 
> > I
> > can play the messenger again but now it seems a round of review is
> > needed and with some testing it'll be possible in some -rc. At that
> > point you may take the patches via the mm tree, unless Linus is ok with
> > a late pull.
> 
> I'm ok with delaying the memzero_page() change to 5.13.  There are a lot of
> kmap changes to come.  But I'm trying to do them as smaller series just for
> this reason.  I don't want valid changes to be denied due to my messing up just
> a few patches...  :-(  Hopefully you and Linus can forgive me on this one.
> 
> Is ok to just drop them and merge the rest of this series in 5.12?

Ok, no problem. Please let me know exactly which patches to drop, I'll
respin the branch. Thanks.
