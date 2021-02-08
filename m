Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47B8314302
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 23:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhBHWaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 17:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhBHW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 17:27:50 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD18C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 14:27:08 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v123so16139450yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 14:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkZsb5s50/kNVK8WJvqgfsXRSHjz/Pyiz90u61r8SDM=;
        b=HQczGpwQqPz/AP89uLzJ6xIOsFUgDGYckMhlsTqCVXb9xe9POKG6WdejHBT1MkEm1Y
         hywsRfogDWZj4jEbOUoIPeG236suzAfVJ3p/sgZ+0bs+Z1hQhSocqJo7Yb6Iu5W+z91K
         OkhMmo4TGoEAzi57HbiNDKZo7YUd9DhLiLi34fkCX/RDMnVBab2Zq0lOwg22QZe9g972
         Z6LxOIHVKAC2NOg+FOs0cTTCalpdHzR+enJrGUd2+6yMieUcpK0ZKeDO7/+/RteYE4vm
         8HoxtAZZfmjO28EUguOQW1OpfEAdykx5TOuPaqXBIomJ4HXLmOKiYvj1Ul3Evj2ZzoUD
         g4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkZsb5s50/kNVK8WJvqgfsXRSHjz/Pyiz90u61r8SDM=;
        b=Fc+Hp7Jse2tSf1hi93GyphAoJlhY93OR+IoYj4Yl7Ij7YlyJGdI+q/07NJZh5Gvo+Y
         QIGwMyNHwyqH7w+WRyI5UF+3yyPxsgnO19aAMC8iqcAGvMq3CmS4GIbf7LnuQvL/jk6k
         xi5wp7GlKj49b4TfMQJD1Sf1T3HoEtXYVOngL19fbubc5DX9UYSkzYYUxwUXP4AQntgK
         omAz6caenJsFPx51oUrW+PcDnwxcaUhUCVaJcx8C64piKnerPV8KJSIzBotr0HNlG6UB
         blfSn44VqCAqlsPwmaezs3VV/woVmIjWuhTW//u1p9KvShzTlKlvthztwBqTlrTay6JU
         V2eQ==
X-Gm-Message-State: AOAM530vtQg17N7mjXs88VIFEuVOazC1gpb8TPuUfwgEeEDwsBKrUbEN
        xuZZOOFwtey70/cK2i4G72c2jJuQiXugmd8FpWVfaCqUeGSSOQ==
X-Google-Smtp-Source: ABdhPJzg9NK9sJMLbD+SuCm5x2nq98ymnXfQi+Fl2xmhMMcKBM0Dzw16l/250FbI9p2idy31fZ58sUVBeAwjyvx7A1o=
X-Received: by 2002:a25:d296:: with SMTP id j144mr15645644ybg.33.1612823228194;
 Mon, 08 Feb 2021 14:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
 <20210208190735.ibq44r5pc4cwzt7j@linutronix.de> <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
 <20210208204136.sv4omzms3nadse6e@linutronix.de>
In-Reply-To: <20210208204136.sv4omzms3nadse6e@linutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 8 Feb 2021 23:26:57 +0100
Message-ID: <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
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

On Mon, Feb 8, 2021 at 9:41 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> It hurts to keep in_interrupt() because it is desired to have it removed
> from drivers. The problem is that pattern is often copied and people
> sometimes get it wrong. For instance, the code here invoked schedule()
> based on in_interrupt(). It did not check whether or not the interrupts
> are disabled which is also important. It may work now, it can break in
> future if an unrelated change is made. An example is commit
>    c2d0f1a65ab9f ("scsi: libsas: Introduce a _gfp() variant of event notifiers")
>    https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git/commit/?id=c2d0f1a65ab9f
>
> in_interrupt() is often used in old code that was written before
> might_sleep() and lockdep was introduced.

Thanks -- can you please add a Link: tag to a lore URL or the docs or
similar where more information can be found regarding the
proposal/discussion for removing `in_interrurt()` etc.? It is useful
to track why these things are happening around the kernel.

Also, `hacking.rst` (and related documentation) should be updated
before this is done, so that we can link to it.

> What I meant was GFP_KERNEL for context which can sleep vs GFP_ATOMIC for
> context which must not sleep. The commit above also eliminates the
> in_interrupt() usage within the driver (in multiple steps).

I was thinking something along those lines, but `in_interrupt()` nor
`cond_resched()` take an explicit context either, so I am confused.
Does `cond_reched()` always do the right thing regardless of context?
The docs are not really clear:

  "cond_resched() and cond_resched_lock(): latency reduction via
explicit rescheduling in places that are safe."

It could be read as "it will only resched whenever safe" or "only to
be called if it is safe".

Cheers,
Miguel
