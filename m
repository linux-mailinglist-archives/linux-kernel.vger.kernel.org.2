Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F638E7C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhEXNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhEXNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:40:08 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3E2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:38:39 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id j184so4919384qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KU38ADsfY+OVhk0Wa3ifSJILAZg0R95ihYDi7tDSXA=;
        b=oGSH3zbCSZLCt6nOeZDNaRaVnYntQ0tBC7rCgPHqsU6fufgcRxfxsCY59Rf24FkJfy
         OmnxTY3KqaptIPh7WgP3SQnjYOkYal6+OEe5boHlErSKF8E47XjnFoAifhtHhqabbFg2
         u54sn5bzuV2tvawREj+uwfTdY2b+uPohfIZXDuRpaGwgCbdp/AaP5/G/37PG6mdfSjcl
         yT5+X/1yobT/k5OQvSBF3nQVuLD4Z4NZ2+JuXOjR5IJmKxCJUokqdM3iGmmosLr/BJHz
         4Ufqe11wew1Acqw07VCLgtgP8Y2noWygHMj669M/XWQYAlnnK+XLgfkcnl3s6DpGrfqi
         XFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KU38ADsfY+OVhk0Wa3ifSJILAZg0R95ihYDi7tDSXA=;
        b=kaGQkTMtzV96Z3/bwOr9EOj0GcDVpoKyd3LsH02Y/d9c4v44qpqRV9mqfaRlIIdLKN
         54FEeF0spteZGpbhLPXqBeWgOZEnSJUXjIRJI9MQMy7SpFb7vIcZUEmZ6daqp5Gv1yGX
         82vRfyr5ft0Y3ValL+LmqDP1vcNzMq2tFKgeflwPJbLiLqh+JG0a/OtvRxobY4i3dHeR
         prS1WT2eeKVHZ3qaNbtnEjMB8ZnCtZAcBDatvs/XnJB28wCu60G3FFUs8rzGV7fsGnWo
         AU23i/I1Yl3jKTcq+xQ08KK3LKXmlReFcqOhXQGoWyXyYHQqwWHp3TqjfcOghZHosn9o
         Spvw==
X-Gm-Message-State: AOAM531CxkpQRYIdOhOZHo6pbdEpchcp0DXEWqy2Q2Y+bvagFa81cZKB
        BKD7IJ0pgraO2OjX6oLE6OIW58IV5H983G4JRQI=
X-Google-Smtp-Source: ABdhPJyq0idQZt4cF3FmgMXO4FbmuOWMbQ3vAiWKHB1+RrqM/b57WyzYgfkpd4fA9aLSPm0sMTBzbewvk44PDmABORU=
X-Received: by 2002:a05:620a:886:: with SMTP id b6mr6714557qka.327.1621863518957;
 Mon, 24 May 2021 06:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <4d84b06ee9e8dad88ff101de5e7b78b9b09cfee3.camel@fifi.org> <20210524075121.1949-1-hdanton@sina.com>
In-Reply-To: <20210524075121.1949-1-hdanton@sina.com>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Mon, 24 May 2021 14:38:12 +0100
Message-ID: <CAM0jSHOWwgPRWkSN22r6T_rkiVcdhYwN34vkzp0q_icgDqT52Q@mail.gmail.com>
Subject: Re: [Intel-gfx] Bug: 5.12.5 - list_add double add at __i915_gem_object_make_shrinkable+0xa6/0xe0
To:     Hillf Danton <hdanton@sina.com>
Cc:     Philippe Troin <phil@fifi.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 at 13:05, Hillf Danton <hdanton@sina.com> wrote:
>
> On Sun, 23 May 2021 12:47:34 -0700 Philippe Troin wrote:
> > Found the following bug on a FUJITSU LIFEBOOK S6520.
> >
> > The kernel crash happens when selecting a user from the gdm login
> > screen right after boot.
> > The same hardware has no problems with 5.11.21.

The trace looks similar to something that was fixed in 8777d17b68dc
("drm/i915/gem: Pin the L-shape quirked object as unshrinkable") which
should now be in drm-tip. Could you try that? Otherwise could you
please file a new bug report at
https://gitlab.freedesktop.org/drm/intel/?

