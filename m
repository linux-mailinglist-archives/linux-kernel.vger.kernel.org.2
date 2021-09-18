Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C117641066A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhIRM3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhIRM3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:29:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25553C061574;
        Sat, 18 Sep 2021 05:28:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j13so40571106edv.13;
        Sat, 18 Sep 2021 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrYqs+eOtoYPesdEkD8TstkgC0IF6+9dGmCfJRa5Xx8=;
        b=E3S7OC1EZ7fg/0rW6erGdPW7TNXDGALKz6CTlGxV5GI6q735+6rkX9kZVPIzoF5wz/
         +y5jtAW6/yp1pOuDkf51tgi8KkPi+cA6dPLxnyb+pf4XhfWraYn1c0Uow8+xgpQ5ipeI
         aEB6jmh+j9I8qDuq+F8YRM1ib5TzogvZ++zckzgUBT/Pcbm5omtR78O1mn2D8Oxgb94z
         dqDr2XhOlyrYGgG+Nq+0BvmrBUbC0lcS/KNp8shaNVqM8Vl8uD0+mAnk1bBE2quA/7D4
         taDvx6y+FVl0Ao6D7xokb+OIxTmHf/qJ+sRyQrU3E3SS4WfcVCsEB3CD1xiQkHb/HtDy
         kvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrYqs+eOtoYPesdEkD8TstkgC0IF6+9dGmCfJRa5Xx8=;
        b=d1bBqMfYwfehCjo2gXdIFIbm89k7VWb/Lyos7lyLNvBd3NLZ0QYyXZbd1MIL/02kCx
         pLOZccNK0fa4lugBsmdGe0hgr6+VPnRpIkOgFeECdOSLIqETDD4HrZqFe5ND9MIguoa6
         1KYQmXrHG8vudDz9HPrZ+430X/Xn1IPNy73rSTgKEDQwdEjNMcL8uJGhezQdTz5WiB+V
         OJSLW2SRcoA0nTV9WWheVLSgKNkhWNgw0ILpV1Qi1Lxudzeq3bjFWQmUDw/N6Zurah7/
         qVPsV/D7Wu1gBVU37mSZuFy8Po7k64eGajS4sOJHvuFlnlDMqBC6lIDtIVLLxUxWYdaB
         F2OQ==
X-Gm-Message-State: AOAM530ujFPcAwwPdQBWTmmOv2lznUOc1pdeoZk3Rfqw+tENbM2x6DPX
        9HJ9YZeSKm6ILwK9vIzl7JdxOeIy9Va+6aHFpLE=
X-Google-Smtp-Source: ABdhPJzBxykrsdId0lHveiZxzZucanHzc/79FFhMeayIf5rnAmejyo8If6A1BHeL647JiV9w5JP6lM7T6E+j3O1Yeow=
X-Received: by 2002:a17:907:75ed:: with SMTP id jz13mr17553689ejc.506.1631968090705;
 Sat, 18 Sep 2021 05:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com>
 <20210917034815.80264-3-songmuchun@bytedance.com> <CAGsJ_4ymutSL-pbWA_TykJ2vE8ZKc+JGn+w_WWy2j7Mn-q+ebA@mail.gmail.com>
 <CAMZfGtWWvDcz+JZtj0k_YZsD4j42cgaoWOCd1o8jArizqBYKgQ@mail.gmail.com>
 <CAGsJ_4zZfemMA9=85sgASacPqaT4OnV7RaYUwtQef=BzEfqW9w@mail.gmail.com> <CAMZfGtV32Wya=rNw29S1suM8qGzHvYhaqvGeFEvsegy5Oxas0A@mail.gmail.com>
