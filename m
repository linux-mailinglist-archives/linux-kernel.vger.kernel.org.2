Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2963D3297C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbhCAWxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbhCARtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:49:36 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D04C0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:47:53 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 201so12017557pfw.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+V91FRp4Sbh05BLovRzOKQntGSlEoq4KQYgquXuBxU=;
        b=dZwUtPvgsq8tWu5jkxszRpmEfx91RRJBV2a2yNBgUYt83R9Hwfetgh8ejw3jcjplwK
         B+mEn6meys3LSxkzcw45IpS7Q3aa5ZcM2ipv92G7wWkbg4XEPpIHiBHo0RZ2i5tVcroQ
         7rg8zij8hy/lq1sUL21qHUqitBljFVkVYK6fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+V91FRp4Sbh05BLovRzOKQntGSlEoq4KQYgquXuBxU=;
        b=DMwaUm3lCercm72Uzc3XEnjjbEU1wx6w63on/7HpK4dF3/1aM0fmMvpvfktNidnRQ2
         xt/3mh6fKi3VheXbKPOp5qTU8/wLWofZI8sxX9mL6TVRg8kkZEiW+xeZOgL/Du0KAyos
         1Hv/rX57Olrg10OnAAswj5AlFigT/uG5pvY+XgaDuDcCU0ni/meKBv9qO/YbiHBpDa/C
         eJyg7sAGKzUSV1PQsBDodMRL2X+TpqrbWqMBgD7yXVHsAtvAJf7Tf5IjqCA0IPy++4cW
         0Xpo5gUYZpRlKKhz53+tTk2YaufW3uBz4Tuk1JohQNmXPZT0IMOgBu2JOllHX/t/3NSt
         tjIA==
X-Gm-Message-State: AOAM530WY5owLDXBLCOg+JLShE5am9gZPRTOGleaMlRGNoJviBNfu08/
        +PjbaFFBKdLLltwaI434anHYDw==
X-Google-Smtp-Source: ABdhPJw3p9cOq/KM7ozuIzqHqWG9Ppdocj3VWGe3w+NsPKjWS3NbRFrChn/otKaWihoc0Xs8PP33Kw==
X-Received: by 2002:a62:7c95:0:b029:1ed:ae61:5379 with SMTP id x143-20020a627c950000b02901edae615379mr16526125pfc.63.1614620873497;
        Mon, 01 Mar 2021 09:47:53 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3c20:df33:e36:93df])
        by smtp.gmail.com with ESMTPSA id y202sm19071325pfb.153.2021.03.01.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:47:53 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH 1/7] buildid: Add method to get running kernel's build ID
Date:   Mon,  1 Mar 2021 09:47:43 -0800
Message-Id: <20210301174749.1269154-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301174749.1269154-1-swboyd@chromium.org>
References: <20210301174749.1269154-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vmlinux_build_id() so that callers can get a hex format string
representation of the running kernel's build ID. This will be used in
the kdump and dump_stack code so that developers can easily locate the
vmlinux for a stacktrace.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/buildid.h |  3 ++
 lib/buildid.c           | 65 ++++++++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 40232f90db6e..dd134a96a87c 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -5,8 +5,11 @@
 #include <linux/mm_types.h>
 
 #define BUILD_ID_SIZE_MAX 20
+#define BUILD_ID_STR_SIZE_MAX (BUILD_ID_SIZE_MAX * 2 + 1)
 
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 
+const char *vmlinux_build_id(void);
+
 #endif
diff --git a/lib/buildid.c b/lib/buildid.c
index 6156997c3895..57daf928b133 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -2,30 +2,23 @@
 
 #include <linux/buildid.h>
 #include <linux/elf.h>
+#include <linux/kernel.h>
 #include <linux/pagemap.h>
 
 #define BUILD_ID 3
+
 /*
  * Parse build id from the note segment. This logic can be shared between
  * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
  * identical.
  */
-static inline int parse_build_id(void *page_addr,
-				 unsigned char *build_id,
-				 __u32 *size,
-				 void *note_start,
-				 Elf32_Word note_size)
+static int parse_build_id_buf(unsigned char *build_id,
+			      __u32 *size,
+			      const void *note_start,
+			      Elf32_Word note_size)
 {
 	Elf32_Word note_offs = 0, new_offs;
 
-	/* check for overflow */
-	if (note_start < page_addr || note_start + note_size < note_start)
-		return -EINVAL;
-
-	/* only supports note that fits in the first page */
-	if (note_start + note_size > page_addr + PAGE_SIZE)
-		return -EINVAL;
-
 	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
 		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
 
@@ -49,9 +42,27 @@ static inline int parse_build_id(void *page_addr,
 			break;
 		note_offs = new_offs;
 	}
+
 	return -EINVAL;
 }
 
+static inline int parse_build_id(void *page_addr,
+				 unsigned char *build_id,
+				 __u32 *size,
+				 void *note_start,
+				 Elf32_Word note_size)
+{
+	/* check for overflow */
+	if (note_start < page_addr || note_start + note_size < note_start)
+		return -EINVAL;
+
+	/* only supports note that fits in the first page */
+	if (note_start + note_size > page_addr + PAGE_SIZE)
+		return -EINVAL;
+
+	return parse_build_id_buf(build_id, size, note_start, note_size);
+}
+
 /* Parse build ID from 32-bit ELF */
 static int get_build_id_32(void *page_addr, unsigned char *build_id,
 			   __u32 *size)
@@ -147,3 +158,31 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	put_page(page);
 	return ret;
 }
+
+static void build_id2hex(char *dst, const unsigned char *src, __u32 size)
+{
+	bin2hex(dst, src, size);
+	dst[2 * size] = '\0';
+}
+
+/**
+ * vmlinux_build_id - Get the running kernel's build-id in hex string format
+ *
+ * Return: Running kernel's build-id in hex string format
+ */
+const char *vmlinux_build_id(void)
+{
+	extern const void __start_notes __weak;
+	extern const void __stop_notes __weak;
+	unsigned int notes_size = &__stop_notes - &__start_notes;
+	unsigned char build_id[BUILD_ID_SIZE_MAX];
+	__u32 size;
+	static char vmlinux_build_id_buf[BUILD_ID_STR_SIZE_MAX];
+
+	if (vmlinux_build_id_buf[0] == '\0') {
+		if (!parse_build_id_buf(build_id, &size, &__start_notes, notes_size))
+			build_id2hex(vmlinux_build_id_buf, build_id, size);
+	}
+
+	return vmlinux_build_id_buf;
+}
-- 
https://chromeos.dev

