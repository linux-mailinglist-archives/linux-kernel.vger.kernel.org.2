Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752FD3EF282
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhHQTLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhHQTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:11:04 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:10:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n7so594256ljq.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iykb3zVshE4eA6E5ehs/j8Ti0hcMXuAQMSGt4bHNST4=;
        b=P6s2laW+/ySM+LSMlI6J0A+C6LGd7jgwKCV5z/iMsS7y6l+jLs8+qjEGr/Z8ax6QAh
         Wix/NJ09rEJYwkRlnEQ+HCSlhqX/1kNgInBda0vwE049aVDpPX/8tEaleWsaQKdJ8KbA
         VSQeo28B0Ab1hdE0RFxEDc8eOLFlglPnYgmTK8leE5Hd5NFyDmA9erUHNxlRsL58gOze
         KlDAzXxaeRvelYps59sacVX3uaz5Ads0lKSaa6TG79Bmf8j3Wv+b+idvwDEnBKpGvuPA
         8H4XQBuneBsrBm16zIePSYHCISi3yewlxpltvPc6d/1ywkkYxH6EmN63h5wt8BE5LRAr
         gi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iykb3zVshE4eA6E5ehs/j8Ti0hcMXuAQMSGt4bHNST4=;
        b=rygipe241U1dczikK7kFDaQQ5B7Ye2gE4nsHgIrSS7e2XsDT7IhRPneF5LgEJoc+GE
         ukrVxJGwz1kgaRI35P5gYgMhWDdPEPwAh2GoVGeYXEfnG3zo/p1kYbyTUEFrxnH9ed1U
         V3es1nv81EPH1z4AQ0Db6IbZotfm0HQmHeKRvge+3EwaR2s2Oh1eDwnOhzUG7oE53cZD
         gCBC16/46LGdZCmci1KTaJX+6/sKDB+W6OR/m6k1rQIdCI1pXfR76WRqTHZV/gINh4f/
         Oo12CZeWyopHiC/eRshDLMMnEVoikkU7ARJouYbgXhVqgUpIF03Ug43NoosPbReLDloF
         +6zg==
X-Gm-Message-State: AOAM531HSih6D1oTQNnBKNOMYVMWw8a0X2A+QT1+1/hKvD7RMTAoa5Yh
        loH6GJ7aDt3pm1jyiExoPna3fQUja07ielbfbacmHw==
X-Google-Smtp-Source: ABdhPJyNgt4XbUwgdloQdNksckqOArZjCflImGwdW9tidae85j9iEPkeav+6SjVzRCSzNylk7r+ETTaOZNd1uNM9ZE8=
X-Received: by 2002:a05:651c:1248:: with SMTP id h8mr2590013ljh.160.1629227427941;
 Tue, 17 Aug 2021 12:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210817180506.220056-1-hannes@cmpxchg.org>
In-Reply-To: <20210817180506.220056-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 17 Aug 2021 12:10:16 -0700
Message-ID: <CALvZod7097PHnXoOUZzPpmkASKpL3rV+2UJ+zp-NCdkpVoFTWg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:03 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> We've noticed occasional OOM killing when memory.low settings are in
> effect for cgroups. This is unexpected and undesirable as memory.low
> is supposed to express non-OOMing memory priorities between cgroups.
>
> The reason for this is proportional memory.low reclaim. When cgroups
> are below their memory.low threshold, reclaim passes them over in the
> first round, and then retries if it couldn't find pages anywhere else.
> But when cgroups are slighly above their memory.low setting, page scan

*slightly

> force is scaled down and diminished in proportion to the overage, to
> the point where it can cause reclaim to fail as well - only in that
> case we currently don't retry, and instead trigger OOM.
>
> To fix this, hook proportional reclaim into the same retry logic we
> have in place for when cgroups are skipped entirely. This way if
> reclaim fails and some cgroups were scanned with dimished pressure,

*diminished

> we'll try another full-force cycle before giving up and OOMing.
>
> Reported-by: Leon Yang <lnyng@fb.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Should this be considered for stable?

Reviewed-by: Shakeel Butt <shakeelb@google.com>

[...]
>
>  static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4620df62f0ff..701106e1829c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -100,9 +100,12 @@ struct scan_control {
>         unsigned int may_swap:1;
>
>         /*
> -        * Cgroups are not reclaimed below their configured memory.low,
> -        * unless we threaten to OOM. If any cgroups are skipped due to
> -        * memory.low and nothing was reclaimed, go back for memory.low.
> +        * Cgroup memory below memory.low is protected as long as we
> +        * don't threaten to OOM. If any cgroup is reclaimed at
> +        * reduced force or passed over entirely due to its memory.low
> +        * setting (memcg_low_skipped), and nothing is reclaimed as a
> +        * result, then go back back for one more cycle that reclaims

*back
