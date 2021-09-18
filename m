Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8641075D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbhIRPdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhIRPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 11:33:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E828C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 08:31:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c190-20020a1c9ac7000000b0030b459ea869so3415171wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBn5D96qNN+hLtTEkGlNEQDeJfDTTnYBIFICklr8IFI=;
        b=QfOqCugsIQAaQ4X/SlBSg3wb123AKQtDHXZAgzI3490QmOswk3s1c68KKdR9i2fA3I
         JWphRzTum6y+P2z3WOPqV8oy1f9JuTY+gasmjT4hsREYjkTYyJnQr8bhtr7LovWI8SGQ
         E4wInJp/OruXsgnCrQOJ1Iqc8xZpE2gWso4rYIYmdyQcVd8AbQeQLHJBbnDJnEXHfXHv
         mcwmjBu2XABZXDqgr3fw7YEt3ndVI5w586mWt+z57gmF2J4y7NDRrOCVOGE5LcAVbsXo
         0ZaNadCK98XqwopMMIa6RkAcFwJNKa3TIf7I140SGhyHQa0GHcj7sSnfn/5oIQ49D65Z
         NIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBn5D96qNN+hLtTEkGlNEQDeJfDTTnYBIFICklr8IFI=;
        b=Y8QbSY6B3w7/24NvJWMNcjv/qYVkhU4ZftwVMZ7IH8PTqTObg9fvO8ovIATFgDF+Al
         MaczWJtAekKspqvZ6H7yCMcXvuOlHjW2L9tZXlKVheb7JLMjYBhvEd3CfOCon1TVEwf5
         6izUYvMEyPrd42g6o82o8S447sHeVz9ZFp7wU1qn0q4CVfN1WSR3h86DBWMmRpR7Yc3e
         uG9kLvlD7wJSxHMLPOJAoOgIWgdeCpu10xE90rpGmm1LcS9D7FYFtRymqxXbDYJ+u6nw
         yWKmvp5LljrKYdKXi5ObBOBkdSpApGyJuzGZwaUUmhYYFhDAs1BQmXOUXZ9HAvaiTDup
         /dnw==
X-Gm-Message-State: AOAM531Og6UTRQqUXfXAiPOdszotIgyKiksRYv83frF/wbU2uFTlcbxn
        6N2XYCcIsugzAu34iNHZnGJDW1tBSEe2ow==
X-Google-Smtp-Source: ABdhPJw3Sn3PPRew1mCLW7VCFp9ps/M1wg8lss1iwxz18Bkv0cVxJQvVlHlFv950iyvSv+yspgx63g==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr15613545wmb.139.1631979104037;
        Sat, 18 Sep 2021 08:31:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:8f8:1127:62fc:cf28:f9:da98:9620])
        by smtp.gmail.com with ESMTPSA id q201sm15548999wme.2.2021.09.18.08.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 08:31:43 -0700 (PDT)
From:   Carles Pey <carles.pey@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Carles Pey <carles.pey@gmail.com>
Subject: [PATCH v2 1/1] ftrace: add unit test for removing trace function
Date:   Sat, 18 Sep 2021 19:30:43 +0400
Message-Id: <20210918153043.318016-2-carles.pey@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210918153043.318016-1-carles.pey@gmail.com>
References: <20210918153043.318016-1-carles.pey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A self test is provided for the trace function removal functionality.

Signed-off-by: Carles Pey <carles.pey@gmail.com>
---
 kernel/trace/trace_selftest.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index adf7ef194005..875b4f1a0476 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -287,6 +287,40 @@ static int trace_selftest_ops(struct trace_array *tr, int cnt)
 	if (trace_selftest_test_probe3_cnt != 4)
 		goto out_free;
 
+	/* Remove trace function from probe 3 */
+	func1_name = "!" __stringify(DYN_FTRACE_TEST_NAME);
+	len1 = strlen(func1_name);
+
+	ftrace_set_filter(&test_probe3, func1_name, len1, 0);
+
+	DYN_FTRACE_TEST_NAME();
+
+	print_counts();
+
+	if (trace_selftest_test_probe1_cnt != 3)
+		goto out_free;
+	if (trace_selftest_test_probe2_cnt != 2)
+		goto out_free;
+	if (trace_selftest_test_probe3_cnt != 4)
+		goto out_free;
+	if (cnt > 1) {
+		if (trace_selftest_test_global_cnt == 0)
+			goto out_free;
+	}
+	if (trace_selftest_test_dyn_cnt == 0)
+		goto out_free;
+
+	DYN_FTRACE_TEST_NAME2();
+
+	print_counts();
+
+	if (trace_selftest_test_probe1_cnt != 3)
+		goto out_free;
+	if (trace_selftest_test_probe2_cnt != 3)
+		goto out_free;
+	if (trace_selftest_test_probe3_cnt != 5)
+		goto out_free;
+
 	ret = 0;
  out_free:
 	unregister_ftrace_function(dyn_ops);
-- 
2.26.3

