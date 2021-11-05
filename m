Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DA64466F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhKEQ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhKEQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:28:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF09C061208
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:25:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p16so19811016lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUTfLy1iCpJaN03F0qB7HmLPMvYCUl4mt7QEsJfTLts=;
        b=kkEJtaY1K2n82x/UBfegIqqgxmEgtDimvV3nuidIgABKW6b/bWTBhKWCqRTYZJ6zXJ
         cjn1R6E286iVDSbguU8u6YX1fG9GY0efrxqXQdEFis4uxZWnS15oJ6srFgw2x4Ur0CYe
         T0LjNOrKMx0JX1ecJygQwJzqvpTK3QFosK0E1oo/1IL2KCaLwZ8XswtAGt3zbzHb5Qe0
         eMZioRrukDQNT++0Lf9TI/g5tpO1ZnhKMa/1NNoxH0p+YkheoJ71aQd6+DTfwdfckguN
         sf4aQePetkg2GUbAcJwtQrFsJCUpAcpPczLPGcyHM3C06ZbU8YiqY4kkkW/4bX2uHod1
         8KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUTfLy1iCpJaN03F0qB7HmLPMvYCUl4mt7QEsJfTLts=;
        b=AiAGQNkZhWLZPoMoD1iQjMDhrJWa5ra1vVA7Dr/T70ljRjez1B4sEg0olrOSTc4GfR
         uBmfQuekoSa8BHVuLbsg+09ZOij7PpyDiL2w1w6+PSQ11pN0VewXJlJkK+tXn6tmiUuA
         Z+p3bg8+LH8U8yS0JqDleTEmdxpfz0ZbbyFaTCPjF4oPsoGiiC/zMEJYpRRBGE1XDqvc
         2FFfNeoLjiVI6WI9c4wpROJRl8XLDXjEFpXtRFzDj7TKIbZG7pJtXwVAJWAw9m3HFx24
         gHOWzWL47zzC6gz3klNIrBdQn1BBOYEZ68+saFK11Zb74bTZe83zJRYKIyknjpI1dmSV
         zl6g==
X-Gm-Message-State: AOAM530EKfbt+/DQZja8E0JbmKPFopEfCIT/AJZwSX4tYHhx0KrueX/9
        MfmOmwDtyNFH/pmwpsD65lC8XMu1T0Bd7A==
X-Google-Smtp-Source: ABdhPJy8KooI80fVpt9eaxrWsH+brvLejZ46wccflYYtY1bDxHtC/FMcxFJmC2hqfHTBccTJ8cSStw==
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr28399988lfg.201.1636129549793;
        Fri, 05 Nov 2021 09:25:49 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id t3sm870833lfc.216.2021.11.05.09.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:25:49 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, christian@brauner.io
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] selftests: cgroup: use function 'labs()' over 'abs()'
Date:   Fri,  5 Nov 2021 17:25:30 +0100
Message-Id: <20211105162530.3307666-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105162530.3307666-1-anders.roxell@linaro.org>
References: <20211105162530.3307666-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building selftests/cgroup with clang, the compiler warn about the
function abs() see below:

In file included from test_memcontrol.c:21:
./cgroup_util.h:16:9: warning: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Wabsolute-value]
        return abs(a - b) <= (a + b) / 100 * err;
               ^
./cgroup_util.h:16:9: note: use function 'labs' instead
        return abs(a - b) <= (a + b) / 100 * err;
               ^~~
               labs

The note indicates what to do, Rework to use the function 'labs()'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/cgroup/cgroup_util.h | 2 +-
 tools/testing/selftests/cgroup/test_kmem.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 82e59cdf16e7..76b35d9dffb5 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -13,7 +13,7 @@
  */
 static inline int values_close(long a, long b, int err)
 {
-	return abs(a - b) <= (a + b) / 100 * err;
+	return labs(a - b) <= (a + b) / 100 * err;
 }
 
 extern int cg_find_unified_root(char *root, size_t len);
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 22b31ebb3513..d65bb8fe876a 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -192,7 +192,7 @@ static int test_kmem_memcg_deletion(const char *root)
 		goto cleanup;
 
 	sum = slab + anon + file + kernel_stack + pagetables + percpu + sock;
-	if (abs(sum - current) < MAX_VMSTAT_ERROR) {
+	if (labs(sum - current) < MAX_VMSTAT_ERROR) {
 		ret = KSFT_PASS;
 	} else {
 		printf("memory.current = %ld\n", current);
@@ -383,7 +383,7 @@ static int test_percpu_basic(const char *root)
 	current = cg_read_long(parent, "memory.current");
 	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
 
-	if (current > 0 && percpu > 0 && abs(current - percpu) <
+	if (current > 0 && percpu > 0 && labs(current - percpu) <
 	    MAX_VMSTAT_ERROR)
 		ret = KSFT_PASS;
 	else
-- 
2.33.0

