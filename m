Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70244330801
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhCHGNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbhCHGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:13:20 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068C3C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 22:13:19 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m22so19146742lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 22:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zuLyIMtTu9vDSB4XkfAbZ0uX4PD6RfhA/3r6OaoQnI=;
        b=r6Qi4/4arJHvPgvhwoboibouvpk0NWSX8MipZS8QZ+BrdZdxwLBJKUDwMfgmWSW8Yu
         OZH2B04mSUrDBog35HKb+a26mrY/JSo/rqgSYqxxjkElj0TqI93KxvK8mDOdBk4yZ7J4
         X/0C1ExrYOpYy5hiIVH9AbKIOyHIhFTpjKjr+hIOCJRuZ+ncLhH7CbLiEcOvouFEaks8
         ShgECUbJ2CftJDm7mTfytGlC3iYLnz1LyTBoe8LmYjmUAUctAzwe0brhEZqv408a/h58
         shgs2HrLbuotvQ96Mkx66y73Bhm7sRyhj8qZJ3j4bk8muAJ9YVm+P3RmqRFS57fU58zb
         pGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zuLyIMtTu9vDSB4XkfAbZ0uX4PD6RfhA/3r6OaoQnI=;
        b=CKA7/DNtYk3uFDbbXZd/cFWIi4DGTRbSlUmsjdICr5rAvRr42swZO8Dq6cgrONEWAv
         Al8wJEDtMI6awxvB6F0DCrmLy8L/+rB1leGbqEJHbUuJoSxHoUonBdXNFjPacUaA3Wx2
         BBmV+NR5zUi3AkDDyX3jrkbfMt9ueTA2sisWLFCCPVRGRYCoWlPk/CH27O4wV+cNxRrC
         SnAlqxGfACYz1grwY5EvVl0aMJblWJnnt8w9ysvNUqlrI18nRYYrHjsE3sfvk7oxSpBr
         V5Jj2oOvi1okYZ2fFi/AyTg0JIvisHwgDDhXtc7FZyYmI72fhjnP3xmuHSWRnQyQesPV
         xhfg==
X-Gm-Message-State: AOAM533FOkasjkaWnFSBG3df9T8lutZMrj3d+fi1P021u3gBln4zqpKX
        eTXdILzYsiWJJgJy4WLwAe2nSTuIqDA/a2gezx3OcA==
X-Google-Smtp-Source: ABdhPJxc0v63Dy8DvVAk/DYaLK47IbF3fY9fLvX7nIB1BSkKIxNiS3PvWjGKhbB+E2Joya7ljUn0FqeLRBf/8nKdAng=
X-Received: by 2002:a05:6512:6c6:: with SMTP id u6mr13260075lff.347.1615183998124;
 Sun, 07 Mar 2021 22:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-6-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-6-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 7 Mar 2021 22:13:04 -0800
Message-ID: <CALvZod75fge=B9LNg_sxbCiwDZjjtn8A9Q2HzU_R6rcg551o6Q@mail.gmail.com>
Subject: Re: [v8 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
To:     Yang Shi <shy828301@gmail.com>, paulmck@kernel.org
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
> Using kvfree_rcu() to free the old shrinker_maps instead of call_rcu().
> We don't have to define a dedicated callback for call_rcu() anymore.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2e753c2516fa..c2a309acd86b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -192,11 +192,6 @@ static inline int shrinker_map_size(int nr_items)
>         return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
>  }
>
> -static void free_shrinker_map_rcu(struct rcu_head *head)
> -{
> -       kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> -}
> -
>  static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>                                    int size, int old_size)
>  {
> @@ -219,7 +214,7 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
>                 memset((void *)new->map + old_size, 0, size - old_size);
>
>                 rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> -               call_rcu(&old->rcu, free_shrinker_map_rcu);
> +               kvfree_rcu(old);

Please use kvfree_rcu(old, rcu) instead of kvfree_rcu(old). The single
param can call synchronize_rcu().
