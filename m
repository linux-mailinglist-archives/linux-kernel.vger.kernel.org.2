Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11B73CF6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhGTIwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:52:14 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:40945 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbhGTIvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:51:31 -0400
Received: by mail-ua1-f51.google.com with SMTP id r9so7849779ual.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 02:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgdnRd+t5Fn08CGE5HYFeKJTBlBO+nXJPRDAHBMbx7U=;
        b=PprMUETTp7Ip8ixzzlQchgNDtkVmvoB8WIF3lqE5n8kdj8j8scuwJ8PEkfvBnTajCt
         5UsaHQ7Ct3hwv8mBETZEunStM9/r90p6gTXn7WZRgiGjhnQTntbDnfFZUknABhWsaOOU
         Ba+2Hzyje8wbUXLUuTZmNj+2CayCZUDEEQBGYy6IneHcl38JDh1SeYDkje4EPZNl2J9X
         B1nCMPtT49LNy1K73p0+Y1Foqb+XNm0URF1XIFZIupD4J8aIdc+QuwEG9yDIcBNDaG5U
         z56bcZ5DsXB2gkUKOiWs9arenkka62xI6RoUV8/pabCyYVv82iTKtsN++2BOdX8cUHrp
         8dpw==
X-Gm-Message-State: AOAM531QoFgXYv+i7z3XwoUkXauggjCI4MYGdaWmOpRnHAFsrFpbnNWU
        J0YVzs9uUlEqsSLON7NF+ETa9RDU+lCjnD7bvfQ=
X-Google-Smtp-Source: ABdhPJzC2IsLXa1JFljvwJBzvQIafprpWb+j/KDrGHgidSzujkNumv581Uu8Zr1ePuNgzSl0gCfBr8EbKuUzjtk7bcM=
X-Received: by 2002:ab0:2554:: with SMTP id l20mr30460183uan.58.1626773523243;
 Tue, 20 Jul 2021 02:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
In-Reply-To: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Jul 2021 11:31:51 +0200
Message-ID: <CAMuHMdWj5j_XQXnwBio8qZBGNFcr5PWwr7O5DroSKwO9AN0nPw@mail.gmail.com>
Subject: Re: [PATCH 0/4] __asm_copy_to-from_user: Fixes
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tsukamoto-san,

On Tue, Jul 20, 2021 at 10:49 AM Akira Tsukamoto
<akira.tsukamoto@gmail.com> wrote:
> These are series for the fix reported by Guenter, Geert and Qiu.
>
> One patch to fix overrun memory access, one patch to fix on rv32.
> And two more for clean up and typos.
>
> Have tested on qemu rv32, qemu rv64 and beaglev beta board.
>
> Thanks for the report and instructions to reproduce the error on rv32.
>
> Akira
>
> Akira Tsukamoto (4):
>   riscv: __asm_copy_to-from_user: Fix: overrun copy
>   riscv: __asm_copy_to-from_user: Fix: fail on RV32
>   riscv: __asm_copy_to-from_user: Remove unnecessary size check
>   riscv: __asm_copy_to-from_user: Fix: Typos in comments
>
>  arch/riscv/lib/uaccess.S | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)

Thanks, RV32 (vexriscv) is booting fine again.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
