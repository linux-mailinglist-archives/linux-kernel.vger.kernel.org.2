Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF0A45A637
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhKWPIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhKWPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:08:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F9AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:05:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u18so39530302wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=aOxYoPKgl1loQBK48sy5QOwMdBraS7ydDT8tFLOfn9k=;
        b=RMrFlWNBitfPi8hEVTqyc3PS6rA3BktxD78wpNjAWD3k/mCc/oruCFj1ByVvFOlfFz
         w8bp2yQ2OWPf/q0eybBl8UwnurjiTI4rhuR1okiNSGkhlu3u1Mc3lLxUP3/wMZWSkXbA
         54lPozEVN3dO9rjVVeYcSvTNdWU0AkdscqyuedQ8GhkbA/Doj9ohtiTauaKJFCK3W/oW
         xXPGnHGuRYlULelSup4KJ471Lr3JVjSqHE0K+50LQTjUujcPuDPgkOkF8cq7wAD6Ek82
         ps0AnBTvjsOTsGvENXzf6dTQRcCsVAkb9wEnrbPM65T2ylhbK8WSJDlPShkfPGFz+WOD
         JAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aOxYoPKgl1loQBK48sy5QOwMdBraS7ydDT8tFLOfn9k=;
        b=u04nvGAWcm6x2AcyaFhZyrOkXPw3s2/aJqnbickZ+zz+0R+OoVP+WuigD9A/8tKq3Z
         iGJvtUHH0bebjRzhTSvJA5248xEM4tWG7xPNeDtfp34OYTdiT1v4tFOloCx6E1svM2fp
         QwOtT0YK3OWBwPItQP6uTzzn85EoccpxDZoLRjh3mAT5z03585R95TfDW8AIuhZk+PPV
         M6mCBiDXaA7A9YLq/IKHrdjmauK3LY4QsA+/0hR3vHiOCGMavKK3FPzm7MT3q+RLcjky
         0E8nNLQpj+XmswBPKccTl3/9SRb+AN6QVxlRs7VDST+2W4P6pVVwCs4IaWemxAMahNYg
         UIuw==
X-Gm-Message-State: AOAM531G10UwEpjrzsFYvfH8XwDp49LMp59mdikYAvJ6EIOfcPGvkSqi
        /F3Z1XhiYmyzrJOb2HFy3BF6tw==
X-Google-Smtp-Source: ABdhPJyOTPph2KxSJtLK/IVnc4aVU6ndkmVTKcQDS2HZgCiB0mrGSaJXSyYOyOK7c+4gs6kNp0+dqA==
X-Received: by 2002:a05:6000:82:: with SMTP id m2mr8032743wrx.202.1637679940200;
        Tue, 23 Nov 2021 07:05:40 -0800 (PST)
Received: from n124-129-120.byted.org (ec2-3-10-73-122.eu-west-2.compute.amazonaws.com. [3.10.73.122])
        by smtp.gmail.com with ESMTPSA id z14sm12715153wrp.70.2021.11.23.07.05.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 07:05:39 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com,
        tglx@linutronix.de
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH] x86/purgatory: provide config to disable purgatory
Date:   Tue, 23 Nov 2021 15:05:08 +0000
Message-Id: <20211123150508.3397898-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can help in reducing boot time if purgatory is not needed
as the sha256 digest of kexec segments is no longer calculated
or verified if the config is disabled.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Reviewed-by: Fam Zheng <fam.zheng@bytedance.com>
---
 arch/powerpc/Kbuild               |  2 +-
 arch/powerpc/Kconfig              |  2 +-
 arch/s390/Kbuild                  |  2 +-
 arch/s390/Kconfig                 |  2 +-
 arch/s390/purgatory/Makefile      |  2 +-
 arch/x86/Kbuild                   |  2 +-
 arch/x86/Kconfig                  |  6 ++--
 arch/x86/kernel/kexec-bzimage64.c | 59 +++++++++++++++++++++------------------
 arch/x86/purgatory/Makefile       |  2 +-
 kernel/kexec_file.c               |  6 ++--
 10 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/Kbuild b/arch/powerpc/Kbuild
index 22cd0d55a892..072e62d7898e 100644
--- a/arch/powerpc/Kbuild
+++ b/arch/powerpc/Kbuild
@@ -15,7 +15,7 @@ obj-$(CONFIG_KVM)  += kvm/
 
 obj-$(CONFIG_PERF_EVENTS) += perf/
 obj-$(CONFIG_KEXEC_CORE)  += kexec/
-obj-$(CONFIG_KEXEC_FILE)  += purgatory/
+obj-$(CONFIG_KEXEC_PURGATORY)  += purgatory/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dea74d7717c0..58bdfd1abb44 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -557,7 +557,7 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to a list of segments as is the
 	  case for the older kexec call.
 
-config ARCH_HAS_KEXEC_PURGATORY
+config KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
 config RELOCATABLE
diff --git a/arch/s390/Kbuild b/arch/s390/Kbuild
index 76e362277179..2ed4ee5cdf59 100644
--- a/arch/s390/Kbuild
+++ b/arch/s390/Kbuild
@@ -7,7 +7,7 @@ obj-$(CONFIG_S390_HYPFS_FS)	+= hypfs/
 obj-$(CONFIG_APPLDATA_BASE)	+= appldata/
 obj-y				+= net/
 obj-$(CONFIG_PCI)		+= pci/
-obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += purgatory/
+obj-$(CONFIG_KEXEC_PURGATORY) += purgatory/
 
 # for cleaning
 subdir- += boot tools
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2a5bb4f29cfe..d15bdaa0e198 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -538,7 +538,7 @@ config KEXEC_FILE
 	  kexec system call this system call takes file descriptors for the
 	  kernel and initramfs as arguments.
 
-config ARCH_HAS_KEXEC_PURGATORY
+config KEXEC_PURGATORY
 	def_bool y
 	depends on KEXEC_FILE
 
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 360ada80d20c..03cac6d7310a 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -51,4 +51,4 @@ $(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
 $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
 	$(call if_changed_rule,as_o_S)
 
-obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += kexec-purgatory.o
+obj-$(CONFIG_KEXEC_PURGATORY) += kexec-purgatory.o
diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f384cb1a4f7a..9089438ed6d8 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -24,7 +24,7 @@ obj-$(CONFIG_IA32_EMULATION) += ia32/
 obj-y += platform/
 obj-y += net/
 
-obj-$(CONFIG_KEXEC_FILE) += purgatory/
+obj-$(CONFIG_KEXEC_PURGATORY) += purgatory/
 
 # for cleaning
 subdir- += boot tools
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7399327d1eff..7efe6dbfdc67 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2000,8 +2000,10 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
-config ARCH_HAS_KEXEC_PURGATORY
-	def_bool KEXEC_FILE
+config KEXEC_PURGATORY
+	bool "A standalone relocatable object run between the 2 kernels during kexec"
+	depends on KEXEC_FILE
+	default y
 
 config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..bf37a2c4ab8b 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -374,18 +374,19 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 			return ERR_PTR(ret);
 	}
 
-	/*
-	 * Load purgatory. For 64bit entry point, purgatory  code can be
-	 * anywhere.
-	 */
-	ret = kexec_load_purgatory(image, &pbuf);
-	if (ret) {
-		pr_err("Loading purgatory failed\n");
-		return ERR_PTR(ret);
-	}
-
-	pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
+	if (IS_ENABLED(CONFIG_KEXEC_PURGATORY)) {
+		/*
+		 * Load purgatory. For 64bit entry point, purgatory  code can be
+		 * anywhere.
+		 */
+		ret = kexec_load_purgatory(image, &pbuf);
+		if (ret) {
+			pr_err("Loading purgatory failed\n");
+			return ERR_PTR(ret);
+		}
 
+		pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
+	}
 
 	/*
 	 * Load Bootparams and cmdline and space for efi stuff.
@@ -466,28 +467,32 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	params->hdr.type_of_loader = 0x0D << 4;
 	params->hdr.loadflags = 0;
 
-	/* Setup purgatory regs for entry */
-	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
-					     sizeof(regs64), 1);
-	if (ret)
-		goto out_free_params;
+	if (IS_ENABLED(CONFIG_KEXEC_PURGATORY)) {
+		/* Setup purgatory regs for entry */
+		ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
+							sizeof(regs64), 1);
+		if (ret)
+			goto out_free_params;
+	}
 
 	regs64.rbx = 0; /* Bootstrap Processor */
 	regs64.rsi = bootparam_load_addr;
 	regs64.rip = kernel_load_addr + 0x200;
-	stack = kexec_purgatory_get_symbol_addr(image, "stack_end");
-	if (IS_ERR(stack)) {
-		pr_err("Could not find address of symbol stack_end\n");
-		ret = -EINVAL;
-		goto out_free_params;
-	}
 
-	regs64.rsp = (unsigned long)stack;
-	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
-					     sizeof(regs64), 0);
-	if (ret)
-		goto out_free_params;
+	if (IS_ENABLED(CONFIG_KEXEC_PURGATORY)) {
+		stack = kexec_purgatory_get_symbol_addr(image, "stack_end");
+		if (IS_ERR(stack)) {
+			pr_err("Could not find address of symbol stack_end\n");
+			ret = -EINVAL;
+			goto out_free_params;
+		}
 
+		regs64.rsp = (unsigned long)stack;
+		ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
+							sizeof(regs64), 0);
+		if (ret)
+			goto out_free_params;
+	}
 	ret = setup_boot_parameters(image, params, bootparam_load_addr,
 				    efi_map_offset, efi_map_sz,
 				    efi_setup_data_offset);
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..688b3f21be8f 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -81,4 +81,4 @@ quiet_cmd_bin2c = BIN2C   $@
 $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
 
-obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
+obj-$(CONFIG_KEXEC_PURGATORY)	+= kexec-purgatory.o
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..e5f4c2d27249 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -724,7 +724,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	struct kexec_sha_region *sha_regions;
 	struct purgatory_info *pi = &image->purgatory_info;
 
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_KEXEC_PURGATORY))
+	if (!IS_ENABLED(CONFIG_KEXEC_PURGATORY))
 		return 0;
 
 	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
@@ -829,7 +829,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	return ret;
 }
 
-#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
+#ifdef CONFIG_KEXEC_PURGATORY
 /*
  * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
  * @pi:		Purgatory to be loaded.
@@ -1176,7 +1176,7 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 
 	return 0;
 }
-#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
+#endif /* CONFIG_KEXEC_PURGATORY */
 
 int crash_exclude_mem_range(struct crash_mem *mem,
 			    unsigned long long mstart, unsigned long long mend)
-- 
2.11.0

