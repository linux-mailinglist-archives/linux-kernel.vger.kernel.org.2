Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1549A387443
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhERIpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbhERIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:45:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF07C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 01:43:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11so5161231pjm.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7RUwFbNr4T55OGnTBNFMlKiHYjLkrXfI2S2QDkmtpw8=;
        b=FeW76RMEV0WreRDTOeV69ili0KezGO7xVke4YrLwvRgWgkfoZQxxH6ZtktX9wtrLyR
         Wk9C9Qq47BqPmWreW2JvbieGLDXbaAPIm/M3DIbqlF1D0nAusGfMuNp+0wUZBwTM7TfZ
         Xv1wZmwKORc7GmuRMJS2o/ucsfw3tNVS3maRkoDUCR/J3tU6a2aue8Sq0laUaTXy2Y16
         KmP7QF5hyG+5dVs+RkE8+0lGNc+1NTWuISBYr0yBy7uqGZgRZeB1T5gywffaHg75hryH
         kAZHjG1W/wppR91XodAHaNqa+BmvJeRpdRfuzGCcc2LTtIhxxc6movlzutBa2mIIaoov
         dtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RUwFbNr4T55OGnTBNFMlKiHYjLkrXfI2S2QDkmtpw8=;
        b=Ui+ACMUYyE4eMd8vf5OJ3UFCxGBrHAaMTlDE8lTxJtCQrUflL5IBfIhPo59BmPGRNx
         5Ig4oB0rRwYp38CiI4JU1Y1OdP9UQZduhcUdFNsWaRTGLG7aPrswjbuoqXFb68Wp1ZMc
         49ZE9oMv76MmUOsqkGraqa0t5TU5gcZ9gTk01fe1fci4yG2+rGU0zAU5SmBcIR87cHRp
         U3E5qqpbcMj/pdFCsnA4WlExtu5qu6lmT4rBgreAKr9estxhiEgpeGNBb/DfLvaOtil9
         SegAFJcKSu8vEjIvu+cfgzkhTv6WZwFHw2OL8XGj5yTOyrB8IMDuKFPJf/Fs+bj6nM+Q
         puPQ==
X-Gm-Message-State: AOAM531zrYRkzgHSn7zI2Xn/ssztv2lpNq0gpUfYz4IPt72ciR+FpvIN
        1Zip15kz+mhtfaj1L+ij2VooK8KvXGJ2B89PfyAJwg==
X-Google-Smtp-Source: ABdhPJyOt5j3ntKwxttM42es9GIILQg/3UMjOKtJLMC3zucpKfZ9mLZOtfsKNDbTPUX487aUzZbh+Bp9881/W7ACRzQ=
X-Received: by 2002:a17:90a:3c8d:: with SMTP id g13mr4410578pjc.13.1621327427529;
 Tue, 18 May 2021 01:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210518052038.491-1-wenhui@gwmail.gwu.edu> <YKN19XI/6Wpk9+Eh@dhcp22.suse.cz>
In-Reply-To: <YKN19XI/6Wpk9+Eh@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 18 May 2021 16:43:11 +0800
Message-ID: <CAMZfGtVdCzaALfW=SSgKCV5-_+HU-7sf7RWJQuO=77STWOwjUA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcontrol: use flexible-array member
To:     wenhuizhang <wenhui@gwmail.gwu.edu>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 4:08 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 18-05-21 01:20:36, wenhuizhang wrote:
> >
> > Change depracated zero-length-and-one-element-arrays into flexible
> > array member.
> > Zero-length and one-element arrays detected by Lukas's CodeChecker.
> > Zero/one element arrays causes undefined behaviours if sizeof() used.
> >
> > https://www.kernel.org/doc/html/latest/processd/deprecated.html
>
> I do understand why zero-length structures are discouraged for trail
> space but does the same concern apply to internal padding inside
> structures to enforce alignment to different cache lines? AFAIK this is
> a trick we use at other places and I do not remember having heard about
> any problems.
>
> nodeinfo is a different case where flexible arrays seems reasonable to
> me.

I do agree with Michal's suggestion. If you only change nodeinfo
to a flexible array in the next version. Please also remove the
comment below it.

>
> > Signed-off-by: wenhuizhang<wenhui@gwmail.gwu.edu>
> > ---
> >  include/linux/memcontrol.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 0ce97eff79e2..f879efb1bc6e 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -190,7 +190,7 @@ enum memcg_kmem_state {
> >
> >  #if defined(CONFIG_SMP)
> >  struct memcg_padding {
> > -     char x[0];
> > +     char x[];
> >  } ____cacheline_internodealigned_in_smp;
> >  #define MEMCG_PADDING(name)      struct memcg_padding name;
> >  #else
> > @@ -349,7 +349,7 @@ struct mem_cgroup {
> >       struct deferred_split deferred_split_queue;
> >  #endif
> >
> > -     struct mem_cgroup_per_node *nodeinfo[0];
> > +     struct mem_cgroup_per_node *nodeinfo[];
> >       /* WARNING: nodeinfo must be the last member here */

I mean this comment. Because the compiler will help us to
check this if we convert it to a flexible array.

Thanks.

> >  };
> >
> > --
> > 2.17.1
>
> --
> Michal Hocko
> SUSE Labs
