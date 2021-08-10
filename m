Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8076A3E5743
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbhHJJnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbhHJJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:43:29 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E88C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:43:08 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so5161443oos.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0V41XQkQgxcQV9SfL614DR4FGIaNIfXk5Ilo3cf9nAI=;
        b=DIn7CsWuXgXIjp5x8edYob0+9ErmxneQsEkEZlwtsbVUeFJxpICmG/hAWxbExQRAU1
         joDDJBw04DWT5ijUtqh8687tsekNZ2f0BPN5h/+oRiQAOPlFnk/8kzLm5sXgQHPaFjiw
         7kNtRMzTf1z9ATj1RHa+D5D2UggJffBP8B6eVWmklBDPrAngl5QJNlaIERtcwfOtFEka
         MUnPLFec2CLs4FWGurYNaUXSYLi33QuQZOL5rxKU2zdaoWC4Bqgk9eWlttp4xZturK2U
         yhtc58wBJSicKoL0CRb9J+2pxRriZvSNX4KwlkC/pmbpZYpxTjRExg6xagDwR3+ZaGuq
         6/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0V41XQkQgxcQV9SfL614DR4FGIaNIfXk5Ilo3cf9nAI=;
        b=Z+7jM7jXR1CzJ2XA8VnsaANE/OV4VNYOq8J7w64H+U9wHZPn8JMGBExMHqwpaNsC37
         724phYnOsbENxJPOqb0sRNja7dSAFCjXgJ2iaglIkjnMQCtgheFue4/nQIULwirpMh2/
         M3e6WCOZ7UHfP5UzclKa1nDbrQBfeIgSRoNgDzebEWS/XjehpkZgcZ41AJ1Z93QkVzn2
         DU3/+iGki6C3mZliloZkUUJu2RjQkT98eme42FmzSP25ROxll06Gy29GXhjR4B4hHGzq
         HVzc6iZvCSdjbI4SXky3js98XfClL0Lrnb8LSUzFGnz3QiXAnIuQ0fbcdZByX3Znph4a
         GJXw==
X-Gm-Message-State: AOAM532ArVsyaxKZUO3fZiKBkhkAEliwOoVVRY6WY/Aub86A1BxV0TsC
        hS2s5zsPUiEPmYMv9r9Y5y0MGj/xd/iShxHiEulz1Q==
X-Google-Smtp-Source: ABdhPJy0Ty0nQxcixhcdrwTJWnGr/r6pqKjJ1XEHpwvMqUnKJaIlAjDaeA2kHtH8LQu44IA5L9ARBruuMtUEzA2qRUU=
X-Received: by 2002:a4a:3c57:: with SMTP id p23mr12505664oof.14.1628588587071;
 Tue, 10 Aug 2021 02:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210809155909.333073de@theseus.lan>
