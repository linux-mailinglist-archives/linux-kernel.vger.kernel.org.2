Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3000C42A91C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhJLQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhJLQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 12:10:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874A6C061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 09:08:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so89958018lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUSRBbgEONe1rUoJU8RUgo+k+yVw3zQ7WDhpeBulOJo=;
        b=U2adeNOvUPaST/L3dSzVje06TwnmZra9J3YOC3Ib1CnFQxFgTZmUh+QSJm10Oc5t9V
         3XiOM53aTlVLZ+rZhOyYQ3hcLSToUPIHsMGF0LCNQn86Gn/x14THrcqcwrrDrBZLriR8
         5SOd7yfJTgEdDoEiCreoIErh2BIJI4DfV9DAY6U5MGG1phvpd4fOzymvLrXfZ+X3c1Oz
         RuQbvFSJBA8XgOGS741rhWf+98RLMOt0k7375Ww4+8WdRix5eXzY68cRbtp1Q97C0sBZ
         3bLzwD7cZ+yveWz4jdGqUZRUSkRuwauS9FSALhacAiA90OpBjhp6R0NstWF885Z2TPcv
         NnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUSRBbgEONe1rUoJU8RUgo+k+yVw3zQ7WDhpeBulOJo=;
        b=8O9TPSrXzFLIUcmK8Tu3Jzbg/HndsnZoFjCfTDJKHJ9WnCRbV7UhFDr3q2wguxnORA
         wsEBnIiCorZgCnxV/guxOlGFRgHJNeh7obuKNsJICvSEFdmO3r6Mi3w0IIVAYLRct/4T
         BzNs+3LiDDKPqPH8VPNaGAD3lahzBC0hAt83dA0kESxsPdwYu73MNC9uIz8pB53r839D
         7BGTmfmir9AQ8vQARqw1L/B7NAINwpf8LWUplj7zEeQogqiHpHX9hiGcUF5ebNKjnSOj
         FuKk+wTGM+SIVRqrF+sd9JkiMXCKHUUbLYIGz2esBzdYxq4SOhtTKh8r3Up4Ys1VfWLj
         yJQw==
X-Gm-Message-State: AOAM530JPzpXN0h8RutzCEDuwMYGieMveYIoIb3+832jZSzbk1LCFv7K
        BQUP4yXC4bAe1e6M3ShGJx13053TCs/f16KC7g/loQ==
X-Google-Smtp-Source: ABdhPJyIpHMQgAoe2Q9DOIypcQAwWCMAYb9SmwCY4mmtBZZasOUiUymZkJcmy0t2UQMhnDHgK+ax0uiYswOB7r5Did0=
X-Received: by 2002:a05:6512:3b0a:: with SMTP id f10mr15565240lfv.8.1634054929389;
 Tue, 12 Oct 2021 09:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
 <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com> <YWWrai/ChIgycgCo@dhcp22.suse.cz>
In-Reply-To: <YWWrai/ChIgycgCo@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Oct 2021 09:08:38 -0700
Message-ID: <CALvZod7LpEY98r=pD-k=WbOT-z=Ux16Mfmv3s7PDtJg6=ZStgw@mail.gmail.com>
Subject: Re: [PATCH mm v3] memcg: enable memory accounting in __alloc_pages_bulk
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 8:36 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 12-10-21 17:58:21, Vasily Averin wrote:
> > Enable memory accounting for bulk page allocator.
>
> ENOCHANGELOG
>
> And I have to say I am not very happy about the solution. It adds a very
> tricky code where it splits different charging steps apart.
>
> Would it be just too inefficient to charge page-by-page once all pages
> are already taken away from the pcp lists? This bulk should be small so
> this shouldn't really cause massive problems. I mean something like
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c274cf..8bcd69195ef5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5308,6 +5308,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>
>         local_unlock_irqrestore(&pagesets.lock, flags);
>
> +       if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT)) {
> +               /* charge pages here */
> +       }

It is not that simple because __alloc_pages_bulk only allocate pages
for empty slots in the page_array provided by the caller.

The failure handling for post charging would be more complicated.
