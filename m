Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C141335AA14
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhDJBxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbhDJBx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C483C0613D7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id g10so3584973plt.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+F0+AQI/pKT3bMZFigretaz19drQemk736g0PUPrfRo=;
        b=KB/4yRfKd6+DbquRf7oLoHTi9Y3AZV79OX83nnWqDE8XbX9rBnKqxEsqVHiQfoOJue
         gUJ0lRmJipsPUpE9V1NDzPqiZwuJpDvq64YECg2b97Ofo1Qy/MM5RRzTqFt9dhfDFA/a
         gJhmsr1J9jV+F0TLNQk2+cEXpTunBhqvBW/+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+F0+AQI/pKT3bMZFigretaz19drQemk736g0PUPrfRo=;
        b=BMJ0dOv+3QLlk1dBzig+pR+DHj3KZN4bkaTQ2jDx/FQQpR1RWJExDhB+yEhLlVif7+
         uJOJ2O/JgYZ4wL+YE+Afu4IzT0roA/CfCQ+CBF7REcD5rnMO7x5mFY80xWGZs/K7g+U/
         YAd6FdJkJFePF+DfRdDmoO9Ej5AXlm9Pu6y/5IgEArD88HCvs7mn/t5Ac9wtlDRZHxHN
         3RTnpMAfzba1rLZOv5wo04dxhRHSfeEknn+e00uFpMKzyk9bFzqFsZluWVNFB/BupoEX
         7VuU6gGZM5IcNNxiZ3yA31KdTnC6uEqDKqGbCpv3jUQZg0gMuPEcpkPiekk6ruuuRwtW
         Wtng==
X-Gm-Message-State: AOAM530AVJCRGifSyYGS4jLvm/fw3RtULZ42GCVxy98kSOhIZNlLb2Gg
        3b6YXGW3IeDHFsMg85Bjl27wAg==
X-Google-Smtp-Source: ABdhPJy0Kdab/ZmPAyAdRv+cesLUL1hCyZ/U0aatSXKpYb6FnicOyXQRcGOkC73NBEw7OY+CKwXPaw==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr16275836pjq.94.1618019592680;
        Fri, 09 Apr 2021 18:53:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:12 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH v4 13/13] kdump: Use vmlinux_build_id to simplify
Date:   Fri,  9 Apr 2021 18:53:00 -0700
Message-Id: <20210410015300.3764485-14-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
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
 include/linux/crash_core.h |  7 ++----
 kernel/crash_core.c        | 50 ++------------------------------------
 2 files changed, 4 insertions(+), 53 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 206bde8308b2..2174dab16ba9 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -39,7 +39,8 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 #define VMCOREINFO_OSRELEASE(value) \
 	vmcoreinfo_append_str("OSRELEASE=%s\n", value)
 #define VMCOREINFO_BUILD_ID(value) \
-	vmcoreinfo_append_str("BUILD-ID=%s\n", value)
+	BUILD_BUG_ON(ARRAY_SIZE(value) != BUILD_ID_SIZE_MAX); \
+	vmcoreinfo_append_str("BUILD-ID=%20phN\n", value)
 #define VMCOREINFO_PAGESIZE(value) \
 	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
 #define VMCOREINFO_SYMBOL(name) \
@@ -69,10 +70,6 @@ extern unsigned char *vmcoreinfo_data;
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
index 825284baaf46..f7eb752560f1 100644
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
+	VMCOREINFO_BUILD_ID(vmlinux_build_id);
 	VMCOREINFO_PAGESIZE(PAGE_SIZE);
 
 	VMCOREINFO_SYMBOL(init_uts_ns);
-- 
https://chromeos.dev

