Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAAA45E025
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhKYSEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhKYSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:02:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F079BC0613DD
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:52:57 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r11so28687108edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhRx6ewN7MwnNiVVmf6uS+ga/E3172l7ca+KEv51r0c=;
        b=BCrwNBWX2FqlFZ/HqcbboLrOckzmhu4WnBtQhvxhmFMS6O7/PT3OW9hJP4v2z7i87A
         7bzLj0CHMltUs+9uegOnDWtM9AootYrqxmL/fRuUzhp09RKGaWcZbU+bTIQJTXmPc7Mn
         FD5ZqLv90OZhm8GKa3E9SgXW+Q32ORhJPYeyGfeRxOifpyJ22Vuq0Ni6o2v/DiU79Ope
         imqzhz6cvjrplmzhn66tZbxH/TFgd4cRcbTnotSjNkZe5ihX7vRbMwJoBbKcpP9hq2BS
         CcpMiUsOHFOIWDSt5tmHTg9YP4lGHb4+VWWOyjvxW3Ode2467dXaZrZxcmXGgcSAPjXi
         Q79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhRx6ewN7MwnNiVVmf6uS+ga/E3172l7ca+KEv51r0c=;
        b=e0U7aA6eWbrfJbaEobpwKOwP5t3NvVPRY1SykOVJDpved3k8E29aa1rxg84kemjXTd
         KAxVWTEH1BcscZ7a6be0gmoEgKDAqVFf0BNXxu/5JYEbll23jR2rlWx73Q9bmaojDGi1
         dPR208A/38FZ4c5adNE0l89U/V5oLx+D319vkUUX+d894W+WCuS5NXnVfD/XJyIus0fM
         IlG1hsNXwR96yFJOEHTcL5btTFI98/7GgJ5b7pHZOI+vV80X//CTFDne9/arAh3fvcyM
         kzqN1q7xOw5KZcqkAHpqCeegprq7MjUKHpkI9CUVcxJFQc96wEcKIxvVsDi6LAGTn2O5
         bueA==
X-Gm-Message-State: AOAM532aX5v9l7ZeJOdlg0PCkrIroEKrN52cevpDzl3jJUhhVL0jVSrq
        7WUrLW6l6iJYgQwN1/bKkYWphNX0YORqbQ==
X-Google-Smtp-Source: ABdhPJxgHKgiW5PAUd7u+vSI+JrN16xc4964UfJvRyWybuzI3+1RHoFXDp+E/iyuTVcxhYCYzMvpvg==
X-Received: by 2002:a17:906:4fcc:: with SMTP id i12mr33236405ejw.309.1637862776557;
        Thu, 25 Nov 2021 09:52:56 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id hs20sm1949795ejc.26.2021.11.25.09.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 09:52:55 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] [RFC] tracing: Refactor ring buffer implementation
Date:   Thu, 25 Nov 2021 19:52:49 +0200
Message-Id: <20211125175253.186422-2-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211125175253.186422-1-tz.stoyanov@gmail.com>
References: <20211125175253.186422-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to introduce sub-buffer size per ring buffer, some internal
refactoring is needed. As ring_buffer_print_page_header() will depend on
the trace_buffer structure, it is moved after the structure definition.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 kernel/trace/ring_buffer.c | 59 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2699e9e562b1..cc34dbfdd29b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -371,35 +371,6 @@ static inline int test_time_stamp(u64 delta)
 /* Max payload is BUF_PAGE_SIZE - header (8bytes) */
 #define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
 
-int ring_buffer_print_page_header(struct trace_seq *s)
-{
-	struct buffer_data_page field;
-
-	trace_seq_printf(s, "\tfield: u64 timestamp;\t"
-			 "offset:0;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)sizeof(field.time_stamp),
-			 (unsigned int)is_signed_type(u64));
-
-	trace_seq_printf(s, "\tfield: local_t commit;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), commit),
-			 (unsigned int)sizeof(field.commit),
-			 (unsigned int)is_signed_type(long));
-
-	trace_seq_printf(s, "\tfield: int overwrite;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), commit),
-			 1,
-			 (unsigned int)is_signed_type(long));
-
-	trace_seq_printf(s, "\tfield: char data;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)BUF_PAGE_SIZE,
-			 (unsigned int)is_signed_type(char));
-
-	return !trace_seq_has_overflowed(s);
-}
 
 struct rb_irq_work {
 	struct irq_work			work;
@@ -559,6 +530,36 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
+int ring_buffer_print_page_header(struct trace_seq *s)
+{
+	struct buffer_data_page field;
+
+	trace_seq_printf(s, "\tfield: u64 timestamp;\t"
+			 "offset:0;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)sizeof(field.time_stamp),
+			 (unsigned int)is_signed_type(u64));
+
+	trace_seq_printf(s, "\tfield: local_t commit;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), commit),
+			 (unsigned int)sizeof(field.commit),
+			 (unsigned int)is_signed_type(long));
+
+	trace_seq_printf(s, "\tfield: int overwrite;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), commit),
+			 1,
+			 (unsigned int)is_signed_type(long));
+
+	trace_seq_printf(s, "\tfield: char data;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), data),
+			 (unsigned int)BUF_PAGE_SIZE,
+			 (unsigned int)is_signed_type(char));
+
+	return !trace_seq_has_overflowed(s);
+}
+
 #ifdef RB_TIME_32
 
 /*
-- 
2.31.1

