Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15E43332E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhCJB4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhCJBzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:55:51 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22143C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 17:55:51 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso9086293wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 17:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYj07w3V8npNrZdvgy1xhdfKg3PbHt8oWOdZw/MuZZo=;
        b=M42HyxWKF5UzMOTZJGZL24QUETO152e1XlfH9Sxu58y2UG0M0Ir1d5WbX3AGk5LPi9
         zZiZ+s3Ya7zsgX7YykRU4gA0ocW7YkdTWKhy6E2cp4wNL5M8izo7eVJ/xkZ+2kCNPNQF
         jIf+s2kzloyL/iH4e6fmx73OGpjXAuBGTfMnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYj07w3V8npNrZdvgy1xhdfKg3PbHt8oWOdZw/MuZZo=;
        b=Lt/hkwH/mOiUliPvnMxxFjEpMoIBwpfPtEVqep1iXzLp5M1wCQSG5QllyJh6pyVaRy
         mmmfT+E6QZrxM6jAkJLcIXDVAATgPHfuhllKDArS1g/2P4MIXdThJwfOB4qY8WyxDfBl
         DDVL/VMbIkLpModwf+TJ/8jJ/Gg9tFvysoCLvKJ0t3trt5cp5rtZPqrKnqgsH2hrDL82
         +JwvOe8wNn1gj0xQpufnoHm+umJbTxrjWzOtM1nyG5lFfpErsx2A7UwNHd2mK87I45qW
         TgBygCnJ1wAz5ngifXcERAszvJbiLdXsrGvkVobohTHLZGMjioFhDxqC/Rwq6ex4aCBn
         E80w==
X-Gm-Message-State: AOAM530BvgIWhpHsRONLrRPKJiUi9cIX5pBDXgX4y2T0KaAZljksKH7S
        xLflEYPHEpAfaVg/xqGlS8hsWA==
X-Google-Smtp-Source: ABdhPJzjETIxAUoy+RZtVxHIgkaMpSU163drD7l9xnpbJ7UsI6FCVGMPngIOBVLviMqPmfzn+pJj2g==
X-Received: by 2002:a1c:988c:: with SMTP id a134mr722659wme.120.1615341349711;
        Tue, 09 Mar 2021 17:55:49 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:e08c:1e90:4e6b:365a])
        by smtp.gmail.com with ESMTPSA id p18sm32171313wro.18.2021.03.09.17.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 17:55:49 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [BUG] One-liner array initialization with two pointers in BPF results in NULLs
Date:   Wed, 10 Mar 2021 02:54:55 +0100
Message-Id: <20210310015455.1095207-1-revest@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that initializing an array of pointers using this syntax:
__u64 array[] = { (__u64)&var1, (__u64)&var2 };
(which is a fairly common operation with macros such as BPF_SEQ_PRINTF)
always results in array[0] and array[1] being NULL.

Interestingly, if the array is only initialized with one pointer, ex:
__u64 array[] = { (__u64)&var1 };
Then array[0] will not be NULL.

Or if the array is initialized field by field, ex:
__u64 array[2];
array[0] = (__u64)&var1;
array[1] = (__u64)&var2;
Then array[0] and array[1] will not be NULL either.

I'm assuming that this should have something to do with relocations
and might be a bug in clang or in libbpf but because I don't know much
about these, I thought that reporting could be a good first step. :)

I attached below a repro with a dummy selftest that I expect should pass
but fails to pass with the latest clang and bpf-next. Hopefully, the
logic should be simple: I try to print two strings from pointers in an
array using bpf_seq_printf but depending on how the array is initialized
the helper either receives the string pointers or NULL pointers:

test_bug:FAIL:read unexpected read: actual 'str1= str2= str1=STR1
str2=STR2 ' != expected 'str1=STR1 str2=STR2 str1=STR1 str2=STR2 '

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/bpf/prog_tests/bug.c | 41 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_bug.c | 43 ++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bug.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bug.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bug.c b/tools/testing/selftests/bpf/prog_tests/bug.c
new file mode 100644
index 000000000000..4b0fafd936b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bug.c
@@ -0,0 +1,41 @@
+#include <test_progs.h>
+#include "test_bug.skel.h"
+
+static int duration;
+
+void test_bug(void)
+{
+	struct test_bug *skel;
+	struct bpf_link *link;
+	char buf[64] = {};
+	int iter_fd, len;
+
+	skel = test_bug__open_and_load();
+	if (CHECK(!skel, "test_bug__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		goto destroy;
+
+	link = bpf_program__attach_iter(skel->progs.bug, NULL);
+	if (CHECK(IS_ERR(link), "attach_iter", "attach_iter failed\n"))
+		goto destroy;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+		goto free_link;
+
+	len = read(iter_fd, buf, sizeof(buf));
+	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
+	// BUG: We expect the strings to be printed in both cases but only the
+	// second case works.
+	// actual 'str1= str2= str1=STR1 str2=STR2 '
+	// != expected 'str1=STR1 str2=STR2 str1=STR1 str2=STR2 '
+	ASSERT_STREQ(buf, "str1=STR1 str2=STR2 str1=STR1 str2=STR2 ", "read");
+
+	close(iter_fd);
+
+free_link:
+	bpf_link__destroy(link);
+destroy:
+	test_bug__destroy(skel);
+}
+
diff --git a/tools/testing/selftests/bpf/progs/test_bug.c b/tools/testing/selftests/bpf/progs/test_bug.c
new file mode 100644
index 000000000000..c41e69483785
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bug.c
@@ -0,0 +1,43 @@
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("iter/task")
+int bug(struct bpf_iter__task *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+
+	/* We want to print two strings */
+	static const char fmt[] = "str1=%s str2=%s ";
+	static char str1[] = "STR1";
+	static char str2[] = "STR2";
+
+	/*
+	 * Because bpf_seq_printf takes parameters to its format specifiers in
+	 * an array, we need to stuff pointers to str1 and str2 in a u64 array.
+	 */
+
+	/* First, we try a one-liner array initialization. Note that this is
+	 * what the BPF_SEQ_PRINTF macro does under the hood. */
+	__u64 param_not_working[] = { (__u64)str1, (__u64)str2 };
+	/* But we also try a field by field initialization of the array. We
+	 * would expect the arrays and the behavior to be exactly the same. */
+	__u64 param_working[2];
+	param_working[0] = (__u64)str1;
+	param_working[1] = (__u64)str2;
+
+	/* For convenience, only print once */
+	if (ctx->meta->seq_num != 0)
+		return 0;
+
+	/* Using the one-liner array of params, it does not print the strings */
+	bpf_seq_printf(seq, fmt, sizeof(fmt),
+		       param_not_working, sizeof(param_not_working));
+	/* Using the field-by-field array of params, it prints the strings */
+	bpf_seq_printf(seq, fmt, sizeof(fmt),
+		       param_working, sizeof(param_working));
+
+	return 0;
+}
-- 
2.30.1.766.gb4fecdf3b7-goog

