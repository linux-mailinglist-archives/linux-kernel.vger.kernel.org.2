Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E03C36DB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhD1PZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhD1PZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:25:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:25:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so4940747wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AVZoGgHHG5L2/L0aYz6MwosCvu+AQ1gWRwjr/PIhwY=;
        b=dMRxeJPOeBuBiCyg+Tzyqg4F48X2Pcri1aTdKqz6Fm4a2q7C75mzKuobgRNLBh2Llb
         vTjjSJLMRwFXXI+eID6fLhCFc8lz7NOkesvdTrWITUofipbRUZKSqKjzCSow5HqPbM2W
         aUlbXxZuI16x4lZyXi+ndH2l+qxnNoipaR0Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AVZoGgHHG5L2/L0aYz6MwosCvu+AQ1gWRwjr/PIhwY=;
        b=jy7Crtpfh4T4F4GVVzlVTB5uOmD4T+GYtHNekGDCnlo1IqVAbycVtaIsEKqDeuUXk2
         P7Dd/LH5tXJJBZgri0PyC8QDs/K2dmcIalxSIPLHSqxsfdEZOaT+Y+5EZLGtMMCDDwsp
         TlYmoQ6kA4T3h3VS1tjlA+fChyMidUM9UgdyEmmVWsPIfvuPdly6jtFMSmz+WTHYCq2b
         PU+rCG37/FJu3oxsZ5Ews+ftHOUkkuH6BtyYQ6u63XyJsYWdMhdbc01o1UWUKrmzUM3/
         iHWslp5+INJzJpDzGsTonDK2lVlUVIQ7Qf+a18GXfo1HCr5AYTfKVHmx3siBM/1Ajb0H
         Hpsg==
X-Gm-Message-State: AOAM530nqG+RZIYOx/cDD9XL5MnTFavK9Ej3AxRr7FvAiP92jd7X+KSm
        RYKm+E6uPP/jGC1wtp57Gp+N/A==
X-Google-Smtp-Source: ABdhPJxxtzzldycl1Z+eZPKNnM8aZoaDbV3OSCdmjz83Qp+UE83ke43vSEURLyyLxbRsKhrbBn6DtA==
X-Received: by 2002:a1c:1bcc:: with SMTP id b195mr18849024wmb.108.1619623508762;
        Wed, 28 Apr 2021 08:25:08 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e04e:f47f:2641:7707])
        by smtp.gmail.com with ESMTPSA id d2sm91471wrs.10.2021.04.28.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:25:08 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix the snprintf test
Date:   Wed, 28 Apr 2021 17:25:01 +0200
Message-Id: <20210428152501.1024509-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BPF program for the snprintf selftest runs on all syscall entries.
On busy multicore systems this can cause concurrency issues.

For example it was observed that sometimes the userspace part of the
test reads "    4 0000" instead of "    4 000" (extra '0' at the end)
which seems to happen just before snprintf on another core sets
end[-1] = '\0'.

This patch adds a pid filter to the test to ensure that no
bpf_snprintf() will write over the test's output buffers while the
userspace reads the values.

Fixes: c2e39c6bdc7e ("selftests/bpf: Add a series of tests for bpf_snprintf")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/bpf/prog_tests/snprintf.c | 2 ++
 tools/testing/selftests/bpf/progs/test_snprintf.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
index a958c22aec75..dffbcaa1ec98 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -43,6 +43,8 @@ void test_snprintf_positive(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
+	skel->bss->pid = getpid();
+
 	if (!ASSERT_OK(test_snprintf__attach(skel), "skel_attach"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
index 951a0301c553..e35129bea0a0 100644
--- a/tools/testing/selftests/bpf/progs/test_snprintf.c
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -5,6 +5,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+__u32 pid = 0;
+
 char num_out[64] = {};
 long num_ret = 0;
 
@@ -42,6 +44,9 @@ int handler(const void *ctx)
 	static const char str1[] = "str1";
 	static const char longstr[] = "longstr";
 
+	if ((int)bpf_get_current_pid_tgid() != pid)
+		return 0;
+
 	/* Integer types */
 	num_ret  = BPF_SNPRINTF(num_out, sizeof(num_out),
 				"%d %u %x %li %llu %lX",
-- 
2.31.1.498.g6c1eba8ee3d-goog

