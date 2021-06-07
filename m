Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB5739DD28
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFGNAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:00:15 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:46735 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhFGNAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:00:12 -0400
Received: by mail-qk1-f201.google.com with SMTP id 205-20020a3707d60000b02903aa9208caa2so3432760qkh.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/aaoSey+XaULg1MGdgAn1yub4BLSR83Q711t6YMKbyU=;
        b=B5Q6qv/j239qQSq6QJOHU/OxhznMCBm9n11rUWkTiUGjoQULfGq5emaVxGXHLCg9gd
         gXCvku07ga/IYzdieyxbL3Zblq8Y66DXyyUYe9zI5VeINeqftPT/D4TjjNMsQ6xQh96J
         BQ1WkBYwn/55v4cWCmq094UlcISISd1RAsxZnkHmWSEogjGMEHZ/ic0SPBSE3wkrIrFI
         L39xw3URqXUW1TmnXhM80Wxk+q2boXxAsytGtIpQgDol/Bgxi77rnWLFMonUGsV/DUMs
         RfTSrUjbeghSwrwTXVQ3sfEOqlP4aS2qf94oJ29xRRZ85LYQGUpf9BEXd053N/jOKxHj
         JbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/aaoSey+XaULg1MGdgAn1yub4BLSR83Q711t6YMKbyU=;
        b=VgepGkPtsyyEsF1C9hNsxTNMQhqeUdjR6jQjhTmDEHquc3a46ILS8zm15/qy3thMBT
         1GVelmpA0ElNoutXr/GrDJ45fxYKjblVca0eeuw1m6obf7VB6KQAhDqnsCsZHzi3hNv5
         qnU4XVSvMqqeYyM0Ad8sSdmLzeamr3PNsIZrPM/0/Xdguymz6OaQiP1OXsla2Kk4BmeT
         RZRaDNGNSzfn9mJVipixpujtwL+MwZ0TAYlHk2Hk9Nnb5O6L2zpeXfbXhoBzFdGrte3u
         H/S0NtFLToDLfmL0flotEyuXr8zlbtM6wsDBKcft7ueV7FuVrR8TvaoL4hfERUwdULbh
         d7qw==
X-Gm-Message-State: AOAM532XUBA4JOwRs9kwbce6mUGBJ37UubPVKzEEIszOydsW+THJSgGQ
        E5vp2/YerGYFqaZRvciC1X4MvMXXnw==
X-Google-Smtp-Source: ABdhPJzUWTXUX+DHChUEZmw+b4TzmHxrK8Ry7wK76pnR64uuGksVdPl4HkAK24lnvjlo1mBbe8I7BdwxKA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:2587:50:741c:6fde])
 (user=elver job=sendgmr) by 2002:ad4:4e89:: with SMTP id dy9mr13977400qvb.40.1623070629649;
 Mon, 07 Jun 2021 05:57:09 -0700 (PDT)
Date:   Mon,  7 Jun 2021 14:56:48 +0200
In-Reply-To: <20210607125653.1388091-1-elver@google.com>
Message-Id: <20210607125653.1388091-3-elver@google.com>
Mime-Version: 1.0
References: <20210607125653.1388091-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 2/7] kcsan: Remove CONFIG_KCSAN_DEBUG
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, will@kernel.org,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By this point CONFIG_KCSAN_DEBUG is pretty useless, as the system just
isn't usable with it due to spamming console (I imagine a randconfig
test robot will run into this sooner or later). Remove it.

Back in 2019 I used it occasionally to record traces of watchpoints and
verify the encoding is correct, but these days we have proper tests. If
something similar is needed in future, just add it back ad-hoc.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 9 ---------
 lib/Kconfig.kcsan   | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 26709ea65c71..d92977ede7e1 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -479,15 +479,6 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		break; /* ignore; we do not diff the values */
 	}
 
-	if (IS_ENABLED(CONFIG_KCSAN_DEBUG)) {
-		kcsan_disable_current();
-		pr_err("watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
-		       is_write ? "write" : "read", size, ptr,
-		       watchpoint_slot((unsigned long)ptr),
-		       encode_watchpoint((unsigned long)ptr, size, is_write));
-		kcsan_enable_current();
-	}
-
 	/*
 	 * Delay this thread, to increase probability of observing a racy
 	 * conflicting access.
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 6152fbd5cbb4..5304f211f81f 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -62,9 +62,6 @@ config KCSAN_VERBOSE
 	  generated from any one of them, system stability may suffer due to
 	  deadlocks or recursion.  If in doubt, say N.
 
-config KCSAN_DEBUG
-	bool "Debugging of KCSAN internals"
-
 config KCSAN_SELFTEST
 	bool "Perform short selftests on boot"
 	default y
-- 
2.32.0.rc1.229.g3e70b5a671-goog

