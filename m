Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1073E5376
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhHJG0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbhHJG0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:26:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4CDC061799
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 23:26:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h2so15217807lji.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wx+RYAAVAPw18oVnn3qZR4sMu11WM9+OwnA33lJi4Gw=;
        b=KjNnlspysltiYL9VG1uTtzPa26xJF/4zf28T9Q8NUyea39Hie4Cg6Yt7e1mDZ6tmjH
         Zuj6D2wx1SgT7ihXTirifdxPF6O/BsvSUxiZhzselypHb9i167AS9inRV7TI+juMqt/a
         XlGmRsV3i78lbRQndTrBHd7ScFISM+QkYxg4D037nVJVBZ1xewPnW2hzvGdMWfh7Qsss
         hO2Cxqlt7TjnP7G0OHspAPWVJUoapBNUcPFF8KKoYTTJW832BS9lr/detTiQzwi00+6D
         a+lTZR5WOrVRmzhEOA2eTA/bawQGWKtnkAgaRDpYhdGakucGDyC2OphNzutuJ3BGFWoz
         rVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wx+RYAAVAPw18oVnn3qZR4sMu11WM9+OwnA33lJi4Gw=;
        b=rCvZv+lryZhCk5D92M+5X7c/SshndLCxxzgPM1W+/xsT5UAUW1h560Jy/z0Yr7qDyL
         eP6PJhGBV7enCuytyXfuD+UX5pY2tz4jrBe4lXa3VTiw5e9JIWTXYbrWtR/51SDpY5PU
         7o59IMxKjKuPfP5gI420MnISDA8gorCH3NLdRhntIMQgCQMYCjAmxFzwwawVhuDSTh0h
         8cqxuMuAhCxM5eI9wchtiC86XE5xlM8/GpTjl0nGKyYNkMXEhHMUCbO1QNNymIqP2HGx
         Wtpn3E37gpwDGhpDWkXo3HGPgDNxnnfa+ZW9g3mMSB18wPGyJFBV9Lu02uI/t2qVKYNS
         La3Q==
X-Gm-Message-State: AOAM532S4TEwi2YtangL3k4SjUHjl9Zrx+vhn2U9UQOH42qelXMN/cBn
        ezJhBRD0j61mCzuqDBH3bb0Hrg==
X-Google-Smtp-Source: ABdhPJwWBQ+K3JlUHh1r9KuMzK5f88CTEesYRXokmMYpujHyCswZFi39bgh9hPbmyaRICi3KPxpsAA==
X-Received: by 2002:a2e:a4c9:: with SMTP id p9mr18511425ljm.437.1628576786272;
        Mon, 09 Aug 2021 23:26:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z24sm1948290lfr.105.2021.08.09.23.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:26:22 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 9C30E102BD9; Tue, 10 Aug 2021 09:26:34 +0300 (+03)
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/5] efi/x86: Implement support for unaccepted memory
Date:   Tue, 10 Aug 2021 09:26:23 +0300
Message-Id: <20210810062626.1012-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UEFI Specification version 2.9 introduces concept of memory acceptance:
Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
requiring memory to be accepted before it can be used by the guest.
Accepting happens via a protocol specific for the Virtrual Machine
platform.

Accepting memory is costly and it makes VMM allocate memory for the
accepted guest physical address range. It's better to postpone memory
acceptation until memory is needed. It lowers boot time and reduces
memory overhead.

Kernel needs to know what memory has been accepted. Firmware
communicates this information via memory map: a new memory type --
EFI_UNACCEPTED_MEMORY -- indicates such memory.

Range based tracking works fine for firmware, but it gets bulky for
kernel: e820 has to be modified on every page acceptance. It leads to
table fragmentation, but there's a limited number of entries in the e820
table

Other option is to mark such memory as usable in e820 and track if the
range has been accepted in a bitmap. One bit in the bitmap represents
2MiB in the address space: one 4k page is enough to track 64GiB or
physical address space.

In the worst case scenario -- a huge hole in the middle of the
address space -- we would need 256MiB to handle 4PiB of the address
space.

Any unaccepted memory that is not aligned to 2M get accepted upfront.

The bitmap allocated and constructed in EFI stub and passed down to
kernel via boot_params. allocate_e820() allocates the bitmap if
unaccepted memory present according to the maximum address in the memory
map.

