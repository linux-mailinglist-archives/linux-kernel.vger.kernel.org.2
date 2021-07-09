Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25F3C2841
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhGIR37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:29:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205DC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:27:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u25so9164081ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A3BFSbignNESj8/rrwZ1G7zuaCPgGVuO823S/jHyGy0=;
        b=raXro5aqHVk05FqTrS0rJjDV0MZ5+ERPmzQZfuH4nwxpLbqvs33kwRqpd1Y3wfueAn
         13oMZAwMS/vpxqlRC13oy5NBgkRRbSl3Fu51UXlk4PfttNKOME2w6oJ61aE5yP/SwLqo
         An96A6j5eCxtZEaUfZYKpsyaPZpufz6QEAQxfBeyaZ5K4AWiDHQPINxpSYf77MWMDGJO
         O1W4afwnIwmK9CpfZybIzXwmVK8krSTUIV3I/B9kMDzTBKTaseBG/LJ3JQeYJh5Tdm5X
         cAlwgtTckxjr7yAQGgJc1AdMzb5aa+aBL5xSvmoV25k/DvgyefzRjrWC2G3AHuRPtNWA
         0iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3BFSbignNESj8/rrwZ1G7zuaCPgGVuO823S/jHyGy0=;
        b=gAIulI1Snf4EchnKWHRPb5gTNg294J8OaGDK6mRdeCFTts/BrFRYcfUBQZHLVw6nAK
         kFJpfhkUpkBulWiebMBgY6EESuKXfO3y7UoHedWsLhAmgocBuSxRLKlWETUKQrriniV6
         3j8XqgpEwOTK37CbK7dHZIlnzprLgR/KzExsI4ybf7mao50zVZg5jdHX+oYcC+gwE9jD
         yrAVdg9YBMN1qIlexYl9WDofg/L1AlGEhKlXaCB+2gPgz4BuU5mWG5LJQzHAiUlUHwuW
         qKN619B64DnZNDuMsFrwpljfkDSsnw8VJHPWxsqO05ORaOjqCWNBwWclSL1fdh7APomi
         VACg==
X-Gm-Message-State: AOAM533SICpwKzVHZvXjRi9Lz25MyAI88nsLMMu3OOqurKpnE9m1GcTk
        Z6muNjEzEWvrTWr/354mvMtAsd8DMrUUbiy5SymnAQ==
X-Google-Smtp-Source: ABdhPJxSTF27Vf8rpwGTyQEHiZoBoQsGHn5uAdCOrMmM2Yc/JJMk/btI8xEmJa8aPs/xwKR6xmWlXa18b7sKsYeZYBM=
X-Received: by 2002:a2e:8215:: with SMTP id w21mr29626159ljg.160.1625851632594;
 Fri, 09 Jul 2021 10:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210709171554.3494654-1-surenb@google.com>
In-Reply-To: <20210709171554.3494654-1-surenb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 9 Jul 2021 10:27:01 -0700
Message-ID: <CALvZod4=WD9suY1J+DKwOjxyCrCYvH=eQVPAjvZ2JJ2Qn3C2Zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 10:15 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Inline mem_cgroup_{charge/uncharge} and mem_cgroup_uncharge_list functions
> functions to perform mem_cgroup_disabled static key check inline before
> calling the main body of the function. This minimizes the memcg overhead
> in the pagefault and exit_mmap paths when memcgs are disabled using
> cgroup_disable=memory command-line option.
> This change results in ~0.4% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> configurationon on an 8-core ARM64 Android device.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
