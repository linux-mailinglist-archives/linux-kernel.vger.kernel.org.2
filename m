Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F19377345
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhEHQvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHQvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 12:51:11 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A020EC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=K6LVt34SQzz13XGIT9Z6S5bUZ33mDxAs2zHLD6vXxQU=; b=qoo6Zh5yQn0s3
        SNwq/ifF29oiT44vaf6AJ6ikM9bhCKKaqdxFVabDvUvydDYSR+oskvLIPy6r6haw
        XJGxuHgLZ8jWvkOLyDwAD/P7PCl8q6/GwYwtMKOxDkdDLTPMpYqBGudXIOMplpxc
        ECtgDRSdxtEJZxEdbmXbXqZR4V0gYo=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDX3Jg0wZZgKLqmAA--.53565S2;
        Sun, 09 May 2021 00:49:57 +0800 (CST)
Date:   Sun, 9 May 2021 00:44:43 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Kossifidis <mick@ics.forth.gr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: kexec: Fix W=1 build warnings
Message-ID: <20210509004443.62c2dd5e@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygDX3Jg0wZZgKLqmAA--.53565S2
X-Coremail-Antispam: 1UD129KBjvJXoWxury3CFW7AFWrAr4kZF4rGrg_yoWrGFykpa
        1qyr1jvrWUWr1Syr1fArn7uw15Ww1DWa4ayrykGF95WF4DK3yUJwnrXw1jka1UKFyFgrn2
        qF1ag3WFkw13C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
        0_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
        6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOoGdUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Fixes the following W=3D1 build warning(s):

In file included from include/linux/kexec.h:28,
                 from arch/riscv/kernel/machine_kexec.c:7:
arch/riscv/include/asm/kexec.h:45:1: warning: =E2=80=98extern=E2=80=99 is n=
ot at beginning of declaration [-Wold-style-declaration]
   45 | const extern unsigned char riscv_kexec_relocate[];
      | ^~~~~
arch/riscv/include/asm/kexec.h:46:1: warning: =E2=80=98extern=E2=80=99 is n=
ot at beginning of declaration [-Wold-style-declaration]
   46 | const extern unsigned int riscv_kexec_relocate_size;
      | ^~~~~
arch/riscv/kernel/machine_kexec.c:125:6: warning: no previous prototype for=
 =E2=80=98machine_shutdown=E2=80=99 [-Wmissing-prototypes]
  125 | void machine_shutdown(void)
      |      ^~~~~~~~~~~~~~~~
arch/riscv/kernel/machine_kexec.c:147:1: warning: no previous prototype for=
 =E2=80=98machine_crash_shutdown=E2=80=99 [-Wmissing-prototypes]
  147 | machine_crash_shutdown(struct pt_regs *regs)
      | ^~~~~~~~~~~~~~~~~~~~~~
arch/riscv/kernel/machine_kexec.c:23: warning: Function parameter or member=
 'image' not described in 'kexec_image_info'
arch/riscv/kernel/machine_kexec.c:53: warning: Function parameter or member=
 'image' not described in 'machine_kexec_prepare'
arch/riscv/kernel/machine_kexec.c:114: warning: Function parameter or membe=
r 'image' not described in 'machine_kexec_cleanup'
arch/riscv/kernel/machine_kexec.c:148: warning: Function parameter or membe=
r 'regs' not described in 'machine_crash_shutdown'
arch/riscv/kernel/machine_kexec.c:167: warning: Function parameter or membe=
r 'image' not described in 'machine_kexec'

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/kexec.h    |  4 ++--
 arch/riscv/kernel/machine_kexec.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index 1e954101906a..e4e291d40759 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -42,8 +42,8 @@ struct kimage_arch {
 	unsigned long fdt_addr;
 };
=20
-const extern unsigned char riscv_kexec_relocate[];
-const extern unsigned int riscv_kexec_relocate_size;
+extern const unsigned char riscv_kexec_relocate[];
+extern const unsigned int riscv_kexec_relocate_size;
=20
 typedef void (*riscv_kexec_method)(unsigned long first_ind_entry,
 				   unsigned long jump_addr,
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_=
kexec.c
index cc048143fba5..9e99e1db156b 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -14,8 +14,9 @@
 #include <asm/set_memory.h>	/* For set_memory_x() */
 #include <linux/compiler.h>	/* For unreachable() */
 #include <linux/cpu.h>		/* For cpu_down() */
+#include <linux/reboot.h>
=20
-/**
+/*
  * kexec_image_info - Print received image details
  */
 static void
@@ -39,7 +40,7 @@ kexec_image_info(const struct kimage *image)
 	}
 }
=20
-/**
+/*
  * machine_kexec_prepare - Initialize kexec
  *
  * This function is called from do_kexec_load, when the user has
@@ -100,7 +101,7 @@ machine_kexec_prepare(struct kimage *image)
 }
=20
=20
-/**
+/*
  * machine_kexec_cleanup - Cleanup any leftovers from
  *			   machine_kexec_prepare
  *
@@ -135,7 +136,7 @@ void machine_shutdown(void)
 #endif
 }
=20
-/**
+/*
  * machine_crash_shutdown - Prepare to kexec after a kernel crash
  *
  * This function is called by crash_kexec just before machine_kexec
@@ -151,7 +152,7 @@ machine_crash_shutdown(struct pt_regs *regs)
 	pr_info("Starting crashdump kernel...\n");
 }
=20
-/**
+/*
  * machine_kexec - Jump to the loaded kimage
  *
  * This function is called by kernel_kexec which is called by the
--=20
2.31.0


