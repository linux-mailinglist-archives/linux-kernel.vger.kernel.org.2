Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D283D566E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhGZInQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:43:16 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:47002 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhGZInO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:43:14 -0400
Received: by mail-vk1-f170.google.com with SMTP id d15so1865905vka.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjJGdTE/tlZseW0pzt6q9F9+mym1b0Btcv6i5Gjm01k=;
        b=DKjdBMqhQ6ieFkLNM0vUmDoEXUkz2aGisjA33LOfM/0nIbwOhJxqJxUrIP6sjcVnbA
         Ft/0N56Us1oiD+YGHePnl6ADTPrW+9YJ5McbCpBaG9vywoqFbXxGKMXqFWi9IL3hSTPU
         mYqt+ojt7aujDwANOumZypee+CZpFtUhOZ8GqingcOa/tcaWThJ4DOQGrCzXTJO7ROzE
         4OhDYstT2b408cQp0O+3WnajX4uEKLXfWm1AsyzdEVHddg4ILLRgKshChvoCzUxws0kj
         a7YBmQtmsCNXD6sL9fXZSWoon1Qov0Qx8NWRBT78fbaNGUFkP7McEmeaD/yNEn1SMhOn
         2uig==
X-Gm-Message-State: AOAM531ccP6nF6i0yP6py5R6UUytA5kn/sK01ynG4ZrGmSzFZYh/T1dL
        L20+NMrSBxSKlp0jBb4kRinA0zG+W8++/lnGNG4=
X-Google-Smtp-Source: ABdhPJzMngFHTfWJxJKBUeUs1WgMw84W9+9SLI15f2X46Ju0B58oyj/TSYhfyq+/enRTeyL3FRCzbQw4VUn+lNK7ay4=
X-Received: by 2002:ac5:cd9b:: with SMTP id i27mr9296318vka.1.1627291422600;
 Mon, 26 Jul 2021 02:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210721104318.1070133-1-twd2.me@gmail.com>
In-Reply-To: <20210721104318.1070133-1-twd2.me@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Jul 2021 11:23:31 +0200
Message-ID: <CAMuHMdUWvnz4jCyPctZevq8MdFtCD8MCNSfDbCVR+__rP_=gvw@mail.gmail.com>
Subject: Re: [PATCH] m68k: Remove redefinitions of `PMD_SIZE`, `PMD_MASK`, etc.
To:     Wende Tan <twd2.me@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wende,

On Wed, Jul 21, 2021 at 12:44 PM Wende Tan <twd2.me@gmail.com> wrote:
> Remove redefinitions of `PMD_SIZE`, `PMD_MASK`, `PTRS_PER_PMD`,
> and `__PAGETABLE_PMD_FOLDED` when PGTABLE_LEVELS == 2 (i.e. SUN3 ||
> COLDFIRE).  They have already been defined in
> `asm-generic/pgtable-nopmd.h`.

Thanks for your patch!

> See also https://lore.kernel.org/lkml/202107201907.lqC6B3dF-lkp@intel.com/#t

I'm a bit confused: is this a new issue introduced by the patch from
the above thread, or is this a pre-existing issue?
If the latter, do you know when it was introduced, and how to reproduce it?

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Wende Tan <twd2.me@gmail.com>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
