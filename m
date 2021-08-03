Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5FA3DF1D7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhHCPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbhHCPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:55:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D9EC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:54:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p5so25863042wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4rRxOqndw+1zKo/Fz0CrxbEOnI7kW3ZlML/LmcKYE0=;
        b=MDbE2PdyGBG8ei9sVkfUOygZ+GxMegR6jkN2XSgREmgePZpxhAzdOzrxh9+HP1gTan
         UA/XnFnSMjVX7Zmr1kpbhpWkb6kEHDb946ejhJume/RoPWMWG3XpZNipDOQfNPH4MYgN
         747RwZX/Dy98IOw9NbhFU6leeEhnjcLep869PMhcTuZrUcmWhNk6GenkV15saiiM1EhP
         K/ByNTvOXPyERdawyUYdvA6gGkEAL+npgT301BxShTmysHNhYyvkOxrhx/a+YTl0vRAP
         hdPF1+0uOPDZNCeYueI/1Ld65+tK8Ibt+VyVw1jTj6W3XP80kO6QGBoBEs7ocyYwI8fV
         Dqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4rRxOqndw+1zKo/Fz0CrxbEOnI7kW3ZlML/LmcKYE0=;
        b=oKJIuc26luujfzx0gOu4s+QfVgdXPi9i5VWWXz0hOxBuUR5cDV6pt0ZruZ1Pbfjpph
         zk8puyrf/KrSFKy2BjCX/4x6iRFLgS4aCDdkticCgG+aYb5Nb7ZqrRZ3BqEYrooe0YtN
         Cz5nI1i2Uh5V8Qek4AHDLtBk3pxc6rcehQvxkIBxkLMSrr9/3p7SKVmRcJ2OcVl0Ogw5
         zzFmzLVHPSJ5Z6QXobBG9lG8/yKk9D+x0gTlzC4Z3EobH1bYS8oMhg4SzZqRmU0a/hQF
         ao/Tzt2LqWrXfc5iYJS0djfwDcFoS3cxGsTZXN6kTNS8IILWSpukQhW5S9MOpCWwsBmT
         t37g==
X-Gm-Message-State: AOAM530yzRYR1L0qEfxE6KLbrdpqHT9J6r8u3pnw9EGQiH4I87RzJEI/
        2TokPMXwN/w0vBI7n0hQw0ZRScYey3ZtKw==
X-Google-Smtp-Source: ABdhPJwDS0Lv49BrcXo0x4vTERnM3Qm7Iqg+oz0sIiTUzEDFPROUoyCwXaRZfq+iPyI7sBaqP6vwaA==
X-Received: by 2002:adf:d22f:: with SMTP id k15mr24098214wrh.335.1628006097056;
        Tue, 03 Aug 2021 08:54:57 -0700 (PDT)
Received: from localhost.localdomain ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id c10sm14058863wmb.40.2021.08.03.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:54:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arch: Export machine_restart() instances so they can be called from modules
Date:   Tue,  3 Aug 2021 16:54:50 +0100
Message-Id: <20210803155452.435812-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803155452.435812-1-lee.jones@linaro.org>
References: <20210803155452.435812-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent attempt to convert the Power Reset Restart driver to tristate
failed because of the following compile error (reported once merged by
Stephen Rothwell via Linux Next):

  ERROR: "machine_restart" [drivers/power/reset/restart-poweroff.ko] undefined!

This error occurs since some of the machine_restart() instances are
not currently exported for use in modules.  This patch aims to rectify
that.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

