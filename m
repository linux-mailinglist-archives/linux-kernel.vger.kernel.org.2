Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E254E34F72E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhCaDFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhCaDFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:38 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30588C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:38 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l76so13144498pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N2ngqVyWuXaPweoaHCYGBgBwQb+GOOcKRlPbrkbWiqM=;
        b=LeQcohqOOm5cr6wT5INmoqw7KuA+4LIoP8kgspyu7cyNviHOi8D7Yf/jrQtNr867YF
         8yfaJrrwCs2aH9jAIfyEBq5S6Xx4d8BZTgM3AKB1+x4C8pKQ1vI4VKYQdakBUV5SGRWJ
         gMqTirk7k1rNz8oXwN1r9zVYbLVEAdmj7MkYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2ngqVyWuXaPweoaHCYGBgBwQb+GOOcKRlPbrkbWiqM=;
        b=UUhO4G/yjsckFpKjy5Z4GdYmucgMXoN9QAGzoMcnFnKizo7Wh/3rtzboKqkjbcJil6
         DzvRhgBDzGKl7mdUDd1NksUkON0mrOX7XEGZJkt/zwHJhpqGxoA6QuEJeLDTOy+q16UU
         FcwZ1ndd+sTPhSgAW45BOBMDEhNB0l0u1hdLBnLfxQ2ka1LkaS2MN/6/MljzMbytVb0N
         9kduwqpWanAXLR9E/q5dJQ4mKZPr0ijFjKycEmB8TrKGMsdhXPnl2fB0C35J3zgp7XX1
         R4C5929d+BFZfgxqTooh24NbAEF0jvN4h3Vryg59aAYbgRxNvf7d8LHlCR+FuVN+P9YS
         efBQ==
X-Gm-Message-State: AOAM530zSMq46ChWZE5JPDp3qAK7wiAaPUGX2K6FiaddJeICXLfqKMg1
        epUHI2qkhJ5es8IZre7/9vNiOQ==
X-Google-Smtp-Source: ABdhPJzOtvrGQEJzIFkbI8x/nm7bBVFtdW24D4Lp1GRqZMvhok8UmPCM5DPaNI5MRXBwQJZmbv7O1w==
X-Received: by 2002:a65:404b:: with SMTP id h11mr1143856pgp.25.1617159937830;
        Tue, 30 Mar 2021 20:05:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:37 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH v3 12/12] kdump: Use vmlinux_build_id to simplify
Date:   Tue, 30 Mar 2021 20:05:20 -0700
Message-Id: <20210331030520.3816265-13-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331030520.3816265-1-swboyd@chromium.org>
References: <20210331030520.3816265-1-swboyd@chromium.org>
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
index 825284baaf46..6b560cf9f374 100644
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
+	VMCOREINFO_BUILD_ID(vmlinux_build_id);
 }
 
 static int __init crash_save_vmcoreinfo_init(void)
-- 
https://chromeos.dev

