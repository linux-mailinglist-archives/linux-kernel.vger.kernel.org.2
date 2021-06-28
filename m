Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD423B5A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhF1Iqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:46:46 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:40798 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhF1Iqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:46:44 -0400
Received: by mail-ua1-f45.google.com with SMTP id r9so6684663ual.7;
        Mon, 28 Jun 2021 01:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gnjjBiBTzk19PQgZ7pULK/I0EN+YsN+LEBoRJwvHTvs=;
        b=YYkw5a6fIgpOxUTZLT9Gka+FmxOeTf9TNQgJt5hLF7mBZOmGL+p1BpLVGZnV0rlCIz
         eA8dGuqBi6YAUepTlIJhOxW2I56XTR+AKfamFMiJSiXuUIfI360u1DI+b48JG0O+YvGr
         SzHCYNawxKJEBVRFtTe3+LlHObMuB/EqZnGs+CwYMoPwAJPrYAMFPhuw0xycntmH8fzW
         e4gpjVWBwIzf7MVPbTUG5a6azsbsroTcYUOFLMOGZMThx5HRcCxLFieNl5IqZdkhwgWr
         IVVoVnyJl7CFkhEXzW8erH9Y/TEbLBwAc7oAI1rmNjINqxnaJeHmaZlMTClAHLao0qE2
         shCA==
X-Gm-Message-State: AOAM532xCS3aPSokrw3gOXOlnKEkaDwX7rOfS42k8akMMAykjUWidCnL
        6kh0gxoWPy6YJ1pZdLVzpZCL+qAyDBMI3dNW/a2qnSbzNaw=
X-Google-Smtp-Source: ABdhPJxXD07jNGgGLX3ccOdFX8wtDfXF9xgIoJ7q/cK73I9P3YZMQj1Vr1NuKJCUpUjx5Es7/uu/8fWrb/Noxqg1Gc4=
X-Received: by 2002:ab0:484b:: with SMTP id c11mr19775050uad.100.1624869858377;
 Mon, 28 Jun 2021 01:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210627220544.8757-1-rdunlap@infradead.org> <20210627220544.8757-2-rdunlap@infradead.org>
In-Reply-To: <20210627220544.8757-2-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jun 2021 10:44:07 +0200
Message-ID: <CAMuHMdUPsTTdH7024=46-3c6Z9j1DVj5nxSjDwVRvNgwAvRFzQ@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] sh: fix kconfig unmet dependency warning for FRAME_POINTER
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matt Fleming <matt@console-pimps.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:05 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> FRAME_POINTER depends on DEBUG_KERNEL so DWARF_UNWINDER should
> depend on DEBUG_KERNEL before selecting FRAME_POINTER.
>
> WARNING: unmet direct dependencies detected for FRAME_POINTER
>   Depends on [n]: DEBUG_KERNEL [=n] && (M68K || UML || SUPERH [=y]) || ARCH_WANT_FRAME_POINTERS [=n]
>   Selected by [y]:
>   - DWARF_UNWINDER [=y]
>
> Fixes: bd353861c735 ("sh: dwarf unwinder support.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