NB: If it's safe to omit some of these, let me know and I'll revise the patch.

 arch/arc/kernel/reset.c            | 1 +
 arch/arm/kernel/reboot.c           | 1 +
 arch/arm64/kernel/process.c        | 1 +
 arch/csky/kernel/power.c           | 1 +
 arch/h8300/kernel/process.c        | 1 +
 arch/hexagon/kernel/reset.c        | 1 +
 arch/m68k/kernel/process.c         | 1 +
 arch/microblaze/kernel/reset.c     | 1 +
 arch/mips/kernel/reset.c           | 1 +
 arch/mips/lantiq/falcon/reset.c    | 1 +
 arch/mips/sgi-ip27/ip27-reset.c    | 1 +
 arch/nios2/kernel/process.c        | 1 +
 arch/openrisc/kernel/process.c     | 1 +
 arch/parisc/kernel/process.c       | 1 +
 arch/powerpc/kernel/setup-common.c | 1 +
 arch/riscv/kernel/reset.c          | 1 +
 arch/s390/kernel/setup.c           | 1 +
 arch/sh/kernel/reboot.c            | 1 +
 arch/sparc/kernel/process_32.c     | 1 +
 arch/sparc/kernel/reboot.c         | 1 +
 arch/um/kernel/reboot.c            | 1 +
 arch/x86/kernel/reboot.c           | 1 +
 arch/xtensa/kernel/setup.c         | 1 +
 23 files changed, 23 insertions(+)

diff --git a/arch/arc/kernel/reset.c b/arch/arc/kernel/reset.c
index fd6c3eb930bad..ae4f8a43b0af4 100644
--- a/arch/arc/kernel/reset.c
+++ b/arch/arc/kernel/reset.c
@@ -20,6 +20,7 @@ void machine_restart(char *__unused)
 	pr_info("Put your restart handler here\n");
 	machine_halt();
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_power_off(void)
 {
diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 0ce388f154226..2878260efd130 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -150,3 +150,4 @@ void machine_restart(char *cmd)
 	printk("Reboot failed -- System halted\n");
 	while (1);
 }
+EXPORT_SYMBOL(machine_restart);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b4bb67f17a2ca..cf89ce91d7145 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -212,6 +212,7 @@ void machine_restart(char *cmd)
 	printk("Reboot failed -- System halted\n");
 	while (1);
 }
+EXPORT_SYMBOL(machine_restart);
 
 #define bstr(suffix, str) [PSR_BTYPE_ ## suffix >> PSR_BTYPE_SHIFT] = str
 static const char *const btypes[] = {
diff --git a/arch/csky/kernel/power.c b/arch/csky/kernel/power.c
index 923ee4e381b81..b466c825cbb3c 100644
--- a/arch/csky/kernel/power.c
+++ b/arch/csky/kernel/power.c
@@ -28,3 +28,4 @@ void machine_restart(char *cmd)
 	do_kernel_restart(cmd);
 	asm volatile ("bkpt");
 }
+EXPORT_SYMBOL(machine_restart);
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 46b1342ce515b..8203ac5cd33ec 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -66,6 +66,7 @@ void machine_restart(char *__unused)
 	local_irq_disable();
 	__asm__("jmp @@0");
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/hexagon/kernel/reset.c b/arch/hexagon/kernel/reset.c
index da36114d928f0..433378d52063c 100644
--- a/arch/hexagon/kernel/reset.c
+++ b/arch/hexagon/kernel/reset.c
@@ -19,6 +19,7 @@ void machine_halt(void)
 void machine_restart(char *cmd)
 {
 }
+EXPORT_SYMBOL(machine_restart);
 
 void (*pm_power_off)(void) = NULL;
 EXPORT_SYMBOL(pm_power_off);
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index da83cc83e7912..e0264704686e9 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -57,6 +57,7 @@ void machine_restart(char * __unused)
 		mach_reset();
 	for (;;);
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/microblaze/kernel/reset.c b/arch/microblaze/kernel/reset.c
index 5f4722908164d..902fbe3777846 100644
--- a/arch/microblaze/kernel/reset.c
+++ b/arch/microblaze/kernel/reset.c
@@ -41,3 +41,4 @@ void machine_restart(char *cmd)
 	pr_emerg("Reboot failed -- System halted\n");
 	while (1);
 }
+EXPORT_SYMBOL(machine_restart);
diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 6288780b779e7..2d3193a3cf68b 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -99,6 +99,7 @@ void machine_restart(char *command)
 	pr_emerg("Reboot failed -- System halted\n");
 	machine_hang();
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/mips/lantiq/falcon/reset.c b/arch/mips/lantiq/falcon/reset.c
index 261996c230cf6..80dd9759ffa55 100644
--- a/arch/mips/lantiq/falcon/reset.c
+++ b/arch/mips/lantiq/falcon/reset.c
@@ -51,6 +51,7 @@ static void machine_restart(char *command)
 		(void *)WDT_REG_BASE);
 	unreachable();
 }
