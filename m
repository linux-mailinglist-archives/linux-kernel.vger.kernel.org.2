Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC234BBB9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhC1Ipo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 04:45:44 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:45921 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhC1IpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 04:45:23 -0400
Received: by mail-vs1-f44.google.com with SMTP id u29so1766794vsi.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 01:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iymNhUT+cpWgp1EHrZNvYnRTH9v3DaMvz7/jWmwfdPc=;
        b=Zh90VJQJyyzPnGYbdgA80dBOUSTsSopkTEPmGMFVhUWHyaK2WhLU/cyUldhYzCZuH3
         3Ou44WuT68620cvDe5cJxagP7DlmmJ/ahU1iuJIIVTqbSZJPc3RvQH9zAq7wsprT+jr6
         ZMHkeVWjD3R+bV+68C2hx5pQ/8+5qQZgIufSMdRpblx+IW+aMQRXYUyFveCTkm2hM37J
         AJhaGVHim6hK2s1laCPuQx7U8ekNww7WcxVXhM9uxZ6EfQy6YdAd30U35uNlPCJFGb+N
         d8jfqWB1t7GN7zGWJcm0drzCISXGrwi2NbZSC/e+JpP/9GjSf1Q1SI1rQ+Y7TtaOL136
         xbpQ==
X-Gm-Message-State: AOAM531BCiUWH9N9X41SSPmAfOxi2bXI58G7C7qxVvMut8a4xDLukt+Q
        XblmmpW23ciW8NapR+DCJLGYYEq0bMAyJxUiBMw=
X-Google-Smtp-Source: ABdhPJxETfYOGyPUNrFlv429r0FCpABL70o/2ZWTluXVm5KhiuSIXf5+/WPm6SEuyAkl9XYVbZDTUT8zIaVl6X79GKk=
X-Received: by 2002:a67:f7c6:: with SMTP id a6mr12257341vsp.42.1616921122297;
 Sun, 28 Mar 2021 01:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210328041359.50149-1-julianbraha@gmail.com>
In-Reply-To: <20210328041359.50149-1-julianbraha@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 28 Mar 2021 10:45:11 +0200
Message-ID: <CAMuHMdXAKuA1GUMjosZUvN6LTDg8rDmYghoJaKyhgrXux=pTZQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

On Sun, Mar 28, 2021 at 6:14 AM Julian Braha <julianbraha@gmail.com> wrote:
> When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
> is disabled, Kbuild gives the following warning:
>
> WARNING: unmet direct dependencies detected for FRAME_POINTER
>   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
>   Selected by [y]:
>   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
>
> Depending on ARCH_WANT_FRAME_POINTERS causes a
> recursive dependency error.
> ARCH_WANT_FRAME_POINTERS is to be selected by the architecture,
> and is not supposed to be overridden by other config options.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Thanks for your patch!

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1665,7 +1665,7 @@ config LATENCYTOP
>         depends on DEBUG_KERNEL
>         depends on STACKTRACE_SUPPORT
>         depends on PROC_FS
> -       select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> +       select FRAME_POINTER if MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86

s/select/depends on/?

>         select KALLSYMS
>         select KALLSYMS_ALL
>         select STACKTRACE

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
