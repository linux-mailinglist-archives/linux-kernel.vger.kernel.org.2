Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C035AA08
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhDJBxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbhDJBxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD84C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j7so3596704plx.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbspQKLdATEoVgdZs/IrxjMWjbvi9Biurj+hlH6bsBM=;
        b=DGFh3qWgLs0t89nbGjs6WV20bw9jUEh3AtOwrVlN15v3BXK+HEMfTFk0uhyoXu9NOw
         A0e4FPEIug7eafeH2QF0kzDE+gHgefI/9FlViF7KKbqeu2cPyp5Q7dT7o3BEee4H+1zJ
         WSj64z8O0SFFz2c5fUDNHZ0uo70hbSGfQSK2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbspQKLdATEoVgdZs/IrxjMWjbvi9Biurj+hlH6bsBM=;
        b=bOnigjIbYoyUMCq3Cm69EEADVP0xm7Xkk0QBer+7X76bGkpK+NJFoi071jM2JLonu+
         XSN48DKxDXBLxsCBBgHep5Qi8t8lv2ODlfn68RmaRw80B2vKGEAIc6gYQDeejULLlVZO
         2aKAqY3t5EVXhgiSZzI43/59TIxm4ZlQMdxrXOVj48qqZ9Zyif1iDyC4s/aZCXdfvoy5
         vS0T34fzWr3HFogbyVX6yEfINaRUPinY4rW73eLZo7mm8jAHXslpWs7/8d/PIav5UhJe
         D4gyIykljXuJQron8QaDvpwPQcdG79MDJIxP/PBhw7uM3nFwZgLq2R/9aOloSmO+S5EX
         dbmQ==
X-Gm-Message-State: AOAM533yRKmhFdFIYpd4YQMLN6Gu+vx5PQbLcpQEn2jMw8sU7V0YMFFP
        BfK8sB/Hzu3LXG0vIMKcfBldrQ==
X-Google-Smtp-Source: ABdhPJw3MdU2sdVtt5oqVkKq/I/KEJ5me4jxlg54Haubzowlib3r6LiBp3NXWncRHuPglDoa2ydONw==
X-Received: by 2002:a17:90a:6b08:: with SMTP id v8mr15813867pjj.131.1618019583573;
        Fri, 09 Apr 2021 18:53:03 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:03 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v4 02/13] buildid: Add API to parse build ID out of buffer
Date:   Fri,  9 Apr 2021 18:52:49 -0700
Message-Id: <20210410015300.3764485-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
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

