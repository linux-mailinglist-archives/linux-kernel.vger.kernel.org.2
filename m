Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC93F17E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbhHSLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbhHSLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:17:12 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC88C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:16:35 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y144so6689917qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GqNWvt3mRolDHwE66h5rouh0U1Qc+bL7CrWojzf5dRA=;
        b=tLtoShExnPg6ODUan9LMeKzDlSF8kv/VkmL1JrIS+2481uABbaYaWy4ybTkFLU2pPH
         PyoJD1Mnqerh1zR2mMA8MJ2AeC/9kb9VbvcwCxJOnoUamfVtcFFJheZKLxcoslrBFDVL
         2pYdearUS57d4ZmNb5gO10tGWgaP4lihwPIkKEefo292Yc7Jcm+v+2NBulcYtlx6zrou
         hmCIuW/eM9riBzfiYMYG8btnqLJBPGr1iB9nVbvLnFWSIYlUfPZ1QPnKhPDPi/SIIlx9
         9MrqvAev7abZzsHvvSQJ9RSHnMSzntM3L/cO0IB513ZOjo+Ghgo4xYntH9mexS3FKpuC
         WEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GqNWvt3mRolDHwE66h5rouh0U1Qc+bL7CrWojzf5dRA=;
        b=kgtDohnEAzmnQIjT+WDAXSBxq4Jvv84i/ylaKBEyf4fStwkowL6HIUhwVTw15KHedA
         /xllQbjEcaFRCadm8PbeLM8Q7eViAolRRl3wnXg6i2fHi+We1JmEw6HxpHYIiWqi8woy
         t6L6HHhcC/FqMKuoUD1Y5pKhR16JBXjU/EHvG3BoBzdQExsDIa/MNMU+Coggc1gIbv3G
         V8OdZqXKmoUB2gWH/Djflhl4lgjpJbmlNk4zGbZ282O6T2v/qU4jIABfMZZw1fwmcwjh
         hn0rR0WXIEx6xB1X5Lz2E6Wp2TNkN/ypxhPl8Z1PWK8XOIc+LoavvnIN6sz/7vFR2WW1
         6x1Q==
X-Gm-Message-State: AOAM530KikanWUwgzMreHvKfZ0zMm6xULISJKgEz9xlrxjeemp087zSp
        CAMECWrQDvON0UYTchAqhVMB4w==
X-Google-Smtp-Source: ABdhPJxT+LxE512ewKYe1PF2KOOZVj/m8nipQ7H1gmSjRwUHzetyf5sNABp1ltzWJrNUGazFBpHDHg==
X-Received: by 2002:a05:620a:941:: with SMTP id w1mr2998230qkw.434.1629371795033;
        Thu, 19 Aug 2021 04:16:35 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id g8sm1383337qkm.25.2021.08.19.04.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:16:34 -0700 (PDT)
Date:   Thu, 19 Aug 2021 07:18:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
Message-ID: <YR499cUnbD5tZGHG@cmpxchg.org>
References: <20210817033032.76089-1-songmuchun@bytedance.com>
 <YRxtZ3X8QGv/bui5@carbon.dhcp.thefacebook.com>
 <CAMZfGtV4LXDmv=Gyd5bKPy-V-3a4y3R62XGXnvZyeQ_xqCabJg@mail.gmail.com>
 <YRyQNEc79Km6M9xc@carbon.dhcp.thefacebook.com>
 <20210818003919.5bd008fec6cb0436af2443c4@linux-foundation.org>
 <CAMZfGtW-5eVqvqWpaeYT6HcpMdJ3zDimSFT-=JwxVJuuFH0FnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtW-5eVqvqWpaeYT6HcpMdJ3zDimSFT-=JwxVJuuFH0FnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 02:33:37PM +0800, Muchun Song wrote:
> On Wed, Aug 18, 2021 at 3:39 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 17 Aug 2021 21:44:36 -0700 Roman Gushchin <guro@fb.com> wrote:
> >
> > > On Wed, Aug 18, 2021 at 12:35:08PM +0800, Muchun Song wrote:
> > > > On Wed, Aug 18, 2021 at 10:16 AM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Tue, Aug 17, 2021 at 11:30:32AM +0800, Muchun Song wrote:
> > > > > > Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> > > > > > PAGEFLAGS_MASK to make the code clear to get the page flags.
> > > > > >
> > > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > > ---
> > > > > >  include/linux/page-flags.h      | 4 +++-
> > > > > >  include/trace/events/page_ref.h | 4 ++--
> > > > > >  lib/test_printf.c               | 2 +-
> > > > > >  lib/vsprintf.c                  | 2 +-
> > > > > >  4 files changed, 7 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > > > index 54c4af35c628..1f951ac24a5e 100644
> > > > > > --- a/include/linux/page-flags.h
> > > > > > +++ b/include/linux/page-flags.h
> > > > > > @@ -180,6 +180,8 @@ enum pageflags {
> > > > > >       PG_reported = PG_uptodate,
> > > > > >  };
> > > > > >
> > > > > > +#define PAGEFLAGS_MASK               (~((1UL << NR_PAGEFLAGS) - 1))
> > > > >
> > > > > Hm, isn't it better to invert it? Like
> > > > > #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> > > > >
> > > > > It feels more usual and will simplify the rest of the patch.
> > > >
> > > > Actually, I learned from PAGE_MASK. So I thought the macro
> > > > like xxx_MASK should be the format of 0xff...ff00...00. I don't
> > > > know if it is an unwritten rule. I can invert PAGEFLAGS_MASK
> > > > if it's not a rule.
> > >
> > > There are many examples of both approached in the kernel tree,
> > > however I'd say the more common is without "~" (out of my head).
> > >
> > > It's definitely OK to define it like
> > > #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> > >
> >
> > PAGE_MASK has always seemed weird to me but I figured that emulating it
> > would be the approach of least surprise.  Might be wrong about that...
> 
> IIUC, you seem to agree with the current approach. Right?

We do use both schemes. PAGE_MASK, as you pointed out. PMD_MASK,
PUD_MASK etc. also *hide* rather than extract the named bits.

However, we already have a series of masks for page->flags in mm.h
that follow the more common scheme of *extracting* the named bits:

#define ZONES_MASK		((1UL << ZONES_WIDTH) - 1)
#define NODES_MASK		((1UL << NODES_WIDTH) - 1)
#define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
#define LAST_CPUPID_MASK	((1UL << LAST_CPUPID_SHIFT) - 1)
#define KASAN_TAG_MASK		((1UL << KASAN_TAG_WIDTH) - 1)
#define ZONEID_MASK		((1UL << ZONEID_SHIFT) - 1)

Because of that, I would agree with Roman here and say it probably
makes sense to put the PAGEFLAGS_MASK definition next to those and
follow the "mask everything but" semantics.
