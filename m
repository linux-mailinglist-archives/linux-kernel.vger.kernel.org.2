Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670FE3F139D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhHSGew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhHSGet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:34:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31EFC061756
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:34:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j187so4544513pfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15LFBoFuuP4d/TgXjeFGT8qoEp2fIp3JE5Jx5/6HQd4=;
        b=WlIT6qcLWZ7ujuhqd20mOKSFffOebZXPKce/CFAt2PYnng7DPDqrnqq1YPra9isQfk
         rrh5x4FDEz2sJPik7NPWgXLjs/8NxvcwqyFPJnmCUkfKdYpTvOEl66A9nmyikzHzjtEK
         kkGXFwgDXoumzIWICuVPacNMFK8FBP1zfqcDp18I1HAioGqO2AqrJu+5F5DVvsvo9quB
         nl8L/ALRyDwOI/jYNFg5ueDG2tsX+aTJZbKKeRZ1e9SiE/h9ZPB/oQlG4cDbz7qHfth0
         KbxreNoCHX78of8H6OmISCBwVZvA5rDl7FjEobrsGR8hw0VoIsU5HBN6WhYBszj9ggdW
         mGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15LFBoFuuP4d/TgXjeFGT8qoEp2fIp3JE5Jx5/6HQd4=;
        b=IEvp8NVf/AVAGS0SeNBMcaP+gyl7pMzl3+nHienyJbu+8SiZ9a6ZlxANaElMr21joD
         y5Ad3q8Zk6NBRIfHQR21LVhTYB8K+PRZHGs1yNUHqtRTRl/FfPF1YC6F2rpQu/odtkGR
         xAYHlZv8kV2+kwNuBFhoswXpyhtmUMNchn9eY3DBMw3ajopuBpXtwUGHubkZs962ZYW5
         ryoi3I1gqJZWye3ijztij+sMVZZ2j2tRCGwkyiecY5VeVEePPuHgUV8c0mzqd8m3j1TU
         k8zIN6pz1iv90gwQM6KxzqJo+IWMSJpy5V6wCvR6Xm5JoRylWaVk3514o9QPi+lG9xg8
         k15g==
X-Gm-Message-State: AOAM5307anmx65/3XQX45AFWLEYS6rEGwZmngdInIvJNGYuQ6zlDNJZx
        j/sQrDejbK0Ih/ldVgTMR8uNQTax3EL3lmI8ejXLlw==
X-Google-Smtp-Source: ABdhPJwotcdA2v3SP+h2EqsRy+pChj8lgDWAucmLra2wROM2MbS7834COYbjyI3lgZUHRLNaLOHdO72naBik8NOXQlc=
X-Received: by 2002:a63:f145:: with SMTP id o5mr12653784pgk.273.1629354853416;
 Wed, 18 Aug 2021 23:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210817033032.76089-1-songmuchun@bytedance.com>
 <YRxtZ3X8QGv/bui5@carbon.dhcp.thefacebook.com> <CAMZfGtV4LXDmv=Gyd5bKPy-V-3a4y3R62XGXnvZyeQ_xqCabJg@mail.gmail.com>
 <YRyQNEc79Km6M9xc@carbon.dhcp.thefacebook.com> <20210818003919.5bd008fec6cb0436af2443c4@linux-foundation.org>
In-Reply-To: <20210818003919.5bd008fec6cb0436af2443c4@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 19 Aug 2021 14:33:37 +0800
Message-ID: <CAMZfGtW-5eVqvqWpaeYT6HcpMdJ3zDimSFT-=JwxVJuuFH0FnQ@mail.gmail.com>
Subject: Re: [PATCH] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 3:39 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 17 Aug 2021 21:44:36 -0700 Roman Gushchin <guro@fb.com> wrote:
>
> > On Wed, Aug 18, 2021 at 12:35:08PM +0800, Muchun Song wrote:
> > > On Wed, Aug 18, 2021 at 10:16 AM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Tue, Aug 17, 2021 at 11:30:32AM +0800, Muchun Song wrote:
> > > > > Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> > > > > PAGEFLAGS_MASK to make the code clear to get the page flags.
> > > > >
> > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > ---
> > > > >  include/linux/page-flags.h      | 4 +++-
> > > > >  include/trace/events/page_ref.h | 4 ++--
> > > > >  lib/test_printf.c               | 2 +-
> > > > >  lib/vsprintf.c                  | 2 +-
> > > > >  4 files changed, 7 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > > index 54c4af35c628..1f951ac24a5e 100644
> > > > > --- a/include/linux/page-flags.h
> > > > > +++ b/include/linux/page-flags.h
> > > > > @@ -180,6 +180,8 @@ enum pageflags {
> > > > >       PG_reported = PG_uptodate,
> > > > >  };
> > > > >
> > > > > +#define PAGEFLAGS_MASK               (~((1UL << NR_PAGEFLAGS) - 1))
> > > >
> > > > Hm, isn't it better to invert it? Like
> > > > #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> > > >
> > > > It feels more usual and will simplify the rest of the patch.
> > >
> > > Actually, I learned from PAGE_MASK. So I thought the macro
> > > like xxx_MASK should be the format of 0xff...ff00...00. I don't
> > > know if it is an unwritten rule. I can invert PAGEFLAGS_MASK
> > > if it's not a rule.
> >
> > There are many examples of both approached in the kernel tree,
> > however I'd say the more common is without "~" (out of my head).
> >
> > It's definitely OK to define it like
> > #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> >
>
> PAGE_MASK has always seemed weird to me but I figured that emulating it
> would be the approach of least surprise.  Might be wrong about that...

IIUC, you seem to agree with the current approach. Right?
