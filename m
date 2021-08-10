Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB623E5377
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhHJG0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbhHJG0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:26:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA704C061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 23:26:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x8so39340356lfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhM9rzQZh1hFlmIsdV4JGrfhMhv28jDR+Y6mMaIyOd4=;
        b=iI6obK6IDsJ5WRxV6OM1M/tAx2RUXXdpWjOOljATFp3gKmjcJd16cMca3CRczpVk90
         vdUUedOazrl3bkG2F0IfOJ6AItLxNYJwCF1n4JKF50+TflcgrRKXqnKIm/J/THTyieZr
         KsM8HcwID/NK5sqFV1M5hQPxhiER2JGcI0YABCRIa4iVTkIyyqaNxusuU50potUPb3Oi
         PUB+8f9Ij8rl+y/qgnVCYh7HdM2F7I53V4Dh1DLgERtHiB2qPWoUfEd0GCbBsUCX6DAg
         /nKOFs0c2RkzNtTU4ew3Npu0B4ABZRqH7MBpxW8V+hsglvKIqewABkD2rTgSDih6C3Up
         n1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhM9rzQZh1hFlmIsdV4JGrfhMhv28jDR+Y6mMaIyOd4=;
        b=VXQj02x+jf8L0KdkDdhZE/at+2uB/e8kvDIvob9QgAaq/C7RCmpRlG29CEnNzj7ED1
         et5yrmgTr7WeCXY+JBHq/RFIejfVgsan+md/KmqJyKG/7FFoFh10RTkdTQDoLAxx7+0B
         LCrpHRhFfe6VuQvqSnFjy56C2pEUzEOdBo0U4mtqk3my/siCFPhHeFlM5VHWTZZSrSnz
         C/Yl0C8ZhDw4D8USvb18mVDt8M6VDVuVgRhDBDjJbZuiBVZUgCTryAua/ecumKbZZudV
         LNv9bTXRMERMbZv+el4o+jixmR3oMCR5P/1S2rWj+wSdnshyc2lD7QQLpikU1ACX5/Dm
         +cEg==
X-Gm-Message-State: AOAM530Up0eYrM0v/GUOLDVTBUdyicVJF3Xv0Sa+guJMvgXgKp3UvfiN
        9KyL02k5F8ZKie+xBKxSF6Wl8w==
X-Google-Smtp-Source: ABdhPJywOJGNlI7IqnnlU0lsO+YPTdIUQE6GK58teoRywSZHJeH0Ifngw9u6S0AYbWyYjWXtNj2VvA==
X-Received: by 2002:a05:6512:e86:: with SMTP id bi6mr21473291lfb.592.1628576784944;
        Mon, 09 Aug 2021 23:26:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w27sm264085lfa.308.2021.08.09.23.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:26:22 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id A60D9102BDA; Tue, 10 Aug 2021 09:26:34 +0300 (+03)
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
Subject: [PATCH 3/5] x86/boot/compressed: Handle unaccepted memory
Date:   Tue, 10 Aug 2021 09:26:24 +0300
Message-Id: <20210810062626.1012-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware is responsible for accepting memory where compressed kernel
image and initrd land. But kernel has to accept memory for decompression
buffer: accept memory just before decompression starts

KASLR allowed to use unaccepted memory for output buffer.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/bitmap.c            | 62 ++++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c             | 14 ++++-
 arch/x86/boot/compressed/misc.c              |  9 +++
 arch/x86/boot/compressed/unaccepted_memory.c | 13 ++++
 arch/x86/include/asm/unaccepted_memory.h     |  2 +
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/bitmap.c b/arch/x86/boot/compressed/bitmap.c
index bf58b259380a..ba2de61c0823 100644
--- a/arch/x86/boot/compressed/bitmap.c
+++ b/arch/x86/boot/compressed/bitmap.c
@@ -2,6 +2,48 @@
 /* Taken from lib/string.c */
 
 #include <linux/bitmap.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+
+unsigned long _find_next_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long nbits,
+		unsigned long start, unsigned long invert, unsigned long le)
+{
+	unsigned long tmp, mask;
+
+	if (unlikely(start >= nbits))
+		return nbits;
+
+	tmp = addr1[start / BITS_PER_LONG];
+	if (addr2)
+		tmp &= addr2[start / BITS_PER_LONG];
+	tmp ^= invert;
+
+	/* Handle 1st word. */
+	mask = BITMAP_FIRST_WORD_MASK(start);
+	if (le)
+		mask = swab(mask);
+
+	tmp &= mask;
+
+	start = round_down(start, BITS_PER_LONG);
+
+	while (!tmp) {
+		start += BITS_PER_LONG;
+		if (start >= nbits)
+			return nbits;
+
+		tmp = addr1[start / BITS_PER_LONG];
+		if (addr2)
+			tmp &= addr2[start / BITS_PER_LONG];
+		tmp ^= invert;
+	}
+
+	if (le)
+		tmp = swab(tmp);
+
+	return min(start + __ffs(tmp), nbits);
+}
 
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
@@ -22,3 +64,23 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len)
 		*p |= mask_to_set;
 	}
 }
+
+void __bitmap_clear(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_clear >= 0) {
+		*p &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_LONG;
+		mask_to_clear = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		*p &= ~mask_to_clear;
+	}
+}
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e36690778497..89cdc17dcbf1 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -729,10 +729,20 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 		 * but in practice there's firmware where using that memory leads
 		 * to crashes.
 		 *
-		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
+		 * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if
+		 * supported) are guaranteed to be free.
 		 */
-		if (md->type != EFI_CONVENTIONAL_MEMORY)
+
+		switch (md->type) {
+		case EFI_CONVENTIONAL_MEMORY:
+			break;
+		case EFI_UNACCEPTED_MEMORY:
+			if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+				break;
 			continue;
+		default:
+			continue;
+		}
 
 		if (efi_soft_reserve_enabled() &&
 		    (md->attribute & EFI_MEMORY_SP))
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 743f13ea25c1..eeefcde8394d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -18,6 +18,7 @@
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
+#include <asm/unaccepted_memory.h>
 
 /*
  * WARNING!!
@@ -435,6 +436,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
+
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
+	    boot_params->unaccepted_memory) {
+		debug_putstr("Accepting memory... ");
+		accept_memory((phys_addr_t)output,
+			      (phys_addr_t)output + needed_size);
+	}
+
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
 	parse_elf(output);
diff --git a/arch/x86/boot/compressed/unaccepted_memory.c b/arch/x86/boot/compressed/unaccepted_memory.c
index c2eca85b5073..17b70627b0cd 100644
--- a/arch/x86/boot/compressed/unaccepted_memory.c
+++ b/arch/x86/boot/compressed/unaccepted_memory.c
@@ -34,3 +34,16 @@ void mark_unaccepted(struct boot_params *params, u64 start, u64 num)
 	bitmap_set((unsigned long *)params->unaccepted_memory,
 		   start / PMD_SIZE, npages);
 }
+
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long *unaccepted_memory;
+	unsigned int rs, re;
+
+	unaccepted_memory = (unsigned long *)boot_params->unaccepted_memory;
+	bitmap_for_each_set_region(unaccepted_memory, rs, re,
+				   start / PMD_SIZE, end / PMD_SIZE) {
+		__accept_memory(rs * PMD_SIZE, re * PMD_SIZE);
+		bitmap_clear(unaccepted_memory, rs, re - rs);
+	}
+}
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index cbc24040b853..f1f835d3cd78 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -9,4 +9,6 @@ struct boot_params;
 
 void mark_unaccepted(struct boot_params *params, u64 start, u64 num);
 
+void accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif
-- 
2.31.1

