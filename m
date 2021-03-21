Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77C834340F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCUS32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:29:28 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:35823 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCUS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:28:56 -0400
Received: by mail-vk1-f170.google.com with SMTP id k27so3309824vki.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 11:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lhuT6VdkKzkIGzdx6zcIj86PDRMbDa/uG9jZA7i7/0=;
        b=lKqDPXtGtDJBGVc2FZUb+mGyoiMMp8MC5PIQ9QNavqZCDyp8p62RoEjJRpftahF5oJ
         45lNhfGYfOj2yHtW1IoFf7Zq7OjhnuMXgLm48ELNfKSgtS/YEl3DN88YHx8/lxDRNkfp
         YitsYUi8iS6eqsAqzDxTOsMhRlwbOkVG09ZzsnrTCg+v4rkgd5bI9+HhPCPI/RmQJUYV
         nmDAJyJlOII0EZSSS5R0zNP0lVFVbkXBkNqR/lChTxDvJULrLXKdjsO+ND5mYfMNAKT8
         UWUMFdCp5IzQ6BjxyVvGwDx1KIY5qInNQkcRFeqXtKbhoNiMDQcZA2/IdObUWDjAeatQ
         SkoA==
X-Gm-Message-State: AOAM530pvTdyHZe8+C8H4pWJv4XiogLiefnhFws/0BhR0fu7K9z0D1pm
        pRFakXn9V9bJ0WM+NCX4vMDgLvi428uPvTzdToM=
X-Google-Smtp-Source: ABdhPJwmDYa9XaBXq0+/BUZ8GiS6FGcfahlU3diBKnATeoBrp4D4xJNj20TVlvlFDSK5vp3FSdu1WzRo8OHS6Jpd8Nw=
X-Received: by 2002:a1f:b689:: with SMTP id g131mr7054099vkf.6.1616351335668;
 Sun, 21 Mar 2021 11:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210320001518.93149-1-julianbraha@gmail.com>
In-Reply-To: <20210320001518.93149-1-julianbraha@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 21 Mar 2021 19:28:43 +0100
Message-ID: <CAMuHMdW1YVmKd4+MJEZvpF0iovP3b8ukh4ExpFdDUR6+UXf6WQ@mail.gmail.com>
Subject: Re: [PATCH] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

On Sat, Mar 20, 2021 at 1:17 AM Julian Braha <julianbraha@gmail.com> wrote:
> When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
> is disabled, Kbuild gives the following warning:
>
> WARNING: unmet direct dependencies detected for FRAME_POINTER
>   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
>   Selected by [y]:
>   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
>
> This is because LATENCYTOP selects FRAME_POINTER,
> without selecting or depending on ARCH_WANT_FRAME_POINTERS,
> despite FRAME_POINTER depending on ARCH_WANT_FRAME_POINTERS.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Thanks for your patch!

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1675,6 +1675,7 @@ config LATENCYTOP
>         depends on DEBUG_KERNEL
>         depends on STACKTRACE_SUPPORT
>         depends on PROC_FS
> +       select ARCH_WANT_FRAME_POINTERS if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86

ARCH_WANT_FRAME_POINTERS is a symbol that is only to be selected by
architecture-specific configuration, and must not be overridden:

    # Select this config option from the architecture Kconfig, if it
    # is preferred to always offer frame pointers as a config
    # option on the architecture (regardless of KERNEL_DEBUG):

Probably this should be turned into a depends instead?

>         select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
>         select KALLSYMS
>         select KALLSYMS_ALL
> --
> 2.25.1
>


-- 
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
