Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0D8350AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhCaXkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCaXj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:39:56 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D116C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:39:56 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h7so282713qtx.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KRXtd75gIM8o6NO9GrD5QaBIhsBoZKHXbOsv1GkYlzc=;
        b=icAxVtUz2hwviiFNsnHwXEnvvtgXHS05bFOuzxBj120Eg5qITOkW4TAP4+E4/U0UMz
         d7A3ZJ0+Y4PUBnaUNcXYjLti0rW3kwnyl8P5KQXebXzrO+mttpJ0a6fqoIYgezQHVNRl
         4QQ7s0RIkQMiWoukQ36T0c2QeLGBfIfCyH4Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KRXtd75gIM8o6NO9GrD5QaBIhsBoZKHXbOsv1GkYlzc=;
        b=E7IOJSyBZ4bD0dj1rVeMQ3O4gk+4p2QJW15Y/SJO6vNpzEVmVktUXdKpYISBHV9uH5
         VbFtEBkiKoDwp8glVfS0NqYQR/59ygjWMLmVURGJn3ZL366x2at1bX7tXZJqoFrPKy1m
         U5FiEqs+u0VyyN3Fi7Il+51R8KK7ZDOy2XqvPclblwQIZsBm1Ga9Jp2ai2OZUlx3OxHi
         63GiFBQo9MEexdiFFanxiOT0u6TpHu/BDT0bxvmctvv96BQT5ete9zBhKmF52bc8Bab4
         OLO94iaGfa0dGLJx/vBz7n2DbmCeqs2VJvWm7q+YozGj5GFOWhkENw8qzcaTp9uo0Ja2
         m+5g==
X-Gm-Message-State: AOAM532/l2ceEd6h8N7zGB5sRhhKICddW/o33Bb0R9j8Zd4IfRnBCh9s
        ZCPCY0WgbgOi2l3Z8pdsxlF3EG+2dszASQ==
X-Google-Smtp-Source: ABdhPJxG2vWVpE52nI95+W/4u7jRbiEh29JJoc4vAA13/Tmrk+kNGNGjbY0/B9As6h80MmI/a4jAMg==
X-Received: by 2002:ac8:1098:: with SMTP id a24mr4538967qtj.291.1617233995369;
        Wed, 31 Mar 2021 16:39:55 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 19sm1350526qtt.32.2021.03.31.16.39.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 16:39:54 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id z1so23003984ybf.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:39:54 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr8216760ybp.476.1617233994289;
 Wed, 31 Mar 2021 16:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210331221630.488498-1-robdclark@gmail.com> <20210331221630.488498-3-robdclark@gmail.com>
 <CAD=FV=USXBm-ZLafNWbUK=Ny7_vwtyG164mQFs87SkXqim-Vpw@mail.gmail.com> <CAF6AEGutvjUQ-bQMsAYDLq5kdRo7rQ5XwWjGSRV27VT_UOuMTw@mail.gmail.com>
