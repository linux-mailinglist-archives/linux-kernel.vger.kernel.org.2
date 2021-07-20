Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7E3CF72F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhGTJI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 05:08:57 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:42537 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhGTJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:08:52 -0400
Received: by mail-vs1-f50.google.com with SMTP id u7so10905870vst.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 02:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X7Rrow7QuzFGdlxPoYmznnIEE3mNavblrdx/pok5ctM=;
        b=mwrH95GEkrTFHVRoNS5FJpqNF8K+Le8XnF9WHIkyaTfzBwCZezdRaVSKxLI/qSWHMM
         Yj1aVRZUxudGA+Qqs4yo2tkabvsTQRx34bRkBr3ys0Qxzl880LtIEFqwSO6uDJBpRokT
         HmF16H2CjvEaVA0LbdbljrYxNeS6/nu1z8Yg8QRGs8iACmUEel31tyYwhCFkWs/58nfV
         wcK9h5cGpS/Yl5cqIT343OnFjQefDW8pq2zhnqaIKy9z4ULATXg2G+7m/1X2Rloed60N
         1L+BWRuPvi0dU2WWLB6ekh+cLpFSKEdkC6zHd6csP97GhoPwTnBYO3w+GYTVevX0qEw5
         /LQg==
X-Gm-Message-State: AOAM530toAwmoszx1KQMhOmw0J1JSs4QB0Hp7rC23JSzuQ2a+G5ZMKL7
        DKG1+BMYr3tbRTbAA+wI0IX0XAEZglCao9+8ll0=
X-Google-Smtp-Source: ABdhPJx6LeiuuZovJDBYwh5S5IVVbdCs9y03T5Nz2Hn82i70Tf8ig1LjFS3chKv5D7mo1ez7diN4cdECYpSeBh14oXU=
X-Received: by 2002:a05:6102:2828:: with SMTP id ba8mr28356150vsb.18.1626774569916;
 Tue, 20 Jul 2021 02:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <37097718-c472-025a-2058-55667badc5b9@gmail.com> <93a6ae3b-3271-5edb-0a1b-260ba789f3f1@gmail.com>
In-Reply-To: <93a6ae3b-3271-5edb-0a1b-260ba789f3f1@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Jul 2021 11:49:18 +0200
Message-ID: <CAMuHMdUnD58W6qAbxnT3y-BMTHb+De+z29YNGYVA3mWD0B-37g@mail.gmail.com>
Subject: Re: [PATCH 2/4] riscv: __asm_copy_to-from_user: Fix: fail on RV32
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tsukamoto-san,

Thanks for your patch!

On Tue, Jul 20, 2021 at 10:51 AM Akira Tsukamoto
<akira.tsukamoto@gmail.com> wrote:
> Had a bug when converting bytes to bits when the cpu was rv32.
>
> The a3 contains the number of bytes and multiple of 8
> would be the bits. The LGREG is holding 2 for RV32 and 3 for
> RV32, so to achieve multiple of 8 it must always be constant 3.

RV64

> The 2 was mistakenly used for rv32.
>
> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
