Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7374D3501BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhCaNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbhCaNyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:54:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54E8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 06:54:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n138so29301902lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M20/VCOtGm0wXrWdqbwDrpizR1Dl5NS3bwcYm8AfBw0=;
        b=Dmb/bo8n0TvTwTqvv+NggtHFmU26ULnHXF6bdDCQRkL2HMOZFaMk0XDclLGuOskS3G
         bWuXcCDsxFEmGFCl9Ix25HuGDrMNnXhnx/aWsFP90/pLWJHc4WztjoR0AlvunXVl/6br
         af6aRI7QNlTFBwVsXe+ciqvHgLSbF/EpOS2ccMrGPWnyoXFqeV0xlbGCMQOflfSJjHlN
         Qo2whdzp/tFx7d6mNS8YjpoQsFygLyPVnVMzsTLDPW+JDlZph+c3aQiEWdPIV9xiFAbj
         kppxBPPL7gUb0P/ylW9t80Ll3WstxyPO63vU4FUMD4gEfblM7W8IiLOIcclPypMylhzR
         uJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M20/VCOtGm0wXrWdqbwDrpizR1Dl5NS3bwcYm8AfBw0=;
        b=JCZCSTLHVCW4HnlKcVx5HZNxHouw3wgn1M6MFk3Z1LaKnAftAOZ4OE5vGbzcGv4dEU
         HHaGKKwq++WFyBa+4yB+KPJZWY2kFBOGz4mxXYlPPLHDYMx3IwMUMNI5vXAdkw6PurD3
         3xW13rAeXE4iek4P13sC+nicpgQvfLPgBx4fSh0fNUtY+3IWl4dOmNrTQMKFeZODhkWK
         H5htqp2SpdwhFAM9nhN6LaShmJ4jPWu9eG8x14gf+dP06g6aJ1MYCXD6tG0mXILcdkMc
         7rB00aOtAWmwfPLGUE5U8xrehc28M+6ek8OLss14idL6qtSqs8RC9lBkdObooG9BjZd6
         /4lw==
X-Gm-Message-State: AOAM532rHC8J5qy9XQcImaVg1YMWywowIHl4bQfd3ImnTonlMmsxNo18
        gHn0YFA5XGPK+ry/iAyiQ8bHjD8movuKdaS1A9IFGg==
X-Google-Smtp-Source: ABdhPJzeXsNR6T8Lq37UZOq7zWxy4lmIQi5Lp1vf1OSrhYqss+SoiE8HkxZnCwPEf11EZ0RnzRVq60H/hEDpmagnS0k=
X-Received: by 2002:a19:c14a:: with SMTP id r71mr2302682lff.358.1617198860128;
 Wed, 31 Mar 2021 06:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2103301640240.2584@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2103301640240.2584@eggly.anvils>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 31 Mar 2021 06:54:08 -0700
Message-ID: <CALvZod7PQ3=1nDUKVo33o5GGh-feGNM2LyekSys-U2-kOYbrTA@mail.gmail.com>
Subject: Re: [PATCH mmotm] mm: vmscan: fix shrinker_rwsem in free_shrinker_info()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 4:44 PM Hugh Dickins <hughd@google.com> wrote:
>
> Lockdep warns mm/vmscan.c: suspicious rcu_dereference_protected() usage!
> when free_shrinker_info() is called from mem_cgroup_css_free(): there it
> is called with no locking, whereas alloc_shrinker_info() calls it with
> down_write of shrinker_rwsem - which seems appropriate.  Rearrange that
> so free_shrinker_info() can manage the shrinker_rwsem for itself.
>
> Link: https://lkml.kernel.org/r/20210317140615.GB28839@xsang-OptiPlex-9020
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
> Sorry, I've made no attempt to work out precisely where in the series
> the locking went missing, nor tried to fit this in as a fix on top of
> mm-vmscan-add-shrinker_info_protected-helper.patch
> which Oliver reported (and which you notated in mmotm's "series" file).
> This patch just adds the fix to the end of the series, after
> mm-vmscan-shrink-deferred-objects-proportional-to-priority.patch

The patch "mm: vmscan: add shrinker_info_protected() helper" replaces
rcu_dereference_protected(shrinker_info, true) with
rcu_dereference_protected(shrinker_info,
lockdep_is_held(&shrinker_rwsem)).

I think we don't really need shrinker_rwsem in free_shrinker_info()
which is called from css_free(). The bits of the map have already been
'reparented' in css_offline. I think we can remove
lockdep_is_held(&shrinker_rwsem) for free_shrinker_info().

>
>  mm/vmscan.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> --- mmotm/mm/vmscan.c   2021-03-28 17:26:54.935553064 -0700
> +++ linux/mm/vmscan.c   2021-03-30 15:55:13.374459559 -0700
> @@ -249,18 +249,20 @@ void free_shrinker_info(struct mem_cgrou
>         struct shrinker_info *info;
>         int nid;
>
> +       down_write(&shrinker_rwsem);
>         for_each_node(nid) {
>                 pn = memcg->nodeinfo[nid];
>                 info = shrinker_info_protected(memcg, nid);
>                 kvfree(info);
>                 rcu_assign_pointer(pn->shrinker_info, NULL);
>         }
> +       up_write(&shrinker_rwsem);
>  }
>
>  int alloc_shrinker_info(struct mem_cgroup *memcg)
>  {
>         struct shrinker_info *info;
> -       int nid, size, ret = 0;
> +       int nid, size;
>         int map_size, defer_size = 0;
>
>         down_write(&shrinker_rwsem);
> @@ -270,9 +272,9 @@ int alloc_shrinker_info(struct mem_cgrou
>         for_each_node(nid) {
>                 info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
>                 if (!info) {
> +                       up_write(&shrinker_rwsem);
>                         free_shrinker_info(memcg);
> -                       ret = -ENOMEM;
> -                       break;
> +                       return -ENOMEM;
>                 }
>                 info->nr_deferred = (atomic_long_t *)(info + 1);
>                 info->map = (void *)info->nr_deferred + defer_size;
> @@ -280,7 +282,7 @@ int alloc_shrinker_info(struct mem_cgrou
>         }
>         up_write(&shrinker_rwsem);
>
> -       return ret;
> +       return 0;
>  }
>
>  static inline bool need_expand(int nr_max)
