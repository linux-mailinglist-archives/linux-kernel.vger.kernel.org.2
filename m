Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854563B8A70
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhF3W1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhF3W06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:26:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E6CC0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:24:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id k21so5496591ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3XjqNfOUEjY4PGf0oNIbcI1jIFS7SSN6noMXz/wL00o=;
        b=ljmoMCp9mVecb3lsQyFfFIa8U3pjU5ywUrl5I7ojN4cPfsATW4/rFgvNjWe9sF02g9
         SvkQChQZpn+GM/fS1xmFE6pf/pjMYEIL+obhVpUplH6kb1utPfVQHiHC1BdpkhGIlDPc
         euB+F0Jf+NRFoBR+Utc642vD/wlc23ekLEw6cbZSW0Q2Le0SmskzND/Yz4qYHznIs4Kc
         UfzsxM0Rvxd0SQ3dY7V6XmHsqzZFW2yo8oUlXg6v3Z5F93SmYVVrSk1P93QSFnm60ZiH
         I5lK+t3HT1x9LbP+/g24vwhiP/Yrp0qlQAnkiccJybiQuhFoGH69Ucyq6/S5hdtPtVU5
         PyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3XjqNfOUEjY4PGf0oNIbcI1jIFS7SSN6noMXz/wL00o=;
        b=r8UzDmRYR2a6hxQQUmvTGJu6QUHVZ2a+ABUSoSLn8W9ZCKqOGwvbWn7TxbTwFlK8ZD
         /4ORntRm62b83/RRVIrK+LTIbOufXnUdtNsW0Sup4UDKPjg2e/BMJ6P7seLid+jKnf48
         cvxTIvWiXtMVfuHMZnz+YwhLa8xOz7RurGjmBQ196Wb/MCgd+D4grWTYVf9MrrVg1LYv
         OyzleOW7U7YxrFUyXs9ORaZ7G7yn2aHoUZRmi8sTvc0J0dj3QHRUe5ZJfj0tyq9x/OrQ
         EbILJYexwJQhqbGKxyAdxIqeY6tMB7IV4kteJsKzKsPShApwk8LGh7+0B/kAO63/+u97
         6ZZQ==
X-Gm-Message-State: AOAM531JQlK3QKIF11nviTSJMdifqONwwug+EapOn/NSVjMLp6AIVSAn
        G8jZbm6RAqt8+Izx3upiTKry1Flp2G/ITJe6M+FePw==
X-Google-Smtp-Source: ABdhPJzBS7LRn1EU7cSbyqMzIUyrWcGYHfzzM9hInxY3/7q47dAHnynTrc93ZIGDiC54Nn8Oc0HhosYwCYqEwFoGG08=
X-Received: by 2002:a05:651c:4ca:: with SMTP id e10mr9108153lji.503.1625091865800;
 Wed, 30 Jun 2021 15:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210630013421.735092-1-john.stultz@linaro.org>
 <20210630013421.735092-2-john.stultz@linaro.org> <ab35ed32-ead4-3dc4-550d-55f288810220@amd.com>
In-Reply-To: <ab35ed32-ead4-3dc4-550d-55f288810220@amd.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 30 Jun 2021 15:24:14 -0700
Message-ID: <CALAqxLXWDKp3BZJdO3nVd9vSVV6B+bWnTy+oP6bzBB6H3Yf4eA@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] drm: Add a sharable drm page-pool implementation
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 2:10 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> Am 30.06.21 um 03:34 schrieb John Stultz:
> > +static unsigned long page_pool_size; /* max size of the pool */
> > +
> > +MODULE_PARM_DESC(page_pool_size, "Number of pages in the drm page pool=
");
> > +module_param(page_pool_size, ulong, 0644);
> > +
> > +static atomic_long_t nr_managed_pages;
> > +
> > +static struct mutex shrinker_lock;
> > +static struct list_head shrinker_list;
> > +static struct shrinker mm_shrinker;
> > +
> > +/**
> > + * drm_page_pool_set_max - Sets maximum size of all pools
> > + *
> > + * Sets the maximum number of pages allows in all pools.
> > + * This can only be set once, and the first caller wins.
> > + */
> > +void drm_page_pool_set_max(unsigned long max)
> > +{
> > +     if (!page_pool_size)
> > +             page_pool_size =3D max;
> > +}
> > +
> > +/**
> > + * drm_page_pool_get_max - Maximum size of all pools
> > + *
> > + * Return the maximum number of pages allows in all pools
> > + */
> > +unsigned long drm_page_pool_get_max(void)
> > +{
> > +     return page_pool_size;
> > +}
>
> Well in general I don't think it is a good idea to have getters/setters
> for one line functionality, similar applies to locking/unlocking the
> mutex below.
>
> Then in this specific case what those functions do is to aid
> initializing the general pool manager and that in turn should absolutely
> not be exposed.
>
> The TTM pool manager exposes this as function because initializing the
> pool manager is done in one part of the module and calculating the
> default value for the pages in another one. But that is not something I
> would like to see here.

So, I guess I'm not quite clear on what you'd like to see...

Part of what I'm balancing here is the TTM subsystem normally sets a
global max size, whereas the old ION pool didn't have caps (instead
just relying on the shrinker when needed).
So I'm trying to come up with a solution that can serve both uses. So
I've got this drm_page_pool_set_max() function to optionally set the
maximum value, which is called in the TTM initialization path or set
the boot argument. But for systems that use the dmabuf system heap,
but don't use TTM, no global limit is enforced.

Your earlier suggestion to have it as an argument to the
drm_page_pool_shrinker_init() didn't make much sense to me, as then we
may have multiple subsystems trying to initialize the pool shrinker,
which doesn't seem ideal. So I'm not sure what would be preferred.

I guess we could have subsystems allocate their own pool managers with
their own shrinkers and per-manager-size-limits? But that also feels
like a fair increase in complexity, for I'm not sure how much benefit.

> > +void drm_page_pool_add(struct drm_page_pool *pool, struct page *p)
> > +{
> > +     unsigned int i, num_pages =3D 1 << pool->order;
> > +
> > +     /* Make sure we won't grow larger then the max pool size */
> > +     if (page_pool_size &&
> > +            ((drm_page_pool_get_total()) + num_pages > page_pool_size)=
) {
> > +             pool->free(pool, p);
> > +             return;
> > +     }
>
> That is not a good idea. See how ttm_pool_free() does this.
>
> First the page is given back to the pool, then all pools are shrinked if
> they are above the global limit.

Ok, initially my thought was it seemed like wasteful overhead to add
the page to the pool and then shrink the pool, so just freeing the
given page directly if the pool was full seemed more straightforward.
But on consideration here I do realize having most-recently-used hot
pages in the pool would be good for performance, so I'll switch that
back. Thanks for pointing this out!

Thanks again so much for the review and feedback!
-john
