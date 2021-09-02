Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C8D3FF1CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbhIBQtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:49:24 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:36590 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346352AbhIBQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:49:14 -0400
Received: by mail-ua1-f42.google.com with SMTP id x23so1263414uav.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhkscD4eQg3gMjYYcjIloMpyH+TEyxkuIO5LmcQoPWs=;
        b=e2m3/R+zLMtyscby1ZWHOaWZgFgy3gBONi2WQYUSRGiszL95j5XdC4YYymOLFOVEUT
         k1QQLtdvCaZgt8EJ7yAK09jNiq5hvc0kusQUrEaepeJhTKTuRGVSHpM6z442qgFF4KOC
         627l1lmi3VUMS0tAUVpkJw/NqU04b9qSKeYPltIOCN6z5KFTPa0z3Z8hhfSgMkCF/x5/
         9b156c29gWEut8YApZmvrbu9Lnx/Gno8R0nc7M0+/2Fg2lWp/eQsIK6UICuZP6sjO6jz
         U5Q/R5onsa4CHcOgMWVdfdPmeSdIRWqtviTloMPuz/HbtJrzndcjHK5mpD1qKL+FVWJe
         dSNQ==
X-Gm-Message-State: AOAM5319zjDYWm5hYcnqlviIrGZ3jF8Dc7NQhISK5c2PaaQRuh4AX1O0
        PGl7l30zncc3xiQqvIAaaTBfhczqw/4XknuTnJldwC6a
X-Google-Smtp-Source: ABdhPJyuhec501quue5johUkVxFJO20CoY6RBbUUFUt2/IiM8feEkGMBc4qTFxABKXXzXDsZOcNKxYozPx3hZ3ZWp0g=
X-Received: by 2002:ab0:4d5b:: with SMTP id k27mr2702126uag.78.1630601295450;
 Thu, 02 Sep 2021 09:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210715193359.25946-1-john.ogness@linutronix.de> <20210715193359.25946-4-john.ogness@linutronix.de>
In-Reply-To: <20210715193359.25946-4-john.ogness@linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Sep 2021 18:48:04 +0200
Message-ID: <CAMuHMdXa-ahzQX2FMb-YZ9Yc4Z=72JpaN8Z9bC5htmyvEDSh+w@mail.gmail.com>
Subject: Re: [PATCH printk v4 3/6] printk: remove safe buffers
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Yue Hu <huyue2@yulong.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Jul 15, 2021 at 9:53 PM John Ogness <john.ogness@linutronix.de> wrote:
> With @logbuf_lock removed, the high level printk functions for
> storing messages are lockless. Messages can be stored from any
> context, so there is no need for the NMI and safe buffers anymore.
> Remove the NMI and safe buffers.
>
> Although the safe buffers are removed, the NMI and safe context
> tracking is still in place. In these contexts, store the message
> immediately but still use irq_work to defer the console printing.
>
> Since printk recursion tracking is in place, safe context tracking
> for most of printk is not needed. Remove it. Only safe context
> tracking relating to the console and console_owner locks is left
> in place. This is because the console and console_owner locks are
> needed for the actual printing.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thank you very much for reducing kernel size by ca. 8 KiB!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