The same boot_params.unaccepted_memory can be used to pass the bitmap
between two kernel on kexec, but the use-case is not yet implemented.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/x86/zero-page.rst              |  1 +
 arch/x86/boot/compressed/Makefile            |  1 +
 arch/x86/boot/compressed/bitmap.c            | 24 +++++++
 arch/x86/boot/compressed/unaccepted_memory.c | 36 ++++++++++
 arch/x86/include/asm/unaccepted_memory.h     | 12 ++++
 arch/x86/include/uapi/asm/bootparam.h        |  3 +-
 drivers/firmware/efi/Kconfig                 | 12 ++++
 drivers/firmware/efi/efi.c                   |  1 +
 drivers/firmware/efi/libstub/x86-stub.c      | 75 ++++++++++++++++----
 include/linux/efi.h                          |  3 +-
 10 files changed, 153 insertions(+), 15 deletions(-)
 create mode 100644 arch/x86/boot/compressed/bitmap.c
 create mode 100644 arch/x86/boot/compressed/unaccepted_memory.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h

diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
index f088f5881666..8e3447a4b373 100644
--- a/Documentation/x86/zero-page.rst
+++ b/Documentation/x86/zero-page.rst
@@ -42,4 +42,5 @@ Offset/Size	Proto	Name			Meaning
 2D0/A00		ALL	e820_table		E820 memory map table
 						(array of struct e820_entry)
 D00/1EC		ALL	eddbuf			EDD data (array of struct edd_info)
+ECC/008		ALL	unaccepted_memory	Bitmap of unaccepted memory (1bit == 2M)
 ===========	=====	=======================	=================================================
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 1bfe30ebadbe..f5b49e74d728 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -100,6 +100,7 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdcall.o
+vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/unaccepted_memory.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/bitmap.c b/arch/x86/boot/compressed/bitmap.c
new file mode 100644
index 000000000000..bf58b259380a
--- /dev/null
+++ b/arch/x86/boot/compressed/bitmap.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Taken from lib/string.c */
+
+#include <linux/bitmap.h>
+
+void __bitmap_set(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_set >= 0) {
+		*p |= mask_to_set;
+		len -= bits_to_set;
+		bits_to_set = BITS_PER_LONG;
+		mask_to_set = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+		*p |= mask_to_set;
+	}
+}
diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
new file mode 100644
index 000000000000..c2eca85b5073
--- /dev/null
+++ b/arch/x86/boot/compressed/unaccepted_memory.c
@@ -0,0 +1,36 @@
+#include "error.h"
+#include "misc.h"
+
+static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/* Platform-specific memory-acceptance call goes here */
+	error("Cannot accept memory");
+}
+
+void mark_unaccepted(struct boot_params *params, u64 start, u64 num)
+{
+	u64 end = start + num * PAGE_SIZE;
+	unsigned int npages;
+
+	if ((start & PMD_MASK) == (end & PMD_MASK)) {
+		npages = (end - start) / PAGE_SIZE;
+		__accept_memory(start, start + npages * PAGE_SIZE);
+		return;
+	}
+
+	if (start & ~PMD_MASK) {
+		npages = (round_up(start, PMD_SIZE) - start) / PAGE_SIZE;
+		__accept_memory(start, start + npages * PAGE_SIZE);
+		start = round_up(start, PMD_SIZE);
+	}
+
+	if (end & ~PMD_MASK) {
+		npages = (end - round_down(end, PMD_SIZE)) / PAGE_SIZE;
+		end = round_down(end, PMD_SIZE);
+		__accept_memory(end, end + npages * PAGE_SIZE);
+	}
+
+	npages = (end - start) / PMD_SIZE;
+	bitmap_set((unsigned long *)params->unaccepted_memory,
+		   start / PMD_SIZE, npages);
+}
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
new file mode 100644
index 000000000000..cbc24040b853
--- /dev/null
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 Intel Corporation */
+#ifndef _ASM_X86_UNACCEPTED_MEMORY_H
+#define _ASM_X86_UNACCEPTED_MEMORY_H
+
+#include <linux/types.h>
+
+struct boot_params;
+
+void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
+
+#endif
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index b25d3f82c2f3..16bc686a198d 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -217,7 +217,8 @@ struct boot_params {
 	struct boot_e820_entry e820_table[E820_MAX_ENTRIES_ZEROPAGE]; /* 0x2d0 */
 	__u8  _pad8[48];				/* 0xcd0 */
 	struct edd_info eddbuf[EDDMAXNR];		/* 0xd00 */
-	__u8  _pad9[276];				/* 0xeec */
+	__u64 unaccepted_memory;			/* 0xeec */
+	__u8  _pad9[268];				/* 0xef4 */
 } __attribute__((packed));
 
 /**
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..e13b584cdd80 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -243,6 +243,18 @@ config EFI_DISABLE_PCI_DMA
 	  options "efi=disable_early_pci_dma" or "efi=no_disable_early_pci_dma"
 	  may be used to override this option.
 
+config UNACCEPTED_MEMORY
+	bool
+	depends on EFI_STUB
+	help
+	   Some Virtual Machine platforms, such as Intel TDX, introduce
+	   the concept of memory acceptance, requiring memory to be accepted
+	   before it can be used by the guest. This protects against a class of
+	   attacks by the virtual machine platform.
+
+	   This option adds support for unaccepted memory and makes such memory
+	   usable by kernel.
+
 endmenu
 
 config EFI_EMBEDDED_FIRMWARE
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 847f33ffc4ae..c6b8a1c5a87f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -737,6 +737,7 @@ static __initdata char memory_type_name[][13] = {
 	"MMIO Port",
 	"PAL Code",
 	"Persistent",
+	"Unaccepted",
 };
 
 char * __init efi_md_typeattr_format(char *buf, size_t size,
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..e67ec1245f10 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -9,12 +9,14 @@
 #include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/stddef.h>
+#include <linux/bitmap.h>
 
 #include <asm/efi.h>
 #include <asm/e820/types.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/unaccepted_memory.h>
 
 #include "efistub.h"
 
@@ -504,6 +506,12 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 			e820_type = E820_TYPE_PMEM;
 			break;
 
+		case EFI_UNACCEPTED_MEMORY:
+			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+				continue;
+			e820_type = E820_TYPE_RAM;
+			mark_unaccepted(params, d->phys_addr, d->num_pages);
+			break;
 		default:
 			continue;
 		}
@@ -569,30 +577,71 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
 }
 
 static efi_status_t allocate_e820(struct boot_params *params,
+				  struct efi_boot_memmap *map,
 				  struct setup_data **e820ext,
 				  u32 *e820ext_size)
 {
-	unsigned long map_size, desc_size, map_key;
 	efi_status_t status;
-	__u32 nr_desc, desc_version;
-
-	/* Only need the size of the mem map and size of each mem descriptor */
-	map_size = 0;
-	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
-			     &desc_size, &desc_version);
-	if (status != EFI_BUFFER_TOO_SMALL)
-		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
+	__u32 nr_desc;
+	bool unaccepted_memory_present = false;
+	u64 max_addr = 0;
+	int i;
 
