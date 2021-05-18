Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9061E3871FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbhERGhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 02:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhERGhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 02:37:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EB1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 23:35:43 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g18so5012454pfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4V3WI5d+/eOgVrYmN1t+v+Ld7YNo5b1VMx3GP24x6w=;
        b=F3tSDObcGcc2/Txb9hBJSVkqxhQm5hMUM1gAg3W7v+QC58PYDu9zYmUvvijFO6z5iy
         e7OLV8n8DByS5TZnvBtZWqoONzdZNKjU+2Ieu3VRJV6CT8uAdvP6XQp7sb58mZ7QWfay
         mU3ZOrU7IgVijmWM+hpsX7qbQxqRxb7VJW6Pv8M5PGWgo87Dx3/0pAIa+OjfWzT4rQT1
         EcMTF396JyF6P8qNCn5IZlPR3sSBRoNJn0jVYsx96j7Ig5mUNvCBwxFVBPpwwzu0dDrW
         ssGDb6I7HaVZijQsU4QdsKt+BuAQtTwO14hXs8WLBZh7H80eZH3fraoTmBdxprgZVOqQ
         bcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4V3WI5d+/eOgVrYmN1t+v+Ld7YNo5b1VMx3GP24x6w=;
        b=YbBHBWpXBpiodc7b6KGSerQFDdGXR6pRgFwdWi3l3GjDT9z7RMOUJ+IrHourPDPEns
         rjdNqnfZjCzZr/oFvY+/NnxbU0Fnqtzg8P/lZKjtEw5hgxVZZMd3UCNWX5Hv/3aqyXAH
         0UtJ65NqWN3JKu2hwts/ongbB/qVl+JJua/Qhrl2hnEWgJa+uT24cbg7iTcQNxJfoZcl
         4vemlfxPDkn7hLqYATCPCX3+tEJfH79GSby+bhq5vuv9n6yaU5jgGrkF6r0FKMNJR8zL
         V+qEBsfaSNSttlegPy8DySNvRfEPtbakuEtTtXteWNaBz5xzODDsCUrXk8H3/hvmG5hE
         bSHg==
X-Gm-Message-State: AOAM531WqIh3GGWkuRDJxPTiW1T1/di7QFKaXYEH2yAMvwz7iuRrWnSw
        EjrZIQjhRkkXBe5wz2kTlAP1X2YXu3Y2Bav9L88hCw==
X-Google-Smtp-Source: ABdhPJyrPvWKv/zGaKn+g9Qh3i+DwmElKr3IfLgG3LihiPVfSouWo/ZlzqJqcbSGNQetv2880HAQFGYqB2eB56y7BiU=
X-Received: by 2002:a65:5288:: with SMTP id y8mr3504073pgp.31.1621319743031;
 Mon, 17 May 2021 23:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210518052038.491-1-wenhui@gwmail.gwu.edu>
In-Reply-To: <20210518052038.491-1-wenhui@gwmail.gwu.edu>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 18 May 2021 14:35:07 +0800
Message-ID: <CAMZfGtVQ0+1UG=vAZLWN-SROJqePB8Gf+jZoCpKBJ81qWoPAFg@mail.gmail.com>
Subject: Re: [External] [PATCH] memcontrol: use flexible-array member
To:     wenhuizhang <wenhui@gwmail.gwu.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:20 PM wenhuizhang <wenhui@gwmail.gwu.edu> wrote:
>
>
> Change depracated zero-length-and-one-element-arrays into flexible
> array member.
> Zero-length and one-element arrays detected by Lukas's CodeChecker.
> Zero/one element arrays causes undefined behaviours if sizeof() used.
>
> https://www.kernel.org/doc/html/latest/processd/deprecated.html
>
>
> Signed-off-by: wenhuizhang<wenhui@gwmail.gwu.edu>
> ---
>  include/linux/memcontrol.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0ce97eff79e2..f879efb1bc6e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -190,7 +190,7 @@ enum memcg_kmem_state {
>
>  #if defined(CONFIG_SMP)
>  struct memcg_padding {
> -       char x[0];
> +       char x[];

Have you tested this?

The compiler will complain about this. The output will be something like below.

    error: flexible array member in otherwise empty struct

Thanks.

>  } ____cacheline_internodealigned_in_smp;
>  #define MEMCG_PADDING(name)      struct memcg_padding name;
>  #else
> @@ -349,7 +349,7 @@ struct mem_cgroup {
>         struct deferred_split deferred_split_queue;
>  #endif
>
> -       struct mem_cgroup_per_node *nodeinfo[0];
> +       struct mem_cgroup_per_node *nodeinfo[];
>         /* WARNING: nodeinfo must be the last member here */
>  };
>
> --
> 2.17.1
>
