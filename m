Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B80640FAF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbhIQPAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242854AbhIQO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:59:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD97C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:58:35 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id o66so11630732oib.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+JGSMw5LOV21Xn1Nvh/yNqSCnZsmZNBCAdtQCfOwAM=;
        b=b1+i3ZY/k9/7OUjdinoDsdGqBfJNyHFocKE2s/VOY8qYyirit6IDXg981qG0N6cH7p
         vIw8xl/g65AdK0GTDRSrQv6LjRS/xLpwY3J+275Fxhm6w96xXCIiqA7NrgN26+jwle0J
         KUtvWwS+gkWnK1LbNIuAz1Q0l0UkWAmuHJbjK/BsIHCnsufbpSF004MWvyiok0pQPHe1
         fe2WrJ+DtIAsLVgDopZsvV/I47SlLT4l6L9h3c0CYdoSdxOmVTfnZ0aHqMaiW3dcie/C
         xt0nnk6wNB1XYv8VLF1eEv+G7HhNO7PHIMENZd+qVx+kBHv4E11yD0flayVtoEQcTK4P
         Bw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+JGSMw5LOV21Xn1Nvh/yNqSCnZsmZNBCAdtQCfOwAM=;
        b=fMVO+PmDZVGcvANv1Giek1c06IeMqmcdC9KY2iM9bu93RJe2PbAEzYt9f1DAF92d1K
         1Dm9qheauSt9Zosn5WPjHhiPeUE2swZ9t/vlsADXmp7RoByLcU6Pw+ru1KUOJd/h4EL9
         PeHMk8euIkHN59GLGWksxZTdJEw+jI0Q1UkFv8tYz2iQUyTT4VIzs8EXhdGydue3sxO4
         rG0K34wffVbQQQ5/HaFPuSVBcW74p7vwW/x9KmX6FQ+7Kkf0BW2Kmi/UWzA/lim3AtQk
         VWTjmQEbF3hMFNQiDkGYxLAwQRtFDi8JkL1DhZXJFW+reMLfH4cEqPofsO6cDgSAt/oT
         cNMg==
X-Gm-Message-State: AOAM530uXdZBuI+Z06akhv+NRoid3I576+99oWRbVQ4bsFcmb6ZxZto2
        KxyCKeC7MDP+uLnYGlojCRVs684isBWLk5xQAHFC7Q==
X-Google-Smtp-Source: ABdhPJyd009rjRQUefvMYwgMn6Ta/CktFruxGfMmpxTT3U37q3vyRZL6ITEreB6Re7aLPteOElnJUHbIOcklqxwepEw=
X-Received: by 2002:aca:f189:: with SMTP id p131mr13961442oih.128.1631890712962;
 Fri, 17 Sep 2021 07:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210830172627.267989-1-bigeasy@linutronix.de> <20210830172627.267989-6-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-6-bigeasy@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 16:58:21 +0200
Message-ID: <CACT4Y+axiW+rAs+8a8E9WRx+rpv67ciKcZT_qEqZ_Hyt-7hLVQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] kcov: Replace local_irq_save() with a local_lock_t.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/On Mon, 30 Aug 2021 at 19:26, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The kcov code mixes local_irq_save() and spin_lock() in
> kcov_remote_{start|end}(). This creates a warning on PREEMPT_RT because
> local_irq_save() disables interrupts and spin_lock_t is turned into a
> sleeping lock which can not be acquired in a section with disabled
> interrupts.
>
> The kcov_remote_lock is used to synchronize the access to the hash-list
> kcov_remote_map. The local_irq_save() block protects access to the
> per-CPU data kcov_percpu_data.
>
> There no compelling reason to change the lock type to raw_spin_lock_t to
> make it work with local_irq_save(). Changing it would require to move
> memory allocation (in kcov_remote_add()) and deallocation outside of the
> locked section.
> Adding an unlimited amount of entries to the hashlist will increase the
> IRQ-off time during lookup. It could be argued that this is debug code
> and the latency does not matter. There is however no need to do so and
> it would allow to use this facility in an RT enabled build.
>
> Using a local_lock_t instead of local_irq_save() has the befit of adding
> a protection scope within the source which makes it obvious what is
> protected. On a !PREEMPT_RT && !LOCKDEP build the local_lock_irqsave()
> maps directly to local_irq_save() so there is overhead at runtime.

