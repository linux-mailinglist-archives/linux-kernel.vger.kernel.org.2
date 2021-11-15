Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3444FF98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhKOIC0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Nov 2021 03:02:26 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:34366 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbhKOICB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:02:01 -0500
Received: by mail-ua1-f43.google.com with SMTP id n6so16464137uak.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b6DHGlM+Xq3uXNm0oDChhbkL/3cIlOkeqDIam8BJA/0=;
        b=5Zpwdvap4S15UyvRrs8ZNVCqGl+eSrFrS/rIQkqrC6nuidXwTScToEd7AvEUhjbNET
         lA61nmx+UWfHr51cPvQotBdwUNMlyvLMPRIOSnvJJLZNWUI41kIQU0pZ+1fE1gUkwv8l
         ivyrl/iUD9yH/Bjd/UDP6YRHvXS9919OtQdDZpmt4ZmekPiFsPtgbmBWvpAOngQu9/O1
         Z6ahVvRQU1+YabAzU6w94hzCDPq8cjhbM29xOuF073cI5Z59h4av8nV4VfWiIiIQ6KdQ
         PeZNVFerhGIRyclceXnscfOUcxyEyclnfniT7swLSK7jeupgcFdkoEE9ce8Hfl6q1oq1
         cmMQ==
X-Gm-Message-State: AOAM533UxFAOMRbacsjPvlM5iN4Wact2XfJq0GlRutuTDNxi+iYOYxSz
        nCEmKGR4nBld9z8i6rDDxuPbNtx9NjQpjg==
X-Google-Smtp-Source: ABdhPJyofhxlhfSNgVxS5fi3YR65jjk1NbcYQkd9tMB1IFJ71WsJws0enawVl9hzFB0vgotHE9p5cg==
X-Received: by 2002:ab0:35cd:: with SMTP id x13mr50478288uat.46.1636963144268;
        Sun, 14 Nov 2021 23:59:04 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id s2sm8934233uap.7.2021.11.14.23.59.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:59:03 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id w23so10089931uao.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:59:03 -0800 (PST)
X-Received: by 2002:a67:af0a:: with SMTP id v10mr40368499vsl.35.1636963143631;
 Sun, 14 Nov 2021 23:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20210629103700.1935012-1-geert@linux-m68k.org> <162500112137.438178.14586324457676666976.b4-ty@chromium.org>
In-Reply-To: <162500112137.438178.14586324457676666976.b4-ty@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Nov 2021 08:58:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWwDK0bB2B7iFXqMhkZrmw26vKDFZEv+z+mYYTavp5-Eg@mail.gmail.com>
Message-ID: <CAMuHMdWwDK0bB2B7iFXqMhkZrmw26vKDFZEv+z+mYYTavp5-Eg@mail.gmail.com>
Subject: Re: [PATCH] pstore/blk: Use "%lu" to format unsigned long
To:     Kees Cook <keescook@chromium.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Tue, Jun 29, 2021 at 11:12 PM Kees Cook <keescook@chromium.org> wrote:
> On Tue, 29 Jun 2021 12:37:00 +0200, Geert Uytterhoeven wrote:
> > On 32-bit:
> >
> >     fs/pstore/blk.c: In function ‘__best_effort_init’:
> >     include/linux/kern_levels.h:5:18: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 3 has type ‘long unsigned int’ [-Wformat=]
> >       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
> >         |                  ^~~~~~
> >     include/linux/kern_levels.h:14:19: note: in expansion of macro ‘KERN_SOH’
> >        14 | #define KERN_INFO KERN_SOH "6" /* informational */
> >         |                   ^~~~~~~~
> >     include/linux/printk.h:373:9: note: in expansion of macro ‘KERN_INFO’
> >       373 |  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> >         |         ^~~~~~~~~
> >     fs/pstore/blk.c:314:3: note: in expansion of macro ‘pr_info’
> >       314 |   pr_info("attached %s (%zu) (no dedicated panic_write!)\n",
> >         |   ^~~~~~~
>
> Applied to for-next/pstore, thanks!

Thanks!

> [1/1] pstore/blk: Use "%lu" to format unsigned long
>       https://git.kernel.org/kees/c/c5d4fb2539ca

Looks like this still hasn't made upstream, although it has been in
linux-next since the end of June?  The issue is still present (and
now an error with -Werror), but hidden due to commit d07f3b081ee63226
("mark pstore-blk as broken").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
