Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3D73661C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhDTVvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhDTVuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:50:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99874C061346
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q2so2301572pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jo339a9O/xQsdX+NYbQT8mbjTnbUeOsyXpYpAUuwZJo=;
        b=G2x6LkLjKgU0qE4ZjA2lHm2dCG+twxxo0HZWcDHZeB6gliC/fIKe/v/ePgRf147lZh
         wi+eSq4724qu7zLstrLK0QjSxcaIX2Elqf1izNR2fIsj8j+Y7/MDpqpZb1I5u6bhHRAI
         YtALafB/lkPTjLaqYiZoT1X0SU/tuzLnJ9tfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jo339a9O/xQsdX+NYbQT8mbjTnbUeOsyXpYpAUuwZJo=;
        b=JiSNYFD5KTWPFuYubx5/vC4WkxHcaftW0yQFtFYqriBVo/AhKPZEJiRxP17POsZp/r
         KJDpxDKohXa3NMHl8fs5/LSSX8SrRbealR/cVED/KenVL7cA4kGKqohYDDEM4arLZnpY
         695WYgSCoaGiYn5JgLligqZd+0Fy084MKsOzLk8d2CoUZWDoTomBaVBmdg65Y/8Q85Hr
         NjnyLp3ICp1+WMUVHcjyuE3ZKbjIUezoPjaXPzyy33nEF85SJwe1NdorLT/u7voTnZXb
         Fn/uc8G/rdf6ENtjRXLo+ucdHo8/94veV4rF4D8BpbMS/spZ4U68zPYbw99yZql6VVdn
         ncBw==
X-Gm-Message-State: AOAM533RwGXG2Rdg7z5hNUYETmA7kKFXPDZEsp+8Wt06Xl0flrxLD+yR
        YiqDxoJZuWenXjcqFC5wEgLYdQ==
X-Google-Smtp-Source: ABdhPJyQ41Vx2h+vs4WKW/yn1z64HrCccodo330hGQvRSnLn+QMkkaXyXyEaPUgn6j8jd5952xA6qQ==
X-Received: by 2002:aa7:9e4f:0:b029:25e:cf65:c554 with SMTP id z15-20020aa79e4f0000b029025ecf65c554mr13105127pfq.66.1618955415205;
        Tue, 20 Apr 2021 14:50:15 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id c21sm31481pfo.91.2021.04.20.14.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:50:14 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH v5 13/13] kdump: Use vmlinux_build_id to simplify
Date:   Tue, 20 Apr 2021 14:50:03 -0700
Message-Id: <20210420215003.3510247-14-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420215003.3510247-1-swboyd@chromium.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use the vmlinux_build_id array here now instead of open coding
it. This mostly consolidates code.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: <kexec@lists.infradead.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/crash_core.h | 12 ++++-----
 kernel/crash_core.c        | 50 ++------------------------------------
 2 files changed, 8 insertions(+), 54 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 206bde8308b2..de62a722431e 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -38,8 +38,12 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 
 #define VMCOREINFO_OSRELEASE(value) \
 	vmcoreinfo_append_str("OSRELEASE=%s\n", value)
-#define VMCOREINFO_BUILD_ID(value) \
-	vmcoreinfo_append_str("BUILD-ID=%s\n", value)
+#define VMCOREINFO_BUILD_ID()						\
+	({								\
+		static_assert(sizeof(vmlinux_build_id) == 20);		\
+		vmcoreinfo_append_str("BUILD-ID=%20phN\n", vmlinux_build_id); \
+	})
+
 #define VMCOREINFO_PAGESIZE(value) \
 	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
 #define VMCOREINFO_SYMBOL(name) \
@@ -69,10 +73,6 @@ extern unsigned char *vmcoreinfo_data;
 extern size_t vmcoreinfo_size;
 extern u32 *vmcoreinfo_note;
 
-/* raw contents of kernel .notes section */
-extern const void __start_notes __weak;
-extern const void __stop_notes __weak;
-
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 825284baaf46..29cc15398ee4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
  */
 
+#include <linux/buildid.h>
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
@@ -378,53 +379,6 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 }
 EXPORT_SYMBOL(paddr_vmcoreinfo_note);
 
-#define NOTES_SIZE (&__stop_notes - &__start_notes)
-#define BUILD_ID_MAX SHA1_DIGEST_SIZE
-#define NT_GNU_BUILD_ID 3
-
-struct elf_note_section {
-	struct elf_note	n_hdr;
-	u8 n_data[];
-};
-
-/*
- * Add build ID from .notes section as generated by the GNU ld(1)
- * or LLVM lld(1) --build-id option.
- */
-static void add_build_id_vmcoreinfo(void)
-{
-	char build_id[BUILD_ID_MAX * 2 + 1];
-	int n_remain = NOTES_SIZE;
-
-	while (n_remain >= sizeof(struct elf_note)) {
-		const struct elf_note_section *note_sec =
-			&__start_notes + NOTES_SIZE - n_remain;
-		const u32 n_namesz = note_sec->n_hdr.n_namesz;
-
-		if (note_sec->n_hdr.n_type == NT_GNU_BUILD_ID &&
-		    n_namesz != 0 &&
-		    !strcmp((char *)&note_sec->n_data[0], "GNU")) {
-			if (note_sec->n_hdr.n_descsz <= BUILD_ID_MAX) {
-				const u32 n_descsz = note_sec->n_hdr.n_descsz;
-				const u8 *s = &note_sec->n_data[n_namesz];
-
-				s = PTR_ALIGN(s, 4);
-				bin2hex(build_id, s, n_descsz);
-				build_id[2 * n_descsz] = '\0';
-				VMCOREINFO_BUILD_ID(build_id);
-				return;
-			}
-			pr_warn("Build ID is too large to include in vmcoreinfo: %u > %u\n",
-				note_sec->n_hdr.n_descsz,
-				BUILD_ID_MAX);
-			return;
-		}
-		n_remain -= sizeof(struct elf_note) +
-			ALIGN(note_sec->n_hdr.n_namesz, 4) +
-			ALIGN(note_sec->n_hdr.n_descsz, 4);
-	}
-}
-
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
@@ -443,7 +397,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	}
 
 	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
-	add_build_id_vmcoreinfo();
+	VMCOREINFO_BUILD_ID();
 	VMCOREINFO_PAGESIZE(PAGE_SIZE);
 
 	VMCOREINFO_SYMBOL(init_uts_ns);
-- 
https://chromeos.dev

