Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA034277DC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhJIHOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 03:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhJIHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 03:14:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B954C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 00:12:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m14so10025689pfc.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Dz0AEQUS+5tnE4rP5Lhm0LEEfQ/t1p73p5EaBt6hmA=;
        b=RYKB4GOVWyquCSCVAJ61Tqp+lLP2okB3soIG8RUco+Jy0LwjYcYT1/hZcTMdM/wSDA
         Q644gB3MLaLus/4RAgNMC9rhDmfaA8FIROqCnaFf58Qp60wmddk+7njkaWxgKJKyawli
         qXg73FO/kUmOCYeiDfbLSH16Zz2nIQFmGZT6lrmxoqa0Qe4Qjbeb8MT3q3jWR4cj3CQD
         pyRrF7aIOHRIFczLPDXf04iXQLZ1nKYNv1/MbLR0i8ty0yNXGE7HwP/7My9YcR1JI63c
         KfNtjTV1DSbhVadHjgOAPGCXQx9i4I0smFFEB+sjiJLo18TqEIXYwFXUtuxH+G4dDPH8
         mh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Dz0AEQUS+5tnE4rP5Lhm0LEEfQ/t1p73p5EaBt6hmA=;
        b=yPw0LW+BRPElQx6Alju1uriPKZJt1sE1RuP9NGyvtvR+x/6KN2qH+1A7hMrTM+BjGm
         /L5uHNaONfvWttfFdRHp4qVv4hcqVar4S47Na6yuA4lo3fnJO9/EzHG62hjYlJlipVUV
         5Oelw+ybTH1P0tRp9KT3JcHZYGcyIHn8jgQGOHnjJJSymLK0GvOtT268iA4o0pOGaUi4
         NyutaIumqdSIYu/OjX9vxWKx+BIujBu+shZ64nwVUWhHEKB5DVsEubflhCONMpaF3icw
         XNh1duXP5vwNjCTYKo2aUkbRY++i+lozgf46vG07xq0Y/SL//WOGq+3F7G95wBAIXuw1
         /lQg==
X-Gm-Message-State: AOAM532C3qsI0z0iv7afBGt50PJeGHU5ef1PHoYEomU4nqEjwERv3Dzl
        Qv81CIJPxOkGnNrJ7e5Wpfw2Kw==
X-Google-Smtp-Source: ABdhPJwUR/+lBFkiA9E2Il0TycxTql4SR/5+2hjmhVIF/mbw+367GIWh8fh5HNofQqXzVuU8UlK9ZQ==
X-Received: by 2002:a05:6a00:1512:b0:447:cb0b:8520 with SMTP id q18-20020a056a00151200b00447cb0b8520mr14085973pfu.54.1633763570627;
        Sat, 09 Oct 2021 00:12:50 -0700 (PDT)
Received: from C02FT5A6MD6R.tiktokd.org ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id k14sm1497567pgg.92.2021.10.09.00.12.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Oct 2021 00:12:50 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v2 2/2] mm: mmap_lock: use DECLARE_EVENT_CLASS and DEFINE_EVENT_FN
Date:   Sat,  9 Oct 2021 15:12:43 +0800
Message-Id: <20211009071243.70286-1-ligang.bdlg@bytedance.com>
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
index 5f980c92e3e9..14db8044c1ff 100644
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