-	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
+	status = efi_get_memory_map(map);
+	if (status != EFI_SUCCESS)
+		return status;
 
-	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
-		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
+	nr_desc = *map->map_size / *map->desc_size;
+	if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
+		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) -
+			EFI_MMAP_NR_SLACK_SLOTS;
 
 		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
 		if (status != EFI_SUCCESS)
 			return status;
 	}
 
+	if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+		return EFI_SUCCESS;
+
+	/* Check if there's any unaccepted memory and find the max address */
+	for (i = 0; i < nr_desc; i++) {
+		efi_memory_desc_t *d;
+
+		d = efi_early_memdesc_ptr(*map->map, *map->desc_size, i);
+		if (d->type == EFI_UNACCEPTED_MEMORY)
+			unaccepted_memory_present = true;
+		if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
+			max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
+	}
+
+	/*
+	 * If unaccepted memory present allocate a bitmap to track what memory
+	 * has to be accepted before access.
+	 *
+	 * One bit in the bitmap represents 2MiB in the address space: one 4k
+	 * page is enough to track 64GiB or physical address space.
+	 *
+	 * In the worst case scenario -- a huge hole in the middle of the
+	 * address space -- we would need 256MiB to handle 4PiB of the address
+	 * space.
+	 *
+	 * TODO: handle situation if params->unaccepted_memory has already set.
+	 * It's required to deal with kexec.
+	 */
+	if (unaccepted_memory_present) {
+		unsigned long *unaccepted_memory = NULL;
+		u64 size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
+
+		status = efi_allocate_pages(size,
+					    (unsigned long *)&unaccepted_memory,
+					    ULONG_MAX);
+		if (status != EFI_SUCCESS)
+			return status;
+		memset(unaccepted_memory, 0, size);
+		params->unaccepted_memory = (u64)unaccepted_memory;
+	}
+
 	return EFI_SUCCESS;
 }
 
@@ -642,7 +691,7 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	priv.boot_params	= boot_params;
 	priv.efi		= &boot_params->efi_info;
 
-	status = allocate_e820(boot_params, &e820ext, &e820ext_size);
+	status = allocate_e820(boot_params, &map, &e820ext, &e820ext_size);
 	if (status != EFI_SUCCESS)
 		return status;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6b5d36babfcc..d43cc872b582 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -108,7 +108,8 @@ typedef	struct {
 #define EFI_MEMORY_MAPPED_IO_PORT_SPACE	12
 #define EFI_PAL_CODE			13
 #define EFI_PERSISTENT_MEMORY		14
-#define EFI_MAX_MEMORY_TYPE		15
+#define EFI_UNACCEPTED_MEMORY		15
+#define EFI_MAX_MEMORY_TYPE		16
 
 /* Attribute values: */
 #define EFI_MEMORY_UC		((u64)0x0000000000000001ULL)	/* uncached */
-- 
2.31.1