s/befit/benefit/
s/overhead/no overhead/

but otherwise

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> Replace the local_irq_save() section with a local_lock_t.
>
> Reported-by: Clark Williams <williams@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/kcov.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 620dc4ffeb685..36ca640c4f8e7 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -88,6 +88,7 @@ static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
>
>  struct kcov_percpu_data {
>         void                    *irq_area;
> +       local_lock_t            lock;
>
>         unsigned int            saved_mode;
>         unsigned int            saved_size;
> @@ -96,7 +97,9 @@ struct kcov_percpu_data {
>         int                     saved_sequence;
>  };
>
> -static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
> +static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data) = {
> +       .lock = INIT_LOCAL_LOCK(lock),
> +};
>
>  /* Must be called with kcov_remote_lock locked. */
>  static struct kcov_remote *kcov_remote_find(u64 handle)
> @@ -824,7 +827,7 @@ void kcov_remote_start(u64 handle)
>         if (!in_task() && !in_serving_softirq())
>                 return;
>
> -       local_irq_save(flags);
> +       local_lock_irqsave(&kcov_percpu_data.lock, flags);
>
>         /*
>          * Check that kcov_remote_start() is not called twice in background
> @@ -832,7 +835,7 @@ void kcov_remote_start(u64 handle)
>          */
>         mode = READ_ONCE(t->kcov_mode);
>         if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
> -               local_irq_restore(flags);
> +               local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>                 return;
>         }
>         /*
> @@ -841,14 +844,15 @@ void kcov_remote_start(u64 handle)
>          * happened while collecting coverage from a background thread.
>          */
>         if (WARN_ON(in_serving_softirq() && t->kcov_softirq)) {
> -               local_irq_restore(flags);
> +               local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>                 return;
>         }
>
>         spin_lock(&kcov_remote_lock);
>         remote = kcov_remote_find(handle);
>         if (!remote) {
> -               spin_unlock_irqrestore(&kcov_remote_lock, flags);
> +               spin_unlock(&kcov_remote_lock);
> +               local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>                 return;
>         }
>         kcov_debug("handle = %llx, context: %s\n", handle,
> @@ -873,13 +877,13 @@ void kcov_remote_start(u64 handle)
>
>         /* Can only happen when in_task(). */
>         if (!area) {
> -               local_irqrestore(flags);
> +               local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>                 area = vmalloc(size * sizeof(unsigned long));
>                 if (!area) {
>                         kcov_put(kcov);
>                         return;
>                 }
> -               local_irq_save(flags);
> +               local_lock_irqsave(&kcov_percpu_data.lock, flags);
>         }
>
>         /* Reset coverage size. */
> @@ -891,7 +895,7 @@ void kcov_remote_start(u64 handle)
>         }
>         kcov_start(t, kcov, size, area, mode, sequence);
>
> -       local_irq_restore(flags);
> +       local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>
>  }
>  EXPORT_SYMBOL(kcov_remote_start);
> @@ -965,12 +969,12 @@ void kcov_remote_stop(void)
>         if (!in_task() && !in_serving_softirq())
>                 return;
>
> -       local_irq_save(flags);
> +       local_lock_irqsave(&kcov_percpu_data.lock, flags);
>
>         mode = READ_ONCE(t->kcov_mode);
>         barrier();
>         if (!kcov_mode_enabled(mode)) {
> -               local_irq_restore(flags);
> +               local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>                 return;
>         }
>         /*
> @@ -978,12 +982,12 @@ void kcov_remote_stop(void)
>          * actually found the remote handle and started collecting coverage.
>          */
>         if (in_serving_softirq() && !t->kcov_softirq) {
> -               local_irq_restore(flags);
> +               local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>                 return;
>         }
>         /* Make sure that kcov_softirq is only set when in softirq. */
>         if (WARN_ON(!in_serving_softirq() && t->kcov_softirq)) {
> -               local_irq_restore(flags);
> +               local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>                 return;
>         }
>
> @@ -1013,7 +1017,7 @@ void kcov_remote_stop(void)
>                 spin_unlock(&kcov_remote_lock);
>         }
>
> -       local_irq_restore(flags);
> +       local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>
>         /* Get in kcov_remote_start(). */
>         kcov_put(kcov);
> --
> 2.33.0
>
