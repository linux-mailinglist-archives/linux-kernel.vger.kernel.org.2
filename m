Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA03A231F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 06:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhFJERR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 00:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhFJERI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 00:17:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98709C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 21:14:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z26so508066pfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 21:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqLG9GpY7necug2HTmXtb7Z8qz/cB5AH/MqEASFbUXY=;
        b=QYApRhGg4ioXPaE8HZBPAvOeCZ7gkXxg/l7jdAvY88OrJrZ9iC/p0ib6gegKLbMzg6
         ReD4rTST/WK8pJ/bY/K0Urw5kSIiu8OeGcPqFd5OMzMZhMrEbiX3jU1DgKRMYJQjSj7I
         4T829lJkJkmRUKbf5ITSwCckl5hraLFo9dNyh5ngBMAA0TkHCuaK9oovehH18WtSbeWT
         BP/FBGhdtYEmLy2RSM5xwD0/tGpdiMaQNBE4M8nR0yDvfzBJLhYmOWd73JW6l1/H5iGh
         Vs/oy2kOeOqc78uvfb57jBEguGqKBNrUha6b5f1AbeUywcgqjc6mkQvr0JvIJAmtx+xo
         vwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqLG9GpY7necug2HTmXtb7Z8qz/cB5AH/MqEASFbUXY=;
        b=kJbiXYT0nFAtT2O3jYXaPOlyfDR5Q+QsjdPj9VQwBZPP7ATuKi6JvWABySOZVgK4yr
         Hoi5kjgClSy61jnj00Lp1GKIQCKmDZ3PkI1bMSyg2/2VjkeKaIyJsXuEj9KiHEkh/3GM
         gqHirDJuf/LXUetypJSLEnWCR+RSUTI2Pft4UlMCt8gEtzVbl19TviwCNmFNt4kBbm4x
         7qiZVXJQEXdZaPcjO7XmOxd0zEu9x40k9Snbss4GxtH3vBQu+JyJmAZ+rj8VerJq4iro
         5srW6g2wLG9ElO4sJG51LJWLLaPqO8/4MRwJQOHq21+6b4FuQ+1iLV0VDAzbTnzVrdcZ
         P/QA==
X-Gm-Message-State: AOAM5312RcDOD1fawN/sAep+yL4a+TzinMYrRoN8fZDaeRVLErHoaTBS
        SVnNLZlxhXbLSxaK6164FvFEmSJF1MRcrUfUxSkUtQ==
X-Google-Smtp-Source: ABdhPJzRiV/Iah/jaw0b3aUDQuxuXztB9R6Xexf88c8ByZ/wXGxM817p8hVLLn79FW60CbJh4XxOPO3Y7GIK/65QxdE=
X-Received: by 2002:a65:63ce:: with SMTP id n14mr2984687pgv.273.1623298498162;
 Wed, 09 Jun 2021 21:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210606041750.69403-1-songmuchun@bytedance.com> <028651d9-5e3b-8348-00af-e6acf8ea4ced@suse.cz>
In-Reply-To: <028651d9-5e3b-8348-00af-e6acf8ea4ced@suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Jun 2021 12:14:18 +0800
Message-ID: <CAMZfGtXPEexiKSMcViKuFnRoYjH7ajjXGLRS8Q-H-pTmyHsCbA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: slub: replace local_irq_save with local_irq_disable
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 8:32 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 6/6/21 6:17 AM, Muchun Song wrote:
> > The caller of slub_cpu_dead cannot be irq disabled (because slab_mutex is
> > holding during the processing), there is no need to use irq_save. Just use
> > irq_disable directly.
>
> Well, we shouldn't need to disable irq at all. We are cleaning up for a dead
> cpu, so there's nobody else accesing the data. irq save/disable will protect
> only the local cpu's data, not of the cpu we are flushing. But we can't simply
> remove the irq disable/enable because there are some nested
> VM_BUG_ON(!irqs_disabled()) under __flush_cpu_slab(). We basically only disable
> irqs here to avoid those from triggering.
>
> My series [1] addresses this completely (among other things), but it's early
> stage RFC (v2 should be soon). Your patch is not wrong, but also not urgent or
> perf critical. So with that context I'll leave the decision to others :)

Got it.

>
> [1] https://lore.kernel.org/lkml/20210524233946.20352-1-vbabka@suse.cz/

Good series. Reducing irq disabling is nice.

Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/slub.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index ee51857d8e9b..fbf592ef14ff 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2529,13 +2529,12 @@ static void flush_all(struct kmem_cache *s)
> >  static int slub_cpu_dead(unsigned int cpu)
> >  {
> >       struct kmem_cache *s;
> > -     unsigned long flags;
> >
> >       mutex_lock(&slab_mutex);
> >       list_for_each_entry(s, &slab_caches, list) {
> > -             local_irq_save(flags);
> > +             local_irq_disable();
> >               __flush_cpu_slab(s, cpu);
> > -             local_irq_restore(flags);
> > +             local_irq_enable();
> >       }
> >       mutex_unlock(&slab_mutex);
> >       return 0;
> >
>
