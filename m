Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3E5439313
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhJYJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhJYJ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:58:08 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E31C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:55:46 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v7so24567387ybq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyTuCec8PQH+pdQXKJ1aGslhFhlqmgZiu6+0uLpWr9w=;
        b=4W4AxVmNGhV7mCGfx+Kqc6uNJXvrd6mg0DRSx4TETf/0qPR7gPBcRIGWDbzO4sxGMr
         R7+SBGvXb/c7O35EHZydkvaflGFZmTWqQ1+EpFUFwUzsjEFB74eAPsR1lcXvrJHWVbGO
         QYwuoQl+Yajrd+SrgxZsw7PMVBnPzaNyaKHZ+uyR+YQis4wQ8ZJM6AkgDYTQeVWTXvLs
         IUOwruVwpZjlxOAKUNQJOu9DrTt9XX/WfYPcOFAZ3Aj16Vn6w74QF12gbyOa43PY9CSh
         xYSjOAB/A14nUmfdJHZ0tksfKbGc0kew050bWy3I+odQ941pWm5bvzLSeprlCE4VZF9D
         aBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyTuCec8PQH+pdQXKJ1aGslhFhlqmgZiu6+0uLpWr9w=;
        b=YAHCUUN15LM3R9w3rDHSoarwQp1Fk0agQXdkTWvfCIf4DDbysFZPxszQkrU7lBTDFV
         Yx0ilnOzvtBJ5RRXw52Tbz/5XVU/w9uBJ81uLkWbPAz1Eft61e01ba1v75x8+PluJKWK
         TFAXiWTEzfhDYVGLop9UMvUB8FWIqqMyw/BCITtxjAyv/rSPjTkrBCkmgkhzY1B3xEC1
         peq6O+diegsVdoclkWPGYfflI1Bd0XNa46wZT8rHZtATaWAkWDMNuMeRHMRk0Y6/sYCX
         SK3kPa87yukQp26dvWTFV7uIVHYVs49mjmT1yUeZx2NFzbUfOkXonVLBehZRnFc9L2Qe
         /pWA==
X-Gm-Message-State: AOAM531QGYZrWrXiVKcpeOukyioS5i5HUfNJyyu/SdjYVdIFHFZ7gHnG
        kdXVIWV1Dx9FEOp2EParxYwv1QHAlUfFRaMi449iIPT0F2yPzQ==
X-Google-Smtp-Source: ABdhPJybpta/2nb9bybcpUTdcPtobZ/viduZOJ197+NNZeAHKXLoS3N1q1HuAxWHH5YYn1DpqSkR+XiZhXetLCTF+30=
X-Received: by 2002:a05:6902:1142:: with SMTP id p2mr16763193ybu.279.1635155745658;
 Mon, 25 Oct 2021 02:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211025082843.671690-1-songyuanzheng@huawei.com>
In-Reply-To: <20211025082843.671690-1-songyuanzheng@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 25 Oct 2021 17:55:07 +0800
Message-ID: <CAMZfGtUWb5MGTAWots=db97OqAiH_LxJpRAqZUX_GdJsiVX4EQ@mail.gmail.com>
Subject: Re: [PATCH -next] mm/vmpressure: fix data-race with memcg->socket_pressure
To:     Yuanzheng Song <songyuanzheng@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 4:14 PM Yuanzheng Song <songyuanzheng@huawei.com> wrote:
>
> BUG: KCSAN: data-race in __sk_mem_reduce_allocated / vmpressure
>
> write to 0xffff8881286f4938 of 8 bytes by task 24550 on cpu 3:
>  vmpressure+0x218/0x230 mm/vmpressure.c:307
>  shrink_node_memcgs+0x2b9/0x410 mm/vmscan.c:2658
>  shrink_node+0x9d2/0x11d0 mm/vmscan.c:2769
>  shrink_zones+0x29f/0x470 mm/vmscan.c:2972
>  do_try_to_free_pages+0x193/0x6e0 mm/vmscan.c:3027
>  try_to_free_mem_cgroup_pages+0x1c0/0x3f0 mm/vmscan.c:3345
>  reclaim_high mm/memcontrol.c:2440 [inline]
>  mem_cgroup_handle_over_high+0x18b/0x4d0 mm/memcontrol.c:2624
>  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:164 [inline]
>  exit_to_user_mode_prepare+0x110/0x170 kernel/entry/common.c:191
>  syscall_exit_to_user_mode+0x16/0x30 kernel/entry/common.c:266
>  ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:289
>
> read to 0xffff8881286f4938 of 8 bytes by interrupt on cpu 1:
>  mem_cgroup_under_socket_pressure include/linux/memcontrol.h:1483 [inline]
>  sk_under_memory_pressure include/net/sock.h:1314 [inline]
>  __sk_mem_reduce_allocated+0x1d2/0x270 net/core/sock.c:2696
>  __sk_mem_reclaim+0x44/0x50 net/core/sock.c:2711
>  sk_mem_reclaim include/net/sock.h:1490 [inline]
>  ......
>  net_rx_action+0x17a/0x480 net/core/dev.c:6864
>  __do_softirq+0x12c/0x2af kernel/softirq.c:298
>  run_ksoftirqd+0x13/0x20 kernel/softirq.c:653
>  smpboot_thread_fn+0x33f/0x510 kernel/smpboot.c:165
>  kthread+0x1fc/0x220 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
>
> When reading memcg->socket_pressure in mem_cgroup_under_socket_pressure()
> and writing memcg->socket_pressure in vmpressure() at the same time,
> the data-race occurs.
>
> So fix it by using READ_ONCE() and WRITE_ONCE() to read and write
> memcg->socket_pressure.
>
> Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
