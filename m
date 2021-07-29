Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2085E3DA6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbhG2Ojb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbhG2Oj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:39:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77426C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:39:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l17so7880761ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQ+TosWiDAdG8+90eQclOC0l7J20f+GG4ER7QwTBKX8=;
        b=R23L4N03E0Cp8DvPNPKl1idmWh2CJdaYEmaLa1zbfrqP6vbUf+kVIxIr+waUl74KJ7
         Mphdxreoppmm+jRPzPzsh1BxrZm8LVudhznf1T4QIzuK2yPi+akMMez82h2jumMlbVBf
         S4s7yiBKeS5xYqWyj6/0VB0Gc5h/lkfbSVQ8/wSDflor4uoM7saLwFNOPaGtfgypCOj/
         +WIjAxfYsT6tTBO/q53IY7HCwDcgVv78qaKosze2J5wD59XRmrOEtTa4h7EmF5Pf5cK0
         nkmiVrgBr2zJPDiZ0MD0JZ5mxei1/97cIXhT5vYsbRVqwrZO7WrhQf5r9ywwwTopzLvU
         jR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQ+TosWiDAdG8+90eQclOC0l7J20f+GG4ER7QwTBKX8=;
        b=rVkNYNSXCKB79dApVm8gCOOu6Ke2Nc8aIVTTU7VteeDwCfRyCXlg6xtNC9NQP/8vLK
         0Z/u5RCwv7PAiFAQoukBFWypijNJNdc9ZOUBQ412sG/9vewVCaTHca28/sjIc06nw/VK
         aDdPMxaB3SdauUo8ON27+0VOoHgwPNGb+tEpHIZfJ/5IpddiVpYYBRjvMhmUP0WX1uMu
         2vUrSxVBLZAsJCfGs+/ndCjityAYMkCdk4WL+cfeRM8fAWd+AlYNAGr0WjUZvBNA+8LH
         T3VJy0Kr48b5aRQ0XLfC9cFlA2pQd+QqwZFv7243Pkeqito/NqVdvNrIQW3FHLq8QldX
         ifYQ==
X-Gm-Message-State: AOAM530TQZLWHKgFknmz5/LfJguAZ5Vx/pdaXMtJKCfCSoOoEH6x2KZR
        xDoy3MKIJCAbPDeX16we7emXWAbffNnbxRNIYecqIg==
X-Google-Smtp-Source: ABdhPJysPj8T1T/jC1N62guQJtz/h9nWJSh3QUau+BzFLvn4bSnqGN64gK1+jXKEM+irMoznNKLcgVOnxOJpvkYACmY=
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr3111083ljj.279.1627569560514;
 Thu, 29 Jul 2021 07:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210729125755.16871-1-linmiaohe@huawei.com> <20210729125755.16871-6-linmiaohe@huawei.com>
In-Reply-To: <20210729125755.16871-6-linmiaohe@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Jul 2021 07:39:08 -0700
Message-ID: <CALvZod6n1EwcyLTi=Eb8t=NVVPLRh9=Ng=VJ93pQyCRkOcLo9Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm, memcg: always call __mod_node_page_state() with
 preempt disabled
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 5:58 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> We should always ensure __mod_node_page_state() is called with preempt
> disabled or percpu ops may manipulate the wrong cpu when preempt happened.
>
> Fixes: b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to charge kmem pages")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 70a32174e7c4..616d1a72ece3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -697,8 +697,8 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
>         memcg = page_memcg(head);
>         /* Untracked pages have no memcg, no lruvec. Update only the node */
>         if (!memcg) {
> -               rcu_read_unlock();
>                 __mod_node_page_state(pgdat, idx, val);
> +               rcu_read_unlock();

This rcu is for page_memcg. The preemption and interrupts are disabled
across __mod_lruvec_page_state().

>                 return;
>         }
>
> --
> 2.23.0
>
