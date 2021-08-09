Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A973E4592
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhHIM0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:26:08 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:37842 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhHIM0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:26:07 -0400
Received: by mail-vs1-f50.google.com with SMTP id a8so9902867vsl.4;
        Mon, 09 Aug 2021 05:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ed39ptxorz+Qljsxnohhxm3EV/HpSyRjPApFZHxB40o=;
        b=B/hD5a8YgN6LstwIER4usmVmsmkM4HNzlSkx480eR5w3a8QbhLJimTFngwXcjtTu8w
         nrmGt1TEdugbd7iSNl9VpYOyxEuRhOV9WcXB+zSSb0h4ftHCK0nJykpaNgSLLJbAAJZe
         zkATBTf6VquDAWnji4eLf3AgcmFgKUcBVAKvXrcEzuSyl14twO/WAjsRthBuZoOS5o8q
         ceH2cc2kGt9HQj4J8Jkz+bYz5QhizKFj990VZnYL7JQHdggQky3ut2clZcM3+/rJAvmD
         HlFU9NvDgPj5k55VQTbwAP4DYJqN1ywYXoVSBfqUyjnuNYJzjWFhJNWU6jEZAX8VMyaQ
         +TzA==
X-Gm-Message-State: AOAM533u0VopxgFskEOi16zKvhsGW/PjHJyeWrnarfKW0/AGT2RnzP7W
        TbOtQHda+A+DglZ/q/U7pLNSNDfkYXzdZEDhH18=
X-Google-Smtp-Source: ABdhPJxpxyQer/sCCyRp98MCHfnWPm0Avf2x2XZw5lVHvn4En6dF2B1WMF2ZTfcMHDtY6fmj58UK8SBwbA8++u6/RyI=
X-Received: by 2002:a67:e2c7:: with SMTP id i7mr15546365vsm.3.1628511946682;
 Mon, 09 Aug 2021 05:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <YQ1ToK8EMdAO4CyH@precision>
In-Reply-To: <YQ1ToK8EMdAO4CyH@precision>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 14:25:35 +0200
Message-ID: <CAMuHMdUzeN54PtKXQxJ0SDtrWSUMFHbae2a66iD7i075Ls1Y6A@mail.gmail.com>
Subject: Re: [PATCH v2] rbtree: remove unneeded explicit alignment in struct rb_node
To:     Mete Polat <metepolat2000@gmail.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jesper Nilsson <jesper@jni.nu>, Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mete,

