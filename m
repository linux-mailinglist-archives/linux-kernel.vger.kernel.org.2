Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824203661BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhDTVus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhDTVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:50:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB6C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id g16so3578229plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbspQKLdATEoVgdZs/IrxjMWjbvi9Biurj+hlH6bsBM=;
        b=liiXtsG9lsia9ZJtipouuR4tCJuKg+BF2IFmXQ+qus2I+gUJdi4kjcFZXWclCbnuAm
         QE1UdHbDnlPCdlidqTfSIiVs7WnInM0img+HRNSzfWOJUHHGAwFNmQ1YD2qXPpr67x6I
         cS+P3jomrpnXqqm+oTmftnfqKtrFIKnPKl4zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbspQKLdATEoVgdZs/IrxjMWjbvi9Biurj+hlH6bsBM=;
        b=cU78tc+JjklrNxxkkiLjtyL/z1xk7pcukVIxYSsSBzUcXUiudP+rd6BOTGInv8HTDm
         ZO3eiROK5MvVgZeR3M+Be9fGOLvmx42glczbxXPWhLsJ0MwOUfeLLP9WFLe3Oj5+RrrL
         YJ4ulYRGfvBR1j6s7YJkolqM8HN6nJ5tIkc/E97AdPpdcv9zj0SHoOgaGoZfjt/mpvSN
         QP+pm9kUhFk3AMM8rEIt/s0by+Qf3iJM34AlhGIu8NGHxBjdfGQhI4pI6AS4b0UAi48a
         xHcmptJCtaI6x96KHEUbnMSErcKXQL8HJ+W5urzEVMC2s304x0yM2476LGEqYz2CkZzD
         7nzQ==
X-Gm-Message-State: AOAM531IKcu3VPEgGTr7g3RtyEm0B9qdwewCZrZjy+pL+lSFCRXyEPeP
        2Zi1CPmWFpN6y377jueSBIb8uw==
X-Google-Smtp-Source: ABdhPJxhnr6v8cMqMD11wSMxY8wKNW+DJ4vmTJhp9RnZJe3W4+mwJwVFh4d7a6hYSfR5Cmja+0LpiA==
X-Received: by 2002:a17:902:7788:b029:e9:11:5334 with SMTP id o8-20020a1709027788b02900e900115334mr30799987pll.70.1618955406371;
        Tue, 20 Apr 2021 14:50:06 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id c21sm31481pfo.91.2021.04.20.14.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:50:06 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v5 02/13] buildid: Add API to parse build ID out of buffer
Date:   Tue, 20 Apr 2021 14:49:52 -0700
Message-Id: <20210420215003.3510247-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420215003.3510247-1-swboyd@chromium.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an API that can parse the build ID out of a buffer, instead of a
vma, to support printing a kernel module's build ID for stack traces.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/buildid.h |  1 +
 lib/buildid.c           | 50 ++++++++++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 40232f90db6e..ebce93f26d06 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -8,5 +8,6 @@
 
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
+int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
 #endif
diff --git a/lib/buildid.c b/lib/buildid.c
index e014636ec3eb..6aea1c4e5e85 100644
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
 
@@ -50,9 +43,27 @@ static inline int parse_build_id(void *page_addr,
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
@@ -148,3 +159,16 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	put_page(page);
 	return ret;
 }
+
+/**
+ * build_id_parse_buf - Get build ID from a buffer
+ * @buf:      Elf note section(s) to parse
+ * @buf_size: Size of @buf in bytes
+ * @build_id: Build ID parsed from @buf, at least BUILD_ID_SIZE_MAX long
+ *
+ * Return: 0 on success, -EINVAL otherwise
+ */
+int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
+{
+	return parse_build_id_buf(build_id, NULL, buf, buf_size);
+}
-- 
https://chromeos.dev

