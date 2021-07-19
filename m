Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB023CE449
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 18:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbhGSPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345171AbhGSPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:00:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C0C076B96
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:53:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id jx7-20020a17090b46c7b02901757deaf2c8so233356pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nvVob/r6aogoYIZPXj3xzusDgNE755/gn+vTBsW74ko=;
        b=RPkxmalK9O2x0tnnD63jkQ1EtIKZ7h7qqYU1CHCCSAGuud+0tDc03Qr561ZcB5P9ta
         2i8hidiCj9YuDDEdqXR0gC7n6pTh3IUhO3eVZDyvfto9Eid4HrFpJXOq8aFNPJgG+mwz
         azvJJGUa2Pfrv5LcWY1YOomimuhASWz7l7EpGEAqAWPABmrfMp6faOb/srC4ebwnVsAr
         twPOayf0xMmviobC7ygj+yLp6qTlIjxnnGKioeszevYnlzo426CbaAt8XiMadYSYofdf
         SoMCq8OVfL9vUPLxBisBbGzNysqPInMIx8DJXVOASFjBIeasi1SA68zz03NxNHneuSG4
         sqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nvVob/r6aogoYIZPXj3xzusDgNE755/gn+vTBsW74ko=;
        b=ZNqNhXbavuN3x4NnHbZjFBFz3KEEYcOUpyr12IWgcnDiEU10zhkGw3EJZqiCWXzMQB
         cBbrGOOBN4RRNSwxM7BUVAnHfiHCO6uNq7lz9o2eCYwZg+QTo+NMQ76rS7AawNjJnFjq
         OPKGbqckAy2KYn6Rfj1C4vrgKixClUBbgNFiUHoO9mue9SWnuvoYHhr212EGWaWX73K1
         Px6iNsrme6YMbnmjXQEFgbOS/75Q1DzDKmAXWSvKGftoYU8WtJW66giU0LKaBMbjQzv8
         a8mtzRnKOOA1G5ktkhvSK7PlBx99GDaMDa9fmnuZn5by1N0DOyvwMdD/iUe0uBZmduAr
         CuFw==
X-Gm-Message-State: AOAM532cbxGNrMkEl82JQHewQYnuMy5NhkckWNt0Qcll0XyslYOCS7P4
        UenaElgjcOaQ0B9qZ5uO6saXzyXMdPM=
X-Google-Smtp-Source: ABdhPJy/lOXC2/EtKPIbuho79iPei4tSqmfJjQhDAOQlSWLSr/7dxEBzOHbcMFV2VFVzJN4KVsqx1g==
X-Received: by 2002:a17:90b:2112:: with SMTP id kz18mr30847210pjb.137.1626708161753;
        Mon, 19 Jul 2021 08:22:41 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id w145sm9410903pfc.39.2021.07.19.08.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 08:22:41 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <a7a801d2-13d2-7b5b-66a5-98e7c95b00cc@gmail.com>
 <5e1b5d90-5a1e-5e9f-7b92-6c53b8589c2a@gmail.com>
 <CAMuHMdVMi8zfmSiZ0vnvCcsZQua_LKXpNAQVmRUdBKxNay=f-w@mail.gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <97ee158e-0fe8-cd7a-6ee2-35f9018838de@gmail.com>
Date:   Tue, 20 Jul 2021 00:22:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVMi8zfmSiZ0vnvCcsZQua_LKXpNAQVmRUdBKxNay=f-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 7/19/2021 11:49 PM, Geert Uytterhoeven wrote:
> Hi Tsukamoto-san,
> 
> On Mon, Jul 19, 2021 at 2:53 PM Akira Tsukamoto
> <akira.tsukamoto@gmail.com> wrote:
>> This patch will reduce cpu usage dramatically in kernel space especially
>> for application which use sys-call with large buffer size, such as
>> network applications. The main reason behind this is that every
>> unaligned memory access will raise exceptions and switch between s-mode
>> and m-mode causing large overhead.
> 
> [...]
> 
>> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
> 
> Thanks for your patch!

Thanks for trying!

> 
> As v3 is part of v5.14-rc1, all fixes and improvements need to be
> send as incremental patches.

Yeah, I was not paying attention to v5.14-rc1. Will regenerate it 
when I spot the remaining bug on rv32.

> 
> After reverting ca6eaaa210deec0e ("riscv: __asm_copy_to-from_user:
> Optimize unaligned memory access and pipeline stall") and applying
> v4, booting linux-on-litex-vexriscv still fails, but now differently
> (real crash):

This time it looks like under copy instead of overrun copy last time.
The SZREG, LGREG, REG_L and REG_S should been taking care of the 
difference of rv32 and rv64, but probably still forgetting applying
some places.

Akira

> 
>     /bi�����V�F-: applet not found
>     2'�����t: applet not found
>     Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>     CPU: 0 PID: 1 Comm: init Not tainted
> 5.14.0-rc2-orangecrab-01933-g5c9574869017 #357
>     Call Trace:
>     Unable to handle kernel NULL pointer dereference at virtual address 00000af0
>     Oops [#1]
>     CPU: 0 PID: 1 Comm: init Not tainted
> 5.14.0-rc2-orangecrab-01933-g5c9574869017 #357
>     epc : walk_stackframe+0x11c/0x13c
>      ra : dump_backtrace+0x2c/0x3c
>     epc : c0003970 ra : c00039bc sp : c1835e20
>      gp : c06a7690 tp : c1838000 t0 : 00000000
>      t1 : 00000000 t2 : 00000000 s0 : c1835e50
>      s1 : c05d8180 a0 : 00001000 a1 : 00000000
>      a2 : c04dfd68 a3 : c05d8180 a4 : ab1d4cdc
>      a5 : 00001000 a6 : c067d204 a7 : ffffefff
>      s2 : 00000000 s3 : c05cc9f4 s4 : 00000000
>      s5 : c05d8180 s6 : c04dfd68 s7 : 00000001
>      s8 : 00000000 s9 : 95b6f158 s10: 00000000
>      s11: 00000001 t3 : 00000000 t4 : 00000001
>      t5 : 00000000 t6 : 00000000
>     status: 00000100 badaddr: 00000af0 cause: 0000000d
>     [<c0003970>] walk_stackframe+0x11c/0x13c
>     [<c00039bc>] dump_backtrace+0x2c/0x3c
>     [<c04dfde8>] show_stack+0x44/0x5c
>     [<c04e4c98>] dump_stack_lvl+0x2c/0x40
>     [<c04e4cc8>] dump_stack+0x1c/0x2c
>     [<c04dff3c>] panic+0x13c/0x330
>     [<c000c774>] do_exit+0x830/0x8b8
>     [<c000c888>] do_group_exit+0x40/0xac
>     [<c000c918>] __wake_up_parent+0x0/0x34
>     [<c0002128>] ret_from_syscall+0x0/0x4
>     ---[ end trace d147f0f146982b08 ]---
>     note: init[1] exited with preempt_count 1
>     Fixing recursive fault but reboot is needed!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
