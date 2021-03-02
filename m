Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5A332A877
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349946AbhCBRhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:37:52 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:34553 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384488AbhCBPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:20 -0500
Received: by mail-pj1-f51.google.com with SMTP id d13-20020a17090abf8db02900c0590648b1so1343042pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRAetBTkgykvfoqIy3pg1P7neDtz9XjrxvIOfomr2iE=;
        b=EQ5ZRgDxjYIxzu827MZKBHH4R1D/gHKEUw2UsAenfJUDyr84TMmMlmWGbRmY1rBbSM
         CXMNg1Hwou4vliFj3RRXA5+Xw2u67n3pp1X7x3/dn2bhY19T65jkqMVoLDXqKkuqtc8X
         Io/23UqXXMJOnne2LCdIJ/PHpvJPy8w1iASVYCacKbx/fP0TMszh5DiKL0lRPiBL8sVa
         wSQIEfqEsLku7WKsulQGAJ8Lm077BVj7ByfHdyf+GDPx6ANp+I+5GCtgKShabs9oxBLx
         ZVM4ynbli8D5WSn7fNBbn9N+y56aOSVu34AErkYBqEmuSopFTxmTljppwawCHoVgy137
         5+6A==
X-Gm-Message-State: AOAM532EB/PxGXu4XNjjyV1aeHeVQJfuKQ4kZGGeuo13+knmtXIzpF8W
        txcrlzGXdXUejRauCMOfixeOLiH2UjfmjnQTkzn9ZqVl
X-Google-Smtp-Source: ABdhPJxmgZjMeq8ZF9cC2RAcBFoT2b20c+7frnXPV6wXTWDKFngJaglGcqPatGSZQvMH2KLigH38l3aTKRG7ZIFxhdU=
X-Received: by 2002:a05:6102:2403:: with SMTP id j3mr1976157vsi.40.1614693519166;
 Tue, 02 Mar 2021 05:58:39 -0800 (PST)
MIME-Version: 1.0
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-8-john.ogness@linutronix.de> <CAMuHMdWDPjU1q6QnBJ2D7k4pt2XZyGMbKJuifTOb8SJB1uio7Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWDPjU1q6QnBJ2D7k4pt2XZyGMbKJuifTOb8SJB1uio7Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 14:58:28 +0100
Message-ID: <CAMuHMdWCM4MLkwRZTZU2Sne3gEvjBT9gowLUKLJbTAYh5gb1wg@mail.gmail.com>
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

On Tue, Mar 2, 2021 at 2:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Feb 25, 2021 at 9:30 PM John Ogness <john.ogness@linutronix.de> wrote:
> > Instead of using "LOG_LINE_MAX + PREFIX_MAX" for temporary buffer
> > sizes, introduce CONSOLE_LOG_MAX. This represents the maximum size
> > that is allowed to be printed to the console for a single record.
> >
> > Rather than setting CONSOLE_LOG_MAX to "LOG_LINE_MAX + PREFIX_MAX"
> > (1024), increase it to 4096. With a larger buffer size, multi-line
> > records that are nearly LOG_LINE_MAX in length will have a better
> > chance of being fully printed. (When formatting a record for the
> > console, each line of a multi-line record is prepended with a copy
> > of the prefix.)
> >
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Thanks for your patch!
>
> This increases kernel size by more than 3 KiB, which affects small
> devices (e.g. SoCs with 10 MiB of SRAM inside).
> Who is printing such long lines to the console?

BTW, printing a single line of 1024 characters to a serial console at
115200 bps takes almost 100 ms.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
