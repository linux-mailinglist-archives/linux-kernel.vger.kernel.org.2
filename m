Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8D034706F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhCXEM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhCXEMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:12:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7779C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 21:12:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e33so13782939pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 21:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p25/A4gvraG4GrSK0QNzOG7a5VxfROedfZ595WlOtfc=;
        b=dcybOyPrXjytyX5pqMpHq8KRfUwYSfHAcYJklNkF9C0WqV2l8aCcMxYGdOP4D7qhdp
         copt+iCQiFQ4KuUx9E+HAFPPUgnrXOPsETJnboSF5n22AHxlpHcp2Agbpes9Zkz2UAOD
         qC1Y2WXXcu5ITAMwqykA1uqqWA9fAChSeddHX4PwUcNjUIHpIzkrL5rfQfZQqhPBpfxb
         kVtqT35+slxDS0ArWP5GlCCCFg4+rUw+Qy3RJQZ/2pUqDDgZLYu7PdJ1BWFKg9JvT9ac
         YYlghi1IuADLX0m0e2vfIKIjOk445huOG8NAWzL/MTCPoDrTCtJ75wyCOvP8wfeN3zHt
         Gt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p25/A4gvraG4GrSK0QNzOG7a5VxfROedfZ595WlOtfc=;
        b=PBnHhnqxB3zRyfUDPKfSo/Xh5g8ov5N/V7OH35pKSw2OftoGYJLfqsN0rTIsDKLT4m
         CJ3BRTo29fGKoLQMutpnKNm1OIHha0JcBDBawzAFP3f9DCLk05iOXZpot7PGnq4Trw/G
         fWSMszSf6A7o6Y+rcg9HCaxfNu65yHMmp5iefBIZtobslNUQr4EnlnIVBRlfDq34ksUd
         hp9g0WcXs+KjT4matgJTtmnrb2gDhK3j5rWCSOMGa/dkUmTffx+NGmNbZrO1FdbmKVcg
         xG78ZlRDDNpTXYjJAE5Pvu9loE28mxN7/hV1n8AuISn5/6uemb1b5KaP89NKGrxJN0JD
         +g0Q==
X-Gm-Message-State: AOAM531/7r+3ou2G1xZk9veubQBZYbaUrN6cwpWcMqKyertS/rN0CSyL
        2qfdvpSoXsl+VpdbLqw/I+o4tfFLL+eNs6M5HJwUdA==
X-Google-Smtp-Source: ABdhPJzhnlivy0sipBYYKv2VrxoVNvIAAAZInhgxCH+QDjHCo855VaazR7l4bm1Vgd+lSac03FJFIeqwomdjoNGFR80=
X-Received: by 2002:a65:6645:: with SMTP id z5mr1312058pgv.273.1616559133180;
 Tue, 23 Mar 2021 21:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210323145653.25684-1-songmuchun@bytedance.com>
In-Reply-To: <20210323145653.25684-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 24 Mar 2021 12:11:35 +0800
Message-ID: <CAMZfGtWT8XXDtg0Jcv=1qJpdLD6foJWE=kB_i1ZyHjvrku=vrw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix memsw uncharge for root_mem_cgroup
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:04 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The pages aren't accounted at the root level, so we cannot uncharge the
> page to the memsw counter for the root memcg. Fix this.
>
> Fixes: 1f47b61fb407 ("mm: memcontrol: fix swap counter leak on swapout from offline cgroup")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I am very sorry. I should repent. I suddenly realise the fix is totally
wrong. Because the @memcg cannot be root memcg when
@memcg != @swap_memcg. Please ignore this patch. I am very
sorry for the noise. And sorry to Michal.


> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 533b4b31b464..7d765a106684 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7155,7 +7155,8 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>         if (!cgroup_memory_noswap && memcg != swap_memcg) {
>                 if (!mem_cgroup_is_root(swap_memcg))
>                         page_counter_charge(&swap_memcg->memsw, nr_entries);
> -               page_counter_uncharge(&memcg->memsw, nr_entries);
> +               if (!mem_cgroup_is_root(memcg))
> +                       page_counter_uncharge(&memcg->memsw, nr_entries);
>         }
>
>         /*
> --
> 2.11.0
>
