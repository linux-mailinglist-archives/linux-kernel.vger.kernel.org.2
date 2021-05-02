Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEEA37095E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 02:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhEBANW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 20:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEBANV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 20:13:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A6FC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 17:12:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so1280466pja.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pA+CSvSlEoAV5AJjMNbj7sGMYMDCGHCkwTCeh/EReyI=;
        b=GpFbckksZnaRZBa6iEDDPh/fq6Tb7a1HeA3D3xM7a6DPNW//KtY9xic6IxrDa9tGFX
         53NzAFArc6R0lYDRQM7UeCoE7ay59csHoO2JA7rSdlywE73hWo+Vz63+CjYo+z/mQSqr
         T3rdQ2dwepUHclWi5eUMTEvZRRQQlFTwWjZk6GMfBJiQLFBKR64q757wl5PSkULzHlTs
         /6N57r3y+COV7xaXonI1kNIqQT2zQUDHgvZljklgs26+M8s8MjjuLRCClFSAqb8b4f+7
         WcRk535AbM00Uwd8vswRvPj9/rzzoZIFkXbj6MMc2nT4XWr9PskwTBVyjCXb3Th9Il5O
         B76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pA+CSvSlEoAV5AJjMNbj7sGMYMDCGHCkwTCeh/EReyI=;
        b=sRLH9qpXQIx5KfcQcjOZoC2q5c+bHAA35d223tqVi3wXXTS/7U7U6rkVqPG39BHmMw
         UMOnewwaerq/MyXgBwo0KotMCEizyexyvfYGm1IfMMz/UbsPg/O57S9zYKf8h7fqonM1
         XmGzGvBG4bK83ciNCxvujJ81Wv1PdEnfdO+1ZTBpnuBATejLhDBb++5yWpieaaE2xhvk
         FSm3SZJbZY4FO5ngs6Ls5wU9ebxc20bvEDvggizB1C5RG/k+mleZrEgp7Y/xfAPmfmZE
         ilyEHqIIpFYkhCSO+Ck7H8PtVVqxNlKoKl0f2xvyfw9va+tbKfqAwz0NZ6JqRVpqGyCE
         yWBA==
X-Gm-Message-State: AOAM532MFrTJ+S2l6FL15tccaqwtUL5fk+sGsis+tTp7Af+vp7NWC2U+
        5ucrOLdLhaJ6hZ8L4RI91QU=
X-Google-Smtp-Source: ABdhPJyGcR3aFpT7atP3gruC1V8HdaR2EQ/b6E44dAxe9agpzVtwE+ELrtd8g6kaa6By2Ua9bDRjsw==
X-Received: by 2002:a17:90a:c3:: with SMTP id v3mr23555028pjd.55.1619914349625;
        Sat, 01 May 2021 17:12:29 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id n25sm5314443pff.154.2021.05.01.17.12.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 May 2021 17:12:29 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] trace: replace WB_REASON_FOREIGN_FLUSH with a string
Date:   Sun,  2 May 2021 08:12:27 +0800
Message-Id: <1619914347-21904-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Now WB_REASON_FOREIGN_FLUSH is displayed as a number, maybe a
string is better.

v2: replace some space with tab.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/trace/events/writeback.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1efa463..7c78c04 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -36,7 +36,8 @@
 	EM( WB_REASON_PERIODIC,			"periodic")		\
 	EM( WB_REASON_LAPTOP_TIMER,		"laptop_timer")		\
 	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
-	EMe(WB_REASON_FORKER_THREAD,		"forker_thread")
+	EM( WB_REASON_FORKER_THREAD,		"forker_thread")	\
+	EMe(WB_REASON_FOREIGN_FLUSH,		"foreign_flush")
 
 WB_WORK_REASON
 
-- 
1.8.3.1

