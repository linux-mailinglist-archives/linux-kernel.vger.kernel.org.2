Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63B63E0606
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbhHDQhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhHDQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:37:18 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FE64C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Juw2cquMzDaAGLJ5HN2u+Sjovrp9iaYMrFDeyu1bTo4=; b=qayyDRT0YgUuF
        AKTemStdlBo34Sr+cDLQ6lsgAwYlmxmprLArXWyQM9HGAi97H1b2EySRIXvHd/ym
        edg4oWGgbEUdC6SqaI0bY5NkwZ1Dat4wvsqhe7uByKoOQRSjMJimxMuUdsGSqyQg
        63a4zhKyzs5nevr0mmxiH512D0QmoI=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBnbPwtwgphJO2UAA--.18797S2;
        Thu, 05 Aug 2021 00:37:01 +0800 (CST)
Date:   Thu, 5 Aug 2021 00:30:59 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Enable Undefined Behavior Sanitizer UBSAN
Message-ID: <20210805003059.26b03ec0@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBnbPwtwgphJO2UAA--.18797S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy3GrWrWw1UAr48XF4ruFg_yoW8Wry3pw
        sYkrn3CrWUGrs5WF4Iy3y8uFyUtan3Xw4agF4qyay5JrWfCr90yw4qvwsIqr1UXFWDArWS
        kF98u347tr17J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUySb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC2
        0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
        vaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5BMNUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Select ARCH_HAS_UBSAN_SANITIZE_ALL in order to allow the user to
enable CONFIG_UBSAN_SANITIZE_ALL and instrument the entire kernel for
ubsan checks.

VDSO is excluded because its build doesn't include the
__ubsan_handle_*() functions from lib/ubsan.c, and the VDSO has no
sane way to report errors even if it has definitions of these functions.

Passed lib/test_ubsan.c test.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig              | 1 +
 arch/riscv/kernel/vdso/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f133ac72572f..cccb95bf8331 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -28,6 +28,7 @@ config RISCV
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 24d936c147cd..30a5335bd317 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -36,6 +36,7 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
 GCOV_PROFILE := n
 KCOV_INSTRUMENT := n
 KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
 
 # Force dependency
 $(obj)/vdso.o: $(obj)/vdso.so
-- 
2.32.0


