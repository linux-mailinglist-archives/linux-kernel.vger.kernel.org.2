Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0578F3EF980
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhHREgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhHREgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:36:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6319AC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:35:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so8054428pjn.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0JQ8tEmQQ4pfyMY58xvtQYlkLkIIdxXFUVuLwMvJj0=;
        b=VhcgTg2l9q3Z8IM1CIom3Kn9rpLwPr1Mr2BTdsrf2thOPB+N7Va3WN3gehco3HUPZW
         KGrWuQleDrKfslEp2eRlsba+YXNh5WhE/rzVMbQgEcDb4aBeoxeSD5O3JhtEzNxaMMnS
         rfV7sLaFiG61OGlIvBDUqHZZAVACNQIYh1DcA3o4RafkHvh6pTyQHUsDoC2GT8lRmcp0
         2T0dYfnjYpm5H8xzFh0oe3Ho7CiwdYtdT/OJkTf3UOM3LkmfFTZzTPCDTo+Q/5YlEgqp
         jee9uDfZk1ldQWCzhBF1I1yhLLnc+IEFxmZFoWIFE6q87ja3AYP6zsaYMofS/qX53eP4
         b6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0JQ8tEmQQ4pfyMY58xvtQYlkLkIIdxXFUVuLwMvJj0=;
        b=TKHgqoUqEfrMPrFvRmieY1S8kgr4TySYGPX+H8+J4CxLC06oP8JkhYk1CXWWtVDoau
         tnAf9ObXDzEAvp3ZXk81KNOV0Gaop/Wj2mBkZWEzYCSaeH7iTMTKu6+cUTBSahJjgsro
         a2gADsmJIcZ8V/77w/714I+gI0K2SjZFh1Hc7/yyg5M76dBCUUemsIewnOGoWSpfOeAp
         lTQleQ45kc1+EdV0Ec7FusuiZaiRI91rWGqEBawyL6IMlEZjJR+j7RbgLslDK50TpFa4
         +aNNY0Amz5ETFFyVrgc6TJvWooHkEyfQBCQJmPKWnxs1qYZi+xTRCqDKs4iuxd5ahoM5
         xVBA==
X-Gm-Message-State: AOAM530sDNP866DeJPduvTld7e/VBuBPV1G3NVodI57mx8Ep2BpbRv+H
        RWwoUJDPGWEsn67zFGfMjllfSkofHpHRhw3EshBrFw==
X-Google-Smtp-Source: ABdhPJwLx2VhS6tdMEWY50Y1AL8GlE7uTpu8J/H8MbFM8lGPTWniNcOQNhEhpL8+sqjzvKb47RO3huZ22gpw2hhb7qY=
X-Received: by 2002:a17:90a:eb17:: with SMTP id j23mr7263644pjz.229.1629261346848;
 Tue, 17 Aug 2021 21:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210817033032.76089-1-songmuchun@bytedance.com> <YRxtZ3X8QGv/bui5@carbon.dhcp.thefacebook.com>
In-Reply-To: <YRxtZ3X8QGv/bui5@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 18 Aug 2021 12:35:08 +0800
Message-ID: <CAMZfGtV4LXDmv=Gyd5bKPy-V-3a4y3R62XGXnvZyeQ_xqCabJg@mail.gmail.com>
Subject: Re: [PATCH] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:16 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Aug 17, 2021 at 11:30:32AM +0800, Muchun Song wrote:
> > Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> > PAGEFLAGS_MASK to make the code clear to get the page flags.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/page-flags.h      | 4 +++-
> >  include/trace/events/page_ref.h | 4 ++--
> >  lib/test_printf.c               | 2 +-
> >  lib/vsprintf.c                  | 2 +-
> >  4 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 54c4af35c628..1f951ac24a5e 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -180,6 +180,8 @@ enum pageflags {
> >       PG_reported = PG_uptodate,
> >  };
> >
> > +#define PAGEFLAGS_MASK               (~((1UL << NR_PAGEFLAGS) - 1))
>
> Hm, isn't it better to invert it? Like
> #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
>
> It feels more usual and will simplify the rest of the patch.

Actually, I learned from PAGE_MASK. So I thought the macro
like xxx_MASK should be the format of 0xff...ff00...00. I don't
know if it is an unwritten rule. I can invert PAGEFLAGS_MASK
if it's not a rule.

Thanks.

>
> Thanks!
>
> > +
> >  #ifndef __GENERATING_BOUNDS_H
> >
> >  static inline unsigned long _compound_head(const struct page *page)
> > @@ -975,7 +977,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
> >   * alloc-free cycle to prevent from reusing the page.
> >   */
> >  #define PAGE_FLAGS_CHECK_AT_PREP     \
> > -     (((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON)
> > +     (~(PAGEFLAGS_MASK | __PG_HWPOISON))
> >
> >  #define PAGE_FLAGS_PRIVATE                           \
> >       (1UL << PG_private | 1UL << PG_private_2)
> > diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
> > index 5d2ea93956ce..643b1b4e9f27 100644
> > --- a/include/trace/events/page_ref.h
> > +++ b/include/trace/events/page_ref.h
> > @@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
> >
> >       TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
> >               __entry->pfn,
> > -             show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
> > +             show_page_flags(__entry->flags & ~PAGEFLAGS_MASK),
> >               __entry->count,
> >               __entry->mapcount, __entry->mapping, __entry->mt,
> >               __entry->val)
> > @@ -88,7 +88,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
> >
> >       TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
> >               __entry->pfn,
> > -             show_page_flags(__entry->flags & ((1UL << NR_PAGEFLAGS) - 1)),
> > +             show_page_flags(__entry->flags & ~PAGEFLAGS_MASK),
> >               __entry->count,
> >               __entry->mapcount, __entry->mapping, __entry->mt,
> >               __entry->val, __entry->ret)
> > diff --git a/lib/test_printf.c b/lib/test_printf.c
> > index 8ac71aee46af..eadcc6458b10 100644
> > --- a/lib/test_printf.c
> > +++ b/lib/test_printf.c
> > @@ -614,7 +614,7 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
> >       bool append = false;
> >       int i;
> >
> > -     flags &= BIT(NR_PAGEFLAGS) - 1;
> > +     flags &= ~PAGEFLAGS_MASK;
> >       if (flags) {
> >               page_flags |= flags;
> >               snprintf(cmp_buf + size, BUF_SIZE - size, "%s", name);
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index dd006adfe853..ff7c180a2971 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -2019,7 +2019,7 @@ static const struct page_flags_fields pff[] = {
> >  static
> >  char *format_page_flags(char *buf, char *end, unsigned long flags)
> >  {
> > -     unsigned long main_flags = flags & (BIT(NR_PAGEFLAGS) - 1);
> > +     unsigned long main_flags = flags & ~PAGEFLAGS_MASK;
> >       bool append = false;
> >       int i;
> >
> > --
> > 2.11.0
> >