In-Reply-To: <20210809155909.333073de@theseus.lan>
From:   Marco Elver <elver@google.com>
Date:   Tue, 10 Aug 2021 11:42:54 +0200
Message-ID: <CANpmjNOg_1uc5w4s+UjZkhYM9m43qwhtqcXaTt9yJRLgOoAFFw@mail.gmail.com>
Subject: Re: [PATCH PREEMPT_RT] kcov: fix locking splat from kcov_remote_start()
To:     Clark Williams <williams@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 at 22:59, Clark Williams <williams@redhat.com> wrote:
> Saw the following splat on 5.14-rc4-rt5 with:
>
> CONFIG_KCOV=y
> CONFIG_KCOV_INSTRUMENT_ALL=y
> CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
> CONFIG_RUNTIME_TESTING_MENU=y
>
> kernel: ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> kernel: BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
> kernel: in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 34, name: ksoftirqd/3
> kernel: 4 locks held by ksoftirqd/3/34:
> kernel:  #0: ffff944376d989f8 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip+0xe0/0x190
> kernel:  #1: ffffffffbbfb61e0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xd0
> kernel:  #2: ffffffffbbfb61e0 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip+0xbd/0x190
> kernel:  #3: ffffffffbc086518 (kcov_remote_lock){....}-{2:2}, at: kcov_remote_start+0x119/0x4a0
> kernel: irq event stamp: 4653
> kernel: hardirqs last  enabled at (4652): [<ffffffffbafb85ce>] _raw_spin_unlock_irqrestore+0x6e/0x80
> kernel: hardirqs last disabled at (4653): [<ffffffffba2517c8>] kcov_remote_start+0x298/0x4a0
> kernel: softirqs last  enabled at (4638): [<ffffffffba110a5b>] run_ksoftirqd+0x9b/0x100
> kernel: softirqs last disabled at (4644): [<ffffffffba149f12>] smpboot_thread_fn+0x2b2/0x410
> kernel: CPU: 3 PID: 34 Comm: ksoftirqd/3 Not tainted 5.14.0-rc4-rt5+ #3
> kernel: Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0359.2016.0906.1028 09/06/2016
> kernel: Call Trace:
> kernel:  dump_stack_lvl+0x7a/0x9b
> kernel:  ___might_sleep.cold+0xf3/0x107
> kernel:  rt_spin_lock+0x3a/0xd0
> kernel:  ? kcov_remote_start+0x119/0x4a0
> kernel:  kcov_remote_start+0x119/0x4a0
> kernel:  ? led_trigger_blink_oneshot+0x83/0xa0
> kernel:  __usb_hcd_giveback_urb+0x161/0x1e0
> kernel:  usb_giveback_urb_bh+0xb6/0x110
> kernel:  tasklet_action_common.constprop.0+0xe8/0x110
> kernel:  __do_softirq+0xe2/0x525
> kernel:  ? smpboot_thread_fn+0x31/0x410
> kernel:  run_ksoftirqd+0x8c/0x100
> kernel:  smpboot_thread_fn+0x2b2/0x410
> kernel:  ? smpboot_register_percpu_thread+0x130/0x130
> kernel:  kthread+0x1de/0x210
> kernel:  ? set_kthread_struct+0x60/0x60
> kernel:  ret_from_fork+0x22/0x30
> kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.14
>
>
> Change kcov_remote_lock from regular spinlock_t to raw_spinlock_t so that
> we don't get "sleeping function called from invalid context" on PREEMPT_RT kernel.
>
> Signed-off-by: Clark Williams <williams@redhat.com>

Reviewed-by: Marco Elver <elver@google.com>

Indeed, most other debugging tools are using raw_spinlock or
arch_spinlock, I guess KCOV was still lagging behind. Should this go
into mainline?

