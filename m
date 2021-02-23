Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F936322E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhBWP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhBWP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:58:55 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46CC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:58:09 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id b201so1360579wmb.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6MyHeS31EL7bb0VItKWbX1lwx1Ls4GM48RMPtv0hqg4=;
        b=sHwtQ4UiQgGx7PNngBOxhHH0QJvSlwMJAiVMluP2MC/J9jQqXygpnJgWGeWeWK7mhh
         DPlqCq2RV+vZ6YFXQDv8WIymY0p2uwiS67hLx+Wiy5T78lsZZLGNvHFNKx0N/aUzW8hY
         1XItvuBNhoFciEiklvIDniZc2Z4mxn1IxY9cXewGZ92PcNss8ZIe3kBzREkDt+PWHco2
         h/tpjbVMefbbOgfdnXL76/m0V7qngItsVjELey+wNZ+08VU2O16QDwWvByAmHIoIG1QI
         HNMxN/AzvSrbNIw+LHRGjAExCnQ/zXtLqKZcRgB6HlIV7L+TREQ/Gh4ERCmbfrwjj+2a
         Tpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6MyHeS31EL7bb0VItKWbX1lwx1Ls4GM48RMPtv0hqg4=;
        b=qZAUQJUDq/SduVAinhDr+YRv19qEyy58+J3DcvE/zbLF0Wo2cLGyW8KSuq2OUT9fwN
         r44YLt7BZ0ZQmRxyUfodbnzA6oeSH9rR56LKdP2zAto4GWXNEAGggcntDu9dee3uCZ9h
         3BU0HbMEwqDzjaI5RuwQKgrcCuG4O1fy8ie45xGkjxwY1/8p6mWDrMX13iHqUT/bYNKY
         fYt0o6Ks2fPwed0CsVdIjMF5la/4O0HtpMQnQPwAaQegOGeefPCH4BmscymzKSKc6Ynb
         Pw7bV0e7RqaxJvdYoUvK8DaF2BgFgnHHBkmRYDjoh2lJs6aKXdWRRiKZsTW2Kc3KT5y/
         Mqrg==
X-Gm-Message-State: AOAM5325r61DZxKqMJiTiWQg3wpY0nn8Xsfy+lUExtV3iDUp4EpLQgqz
        7+PuV3Jd6zAQHAtQF8rjC4+YHUZ8V74=
X-Google-Smtp-Source: ABdhPJyi1NEYRySQoJ9bCKgZ87lgzwQsxEV6eju9zsWcd4dPWKkzJgwL2iSidbgzKw+k31pCnQRJ/zgWfME=
Sender: "ascull via sendgmr" <ascull@ascull.c.googlers.com>
X-Received: from ascull.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1510])
 (user=ascull job=sendgmr) by 2002:a1c:2e90:: with SMTP id u138mr30106wmu.0.1614095887853;
 Tue, 23 Feb 2021 07:58:07 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:57:57 +0000
In-Reply-To: <20210223155759.3495252-1-ascull@google.com>
Message-Id: <20210223155759.3495252-3-ascull@google.com>
Mime-Version: 1.0
References: <20210223155759.3495252-1-ascull@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 2/4] bug: Factor out a getter for a bug's file line
From:   Andrew Scull <ascull@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com,
        will@kernel.org, catalin.marinas@arm.com, kernel-team@android.com,
        Andrew Scull <ascull@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some non-trivial config-based logic to get the file name and
line number associated with a bug. Factor this out to a getter that can
be resused.

Signed-off-by: Andrew Scull <ascull@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
---
 include/linux/bug.h |  3 +++
 lib/bug.c           | 27 +++++++++++++++++----------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index f639bd0122f3..e3841bee4c8d 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -36,6 +36,9 @@ static inline int is_warning_bug(const struct bug_entry *bug)
 	return bug->flags & BUGFLAG_WARNING;
 }
 
+void bug_get_file_line(struct bug_entry *bug, const char **file,
+		       unsigned int *line);
+
 struct bug_entry *find_bug(unsigned long bugaddr);
 
 enum bug_trap_type report_bug(unsigned long bug_addr, struct pt_regs *regs);
diff --git a/lib/bug.c b/lib/bug.c
index 4ab398a2de93..f936615176b8 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -130,6 +130,22 @@ static inline struct bug_entry *module_find_bug(unsigned long bugaddr)
 }
 #endif
 
+void bug_get_file_line(struct bug_entry *bug, const char **file,
+		       unsigned int *line)
+{
+	*file = NULL;
+	*line = 0;
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+	*file = bug->file;
+#else
+	*file = (const char *)bug + bug->file_disp;
+#endif
+	*line = bug->line;
+#endif
+}
+
 struct bug_entry *find_bug(unsigned long bugaddr)
 {
 	struct bug_entry *bug;
@@ -156,17 +172,8 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 
 	disable_trace_on_warning();
 
-	file = NULL;
-	line = 0;
+	bug_get_file_line(bug, &file, &line);
 
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-	file = bug->file;
-#else
-	file = (const char *)bug + bug->file_disp;
-#endif
-	line = bug->line;
-#endif
 	warning = (bug->flags & BUGFLAG_WARNING) != 0;
 	once = (bug->flags & BUGFLAG_ONCE) != 0;
 	done = (bug->flags & BUGFLAG_DONE) != 0;
-- 
2.30.0.617.g56c4b15f3c-goog

