Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CDD31B01C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 11:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBNKfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 05:35:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:33044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhBNKfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 05:35:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9D11AC90;
        Sun, 14 Feb 2021 10:34:18 +0000 (UTC)
Date:   Sun, 14 Feb 2021 11:34:14 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.11
Message-ID: <20210214103414.GA29103@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I kinda knew while typing "I hope this is the last batch of x86/urgent
updates" last week, Murphy was reading too and uttered "Hold my beer!".
So here's more fixes... Thanks Murphy.

Anyway, please pull three more x86/urgent fixes for 5.11 final. We
should be finally ready (famous last words). :-)

Thx.

---

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11

for you to fetch changes up to 70245f86c109e0eafb92ea9653184c0e44b4b35c:

  x86/pci: Create PCI/MSI irqdomain after x86_init.pci.arch_init() (2021-02-10 22:06:47 +0100)

----------------------------------------------------------------
- An SGX use after free fix.

- A fix for the fix to disable CET instrumentation generation for kernel code.
We forgot 32-bit, which we seem to do very often nowadays.

- A Xen PV fix to irqdomain init ordering.

----------------------------------------------------------------
Borislav Petkov (1):
      x86/build: Disable CET instrumentation in the kernel for 32-bit too

Jarkko Sakkinen (1):
      x86/sgx: Maintain encl->refcount for each encl->mm_list entry

Thomas Gleixner (1):
      x86/pci: Create PCI/MSI irqdomain after x86_init.pci.arch_init()

 arch/x86/Makefile                |  6 +++---
 arch/x86/kernel/cpu/sgx/driver.c |  3 +++
 arch/x86/kernel/cpu/sgx/encl.c   |  5 +++++
 arch/x86/pci/init.c              | 15 +++++++++++----
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5857917f83ee..30920d70b48b 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -50,6 +50,9 @@ export BITS
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
 KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
 
+# Intel CET isn't enabled in the kernel
+KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
+
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
         UTS_MACHINE := i386
@@ -120,9 +123,6 @@ else
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
-
-	# Intel CET isn't enabled in the kernel
-	KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
 
 ifdef CONFIG_X86_X32
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index f2eac41bb4ff..8ce6d8371cfb 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -72,6 +72,9 @@ static int sgx_release(struct inode *inode, struct file *file)
 		synchronize_srcu(&encl->srcu);
 		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
 		kfree(encl_mm);
+
+		/* 'encl_mm' is gone, put encl_mm->encl reference: */
+		kref_put(&encl->refcount, sgx_encl_release);
 	}
 
 	kref_put(&encl->refcount, sgx_encl_release);
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index ee50a5010277..f65564a94b9b 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -481,6 +481,9 @@ static void sgx_mmu_notifier_free(struct mmu_notifier *mn)
 {
 	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm, mmu_notifier);
 
+	/* 'encl_mm' is going away, put encl_mm->encl reference: */
+	kref_put(&encl_mm->encl->refcount, sgx_encl_release);
+
 	kfree(encl_mm);
 }
 
@@ -534,6 +537,8 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 	if (!encl_mm)
 		return -ENOMEM;
 
+	/* Grab a refcount for the encl_mm->encl reference: */
+	kref_get(&encl->refcount);
 	encl_mm->encl = encl;
 	encl_mm->mm = mm;
 	encl_mm->mmu_notifier.ops = &sgx_mmu_notifier_ops;
diff --git a/arch/x86/pci/init.c b/arch/x86/pci/init.c
index 00bfa1ebad6c..0bb3b8b44e4e 100644
--- a/arch/x86/pci/init.c
+++ b/arch/x86/pci/init.c
@@ -9,16 +9,23 @@
    in the right sequence from here. */
 static __init int pci_arch_init(void)
 {
-	int type;
-
-	x86_create_pci_msi_domain();
+	int type, pcbios = 1;
 
 	type = pci_direct_probe();
 
 	if (!(pci_probe & PCI_PROBE_NOEARLY))
 		pci_mmcfg_early_init();
 
-	if (x86_init.pci.arch_init && !x86_init.pci.arch_init())
+	if (x86_init.pci.arch_init)
+		pcbios = x86_init.pci.arch_init();
+
+	/*
+	 * Must happen after x86_init.pci.arch_init(). Xen sets up the
+	 * x86_init.irqs.create_pci_msi_domain there.
+	 */
+	x86_create_pci_msi_domain();
+
+	if (!pcbios)
 		return 0;
 
 	pci_pcbios_init();

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
