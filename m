Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E496315BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhBJBBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbhBIWRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:17:54 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144DC0698CF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:15:00 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z9so80565plg.19
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=t77+PuCigeZOcF53sLtwu0Du9UKFrCGhrRKsmy3L6C4=;
        b=d9ikACbu6qy1ulW0wSWsHA6FQSQ6KWZ9q7y0tI23lcp6zqywGVCwUy0PyUQBPNGOUn
         CTStJYZAFnTmq0LaDsVYpUnGVtQBXFm5fYzBp+Ut7OGHBhjKhMbr6GWtlCpwWV4HNDMZ
         CR7vd1Cf8gvgh1gnBNj2M+QG3tWnuECEnY+5dEp6r8T5piVNqLYdVC1pt7wJV0wV0BKM
         8eFD2qcB347FBqOweh8LWCkLU3OJ3nR+Z5mn/eK3G/ay5NAQd91a9nd9i1AChe2Dw7mM
         deGqu0MMXhbfdQHAeGmRbbhz2AZnODTeVU6uikVsKvI29/KwDXZJjH3Yg5IyCmZcAkLk
         kcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t77+PuCigeZOcF53sLtwu0Du9UKFrCGhrRKsmy3L6C4=;
        b=METmYV+BvCvSJdAXU8jdtHAJ1dIJb1txLXiRbrns22Y9NILtZKGLmFSBxAo1KRGmbc
         4NXTdOTyA8zpNsP6Tr2h69+A+O8CIaJDR4OEDAu1/bvvX9CUvsHiiqXu4ObXqFTEtNBG
         XngCcmg6HQpLcdinQE/y0asL+DxdhC+/Ps8ZRhVoD5ebV+AEIn+XOZHZBb2nI22kYeVf
         ItjKQ8oaGLt4ZygrfulwwzDqekWeFEt3/DLQsaB85AYO4mXMICds1xwNlUcxcgXQK1ea
         cicu5YimVY+Dj5wnh6ZUG1hLDhqPLjgNJrMUAi6YjlNZBnu8ZLm03TtJZI4fwNLOzd5p
         zdJw==
X-Gm-Message-State: AOAM5335n8KsFtzI0j9ZxtBtSKKKfqbcEH8nmDfMafsowIv3exn333fs
        4U14ai9G3rKwTXBz4Y+xlgI187qsfbK/4g==
X-Google-Smtp-Source: ABdhPJz6rbJFwUFn+s86ByXOsu1A/32Yea+7KK7JKMRSyX1h8XuZLwh6YV1us28bzRRXCk6ELNJKSF0ZkhSgOg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7dd9:967f:92f4:2aae])
 (user=dlatypov job=sendgmr) by 2002:a63:4084:: with SMTP id
 n126mr124475pga.80.1612908900146; Tue, 09 Feb 2021 14:15:00 -0800 (PST)
Date:   Tue,  9 Feb 2021 14:14:43 -0800
In-Reply-To: <20210209221443.78812-1-dlatypov@google.com>
Message-Id: <20210209221443.78812-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210209221443.78812-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v3 2/2] kunit: ubsan integration
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, alan.maguire@oracle.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Uriel Guajardo <urielguajardo@google.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
whenever it reports undefined behavior.

When CONFIG_KUNIT=n, nothing is printed or even formatted, so this has
no behavioral impact outside of tests.

kunit_fail_current_test() effectively does a pr_err() as well, so
there's some slight duplication, but it also ensures an error is
recorded in the debugfs entry for the running KUnit test.

Print a shorter version of the message to make it less spammy.

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/ubsan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index bec38c64d6a6..1ec7d6f1fe63 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <kunit/test-bug.h>
 
 #include "ubsan.h"
 
@@ -141,6 +142,8 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
 		"========================================\n");
 	pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
 		loc->line & LINE_MASK, loc->column & COLUMN_MASK);
+
+	kunit_fail_current_test("%s in %s", reason, loc->file_name);
 }
 
 static void ubsan_epilogue(void)
-- 
2.30.0.478.g8a0d178c01-goog

