Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE334FFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhCaLna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbhCaLn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:43:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72D9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:43:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l1so7753951plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGpodPHkfXLm7iN56tDwGRyDh5EuD8H1YpMxQufPMD0=;
        b=rwKHgWGBF7LbXnXNy5oGtdkj7nZFlz59noFuMNooFY6kaShHxbzRMz2I7d5nGgL7/t
         +ok1CQz/P9V4NcwZTV2I0zxbXSPqbmClTwg/N6NxPY284O20IoD6Z14MbEqsJBz9AdNY
         sjAmyPj74zOc/MnKuHRJS1kkUxVPpGUyhANWVh2yPxPTsW1uNnlblhzlrnN6pCrjWjSW
         IBe48QfLRzk3/tqGPuo0GP3N63V3cnkBIG7dd0nll8vo3JVEl7KOi6ueOuAFcw+0L71G
         vezVPvBBidgrSFC5btdWIO8bQk8h0Rkgcb0BZKA/blokIIYpu1h8vSipqhLmUXsk96rC
         Ibfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGpodPHkfXLm7iN56tDwGRyDh5EuD8H1YpMxQufPMD0=;
        b=ZP/URStKjCxpdL1z5rl2uhTdAAT8/GBsk5GCGS6AjBO8nkRLnL5RG1Ldm3uENdciWp
         eAHQHgZI/OP9U8SQIUA7jormBGvVbxsKRLQHRKeT1VLrii/QKpSVWoOqNJeS8DQzwlEX
         3FzNziYXDFtCoCGiO1O/UXhEWv2Ji/2NALHd52zN2rhNe0jKxaR9WFcjKtVIrOqItuQC
         IJoefGhj3iz01P4XrCiLWqrN2YvgylzHQwcE8YEMrtyLOVtyVzBjXfMm7yhLkJpjfUKQ
         6SSyvM5i2GgpHFC5sxBiV2KE6MigeWkKcaOUpcJ0RaklQU9yaU4l6x/gxoUmr2K2tkWi
         /kmA==
X-Gm-Message-State: AOAM533jQYhAct2hKcYaIDw9/7r8zGUp+u4n0As7Ui9/JYnf08bux+iV
        EqWJ3Hi1tJitTIlwJKTqLPSp8SGUIWTIUpTdQphxswWD+v1R1Q==
X-Google-Smtp-Source: ABdhPJyQeEccOchdfuIdOfAs7vnS1u5W66NAQF5XOs+4FxaBFfEy50turP6fbzyVPqbmyOQiVacohw7vfOhJFSVtnrU=
X-Received: by 2002:a17:902:da91:b029:e5:e7cf:d737 with SMTP id
 j17-20020a170902da91b02900e5e7cfd737mr2747859plx.24.1617191005204; Wed, 31
 Mar 2021 04:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210329205249.6b557510@canb.auug.org.au> <83263d0d-1f3f-8a3c-8a95-49e0cfa15051@de.ibm.com>
 <4419611b-3282-2197-884c-332025cdada8@de.ibm.com> <CAMZfGtUaTdmpcw1dr_rWQZTz3UTh9ZFavr0WBSa_obENPasgFw@mail.gmail.com>
 <7c27fc2e-5cea-5a17-6e30-8ae1cb291274@de.ibm.com> <CAMZfGtV9w24cJAwYsQuhvVpdLiYssjdfwfXApNK51zacr31c3w@mail.gmail.com>
 <179f84ad-7b98-4bc5-f895-c19faabbb311@de.ibm.com>
In-Reply-To: <179f84ad-7b98-4bc5-f895-c19faabbb311@de.ibm.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 31 Mar 2021 19:42:48 +0800
Message-ID: <CAMZfGtX0MvsXCE2DgBo=jsmTGWa5wcS40vaOJSBZ1U6Wnkx8Fw@mail.gmail.com>
Subject: Re: [External] RE: kernel warning percpu ref in obj_cgroup_release
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 2:22 PM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 30.03.21 18:25, Muchun Song wrote:
> > On Tue, Mar 30, 2021 at 11:10 PM Christian Borntraeger
> > <borntraeger@de.ibm.com> wrote:
> >>
> >>
> >> On 30.03.21 15:49, Muchun Song wrote:
> >>> On Tue, Mar 30, 2021 at 9:27 PM Christian Borntraeger
> >>> <borntraeger@de.ibm.com> wrote:
> >>>>
> >>>> So bisect shows this for belows warning:
> >>>
> >>> Thanks for your effort on this. Can you share your config?
> >>
> >> attached (but its s390x) for next-20210330
> >
> > Thanks. Can you apply the following patch and help me test?
> > Very Thanks.
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 7fdc92e1983e..579408e4d46f 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -793,6 +793,12 @@ static inline void obj_cgroup_get(struct obj_cgroup *objcg)
> >          percpu_ref_get(&objcg->refcnt);
> >   }
> >
> > +static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
> > +                                      unsigned long nr)
> > +{
> > +       percpu_ref_get_many(&objcg->refcnt, nr);
> > +}
> > +
> >   static inline void obj_cgroup_put(struct obj_cgroup *objcg)
> >   {
> >          percpu_ref_put(&objcg->refcnt);
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c0b83a396299..1634dba1044c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3133,7 +3133,10 @@ void split_page_memcg(struct page *head, unsigned int nr)
> >
> >          for (i = 1; i < nr; i++)
> >                  head[i].memcg_data = head->memcg_data;
> > -       css_get_many(&memcg->css, nr - 1);
> > +       if (PageMemcgKmem(head))
> > +               obj_cgroup_get_many(__page_objcg(head), nr - 1);
> > +       else
> > +               css_get_many(&memcg->css, nr - 1);
> >   }
> >
> >   #ifdef CONFIG_MEMCG_SWAP
> >
>
> This one seems to do the trick, I can no longer see the warning.

Thanks for your testing. I will send a fix patch.
