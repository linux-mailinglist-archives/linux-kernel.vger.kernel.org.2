Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C045B3E4850
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhHIPHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:07:44 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:38661 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbhHIPHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:07:43 -0400
Received: by mail-vs1-f43.google.com with SMTP id t29so10242418vsr.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTs5CtLWyXBG0DLVLRK1Nq+J/mFgqyrFa3Bq0XHKiyY=;
        b=skEjSN+C58DWBQtj5oBTI9ayWbPHEc22pm+GEhdZJwIWq0w5LspoxpXHCoJ3HcxOLl
         MpGiTS9w1VNNkuQ0g4FrU6tjNRpED/wlerWJwRelbKjGkBqdrdX0+zCvfKp9mpKkqOzC
         7HmPPw8w4/XLyx0L0qSyE/yeUAmYXpkYwzrbti4nylM7R8nc1veeeoC0wL558/tmzUEP
         3c4rLQUB5fKhWA493Pq0N3ICPSDwgaFU+8LMh3229DbYc9PYWr4NOPoVUkjo1KamA8JH
         rTAzinYGVCwjf/vEfEJIjhGOg/3EiZ0clKqp8fUDSO0gZzZR8jv+Kfdu/qNa+6jHz1Ml
         u5XQ==
X-Gm-Message-State: AOAM53071pKoaOLJIF+8Gv4Vblc6/y6cchJc9e3vJjn4okNFkfd3qPlJ
        KjilB7YbXLzmWjy8qWlTPprNxJcW21We9OONos0=
X-Google-Smtp-Source: ABdhPJwoyk8XAGm4vmp+Ctx5jM2BnC5S9BUXjB4D0vk1aiOLNj+y1qF9/zVQr0myFBBlFBK2vGAJK6LwCiz8OCvVmgw=
X-Received: by 2002:a05:6102:d9:: with SMTP id u25mr7768616vsp.42.1628521642116;
 Mon, 09 Aug 2021 08:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <202108010312.8uIaWK0u-lkp@intel.com> <3bdd5b29-b6a1-54a8-ac99-adb59e8e91a7@vt.edu>
In-Reply-To: <3bdd5b29-b6a1-54a8-ac99-adb59e8e91a7@vt.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 17:07:11 +0200
Message-ID: <CAMuHMdXueYTAYFgt-gP79e1NaFzmPmsE1if+DsiZaB5VmNqCXA@mail.gmail.com>
Subject: Re: [PATCH v4.1] include: linux: Reorganize timekeeping and ktime headers
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 1, 2021 at 10:13 PM Carlos Bilbao <bilbao@vt.edu> wrote:
> Reorganize and separate the headers by making ktime.h take care of the
> ktime_get() family of functions, and reserve timekeeping.h for the actual
> timekeeping. This also helps to avoid implicit function errors and strengthens
> the header dependencies, since timekeeping.h was using ktime_to_ns(), a static
> function defined in a header it does no include, ktime.h. Include the header
> timekeeping.h wherever it is necessary for a successful compilation after the
> header code reorganization.
>
> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> Reported-by: kernel test robot <lkp@intel.com>

>  arch/m68k/atari/time.c         |   1 +
>  arch/m68k/hp300/time.c         |   2 +
>  arch/m68k/mac/via.c            |   1 +
>  arch/m68k/mvme16x/config.c     |   1 +
>  arch/m68k/sun3/sun3ints.c      |   1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
