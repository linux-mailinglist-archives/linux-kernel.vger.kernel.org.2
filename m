Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78EA45562A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 08:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244128AbhKRH72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 02:59:28 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:40550 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244115AbhKRH71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 02:59:27 -0500
Received: by mail-vk1-f175.google.com with SMTP id k83so3262495vke.7;
        Wed, 17 Nov 2021 23:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bxSVfK+jtq4xx4x9ZRh1L5+4X8L6DgEqVEG/BczPbk=;
        b=ax04JnvzgXJXcd0oqDA768ZOhhmj7doZ3qnWc9Gy/b6hN3J0N5AhJH9LrVqWHouFo1
         PNdCjCS4PfnQ+9EH3lFFkh3KNIsXZkRvB3zfD66FF633ARo2zDoXxaIWY9zAOL8eD6Q4
         gfDR9HkWUVMbXVnQ+2bVg6Kxvbbu9jbVUP/pLNiIoW1ByD3MRkZ+9EWAFPVQqzQbmSTT
         g8+WIAf2WiLnogo281ZkQ089iQRZBBNM3I4IuMeVe5U0uuOY0ZXBOIzL0V3UtVDrsr0C
         Ke1wve19mPpSI48Y9er4AXWuq5CoWKedYlQ+E8U8eQZoUJsWb1a1ky4swQRZYSDPGMBY
         VuUQ==
X-Gm-Message-State: AOAM530f2jk14HyGCkW5x17jGxYTyVMtU3LjFLN1Ry6E94OojIbpeOpe
        7j2W9BlW7NDuanSsQiUghNMigUYkQzM4aQ==
X-Google-Smtp-Source: ABdhPJyuID99H42Ay3Ae4ZnRhOopz7g1aWbEEU0GgBkRcZFb/zsR/SpsOaLPkDG4lZWRut+QNomEjg==
X-Received: by 2002:a05:6122:1796:: with SMTP id o22mr101030162vkf.23.1637222187075;
        Wed, 17 Nov 2021 23:56:27 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 66sm46009uao.0.2021.11.17.23.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 23:56:26 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id p37so11740971uae.8;
        Wed, 17 Nov 2021 23:56:26 -0800 (PST)
X-Received: by 2002:a05:6102:1354:: with SMTP id j20mr78448014vsl.41.1637222186077;
 Wed, 17 Nov 2021 23:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20211117201459.1194876-1-nickrterrell@gmail.com> <20211117201459.1194876-4-nickrterrell@gmail.com>
In-Reply-To: <20211117201459.1194876-4-nickrterrell@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Nov 2021 08:56:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV_ZYZPv6T+V1zXcYRM2n8RNKf-uwmoxNtZUgBGC-uk7Q@mail.gmail.com>
Message-ID: <CAMuHMdV_ZYZPv6T+V1zXcYRM2n8RNKf-uwmoxNtZUgBGC-uk7Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lib: zstd: Don't add -O3 to cflags
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Nick Terrell <terrelln@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, Nov 17, 2021 at 9:08 PM Nick Terrell <nickrterrell@gmail.com> wrote:
> From: Nick Terrell <terrelln@fb.com>
>
> After the update to zstd-1.4.10 passing -O3 is no longer necessary to
> get good performance from zstd. Using the default optimization level -O2
> is sufficient to get good performance.
>
> I've measured no significant change to compression speed, and a ~1%
> decompression speed loss, which is acceptable.
>
> This fixes the reported parisc -Wframe-larger-than=1536 errors [0]. The
> gcc-8-hppa-linux-gnu compiler performed very poorly with -O3, generating
> stacks that are ~3KB. With -O2 these same functions generate stacks in
> the < 100B, completely fixing the problem. Function size deltas are
> listed below:
>
> ZSTD_compressBlock_fast_extDict_generic: 3800 -> 68
> ZSTD_compressBlock_fast: 2216 -> 40
> ZSTD_compressBlock_fast_dictMatchState: 1848 ->  64
> ZSTD_compressBlock_doubleFast_extDict_generic: 3744 -> 76
> ZSTD_fillDoubleHashTable: 3252 -> 0
> ZSTD_compressBlock_doubleFast: 5856 -> 36
> ZSTD_compressBlock_doubleFast_dictMatchState: 5380 -> 84
> ZSTD_copmressBlock_lazy2: 2420 -> 72
>
> Additionally, this improves the reported code bloat [1]. With gcc-11
> bloat-o-meter shows an 80KB code size improvement:
>
> ```
> > ../scripts/bloat-o-meter vmlinux.old vmlinux
> add/remove: 31/8 grow/shrink: 24/155 up/down: 25734/-107924 (-82190)
> Total: Before=6418562, After=6336372, chg -1.28%
> ```
>
> Compared to before the zstd-1.4.10 update we see a total code size
> regression of 105KB, down from 374KB at v5.16-rc1:
>
> ```
> > ../scripts/bloat-o-meter vmlinux.old vmlinux
> add/remove: 292/62 grow/shrink: 56/88 up/down: 235009/-127487 (107522)
> Total: Before=6228850, After=6336372, chg +1.73%
> ```
>
> [0] https://lkml.org/lkml/2021/11/15/710
> [1] https://lkml.org/lkml/2021/11/14/189
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Nick Terrell <terrelln@fb.com>

Impact on vmlinux for atari_defconfig:

    add/remove: 22/3 grow/shrink: 7/91 up/down: 3246/-35548 (-32302)

Impact on lib/zstd/zstd_compress.ko for atari_defconfig:

    add/remove: 63/5 grow/shrink: 23/197 up/down: 13410/-168604 (-155194)

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
