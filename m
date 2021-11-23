Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7050945AC84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhKWTgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:36:32 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57098 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229891AbhKWTga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:36:30 -0500
Received: from ip5f5b2004.dynamic.kabel-deutschland.de ([95.91.32.4] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mpbXb-0001xe-3l; Tue, 23 Nov 2021 20:33:19 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     guoren@kernel.org, anup@brainfault.org, palmer@dabbelt.com,
        atishp@rivosinc.com, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        guoren@kernel.org, philipp.tomsich@vrull.eu
Subject: Re: [RFC PATCH 0/3] riscv: Add riscv.fwsz kernel parameter to save memory
Date:   Tue, 23 Nov 2021 20:33:18 +0100
Message-ID: <1913356.JkcO0Xq8vV@diego>
In-Reply-To: <20211123015717.542631-1-guoren@kernel.org>
References: <20211123015717.542631-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

Am Dienstag, 23. November 2021, 02:57:14 CET schrieb guoren@kernel.org:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The firmware of riscv (such as opensbi) occupy 2MB(64bit) /
> 4MB(32bit) in Linux. It's very wasteful to small memory footprint
> soc chip such as Allwinner D1s/F133. The kernel parameter gives a
> chance to users to set the proper size of the firmware and get
> more than 1.5MB of memory.

is this kernel parameter approach a result of the T-Head Ice-SoC
currently loading its openSBI from inside the main u-boot via extfs-load,
directly before the kernel itself [0] ?

Because that approach in general looks not ideal.

Normally you want the main u-boot already running with less privileges
so firmware like openSBI should've been already loaded before that.
Even more true when you're employing methods to protect memory regions
from less privileged access.

A lot of socs set u-boot as opensbi payload, but for the example the D1
mainline approach uses the Allwinner TOC1 image format to load both
opensbi and the main uboot into memory from its 1st stage loader.


Of course the best way would be to just mimic what a number of
arm64 and also riscv socs do and use already existing u-boot utilities.

U-Boot can create a FIT image containing both main u-boot, dtb and
firmware images that all get loaded from SPL and placed at the correct
addresses before having the SPL jump into opensbi and from there
into u-boot [1] .

And as Anup was writing, reserved-memory should then be the way
to go to tell the kernel what regions to omit.

And mainline u-boot has already the means to even take the reserved-memory
from the devicetree used by opensbi and copy it to a new devicetree,
if the second one is different.


Heiko


[0] https://github.com/T-head-Semi/u-boot/blob/main/include/configs/ice-c910.h#L46
[1] see spl_invoke_opensbi() in common/spl/spl_opensbi.c
[2] see riscv_board_reserved_mem_fixup() in arch/riscv/lib/fdt_fixup.c

> 
> Guo Ren (3):
>   riscv: Remove 2MB offset in the mm layout
>   riscv: Add early_param to decrease firmware region
>   riscv: Add riscv.fwsz kernel parameter
> 
>  .../admin-guide/kernel-parameters.txt         |  3 +++
>  arch/riscv/include/asm/page.h                 |  8 +++++++
>  arch/riscv/kernel/head.S                      | 10 +++-----
>  arch/riscv/kernel/vmlinux.lds.S               |  5 ++--
>  arch/riscv/mm/init.c                          | 23 ++++++++++++++++---
>  5 files changed, 36 insertions(+), 13 deletions(-)
> 
> 




