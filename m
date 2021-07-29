Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7CD3DA035
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhG2J2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhG2J2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:28:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F6C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:28:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso14702353pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4GOHKQpdKjGYrmtCwrt0j30dBYvWtSv27SD0TMpOQc=;
        b=M9b1CHbcfKuYfUzMvS99VE+HJOwJSEZfyj4HmPCIQfRvIVGmDzhSDur1LaX7VZbQrR
         fsab0SaHTgacp94jmQLOXP4Jq6P724cTewVUG9z9yOG0YOD2fvzAhGahzzDzuuRs5r33
         uO3vTBY1YCmOzzub3wS9EASHqi7d2vsivWimIT5P9H/FyoHq6B1Tz5mzGOSG4va/hNb4
         JL5UmloxsxxyeqGButFc7XnBtTybP77iCV0lLzlUEYRftva0W8VA398RQIZZS6L8RrCs
         gbdxZeSECZcJtqfnybiv+qRgvjcoZxqIqMMqlLM4Id1Y5L3knDywb+/f3TuRsKlo/AVx
         byaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4GOHKQpdKjGYrmtCwrt0j30dBYvWtSv27SD0TMpOQc=;
        b=owdn18B0Ab95d+X7zewmzYXxdfKyjcQ8lidenxdNrSXkXKch/QKxALlp1LVDokjyjL
         UEkI4Cr5MaO2onF8aaxDJUjWi3RnRhI4q16PGPGGGugHQp5Z5EnnC0lo6rwLHO4jvVeu
         +cl8qNgBpLaAX5lO++EI1I8POw/eGilgzqw5JG9S8JTS55LEcHXntR63ETbI+3l43iRI
         Dy5EGy83bKitFvfmbj3j8UFnP38VVLvjzhKpNLud9gHBDPj/+KPZP54+WRkrsGWK66eD
         O8vwgirox80OmLD3978HuNBEV3MoIs9GlGxIni8rbtyYZxS8b7BaP1DEQj37ZbZ4wzke
         +laA==
X-Gm-Message-State: AOAM530T1atxszEKXQqdTwUVLJkFtBC0H5VfKR2fZVgjJKpMaLFeeYci
        U6ZjzOMDBVR1glGo1NPAmp1nbA==
X-Google-Smtp-Source: ABdhPJyV6MpMhTw91msNDXtPlU6wwKyLC0ErjC+OcmL0d3FpkqINMErlEU4sEm7dAb0TEgMZv9Ok1A==
X-Received: by 2002:a17:90b:688:: with SMTP id m8mr13966199pjz.45.1627550917801;
        Thu, 29 Jul 2021 02:28:37 -0700 (PDT)
Received: from C02FT5A6MD6R.tiktokd.org ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id y28sm2906325pff.137.2021.07.29.02.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jul 2021 02:28:37 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH 1/3] mm: mmap_lock: remove redundant "\n" in TP_printk
Date:   Thu, 29 Jul 2021 17:28:31 +0800
Message-Id: <20210729092831.38106-1-ligang.bdlg@bytedance.com>
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

