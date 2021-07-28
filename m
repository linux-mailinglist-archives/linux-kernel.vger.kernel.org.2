Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74F3D919B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhG1PPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhG1PPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:15:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:15:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a26so4566426lfr.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tx+FYtBuZQVekt2gFR3FJ30E6SooR2qVzUKktdlwZyg=;
        b=jig5DPla8OJHGr3yjvnWsRWgFIW1UHe2tlc/rSmmDEwWVtH8D5MxsB0mkCDb1F+X//
         J4uz2TYqMCJWL1e+Qvk7+cE+4qgwWQ5kO5PdpDlAwMv+7iaTWk+4/Y93dvRsvSK4m7I3
         S+6Wtp58T6a50/HhNzruWXMBZpuExzelvVr/1e05rS+UjKRqMYFn4PngV2/JlcY7qyoU
         GZfejQWG9RiY+BvJe1YmaBWGEOrUZA5UFSLtOdc5iZ0r7DhM+8EeF+ZvfOISjbLNDOM1
         RWH2rJSbCNV86868EdR3/iAbMZBAy2owjGEAFPyIGiHeWvWYg8STdzn/lGHBVV1ppl07
         pe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tx+FYtBuZQVekt2gFR3FJ30E6SooR2qVzUKktdlwZyg=;
        b=cMVl0NS7O9WL0YU4afj5Cjv+UxYoij3E7hQBiqcY3merROpntrAwTwrdQ1SRBDXLAc
         PzHYaqF0FhYrzQOpSALB+EOjkKuRUQrpLUzyodbvFvPzwdPfQhC/a8hjH2ORUHaJ+Lky
         drPXi7wo32bRCaP8I3EdyjzUOi/VCCVmzpznbBbARjKXoODaCiLhWg2j7Y+LpV2RdKZ7
         Ytswj+y/OWSVUBVhzMEkkulLBmrkwMurGE9CXXGpIZvE6mySgJ3RomF2Thi4X+MSoz2V
         iHPlASXCckDO/6Gd69KWtCnhzGao0KNDGao3qXdv5cYnpatx6LDCgFPFfW+UsmneWudr
         9XFw==
X-Gm-Message-State: AOAM533bI/OwABB691JiE4R+fz4XA5HsOGSFDO6vcTVpAKTUpgvk/rg/
        Yy68USXHXUsYRSVLrFZXOldLGK4d6LWEtTqR1tJsYw==
X-Google-Smtp-Source: ABdhPJybpSnyrZNdgFQuBcyoqC2ai3dKbfuPkIMnBoiHzL9J1UqgAA5wmYbdyS/3dytw7BY5r8e0cAw3W0s512BkjNI=
X-Received: by 2002:ac2:4d86:: with SMTP id g6mr59011lfe.549.1627485301144;
 Wed, 28 Jul 2021 08:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210728145655.274476-1-wanghai38@huawei.com>
In-Reply-To: <20210728145655.274476-1-wanghai38@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 28 Jul 2021 08:14:50 -0700
Message-ID: <CALvZod5uUWWOdjvSnEpO+UMei9y2M711=ROtAm3TYw25L6trUg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcg: fix NULL pointer dereference in memcg_slab_free_hook()
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 7:57 AM Wang Hai <wanghai38@huawei.com> wrote:
>
> When I use kfree_rcu() to free a large memory allocated by
> kmalloc_node(), the following dump occurs.
>
> BUG: kernel NULL pointer dereference, address: 0000000000000020
> [...]
> Oops: 0000 [#1] SMP
> [...]
> Workqueue: events kfree_rcu_work
> RIP: 0010:__obj_to_index include/linux/slub_def.h:182 [inline]
> RIP: 0010:obj_to_index include/linux/slub_def.h:191 [inline]
> RIP: 0010:memcg_slab_free_hook+0x120/0x260 mm/slab.h:363
> [...]
> Call Trace:
>  kmem_cache_free_bulk+0x58/0x630 mm/slub.c:3293
>  kfree_bulk include/linux/slab.h:413 [inline]
>  kfree_rcu_work+0x1ab/0x200 kernel/rcu/tree.c:3300
>  process_one_work+0x207/0x530 kernel/workqueue.c:2276
>  worker_thread+0x320/0x610 kernel/workqueue.c:2422
>  kthread+0x13d/0x160 kernel/kthread.c:313
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>
> When kmalloc_node() a large memory, page is allocated, not slab,
> so when freeing memory via kfree_rcu(), this large memory should not
> be used by memcg_slab_free_hook(), because memcg_slab_free_hook() is
> is used for slab.
>
> Using page_objcgs_check() instead of page_objcgs() in
> memcg_slab_free_hook() to fix this bug.
>
> Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access slab page's memcg_data")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
