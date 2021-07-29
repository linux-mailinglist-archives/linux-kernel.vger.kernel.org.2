Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C083DA037
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhG2J2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhG2J2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:28:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CDEC061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:28:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k4-20020a17090a5144b02901731c776526so14631348pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kbKd6mIKJ8w6ikea0jy7SiRuyXcKRZHwxw3CSR6P5ys=;
        b=0BvP4nmCX32RPP47Vd0bP89SOBvqodO5aLveC0qLasWXWHOaz5wS6+hlPr6m1m/zN6
         qG/47KzrBsahiqBRsVmgoYx8JxFwKbe6K82WgkHAZ78xlFqHDx5erSdgUPhMRpgVddG9
         7u5Ofars4QcUInqOKoe2pgJmbQqQdcvo25TVttCP6obVFt7zkbZLXUaRin9Xh0G4y/+d
         Dr3XPnXzNtCm9GELN7/Qpxd+OoaRElWZw+L3G6O5pdeVr4Mbj2iKSDwkVTxUfy1M4IFN
         Dp9XiVWUMBI428ny8fNrOvAjcMU2p7IjBSeheLi3m0u6m2ScrTw9Andpa+2zWcJNTa/g
         5JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kbKd6mIKJ8w6ikea0jy7SiRuyXcKRZHwxw3CSR6P5ys=;
        b=uW67cXSzJNOrCAXPpZ0tYtWz5vTlZtbWFpOLgDnMPxorkVacsk24ycx6W/e8YANCLw
         gQuLwC7LdPpXJtYBdQoaAjN2LS7CgPDpuCoV7kZqYmYwtXhvAMjqqhFSZyC5IkCWQwFo
         CbP07Zhr+vRwYRsGumgNIIpET5JLo/Uzcg1/3Qtdu73NnYwO0+699MR+2AkcYAiKpeNj
         2HJ4TbKKzTSQ9VXeCjpc6DvkLia4riBCCp4tu6KACjVpHeghmeGiAez7C6kpjKXvkpaq
         VH/5It/RNIX7WrIxabpKDne7u4iu9Xa6EbMNYiw0Oze6uZuMsqP4cHHuqsLJFJhiFYh+
         8CSQ==
X-Gm-Message-State: AOAM533i4/861ZKzNs/y50Gjp3bX+00VuUcdGtIHmyS6iR381i6XGjCP
        1s55owraPR3gSYtchEQSQCg+wg==
X-Google-Smtp-Source: ABdhPJzCwrUDOsV9ECzyNF5Llxx7AvntM4hn93q4egIPLtU12gsW1V5wULfaY3iGbHhmHynOd13CbQ==
X-Received: by 2002:a05:6a00:168a:b029:2fb:6bb0:aba with SMTP id k10-20020a056a00168ab02902fb6bb00abamr4304046pfc.32.1627550929658;
        Thu, 29 Jul 2021 02:28:49 -0700 (PDT)
Received: from C02FT5A6MD6R.tiktokd.org ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id az15sm2603578pjb.57.2021.07.29.02.28.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jul 2021 02:28:49 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH 2/3] mm: mmap_lock: use DECLARE_EVENT_CLASS and DEFINE_EVENT_FN
Date:   Thu, 29 Jul 2021 17:28:41 +0800
Message-Id: <20210729092841.38175-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using DECLARE_EVENT_CLASS and TRACE_EVENT_FN, we can save a lot
of space from duplicate code.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/trace/events/mmap_lock.h | 44 +++++++++-----------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
index 5f980c92e3e9..b9dd66f9c226 100644
--- a/include/trace/events/mmap_lock.h
+++ b/include/trace/events/mmap_lock.h
@@ -13,7 +13,7 @@ struct mm_struct;
 extern int trace_mmap_lock_reg(void);
 extern void trace_mmap_lock_unreg(void);
 
-TRACE_EVENT_FN(mmap_lock_start_locking,
+DECLARE_EVENT_CLASS(mmap_lock,
 
 	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
 
@@ -36,11 +36,19 @@ TRACE_EVENT_FN(mmap_lock_start_locking,
 		__entry->mm,
 		__get_str(memcg_path),
 		__entry->write ? "true" : "false"
-	),
-
-	trace_mmap_lock_reg, trace_mmap_lock_unreg
+   )
 );
 
+#define DEFINE_MMAP_LOCK_EVENT(name)                                    \
+	DEFINE_EVENT_FN(mmap_lock, name,                                \
+		TP_PROTO(struct mm_struct *mm, const char *memcg_path,  \
+			bool write),                                    \
+		TP_ARGS(mm, memcg_path, write),                         \
+		trace_mmap_lock_reg, trace_mmap_lock_unreg)
+
+DEFINE_MMAP_LOCK_EVENT(mmap_lock_start_locking);
+DEFINE_MMAP_LOCK_EVENT(mmap_lock_released);
+
 TRACE_EVENT_FN(mmap_lock_acquire_returned,
 
 	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
@@ -73,34 +81,6 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
 	trace_mmap_lock_reg, trace_mmap_lock_unreg
 );
 
-TRACE_EVENT_FN(mmap_lock_released,
-
-	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
-
-	TP_ARGS(mm, memcg_path, write),
-
-	TP_STRUCT__entry(
-		__field(struct mm_struct *, mm)
-		__string(memcg_path, memcg_path)
-		__field(bool, write)
-	),
-
-	TP_fast_assign(
-		__entry->mm = mm;
-		__assign_str(memcg_path, memcg_path);
-		__entry->write = write;
-	),
-
-	TP_printk(
-		"mm=%p memcg_path=%s write=%s",
-		__entry->mm,
-		__get_str(memcg_path),
-		__entry->write ? "true" : "false"
-	),
-
-	trace_mmap_lock_reg, trace_mmap_lock_unreg
-);
-
 #endif /* _TRACE_MMAP_LOCK_H */
 
 /* This part must be outside protection */
-- 
2.20.1

