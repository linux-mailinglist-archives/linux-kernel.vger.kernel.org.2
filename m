Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1376434349E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCUUVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCUUVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:21:06 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EBEC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:21:05 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so13945132oto.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ml2CAGfeWm9mmFcT8io3E2LueuJYHNce2KGbKvNhe/o=;
        b=PtuWr/U+sqzCVLMcJ0B9O8DCNzwTq3qYOcCVk1Mc12F7cYCNnA5I/0zRurmkIIG1lw
         kg1KiWTH1vtZrMLbSSH78e1yxaS3u4X07oWv/7EvxzKYvoJARJCfiG6V30MRNNLioIcQ
         1cSmCcyPXEB3MFARyGi0OHLLxGmAAm99vBHWmXNBiz5gPCdWCZ6hDJCIvLruvWJaaJjV
         XnVKSeN4Tq+QOMpt/aGM3LQ24FFXFGiqwK8QePaHk/+t2iSbox4Eguv4u8POlpvuTcpN
         HIe1/YKqGGyCHt0ivy79HXBkHFksf/W41ILlFfoHiwHsngG7Y+yLz++KZ5GcfEhuQMl5
         v9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ml2CAGfeWm9mmFcT8io3E2LueuJYHNce2KGbKvNhe/o=;
        b=ggVDGo8anHgMGP+qdHDjz+G9f52+ceZPAoDtN7vSXpe3+b/qgwjN52+XIow09HY2xn
         oCUk2SfvR8H9Sp9IT5DOt0tkvnNSw6Cp9DkDfi+P9qQtcYGm34RgBdFgSh3M6hMag3IS
         R3JhVRDJ/fJQiHY5Xt9m662d0U50aZu9ipCsUM7waxye3FNvwDJrLo4b2nYmpv6yV59U
         Pl6/c/HyO/Plrea1Nqimb0fuK1uJWi/vwp62zb3Ja4BE9VUr5HzcRLwLOSPEJakd0P3H
         s5zOACQdcJ+YaYFrUCKSULEibqDF0xOdDfxbM9UZyNc0FMuzsSRjgfQvzajg7yjtVCTM
         vvRw==
X-Gm-Message-State: AOAM531+8StromhGGxCs648F2dExDEMNkXvB/ZbSWwbs1j8/TacMOd3s
        Y1sYSY/0zt7iLqF4P4etA34=
X-Google-Smtp-Source: ABdhPJz6gwGf/T6Qab0+dLhMoM8CmLXE1E1osNarieuhjULfTLIx37pTer27dN5qiDpH7/6G+S6nig==
X-Received: by 2002:a9d:3437:: with SMTP id v52mr6252883otb.55.1616358065008;
        Sun, 21 Mar 2021 13:21:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64sm2937923otu.80.2021.03.21.13.21.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Mar 2021 13:21:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 21 Mar 2021 13:21:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v4] RISC-V: enable XIP
Message-ID: <20210321202103.GA121213@roeck-us.net>
References: <20210306121438.12827-1-vitaly.wool@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306121438.12827-1-vitaly.wool@konsulko.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 02:14:38PM +0200, Vitaly Wool wrote:
> Introduce XIP (eXecute In Place) support for RISC-V platforms.
> It allows code to be executed directly from non-volatile storage
> directly addressable by the CPU, such as QSPI NOR flash which can
> be found on many RISC-V platforms. This makes way for significant
> optimization of RAM footprint. The XIP kernel is not compressed
> since it has to run directly from flash, so it will occupy more
> space on the non-volatile storage to The physical flash address
> used to link the kernel object files and for storing it has to
> be known at compile time and is represented by a Kconfig option.
> 
> XIP on RISC-V will currently only work on MMU-enabled kernels.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> ---

The impact of this patch on RISC-V images running in qemu is quite fatal.

