Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C22B352B0B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhDBNeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBNeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:34:36 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D398C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=79odaMnTT9R2qi2lfpKGnNp4FQRgM5yuMypKBy3IvUw=; b=GV+SI9/xzy2LS
        Q5Y8eXoABSerD/DKPBfVVMjUV4mL6VoIhL5ar1m+xVSuQ2++r8dBt+NWy4L0G09L
        S4ScikiqZ9kLuOPaLsWK+FI38USXOfZ3ZPksNfJdwSPd8XHL1xcv+yPpXD5VvUNh
        BjEDeoayxrrgmFY7x7lkcvdpg5Mw9c=
Received: from xhacker (unknown [101.86.19.180])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBX+phgHWdgkQCLAA--.61503S2;
        Fri, 02 Apr 2021 21:34:25 +0800 (CST)
Date:   Fri, 2 Apr 2021 21:29:08 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] riscv: vdso: fix and clean-up Makefile
Message-ID: <20210402212908.6f9b9686@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBX+phgHWdgkQCLAA--.61503S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyfWF17AFyxur4kKw45Wrg_yoW8tw1Upa
        13Kw1kurZ8CrWUCay7tF13u3yUuFZ3Gw13CFy8AF45Crs3tF4ak3saqF13WF15GF1xA3yU
        tFWUuws0ya18Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
        GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5PpnJUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Running "make" on an already compiled kernel tree will rebuild the
kernel even without any modifications:

  CALL    linux/scripts/checksyscalls.sh
  CALL    linux/scripts/atomic/check-atomics.sh
  CHK     include/generated/compile.h
  SO2S    arch/riscv/kernel/vdso/vdso-syms.S
  AS      arch/riscv/kernel/vdso/vdso-syms.o
  AR      arch/riscv/kernel/vdso/built-in.a
  AR      arch/riscv/kernel/built-in.a
  AR      arch/riscv/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o

The reason is "Any target that utilizes if_changed must be listed in
$(targets), otherwise the command line check will fail, and the target
will always be built" as explained by Documentation/kbuild/makefiles.rst

Fix this build bug by adding vdso-syms.S to $(targets)

At the same time, there are two trivial clean up modifications:

- the vdso-dummy.o is not needed any more after so remove it.

- vdso.lds is a generated file, so it should be prefixed with
  $(obj)/ instead of $(src)/

Fixes: c2c81bb2f691 ("RISC-V: Fix the VDSO symbol generaton for binutils-2.35+")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 71a315e73cbe..7b9f505ba82f 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -23,7 +23,7 @@ ifneq ($(c-gettimeofday-y),)
 endif
 
 # Build rules
-targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds vdso-dummy.o
+targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds vdso-syms.S
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
 obj-y += vdso.o vdso-syms.o
@@ -42,7 +42,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
 
 # link rule for the .so file, .lds has to be first
 SYSCFLAGS_vdso.so.dbg = $(c_flags)
-$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
 SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
 	-Wl,--build-id=sha1 -Wl,--hash-style=both
-- 
2.31.0


