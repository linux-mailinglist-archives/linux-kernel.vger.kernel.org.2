Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2CD3DB12C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhG3Cer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhG3Cep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:34:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A429C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:34:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q2so9258084plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrnW4TDngOfmT4k1Ifughwagt8BmS1Mfblfsw7s1vyw=;
        b=sCBp+WebYpI5Z9F5/Q3Yqxn7z/iABDei+1bGAY6Eb+qvxZnqBq3AoNCMtY7SjlRdCw
         V0gox9Fyqip/WZUwEbnACYCEwQP9fPDxfzFbSVadNYyenjP4DvwlYI6sfO+0wo9PQO++
         DeEOjlwQGzxR7u2teqGXnaffsL1lNMExo9NQlJR00TUC0qx/6sYJopIwQuuBZa+k8aEq
         f6zX0jjLeZGNF0zhY86tGIVqrkY+g6RKKUOvyPh7eP2Cx+MRJIYvdv8pAkt4cG1OLDE+
         nfBed/rDolcbxTZZsQ1QjFY5GQAtGOCGH6OhFu7v/3eWULQji7xUH18UC5PQig+rY30B
         mG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrnW4TDngOfmT4k1Ifughwagt8BmS1Mfblfsw7s1vyw=;
        b=cgQBeEucWG4Mu+RWUD8YjpDAGK0K3YA6ufkHIkP1K/LUpX6bFYsbb0Qv9fZNdYvsPd
         TdSTE3davVxn/6tFlqkjld9YYK/FvxNFDzMQT5EuPGq1n/hONaBx4VJDav/9hXnqKedv
         ZVTFYnfOK51bhDH4L0j3XwCjbIE+X34zTLMSDXQTj1gsA+B+YUkVu2Y/5ATVQAWOdDlH
         Zjn13kEBGYEqNnE5SV3VLwg4ykQpIENWa8axBGB3iQbm89Y3jpIOYKo0eRsjP7md/k9t
         EH6Ckg3Uz/0ewvTuQ+UTP32/ic/jHvSilr1WEmNlA2Ydzlk6FHaZnm6oaf3aIXhLlQIj
         sAJw==
X-Gm-Message-State: AOAM533mP8EBD6ggyimBmkhR42iocPDnUr5Pc6z9QahkjmzIJplvC1oA
        i94P6NiJJo+RlOiD6LVnEV21JE6++23KImPRg09yAQ==
X-Google-Smtp-Source: ABdhPJzmgpl+O4iYQgoT3Ku82TzGbEGeGUtmB2tMZ58JKjkpbyAh74p90jNkObUdqkedLXTRssh5VexSBlLg96Ex/rE=
X-Received: by 2002:a62:92d7:0:b029:32c:8c46:9491 with SMTP id
 o206-20020a6292d70000b029032c8c469491mr280988pfd.2.1627612480527; Thu, 29 Jul
 2021 19:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210729125755.16871-1-linmiaohe@huawei.com> <20210729125755.16871-6-linmiaohe@huawei.com>
 <CALvZod6n1EwcyLTi=Eb8t=NVVPLRh9=Ng=VJ93pQyCRkOcLo9Q@mail.gmail.com> <29c4bb2a-ceaf-6c8b-c222-38b30460780f@huawei.com>
In-Reply-To: <29c4bb2a-ceaf-6c8b-c222-38b30460780f@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Jul 2021 10:33:59 +0800
Message-ID: <CAMZfGtUMBZeo-P48MECO=xM9-apeLMAZZGE3VNsg_u5P523BEg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 5/5] mm, memcg: always call
 __mod_node_page_state() with preempt disabled
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 9:52 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2021/7/29 22:39, Shakeel Butt wrote:
> > On Thu, Jul 29, 2021 at 5:58 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> We should always ensure __mod_node_page_state() is called with preempt
> >> disabled or percpu ops may manipulate the wrong cpu when preempt happened.
> >>
> >> Fixes: b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to charge kmem pages")
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/memcontrol.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index 70a32174e7c4..616d1a72ece3 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -697,8 +697,8 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
> >>         memcg = page_memcg(head);
> >>         /* Untracked pages have no memcg, no lruvec. Update only the node */
> >>         if (!memcg) {
> >> -               rcu_read_unlock();
> >>                 __mod_node_page_state(pgdat, idx, val);
> >> +               rcu_read_unlock();
> >
> > This rcu is for page_memcg. The preemption and interrupts are disabled
> > across __mod_lruvec_page_state().
> >
>
> I thought it's used to protect __mod_node_page_state(). Looks somewhat confusing for me.
> Many thanks for pointing this out!

Hi Miaohe,

git show b4e0b68fbd9d can help you find out why we add
the rcu read lock around it.

Thanks.

>
> >>                 return;
> >>         }
> >>
> >> --
> >> 2.23.0
> >>
> > .
> >
>
