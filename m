Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227083FADF6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhH2S4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 14:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhH2S4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:56:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0B4860E77;
        Sun, 29 Aug 2021 18:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630263320;
        bh=EvJr0ZYt81aaKcUVn3EOQQ1cUYFuWczycw/vv7zPZdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2YD02v8Zwcl4YRbPGg9oazZUjwuXez1mhOCjsJVMVRePMomto09bArkfx8ZqXicU
         eu7uv7nkIAMf/Pa2ApZxjioLo70VRBqmllRQ8MGZIJqWrdQUTIP6yU857OguFf2s3s
         V3A9h8HTkQq6JytZuGW1p4VrpqOZU5PAu8aozCG/Yzn+Cz4i2OMAQOHBARsN+bgOQU
         RKaSxuwPfuqlqJC9Zy20/t6dzZbqrkBR4/zsBgzliM2sXMaFtKdBolyCi+rt5th7w1
         hKkQ4L7blEZr60TFlIsy3eWYxrL+3fS2m4AlaspHZRw//w9xSn/kGGMmQIe5tlfoLU
         9/0c56msiS9ZA==
Date:   Sun, 29 Aug 2021 11:55:17 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 4/4] powerpc/ptdump: Convert powerpc to GENERIC_PTDUMP
Message-ID: <YSvYFTSwP5EkXQZ0@Ryzen-9-3900X.localdomain>
References: <b864a92693ca8413ef0b19f0c12065c212899b6e.1625762905.git.christophe.leroy@csgroup.eu>
 <03166d569526be70214fe9370a7bad219d2f41c8.1625762907.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03166d569526be70214fe9370a7bad219d2f41c8.1625762907.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Thu, Jul 08, 2021 at 04:49:43PM +0000, Christophe Leroy wrote:
> This patch converts powerpc to the generic PTDUMP implementation.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

This patch as commit e084728393a5 ("powerpc/ptdump: Convert powerpc to
GENERIC_PTDUMP") in powerpc/next causes a panic with Fedora's ppc64le
config [1] when booting up in QEMU with [2]:

[    1.621864] BUG: Unable to handle kernel data access on read at 0xc0eeff7f00000000
[    1.623058] Faulting instruction address: 0xc00000000045e5fc
[    1.623832] Oops: Kernel access of bad area, sig: 11 [#1]
[    1.624318] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA PowerNV
[    1.625015] Modules linked in:
[    1.625463] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc7-next-20210827 #16
[    1.626237] NIP:  c00000000045e5fc LR: c00000000045e580 CTR: c000000000518220
[    1.626839] REGS: c00000000752b820 TRAP: 0380   Not tainted  (5.14.0-rc7-next-20210827)
[    1.627528] MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 84002482  XER: 20000000
[    1.628449] CFAR: c000000000518300 IRQMASK: 0
[    1.628449] GPR00: c00000000045e580 c00000000752bac0 c0000000028a9300 0000000000000000
[    1.628449] GPR04: c200800000000000 ffffffffffffffff 000000000000000a 0000000000000001
[    1.628449] GPR08: c0eeff7f00000000 0000000000000012 0000000000000000 0000000000000000
[    1.628449] GPR12: 0000000000000000 c000000002b20000 fffffffffffffffe c000000002971a70
[    1.628449] GPR16: c000000002960040 c0000000011a8f98 c00000000752bbf0 ffffffffffffffff
[    1.628449] GPR20: c2008fffffffffff c0eeff7f00000000 c000000002971a68 c00a0003ff000000
[    1.628449] GPR24: c000000002971a78 0000000000000002 0000000000000001 c0000000011a8f98
[    1.628449] GPR28: c0000000011a8f98 c0000000028daef8 c200800000000000 c200900000000000
[    1.634090] NIP [c00000000045e5fc] __walk_page_range+0x2bc/0xce0
[    1.635117] LR [c00000000045e580] __walk_page_range+0x240/0xce0
[    1.635755] Call Trace:
[    1.636018] [c00000000752bac0] [c00000000045e580] __walk_page_range+0x240/0xce0 (unreliable)
[    1.636811] [c00000000752bbd0] [c00000000045f234] walk_page_range_novma+0x74/0xb0
[    1.637459] [c00000000752bc20] [c000000000518448] ptdump_walk_pgd+0x98/0x170
[    1.638138] [c00000000752bc70] [c0000000000aa988] ptdump_check_wx+0x88/0xd0
[    1.638738] [c00000000752bd50] [c00000000008d6d8] mark_rodata_ro+0x48/0x80
[    1.639299] [c00000000752bdb0] [c000000000012a34] kernel_init+0x74/0x1a0
[    1.639842] [c00000000752be10] [c00000000000cfd4] ret_from_kernel_thread+0x5c/0x64
[    1.640597] Instruction dump:
[    1.641021] 38e7ffff 39490010 7ce707b4 7fca5436 79081564 7d4a3838 7908f082 794a1f24
[    1.641740] 78a8f00e 30e6ffff 7ea85214 7ce73110 <7d48502a> 78f90fa4 2c2a0000 39290010
[    1.642771] ---[ end trace 6cf72b085097ad52 ]---
[    1.643220]
[    2.644228] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    2.645523] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

This is not compiler specific, I can reproduce it with GCC 11.2.0 and
binutils 2.37. If there is any additional information I can provide,
please let me know.

[1]: https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-ppc64le-fedora.config
[2]: https://github.com/ClangBuiltLinux/boot-utils

Cheers,
Nathan
