Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D8346F33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhCXCFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhCXCEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:04:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E5C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t20so7099152plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTViBd2CblQCYYTYIA/BnWrPbYp/Rg6Ysmy5b/6qMok=;
        b=b4+g/DEALeK+0LblrPRdyC7/O4Xdztch96h9gpl27A3SR2nHtlOPNjeKB3HvKk6Jqr
         zY6tuHTg6dtpWzsLjwIeQNpV8bvwyrrk6z7ieedC26/5lifdiUdDnPYlj88b+DY6rNIG
         +2Gk9Vz2ZZzFuUSwmZCUhI37Ejk0tXOItOwaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTViBd2CblQCYYTYIA/BnWrPbYp/Rg6Ysmy5b/6qMok=;
        b=gXpTOB18UK+6q9C/jhe5kql960eGU6ICNa/g9aJfW7O0umKVzSMazoCNtP4XWZtyb3
         Q5xGQ+j9MsIvMUJpk1Z30rgKr0ONwV0iM+4UnDqZyyfEKeaV7uZZYzm1lLEbw2QjbV7n
         sdcDE4tkbEPQgk3fcqyEr7SOPyr2j0cBg9I/XC+8moAWu7CGGrqZl0SEjjsk39Agii30
         9Sul96TBQXK47mQVYmjOTDJGa0nITmduGvBNhh8qHcaD3+qS0UGXHmFJtUS7wlppKfbr
         BKdb3tHBOTXKt6QBmwq9iTBvGLIMe1hnle+j26T6W3M8f05h+kQAXyc1KH6PcNdt8zTZ
         417Q==
X-Gm-Message-State: AOAM5329F5rE0dN5f9FQY8qob6yPpYZ8kNS9AHtVgKDrF3GN+593rFIi
        IAknEXXuXOCU8X6eavHPqvpRgmrjfEXHAA==
X-Google-Smtp-Source: ABdhPJxM8iXvhosxLoF94PF702dC+dwLaNsu1yZNcl0bRm6TthpyPic3/+AbdR3yub0gHHS9ASrKVA==
X-Received: by 2002:a17:90a:2a41:: with SMTP id d1mr933288pjg.164.1616551488794;
        Tue, 23 Mar 2021 19:04:48 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:48 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH v2 02/12] buildid: Add method to get running kernel's build ID
Date:   Tue, 23 Mar 2021 19:04:33 -0700
Message-Id: <20210324020443.1815557-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vmlinux_build_id() so that callers can print a hex format string
representation of the running kernel's build ID. This will be used in
the kdump and dump_stack code so that developers can easily locate the
vmlinux debug symbols for a crash/stacktrace.

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
 include/linux/buildid.h |  2 ++
 lib/buildid.c           | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index ebce93f26d06..2ff6b1b7cc9b 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -10,4 +10,6 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
+const unsigned char *vmlinux_build_id(void);
+
 #endif
diff --git a/lib/buildid.c b/lib/buildid.c
index 010ab0674cb9..fa1b6466b4b8 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -4,6 +4,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/string.h>
 
 #define BUILD_ID 3
 
@@ -171,3 +172,21 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 {
 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
 }
+
+/**
+ * vmlinux_build_id - Get the running kernel's build ID
+ *
+ * Return: Running kernel's build ID
+ */
+const unsigned char *vmlinux_build_id(void)
+{
+	extern const void __start_notes __weak;
+	extern const void __stop_notes __weak;
+	unsigned int size = &__stop_notes - &__start_notes;
+	static unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
+
+	if (!memchr_inv(vmlinux_build_id, 0, BUILD_ID_SIZE_MAX))
+		build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
+
+	return vmlinux_build_id;
+}
-- 
https://chromeos.dev