In-Reply-To: <CAF6AEGutvjUQ-bQMsAYDLq5kdRo7rQ5XwWjGSRV27VT_UOuMTw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Mar 2021 16:39:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLzDW93COWPALyin3N-wM=a7uKG7WgttmMCncf7qRmKQ@mail.gmail.com>
Message-ID: <CAD=FV=VLzDW93COWPALyin3N-wM=a7uKG7WgttmMCncf7qRmKQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/msm: Avoid mutex in shrinker_count()
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 31, 2021 at 4:23 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Wed, Mar 31, 2021 at 3:44 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Mar 31, 2021 at 3:14 PM Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > @@ -818,11 +820,19 @@ static void update_inactive(struct msm_gem_object *msm_obj)
> > >         mutex_lock(&priv->mm_lock);
> > >         WARN_ON(msm_obj->active_count != 0);
> > >
> > > +       if (msm_obj->dontneed)
> > > +               mark_unpurgable(msm_obj);
> > > +
> > >         list_del_init(&msm_obj->mm_list);
> > > -       if (msm_obj->madv == MSM_MADV_WILLNEED)
> > > +       if (msm_obj->madv == MSM_MADV_WILLNEED) {
> > >                 list_add_tail(&msm_obj->mm_list, &priv->inactive_willneed);
> > > -       else
> > > +       } else if (msm_obj->madv == MSM_MADV_DONTNEED) {
> > >                 list_add_tail(&msm_obj->mm_list, &priv->inactive_dontneed);
> > > +               mark_purgable(msm_obj);
> > > +       } else {
> > > +               WARN_ON(msm_obj->madv != __MSM_MADV_PURGED);
> > > +               list_add_tail(&msm_obj->mm_list, &priv->inactive_purged);
> >
> > I'm probably being dense, but what's the point of adding it to the
> > "inactive_purged" list here? You never look at that list, right? You
> > already did a list_del_init() on this object's list pointer
> > ("mm_list"). I don't see how adding it to a bogus list helps with
> > anything.
>
> It preserves the "every bo is in one of these lists" statement, but
> other than that you are right we aren't otherwise doing anything with
> that list.  (Or we could replace the list_del_init() with list_del()..
> I tend to instinctively go for list_del_init())

If you really want this list, it wouldn't hurt to at least have a
comment saying that it's not used for anything so people like me doing
go trying to figure out what it's used for. ;-)


> > > @@ -198,6 +203,33 @@ static inline bool is_vunmapable(struct msm_gem_object *msm_obj)
> > >         return (msm_obj->vmap_count == 0) && msm_obj->vaddr;
> > >  }
> > >
> > > +static inline void mark_purgable(struct msm_gem_object *msm_obj)
> > > +{
> > > +       struct msm_drm_private *priv = msm_obj->base.dev->dev_private;
> > > +
> > > +       WARN_ON(!mutex_is_locked(&priv->mm_lock));
> > > +
> > > +       if (WARN_ON(msm_obj->dontneed))
> > > +               return;
> >
> > The is_purgeable() function also checks other things besides just
> > "MSM_MADV_DONTNEED". Do we need to check those too? Specifically:
> >
> >  msm_obj->sgt && !msm_obj->base.dma_buf && !msm_obj->base.import_attach
> >
> > ...or is it just being paranoid?
> >
> > I guess I'm just worried that if any of those might be important then
> > we'll consistently report back that we have a count of things that can
> > be purged but then scan() won't find anything to do. That wouldn't be
> > great.
>
> Hmm, I thought msm_gem_madvise() returned an error instead of allowing
> MSM_MADV_DONTNEED to be set on imported/exported dma-bufs.. it
> probably should to be complete (but userspace already knows not to
> madvise an imported/exported buffer for other reasons.. ie. we can't
> let a shared buffer end up in the bo cache).  I'll re-work that a bit.
>
> The msm_obj->sgt case is a bit more tricky.. that will be the case of
> a freshly allocated obj that does not have backing patches yet.  But
> it seems like enough of a corner case, that I'm happy to live with
> it.. ie. the tricky thing is not leaking decrements of
> priv->shrinkable_count or underflowing priv->shrinkable_count, and
> caring about the !msm_obj->sgt case doubles the number of states an
> object can be in, and the shrinker->count() return value is just an
> estimate.

I think it's equally important to make sure that we don't constantly
have a non-zero count and then have scan() do nothing.  If there's a
transitory blip then it's fine, but it's not OK if it can be steady
state. Then you end up with:

1. How many objects do you have to free? 10
2. OK, free some. How many did you free? 0
3. Oh. You got more to do, I'll call you again.
4. Goto #1

...and it just keeps looping, right?

As long as you're confident that this case can't happen then we're
probably fine, but good to be careful. Is there any way we can make
sure that a "freshly allocated object" isn't ever in the "DONTNEED"
state?


> > > +       priv->shrinkable_count += msm_obj->base.size >> PAGE_SHIFT;
> > > +       msm_obj->dontneed = true;
> > > +}
> > > +
> > > +static inline void mark_unpurgable(struct msm_gem_object *msm_obj)
> > > +{
> > > +       struct msm_drm_private *priv = msm_obj->base.dev->dev_private;
> > > +
> > > +       WARN_ON(!mutex_is_locked(&priv->mm_lock));
> > > +
> > > +       if (WARN_ON(!msm_obj->dontneed))
> > > +               return;
> > > +
> > > +       priv->shrinkable_count -= msm_obj->base.size >> PAGE_SHIFT;
> > > +       WARN_ON(priv->shrinkable_count < 0);
> >
> > If you changed the order maybe you could make shrinkable_count
> > "unsigned long" to match the shrinker API?
> >
> >  new_shrinkable = msm_obj->base.size >> PAGE_SHIFT;
> >  WARN_ON(new_shrinkable > priv->shrinkable_count);
> >  priv->shrinkable_count -= new_shrinkable
> >
>
> True, although I've developed a preference for signed integers in
> cases where it can underflow if you mess up

Yeah, I guess it's fine since it's a count of pages and we really
can't have _that_ many pages worth of stuff to purge. It might not
hurt to at least declare it as a "long" instead of an "int" though to
match the shrinker API.

-Doug
