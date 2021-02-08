Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EB2312C98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBHI5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBHIuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:50:54 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF24C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 00:50:06 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o21so8355449pgn.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 00:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1xI4q0IE2/j0OhMlMQaNaEB2C3eai/3ilfN5as2bkI=;
        b=AmXB/wQGRiK3d99p7ZqecuAVIoY/NYtbjqdxLM45I0xvZFDqOq6okJViFw4fL25lzx
         /3+oaO2H9I+DV4uRL6791x2bBHUIfkVeutqfIjIZno6PdggR3UfYQ2oWpF6K5Q735igh
         JNJQ96FoCQegwf97V0xZRvZ4LshyQ4TvTODl45y+fVuO+3JTsfNrAbXAkdYiIDtNIf17
         yrOEtZ/1Dn4UT0OG4sBDKrg3FF1ZGfSBye5Z4fZuji1Gt7zFbaef3AoaMP8KkaVOB0CG
         bJ2BOvavQocyhiHsS0gMD8WIgmyws/XvWkHiqnpdSpVW3Z7WyyLANbB+4dWM6nwAHg3g
         8X6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1xI4q0IE2/j0OhMlMQaNaEB2C3eai/3ilfN5as2bkI=;
        b=e08QvnNwMa0LHWru+FjZauSnz+eliEGbs0Q8SNlqJ3bPIpsRQUtnFMA9QHyOaD1ctH
         MMHkzFfk+4kMvFphw39ZvTnlAqWckM+znP8v7I1TQmI46UI7HlmSpLd5+w0z0sbAej8u
         ByNVaE1aSNNuEW2kWPWXZ6LaK9e4AMYpjXKKNEJGLf6XwwlZyWh5xbhY5bVlP94FBgLm
         nf/ZimpH5OvGXjrmKOdBv3ffoOFyr80dnaDZPYNzib2eVctMXjt7eWRVnMeZNecW5jmc
         8KdtHRbvufgDrUtiEDWEuW6X2Hco5lhyANrjhuRyDp7krw/YuVwceFDWu8XbsHAVF8VV
         EGmQ==
X-Gm-Message-State: AOAM5328+nKnJa1gGCaCMeJlh8I14ecULUYRK0LECVeaNN7IGfxTg1wO
        mOuULo84EtWrCbrptrt5yrV/fWybV2PWqYtLo71QXPUg5/1TkA==
X-Google-Smtp-Source: ABdhPJwMXTG7wUByi8LwP7JK3r2w8sXxWp8sWUXgkbnHyaZZL6qaLocaRydhrH/zDgosmHKgHRtZcC2kpZE984W53ak=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr16552090pgf.31.1612774205691;
 Mon, 08 Feb 2021 00:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20210206054124.6743-1-songmuchun@bytedance.com> <YCDcAy39BbPItdGY@jagdpanzerIV.localdomain>
In-Reply-To: <YCDcAy39BbPItdGY@jagdpanzerIV.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 8 Feb 2021 16:49:28 +0800
Message-ID: <CAMZfGtVBVSuH=HGNs7KFOtixSviy_stoZsiG4au0RUkUnH-0rQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] printk: fix deadlock when kernel panic
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        john.ogness@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 2:38 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (21/02/06 13:41), Muchun Song wrote:
> > We found a deadlock bug on our server when the kernel panic. It can be
> > described in the following diagram.
> >
> > CPU0:                                         CPU1:
> > panic                                         rcu_dump_cpu_stacks
> >   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
> >     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
> >                                                     __printk_safe_flush
> >                                                       raw_spin_lock_irqsave(&read_lock)
> >     // send NMI to other processors
> >     apic_send_IPI_allbutself(NMI_VECTOR)
> >                                                         // NMI interrupt, dead loop
> >                                                         crash_nmi_callback
>
> At what point does this decrement num_online_cpus()? Any chance that
> panic CPU can apic_send_IPI_allbutself() and printk_safe_flush_on_panic()
> before num_online_cpus() becomes 1?

I took a closer look at the code. IIUC, It seems that there is no point
which decreases num_online_cpus.

>
> >   printk_safe_flush_on_panic
> >     printk_safe_flush
> >       __printk_safe_flush
> >         // deadlock
> >         raw_spin_lock_irqsave(&read_lock)
>
>         -ss
