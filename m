Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D1351A61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhDASAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbhDARoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:44:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F9C08EC9D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:59:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 11so1534460pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/3a43OgndFhV4YsO1YCBwrGwKsBQWPZaqZIOquPyFI=;
        b=scDCPxoQNlEKV1yrTg85cmjORG9bOVx/N6WlMBywtsg3w+WcwRSrL4VcPcoNjz5wHp
         u+EwUwaBBknJ1u8Co2/8xXNmO8jcJgY2gu33mE7VeockYYpaBX8sO9q21F8Rd+SWnWzp
         lOdUUzxB2BEluRYyy6yBfRfv+c3lz6z98nZghwhBFxjwAS4LbI8n/g30kS7SajIBMPQT
         6t9mjkzBfq4mnWHB4CX9PefShFN38weoOGV34lxOpnQ3Wom3KikeCOpp2sWhIQ+7Xpye
         02TXquVhehHh9ey/Ha930rCG9t6kIRzQEec91JtxEAcy78MX2qTmPSil7Cs11b1U9XLY
         Wetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/3a43OgndFhV4YsO1YCBwrGwKsBQWPZaqZIOquPyFI=;
        b=YG5XunRTAju4LfeKWOqXUNd8kjwv/BJ3zgAWqE3uKLMzp9gmIBy6O0SsKjaYGNqAVX
         jfDq7ESkLY46j+KqcLOXpnqycpn/DN1j+RBKcb3fDbgOuKenxiYEdtsd4G77SlpFk1aN
         fMaNsWFayBKRRmKrgRqzSjLm/SwqutSLmKa2c5MiQSgoY2BbzubEy1uVc17Qmfr7UsE7
         c19O+sPA/PYbZIE/PWQEI71loompZcl9EitjBfOzXjON3gTirw8RoppjCtcwJpkAvVQf
         xR6xJ2l3+9b5epeQJ0+Ux7hfkThPbeyt0p0v5sneqt0AqR5ZeDUu7jbLAd2uHdi4tqCI
         7JLQ==
X-Gm-Message-State: AOAM531Zzq2xGlLwCbFTN4lsCslQnPtlA2ii6iC82mtLNaQ6JppGUdP7
        Vze9GEayhFGN7t03/yrZHieBQJNuyVk1KocgcYlvTOk058vD6zVIYUc=
X-Google-Smtp-Source: ABdhPJwNg+9PInDOEEfsa1PFCuiHDHOXd+WcWYXY+aqhNpMjZtXUSmn6E/wl0B4O5uBWtmG9cpA0Iz54JEhdffJn6O0=
X-Received: by 2002:aa7:9614:0:b029:1fa:e77b:722 with SMTP id
 q20-20020aa796140000b02901fae77b0722mr8004895pfg.2.1617285590462; Thu, 01 Apr
 2021 06:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210401093343.51299-1-songmuchun@bytedance.com> <YGWf1C/gIZgs0AhR@dhcp22.suse.cz>
In-Reply-To: <YGWf1C/gIZgs0AhR@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 1 Apr 2021 21:59:13 +0800
Message-ID: <CAMZfGtX9V898aezb-huMEYU_-NjqfL6HbXeaZr2Q2MUa+VG3qQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] writeback: fix obtain a reference to a
 freeing memcg css
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, axboe@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 6:26 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 01-04-21 17:33:43, Muchun Song wrote:
> > The caller of wb_get_create() should pin the memcg, because
> > wb_get_create() relies on this guarantee. The rcu read lock
> > only can guarantee that the memcg css returned by css_from_id()
> > cannot be released, but the reference of the memcg can be zero.
> > Fix it by holding a reference to the css before calling
> > wb_get_create(). This is not a problem I encountered in the
> > real world. Just the result of a code review.
> >
> > And it is unnecessary to use GFP_ATOMIC, so replace it with
> > GFP_NOIO.
>
> This should go into it's own patch. With more explanation why NOIO is
> required.

OK. Replacing GFP_ATOMIC with NOIO should be a separate
patch. I will remove this in the next version.

>
> > Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> For the css part feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

>
> Even if the css ref count is not really necessary it shouldn't cause any
> harm and it makes the code easier to understand. At least a comment
> explaining why that is not necessary would be required without it

OK. I will add a comment here to explain why we need to hold a
ref.

>
> Thanks!
>
> > ---
> > Changelog in v2:
> >  1. Replace GFP_ATOMIC with GFP_NOIO suggested by Matthew.
> >
> >  fs/fs-writeback.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index e91980f49388..df7f89f8f771 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -501,16 +501,21 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> >       if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
> >               return;
> >
> > -     isw = kzalloc(sizeof(*isw), GFP_ATOMIC);
> > +     isw = kzalloc(sizeof(*isw), GFP_NOIO);
> >       if (!isw)
> >               return;
> >
> >       /* find and pin the new wb */
> >       rcu_read_lock();
> >       memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
> > -     if (memcg_css)
> > -             isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> > +     if (memcg_css && !css_tryget(memcg_css))
> > +             memcg_css = NULL;
> >       rcu_read_unlock();
> > +     if (!memcg_css)
> > +             goto out_free;
> > +
> > +     isw->new_wb = wb_get_create(bdi, memcg_css, GFP_NOIO);
> > +     css_put(memcg_css);
> >       if (!isw->new_wb)
> >               goto out_free;
> >
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
