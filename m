Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A29E42850D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 04:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhJKCNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 22:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhJKCNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 22:13:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AB5C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 19:11:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 21so4045560plo.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 19:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3W1YPacmCCYy5sTjqSS48y7QQu3vkowBEiww0ZAUWFw=;
        b=am8AgWiyXe4NW4Npl8JNKZlKSPiHBkT2XX9UsUPmPGQn0Mqvm64DF1s32TGoUvdkUd
         hoKFfB6rvMtlIDrcc4F7TfCvYprxJ7rbWM+wWqmuN/YWWK0I6b+uF9Xv/QMYKBM0As8l
         3C9X5ZNEnGPong6KN1wo4q3RrZNYn1OYz1QtiJ0AMJY1R3KgZYc96woOe3RaR1VEnWwL
         R2yblrZHroUuY0AtxvweL86aAAO3/46/X4ePGDdGdzd7sre9vxz8GWONuGXE+OMXdNv8
         F5viLWJObdEiRN68UWoHGKB5NadAaCIbDBkpqSjfBOpp8fYtje9qYGKpAJcz6QOO3ajI
         YAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3W1YPacmCCYy5sTjqSS48y7QQu3vkowBEiww0ZAUWFw=;
        b=egYbzuWFZNzYwz+ko9G07Dh9vlEPp+VVP57VNB+A0+d+uhJmMdBYKPNx7cbs/CZsau
         LKcrwoYdIgLy8PqtDSbpA+sitoQmsvul7VFS7mVH8u2LpkP+e9g6T9ppxxvCKO2ZSxmR
         q1Oyh52uAq1qdi68lURh+7ictD64Px9w95NX7WTCM85txm2iOLFDfkUR5vIPYaJ0/Ivl
         fb0pmidrrVaTaDAmn6JQrjRPrhxXbz8BAUbWrUyW31pv7QXX7/ojNTrVBW212z91zzMM
         AH+F0vsSq/O6427ensqj61wC7QsOSUB5KIkeWHhaKLqn53YnYJc5Fjey24YVvaZR2h8J
         8hXQ==
X-Gm-Message-State: AOAM531HQ28TIogjaHCaDa0mia1U11IHz9oUZLgNkanrukKT7ivmcFym
        u2s0ob7WtjpPlDOWXznTt17Y1Q==
X-Google-Smtp-Source: ABdhPJwsdIQU250yejq1VzBaj6zgitGurMSTcucT8crx8Hf/F04/gPH06FN+wLfVWaJtgKImmjbYMQ==
X-Received: by 2002:a17:903:2341:b0:13e:ae30:412 with SMTP id c1-20020a170903234100b0013eae300412mr21951142plh.15.1633918293484;
        Sun, 10 Oct 2021 19:11:33 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id 186sm5719383pfg.20.2021.10.10.19.11.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Oct 2021 19:11:33 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v3] mm: mmap_lock: remove "\n" in TP_printk and use DECLARE_EVENT_CLASS
Date:   Mon, 11 Oct 2021 10:11:24 +0800
Message-Id: <20211011021124.86248-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace core will add "\n" automatically on print. "\n" in TP_printk
will create blank line, so remove it.

By using DECLARE_EVENT_CLASS and TRACE_EVENT_FN, we can save a lot
of space from duplicate code.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/trace/events/mmap_lock.h | 48 ++++++++++----------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
index 0abff67b96f0..14db8044c1ff 100644
--- a/include/trace/events/mmap_lock.h
+++ b/include/trace/events/mmap_lock.h
@@ -13,7 +13,7 @@ struct mm_struct;
 extern int trace_mmap_lock_reg(void);
 extern void trace_mmap_lock_unreg(void);
 
-TRACE_EVENT_FN(mmap_lock_start_locking,
+DECLARE_EVENT_CLASS(mmap_lock,
 
 	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
 
@@ -32,15 +32,23 @@ TRACE_EVENT_FN(mmap_lock_start_locking,
 	),
 
 	TP_printk(
-		"mm=%p memcg_path=%s write=%s\n",
+		"mm=%p memcg_path=%s write=%s",
 		__entry->mm,
 		__get_str(memcg_path),
 		__entry->write ? "true" : "false"
-	),
-
-	trace_mmap_lock_reg, trace_mmap_lock_unreg
+	)
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
@@ -63,7 +71,7 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
 	),
 
 	TP_printk(
-		"mm=%p memcg_path=%s write=%s success=%s\n",
+		"mm=%p memcg_path=%s write=%s success=%s",
 		__entry->mm,
 		__get_str(memcg_path),
 		__entry->write ? "true" : "false",
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
-		"mm=%p memcg_path=%s write=%s\n",
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

