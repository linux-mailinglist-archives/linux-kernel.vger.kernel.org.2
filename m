Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904DD3F1C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbhHSPHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbhHSPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:07:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D438C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:06:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m26so5774473pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRP4QaaG2BZAUZjQyqy0D7D6eqKZn/t5ewBUMuvwDnQ=;
        b=fgjovzasfByAdj7b+nK1+ixIaKp2smVLzl8dj2Pd73vlgPoH5aC3SJZb44ssasEbKm
         T+U4/Ze8J/PxLezM2pOvFXr0kf5+dnfk/xGHyem3ktq3VOUoYAFq/bheXQGOx4ajjdeu
         +zna3g8/D4Uw4rUgWqdPpPV4xUHeUw/8gg/VuNLsQ7RrT1QKpOOYJeZLXdjP2wsKcj5b
         qLCF++TY75HV8241PSHgtEdyrTpRskXsHSY/Ff7cpzTXqZgDvVkB1Mh6b3Tgm3vjFuLM
         yfgIZw+RFqjlZUZvmP8fQ95bCYG2OuqNCNDmr7Zf1mNua+F0dGjMbtqj56YAmP7QXIGw
         knQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRP4QaaG2BZAUZjQyqy0D7D6eqKZn/t5ewBUMuvwDnQ=;
        b=VZt3mlQsG1bWPYSXqgKfnnOGkES+6ZuVt5IBGradrQlY1gVgn7TUt64che+hffej3L
         7GXlNvC7tqv7I97nXLN4/cpCQjafwv3nJON/7HNlKPQXLO6cPNXwUtL2jVHyix3RKD/d
         OVAXMmzU33OEme2Ch/pqB0HEZNSNLS+MigpXFH1i7ZssvuOa1vFj3WyMU/zmMAcRCFmA
         HFNso43kxMO1kM6ILNBuM2g+0ydBOH7wo+o3xfyc/hkmj8Bsj0YnwM0BWgOySiblHd+m
         NDosPW4s4cPD3gx2XHxCRtVboLb3eAFEyyXnoW1hQDUlq29pfLt48LCS9dfhU5muNswh
         2e6Q==
X-Gm-Message-State: AOAM533sgr7aKdc8yQD38Lww2jThqSBvpveqbsH2wTg0xghesBD9/Sx9
        0Zu/sa9/+bOiNQDF1XvgfMpbuhDqdgNiVYVW5eDktw==
X-Google-Smtp-Source: ABdhPJz8lkdiVYrj4P3x1i2Vrmi9AoEo5maSK7RR03IgaBMALT+NVIzESpOO1t4YOJK58xAcD/iJec3E8zUdkOJS9aA=
X-Received: by 2002:a63:f145:: with SMTP id o5mr14491018pgk.273.1629385583710;
 Thu, 19 Aug 2021 08:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210817033032.76089-1-songmuchun@bytedance.com>
 <YRxtZ3X8QGv/bui5@carbon.dhcp.thefacebook.com> <CAMZfGtV4LXDmv=Gyd5bKPy-V-3a4y3R62XGXnvZyeQ_xqCabJg@mail.gmail.com>
 <YRyQNEc79Km6M9xc@carbon.dhcp.thefacebook.com> <20210818003919.5bd008fec6cb0436af2443c4@linux-foundation.org>
 <CAMZfGtW-5eVqvqWpaeYT6HcpMdJ3zDimSFT-=JwxVJuuFH0FnQ@mail.gmail.com> <YR499cUnbD5tZGHG@cmpxchg.org>
In-Reply-To: <YR499cUnbD5tZGHG@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 19 Aug 2021 23:05:45 +0800
Message-ID: <CAMZfGtW8N_M-LQL-pny9han0EN7PCgGj4jggjKv7f61+juzm8w@mail.gmail.com>
Subject: Re: [PATCH] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 7:16 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Aug 19, 2021 at 02:33:37PM +0800, Muchun Song wrote:
> > On Wed, Aug 18, 2021 at 3:39 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 17 Aug 2021 21:44:36 -0700 Roman Gushchin <guro@fb.com> wrote:
> > >
> > > > On Wed, Aug 18, 2021 at 12:35:08PM +0800, Muchun Song wrote:
> > > > > On Wed, Aug 18, 2021 at 10:16 AM Roman Gushchin <guro@fb.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 17, 2021 at 11:30:32AM +0800, Muchun Song wrote:
> > > > > > > Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> > > > > > > PAGEFLAGS_MASK to make the code clear to get the page flags.
> > > > > > >
> > > > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > > > ---
> > > > > > >  include/linux/page-flags.h      | 4 +++-
> > > > > > >  include/trace/events/page_ref.h | 4 ++--
> > > > > > >  lib/test_printf.c               | 2 +-
> > > > > > >  lib/vsprintf.c                  | 2 +-
> > > > > > >  4 files changed, 7 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > > > > index 54c4af35c628..1f951ac24a5e 100644
> > > > > > > --- a/include/linux/page-flags.h
> > > > > > > +++ b/include/linux/page-flags.h
> > > > > > > @@ -180,6 +180,8 @@ enum pageflags {
> > > > > > >       PG_reported = PG_uptodate,
> > > > > > >  };
> > > > > > >
> > > > > > > +#define PAGEFLAGS_MASK               (~((1UL << NR_PAGEFLAGS) - 1))
> > > > > >
> > > > > > Hm, isn't it better to invert it? Like
> > > > > > #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> > > > > >
> > > > > > It feels more usual and will simplify the rest of the patch.
> > > > >
> > > > > Actually, I learned from PAGE_MASK. So I thought the macro
> > > > > like xxx_MASK should be the format of 0xff...ff00...00. I don't
> > > > > know if it is an unwritten rule. I can invert PAGEFLAGS_MASK
> > > > > if it's not a rule.
> > > >
> > > > There are many examples of both approached in the kernel tree,
> > > > however I'd say the more common is without "~" (out of my head).
> > > >
> > > > It's definitely OK to define it like
> > > > #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> > > >
> > >
> > > PAGE_MASK has always seemed weird to me but I figured that emulating it
> > > would be the approach of least surprise.  Might be wrong about that...
> >
> > IIUC, you seem to agree with the current approach. Right?
>
> We do use both schemes. PAGE_MASK, as you pointed out. PMD_MASK,
> PUD_MASK etc. also *hide* rather than extract the named bits.
>
> However, we already have a series of masks for page->flags in mm.h
> that follow the more common scheme of *extracting* the named bits:
>
> #define ZONES_MASK              ((1UL << ZONES_WIDTH) - 1)
> #define NODES_MASK              ((1UL << NODES_WIDTH) - 1)
> #define SECTIONS_MASK           ((1UL << SECTIONS_WIDTH) - 1)
> #define LAST_CPUPID_MASK        ((1UL << LAST_CPUPID_SHIFT) - 1)
> #define KASAN_TAG_MASK          ((1UL << KASAN_TAG_WIDTH) - 1)
> #define ZONEID_MASK             ((1UL << ZONEID_SHIFT) - 1)
>
> Because of that, I would agree with Roman here and say it probably
> makes sense to put the PAGEFLAGS_MASK definition next to those and
> follow the "mask everything but" semantics.

Thanks for your suggestions. I'll send a v2 patch.
