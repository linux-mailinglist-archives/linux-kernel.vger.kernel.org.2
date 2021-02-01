Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6097130AC50
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBAQJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhBAQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:09:22 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F18C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DlMrAW06ad5RC0MRLVNOJzQJoLkaCpjO7v7rgY5Ww7g=; b=eOj9UAzVOYtYpXFHFGm00e79X
        mA7Dqv7PbJSlVoLpMS83ifwNOZ77vwA8WQeQgSgfKs+YBoT/NQAC5C+4gxXAp4qaQSHwXWMctXSDb
        HcqbTUELkxg2H1OJFb38mLg5OQMskTlUuDBgIT6b4XwzF46YRkArYTGA9HHU5lDyzh0DLymh3EXBj
        okEE0Bpl0Xg4lRr/62IxHoGsPaR2aU5dDPRVasiRFQDkin09B/oXiZjnEElzB8TD0NiwLxl4/Gmsu
        D8mUlQJJ90XQpoqEZapDSv5DFRZF32JVL7eKYHD//gcb8EI1WxN1NCLX9WTndIBtGEVGNiZT1M1DR
        YyIN0gaDA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37808)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l6bkl-0003Tw-Iw; Mon, 01 Feb 2021 16:08:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l6bkk-00028g-DK; Mon, 01 Feb 2021 16:08:38 +0000
Date:   Mon, 1 Feb 2021 16:08:38 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>,
        linux-kernel@vger.kernel.org, penberg@kernel.org,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201160838.GH1463@shell.armlinux.org.uk>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201130344.GF1463@shell.armlinux.org.uk>
 <20210201135714.GB66060@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201135714.GB66060@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 01:57:14PM +0000, Mark Rutland wrote:
> We could simplify this slightly if we moved the kexec_& variables into a
> struct (using asm-offset KEXEC_VAR_* offsets and a KEXEC_VAR_SIZE region
> reserved in the asm), then here we could do something like:
> 
> static struct kexec_vars *kexec_buffer_vars(void *buffer)
> {
> 	unsigned long code = ((unisigned long)relocate_new_kernel) & ~1;
> 	unsigned long vars - (unsigned long)relocate_vars;
> 	unsigned long offset = vars - code;
> 
> 	return buffer + offset;
> }
> 
> ... and in machine_kexec() do:
> 
> 	struct kexec_vars *kv = kexec_buffer_vars(reboot_code_buffer);
> 
> 	kv->start_address = image->start;
> 	kv->indirection_page = page_list;
> 	kv->mach_type = machine-arch_type;
> 	kv->boot_atags = arch.kernel_r2;
> 
> ... if that looks any better to you?

Something like this?

diff --git a/arch/arm/include/asm/kexec-internal.h b/arch/arm/include/asm/kexec-internal.h
new file mode 100644
index 000000000000..ecc2322db7aa
--- /dev/null
+++ b/arch/arm/include/asm/kexec-internal.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ARM_KEXEC_INTERNAL_H
+#define _ARM_KEXEC_INTERNAL_H
+
+struct kexec_relocate_data {
+	unsigned long kexec_start_address;
+	unsigned long kexec_indirection_page;
+	unsigned long kexec_mach_type;
+	unsigned long kexec_r2;
+};
+
+#endif
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index a1570c8bab25..be8050b0c3df 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <asm/cacheflush.h>
+#include <asm/kexec-internal.h>
 #include <asm/glue-df.h>
 #include <asm/glue-pf.h>
 #include <asm/mach/arch.h>
@@ -170,5 +171,9 @@ int main(void)
   DEFINE(MPU_RGN_PRBAR,	offsetof(struct mpu_rgn, prbar));
   DEFINE(MPU_RGN_PRLAR,	offsetof(struct mpu_rgn, prlar));
 #endif
