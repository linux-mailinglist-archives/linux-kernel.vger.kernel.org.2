Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDBA3D0382
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 23:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhGTURg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 16:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbhGTUKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 16:10:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F068BC061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 13:50:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t2so29716023edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 13:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXmPAgOyL+BBz09jacg1aZLHANboewgCvjK3IRp37+M=;
        b=CexM0fobFkGeZKt/XDFgzC2uVpyPQQkeYkBPEn4PuXSAEw2GL+zOXHNg3/fcNAlcBD
         b1R4ZHzVfR8tIlrik/Pt4MmPSNPJGGD1dAidUcNFNsxZgegUvgPvqYoEc2VcBCwkw257
         JFDZCRBAFhLIoC7NA8qfKohAtRn5E7MIFHrOIWZ+35RYBZPFjYk0TzBCAfIZ6Yfir0o0
         z8r9epJyBC+9MJ0jB0rAgZk3fsZkdAn8BHLj0GDjQz6leQ7CspjbQdNgbV65L8OXr4+n
         6naoI/EIGRyCH4CzNMG3M812r/3d59iT4tRWd+L5HjhwWjt0elyAI9hqR28y/ODj9X31
         fYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXmPAgOyL+BBz09jacg1aZLHANboewgCvjK3IRp37+M=;
        b=lJPML5yUOobmvNXKhQmY8C1dAX/NH79pjUd2AyBusFyOqiiIBKnmqSYoAxxXZ/u4TV
         9l3taHazXAqqez7YqnpaNAdRKQbjlYMLs7Fi1BC8f/pPL/HKH/tUWcabFS/I57XtEzJW
         /XCZ1vQEUMfANXPtNJmqSliJcEVeDNijhZWsNJD9A/Dlk9ci+gIcPW+bNA47cqz+BZ2v
         V+XnQAOWwg2zIaTi1Ji3ISyw0fAqxNedKCWg0vpPg67dy5qUvlehhYwVos+vx4jfqGXx
         LZM8vqapKYf1klelAPKqvBHuVQhLBBTDleF74qeLnsqpIc+00+dhoBrLYl8TK7qxE+XV
         iVyQ==
X-Gm-Message-State: AOAM532/n9HKvSUhYkS9eO7Pejl6WS0SqEp2PAZiC/k/cz01woX+OyxD
        W/IhP0mjn8wYvhHyALVPJA5G/VC3MLseGbqDBEI=
X-Google-Smtp-Source: ABdhPJx4b2v04XUMMAS3ZJEBCkn8DGU8Gu+gQabTwKgzsJIPBP+7A/UUswQQjcBHFLndqKM/h6j88El19hqEI1QxVbo=
X-Received: by 2002:a50:954c:: with SMTP id v12mr39330637eda.313.1626814236512;
 Tue, 20 Jul 2021 13:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210720074228.76342-1-songmuchun@bytedance.com>
In-Reply-To: <20210720074228.76342-1-songmuchun@bytedance.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 20 Jul 2021 13:50:24 -0700
Message-ID: <CAHbLzko=p0dA=TmTWqT1mrRm1rsvrBYpEOB=hZfq_S-ho5S5AQ@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix disabling preemption directly
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, cuibixuan@huawei.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 12:43 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The commit 832b50725373 ("mm: mmap_lock: use local locks instead of
> disabling preemption") fix a bug by using local locks. But commit
> d01079f3d0c0 ("mm/mmap_lock: remove dead code for !CONFIG_TRACING
> configurations") changes those lines to original version. I guess
> it is introduced by the conflicts fixing on merging.
>
> Fixes: d01079f3d0c0 ("mm/mmap_lock: remove dead code for !CONFIG_TRACING configurations")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/mmap_lock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index f5852a058ce0..1854850b4b89 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -156,14 +156,14 @@ static inline void put_memcg_path_buf(void)
>  #define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
>         do {                                                                   \
>                 const char *memcg_path;                                        \
> -               preempt_disable();                                             \
> +               local_lock(&memcg_paths.lock);                                 \
>                 memcg_path = get_mm_memcg_path(mm);                            \
>                 trace_mmap_lock_##type(mm,                                     \
>                                        memcg_path != NULL ? memcg_path : "",   \
>                                        ##__VA_ARGS__);                         \
>                 if (likely(memcg_path != NULL))                                \
>                         put_memcg_path_buf();                                  \
> -               preempt_enable();                                              \
> +               local_unlock(&memcg_paths.lock);                               \
>         } while (0)
>
>  #else /* !CONFIG_MEMCG */
> --
> 2.11.0
>
