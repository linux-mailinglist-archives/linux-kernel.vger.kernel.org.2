Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95A324371
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhBXSAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:00:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:5235 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhBXSAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:00:14 -0500
IronPort-SDR: WBbidW5v/GuiMwH71KlDpI5G4lqgFmkKZGY1KRJYAqHddmmNtWPVa1V58XDP8jHcTWkuUUT1wX
 SK2oWpulPI9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="182788400"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="182788400"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 09:59:24 -0800
IronPort-SDR: Cr/ZBKaFYZ1YyMhbhIdg8+vZGFxobraT6gGpHI/ZcgRiJc0zAm/g94qzVOwlDSm3qXrdIlPhUo
 fUk6pH+j+ayA==
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="403827752"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 09:59:24 -0800
Date:   Wed, 24 Feb 2021 09:59:12 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [GIT PULL] Kmap conversions for 5.12
Message-ID: <20210224175912.GA3014244@iweiny-DESK2.sc.intel.com>
References: <cover.1614090658.git.dsterba@suse.com>
 <CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com>
 <20210223192506.GY3014244@iweiny-DESK2.sc.intel.com>
 <20210224123049.GX1993@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224123049.GX1993@twin.jikos.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 01:30:49PM +0100, David Sterba wrote:
> On Tue, Feb 23, 2021 at 11:25:06AM -0800, Ira Weiny wrote:
> > On Tue, Feb 23, 2021 at 09:13:42AM -0800, Linus Torvalds wrote:
> > > On Tue, Feb 23, 2021 at 7:03 AM David Sterba <dsterba@suse.com> wrote:
> [...]
> 
> > Sorry.  I will change it.
> 
> Let me know how you want to proceed with the patchset/pull request.

To be clear I'd like to just drop the 2 patches which use zero_user() for this
merge window.

I've already submitted some additional btrfs changes for 5.13[1].  I can rework
these zero_user() patches and submit them through Andrew for 5.13 as separate
set.  That is what I meant by 'I will change it'.

> I
> can play the messenger again but now it seems a round of review is
> needed and with some testing it'll be possible in some -rc. At that
> point you may take the patches via the mm tree, unless Linus is ok with
> a late pull.

I'm ok with delaying the memzero_page() change to 5.13.  There are a lot of
kmap changes to come.  But I'm trying to do them as smaller series just for
this reason.  I don't want valid changes to be denied due to my messing up just
a few patches...  :-(  Hopefully you and Linus can forgive me on this one.

Is ok to just drop them and merge the rest of this series in 5.12?

Ira

[1] https://lore.kernel.org/lkml/20210217024826.3466046-1-ira.weiny@intel.com/
