Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293A532316B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhBWT0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:26:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:39522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhBWTZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:25:51 -0500
IronPort-SDR: AyhBzYnDv9vhjWxk8ijLdSABS83LPnXgXjZEVFWTW8ork6rtXnWAMg8O5CnZfclx44ffWKbXgT
 25i81lDAjDiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="164775240"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="164775240"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:25:07 -0800
IronPort-SDR: N18dsRoR7MTP+0xVTJhhotrFPCCEShC9WRMClXCTVmtJ8Qq15MYHnXj4DX9KrLBizZgO9ypEf8
 6K6xBgVKofLw==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="403302299"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:25:07 -0800
Date:   Tue, 23 Feb 2021 11:25:06 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>, David Sterba <dsterba@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [GIT PULL] Kmap conversions for 5.12
Message-ID: <20210223192506.GY3014244@iweiny-DESK2.sc.intel.com>
References: <cover.1614090658.git.dsterba@suse.com>
 <CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 09:13:42AM -0800, Linus Torvalds wrote:
> On Tue, Feb 23, 2021 at 7:03 AM David Sterba <dsterba@suse.com> wrote:
> > Ira Weiny (8):
> >       iov_iter: Remove memzero_page() in favor of zero_user()
> 
> Ugh. I absolutely _detest_ this patch.

Sorry.

> 
> "zero_user()" is a completely horrendous function, and not at all the
> same as memzero_page().
> 
> Just look at it.
> 
> Yes, it's mis-used in a lot of places that really always wanted
> "memzero_page()", but this conversion is going exactly the wrong way
> around.

Originally I lifted memzero_page()[1] but was pointed to zero_user_segments()
which lead me astray to use zero_user().  I should have thought about it more
rather than blindly changing to zero_user().

> 
> Existing users of that zero_user() should have been converted to
> memzero_page(), rather than doing it this way.

I can do that.  No Problem.

> 
> The "user" naming should have given it away. It's a very very magical
> interface for user-mapped pages that have additional odd issues (ie
> look at the dcache flushing etc).

Agreed.

> 
> I'll think some more about this pull request, but honestly, this one
> broken is pretty much enough for me to say "No way in hell", because
> it shows a complete disregard for sanity.

Can we just drop the zero_user() patches?  Christoph and others would like to
see memcpy_[to|from]_page() lifted to the core for other work which is pending.
Would you agree to those?

> 
> The last commit in the series:
> 
> >       btrfs: convert to zero_user()
> 
> is also very mixed up about whether it actually wants the dcache
> flushing or not (and thus zero_user() or memzero_page()).

Drop this patch too?

> 
> Honestly, I suspect all the dcache flushing is totally pointless,
> because any architecture with virtual caches that does kmap needs to
> flush at kunmap anyway, afaik. Some of it is probably just voodoo
> programming and copying a pattern.
> 
> But in any case, zero_user() is not the same thing as memzero_page(),
> and even if they *were* the same thing, zero_user() is objectively the
> horribly much worse name.

Sorry.  I will change it.
Ira

> 
>               Linus

[1] https://lore.kernel.org/lkml/20201124141941.GB4327@casper.infradead.org/#t