+EXPORT_SYMBOL(machine_restart);
 
 static void machine_halt(void)
 {
diff --git a/arch/mips/sgi-ip27/ip27-reset.c b/arch/mips/sgi-ip27/ip27-reset.c
index 5ac5ad6387343..a3f8f4498b7c5 100644
--- a/arch/mips/sgi-ip27/ip27-reset.c
+++ b/arch/mips/sgi-ip27/ip27-reset.c
@@ -29,6 +29,7 @@
 #include "ip27-common.h"
 
 void machine_restart(char *command) __noreturn;
+EXPORT_SYMBOL(machine_restart);
 void machine_halt(void) __noreturn;
 void machine_power_off(void) __noreturn;
 
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index c5f916ca6845f..6f9459e8ae4ed 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -51,6 +51,7 @@ void machine_restart(char *__unused)
 	: "r" (cpuinfo.reset_addr)
 	: "r4");
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index eb62429681fc8..12c3022c46387 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -61,6 +61,7 @@ void machine_restart(char *cmd)
 	pr_emerg("Reboot failed -- System halted\n");
 	while (1);
 }
+EXPORT_SYMBOL(machine_restart);
 
 /*
  * Similar to machine_power_off, but don't shut off power.  Add code
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index b144fbe29bc16..05e9f03124b64 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -96,6 +96,7 @@ void machine_restart(char *cmd)
 	while (1) ;
 
 }
+EXPORT_SYMBOL(machine_restart);
 
 void (*chassis_power_off)(void);
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 74a98fff2c2f9..54ebae540dd7d 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -159,6 +159,7 @@ void machine_restart(char *cmd)
 
 	machine_hang();
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_power_off(void)
 {
diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index ee5878d968cc1..596a36b91eaa2 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -20,6 +20,7 @@ void machine_restart(char *cmd)
 	do_kernel_restart(cmd);
 	while (1);
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 5aab59ad56881..fd2394af0d43a 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -276,6 +276,7 @@ void machine_restart(char *command)
 		console_unblank();
 	_machine_restart(command);
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index 5c33f036418be..36b6c61f3b129 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -83,6 +83,7 @@ void machine_restart(char *cmd)
 {
 	machine_ops.restart(cmd);
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 3b9794978e5bc..30a1674683946 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -104,6 +104,7 @@ void machine_restart(char * cmd)
 	prom_feval ("reset");
 	panic("Reboot failed!");
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_power_off(void)
 {
diff --git a/arch/sparc/kernel/reboot.c b/arch/sparc/kernel/reboot.c
index 69c1b6c047d53..53adef425d7de 100644
--- a/arch/sparc/kernel/reboot.c
+++ b/arch/sparc/kernel/reboot.c
@@ -52,4 +52,5 @@ void machine_restart(char *cmd)
 	prom_reboot("");
 	panic("Reboot failed!");
 }
+EXPORT_SYMBOL(machine_restart);
 
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 48c0610d506e0..4b764311efb89 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -47,6 +47,7 @@ void machine_restart(char * __unused)
 	uml_cleanup();
 	reboot_skas();
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_power_off(void)
 {
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index b29657b76e3fa..b48c30ead7167 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -733,6 +733,7 @@ static void native_machine_restart(char *__unused)
 		machine_shutdown();
 	__machine_emergency_restart(0);
 }
+EXPORT_SYMBOL(machine_restart);
 
 static void native_machine_halt(void)
 {
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index ed184106e4cf9..a84cc934300d5 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -564,6 +564,7 @@ void machine_restart(char * cmd)
 {
 	platform_restart();
 }
+EXPORT_SYMBOL(machine_restart);
 
 void machine_halt(void)
 {
-- 
2.32.0.554.ge1b32706d8-goog

