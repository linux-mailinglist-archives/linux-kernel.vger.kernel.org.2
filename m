Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C0E3D90DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbhG1Oo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbhG1Oo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:44:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA53C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:44:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z2so4480846lft.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6hplgm1AOnVRZYwW0TRgRGo6eN4ywXDspCC0lWNzLAA=;
        b=joZBLJq5jAiJ/cDOdzO6CZncB4oI/y+eYnbZlIvesJXEovYwNIpq9d+tLLn2o0q2iV
         o1Ue6EWrFZk62q25X7VczcS5WI9e0a6NsPVD+5X0PQR1Ng1PG6jFW0edntDNYecclsbM
         VVW2g7lSZld4LT/xCK/Y8zWGQBXw03NEHmSvPW97nKe8eCgd3ZQXxluKVMcfKH3abkc4
         mBON+BbMIbkxXIwEeuZZIAnSIZzFCr6dlAMtPaQrlsuWSjlqg0UIOJ2XioTfcS2IZ/5C
         gwlIVts3FvRRJ9AeYanctDC5+TcbEZ/LUpAX3cNOBCxHaa59jjeybOZHdlpUrsZIaOFl
         eNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6hplgm1AOnVRZYwW0TRgRGo6eN4ywXDspCC0lWNzLAA=;
        b=HQdsObDIKISH9Fp2RnQg9kqdvc2DWwtx90NmYFM607ufVXHIf6CUeCVkZDlX9+IrUP
         yZ1o9hT4pOGf58c6Q7bzTR6LAVzGpbzdsJ4BnQZT81up32en7C1JQNKcvaD/W4l2ru1B
         s29WV9iNgtLrJLTn8mU3HzdBPPPncLXMaDZlYq3n00I9HZUx7AJBi/RLCguwL9PmdXdY
         bUkKXxl2MRbTUz8RJiilR+m9wNCRzxWEo3dxYzZ1ONvy98wp/7EyPCUdZvM7zyv9nArw
         SYjobSa0MI6S7CturkJxqMXgC0bqlwA6PfxtHhT2AA0GVjAGMndsjM5EpOAhgHxQfbqi
         HKtQ==
X-Gm-Message-State: AOAM53042Dhr9Cbam33ej5bbiA8K9ZTEqZSPZPRrAfqSgS2v+OVs6mmW
        N2yyo4YS5wRe3cmKoSCD9iOTjZkLHpdS29Z+TiV83A==
X-Google-Smtp-Source: ABdhPJxakU5Mag9Ula6SSPel7HLGxlJn+QfaO6fBnfMigRAo4toXEmVoyMpiAlUqegtZnK4/34LGq+aXnPy6aoxbY/A=
X-Received: by 2002:ac2:4d86:: with SMTP id g6mr20701148lfe.549.1627483465480;
 Wed, 28 Jul 2021 07:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210728091348.272714-1-wanghai38@huawei.com> <YQFaPwYzzy0UPzNI@dhcp22.suse.cz>
 <e9ad7775-2df2-fdb3-cfa9-6c1c265142f5@huawei.com> <CALvZod7a36w7Hht4yrozTMx4gdNxZ7mzi+MeaD-yuv69rxYY7Q@mail.gmail.com>
 <aced9cfe-2ae4-b717-62f5-e495ca4934c2@huawei.com>
In-Reply-To: <aced9cfe-2ae4-b717-62f5-e495ca4934c2@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 28 Jul 2021 07:44:14 -0700
Message-ID: <CALvZod4G8XrxoHhyJcUKxtbKSLKUFwLWb8_50Ed6j1-3hn1WVA@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: fix NULL pointer dereference in memcg_slab_free_hook()
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 7:34 AM wanghai (M) <wanghai38@huawei.com> wrote:
>
>
> =E5=9C=A8 2021/7/28 22:26, Shakeel Butt =E5=86=99=E9=81=93:
> > On Wed, Jul 28, 2021 at 7:21 AM Kefeng Wang <wangkefeng.wang@huawei.com=
> wrote:
> >>
> >> On 2021/7/28 21:23, Michal Hocko wrote:
> >>> On Wed 28-07-21 17:13:48, Wang Hai wrote:
> >>>> When I use kfree_rcu() to free a large memory allocated by
> >>>> kmalloc_node(), the following dump occurs.
> >>>>
> >>>> BUG: kernel NULL pointer dereference, address: 0000000000000020
> >>>> [...]
> >>>> Oops: 0000 [#1] SMP
> >>>> [...]
> >>>> Workqueue: events kfree_rcu_work
> >>>> RIP: 0010:__obj_to_index include/linux/slub_def.h:182 [inline]
> >>>> RIP: 0010:obj_to_index include/linux/slub_def.h:191 [inline]
> >>>> RIP: 0010:memcg_slab_free_hook+0x120/0x260 mm/slab.h:363
> >>>> [...]
> >>>> Call Trace:
> >>>>    kmem_cache_free_bulk+0x58/0x630 mm/slub.c:3293
> >>>>    kfree_bulk include/linux/slab.h:413 [inline]
> >>>>    kfree_rcu_work+0x1ab/0x200 kernel/rcu/tree.c:3300
> >>>>    process_one_work+0x207/0x530 kernel/workqueue.c:2276
> >>>>    worker_thread+0x320/0x610 kernel/workqueue.c:2422
> >>>>    kthread+0x13d/0x160 kernel/kthread.c:313
> >>>>    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >>>>
> >>>> When kmalloc_node() a large memory, page is allocated, not slab,
> >>>> so when freeing memory via kfree_rcu(), this large memory should not
> >>>> be used by memcg_slab_free_hook(), because memcg_slab_free_hook() is
> >>>> is used for slab.
> >>>>
> >>>> So in this case, there is no need to do anything with this large
> >>>> page in memcg_slab_free_hook(), just skip it.
> >>>>
> >>>> Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access sla=
b page's memcg_data")
> >>> Are you sure that this commit is really breaking the code. Unless I h=
ave
> >> Yes, we confirmed that this commit introduces the bug.
> >>> missed something there shouldn't be any real change wrt. large
> >>> allocations here. page_has_obj_cgroups is just a different name for w=
hat
> >>> what page_objcgs is giving us.
> >> maybe we could simply use page_objcgs_check to fix the issue ? we will
> >> check it again.
> > You will see the same crash with page_objcgs_check as well.
> > .
>
> I just test it. It won't crash.
>
> This is the test case:
>
> node =3D kmalloc_node(299999, GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT, =
-1);
> kfree_rcu(node, rcu);
>

Indeed it is checking MEMCG_DATA_OBJCGS directly. Yeah, we can use
page_objcgs_check(). Please send a new version of the patch and do CC
Roman.
