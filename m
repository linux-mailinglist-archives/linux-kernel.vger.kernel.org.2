Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3963DA038
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhG2J3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhG2J3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:29:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6417EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:29:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b6so9409433pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Su0VFVFTdWpdLAS734Wj7JN2joCnRImQkjmBeHRcGw=;
        b=Mm0bGYj6/zbXmOrHkAVjtM11qQ3M/chM0vse5Hslve/QWFmKyfyICYhWL3BT2hx/Jo
         lOGR9ZsMGew7INrypS3uKTBqAUxFZLAlgwJWVAy6MeLdws6WhQBqj5mtKaSq0iK/vyMB
         j0PQxCdHntIUxePG/8zJzVfWMGkAdNo6uIAkTeLUChMsobrUMrNxGS57Fj546MJq6Zln
         adJvdzIF3G5hlLC+fD1uEx56nURRO9YJdcs2v4uvphig6pyHSr3B/qUQGwNsHiAgqFUb
         4FR42rMO6lpqG+xPLhSjtQH06l70y+kl3W4FEp/pKMwdDKZ1XmHobV7jT7YvdKC0oyBd
         P7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Su0VFVFTdWpdLAS734Wj7JN2joCnRImQkjmBeHRcGw=;
        b=mQwB+bn6lktgAnyKxh37f/hBP78WVz8ouO0c/SB9zh4YLu1iDDb71Y7gGpGYdPeZBV
         SFImh6MJlHMCdqzXQhUs3qnox+bbjuVQmzpu3Z/L4gy24O+YvVcHiEAfpsUdVrtBxspB
         yfeMy0+7Cr1GEcd20KiV1QAIfTfBiRZEkHd3lGLMBhQ525mmDK8GzdgV3OsdEgutaqR5
         6EljRf0HelYaLQ6DSYL3jV8eejww5Tom5y1uL+EbF0NL6Vu1PyOin2UIAyVsrY2ejL37
         MGq55yrIclc1yNLmnko6UYLcWpdbEyKbcR7vGVLxBHjbHa3g4d4uqa9Yad1quq2kBQxy
         ZNwQ==
X-Gm-Message-State: AOAM531E5YnrnpKsG2LuTHOa/ta1TJsZlaLOhinc5IAR/12HokpktESh
        mFCJEFb5otENEDwQoM14T7Q4ybDZWqGkZw==
X-Google-Smtp-Source: ABdhPJzlw1r4Pigt4TQxXfj0XMmgGNpRfR9b/xT71Yrj9/h4lENPsF8b7WzA9XQCx49BV4sNearpNA==
X-Received: by 2002:a17:90a:5101:: with SMTP id t1mr14152738pjh.107.1627550939931;
        Thu, 29 Jul 2021 02:28:59 -0700 (PDT)
Received: from C02FT5A6MD6R.tiktokd.org ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id b15sm2962031pgm.15.2021.07.29.02.28.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jul 2021 02:28:59 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH 3/3] mm: mmap_lock: add ip to mmap_lock tracepoints
Date:   Thu, 29 Jul 2021 17:28:53 +0800
Message-Id: <20210729092853.38242-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmap_lock is acquired on most (all?) mmap / munmap / page fault
operations, so a multi-threaded process which does a lot of these
can experience significant contention. Sometimes we want to know
where the lock is hold. And it's hard to locate without collecting ip.

Here's an example: TP_printk("ip=%pS",ip)
Log looks like this: "ip=do_user_addr_fault+0x274/0x640"

We can find out who cause the contention amd make some improvements
for it.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/trace/events/mmap_lock.h | 27 +++++++++++++++++----------
 mm/mmap_lock.c                   |  6 +++---
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
index b9dd66f9c226..8913a9f85894 100644
--- a/include/trace/events/mmap_lock.h
+++ b/include/trace/events/mmap_lock.h
@@ -15,35 +15,39 @@ extern void trace_mmap_lock_unreg(void);
 
 DECLARE_EVENT_CLASS(mmap_lock,
 
-	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
+	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
+		unsigned long ip),
 
-	TP_ARGS(mm, memcg_path, write),
+	TP_ARGS(mm, memcg_path, write, ip),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
 		__string(memcg_path, memcg_path)
 		__field(bool, write)
+		__field(void *, ip)
 	),
 
 	TP_fast_assign(
 		__entry->mm = mm;
 		__assign_str(memcg_path, memcg_path);
 		__entry->write = write;
+		__entry->ip = (void *)ip;
 	),
 
 	TP_printk(
-		"mm=%p memcg_path=%s write=%s",
+		"mm=%p memcg_path=%s write=%s ip=%pS",
 		__entry->mm,
 		__get_str(memcg_path),
-		__entry->write ? "true" : "false"
-   )
+		__entry->write ? "true" : "false",
+		__entry->ip
+	)
 );
 
 #define DEFINE_MMAP_LOCK_EVENT(name)                                    \
 	DEFINE_EVENT_FN(mmap_lock, name,                                \
 		TP_PROTO(struct mm_struct *mm, const char *memcg_path,  \
-			bool write),                                    \
-		TP_ARGS(mm, memcg_path, write),                         \
+			bool write, unsigned long ip),                  \
+		TP_ARGS(mm, memcg_path, write, ip),                     \
 		trace_mmap_lock_reg, trace_mmap_lock_unreg)
 
 DEFINE_MMAP_LOCK_EVENT(mmap_lock_start_locking);
@@ -52,14 +56,15 @@ DEFINE_MMAP_LOCK_EVENT(mmap_lock_released);
 TRACE_EVENT_FN(mmap_lock_acquire_returned,
 
 	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
-		bool success),
+		unsigned long ip, bool success),
 
-	TP_ARGS(mm, memcg_path, write, success),
+	TP_ARGS(mm, memcg_path, write, ip, success),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
 		__string(memcg_path, memcg_path)
 		__field(bool, write)
+		__field(void *, ip)
 		__field(bool, success)
 	),
 
@@ -67,14 +72,16 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
 		__entry->mm = mm;
 		__assign_str(memcg_path, memcg_path);
 		__entry->write = write;
+		__entry->ip = (void *)ip;
 		__entry->success = success;
 	),
 
 	TP_printk(
-		"mm=%p memcg_path=%s write=%s success=%s",
+		"mm=%p memcg_path=%s write=%s ip=%pS success=%s",
 		__entry->mm,
 		__get_str(memcg_path),
 		__entry->write ? "true" : "false",
+		__entry->ip,
 		__entry->success ? "true" : "false"
 	),
 
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 1854850b4b89..f1100eae6f2f 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -227,20 +227,20 @@ static const char *get_mm_memcg_path(struct mm_struct *mm)
 
 void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write)
 {
-	TRACE_MMAP_LOCK_EVENT(start_locking, mm, write);
+	TRACE_MMAP_LOCK_EVENT(start_locking, mm, write, _RET_IP_);
 }
 EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
 
 void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
 					   bool success)
 {
-	TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
+	TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, _RET_IP_, success);
 }
 EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
 
 void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
 {
-	TRACE_MMAP_LOCK_EVENT(released, mm, write);
+	TRACE_MMAP_LOCK_EVENT(released, mm, write, _RET_IP_);
 }
 EXPORT_SYMBOL(__mmap_lock_do_trace_released);
 #endif /* CONFIG_TRACING */
-- 
2.20.1

