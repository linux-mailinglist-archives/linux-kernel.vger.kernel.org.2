Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9AF3C5FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhGLP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGLP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:58:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40FC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:55:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y38so29752402ybi.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+R+buwilcZJPqYitjTRHvClHpz5qW+7Zf9f3EMnGV/A=;
        b=hWvlM8rao4P3XGZzXkW/CYN7nJSLsBhLSfupdLB5AO4qrn9z8yU7lpr8/r4p/673D6
         /84v/MB7BpZbegwEzPtqiOm9hiaTI/lfnQbByU0WqKSQ/gpJF4rM3bt2GRnE3GshSpus
         T1tCCsMBfLcsieo7Rq4IYZxBCPFqZiXITsFIAS9L9EA9z8mA+JScy9XTDpeJ8m67VRyT
         6tLWTeoTNFClUrp/K1/7BgZJSU5pd47rmVOxKwmSvSMeQkalxfJ6AfI130ptNl2BZIfB
         VjN5D7QfyGWhr/Etgc6eqMMtpZNDWZzhkIZ8IfsEOnEFdKSDUOf0UQaOBmzwiMQDqTzO
         jzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+R+buwilcZJPqYitjTRHvClHpz5qW+7Zf9f3EMnGV/A=;
        b=SSH+JHsYnT1AValMEGg/tyhEHVI2iOWUBw0Vo/tzEbzXMoRb3DkAhl3ytJVl2u7ZJZ
         A8cV66yhYp5tbfscihRHT/CYjOku7ckXHdkhvqVo3257vXJPfikHVua09VkHFTqr1nBH
         wl3ZXafhlYF4fAa8W50zFYrmUiLWFwO5OsXzAAg+S+av+eKTryTKQLT9Hee3LFxPr+Sk
         RG425swenJxlHrzqt+6SQwxaJ7VsH1IKp33yUZfmONZ57zqMpfm9BV9wGtWGZYlHPv9o
         wPSqz/5OVGP3OzqkOtWvTJR726D3p4AB+Yl/0ZimgLCI44NYEPWPsSL6P8o+Qbb5uyDK
         rlPA==
X-Gm-Message-State: AOAM532A1wkXdeXBT2RyGy5GbWmeKtDhA9apErPG2kF2eLEtgC84EO6M
        un1zCsxolmT7Ff/vVwV79//Q9Ny+0o/bpaOMxodGKg==
X-Google-Smtp-Source: ABdhPJwYCwwkIxqyAnX/UFeRx6Wa0DRpesQ2VcFQV1sU270R6xtrFjabQwm5pRt/7PtBPpTZjZNbnupdWJEbiVrHeqg=
X-Received: by 2002:a25:4102:: with SMTP id o2mr62993247yba.23.1626105311117;
 Mon, 12 Jul 2021 08:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com> <YOvrKzvG+nHJpV+V@dhcp22.suse.cz>
In-Reply-To: <YOvrKzvG+nHJpV+V@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 12 Jul 2021 08:55:00 -0700
Message-ID: <CAJuCfpEWUqE6iuMC02Qac3TBLx7Zy12y3iSwr6Tsvcd-tAMOrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm, memcg: add mem_cgroup_disabled checks in
 vmpressure and swap-related functions
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        vdavydov.dev@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        richard.weiyang@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, apopple@nvidia.com,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:11 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 09-07-21 17:36:24, Suren Baghdasaryan wrote:
> > Add mem_cgroup_disabled check in vmpressure, mem_cgroup_uncharge_swap a=
nd
> > cgroup_throttle_swaprate functions. This minimizes the memcg overhead i=
n
> > the pagefault and exit_mmap paths when memcgs are disabled using
> > cgroup_disable=3Dmemory command-line option.
> > This change results in ~2.1% overhead reduction when running PFT test
>
> What is PFT test?

Christoph Lamenter=E2=80=99s pagefault tool
(https://lkml.org/lkml/2006/8/29/294). I'll add the link in the
description for clarity.

>
> > comparing {CONFIG_MEMCG=3Dn, CONFIG_MEMCG_SWAP=3Dn} against {CONFIG_MEM=
CG=3Dy,
> > CONFIG_MEMCG_SWAP=3Dy, cgroup_disable=3Dmemory} configuration on an 8-c=
ore
> > ARM64 Android device.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

>
> Thanks!
>
> > ---
> >  mm/memcontrol.c | 3 +++
> >  mm/swapfile.c   | 3 +++
> >  mm/vmpressure.c | 7 ++++++-
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index ae1f5d0cb581..a228cd51c4bd 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7305,6 +7305,9 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, =
unsigned int nr_pages)
> >       struct mem_cgroup *memcg;
> >       unsigned short id;
> >
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +
> >       id =3D swap_cgroup_record(entry, 0, nr_pages);
> >       rcu_read_lock();
> >       memcg =3D mem_cgroup_from_id(id);
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 1e07d1c776f2..707fa0481bb4 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3778,6 +3778,9 @@ void cgroup_throttle_swaprate(struct page *page, =
gfp_t gfp_mask)
> >       struct swap_info_struct *si, *next;
> >       int nid =3D page_to_nid(page);
> >
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +
> >       if (!(gfp_mask & __GFP_IO))
> >               return;
> >
> > diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> > index d69019fc3789..9b172561fded 100644
> > --- a/mm/vmpressure.c
> > +++ b/mm/vmpressure.c
> > @@ -240,7 +240,12 @@ static void vmpressure_work_fn(struct work_struct =
*work)
> >  void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
> >               unsigned long scanned, unsigned long reclaimed)
> >  {
> > -     struct vmpressure *vmpr =3D memcg_to_vmpressure(memcg);
> > +     struct vmpressure *vmpr;
> > +
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +
> > +     vmpr =3D memcg_to_vmpressure(memcg);
> >
> >       /*
> >        * Here we only want to account pressure that userland is able to
> > --
> > 2.32.0.93.g670b81a890-goog
>
> --
> Michal Hocko
> SUSE Labs
