Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF5132A7AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578988AbhCBQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:27:45 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:39456 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbhCBNzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:55:45 -0500
Received: by mail-vs1-f45.google.com with SMTP id p123so10609819vsp.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NodHc+ppHnADqI80/mzY0P9af63xy9kx4iRweKeW5Ww=;
        b=OJwIv7H0QYm8d+fS4HAB8g2olDd7jkYsdRQZNHjtKJwdfqYT++GOrEjgeGCUTlPOo3
         zKC9omaeFH0EooruSVe62D4paraXqh+K9Q1AasY8TTBBt4fpU7j22sovRFQAyWEn+fUr
         UR909VfHE0NtW+hL1AFmFGhmz+kn6vFTbMXIC5MhoOo1Owr+lIP+6r/2jVMntkXrO1VI
         fR4YoaRMfxg6yfMaTb0OVL1fhT0peh6bb7c2z/L89A4dsz8XfSH/P0BU8kyYmgS3uHN0
         KYAyLKrHoT6U5rwJ/XpW+wX6qIEBViDE0i5t+09S/n+aP/Lurk/IL8wHdlct4rbwIRQd
         rzSw==
X-Gm-Message-State: AOAM533cLXQyLXgEn+I4lK2YA074oCPnR48Af8oQm5eSjBjMQsOgBSJO
        mTNRR4GuJx0JUNFSwyfyiZbetQN+XY0Hl9bO/Xo=
X-Google-Smtp-Source: ABdhPJyF2o1l58F5DCYuIcNYP+vMLUw/V+ZRP7USrXnmhzozyARD61djgeLy6Q7+OSe1S1/qEIlJUhlYvwoRHYTcJQo=
X-Received: by 2002:a67:f247:: with SMTP id y7mr2134422vsm.42.1614693297493;
 Tue, 02 Mar 2021 05:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20210225202438.28985-1-john.ogness@linutronix.de> <20210225202438.28985-8-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-8-john.ogness@linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 14:54:45 +0100
Message-ID: <CAMuHMdWDPjU1q6QnBJ2D7k4pt2XZyGMbKJuifTOb8SJB1uio7Q@mail.gmail.com>
Subject: Re: [PATCH next v3 07/15] printk: introduce CONSOLE_LOG_MAX for
 improved multi-line support
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Feb 25, 2021 at 9:30 PM John Ogness <john.ogness@linutronix.de> wrote:
> Instead of using "LOG_LINE_MAX + PREFIX_MAX" for temporary buffer
> sizes, introduce CONSOLE_LOG_MAX. This represents the maximum size
> that is allowed to be printed to the console for a single record.
>
> Rather than setting CONSOLE_LOG_MAX to "LOG_LINE_MAX + PREFIX_MAX"
> (1024), increase it to 4096. With a larger buffer size, multi-line
> records that are nearly LOG_LINE_MAX in length will have a better
> chance of being fully printed. (When formatting a record for the
> console, each line of a multi-line record is prepended with a copy
> of the prefix.)
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks for your patch!

This increases kernel size by more than 3 KiB, which affects small
devices (e.g. SoCs with 10 MiB of SRAM inside).
Who is printing such long lines to the console?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
