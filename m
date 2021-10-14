Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBA442DDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhJNPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhJNPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:13:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A179C02C30A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:01:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i24so27394798lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BgPbMZUg3AHIPgZBVoqfyExpxLxFLTly+c7L8vjvng=;
        b=EtQS7B1AIWL9XFdEes5Dd/g1277fNmryyfdb+sMr26dYVhXPs2hcQ8HJVpr3gwACIM
         ZB9qrXIzQ4oCn+3yIYMoCKeQ39Y/9PVMkmWvGzNYfXTZX/2B+zekABjJzUSBeOqOjTZ4
         PL4Q1C4V7CN5kslWMxr/cHoRzdi7s2LmYwnvkrsRR6Lvk+26uQ495rDHhKxfJWs2acgO
         +2ZTX9V6PdVRBNj2r8R1YHOaL40ky3yYNfQ/teOP2qx5qqZwaz/ynOyBj2B0a17/x/bO
         xl0N5oovJudgWPf/FH36Wml2+J9OcE/tAh87QEXuqiqX3dajD52YWwzNwc7ejn0/oEyq
         ckCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BgPbMZUg3AHIPgZBVoqfyExpxLxFLTly+c7L8vjvng=;
        b=ZqXa5DLNxvz4wSFKfDlGxH3jeasKRl9rds/nrizQozBeERAhPNQtO0p4F9XwKzDVL3
         eROe+CGQ+oHTv/BYXQUDwzMw61RFKvJCcy1VYcjOQaZ+8iY1snksE8egCfF4S0uRv7vK
         P3ZWArJSGEkro0GwAWU6SB/JtdVMVTnRNuWnLeoPHAgc4pj8f77OSUbSYdLYO3QqDv8l
         zu9WX2vdTkNVSXXPFkg6Pe/EaFLOh1gfp0f7SHOrT2X4wQF9pPmoIdK2kJVYfXwtY7uw
         6zeFL8nhBj6JpAb6XQ+kQoZawFortT6tRRqyRRguv+Q20mYzt5MEgDQMQVjoSqw4aOR0
         FcRA==
X-Gm-Message-State: AOAM530KESOWWLhtueRhZArJFqvuGTc8JUuVFq0BKe7D/r4y1L31GXuZ
        AI6KYS9M+NU996b2HzIxDkkOo/5KWl2uGbYAE6T6NQ==
X-Google-Smtp-Source: ABdhPJwvrMjD2HlCDGXyCG1QjW7zKaAkzlCK42+wrDhaw5k2wc7ckIjIG0TYfQIfdKlsGQwgjly31iqstdjTzhvAqT0=
X-Received: by 2002:a05:651c:1793:: with SMTP id bn19mr6396501ljb.475.1634223688029;
 Thu, 14 Oct 2021 08:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211013194338.1804247-1-shakeelb@google.com> <YWfZNF7T7Fm69sik@dhcp22.suse.cz>
In-Reply-To: <YWfZNF7T7Fm69sik@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 14 Oct 2021 08:01:16 -0700
Message-ID: <CALvZod4Br9iwq-qfdwj6dzgW2g1vEr2YL4=w_mQjOeWWDQzFjw@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 12:16 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 13-10-21 12:43:38, Shakeel Butt wrote:
> [...]
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 668edb16446a..b3acad4615d3 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5215,6 +5215,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> >       unsigned int alloc_flags = ALLOC_WMARK_LOW;
> >       int nr_populated = 0, nr_account = 0;
> >
> > +     /* Bulk allocator does not support memcg accounting. */
> > +     if (unlikely(gfp & __GFP_ACCOUNT))
> > +             goto out;
>
> Did you mean goto failed here? This would break some which do not
> have any fallback. E.g. xfs_buf_alloc_pages but likely more.
>
> Sorry I could have been more specific when talking about bypassing the
> bulk allocator. It is quite confusing because the bulk allocator
> interface consists of the bulk allocator and the fallback to the normal
> page allocator.
>

I did consider 'goto failed' here but for that I have to move
__GFP_ACCOUNT check after the "Already populated array" check in the
function. Basically what's the point of doing other operations
(incrementing nr_populated) if we are gonna skip bulk anyways.

Regarding xfs_buf_alloc_pages(), it is not using __GFP_ACCOUNT and
vmalloc() is the only __GFP_ACCOUNT user at this point. So, not an
issue for now but I suppose it is better to be future-proof and do the
'goto failed'.

Let me know what you think.
