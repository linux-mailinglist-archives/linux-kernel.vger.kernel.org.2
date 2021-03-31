Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93DA34F723
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhCaDFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhCaDFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DF2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l123so13513849pfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xY3ms9y+N39U80obnwVhTs0YwJmwUA+v7N5J1rpQp20=;
        b=lmjOvoqa3MT6JcIM+QEhEIsHtotCoIPKKexdWYKQqYyx2IGJG163S6/LE4XDAfvg4I
         E3mtf3yNWOcZhhF+xLfFipTdkXNK741kUDOjODfhLfFzLtgBvJrAfvFwhDck2W6tAhoO
         jqsnhchpIpCO4t/Ja6EuwJ1giAVGm4a53ngec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xY3ms9y+N39U80obnwVhTs0YwJmwUA+v7N5J1rpQp20=;
        b=VldxB9/f3yX2M+kStRQIvOnFvNvJPt3ch3PGsu5JUB2gX8iC4gr00NaZhIo8/0Ye8L
         8+Kas6GccgAJmJOd9hBVS0N3fjMY0KjQNfOAS2MPcxrWtoMOWFiD5b5UMAAD325+0yYL
         yP0WyUuM3bFohKmbcml68MijTP8sdSob9P7XmTE8IyaGNxftclsiIlkAc1rKBHqJm77j
         XvWLSx/eKqr5t2OHlFyG/y+j3jU23NFrrmolh4fA/xIzAFZevvFMf1XkX3p3BKGLxR6l
         pVcCKng9evHmidxcBUza70cNfvGLFMGP6Vb1Zt8Wmkf9YZu3nIfAHoSoUor3G9Fnlf8T
         2T8A==
X-Gm-Message-State: AOAM530jkbXMjc/oYiU3AmZcmPXgOr2yt75OCXtDw5t4gjXospV/Ym2V
        EAM8SX4lZtPAbjEJTn/YJ4GoSuZKBHMTiw==
X-Google-Smtp-Source: ABdhPJzXBReuWQG4hi6mQApR1jBihKX+HxidoiWYNHaMxLNfvM2Hw7lntztg+V0fq2CvKdzoL/lPSQ==
X-Received: by 2002:a63:f258:: with SMTP id d24mr1135388pgk.174.1617159924457;
        Tue, 30 Mar 2021 20:05:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v3 01/12] buildid: Add API to parse build ID out of buffer
Date:   Tue, 30 Mar 2021 20:05:09 -0700
Message-Id: <20210331030520.3816265-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331030520.3816265-1-swboyd@chromium.org>
References: <20210331030520.3816265-1-swboyd@chromium.org>
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
index 6156997c3895..010ab0674cb9 100644
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
@@ -147,3 +158,16 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
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

