Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114893CD734
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhGSOLX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jul 2021 10:11:23 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:46682 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241182AbhGSOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:09:14 -0400
Received: by mail-vs1-f53.google.com with SMTP id e9so9459900vsk.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qx5mJkBsGELHIfg3tO6IBHVeQdtURYJ38KZzvX6xUBY=;
        b=GTNIkkMT1/aroOpzSfHfqRdsuj2GeI1yQlIRXxjJq2glfJ/o7PEkkNvwUX7Iq45L1I
         QOFyv7dNEryXiKOWOZIW7Ye4NB2Ds+nhOItWv1CsF86VHKDjw0zodVQaBTj/BcGFJT6B
         pfYEBTO2MAUrSVWm1kgtbCxe8LZPk3Q5RYgWLqfEH7+eJmGnz21LAYp2r6INoVJ4zJ12
         uMtWRAphd76GPOgXWz3dlu1xlJOhZEDJJ5h93tr+WQNNzUGAuoyIJ9EvFXeg//dMjw6Z
         oju//bDRv+9QVZxYMVqQMWc/0Gy2c2dm38Z52tXeIcELO8xoQKo50VyNEF+/ecFAk+Ye
         dz9w==
X-Gm-Message-State: AOAM531/IwtrEo3YvZMKqYRqMzfxa/QDx/ttMrOBnW3uR1ImHWB3Gao4
        Hw6hcf5TKrnazj5fFvQpGLT02AlUWEL2Hn/W4ao=
X-Google-Smtp-Source: ABdhPJyWBmBLTA8AWcOVBVDelW9SF9rerNvvLBU1GLRis490q++voKnpseBb3FVTBjim+amqIyy5GHm+gV0aS+Sxsm8=
X-Received: by 2002:a05:6102:321c:: with SMTP id r28mr24683436vsf.40.1626706162788;
 Mon, 19 Jul 2021 07:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <a7a801d2-13d2-7b5b-66a5-98e7c95b00cc@gmail.com> <5e1b5d90-5a1e-5e9f-7b92-6c53b8589c2a@gmail.com>
In-Reply-To: <5e1b5d90-5a1e-5e9f-7b92-6c53b8589c2a@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Jul 2021 16:49:11 +0200
Message-ID: <CAMuHMdVMi8zfmSiZ0vnvCcsZQua_LKXpNAQVmRUdBKxNay=f-w@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tsukamoto-san,

On Mon, Jul 19, 2021 at 2:53 PM Akira Tsukamoto
<akira.tsukamoto@gmail.com> wrote:
> This patch will reduce cpu usage dramatically in kernel space especially
> for application which use sys-call with large buffer size, such as
> network applications. The main reason behind this is that every
> unaligned memory access will raise exceptions and switch between s-mode
> and m-mode causing large overhead.

[...]

> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>

Thanks for your patch!

As v3 is part of v5.14-rc1, all fixes and improvements need to be
send as incremental patches.

After reverting ca6eaaa210deec0e ("riscv: __asm_copy_to-from_user:
Optimize unaligned memory access and pipeline stall") and applying
v4, booting linux-on-litex-vexriscv still fails, but now differently
(real crash):

    /bi�����V�F-: applet not found
    2'�����t: applet not found
    Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
    CPU: 0 PID: 1 Comm: init Not tainted
5.14.0-rc2-orangecrab-01933-g5c9574869017 #357
    Call Trace:
    Unable to handle kernel NULL pointer dereference at virtual address 00000af0
    Oops [#1]
    CPU: 0 PID: 1 Comm: init Not tainted
5.14.0-rc2-orangecrab-01933-g5c9574869017 #357
    epc : walk_stackframe+0x11c/0x13c
     ra : dump_backtrace+0x2c/0x3c
    epc : c0003970 ra : c00039bc sp : c1835e20
     gp : c06a7690 tp : c1838000 t0 : 00000000
     t1 : 00000000 t2 : 00000000 s0 : c1835e50
     s1 : c05d8180 a0 : 00001000 a1 : 00000000
     a2 : c04dfd68 a3 : c05d8180 a4 : ab1d4cdc
     a5 : 00001000 a6 : c067d204 a7 : ffffefff
     s2 : 00000000 s3 : c05cc9f4 s4 : 00000000
     s5 : c05d8180 s6 : c04dfd68 s7 : 00000001
     s8 : 00000000 s9 : 95b6f158 s10: 00000000
     s11: 00000001 t3 : 00000000 t4 : 00000001
     t5 : 00000000 t6 : 00000000
    status: 00000100 badaddr: 00000af0 cause: 0000000d
    [<c0003970>] walk_stackframe+0x11c/0x13c
    [<c00039bc>] dump_backtrace+0x2c/0x3c
    [<c04dfde8>] show_stack+0x44/0x5c
    [<c04e4c98>] dump_stack_lvl+0x2c/0x40
    [<c04e4cc8>] dump_stack+0x1c/0x2c
    [<c04dff3c>] panic+0x13c/0x330
    [<c000c774>] do_exit+0x830/0x8b8
    [<c000c888>] do_group_exit+0x40/0xac
    [<c000c918>] __wake_up_parent+0x0/0x34
    [<c0002128>] ret_from_syscall+0x0/0x4
    ---[ end trace d147f0f146982b08 ]---
    note: init[1] exited with preempt_count 1
    Fixing recursive fault but reboot is needed!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
