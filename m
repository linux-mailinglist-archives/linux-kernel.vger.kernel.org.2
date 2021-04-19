Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D229E363F28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhDSJts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhDSJtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:49:47 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83677C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:49:16 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id m25-20020a4abc990000b02901ed4500e31dso631172oop.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nitggrP0xRKevJNitjMdZZF9gGxfx3q/C1mur/zTDM4=;
        b=SnrQH8znT2PnsSAqn0jXpHSmCspkH0VVBOSQegOGOyXENQDZaw59x840LwuilNQe+L
         TKgVMlImiglbkLDoP6FzmSzTMU7We1xNNNR4lwb6yd7RP5gE9T6UEdJZS1x6byCQyiuK
         oivTvlDGePHJgoizjxX+ip7vSAxMBfmumdb0NB0Mbqz0R7x0whQ3bAib84SZTSY5cbsa
         j0bxgF91OhwJUDBta4spTK92YGdQiOrEsiGwLnWtj/r2+sP1VFXUN0gAOEUa3vHbhEi5
         c6cz8AalBDd4qvdOiCjiEhd1xaETwZaPyKBuZg2GdikqsiyhXlSWwH34sFvKEpZrUN6k
         wgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nitggrP0xRKevJNitjMdZZF9gGxfx3q/C1mur/zTDM4=;
        b=p1cTxVOyqxJ0xmVHN1OCTMAaiJjxZlbRZTQtvdjnjIVCOfN7bK8JzfwulH4TyQ4xY+
         ZiMUXkxqUUV1naNxSibEqowYWJyZ8amg2JmRJIpPfmlnTNGRW7jivatzoiMXGukGP2P9
         PHuVE1kXJ8a70Rs5Bink2LwfU+AttMEyRryNRfciPPNJr52TPRYX2lZJ+ehdAtEUKroX
         imhJPXUXSHQI3LZTLQzogNf294h6cqhkK8PULUIlW7ndG34lgGycZahArRhUJ5Qd1m9F
         p/G2kVwUn97BuvN8VgOhXSnMWvFlGbLB/3CEuR2hN1e+fBmbTL71TmTIeJdfptKHR9lN
         q0mg==
X-Gm-Message-State: AOAM531O+c8qXAqEMvYgswP1afGaxr9JjsmM7lgadQDaARz2xT8HKsnp
        oj2gnR9tQSjVk2KF+by4xpXhPzLlFaF9UIKblF007A==
X-Google-Smtp-Source: ABdhPJyK0p5DKT8g7HVkLdNNo5TjSC69kgdPjyM/tw685tNXp7o0tBnV2rd+RRqciPsuO8a/EdxlE8c1zvZKS2jKS5Y=
X-Received: by 2002:a4a:eb02:: with SMTP id f2mr12729819ooj.36.1618825755725;
 Mon, 19 Apr 2021 02:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210419085027.761150-1-elver@google.com> <20210419085027.761150-2-elver@google.com>
 <20210419094044.311-1-hdanton@sina.com> <CANpmjNMR-DPj=0mQMevyEQ7k3RJh0eq_nkt9M6kLvwC-abr_SQ@mail.gmail.com>
In-Reply-To: <CANpmjNMR-DPj=0mQMevyEQ7k3RJh0eq_nkt9M6kLvwC-abr_SQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 19 Apr 2021 11:49:04 +0200
Message-ID: <CANpmjNNO3AgK3Fr07KXQhGpqt6-z7xNJFP=UoODg-Ft=u9cGfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kfence: await for allocation using wait_event
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 at 11:44, Marco Elver <elver@google.com> wrote:
>
> On Mon, 19 Apr 2021 at 11:41, Hillf Danton <hdanton@sina.com> wrote:
> >
> > On Mon, 19 Apr 2021 10:50:25 Marco Elver wrote:
> > > +
> > > +     WRITE_ONCE(kfence_timer_waiting, true);
> > > +     smp_mb(); /* See comment in __kfence_alloc(). */
> >
> > This is not needed given task state change in wait_event().
>
> Yes it is. We want to avoid the unconditional irq_work in
> __kfence_alloc(). When the system is under load doing frequent
> allocations, at least in my tests this avoids the irq_work almost
> always. Without the irq_work you'd be correct of course.

And in case this is about the smp_mb() here, yes it definitely is
required. We *must* order the write of kfence_timer_waiting *before*
the check of kfence_allocation_gate, which wait_event() does before
anything else (including changing the state). Otherwise the write may
be reordered after the read, and we could potentially never wake up
because __kfence_alloc() not waking us.

This is documented in __kfence_alloc().

> > > +     wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate), HZ);
> > > +     smp_store_release(&kfence_timer_waiting, false); /* Order after wait_event(). */
> > > +
