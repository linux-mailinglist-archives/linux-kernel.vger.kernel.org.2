Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C5536E233
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhD1XdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD1XdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:33:09 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C74C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 16:32:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z23so27727093lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKq+LFxXyWBv0dDTFY+xwdbBAeyG/loY9cisPmftCiM=;
        b=fOK8Gte9Lv/qjiZD5DrB5u9ffD/eOuMtHeRXWH5DTq5IZNXrLrVYdv2yXGI8XKhop0
         WMqDH3qz7FrWIhw0WlFbPyWcreqCalPk9cNvVu76ktwMyChX/RXU5svLiLmwqUmqNxlo
         dZk1T0X7yPoRp/7oSqxflxCnz1sdA7jbVt5+Q62Yv4gaVlH+VIZCQaTM/4mPlnVnAcPo
         B9fWgjRbqwND3uMVNbtG4kM4CAB++EPz1ngJ7h+qcyduKi670SKL8Qijs04wwmRhactc
         N9q1nintLqo0k6ZYHrWI09cAl77fxkCeI/W4V/aMwmw9huJMaBIHQAQUVjn+CKII9w3D
         DjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKq+LFxXyWBv0dDTFY+xwdbBAeyG/loY9cisPmftCiM=;
        b=oEOaOR7jMHiDWClrc6h7nj6vSMWkyufSXHXVLzWJpxe8Yg+UzOGCRzQ345sSvGGUsy
         hX6+JhL1TZux0unDJMvtxm0N2GbuasM6ncH6H+SA+uJQ7nnv5waSOLDaRxPu4P/yPnkF
         ipfVykWXailP+hyqswQ4VwYqt/EuJQYDHT6IS8lqU+FZ9PJ0RHBkSrgSLMqO45nTe/ht
         lonKpebgeLBE8kFJuCVchskDpeHcykVi3cl1Yo6/tgipggsAucSg42NMYyM5i9tJ9hhD
         d4+PohYjpPk1xkUWO9yCXCK35dq9P4eVzoQGPIZHEKZx9Ptg+wBFvvtWzWoAa+69gkHL
         TdHQ==
X-Gm-Message-State: AOAM531FU3DBer8GuIEt/6btPWgpbDsLM0dJfo+K6MJgDDaHz7XhlG/i
        3ldQWpT9u60KQm8lS7Vh6jBwpjT9rUBLK/QoSJx0BA==
X-Google-Smtp-Source: ABdhPJy3P/E9ZXBwSluvDEgi8bjVYUJz8Z+EqxAxyirc6UV5SK1NI/Z+7EGWfDNucx42FfRiJqMqLlmVEiLBFgn0Ya4=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr21518327ljm.160.1619652741705;
 Wed, 28 Apr 2021 16:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210428094949.43579-1-songmuchun@bytedance.com>
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 28 Apr 2021 16:32:07 -0700
Message-ID: <CALvZod6XtOpPAg5BipOe3fWJrDXFhonqgne8eaD6QBr07rDR2w@mail.gmail.com>
Subject: Re: [PATCH 0/9] Shrink the list lru size on memory cgroup removal
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        alexs@kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 2:54 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> In our server, we found a suspected memory leak problem. The kmalloc-32
> consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> memory.
>
> After our in-depth analysis, the memory consumption of kmalloc-32 slab
> cache is the cause of list_lru_one allocation.
>
>   crash> p memcg_nr_cache_ids
>   memcg_nr_cache_ids = $2 = 24574
>
> memcg_nr_cache_ids is very large and memory consumption of each list_lru
> can be calculated with the following formula.
>
>   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
>
> There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
>
>   crash> list super_blocks | wc -l
>   952
>
> Every mount will register 2 list lrus, one is for inode, another is for
> dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
> MB (~5.6GB). But the number of memory cgroup is less than 500. So I
> guess more than 12286 containers have been deployed on this machine (I
> do not know why there are so many containers, it may be a user's bug or
> the user really want to do that). But now there are less than 500
> containers in the system. And memcg_nr_cache_ids has not been reduced
> to a suitable value. This can waste a lot of memory. If we want to reduce
> memcg_nr_cache_ids, we have to reboot the server. This is not what we
> want.
>
> So this patchset will dynamically adjust the value of memcg_nr_cache_ids
> to keep healthy memory consumption. In this case, we may be able to restore
> a healthy environment even if the users have created tens of thousands of
> memory cgroups and then destroyed those memory cgroups. This patchset also
> contains some code simplification.
>

There was a recent discussion [1] on the same issue. Did you get the
chance to take a look at that. I have not gone through this patch
series yet but will do in the next couple of weeks.

[1] https://lore.kernel.org/linux-fsdevel/20210405054848.GA1077931@in.ibm.com/
