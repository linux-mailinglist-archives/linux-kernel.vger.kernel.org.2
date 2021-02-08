Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB77314003
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhBHULZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbhBHSjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:39:02 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1323C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 10:38:21 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v123so15514876yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZCGf87TVUgdkojVDxKZx0J3zFOqmM5xnE7pmee19zU=;
        b=CtKsNaLogxgGWiCSlBv3jckSAYMrfX/p2HXv41NOaXwgZDsQADjABhhVkdq8inXMGr
         PkS1mUoAZh+c5HyG4OBJYRLN38RChVFNl1eLIgInlXOcbriEbxHg8ZzKJhW/nhWUa6Cu
         399wTbKBr8XWdYMa9UFuN3Op3fKr8ur+BCzHKWxtxPWp0Me5cV87DXHkSjnFrDxG6ltW
         ZsZnbdywwjL4rhiCP/amjB1ndGRlmobHYPEvQIrHP0QX23+Kr9xe34qRv+xbDjFgVbLx
         3aIrJ+AahcdmC7vSezNK7NciPIilmQyWLvd80fhaFLJbFcUK2fjYarR6IO1tOgtUbob0
         1uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZCGf87TVUgdkojVDxKZx0J3zFOqmM5xnE7pmee19zU=;
        b=o2+wd6XVi7UpuV+OZL2NYeAXJKYtP4QSifYu732bLR8BJlb8xnJ5TkVkBJDygVVbbn
         AFu6J99XuD2XGvRTqV2f/xIidVZQJOVZSgJYajQHf2m2Drozmw1xtXQJ+vE0sI9IEeWA
         EswZmWr9reMzV588THnLpqiHMyCgm39YLJjZoqAedtIR4YkxGOQU3ZAwIE3Aacg3+L6+
         RJeCW+C8oad15IGv4aRiksnyDaxauK5NwUja4Se6maO/+RBUdGosJ5feh4EsPLb6jP8G
         RXkviPSMsEeQVigHw42JOlL3omO7iXut1T1alrbml3lW8Sd67mdgLWrD84yaQMRshpu9
         o0Qg==
X-Gm-Message-State: AOAM5328zA57/P00m8VIODDP+87R3/15tV/2ggMyBlTKHBMjWP6vlAsQ
        ZCcChRc+KsBE89Bhzy9OND4ofceZVBuBvoKT367tHLvZFO0=
X-Google-Smtp-Source: ABdhPJxTAu5VvVMXyEgK5iVvmoES9QFenuF56bsFqD3PLJRfYHakioFPrH2KxYIsP9Q1Hq6CKuACoYhQGiwrOWt++vw=
X-Received: by 2002:a25:7cc2:: with SMTP id x185mr3881304ybc.422.1612809501347;
 Mon, 08 Feb 2021 10:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20210208175824.381484-1-bigeasy@linutronix.de>
In-Reply-To: <20210208175824.381484-1-bigeasy@linutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 8 Feb 2021 19:38:10 +0100
Message-ID: <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Remove in_interrupt() usage.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Mon, Feb 8, 2021 at 6:59 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> charlcd_write() is invoked as a VFS->write() callback and as such it is
> always invoked from preemptible context and may sleep.
>
> charlcd_puts() is invoked from register/unregister callback which is
> preemtible. The reboot notifier callback is also invoked from

preemtible -> preemptible

> preemptible context.
>
> Therefore there is no need to use `in_interrupt()' to figure out if it
> is save to sleep because it always is.

save -> safe

Does it hurt to have `in_interrupt()`? Future patches could make it so
that it is no longer a preemptible context. Should it be moved to e.g.
a `WARN_ON()` instead?

> Using `schedule()' to schedule (an be friendly to others) is

an -> and

> discouraged and `cond_resched()' should be used instead.
>
> Remove `in_interrupt()' and use `cond_resched()' to schedule every 32
> iteration if needed.
>
> Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Cc'ing Geert and Willy too.

Thanks for the patch!

Cheers,
Miguel
