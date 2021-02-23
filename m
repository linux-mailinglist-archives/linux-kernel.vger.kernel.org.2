Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317A9322E27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhBWP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhBWP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:58:48 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3C0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:58:06 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id e11so7421432wro.19
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CQEfesAGh6Yaxupcr8w3bDyhXlptt6J3Yf5vNzEZ7xI=;
        b=ahJMz/9QD//FktmI3FiYI5kZv2HmCwtxm6T0qpp83ZVG11ijWrwdYwZhWhlWBJ+CEk
         1jnG0OcblYWp0DVJ2dRRxnnLq+pq/xlYOWPblGlAnVTe4mmpgGKdY6ht57WvK4H62vTB
         CGC8mOl2P3AhVSh0z/+sXRUnjWeANK35861+rdXPjXd7vpwV2nV7e4gUfGh750HKKDJX
         r78EbvODYloUoicbFLZE55MmD1KVG5MrrSLwvm8nefA6P2EJdhqCH+x+jCmeDqeLQ68e
         oDb0F8nFaTaHd77uYGBKUBqhEv8gIzKcfslPSAY4HgpmgTHHKG5egD0k3uoCse1RY+Nw
         ZaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CQEfesAGh6Yaxupcr8w3bDyhXlptt6J3Yf5vNzEZ7xI=;
        b=GDAKro2zt7SE7yW4n1BBn63KzaEEx7peDb7YicQ8BOHqnALsTNZfPk2iX3CVzWF9we
         p9+KcnR/ebjRgCpBgkNou+DC2Ii+NOTNJGlWQhH59wK9Lcb7KWwqhh2bOEHKhvSLMlOk
         k05M7ypqJMi4SmixHyAvRNcOweQIv7RKdsO2G5mBj6AhC886XJxWhlO1bdz3KIaXvyGa
         yqy+fV1YffqJWcDhmezWZTPXja6coiarDNHQ9S7e20EWAhNnyko7vyhQXxjjaUU0mjdo
         8nEqc6W+xHXgSATGfgr0IXDx+Gw4gKlJKHb7lzg8vqItB6YZ/DTL1aUQ7sSFv7mecSPa
         YSIA==
X-Gm-Message-State: AOAM531B56TPWuDqbc+suM+FlOl+LaETnL4J1d2R+bUKGzyUB1lmBwt3
        H8qJps+uwu62ez/Ijl6r/2MHw+iA3Tg=
X-Google-Smtp-Source: ABdhPJx243HHOgDuZVZvZaJGT0iEdqLHawYC1nTIPMVKhxwcycsNTCwKSh8mZBNkhlNs39I7Nz8grf21hKw=
Sender: "ascull via sendgmr" <ascull@ascull.c.googlers.com>
X-Received: from ascull.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1510])
 (user=ascull job=sendgmr) by 2002:a1c:17:: with SMTP id 23mr216919wma.6.1614095885613;
 Tue, 23 Feb 2021 07:58:05 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:57:56 +0000
In-Reply-To: <20210223155759.3495252-1-ascull@google.com>
Message-Id: <20210223155759.3495252-2-ascull@google.com>
Mime-Version: 1.0
References: <20210223155759.3495252-1-ascull@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 1/4] bug: Remove redundant condition check in report_bug
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

report_bug() will return early if it cannot find a bug corresponding to
the provided address. The subsequent test for the bug will always be
true so remove it.

Signed-off-by: Andrew Scull <ascull@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
---
 lib/bug.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/lib/bug.c b/lib/bug.c
index 7103440c0ee1..4ab398a2de93 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -158,30 +158,27 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 
 	file = NULL;
 	line = 0;
-	warning = 0;
 
-	if (bug) {
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-		file = bug->file;
+	file = bug->file;
 #else
-		file = (const char *)bug + bug->file_disp;
+	file = (const char *)bug + bug->file_disp;
 #endif
-		line = bug->line;
+	line = bug->line;
 #endif
-		warning = (bug->flags & BUGFLAG_WARNING) != 0;
-		once = (bug->flags & BUGFLAG_ONCE) != 0;
-		done = (bug->flags & BUGFLAG_DONE) != 0;
-
-		if (warning && once) {
-			if (done)
-				return BUG_TRAP_TYPE_WARN;
-
-			/*
-			 * Since this is the only store, concurrency is not an issue.
-			 */
-			bug->flags |= BUGFLAG_DONE;
-		}
+	warning = (bug->flags & BUGFLAG_WARNING) != 0;
+	once = (bug->flags & BUGFLAG_ONCE) != 0;
+	done = (bug->flags & BUGFLAG_DONE) != 0;
+
+	if (warning && once) {
+		if (done)
+			return BUG_TRAP_TYPE_WARN;
+
+		/*
+		 * Since this is the only store, concurrency is not an issue.
+		 */
+		bug->flags |= BUGFLAG_DONE;
 	}
 
 	/*
-- 
2.30.0.617.g56c4b15f3c-goog

