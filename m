Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC0833083B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhCHGkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbhCHGkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:40:25 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58441C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 22:40:24 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id c19so6322937ljn.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 22:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAOQAdW2gJleMVEvY9uVkWH8JBAiFCjWdKg9XMUoT3c=;
        b=LwefvH06zFhM9HjOdO0twZV744eF72MK8lLPc7E2DGRrfwVsJRVG2ebpuHJqNHtc6a
         pbROrFakeP4zE4UEoaxv0lNoMR+gVqBhsKqxCVPrRwIltPi0TZxBpgHCvXZA8ZT5pLc6
         J8QlQ7H1W+upe7SpGJkCRyhwLS0feyNuuhTzaZ+fepKO2BdKWLJPioJk06lCJkKoSinh
         iEFypeVFO4BE4mMwQ0OdQdsASlMcxXUsCfw0hKmJO6tng189ROuV0RNZEBta6MB9UUAb
         J9V391tCLQeKe6GT58MOC6EoQ1lKaPS7U5mcuWAmfxKKtvj6VvSeHLsmmuLW0iu0G+gE
         SyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAOQAdW2gJleMVEvY9uVkWH8JBAiFCjWdKg9XMUoT3c=;
        b=txleJuBFeooJzVLTm6WrB4PISSUjqFlLVP0DSj1Q0xiIDzNOVJ8OxW966SpLKNXPjE
         r7jVadkFYDMoPKWkcHQd6lOqS56xYa/JB7OoXi096oOpqR96toDyIqqoTK5tLe2HIGlb
         4RzFvn++yjOIV96k8HPq7P67sN32lcjSFLoziYyVyINewO227j2hE7ik5wsiPPQb3axZ
         bHzvIjKFdOtNun3N2PJyWlOzBKy00xI9jtSGS39xTQjOP0QXBAiLnOG6R1/zle1cpZir
         CeqUXgY4BG68ZK1ccgflcp3NQl8eV5qfSfypJnm2s/Y7SVX3yylcfYsim1QMgdUY5RY6
         FLuw==
X-Gm-Message-State: AOAM532pmWLrF6Pk95Fy0mY57CgyGIyor+kDRGAcOr5bV6dmr1nPPKt0
        03soFliTEQgKCslxr0QR0otpAggQQfIKxC+Nd/LLXA==
X-Google-Smtp-Source: ABdhPJx2MwNnM9KxheS2vwBmxXnWYjXdOmwiKsgw5szW6RqYJwuEICOKBs2B6gY68hWVvo3tWilSSwMB9dCsoZOnxGY=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr9630706ljg.122.1615185622519;
 Sun, 07 Mar 2021 22:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-4-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-4-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 7 Mar 2021 22:40:08 -0800
Message-ID: <CALvZod7Z6A=qFHOy2BODiTcK-fz=Yid5-LhbzofQBa8aemt1Lw@mail.gmail.com>
Subject: Re: [v8 PATCH 03/13] mm: vmscan: use shrinker_rwsem to protect
 shrinker_maps allocation
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Since memcg_shrinker_map_size just can be changed under holding shrinker_rwsem
> exclusively, the read side can be protected by holding read lock, so it sounds
> superfluous to have a dedicated mutex.
>
> Kirill Tkhai suggested use write lock since:
>
>   * We want the assignment to shrinker_maps is visible for shrink_slab_memcg().
>   * The rcu_dereference_protected() dereferrencing in shrink_slab_memcg(), but
>     in case of we use READ lock in alloc_shrinker_maps(), the dereferrencing
>     is not actually protected.
>   * READ lock makes alloc_shrinker_info() racy against memory allocation fail.
>     alloc_shrinker_info()->free_shrinker_info() may free memory right after
>     shrink_slab_memcg() dereferenced it. You may say
>     shrink_slab_memcg()->mem_cgroup_online() protects us from it? Yes, sure,
>     but this is not the thing we want to remember in the future, since this
>     spreads modularity.
>
> And a test with heavy paging workload didn't show write lock makes things worse.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
