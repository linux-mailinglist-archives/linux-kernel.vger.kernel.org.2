Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1534277DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 09:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhJIHO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 03:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhJIHOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 03:14:25 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ED9C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 00:12:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 75so5335999pga.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 00:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4GOHKQpdKjGYrmtCwrt0j30dBYvWtSv27SD0TMpOQc=;
        b=M9WKyzjFWGG/KvU30+aQ9WvUMAmBgCnSBUXf2NWfyO/Jfkd650wpjQbYYaExeQZzWv
         mth8bJuq6JvWPxVyD41doqYRASh9kcu5Y6eerBNPq4ulyS/XSwjT8H03qEzS5kfnRBZY
         nJ2tRbVnL5iuMVjt6/AACRz0CYZUMcI2y/tnhoeCBlZ3sr9fSzO1OjneeDcrUzgEush/
         jD67PxUEYSTC1vskVs+UtU/2nVjuyRNQsRXFtqoDYtrjWbiI1oBUO6iazJFHvv6OhB9r
         2D4D1HonX6zuoLPt4NZg+g+aJI77N6Vtf8bjppXq77qKz30/TkzHaKH94iLhGYhd7FYs
         tOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4GOHKQpdKjGYrmtCwrt0j30dBYvWtSv27SD0TMpOQc=;
        b=k/FvwxgCcKt9K0zLLo+O26IM1iRsGMEwW6xmwhv6BbaM1lTE/NnqvqtqQDAqMVo5sA
         0WnwN8xiiyZYwBJ+atB5IEfsRB9HdSe4DKKstcnos2mKvn4S96i9GIEReCgrrGyhF09y
         lw7uLRwzTBATQd+N/dUvdWOv4DWXuPd/ZCNGYe2Guh6z8DFPCUy8T3G8iu38tzK4e5NE
         H6ejk/hzIHAPZXh+YZ8U4Yy+OJFdG5aOdsefgs0nIZjN0pSHfF1xiFVU59hza6I1+7aw
         bSr5jAMCSTcWNEfmmjockP+qiRcx9eJuwX0JhODbRGHaLQl2nHOllTEHf2mUAvVLDYnz
         VnQw==
X-Gm-Message-State: AOAM533ZGCYlA9Ze1I9M7UB6/abAiWpJgrOSx61CitFaHooM191jg0+Q
        OjV4OcfkacLPX3CVGgFJjCRK9g==
X-Google-Smtp-Source: ABdhPJycZN9+KmNLZNVOF85ID4gSIzxcQCNc2S0qYIBgaSwvZd+Qy6e7Mt8jN0ynLvDW8HGMPB7YgQ==
X-Received: by 2002:a63:7402:: with SMTP id p2mr8364824pgc.472.1633763548294;
        Sat, 09 Oct 2021 00:12:28 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id p9sm1333860pfh.162.2021.10.09.00.12.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Oct 2021 00:12:27 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v2 1/2] mm: mmap_lock: remove redundant "\n" in TP_printk
Date:   Sat,  9 Oct 2021 15:11:05 +0800
Message-Id: <20211009071105.69544-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace core will add "\n" automatically on print. "\n" in TP_printk
will create blank line, so remove it.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/trace/events/mmap_lock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
index 0abff67b96f0..5f980c92e3e9 100644
--- a/include/trace/events/mmap_lock.h
+++ b/include/trace/events/mmap_lock.h
@@ -32,7 +32,7 @@ TRACE_EVENT_FN(mmap_lock_start_locking,
 	),
 
 	TP_printk(
-		"mm=%p memcg_path=%s write=%s\n",
+		"mm=%p memcg_path=%s write=%s",
 		__entry->mm,
 		__get_str(memcg_path),
 		__entry->write ? "true" : "false"
@@ -63,7 +63,7 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
 	),
 
 	TP_printk(
-		"mm=%p memcg_path=%s write=%s success=%s\n",
+		"mm=%p memcg_path=%s write=%s success=%s",
 		__entry->mm,
 		__get_str(memcg_path),
 		__entry->write ? "true" : "false",
@@ -92,7 +92,7 @@ TRACE_EVENT_FN(mmap_lock_released,
 	),
 
 	TP_printk(
-		"mm=%p memcg_path=%s write=%s\n",
+		"mm=%p memcg_path=%s write=%s",
 		__entry->mm,
 		__get_str(memcg_path),
 		__entry->write ? "true" : "false"
-- 
2.20.1

