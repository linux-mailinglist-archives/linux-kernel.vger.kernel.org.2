Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208543DF88F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhHCXf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbhHCXf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:35:56 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FB1C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:35:44 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id k7so1091316qki.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uhDyUj2VSVRpxbG/0UXwj6BIhNgU6btFMLRW7jRZu+0=;
        b=kZtnicXFx9GD20ho5v8snd5tko753aUlUgTIuPa6FbiGiWZEJWWlvpZ+LQ8DqwRVMW
         tW/sbXcwp7Y00/DWrE8kE3MLU6XaxvcZQmjBeduRZm56uPe8Io+SoqspP6ERGOXZGXlP
         sMcMCUbCZl4uF7hFRclzuzwt3GcSQu5qp/w/3BwfR9pXXVP1cfr5PPTrCreq+C6D7Yj9
         Vq17Iaymneru9n4bdT/CJxdAu4/2oF6aIFlTFu0RTyIgkvxZ8ZhfJ0CZXtfpwn2p4JzW
         FhEn9esnkhvsSGsZvkfYjZEd+dqK3fACCSHC5yoB2kHUg/Brs6CtNpj6jujsECF1WHQl
         yCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uhDyUj2VSVRpxbG/0UXwj6BIhNgU6btFMLRW7jRZu+0=;
        b=O7eJYA1n330M5l7SJVKWkjJm2LlZU9/5zClzKmhMoCe6a4+s3u86USZBVH2749k++N
         VNcJR4W7x2IJJuRuB1ba6Nk+Av+7OCQgf2KRi5mbaZII7A8L4hlYpl+yNPAdEkRH/RrC
         OwCmrzR5OhAa1RhGswTWDWwakyJYap3Lk5TPt/XTPimlAr2C25tgTZFJD9g3mGAAOMIF
         JXpdu7YMFwHk3LXJFzVL0SKPsDx6XGCYvi5V4rUzlHZY3pll1i/PCdFhurXb9tv/NCdl
         pUQ/UWycQccMrgxCD6GHaoe/Iimhf4DiSfQVmH3F4PSUeE9+FJG4ASMHm7pp11CXC/FQ
         UFww==
X-Gm-Message-State: AOAM533BOtt3Blh7jYCiYNoS+VhEnce7cLQ0z3DA8UC1jnPpDv4PK0DC
        +xVCIACp7JURj/imN/wHBq85sg==
X-Google-Smtp-Source: ABdhPJx/JXJh+CCyExIE/rFD7Gs85I8uz1IOyOfUCLsinNt7bQE3NPusvSSul/lc54NwuguJEWasSA==
X-Received: by 2002:a05:620a:64c:: with SMTP id a12mr18105687qka.377.1628033744011;
        Tue, 03 Aug 2021 16:35:44 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 28sm309576qkp.26.2021.08.03.16.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:35:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mB3wk-00CMna-H4; Tue, 03 Aug 2021 20:35:42 -0300
Date:   Tue, 3 Aug 2021 20:35:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Luigi Rizzo <lrizzo@google.com>, Jann Horn <jannh@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Message-ID: <20210803233542.GH543798@ziepe.ca>
References: <20210731175341.3458608-1-lrizzo@google.com>
 <20210803160803.GG543798@ziepe.ca>
 <CAMOZA0JKjRFUHbs3zc4kiGcuXxR0arCN=oPZZsLCa4qHvRrH_A@mail.gmail.com>
 <20210803230725.ao3i2emejyyor36n@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803230725.ao3i2emejyyor36n@revolver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 11:07:35PM +0000, Liam Howlett wrote:
> * Luigi Rizzo <lrizzo@google.com> [210803 17:49]:
> > On Tue, Aug 3, 2021 at 6:08 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Sat, Jul 31, 2021 at 10:53:41AM -0700, Luigi Rizzo wrote:
> > > > find_vma() and variants need protection when used.
> > > > This patch adds mmap_assert_lock() calls in the functions.
> > > >
> > > > To make sure the invariant is satisfied, we also need to add a
> > > > mmap_read_loc() around the get_user_pages_remote() call in
> > > > get_arg_page(). The lock is not strictly necessary because the mm
> > > > has been newly created, but the extra cost is limited because
> > > > the same mutex was also acquired shortly before in __bprm_mm_init(),
> > > > so it is hot and uncontended.
> > > >
> > > > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> > > >  fs/exec.c | 2 ++
> > > >  mm/mmap.c | 2 ++
> > > >  2 files changed, 4 insertions(+)
> > > >
> > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > index 38f63451b928..ac7603e985b4 100644
> > > > +++ b/fs/exec.c
> > > > @@ -217,8 +217,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
> > > >        * We are doing an exec().  'current' is the process
> > > >        * doing the exec and bprm->mm is the new process's mm.
> > > >        */
> > > > +     mmap_read_lock(bprm->mm);
> > > >       ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
> > > >                       &page, NULL, NULL);
> > > > +     mmap_read_unlock(bprm->mm);
> > > >       if (ret <= 0)
> > > >               return NULL;
> > >
> > > Wasn't Jann Horn working on something like this too?
> > >
> > > https://lore.kernel.org/linux-mm/20201016225713.1971256-1-jannh@google.com/
> > >
> > > IIRC it was very tricky here, are you sure it is OK to obtain this lock
> > > here?
> > 
> > I cannot comment on Jann's patch series but no other thread knows
> > about this mm at this point in the code so the lock is definitely
> > safe to acquire (shortly before there was also a write lock acquired
> > on the same mm, in the same conditions).
> 
> If there is no other code that knows about this mm, then does one need
> the lock at all?  Is this just to satisfy the new check you added?
> 
> If you want to make this change, I would suggest writing it in a way to
> ensure the call to expand_downwards() in the same function also holds
> the lock.  I believe this is technically required as well?  What do you
> think?

This is essentially what Jann was doing. Since the mm is newly created
we can create it write locked and then we can add proper locking tests
to many of the functions called along this path.

Adding useless locks around each troublesome callsite just seems
really confusing to me.

Jason
