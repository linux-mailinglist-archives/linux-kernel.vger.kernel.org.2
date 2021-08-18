Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41F53EFDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbhHRHjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239059AbhHRHjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:39:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD05C61076;
        Wed, 18 Aug 2021 07:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629272360;
        bh=uOsjx46pIEb9R/raJK1EVvRJGCZHDt9swlO23X7+9TY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kmtio6ETvuhtdSkDBzspOiKPUJQKbHt16CweehjMBb6GMcri0DqdVPgj+OS6xCjrc
         21KWPUclxRyUJKMF7oY+lRyq34gRi2XMxNzvjukosRHBhxbSopzywqMxaNvFhYygR9
         rjlt6b+7m0F2VDifHEmpdjZBRBdyDj35J9CQ+MH0=
Date:   Wed, 18 Aug 2021 00:39:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
Message-Id: <20210818003919.5bd008fec6cb0436af2443c4@linux-foundation.org>
In-Reply-To: <YRyQNEc79Km6M9xc@carbon.dhcp.thefacebook.com>
References: <20210817033032.76089-1-songmuchun@bytedance.com>
        <YRxtZ3X8QGv/bui5@carbon.dhcp.thefacebook.com>
        <CAMZfGtV4LXDmv=Gyd5bKPy-V-3a4y3R62XGXnvZyeQ_xqCabJg@mail.gmail.com>
        <YRyQNEc79Km6M9xc@carbon.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2021 21:44:36 -0700 Roman Gushchin <guro@fb.com> wrote:

> On Wed, Aug 18, 2021 at 12:35:08PM +0800, Muchun Song wrote:
> > On Wed, Aug 18, 2021 at 10:16 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Tue, Aug 17, 2021 at 11:30:32AM +0800, Muchun Song wrote:
> > > > Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> > > > PAGEFLAGS_MASK to make the code clear to get the page flags.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  include/linux/page-flags.h      | 4 +++-
> > > >  include/trace/events/page_ref.h | 4 ++--
> > > >  lib/test_printf.c               | 2 +-
> > > >  lib/vsprintf.c                  | 2 +-
> > > >  4 files changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > index 54c4af35c628..1f951ac24a5e 100644
> > > > --- a/include/linux/page-flags.h
> > > > +++ b/include/linux/page-flags.h
> > > > @@ -180,6 +180,8 @@ enum pageflags {
> > > >       PG_reported = PG_uptodate,
> > > >  };
> > > >
> > > > +#define PAGEFLAGS_MASK               (~((1UL << NR_PAGEFLAGS) - 1))
> > >
> > > Hm, isn't it better to invert it? Like
> > > #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> > >
> > > It feels more usual and will simplify the rest of the patch.
> > 
> > Actually, I learned from PAGE_MASK. So I thought the macro
> > like xxx_MASK should be the format of 0xff...ff00...00. I don't
> > know if it is an unwritten rule. I can invert PAGEFLAGS_MASK
> > if it's not a rule.
> 
> There are many examples of both approached in the kernel tree,
> however I'd say the more common is without "~" (out of my head).
> 
> It's definitely OK to define it like
> #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> 

PAGE_MASK has always seemed weird to me but I figured that emulating it
would be the approach of least surprise.  Might be wrong about that...