[    0.000000] Linux version 5.12.0-rc3-next-20210319 (groeck@saturn.roeck-us.net) (riscv64-linux-gcc (GCC) 9.3.0, GNU ld (GNU Binutils) 2.34) #1 SMP Fri Mar 19 04:01:41 PDT 2021
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
[    0.000000] Machine model: riscv-virtio,qemu
[    0.000000] earlycon: uart8250 at MMIO 0x0000000010000000 (options '115200')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] Unable to handle kernel paging request at virtual address 0000000040000001
[    0.000000] Oops [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.12.0-rc3-next-20210319 #1
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] epc : fdt_check_header+0x0/0x1fc
[    0.000000]  ra : early_init_dt_verify+0x16/0x6e
[    0.000000] epc : ffffffe00049c04a ra : ffffffe000a26144 sp : ffffffe001603f10
[    0.000000]  gp : ffffffe0017d04b0 tp : ffffffe001611280 t0 : ffffffffffffffff
[    0.000000]  t1 : 0000000012adc51a t2 : 000000000004ffeb s0 : ffffffe001603f30
[    0.000000]  s1 : 0000000040000000 a0 : 0000000040000000 a1 : ffffffe001617ae8
[    0.000000]  a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000018
[    0.000000]  a5 : ffffffe000c0f8f0 a6 : ffffffe01fdfee70 a7 : 0000000000000000
[    0.000000]  s2 : 0000000080000200 s3 : 0000000000000fff s4 : ffffffe000c0ec60
[    0.000000]  s5 : 0000000000000006 s6 : 00000000000001c0 s7 : ffffffe01fdfee40
[    0.000000]  s8 : 0000000081000200 s9 : 0000000080000200 s10: ffffffe000c01000
[    0.000000]  s11: 0000000000000fff t3 : 000000000000000e t4 : ffffffffa6000000
[    0.000000]  t5 : ffffffffffffffff t6 : 0000000000000015
[    0.000000] status: 0000000000000100 badaddr: 0000000040000001 cause: 000000000000000d
[    0.000000] Call Trace:
[    0.000000] [<ffffffe00049c04a>] fdt_check_header+0x0/0x1fc
[    0.000000] [<ffffffe000a02c84>] setup_arch+0x3a8/0x414
[    0.000000] [<ffffffe000a006fa>] start_kernel+0x8e/0x62c
[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x22/0x44 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

This is with riscv:defconfig. Reverting this patch fixes the problem.

Bisect log is attached.

Guenter

---
# bad: [f00397ee41c79b6155b9b44abd0055b2c0621349] Add linux-next specific files for 20210319
# good: [1e28eed17697bcf343c6743f0028cc3b5dd88bf0] Linux 5.12-rc3
git bisect start 'HEAD' 'v5.12-rc3'
# bad: [728bc19f9c531acd94e4139e8258a1577f17d2ff] Merge remote-tracking branch 'drm/drm-next'
git bisect bad 728bc19f9c531acd94e4139e8258a1577f17d2ff
# bad: [ad5d10f254a7d91a9fadadcf2b109795544e9dcb] Merge remote-tracking branch 'hid/for-next'
git bisect bad ad5d10f254a7d91a9fadadcf2b109795544e9dcb
# good: [163518c802260a16b5bca8bd7fe0a9335a6860e1] Merge remote-tracking branch 'qcom/for-next'
git bisect good 163518c802260a16b5bca8bd7fe0a9335a6860e1
# bad: [a9fdd30a39510f783a38fe5c30b2d888397b35d5] Merge remote-tracking branch 'btrfs/for-next'
git bisect bad a9fdd30a39510f783a38fe5c30b2d888397b35d5
# good: [3f26d646c9c30116057e2cc34091e7d3fd894863] Merge remote-tracking branch 'microblaze/next'
git bisect good 3f26d646c9c30116057e2cc34091e7d3fd894863
# good: [f0fd694b8c3eba5651fa9eed185cc1c39c1a3d64] Merge branch 'ext/qu/subpage-write-meta-v2' into for-next-next-v5.12-20210317
git bisect good f0fd694b8c3eba5651fa9eed185cc1c39c1a3d64
# bad: [762f6038cff9e5658c29936a0ff0398fb2b77dc9] Merge remote-tracking branch 'sh/for-next'
git bisect bad 762f6038cff9e5658c29936a0ff0398fb2b77dc9
# good: [fb009cbdd0693bd633f11e99526617b3d392cfad] firmware: bcm47xx_nvram: rename finding function and its variables
git bisect good fb009cbdd0693bd633f11e99526617b3d392cfad
# good: [10b3a0a8f783dc5491921f0236f1b756cbe1b12d] Merge remote-tracking branch 'parisc-hd/for-next'
git bisect good 10b3a0a8f783dc5491921f0236f1b756cbe1b12d
# good: [2882b7626f4903a8e9250b328cdf7396a6deecac] sh: kernel: traps: remove unused variable
git bisect good 2882b7626f4903a8e9250b328cdf7396a6deecac
# bad: [06c7c914de26c5a4f1418fd54e4dfd0be4215de6] RISC-V: enable XIP
git bisect bad 06c7c914de26c5a4f1418fd54e4dfd0be4215de6
# good: [9530141455c968938a913d602a236c2a7b0322e1] riscv: Add ARCH_HAS_FORTIFY_SOURCE
git bisect good 9530141455c968938a913d602a236c2a7b0322e1
# good: [2f100585d04506004b8027ec9bbaee26940a769f] riscv: Enable generic clockevent broadcast
git bisect good 2f100585d04506004b8027ec9bbaee26940a769f
# first bad commit: [06c7c914de26c5a4f1418fd54e4dfd0be4215de6] RISC-V: enable XIP
