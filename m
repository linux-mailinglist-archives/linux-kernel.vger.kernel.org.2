Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2F13297E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbhCAXBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 18:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbhCARv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:51:27 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F298C061223
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:48:00 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q204so10950456pfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IgIqE4zqLLzQAgN/XnF9qZIt9tT1A/2XToO9EAjimLU=;
        b=VfHyF2nE1SnOgwI5Uql6AynW2ttrEoJiik3YsgU7Lqu9nf6lKI51JNaQtRIXXQuCEY
         rduQvXX7/Sss8fYkbvL0dwSw/qkqMjqwYmUJKWOL/lb4qo8Srv9+gvBgjgwtlGOuf8XM
         h3Ol8EzA/Tc4XT26dgl/vpJBfizhk3tTedPao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgIqE4zqLLzQAgN/XnF9qZIt9tT1A/2XToO9EAjimLU=;
        b=tO50p1CWP09aH8Rh+28H52XvRolCwN2YMmnJZs6VD3o1MHf18ZUjgkG1GIBw/tWyPi
         tnUsZ1nKMUyQYpzIpSPk8PZeXWBuLaflZ7VTY2+3FhgPuARIVb4BrsSePo8iDMkV3Da0
         o6CoxNLabv4idcgKbcIMiakMpJd8z+s1oY7dNeAWugFOIINxwWBEEMOQqY5Y4bT8KDVQ
         n61Mnngv5fXKdi18eAX2xNKs1zKmNESNxOJigCIOXM28ct4HFBCneuvatCi2TRE+O4Fl
         A5rCsLrJRWv5GcYTMF4xa7wjQtPPrVEKMiaoyEteR2HaH/3/l5kIv9Mar7L5/9MraSZm
         VObA==
X-Gm-Message-State: AOAM533wi6uPGQGdFaHQrtLaMGMKDTLwYz/O4vMLjqLdaAIEyHu7V9UP
        lgtIxY0n1hSvgf/z0HsfjoCxCcFaKSa62w==
X-Google-Smtp-Source: ABdhPJy1xKs29RIwJ8Ev9QDa4HxL6guMYNNYCak2SdN/TdOo9h9VXnAynTVHwgGCPyh3p2fq7yFOuQ==
X-Received: by 2002:a65:4288:: with SMTP id j8mr11064519pgp.231.1614620880253;
        Mon, 01 Mar 2021 09:48:00 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3c20:df33:e36:93df])
        by smtp.gmail.com with ESMTPSA id y202sm19071325pfb.153.2021.03.01.09.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:47:59 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH 7/7] kdump: Use vmlinux_build_id() to simplify
Date:   Mon,  1 Mar 2021 09:47:49 -0800
Message-Id: <20210301174749.1269154-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301174749.1269154-1-swboyd@chromium.org>
References: <20210301174749.1269154-1-swboyd@chromium.org>
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
 kernel/crash_core.c | 46 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 38 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 825284baaf46..07d3e1109a8c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
  */
 
+#include <linux/buildid.h>
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
@@ -378,51 +379,20 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
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
+	const char *build_id = vmlinux_build_id();
+
+	if (build_id[0] == '\0') {
+		pr_warn("Build ID cannot be included in vmcoreinfo\n");
+		return;
 	}
+
+	VMCOREINFO_BUILD_ID(build_id);
 }
 
 static int __init crash_save_vmcoreinfo_init(void)
-- 
https://chromeos.dev

