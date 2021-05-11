Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33023379BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhEKAkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhEKAkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:40:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D231C061345
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:39:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m124so14495551pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RgXpC37KOLrGOOwRxOx7ZzpFECE61gGy4+GXfRXJ9E=;
        b=QXuLgmT532q/P+SdCThgaZLfv3tEW78iD68/2DKm9om/S9QiuBj2VPcYuOPSKXXJRg
         64/VIiOUnwIhHOLPFr1WPY1VVTC4gdsSVy4IjXx0bRSDx8dOB8lsGzTESqu0bd/oIsbo
         8/WXqlS75/7mo1dFl1Dce9KrKssyL2lNUiHcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RgXpC37KOLrGOOwRxOx7ZzpFECE61gGy4+GXfRXJ9E=;
        b=keWOstcuOipT935NJ/928vQPRdNUHXfH3pWjbgeFXVDm/oXu7Qfs9cNJcFPv5XGDOx
         PIXI9t3zykvu36cOQbHOAlBOrTgEvVM2UzxwAu1P5TJOaVaxSuJimDmaUwioDvvO4dJF
         jlqqQv2lUFhBUQFJcSUmPGDPtT0qv7tIYq7McANCdwherYnqcRxFbzX88yiz+HTPH05f
         zyaNFyQ9MQCNXgiAbW52cgWJzgcahlbSTWuU1cjX0ufvXB+xw+C1KAn/Mc4I5ZK6cRQ0
         OCmyOhdx/JmnpzojisTE/ZfjiMN7Y4Tiyfw4YrgQuMMo+wUsZlytWjO+i3Dvs4s6b+gE
         c33A==
X-Gm-Message-State: AOAM532XE864wbD7v5oyjMZIu3g0BWINBPPtzUn2yHdAV9m1cGA34LKY
        8V+FRc8kKHNgQtGZTgKcVlMJEg==
X-Google-Smtp-Source: ABdhPJz/vlTDOX+8lRVr//xS2iPtXJr00kFcUq7DnKZHmp72ZwLF30VJD0gDiEyw9Acr5FDLNjWEJQ==
X-Received: by 2002:aa7:8b56:0:b029:2b9:77be:d305 with SMTP id i22-20020aa78b560000b02902b977bed305mr11349066pfd.61.1620693543916;
        Mon, 10 May 2021 17:39:03 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:39:03 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH v6 13/13] kdump: Use vmlinux_build_id to simplify
Date:   Mon, 10 May 2021 17:38:45 -0700
Message-Id: <20210511003845.2429846-14-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
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
 include/linux/buildid.h    |  2 +-
 include/linux/crash_core.h | 12 ++++-----
 kernel/crash_core.c        | 50 ++------------------------------------
 lib/buildid.c              |  2 +-
 4 files changed, 10 insertions(+), 56 deletions(-)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 3e8d77a93ec4..3b7a0ff4642f 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -10,7 +10,7 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)
 extern unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
 void init_vmlinux_build_id(void);
 #else
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
diff --git a/lib/buildid.c b/lib/buildid.c
index 180a1a9b3b76..dfc62625cae4 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -174,7 +174,7 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
 }
 
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)
 unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
 
 /**
-- 
https://chromeos.dev