> >
> > OOPS:
> >    list_add double add: new=ffff8e785604c620, prev=ffff8e785604c620, next=ffff8e784d105b38.
> >    ------------[ cut here ]------------
> >    kernel BUG at lib/list_debug.c:29!
> >    invalid opcode: 0000 [#1] SMP PTI
> >    CPU: 0 PID: 1498 Comm: gnome-shell Not tainted 5.12.5-200.fc33.x86_64 #1
> >    Hardware name: FUJITSU LIFEBOOK S6520/FJNB1E6, BIOS Version 1.31  09/09/2009
> >    RIP: 0010:__list_add_valid.cold+0x26/0x3f
> >    Code: d8 77 a6 ff 4c 89 c1 48 c7 c7 10 52 41 b8 e8 7f 2c fe ff 0f 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 c0 52 41 b8 e8 68 2c fe ff <0f> 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 68 52 41 b8 e8 51 2c fe
> >    RSP: 0018:ffffb84100ebfcf8 EFLAGS: 00010082
> >    RAX: 0000000000000058 RBX: ffff8e785604c340 RCX: 0000000000000000
> >    RDX: ffff8e787bc26720 RSI: ffff8e787bc185c0 RDI: ffff8e787bc185c0
> >    RBP: ffff8e784d105b38 R08: 0000000000000000 R09: ffffb84100ebfb30
> >    R10: ffffb84100ebfb28 R11: ffffffffb8b45f28 R12: ffff8e784d100000
> >    R13: 0000000000000246 R14: ffff8e784d105b20 R15: ffff8e785604c620
> >    FS:  00007fa65ebf6d40(0000) GS:ffff8e787bc00000(0000) knlGS:0000000000000000
> >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    CR2: 00007fa638311a10 CR3: 00000001162d0000 CR4: 00000000000006f0
> >    Call Trace:
> >     __i915_gem_object_make_shrinkable+0xa6/0xe0 [i915]
> >     i915_gem_object_set_tiling+0x4fe/0x530 [i915]
> >     ? i915_gem_object_make_unshrinkable+0x75/0xd0 [i915]
> >     i915_gem_set_tiling_ioctl+0x148/0x230 [i915]
> >     ? i915_gem_object_set_tiling+0x530/0x530 [i915]
> >     drm_ioctl_kernel+0x86/0xd0 [drm]
> >     drm_ioctl+0x20f/0x3a0 [drm]
> >     ? i915_gem_object_set_tiling+0x530/0x530 [i915]
> >     ? handle_mm_fault+0xd5/0x2b0
> >     __x64_sys_ioctl+0x83/0xb0
> >     do_syscall_64+0x33/0x40
> >     entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Update shrink_pin under lock to cut chance for races.
> If it is a cure then atomic_t will be dropped.
>
> +++ x/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
> @@ -435,6 +435,7 @@ void i915_gem_object_make_unshrinkable(s
>  {
>         struct drm_i915_private *i915 = obj_to_i915(obj);
>         unsigned long flags;
> +       int pin;
>
>         /*
>          * We can only be called while the pages are pinned or when
> @@ -442,12 +443,10 @@ void i915_gem_object_make_unshrinkable(s
>          * from a single caller under controlled conditions; and on release
>          * only one caller may release us. Neither the two may cross.
>          */
> -       if (atomic_add_unless(&obj->mm.shrink_pin, 1, 0))
> -               return;
> -
>         spin_lock_irqsave(&i915->mm.obj_lock, flags);
> -       if (!atomic_fetch_inc(&obj->mm.shrink_pin) &&
> -           !list_empty(&obj->mm.link)) {
> +       pin = atomic_read(&obj->mm.shrink_pin);
> +       atomic_inc(&obj->mm.shrink_pin);
> +       if (!pin && !list_empty(&obj->mm.link)) {
>                 list_del_init(&obj->mm.link);
>                 i915->mm.shrink_count--;
>                 i915->mm.shrink_memory -= obj->base.size;
> @@ -460,23 +459,23 @@ static void __i915_gem_object_make_shrin
>  {
>         struct drm_i915_private *i915 = obj_to_i915(obj);
>         unsigned long flags;
> +       int pin;
>
>         GEM_BUG_ON(!i915_gem_object_has_pages(obj));
>         if (!i915_gem_object_is_shrinkable(obj))
>                 return;
>
> -       if (atomic_add_unless(&obj->mm.shrink_pin, -1, 1))
> -               return;
> -
>         spin_lock_irqsave(&i915->mm.obj_lock, flags);
>         GEM_BUG_ON(!kref_read(&obj->base.refcount));
> -       if (atomic_dec_and_test(&obj->mm.shrink_pin)) {
> +
> +       pin = atomic_read(&obj->mm.shrink_pin);
> +       atomic_dec(&obj->mm.shrink_pin);
> +       if (pin == 1) {
>                 GEM_BUG_ON(!list_empty(&obj->mm.link));
>
>                 list_add_tail(&obj->mm.link, head);
>                 i915->mm.shrink_count++;
>                 i915->mm.shrink_memory += obj->base.size;
> -
>         }
>         spin_unlock_irqrestore(&i915->mm.obj_lock, flags);
>  }
> --
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