On Fri, Aug 6, 2021 at 5:22 PM Mete Polat <metepolat2000@gmail.com> wrote:
> Commit e977145aeaad ("[RBTREE] Add explicit alignment to sizeof(long) for
> struct rb_node.") adds an explicit alignment to the struct rb_node due to
> some speciality of the CRIS architecture.
>
> The support for the CRIS architecture was removed with commit c690eddc2f3b
> ("CRIS: Drop support for the CRIS port")
>
> So, remove this now unneeded explicit alignment in struct rb_node as well.
>
> This basically reverts commit e977145aeaad ("[RBTREE] Add explicit
> alignment to sizeof(long) for struct rb_node.").
>
> The rbtree node color is stored in the LSB of '__rb_parent_color'.
> Only mask the first bit in '__rb_parent()', otherwise it modifies the
> node's parent address on m68k.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Mete Polat <metepolat2000@gmail.com>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Mete Polat <metepolat2000@gmail.com>
> ---
> I have tested it on x86, but not on m68k. Can you ack that Geert?

Unfortunately not.  Just booting on ARAnyM gives:

Unable to handle kernel access at virtual address 84abc227
Oops: 00000000
Modules linked in:
PC: [<b45b0005>] 0xb45b0005
SR: 2700  SP: fc24ede1  a2: 01322b40
d0: b45aff7c    d1: 00002708    d2: 00000000    d3: 0033a6a4
d4: 00000005    d5: 95847357    a0: b45b0005    a1: 000f4240
Process sh (pid: 402, task=672891a8)
Frame format=7 eff addr=b45b0005 ssw=0546 faddr=b45b0005
wb 1 stat/addr/data: 0000 00000000 00000000
wb 2 stat/addr/data: 0000 00000000 00000000
wb 3 stat/addr/data: 0000 b45b0005 00000000
push data: 00000000 00000000 00000000 00000000
Stack from 0131debc:
        0004ddf4 0122e0a4 0122e0a4 00477c26 00000000 00000000 00000005 95847357
        00002708 0004558e 0033ab30 00000002 01003180 0047273c 0131df88 0033a6a4
        00477c3a 00477c24 0004dfee 00000005 95847357 00002708 0000000f 00000001
        9915a000 0000000d 0004d430 01322b40 00000001 00002604 00000000 00006e50
        00000001 00000000 0004560c 0000000d 00000000 00000000 efc3aa78 efc3aa78
        c0158c0c 8009ff68 0047273c efc3aa64 c01537a8 0131df8c 000456b6 0047273c
Call Trace: [<0004ddf4>] __hrtimer_run_queues.constprop.0+0xba/0x144
 [<00002708>] calibrate_delay+0xd6/0x18a
 [<0004558e>] __irq_wake_thread+0x0/0x40
 [<0033ab30>] printk+0x0/0x18
 [<0033a6a4>] warn_slowpath_fmt+0x0/0x62
 [<0004dfee>] hrtimer_run_queues+0xb4/0xc0
 [<00002708>] calibrate_delay+0xd6/0x18a
 [<0004d430>] update_process_times+0x38/0x8c
 [<00002604>] wait_for_initramfs+0x30/0x58
 [<00006e50>] mfp_timer_c_handler+0x2c/0x3c
 [<0004560c>] __handle_irq_event_percpu+0x3e/0xcc
 [<000456b6>] handle_irq_event_percpu+0x1c/0x52
 [<0004570a>] handle_irq_event+0x1e/0x30
 [<00047aa2>] handle_simple_irq+0x4a/0x4e
 [<00045062>] handle_irq_desc+0x1e/0x28
 [<00002cac>] do_IRQ+0x20/0x32
 [<00002bcc>] user_irqvec_fixup+0xc/0x14
 [<0010c00b>] mb_cache_create+0x47/0xdc

Code: dde0 dde0 dde0 dde0 dde0 dde0 dde0 dde0 Bad PC value.
Disabling lock debugging due to kernel taint
Kernel panic - not syncing: Aiee, killing interrupt handler!
---[ end Kernel panic - not syncing: Aiee, killing interrupt handler! ]---

> --- a/include/linux/rbtree.h
> +++ b/include/linux/rbtree.h
> @@ -25,8 +25,7 @@ struct rb_node {
>         unsigned long  __rb_parent_color;
>         struct rb_node *rb_right;
>         struct rb_node *rb_left;
> -} __attribute__((aligned(sizeof(long))));
> -    /* The alignment might seem pointless, but allegedly CRIS needs it */
> +};
>
>  struct rb_root {
>         struct rb_node *rb_node;
> diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
> index d1c53e9d8c75..94b6a0f4499e 100644
> --- a/include/linux/rbtree_augmented.h
> +++ b/include/linux/rbtree_augmented.h
> @@ -145,7 +145,7 @@ RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,                                            \
>  #define        RB_RED          0
>  #define        RB_BLACK        1
>
> -#define __rb_parent(pc)    ((struct rb_node *)(pc & ~3))
> +#define __rb_parent(pc)    ((struct rb_node *)(pc & ~1))

Are you sure you can do this, i.e. that nothing else relies on the
alignment to (at least) 4 bytes?

There is another definition of rb_parent().  If I make a similar change there:

--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -31,7 +31,7 @@ struct rb_root {
        struct rb_node *rb_node;
 };

-#define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
+#define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~1))

 #define RB_ROOT        (struct rb_root) { NULL, }
 #define        rb_entry(ptr, type, member) container_of(ptr, type, member)

the system boots on ARAnyM, but I prefer to be a bit cautious...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
