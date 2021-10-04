Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59DE4209F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhJDLTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232395AbhJDLTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:19:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B488F6124C;
        Mon,  4 Oct 2021 11:18:00 +0000 (UTC)
Date:   Mon, 4 Oct 2021 13:17:58 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Brauner <christian@brauner.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] RISC-V: Include clone3() on rv32
Message-ID: <20211004111758.rl2zq6l575hmcv22@wittgenstein>
References: <20211003002120.198752-1-palmer@dabbelt.com>
 <CAK8P3a1rwMWQSmdW4ARkk6swT9VC2Fcx5nBWVugSOuhv8o7QHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1rwMWQSmdW4ARkk6swT9VC2Fcx5nBWVugSOuhv8o7QHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 05:30:24PM +0200, Arnd Bergmann wrote:
> On Sun, Oct 3, 2021 at 2:58 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > From: Palmer Dabbelt <palmerdabbelt@google.com>
> >
> > As far as I can tell this should be enabled on rv32 as well, I'm not
> > sure why it's rv64-only.  checksyscalls is complaining about our lack of
> > clone3() on rv32.
> >
> > Fixes: 56ac5e213933 ("riscv: enable sys_clone3 syscall for rv64")
> > Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> We should probably reverse the polarity of this symbol and force
> architectures that don't implement it properly to say they don't
> have it, but for now, it definitely makes sense to treat this the same
> way on 32-bit and 64-bit risc-v.

I think we had that discussion back when I added it and I think I even
proposed that or you did but then we settled on __ARCH_WANT_SYS_CLONE3.
Most likely because it fell in line with the other
__ARCH_WANT_SYS_{CLONE,FORK}.

I think at this point its alpha, ia64, nios, sparc, and sh that don't
implement it. For some it looks trivial at first glance at least (Fwiw,
nios implements sys_clone() but doesn't select __ARCH_WANT_SYS_CLONE3):

diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
index 0b4bb1d41b28..6c4f45abd3ab 100644
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -18,6 +18,7 @@

  #define sys_mmap2 sys_mmap_pgoff

+#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SET_GET_RLIMIT
diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
index 0794cd7803df..c1804bda8259 100644
--- a/arch/nios2/kernel/entry.S
+++ b/arch/nios2/kernel/entry.S
@@ -396,6 +396,15 @@ ENTRY(sys_clone)
        RESTORE_SWITCH_STACK
        ret

+/*
+ * int clone3(struct clone_args __user *, uargs, size_t, size)
+ */
+ENTRY(sys_clone3)
+       SAVE_SWITCH_STACK
+       call    sys_clone3
+       RESTORE_SWITCH_STACK
+       ret
+
 ENTRY(sys_rt_sigreturn)
        SAVE_SWITCH_STACK
        mov     r4, sp

