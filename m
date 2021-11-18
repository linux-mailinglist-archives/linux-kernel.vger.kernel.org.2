Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EDF455870
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbhKRKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 05:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245322AbhKRKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 05:01:59 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2402C061766
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:58:58 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f18so23298465lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+O/tRzRt0aTbXVnB+DdljjU6ah6dRQd6+vFzdM3Bi4=;
        b=unyu7OwgDMXJdmdaeFF8QYwhR4gXJQ4N9ifkN9rUrT9S9jlc64bD+g5bvhgJ/idc21
         mrXZTe7EAiwbDeh/ltOoWgTM+SWE8Pbi8bbX2PHF5bJSYsNE5daib5GWhY3VaelQyVCg
         qJ/+KQiQoGRJi1t3xJBhlp/ph+tuIa31a5ks4NXYUeSuMFUIxAtkT3gdjYFe0wpJb5MM
         FIJr3A/Gndm3YgULcXmA2q3Cl9zLeHu/CYqjtM1LAQHo9q95lWADqlBjVA3tUnD4541W
         XhLdjctdhxHLYCqbPlQT0wjpG1axTvu3lodzOi22YtfdgKQAHVUhVyIXkPbf/XcpQp8U
         5yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+O/tRzRt0aTbXVnB+DdljjU6ah6dRQd6+vFzdM3Bi4=;
        b=GCKnnXvnq2hT7y2vQ67QGmHCoNKjdDuza8c5iZ81T6Qv3Pk2SAubD+kfvTcgeQrmId
         qOth/1F3GnYXy7i+CZRdnDmlRfcrxqZq1Xs8vnqFL7J8Kh4rd+w3ebtKhylmK4ZH+Hhl
         SzESBUSNEZ4f9R19lQrmLqDeGF+bpRMND5SCRMV4LvZZbCmLpA61eBt9++MHyARDXlbV
         lKLYCT94opG4nRCFz0D9preHwDdY7LwbjzOSyKt387vr6cbYVzUgwqvvEAw5iIBCP0FW
         H6hdJvLjx3p+ZMmjX6lJ7EJxHtwB6JpXHSZosMqQun58JzXp+mhAZ8OZDvnBHK4RoRZx
         ewDw==
X-Gm-Message-State: AOAM531Ubw2jklkmDY/LDV+fBqZPs910MjWt8EpIyRrgFnOhY4bZQgPy
        gNR3GOsVKhoiDEtkXkUvC8I+C/2s2ZAbTg==
X-Google-Smtp-Source: ABdhPJyi+0spX3wn1r8IFaINux9dkP2tBGxxKfV7B+JfDeMQFSuA+QsMIZDKPY/sicQmrojvlflXxg==
X-Received: by 2002:a05:6512:1189:: with SMTP id g9mr22693442lfr.396.1637229537123;
        Thu, 18 Nov 2021 01:58:57 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id y28sm254570lfa.92.2021.11.18.01.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 01:58:56 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, christian@brauner.io,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 2/2] selftests: clone3: simplify return logic in clone3_set_tid()
Date:   Thu, 18 Nov 2021 10:58:52 +0100
Message-Id: <20211118095852.616256-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118095852.616256-1-anders.roxell@linaro.org>
References: <CADYN=9+_UU9qZX56uahGXxz00iayqJLRAaQrRXh1CMXTvwSbAg@mail.gmail.com>
 <20211118095852.616256-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ksft_exit_* and exit instead of using goto.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/clone3/clone3_set_tid.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index a755fcd3af89..1b950c3c3b7c 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -250,7 +250,8 @@ int main(int argc, char *argv[])
 		 * that all those tests are skipped as non-root.
 		 */
 		ksft_cnt.ksft_xskip += ksft_plan - ksft_test_num();
-		goto out;
+		ksft_exit_skip(
+			"Please run the remaining tests as root - Exiting.\n");
 	}
 
 	/* Find the current active PID */
@@ -371,9 +372,7 @@ int main(int argc, char *argv[])
 	close(pipe_2[1]);
 
 	if (waitpid(ns_pid, &status, 0) < 0) {
-		ksft_print_msg("Child returned %s\n", strerror(errno));
-		ret = -errno;
-		goto out;
+		ksft_exit_fail_msg("Child returned %s\n", strerror(errno));
 	}
 
 	if (!WIFEXITED(status))
@@ -390,10 +389,6 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail(
 			"PIDs in all namespaces not as expected (%d,%d,%d)\n",
 			ns3, ns2, ns1);
-out:
-	ret = 0;
 
-	if (ret)
-		ksft_exit_fail();
 	ksft_exit_pass();
 }
-- 
2.33.0

