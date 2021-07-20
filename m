Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286C43D0420
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 23:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhGTVPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhGTVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 17:09:43 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7828EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 14:50:20 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z9so133306iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lonf35HEQtzdwS1vVAGOjU19/cVFx6og3CRt+wfciSE=;
        b=G44vkWpmc+BkoRZ1w/UfuDI9K6MQV90PEFYbyoWOoAtjAy30QqLPShTGoyX+EPyBOV
         PVLcPkAogJgJhUCIv5IllHPKQ7V7krzcCA9plyTO/uNUUvRzKdNFIaEUe5OlJZg5RNGi
         9j/EgcyjSjd9uCkXmj1XBPHvEyFP+y/wTlf9eW3lNcp24oquZANtnV/OAYo0pjFSvEMt
         n1Nm01HUNbA7bJ88+HRwMWsebBmmtWOOtwn5qQxZEQcJ1SSzAV906vcAb0jjc2Waodqk
         eERR+LAdvPfNlQhs4b8pcE8xfvDQhsotwXhx8LktrM4fRMUjLXpxz1Ja24550YC9U3Un
         Jeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lonf35HEQtzdwS1vVAGOjU19/cVFx6og3CRt+wfciSE=;
        b=RlZ0txxz5eIi0ukrfl9zeTezCaADtrNqx/prsui8VFvoJExnxyfyrbXps6JeFFnd4m
         0LAEK/GSJ7qUPx75TSDbmh3BmYIX6q+LBSxplqbUe9gDjArfw5gKRMvL7S4MxF2ssMQm
         EZNXlkQiPVJCfFo/sYI0K2CPVLbsHP/LSsOljM15FjVKSeIw1wX+t4GFdcBFlyk8/5x3
         jckIxh9JD9n7s1OhW2CGBFBu2G8t/2P15u6ylQDVKfUzi6LX3A9jXrsogd0LH1wKkgJb
         LPWo2Eei46DbCBsFdW6dRCCDjltQ/LZEuRUOBbacmeogl4UXxwxLFHLUo2Zhgu5HsiF9
         PZ5A==
X-Gm-Message-State: AOAM531pcxTBJNAhqvI9BHTxZFEtav+tsSeHf6fqwMy/EF52JLi61k3S
        hsqKaCtYIY6HgYJLHizTP4USzbgqmtgSWdQK3Bc=
X-Google-Smtp-Source: ABdhPJwH3IKrussB0xcgu/Ki697Ft7w2up+2svX4KnJyA+rWIH1v07knNVhZx/U7xh4buipS310hgtIO2pbqvoc7nwo=
X-Received: by 2002:a5d:91d8:: with SMTP id k24mr24558310ior.84.1626817819905;
 Tue, 20 Jul 2021 14:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210720074228.76342-1-songmuchun@bytedance.com>
In-Reply-To: <20210720074228.76342-1-songmuchun@bytedance.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 20 Jul 2021 23:50:08 +0200
Message-ID: <CAM9Jb+g569xR72-GMbCRK1KXZYgjP0gX8gd3dyExy-MS+oCwKA@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix disabling preemption directly
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, shy828301@gmail.com,
        cuibixuan@huawei.com, Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The commit 832b50725373 ("mm: mmap_lock: use local locks instead of
> disabling preemption") fix a bug by using local locks. But commit
> d01079f3d0c0 ("mm/mmap_lock: remove dead code for !CONFIG_TRACING
> configurations") changes those lines to original version. I guess
> it is introduced by the conflicts fixing on merging.
>
> Fixes: d01079f3d0c0 ("mm/mmap_lock: remove dead code for !CONFIG_TRACING configurations")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
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

Reviewed-by: Pankaj Gupta <pankaj.gupta@ionos.com>
