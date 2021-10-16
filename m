Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2090142FFBA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 04:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhJPCb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 22:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhJPCbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 22:31:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC0FC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 19:29:17 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a13so504460qkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 19:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpcMXlD4nO+K+Q8XzAFsUdO5HR/N4yrrpmRoJSfRZVc=;
        b=EnKIfT2UsVIuFY0xz0CB9IQD9sy5IpZQrEtBxQTjPmuqA5FIIaTzgNu2kbVr/BBuo6
         EFdPygJcPsnLBbP1UxnsxiS8vIZbAjLbbdRsmrIiAXjlD8l//MelTPh3ZxwB5a2ByBtL
         pFgRyTczQ7dKo3d1oCYXsM1U4fGgbWOxaJkWEcXLFQJkPQxcAankAz24OEAod27Noidc
         mG7Q2A72OqnG+fGAOwICODeYhBUCHwAnE7qyPrzD06xW8DiqsA6OSzVTLGLRcZM72iX2
         CkrsAsus+l4HnZrA304xWldcEh/PPuUO5/wU0nz9KRvhLx7L1DEMIs+4uaI3URwzpD9a
         O1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpcMXlD4nO+K+Q8XzAFsUdO5HR/N4yrrpmRoJSfRZVc=;
        b=sfZbxn1xV8gD4Ol/6TVNAdUtCQLtt3sojKKtg9NnQHqbdDbA3mFmAA5iaOauw/ICoW
         aLSLre0dGv02TdSMPfi4xFB8w7QBeJFMYVL44btHb6vxmxeSrjBXzony29cDU88yoL7k
         xPBY7hG0IYap7GU2FRlAE4Wi8VZ3YzHyrz25zFcvavftW2Q+mBKvegoUMGlIyWyHO0px
         BT4NLehfCSoFgD2tGNvT8sufHgpEc59LXgr1BO9OZdZ3N6/bCTm7O2rV86u8/fPYXah3
         9ht6YqQekX+GEuRAwRbPkfZggQMN7P3EUndLa4U/SyXJ9VaXGFY80YF2/ucSdYEBSvqC
         bCYQ==
X-Gm-Message-State: AOAM533AeVQ6wHh4NJmUDbM5QPohKDh8nJOyne66xBmMhivaKVswMyVw
        zhGwa29Vqch9D+rt8NUW68+w3RcadYjM7FDR+QIwrjJ1
X-Google-Smtp-Source: ABdhPJzDd178K+uCNadWMb0AKyso7BKqq1O2RA3LDtQOrhnb9ooPAqBDK6rCsXgWLsF6lp45yWw7XDbDcU4KgiuBDQk=
X-Received: by 2002:a37:4041:: with SMTP id n62mr12617004qka.225.1634351355936;
 Fri, 15 Oct 2021 19:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com> <20211015130035.aacc18a4d1ee141b306c2272@linux-foundation.org>
In-Reply-To: <20211015130035.aacc18a4d1ee141b306c2272@linux-foundation.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sat, 16 Oct 2021 10:28:54 +0800
Message-ID: <CAGWkznGt=9HznGA6R15z=QVZmnk9rGvQ77gN_G9UZk-XqzpF1g@mail.gmail.com>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 4:00 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 15 Oct 2021 14:15:29 +0800 Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Sibling thread of the same process could refault the reclaimed pages
> > in the same time, which would be typical in None global reclaim and
> > introduce thrashing.
>
> "None" -> "node", I assume?
>
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2841,6 +2841,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >                               sc->memcg_low_skipped = 1;
> >                               continue;
> >                       }
> > +                     /*
> > +                      * Don't bother current when its memcg is below low
> > +                      */
>
> The comment explains what the code is doing, but the code itself
> already does this.  Please can we have a comment that explains *why*
> the code is doing this?
We find that the patch help direct reclaiming bail out early and
eliminate page thrashing for some scenarios(etc APP start on android).
The case could be worse if each APP possess a unique memcg(pages on
current's lru are reclaimed more than global reclaim)
>
>
> > +                     if (get_mem_cgroup_from_mm(current->mm) == memcg)
> > +                             continue;
> >                       memcg_memory_event(memcg, MEMCG_LOW);
> >               }
>
