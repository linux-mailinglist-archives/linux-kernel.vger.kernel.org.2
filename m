Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF47745845B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 16:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbhKUPMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 10:12:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbhKUPMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 10:12:34 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637507369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Lil0iTrb8L+Tl2mMonq7n7UHjEcqkSjmzCQ8U0rW3SM=;
        b=r9WPn3ZBdIrEi6dNA313dE+O8tHDU88fhJXR9Z2hwvXIevxm4cKGJgqw5a7nASse31u0Bn
        43KQ5TeWrvm6RzvVONCf9BqXsFUEycuuTKy4i4zSvLAyeHpwu2/VV/v/m8uSZDO3q+/4tv
        gEHCOFuccv8Z0KS38OTvHk5IPeWjJErxYEKh8Z0DJ/TluDivJiQDjE+wFK8uc58qfmzmMf
        JdIX2UbUMQ092syRUoA5VplNmAN3NQFNEU1IzZMHo0hyoRnCcbQuyITiV6nhvDGgpgG0uc
        sCfGADSt4x6bxqVVvdD+d81Qb11teVjjayBWp/s0bJP7fTCU3CkIF3f92zZxQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637507369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Lil0iTrb8L+Tl2mMonq7n7UHjEcqkSjmzCQ8U0rW3SM=;
        b=E6y9uvVvIuIwMYYEX73TTCyOIBa7Mp5Y1uSL7BEPOR023JxUVvx3X2cZhx6kovmvAD4Zcs
        7BVekdMQj27BtzBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.16-rc1
References: <163750734517.21962.4980600300710105647.tglx@xen13>
Message-ID: <163750734663.21962.15919226186457637549.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 21 Nov 2021 16:09:28 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-=
11-21

up to:  ac5d272a0ad0: x86/sgx: Fix free page accounting

Two X86 fixes:

 - Move the command line preparation and the early command line parsing
   earlier so that the command line parameters which affect
   early_reserve_memory(), e.g. efi=3Dnosftreserve, are taken into
   account. This was broken when the invocation of early_reserve_memory()
   was moved recently.

 - Use an atomic type for the SGX page accounting, which is read and
   written lockless, to plug various race conditions related to it.

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      x86/boot: Pull up cmdline preparation and early param parsing

Reinette Chatre (1):
      x86/sgx: Fix free page accounting


 arch/x86/kernel/cpu/sgx/main.c | 12 ++++----
 arch/x86/kernel/setup.c        | 66 +++++++++++++++++++++++++---------------=
--
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 63d3de02bbcc..8471a8b9b48e 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -28,8 +28,7 @@ static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
 static LIST_HEAD(sgx_active_page_list);
 static DEFINE_SPINLOCK(sgx_reclaimer_lock);
=20
-/* The free page list lock protected variables prepend the lock. */
-static unsigned long sgx_nr_free_pages;
+static atomic_long_t sgx_nr_free_pages =3D ATOMIC_LONG_INIT(0);
=20
 /* Nodes with one or more EPC sections. */
 static nodemask_t sgx_numa_mask;
@@ -403,14 +402,15 @@ static void sgx_reclaim_pages(void)
=20
 		spin_lock(&node->lock);
 		list_add_tail(&epc_page->list, &node->free_page_list);
-		sgx_nr_free_pages++;
 		spin_unlock(&node->lock);
+		atomic_long_inc(&sgx_nr_free_pages);
 	}
 }
=20
 static bool sgx_should_reclaim(unsigned long watermark)
 {
-	return sgx_nr_free_pages < watermark && !list_empty(&sgx_active_page_list);
+	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
+	       !list_empty(&sgx_active_page_list);
 }
=20
 static int ksgxd(void *p)
@@ -471,9 +471,9 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_nod=
e(int nid)
=20
 	page =3D list_first_entry(&node->free_page_list, struct sgx_epc_page, list);
 	list_del_init(&page->list);
-	sgx_nr_free_pages--;
=20
 	spin_unlock(&node->lock);
+	atomic_long_dec(&sgx_nr_free_pages);
=20
 	return page;
 }
@@ -625,9 +625,9 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	spin_lock(&node->lock);
=20
 	list_add_tail(&page->list, &node->free_page_list);
-	sgx_nr_free_pages++;
=20
 	spin_unlock(&node->lock);
+	atomic_long_inc(&sgx_nr_free_pages);
 }
=20
 static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 49b596db5631..c410be738ae7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -742,6 +742,28 @@ dump_kernel_offset(struct notifier_block *self, unsigned=
 long v, void *p)
 	return 0;
 }
=20
+static char *prepare_command_line(void)
+{
+#ifdef CONFIG_CMDLINE_BOOL
+#ifdef CONFIG_CMDLINE_OVERRIDE
+	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+#else
+	if (builtin_cmdline[0]) {
+		/* append boot loader cmdline to builtin */
+		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
+		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+	}
+#endif
+#endif
+
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+
+	parse_early_param();
+
+	return command_line;
+}
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also b=
een
  * passed the efi memmap, systab, etc., so we should use these data structur=
es
@@ -830,6 +852,23 @@ void __init setup_arch(char **cmdline_p)
=20
 	x86_init.oem.arch_setup();
=20
+	/*
+	 * x86_configure_nx() is called before parse_early_param() (called by
+	 * prepare_command_line()) to detect whether hardware doesn't support
+	 * NX (so that the early EHCI debug console setup can safely call
+	 * set_fixmap()). It may then be called again from within noexec_setup()
+	 * during parsing early parameters to honor the respective command line
+	 * option.
+	 */
+	x86_configure_nx();
+
+	/*
+	 * This parses early params and it needs to run before
+	 * early_reserve_memory() because latter relies on such settings
+	 * supplied as early params.
+	 */
+	*cmdline_p =3D prepare_command_line();
+
 	/*
 	 * Do some memory reservations *before* memory is added to memblock, so
 	 * memblock allocations won't overwrite it.
@@ -863,33 +902,6 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start =3D __pa_symbol(__bss_start);
 	bss_resource.end =3D __pa_symbol(__bss_stop)-1;
=20
-#ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
-	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if (builtin_cmdline[0]) {
-		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
-#endif
-
-	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
-	*cmdline_p =3D command_line;
-
-	/*
-	 * x86_configure_nx() is called before parse_early_param() to detect
-	 * whether hardware doesn't support NX (so that the early EHCI debug
-	 * console setup can safely call set_fixmap()). It may then be called
-	 * again from within noexec_setup() during parsing early parameters
-	 * to honor the respective command line option.
-	 */
-	x86_configure_nx();
-
-	parse_early_param();
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 	/*
 	 * Memory used by the kernel cannot be hot-removed because Linux

