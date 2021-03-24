Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D483346F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhCXCFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhCXCFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:05:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C4C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:05:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e33so13602930pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TpA0XuYAYVanYdVhnp/5NKPSASr0R+WuUXeoJO+x+fQ=;
        b=ModFz4CrhxOc4t/AQigdavPqYdXRBrvoV9UBO/xEZDtAHBoB2x0So2kjJSYEuI9pll
         KrbCefuX2jQ0yhBlTLDUkSsO3RxUAn5ctjoML5DDxFVh1OfxKz3mbomXegJJ+LlY28aD
         jPWhQANm7/5oy/EmpRT0WJfUH58Fa3zHHo5vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpA0XuYAYVanYdVhnp/5NKPSASr0R+WuUXeoJO+x+fQ=;
        b=JHmH2arNoS8Ux4HJlWI0278nXI7fpJSpakotG5Vy0u7t3Rpue33lCtbutZYywSEoiv
         zDVDsrdojfgOmdjlzrN9SfcovAAF9fxRLgeb5FYAP3WNZZc58anajDlcnLqtkzHxLmuc
         QknXvKdZfyvuX5apxK4ES9XztDEjMYokueN+JDPTitE8JQKp3muRUgSlyChpBucZ332U
         dD4GKsAnRp6WclIzUaJeBKA8bx6OWVIP0aFhHPSpTzEN8PNTA+kpzVgnvpWp7RMuXbn3
         kT88+rahBqEfz8tGlGd72sZyJZuxn1cws0D2s7r5F7rJklArjRDK3utMJ4mDxlUFViuA
         mBbQ==
X-Gm-Message-State: AOAM531FgIAZvir8nUtXbPfPBvGPRoGQ/ovUUyc+djPW1UAYifQqQbJh
        YExjTho7oQd7ZjUe2vyQlrSjEw==
X-Google-Smtp-Source: ABdhPJzcroxb9IRTs0BVSmxlj0ZxdfXqvqaok4Py9N3Dm1Pdtg1V8GksnSXOa/zQ/YO1RvIaDME96g==
X-Received: by 2002:a63:4462:: with SMTP id t34mr931332pgk.389.1616551501156;
        Tue, 23 Mar 2021 19:05:01 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:05:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH v2 12/12] kdump: Use vmlinux_build_id() to simplify
Date:   Tue, 23 Mar 2021 19:04:43 -0700
Message-Id: <20210324020443.1815557-13-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use the vmlinux_build_id() helper here now instead of open coding
it. This consolidates code and possibly avoids calculating the build ID
twice in the case of a crash with a stacktrace.

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
 include/linux/crash_core.h |  6 +-----
 kernel/crash_core.c        | 41 ++------------------------------------
 2 files changed, 3 insertions(+), 44 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 206bde8308b2..fb8ab99bb2ee 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -39,7 +39,7 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 #define VMCOREINFO_OSRELEASE(value) \
 	vmcoreinfo_append_str("OSRELEASE=%s\n", value)
 #define VMCOREINFO_BUILD_ID(value) \
-	vmcoreinfo_append_str("BUILD-ID=%s\n", value)
+	vmcoreinfo_append_str("BUILD-ID=%20phN\n", value)
 #define VMCOREINFO_PAGESIZE(value) \
 	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
 #define VMCOREINFO_SYMBOL(name) \
@@ -69,10 +69,6 @@ extern unsigned char *vmcoreinfo_data;
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
index 825284baaf46..0b0e24668697 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
  */
 
+#include <linux/buildid.h>
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
@@ -378,51 +379,13 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
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
 /*
  * Add build ID from .notes section as generated by the GNU ld(1)
  * or LLVM lld(1) --build-id option.
  */
 static void add_build_id_vmcoreinfo(void)
 {
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
+	VMCOREINFO_BUILD_ID(vmlinux_build_id());
 }
 
 static int __init crash_save_vmcoreinfo_init(void)
-- 
https://chromeos.dev

