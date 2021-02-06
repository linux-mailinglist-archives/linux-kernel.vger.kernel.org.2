Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09EC311B60
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 06:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhBFFLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 00:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhBFEff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 23:35:35 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02F8C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 20:34:52 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id b145so5685436pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 20:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfU8CxWnfJGtSfIWBoz8gcUKxsmxSB28QltCEf7Seho=;
        b=FY0YcpkTvfMDL0uzj13pWIJ446sR279zz/b0pKxyDlsQhUfw4es4Vhs5+hc++o2z56
         pWd/RcPOHFkrY+CZXxwt2hbW+IiNgQsOsM852AYmZDx7oEU+KUW2wsudTvsH1iqWsaQS
         xqmkuNNbeuD5F2hbeIshyo5ASOOk2USdodJnuN6XisfqRqblFRBG3pmC/k1idVu6iGNG
         5C7TszOfXt5updsf02pFqo+WQfBE0i+fhXO32Q7yMgpSihcLgavAc2oBhSAp7iDMjWJw
         jpiGyXOJFBAaiRhmfihsVWud6HHW7H0LzE0jbWqh62ZHKVMzl0HNN1kGN5A+bJmo3X3s
         PjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfU8CxWnfJGtSfIWBoz8gcUKxsmxSB28QltCEf7Seho=;
        b=LfCE+m+0lqv9U8mahSgBTnokjC7jVVxuxcSm9GQMfwpk1SWVcCZS2sPMJ+a6jfaf0/
         +FSq80lsGGpl8KPSP7CPdejm/APAT4N4rHyiu+kMEZKiccia0EdzariaRmL0vQC0FOeA
         8hYwPb+pjI+qLgsM6WE02Y5W244fYMzuce5NV5BqsantUV2H0uMVYPPeRLfrMxVgGpD8
         5RLAeDKntJssGjYCiYD7Li+W6soWBYIfwI7nMp2K4s24KUYsnO+JSjuZaJfMtxvvb77l
         EO0ZwBC2mryC11QCONifIeLQ88fQ4VDPGEEuShq23didiyM08dTAkMAK8aQc9HrIRH74
         Tv2w==
X-Gm-Message-State: AOAM532V0ZzAmF5+R9UrtOmtWblTXM0YbSZOIytypc6qsgrOPVGMYZav
        pMQDHhZljczxNBV+7Zle5oKzlil1DdZbzDrSgA3vdw==
X-Google-Smtp-Source: ABdhPJyqtQIhxPw6a1Uqk6ljaaRtA7+gtwIMZCVo7NTDNLImSJ0FaLLoipyla11ctjOPVdEMgXGBLm0h/Q+6uH0lwnw=
X-Received: by 2002:a62:1b93:0:b029:1cb:4985:623b with SMTP id
 b141-20020a621b930000b02901cb4985623bmr7870533pfb.59.1612586092333; Fri, 05
 Feb 2021 20:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20210205062719.74431-1-songmuchun@bytedance.com>
 <YB0DnAlCaQza4Uf9@dhcp22.suse.cz> <CAMZfGtVhBrwgkJVwiah6eDsppSf8fYp+uZ=tZmHBLDFeTmQX3w@mail.gmail.com>
 <YB0euLiMU+T/9bMK@dhcp22.suse.cz> <YB2LTIeTPN72Xrxj@cmpxchg.org>
In-Reply-To: <YB2LTIeTPN72Xrxj@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 6 Feb 2021 12:34:15 +0800
Message-ID: <CAMZfGtVyn75kyMe+6DJ2rZaycfgomWyDYH+5Pk-Fesqs+bb3+g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: remove rcu_read_lock from get_mem_cgroup_from_page
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 6, 2021 at 2:15 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Feb 05, 2021 at 11:32:24AM +0100, Michal Hocko wrote:
> > On Fri 05-02-21 17:14:30, Muchun Song wrote:
> > > On Fri, Feb 5, 2021 at 4:36 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 05-02-21 14:27:19, Muchun Song wrote:
> > > > > The get_mem_cgroup_from_page() is called under page lock, so the page
> > > > > memcg cannot be changed under us.
> > > >
> > > > Where is the page lock enforced?
> > >
> > > Because it is called from alloc_page_buffers(). This path is under
> > > page lock.
> >
> > I do not see any page lock enforecement there. There is not even a
> > comment requiring that. Can we grow more users where this is not the
> > case? There is no actual relation between alloc_page_buffers and
> > get_mem_cgroup_from_page except that the former is the only _current_
> > existing user. I would be careful to dictate locking based solely on
> > that.
>
> Since alloc_page_buffers() holds the page lock throughout the entire
> time it uses the memcg, there is no actual reason for it to use RCU or
> even acquire an additional reference on the css. We know it's pinned,
> the charge pins it, and the page lock pins the charge. It can neither
> move to a different cgroup nor be uncharged.

Thanks for your patient explanation.

>
> So what do you say we switch alloc_page_buffers() to page_memcg()?

It's better than mine.

>
> And because that removes the last user of get_mem_cgroup_from_page(),
> we can kill it off and worry about a good interface once a consumer
> materializes for it.
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 96c7604f69b3..12a10f461b81 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -847,7 +847,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
>         if (retry)
>                 gfp |= __GFP_NOFAIL;
>
> -       memcg = get_mem_cgroup_from_page(page);
> +       memcg = page_memcg(page);
>         old_memcg = set_active_memcg(memcg);
>
>         head = NULL;
> @@ -868,7 +868,6 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
>         }
>  out:
>         set_active_memcg(old_memcg);
> -       mem_cgroup_put(memcg);
>         return head;
>  /*
>   * In case anything failed, we just free everything we got.
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a8c7a0ccc759..a44b2d51aecc 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -687,8 +687,6 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
>
>  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
>
> -struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
> -
>  struct lruvec *lock_page_lruvec(struct page *page);
>  struct lruvec *lock_page_lruvec_irq(struct page *page);
>  struct lruvec *lock_page_lruvec_irqsave(struct page *page,
> @@ -1169,11 +1167,6 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>         return NULL;
>  }
>
> -static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> -{
> -       return NULL;
> -}
> -
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 490357945f2c..ff52550d2f65 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1048,29 +1048,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL(get_mem_cgroup_from_mm);
>
> -/**
> - * get_mem_cgroup_from_page: Obtain a reference on given page's memcg.
> - * @page: page from which memcg should be extracted.
> - *
> - * Obtain a reference on page->memcg and returns it if successful. Otherwise
> - * root_mem_cgroup is returned.
> - */
> -struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> -{
> -       struct mem_cgroup *memcg = page_memcg(page);
> -
> -       if (mem_cgroup_disabled())
> -               return NULL;
> -
> -       rcu_read_lock();
> -       /* Page should not get uncharged and freed memcg under us. */
> -       if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -               memcg = root_mem_cgroup;
> -       rcu_read_unlock();
> -       return memcg;
> -}
> -EXPORT_SYMBOL(get_mem_cgroup_from_page);
> -
>  static __always_inline struct mem_cgroup *active_memcg(void)
>  {
>         if (in_interrupt())
