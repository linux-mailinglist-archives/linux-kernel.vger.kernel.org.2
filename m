Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE10392A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhE0JD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235392AbhE0JDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:03:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 256B26109F;
        Thu, 27 May 2021 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622106111;
        bh=0v+a7eFcTScxcFMCOsuCXh3erJ+IhTVmOZi4NoMG1uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDOm/Xguo2zMSam3Mo8LfZPDvvMXxJJPOASYoPQbPP4Zvxq4hST/hcaphiHHZcEPU
         w4g/za7ab2AguDkhxfo1oMkXi8aZYn0aZ4FHGS2XPVT79dlLc/A75erYO9Nzb1rlb/
         WnoKpOmVglbE1xxXPLwBPzWO0DODaTXlrIo9hia5kMXWFlPSRB1FrjDTuEt+8MnkUD
         +gP9oJgLFhUF30nq37lnBkVIf21XfKlUI4XwdR6RHao4ZGZljYsE9Ok0Egn8qQeeEB
         ainxTCK4kEP/xofIrjLEk952jaJkI7yxRuNJIMcLrhhWQNVf6yCqcRDQ9r+siRYlLh
         2/bibDnknevEw==
Date:   Thu, 27 May 2021 11:01:47 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: global-out-of-bounds in move_module
Message-ID: <YK9f+2y3Yz75qmeI@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
References: <20210510202653.gjvqsxacw3hcxfvr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210510202653.gjvqsxacw3hcxfvr@pengutronix.de>
X-OS:   Linux p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de
 5.12.0-2-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Marc Kleine-Budde [10/05/21 22:26 +0200]:
>Hello,
>
>I just noticed on current net-next/master b741596468b0 ("Merge tag
>'riscv-for-linus-5.13-mw1' of
>git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux") on 32 bit
>arm, that modprobe of a module triggers the following KASAN bug:

Hi,

Hm, well I just submitted a module loader fix last week (I have no idea
if the fix is related to this report somehow, but it does bring ARM module
loader behavior up to speed with the other arches). I'm wondering if
you can still reproduce this on -rc3?

>| [  110.241783] ==================================================================
>| [  110.249600] BUG: KASAN: global-out-of-bounds in move_module+0x58/0x208
>| [  110.256253] Write of size 69632 at addr bf030000 by task modprobe/290
>| [  110.262789]
>| [  110.264361] CPU: 0 PID: 290 Comm: modprobe Tainted: G        W         5.12.0-perf+ #7
>| [  110.272373] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>| [  110.278977] Backtrace:
>| [  110.281537] [<c150df20>] (dump_backtrace) from [<c150e430>] (show_stack+0x20/0x24)
>| [  110.289245]  r7:00000080 r6:80010093 r5:00000000 r4:c24c20a0
>| [  110.294981] [<c150e410>] (show_stack) from [<c151e794>] (dump_stack+0xf0/0x118)
>| [  110.302407] [<c151e6a4>] (dump_stack) from [<c1515770>] (print_address_description.constprop.0+0x58/0x210)
>| [  110.312205]  r9:b6e0720e r8:b6e08200 r7:c0273980 r6:00000001 r5:00000000 r4:bf030000
>| [  110.320023] [<c1515718>] (print_address_description.constprop.0) from [<c03da2b4>] (kasan_report+0x11c/0x140)
>| [  110.330088]  r7:c0273980 r6:00000001 r5:00011000 r4:bf030000
>| [  110.335820] [<c03da198>] (kasan_report) from [<c03dae54>] (kasan_check_range+0xcc/0x1a4)
>| [  110.344039]  r7:000001ff r6:b6e081ff r5:bf040fff r4:b6e07210
>| [  110.349772] [<c03dad88>] (kasan_check_range) from [<c03db6e0>] (memset+0x28/0x44)
>| [  110.357386]  r10:cc6a3ef4 r9:f0f1ef18 r8:f0de8740 r7:cc6a3ee0 r6:00000000 r5:bf030000
>| [  110.365296]  r4:00011000 r3:c0273980
>| [  110.368943] [<c03db6b8>] (memset) from [<c0273980>] (move_module+0x58/0x208)
>| [  110.376116]  r7:cc6a3ee0 r6:f0de8880 r5:f0de8884 r4:bf030000
>| [  110.381850] [<c0273928>] (move_module) from [<c0274314>] (layout_and_allocate+0x1bc/0x290)
>| [  110.390233]  r10:cc6a3ef4 r9:f0f1ef18 r8:cc6a3ef0 r7:00000039 r6:cc6a3ee4 r5:cc6a3ee0
>| [  110.398138]  r4:00000000
>| [  110.400743] [<c0274158>] (layout_and_allocate) from [<c0274734>] (load_module+0x34c/0xbe4)
>| [  110.409125]  r10:cc6a0000 r9:b88d47b8 r8:c165cb00 r7:f3f3f3f3 r6:cc6a3e40 r5:cc6a3ee0
>| [  110.417031]  r4:cc6a0000
>| [  110.419634] [<c02743e8>] (load_module) from [<c0275248>] (sys_finit_module+0x110/0x178)
>| [  110.427760]  r10:0000017b r9:00000003 r8:cc6a3ee0 r7:004762d0 r6:00000000 r5:cc6a3f80
>| [  110.435666]  r4:b88d47d4
>| [  110.438273] [<c0275138>] (sys_finit_module) from [<c0100080>] (ret_fast_syscall+0x0/0x2c)
>| [  110.446565] Exception stack(0xcc6a3fa8 to 0xcc6a3ff0)
>| [  110.451708] 3fa0:                   004780c0 00000000 00000003 004762d0 00000000 00477cd0
>| [  110.459983] 3fc0: 004780c0 00000000 98560c00 0000017b 0210a3f8 0048a090 0047544c 0210a360
>| [  110.468246] 3fe0: b6c91978 b6c91968 0046eb0d aea934f2
>| [  110.473388]  r9:cc6a0000 r8:c0100268 r7:0000017b r6:98560c00 r5:00000000 r4:004780c0
>| [  110.481206]
>| [  110.482769]
>| [  110.484329] Memory state around the buggy address:
>| [  110.489199]  bf038f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>| [  110.495812]  bf038f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>| [  110.502419] >bf039000: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 f9 f9
>| [  110.509021]                                                   ^
>| [  110.515018]  bf039080: f9 f9 f9 f9 00 02 f9 f9 f9 f9 f9 f9 00 02 f9 f9
>| [  110.521626]  bf039100: f9 f9 f9 f9 00 02 f9 f9 f9 f9 f9 f9 00 00 00 00
>| [  110.528231] ==================================================================
>
>regards,
>Marc
>
>-- 
>Pengutronix e.K.                 | Marc Kleine-Budde           |
>Embedded Linux                   | https://www.pengutronix.de  |
>Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
>Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


