Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3967731F59B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBSIEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBSIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:04:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A2AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:03:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id kr16so3253983pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MhXeuyvm8uTbmAfHrQDEaA0duTq/sCZgbklnifZ5wLY=;
        b=GFVxB4gPy6Btk4zFDDPDn5D3LXG90FLWsBVtQwCmbJaiYdKyZIKqm6DQsLao47vdF8
         1RpTVKi8igHur6XMuj7/FmWf2NygjffsaC6uDb9mXX0K7SHU/tARUkaKyyfcCQ1Eg4OC
         SCW1ZTgnyHZvqG90WZWkW0SAFKYSxAYzou8fY8wKeDYHoHL401TLk6laNtL/lTInUpkO
         nh8sW5ZEYzn8t+TGhV7RC43O4o8BSlsNH6wOiKZzrzDxfg2iIYiKvPBZVjkZEW0p1h38
         Rf/qY2EUsJQG2CAuLNHrFpMS2qQYX52VL08RNwfLJSAxjK8V++MhrzeCrImrEqXrSs2v
         kfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MhXeuyvm8uTbmAfHrQDEaA0duTq/sCZgbklnifZ5wLY=;
        b=EPLJ/O62/c+Zbs+4HzpkiEZhU20Oxit0msNBfKt6I0tdNrlWqZtlLmAS24dK0pgdtR
         1vE/zPu29Rz/IdAB45PPwmDcM1Z0M6PO8h4j6Ro/3+Y9uNqCTv8TYUoKj3EEapOyB+vb
         PBKXxC/ePW0gzlxhhTEuxahxr+4Rfb4zoVLeOI+AryI9XuZoBizGoBpQFNXC94jgxb5u
         byuJ0LYgttfqD0YEnSQORKxA4ul16Z9VhxKYGyEIVi5YIyziFY8NdvR7XWgmWndmOdaC
         dTB3347+bQXR07J51UM+MDG/0zjG2hS1zESGvV6M5o6RP4AsSZlnF+NFtfnqlqNB1DMA
         mhqw==
X-Gm-Message-State: AOAM531/1IpsytSKYbH1EeDBBwffdviXiGaQVnTx+Km6eTfKlYRWU9oT
        gP8eib381VF5ZPpismAp9RUclg==
X-Google-Smtp-Source: ABdhPJw18quszC4COmeXXlaCjmhhguhzV/g5qTt8aUT/kHc7o5Mc59BFbMwZB3w+sGIvN1gE2Ctn5w==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr8455843pjb.160.1613721799493;
        Fri, 19 Feb 2021 00:03:19 -0800 (PST)
Received: from localhost.localdomain ([122.173.196.104])
        by smtp.gmail.com with ESMTPSA id lj11sm7463845pjb.2.2021.02.19.00.03.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 00:03:18 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, peterz@infradead.org,
        stefan.saecherl@fau.de, qy15sije@cip.cs.fau.de,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] kernel: debug: Handle breakpoints in kernel .init.text section
Date:   Fri, 19 Feb 2021 13:31:34 +0530
Message-Id: <1613721694-16418-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently breakpoints in kernel .init.text section are not handled
correctly while allowing to remove them even after corresponding pages
have been freed.

In order to keep track of .init.text section breakpoints, add another
breakpoint state as BP_ACTIVE_INIT and don't try to free these
breakpoints once the system is in running state.

To be clear there is still a very small window between call to
free_initmem() and system_state = SYSTEM_RUNNING which can lead to
removal of freed .init.text section breakpoints but I think we can live
with that.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/linux/kgdb.h      |  3 ++-
 kernel/debug/debug_core.c | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 0d6cf64..57b8885 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -71,7 +71,8 @@ enum kgdb_bpstate {
 	BP_UNDEFINED = 0,
 	BP_REMOVED,
 	BP_SET,
-	BP_ACTIVE
+	BP_ACTIVE_INIT,
+	BP_ACTIVE,
 };
 
 struct kgdb_bkpt {
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index af6e8b4f..229dd11 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -324,7 +324,11 @@ int dbg_activate_sw_breakpoints(void)
 		}
 
 		kgdb_flush_swbreak_addr(kgdb_break[i].bpt_addr);
-		kgdb_break[i].state = BP_ACTIVE;
+		if (system_state >= SYSTEM_RUNNING ||
+		    !init_section_contains((void *)kgdb_break[i].bpt_addr, 0))
+			kgdb_break[i].state = BP_ACTIVE;
+		else
+			kgdb_break[i].state = BP_ACTIVE_INIT;
 	}
 	return ret;
 }
@@ -378,8 +382,13 @@ int dbg_deactivate_sw_breakpoints(void)
 	int i;
 
 	for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
-		if (kgdb_break[i].state != BP_ACTIVE)
+		if (kgdb_break[i].state < BP_ACTIVE_INIT)
+			continue;
+		if (system_state >= SYSTEM_RUNNING &&
+		    kgdb_break[i].state == BP_ACTIVE_INIT) {
+			kgdb_break[i].state = BP_UNDEFINED;
 			continue;
+		}
 		error = kgdb_arch_remove_breakpoint(&kgdb_break[i]);
 		if (error) {
 			pr_info("BP remove failed: %lx\n",
@@ -425,7 +434,7 @@ int kgdb_has_hit_break(unsigned long addr)
 	int i;
 
 	for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
-		if (kgdb_break[i].state == BP_ACTIVE &&
+		if (kgdb_break[i].state >= BP_ACTIVE_INIT &&
 		    kgdb_break[i].bpt_addr == addr)
 			return 1;
 	}
@@ -439,7 +448,7 @@ int dbg_remove_all_break(void)
 
 	/* Clear memory breakpoints. */
 	for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
-		if (kgdb_break[i].state != BP_ACTIVE)
+		if (kgdb_break[i].state < BP_ACTIVE_INIT)
 			goto setundefined;
 		error = kgdb_arch_remove_breakpoint(&kgdb_break[i]);
 		if (error)
-- 
2.7.4

