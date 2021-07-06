Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8ED3BC6E3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhGFGxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhGFGxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:53:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68AEC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 23:50:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so1299794pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxRxvbvPJKtE9j1haCeD3JgDCpQu9adJA5ZIJGxvPe4=;
        b=Ul2aED+i54aC8bXAxZYg5syxf8716TFdPxxYI6RbeRglt+HKwfDCrpHO+wTGXaRPin
         e2DMz8bcNaYJQf1s7ZlVg8AX9S1iIyIA2L4BszwoCMjHKjiVifQZHT+W8MBxPRdoVyZd
         U/o7pR6YzonABNKJ/ZBhCGeuIF15GU7A0EqNeP4I4x0GJd5/jqVNbxycyj4VY56zG1e+
         U3vgnxoYIml67EkVzM8aS7ENEV9jdcWtDOzJCVQWXc1j2GZ595QgBFWZJ5MW3WqYclRE
         VK0WNB1IjS2TmAEjVR5dJ5FLvoRkMe7Bw3J4AHyx4zxGx6VsOt432wc90O16uIOsNoQv
         JVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxRxvbvPJKtE9j1haCeD3JgDCpQu9adJA5ZIJGxvPe4=;
        b=Rle9DGChsQGb76c/KS24MRY1XXvZOQ4F2sTgSoGzyT4GlLWRBf8vErfHItg0ZmUTU5
         P7inGUK4ymLWe6h9j9uYw68CBlCxZ6w4Z+Xvu/VHGFabRfnBJHD1ro4kVwLxFS4fBJ0X
         YCaE86Tbrz1XZ0pvywd98mFI4kWbdTTLypijRsyoOLR2yOLxQ3j0yhAoVdcIvRxuKhBT
         feY9o5AU8L/L3EKpqj4Ydpn00oC8zLQZx70wnAfjtVKpUoB04SOF1I9gugHSHwVXntve
         ROs80yOxgTk2Bc2jVZNkbRrJRTbkOgGCDOzE6+9p41fRbYBe2tKBTvYfzzd0IwBj6ryY
         sfMQ==
X-Gm-Message-State: AOAM532atz9r6igPBrTfjwzTFgZrqjcAGtAagQawQggiX0xr5/u+jHyZ
        ZeGB4h4xqnf54ciAvFoGTUlLMt5Sz5r9FM86gKy27g==
X-Google-Smtp-Source: ABdhPJwPgLex1MgFrzlym+XQVZMzXx2/SdHK+j5HfduDsARtC1KBVtO22hDeA8cEHw2KJUni+uX2VE5b+8+59JJnGPk=
X-Received: by 2002:a17:90a:14a4:: with SMTP id k33mr19609735pja.13.1625554241252;
 Mon, 05 Jul 2021 23:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210706032907.1276-1-qiang.zhang@windriver.com>
In-Reply-To: <20210706032907.1276-1-qiang.zhang@windriver.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 6 Jul 2021 14:50:04 +0800
Message-ID: <CAMZfGtVB-UQV0i4_mrRrt59iWFZbchm1FtT_TFhaE6Bmp43Hfw@mail.gmail.com>
Subject: Re: [External] [PATCH] mm/page_alloc: Fix sleeping function called in
 case of irqsdisable.
To:     qiang.zhang@windriver.com
Cc:     mgorman@techsingularity.net,
        Andrew Morton <akpm@linux-foundation.org>, alobakin@pm.me,
        wangqing@vivo.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 11:29 AM <qiang.zhang@windriver.com> wrote:
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> .....
> __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
>  ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
>  prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
>  __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
>  alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147
>  alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
>  stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
>  save_stack+0x15e/0x1e0 mm/page_owner.c:120
>  __set_page_owner+0x50/0x290 mm/page_owner.c:181
>  prep_new_page mm/page_alloc.c:2445 [inline]
>  __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
>  alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
>  vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
>  __vmalloc_area_node mm/vmalloc.c:2845 [inline]
>  __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
>  __vmalloc_node mm/vmalloc.c:2996 [inline]
>  vzalloc+0x67/0x80 mm/vmalloc.c:3066
>
> If the PAGE_OWNER is enabled, in __set_page_owner(), the pages will be
> allocated to save calltrace info, due to the allocated action is executed
> under irq disable(pagesets.lock be held), if the gfp variable contains
> the flag that causes sleep, will trigger above information. the
> prep_new_page() is not need to disable irq for protection, fix it through
> enable irq before call prep_new_page().
>
> Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
> Reported-by: syzbot+0123a2b8f9e623d5b443@syzkaller.appspotmail.com
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d6e94cc8066c..8d7f0f5ce891 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5309,12 +5309,14 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>                 }
>                 nr_account++;
>
> +               local_unlock_irqrestore(&pagesets.lock, flags);
>                 prep_new_page(page, 0, gfp, 0);
>                 if (page_list)
>                         list_add(&page->lru, page_list);
>                 else
>                         page_array[nr_populated] = page;
>                 nr_populated++;
> +               local_lock_irqsave(&pagesets.lock, flags);

Because pagesets.lock is relocked here, the current
thread can be scheduled to another CPU. The @pcp
and @pcp_list need to be reloaded. Otherwise, it is
broken in the next loop.

Thanks.

>         }
>
>         local_unlock_irqrestore(&pagesets.lock, flags);
> --
> 2.17.1
>
