Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CF33D956
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhCPQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhCPQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:25:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C45C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:25:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 20so787258lfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPPV6ZX3Tdhvd5ax8oWrAMyN2NntSRwXfaI6WubILUM=;
        b=GqzIDfmCJYvYrFRGXeic57AzgBH3b1U4AAYEYp2J5pjfw4f/EnP9cLB/T6t1r6TAVg
         tMrVgaaocuUTM4D5JtLmSuQIu2yoT7UwXVom1It5Gr99hKftdLRf8bFHTTW90fpDcSxG
         LAklID4UlfQ5039uo09+40JkCw6EmElu4y5DRj8kxbylRlUp4Q2u5Vdg5DPlB9Pd0Bi2
         T4/d+1t2uvMESJRFgocJF9lvTDwHRjPJUtXR2rDn4rU3r5/Gp0EtxNgynOSacujSpjVU
         vmQw90Z074wG2SsY7t61SI+FYrKEojLMY+5Ts4h8dkCyGw/ZjTFaDaYPYDf/Dcb5Mjhn
         wp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPPV6ZX3Tdhvd5ax8oWrAMyN2NntSRwXfaI6WubILUM=;
        b=meRNbZqXUVyf6d3Cl3Yv/tyrg1A9kUesNeoDz/LI2xN975MfgszYfvlMcdJaldo/yt
         NffdUu2gL79+7UgavhT5eJc6oTVQ3dnB5oWDjc1VRnxbWZd4hubiPTV2M59+xiA1AbX1
         jrJLdUHiAnNaen1+BDForNkhSvXN5bZXzsWsR/T6ouwzLluiDw56T0h/Sfosf2+v4/Ke
         b735fW4HKxLTyHUX2bnpPfEWcvqhRcf/YHWsnfVJ7aVhWZDGolblSRuD8acsKoIQxJ+J
         0f2brE4Zt16g+ZxhKLn4p4Rq0DzIjaWDPb/BqbllTaKOac5X/AN2qrGm6zAXEy2HtKRW
         7vbQ==
X-Gm-Message-State: AOAM531XX1+hBE53/HxRkEJGulGU0CYPz+vjxBtS+lN2F/JkihiMaY5X
        mN/+nHcQkcKFESUxNcBrO36LN8oqqth4OUVaO9EcfQ==
X-Google-Smtp-Source: ABdhPJwQax98b9r+LloLeVzpURQWBJz/Z6VclirjaaFs0GEYtgmAXB7YpLkqvIrfK/L8srjer8T+p/MPbsW3QvkKVXk=
X-Received: by 2002:a19:f50e:: with SMTP id j14mr11828246lfb.299.1615911930635;
 Tue, 16 Mar 2021 09:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210316153655.500806-1-schatzberg.dan@gmail.com> <20210316153655.500806-4-schatzberg.dan@gmail.com>
In-Reply-To: <20210316153655.500806-4-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Mar 2021 09:25:18 -0700
Message-ID: <CALvZod7tDf3vvspJmS551GkiNbSdCH9VWNgWMesmUi2Q3NkgKA@mail.gmail.com>
Subject: Re: [PATCH 3/3] loop: Charge i/o to mem and blk cg
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 8:37 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
[...]
>
>  /* Support for loadable transfer modules */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c04d39a7967..fd5dd961d01f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1187,6 +1187,17 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>         return NULL;
>  }
>
> +static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> +{
> +       return NULL;
> +}

The above function has been removed.