In-Reply-To: <CAMZfGtV32Wya=rNw29S1suM8qGzHvYhaqvGeFEvsegy5Oxas0A@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 19 Sep 2021 00:27:59 +1200
Message-ID: <CAGsJ_4xuK6hpCEca4kM5O7xOSBpt_GJOY3NqSFM0LupN8NxRLg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/4] mm: hugetlb: replace hugetlb_free_vmemmap_enabled
 with a static_key
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 11:48 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Sat, Sep 18, 2021 at 7:15 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Sat, Sep 18, 2021 at 10:31 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > On Sat, Sep 18, 2021 at 12:55 PM Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > On Sat, Sep 18, 2021 at 12:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > >
> > > > > The page_head_if_fake() is used throughout memory management and the
> > > > > conditional check requires checking a global variable, although the
> > > > > overhead of this check may be small, it increases when the memory
> > > > > cache comes under pressure. Also, the global variable will not be
> > > > > modified after system boot, so it is very appropriate to use static
> > > > > key machanism.
> > > > >
> > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > ---
> > > > >  include/linux/hugetlb.h    |  6 +++++-
> > > > >  include/linux/page-flags.h |  6 ++++--
> > > > >  mm/hugetlb_vmemmap.c       | 10 +++++-----
> > > > >  3 files changed, 14 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > > > index f7ca1a3870ea..ee3ddf3d12cf 100644
> > > > > --- a/include/linux/hugetlb.h
> > > > > +++ b/include/linux/hugetlb.h
> > > > > @@ -1057,7 +1057,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
> > > > >  #endif /* CONFIG_HUGETLB_PAGE */
> > > > >
> > > > >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > > > > -extern bool hugetlb_free_vmemmap_enabled;
> > > > > +DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > > > > +                        hugetlb_free_vmemmap_enabled_key);
> > > > > +#define hugetlb_free_vmemmap_enabled                                    \
> > > > > +       static_key_enabled(&hugetlb_free_vmemmap_enabled_key)
> > > > > +
> > > > >  #else
> > > > >  #define hugetlb_free_vmemmap_enabled   false
> > > > >  #endif
> > > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > > index 7b1a918ebd43..d68d2cf30d76 100644
> > > > > --- a/include/linux/page-flags.h
> > > > > +++ b/include/linux/page-flags.h
> > > > > @@ -185,7 +185,8 @@ enum pageflags {
> > > > >  #ifndef __GENERATING_BOUNDS_H
> > > > >
> > > > >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > > > > -extern bool hugetlb_free_vmemmap_enabled;
> > > > > +DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > > > > +                        hugetlb_free_vmemmap_enabled_key);
> > > > >
> > > > >  /*
> > > > >   * If the feature of freeing some vmemmap pages associated with each HugeTLB
> > > > > @@ -204,7 +205,8 @@ extern bool hugetlb_free_vmemmap_enabled;
> > > > >   */
> > > > >  static __always_inline const struct page *page_head_if_fake(const struct page *page)
> > > > >  {
> > > > > -       if (!hugetlb_free_vmemmap_enabled)
> > > > > +       if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > > > > +                                &hugetlb_free_vmemmap_enabled_key))
> > > >
> > > > A question bothering me is that we still have hugetlb_free_vmemmap_enabled
> > > > defined as static_key_enabled(&hugetlb_free_vmemmap_enabled_key).
> > > > but here you are using static_branch_maybe() with the CONFIG and refer the key
> > > > directly.
> > > > Do we only need one of them? Or something is wrong?
> > > >
> > >
> > > Yeah, we only need one. But my consideration is that we
> > > use static_branch_maybe() for performance sensitive places.
> > > So I do not change hugetlb_free_vmemmap_enabled
> > > to static_branch_maybe(), this can reduce some codes
> > > that need to be updated when the static key is enabled.
> > > Actually, the user of hugetlb_free_vmemmap_enabled
> > > is not performance sensitive.
> >
> > not quite sure if an unified inline API will be better, e.g.
> >
> > #ifdef CONFIG_SCHED_SMT
> > extern struct static_key_false sched_smt_present;
> >
> > static __always_inline bool sched_smt_active(void)
> > {
> >         return static_branch_likely(&sched_smt_present);
> > }
> > #else
> > static inline bool sched_smt_active(void) { return false; }
> > #endif
>
> Alright, I can change hugetlb_free_vmemmap_enabled to
> an inline function.
>
> >
> > but in your case, CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > is always true in your page_head_if_fake(). Why do we check it
> > again?
>
> That is CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
> not CONFIG_HUGETLB_PAGE_FREE_VMEMMAP.

oops, sorry for missing that.

>
> Thanks
