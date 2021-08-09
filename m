Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A783E44C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhHIL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbhHIL0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:26:15 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAB6C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:25:54 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id q188-20020a1ca7c50000b0290241f054d92aso3922600wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P7GOzPu0NcYglTRl+yIv+BtZNtyGAI762LUyqxvjzUo=;
        b=cVbOSaptMmSyxu80pyqsQzQnm0N4FaFPkxI88y48DPMmbO2xmho4LsoJmaWhpm7yzd
         zeEgLXcIYIFtO22mgi4gHUK+6RINb/cbQllMdJGLQOdTdL5j2vttzyUMTxuEIorNrN5m
         qHfYNKOhlJSBP1CIgFXE3L4TlRv+f5VvWz+poz9jHHoMs3yjUWgQAcYqywfdQqp0E8jD
         iM+ob4chmgCnSXjY5neJN1JHCHqMEW+0oTDE4SInxJv9gdQ04JsWLPYam24yiewjj3F6
         YMguaDEJd6gOaUfYwfCTVDFtOCBtTeSJT93Sd9PqJUsXMvZckrrJYoh2VG6CevfJMdZz
         ExMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P7GOzPu0NcYglTRl+yIv+BtZNtyGAI762LUyqxvjzUo=;
        b=IlJkPd1eX/vS2NjcAY7/mbo+lUbK++roVr1qbxdierVbN+KMxDG6SqmshV2H1sb+bK
         9dc6FGGf97xMSQn4IEA8K3FvpTVPDgGJOebgXfez/Vu7e9FDfhjTXkw/FDR0T9aViJhW
         0awsV/H7o6sf/IY3Rhs3GPcWpZyLZXjzq51+iMTblvJSYU9OXyqYvMPVo5Srq3II74rM
         Nsy8leI1euGxAehzOHpYAFlw5jv0e1NFmrxY/kOXTLVA9zyAWafMWTQizxlhvljQfHsB
         dqrPeoGihJRX7y1gr+m4kWdjhyDWG2x3cS2UhB5sa9S8VDHY8iuqsKPMhllVpKljt0di
         43oQ==
X-Gm-Message-State: AOAM531H4fRFXIRoeKt9Slz6jFbd+a3u8HD70VudrlOppAS43pLwYbNq
        QYuEWlL0R9Tw1mrPhl5JNyQeXHdAhQ==
X-Google-Smtp-Source: ABdhPJwngY7E4jxfScgUibZ4nmoCGnsqnZlCU7clumKrhFNY7VNph9+5/4nifY+CVuUkqadrh9D3gZSBuA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e5a3:e652:2b8b:ef12])
 (user=elver job=sendgmr) by 2002:a7b:c106:: with SMTP id w6mr3129102wmi.152.1628508352701;
 Mon, 09 Aug 2021 04:25:52 -0700 (PDT)
Date:   Mon,  9 Aug 2021 13:25:15 +0200
In-Reply-To: <20210809112516.682816-1-elver@google.com>
Message-Id: <20210809112516.682816-8-elver@google.com>
Mime-Version: 1.0
References: <20210809112516.682816-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 7/8] kcsan: Support reporting scoped read-write access type
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support generating the string representation of scoped read-write
accesses for completeness. They will become required in planned changes.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 8 +++++---
 kernel/kcsan/report.c     | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index a3b12429e1d3..660729238588 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -210,10 +210,12 @@ static bool report_matches(const struct expect_report *r)
 							"read-write" :
 							"write") :
 					       "read");
+		const bool is_atomic = (ty & KCSAN_ACCESS_ATOMIC);
+		const bool is_scoped = (ty & KCSAN_ACCESS_SCOPED);
 		const char *const access_type_aux =
-			(ty & KCSAN_ACCESS_ATOMIC) ?
-				      " (marked)" :
-				      ((ty & KCSAN_ACCESS_SCOPED) ? " (scoped)" : "");
+				(is_atomic && is_scoped)	? " (marked, scoped)"
+				: (is_atomic			? " (marked)"
+				   : (is_scoped			? " (scoped)" : ""));
 
 		if (i == 1) {
 			/* Access 2 */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 4849cde9db9b..fc15077991c4 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -247,6 +247,10 @@ static const char *get_access_type(int type)
 		return "write (scoped)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
 		return "write (marked, scoped)";
+	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE:
+		return "read-write (scoped)";
+	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
+		return "read-write (marked, scoped)";
 	default:
 		BUG();
 	}
-- 
2.32.0.605.g8dce9f2422-goog