+  DEFINE(KEXEC_START_ADDR,	offsetof(struct kexec_relocate_data, kexec_start_address));
+  DEFINE(KEXEC_INDIR_PAGE,	offsetof(struct kexec_relocate_data, kexec_indirection_page));
+  DEFINE(KEXEC_MACH_TYPE,	offsetof(struct kexec_relocate_data, kexec_mach_type));
+  DEFINE(KEXEC_R2,		offsetof(struct kexec_relocate_data, kexec_r2));
   return 0; 
 }
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 5d84ad333f05..2b09dad7935e 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -13,6 +13,7 @@
 #include <linux/of_fdt.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
+#include <asm/kexec-internal.h>
 #include <asm/fncpy.h>
 #include <asm/mach-types.h>
 #include <asm/smp_plat.h>
@@ -22,11 +23,6 @@
 extern void relocate_new_kernel(void);
 extern const unsigned int relocate_new_kernel_size;
 
-extern unsigned long kexec_start_address;
-extern unsigned long kexec_indirection_page;
-extern unsigned long kexec_mach_type;
-extern unsigned long kexec_boot_atags;
-
 static atomic_t waiting_for_crash_ipi;
 
 /*
@@ -159,6 +155,7 @@ void (*kexec_reinit)(void);
 void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list, reboot_entry_phys;
+	struct kexec_relocate_data *data;
 	void (*reboot_entry)(void);
 	void *reboot_code_buffer;
 
@@ -174,18 +171,17 @@ void machine_kexec(struct kimage *image)
 
 	reboot_code_buffer = page_address(image->control_code_page);
 
-	/* Prepare parameters for reboot_code_buffer*/
-	set_kernel_text_rw();
-	kexec_start_address = image->start;
-	kexec_indirection_page = page_list;
-	kexec_mach_type = machine_arch_type;
-	kexec_boot_atags = image->arch.kernel_r2;
-
 	/* copy our kernel relocation code to the control code page */
 	reboot_entry = fncpy(reboot_code_buffer,
 			     &relocate_new_kernel,
 			     relocate_new_kernel_size);
 
+	data = reboot_code_buffer + relocate_new_kernel_size;
+	data->kexec_start_address = image->start;
+	data->kexec_indirection_page = page_list;
+	data->kexec_mach_type = machine_arch_type;
+	data->kexec_r2 = image->arch.kernel_r2;
+
 	/* get the identity mapping physical address for the reboot code */
 	reboot_entry_phys = virt_to_idmap(reboot_entry);
 
diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index 72a08786e16e..218d524360fc 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -5,14 +5,16 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/asm-offsets.h>
 #include <asm/kexec.h>
 
 	.align	3	/* not needed for this code, but keeps fncpy() happy */
 
 ENTRY(relocate_new_kernel)
 
-	ldr	r0,kexec_indirection_page
-	ldr	r1,kexec_start_address
+	adr	r7, relocate_new_kernel_end
+	ldr	r0, [r7, #KEXEC_INDIR_PAGE]
+	ldr	r1, [r7, #KEXEC_START_ADDR]
 
 	/*
 	 * If there is no indirection page (we are doing crashdumps)
@@ -57,34 +59,16 @@ ENTRY(relocate_new_kernel)
 
 2:
 	/* Jump to relocated kernel */
-	mov lr,r1
-	mov r0,#0
-	ldr r1,kexec_mach_type
-	ldr r2,kexec_boot_atags
- ARM(	ret lr	)
- THUMB(	bx lr		)
-
-	.align
-
-	.globl kexec_start_address
-kexec_start_address:
-	.long	0x0
-
-	.globl kexec_indirection_page
-kexec_indirection_page:
-	.long	0x0
-
-	.globl kexec_mach_type
-kexec_mach_type:
-	.long	0x0
-
-	/* phy addr of the atags for the new kernel */
-	.globl kexec_boot_atags
-kexec_boot_atags:
-	.long	0x0
+	mov	lr, r1
+	mov	r0, #0
+	ldr	r1, [r7, #KEXEC_MACH_TYPE]
+	ldr	r2, [r7, #KEXEC_R2]
+ ARM(	ret	lr	)
+ THUMB(	bx	lr	)
 
 ENDPROC(relocate_new_kernel)
 
+	.align	3
 relocate_new_kernel_end:
 
 	.globl relocate_new_kernel_size

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