> ---
>  kernel/kcov.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 80bfe71bbe13..60f903f8a46c 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -82,7 +82,7 @@ struct kcov_remote {
>         struct hlist_node       hnode;
>  };
>
> -static DEFINE_SPINLOCK(kcov_remote_lock);
> +static DEFINE_RAW_SPINLOCK(kcov_remote_lock);
>  static DEFINE_HASHTABLE(kcov_remote_map, 4);
>  static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
>
> @@ -375,7 +375,7 @@ static void kcov_remote_reset(struct kcov *kcov)
>         struct hlist_node *tmp;
>         unsigned long flags;
>
> -       spin_lock_irqsave(&kcov_remote_lock, flags);
> +       raw_spin_lock_irqsave(&kcov_remote_lock, flags);
>         hash_for_each_safe(kcov_remote_map, bkt, tmp, remote, hnode) {
>                 if (remote->kcov != kcov)
>                         continue;
> @@ -384,7 +384,7 @@ static void kcov_remote_reset(struct kcov *kcov)
>         }
>         /* Do reset before unlock to prevent races with kcov_remote_start(). */
>         kcov_reset(kcov);
> -       spin_unlock_irqrestore(&kcov_remote_lock, flags);
> +       raw_spin_unlock_irqrestore(&kcov_remote_lock, flags);
>  }
>
>  static void kcov_disable(struct task_struct *t, struct kcov *kcov)
> @@ -638,18 +638,18 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                 kcov->t = t;
>                 kcov->remote = true;
>                 kcov->remote_size = remote_arg->area_size;
> -               spin_lock_irqsave(&kcov_remote_lock, flags);
> +               raw_spin_lock_irqsave(&kcov_remote_lock, flags);
>                 for (i = 0; i < remote_arg->num_handles; i++) {
>                         if (!kcov_check_handle(remote_arg->handles[i],
>                                                 false, true, false)) {
> -                               spin_unlock_irqrestore(&kcov_remote_lock,
> +                               raw_spin_unlock_irqrestore(&kcov_remote_lock,
>                                                         flags);
>                                 kcov_disable(t, kcov);
>                                 return -EINVAL;
>                         }
>                         remote = kcov_remote_add(kcov, remote_arg->handles[i]);
>                         if (IS_ERR(remote)) {
> -                               spin_unlock_irqrestore(&kcov_remote_lock,
> +                               raw_spin_unlock_irqrestore(&kcov_remote_lock,
>                                                         flags);
>                                 kcov_disable(t, kcov);
>                                 return PTR_ERR(remote);
> @@ -658,7 +658,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                 if (remote_arg->common_handle) {
>                         if (!kcov_check_handle(remote_arg->common_handle,
>                                                 true, false, false)) {
> -                               spin_unlock_irqrestore(&kcov_remote_lock,
> +                               raw_spin_unlock_irqrestore(&kcov_remote_lock,
>                                                         flags);
>                                 kcov_disable(t, kcov);
>                                 return -EINVAL;
> @@ -666,14 +666,14 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                         remote = kcov_remote_add(kcov,
>                                         remote_arg->common_handle);
>                         if (IS_ERR(remote)) {
> -                               spin_unlock_irqrestore(&kcov_remote_lock,
> +                               raw_spin_unlock_irqrestore(&kcov_remote_lock,
>                                                         flags);
>                                 kcov_disable(t, kcov);
>                                 return PTR_ERR(remote);
>                         }
>                         t->kcov_handle = remote_arg->common_handle;
>                 }
> -               spin_unlock_irqrestore(&kcov_remote_lock, flags);
> +               raw_spin_unlock_irqrestore(&kcov_remote_lock, flags);
>                 /* Put either in kcov_task_exit() or in KCOV_DISABLE. */
>                 kcov_get(kcov);
>                 return 0;
> @@ -845,10 +845,10 @@ void kcov_remote_start(u64 handle)
>                 return;
>         }
>
> -       spin_lock(&kcov_remote_lock);
> +       raw_spin_lock(&kcov_remote_lock);
>         remote = kcov_remote_find(handle);
>         if (!remote) {
> -               spin_unlock_irqrestore(&kcov_remote_lock, flags);
> +               raw_spin_unlock_irqrestore(&kcov_remote_lock, flags);
>                 return;
>         }
>         kcov_debug("handle = %llx, context: %s\n", handle,
> @@ -869,7 +869,7 @@ void kcov_remote_start(u64 handle)
>                 size = CONFIG_KCOV_IRQ_AREA_SIZE;
>                 area = this_cpu_ptr(&kcov_percpu_data)->irq_area;
>         }
> -       spin_unlock_irqrestore(&kcov_remote_lock, flags);
> +       raw_spin_unlock_irqrestore(&kcov_remote_lock, flags);
>
>         /* Can only happen when in_task(). */
>         if (!area) {
> @@ -1008,9 +1008,9 @@ void kcov_remote_stop(void)
>         spin_unlock(&kcov->lock);
>
>         if (in_task()) {
> -               spin_lock(&kcov_remote_lock);
> +               raw_spin_lock(&kcov_remote_lock);
>                 kcov_remote_area_put(area, size);
> -               spin_unlock(&kcov_remote_lock);
> +               raw_spin_unlock(&kcov_remote_lock);
>         }
>
>         local_irq_restore(flags);
> --
> 2.31.1
>
>
>
> --
> The United States Coast Guard
> Ruining Natural Selection since 1790
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210809155909.333073de%40theseus.lan.
