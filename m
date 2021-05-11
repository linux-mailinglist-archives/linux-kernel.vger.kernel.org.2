Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46C1379BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhEKAkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhEKAj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:39:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCECC061761
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b3so9964715plg.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbspQKLdATEoVgdZs/IrxjMWjbvi9Biurj+hlH6bsBM=;
        b=l01jwAL99b+6ual1hc61NJSWCegcP0OTWeWfMKVptRHwlPhBzQatsTfYxNLyzCKCI9
         pfUZGOYVjGcFG7VhsQY2uwAlaFlLMaUNEkWSQS3DbHJa1TkLydThseReY29dsCedVMbP
         FQtqrBr3pbjlnjgB0MM/wRMAsvDnDu1VFvAAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbspQKLdATEoVgdZs/IrxjMWjbvi9Biurj+hlH6bsBM=;
        b=as7ZIKSbiX32TVxLIReiXeSmALN73gRVfJT4f38KE6TQnn+uwhfMn/vR7ihxebUl6s
         MbWtBFFEhS+fY/35gkA+84hNZ3oWhrKG0kamtzNlSAl441ZT/HvzLJmsBvttipkWNMw1
         TTxA/HMtTGp0e74Ag5Fm7X6gIPBcWb7X5UgACasDusUmPeiL543EadtHq5Rmsc2jQMGS
         hMirSIG3fyu7O8oFvir5wgyRLzKGm20UMdH77KI0sUIfQ1CD+PRBkrAIJmR70gYgYgo2
         1Wd45IGWKjg3KOPAph+vakliK0MsW8Ml1WXhvH7CFGRoKUOrwzsytPBIxzgUchMRbjQE
         P4IA==
X-Gm-Message-State: AOAM532svIxyxDYOu6hbSz5ylFjabpj4PjJhSn5CB1XZgzaYpa49Ypui
        N8MK8UGBAzDXCXjWiwYqkyqRWw==
X-Google-Smtp-Source: ABdhPJwSUYof8wAYTnuWBV3+i1jYXR/kYrapu8CcdXl3Q9yecO3TXFdmi4MCtvpnoE3YO2RKxgRWJg==
X-Received: by 2002:a17:902:8a86:b029:ef:5161:99e7 with SMTP id p6-20020a1709028a86b02900ef516199e7mr2141266plo.32.1620693530310;
        Mon, 10 May 2021 17:38:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:38:50 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v6 02/13] buildid: Add API to parse build ID out of buffer
Date:   Mon, 10 May 2021 17:38:34 -0700
Message-Id: <20210511003845.2429846-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
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

