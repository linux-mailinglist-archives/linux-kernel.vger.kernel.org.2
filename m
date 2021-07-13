Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157933C7075
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhGMMhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbhGMMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:37:32 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1AFC06178A;
        Tue, 13 Jul 2021 05:34:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id k3so7363919qtq.7;
        Tue, 13 Jul 2021 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Vk7ZOtHAlS3Sf8cuVe/kfkiJfu3tPfpbdiCemuvVIA=;
        b=dJlD3MwZQcWVLnxRLWvqA/qFGVgkAs4lEkBJmocgPSysN6B/UN1MvcrqexwbDhPbAr
         CooOsTF7wPAWxvXhSmah1Udn2SXZYu89epWNpRu/Sgs87cC0KYY7FQtU8JRkUhIwHX6+
         fwiSkk3HtJLNmdsJrtHRMkr1/pk77PipjVCQDJ8ovGbTpfOxIq/CCmf4ZfEZq4+LfKKG
         /RhDm0N/bevhyVfGakQcaCkswDNkQ0jNJaRVlHoxvRoAEvwC8ptNfJyZKLW9M+5lJx5P
         qIMIYrgcMjznTp1ZLevrKnpJy/iNnyNfdOC/IDEpw4mvajgpM8n6wuP0CxwGYZj8JSPQ
         GuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Vk7ZOtHAlS3Sf8cuVe/kfkiJfu3tPfpbdiCemuvVIA=;
        b=sNv9RHjl5kZOr7TDZ2FnklE8P/E0dR7bSUWzUvrGLkjADb3ecPIzV9WY3zXd9pdVDZ
         nWdX1H7VEaXdyiQ/hMlTUscxFQ+oovL7jZyd38++LekW+zivR2dz1B9UEi7bcMzSNS+q
         yeS5eBI75eLMUR3TnIwgyla8+80zHPTbyx49ipnpexs4nlC52TtxpTkIzTE0Y27e85ES
         zCeipYXBA9qFXyQJk1HHs1Q4r/PPF+HW8egqKDRQr7bNxdLVal2s5Xy5MBU3zl2QL1OI
         t+KnOsmQmyIOLL3wVja76EPX4NthxN2+iQQBcoLzGOwvf3YdXajQrjtu4c+liTq1YD6m
         gTWA==
X-Gm-Message-State: AOAM5301DkkwTU8g/b6c/Pm25EOG8Pk0XIbXYxAQO+w1pwjzyp4Jm3+S
        nXGQ4gcuz6VGPaLV3eyGBSg=
X-Google-Smtp-Source: ABdhPJx86SR06OiFthpWTL+ax8QTcjEJlF6DvdvRM7CMUrP6Ga+GGDE5yG1vCp6agDwQ1meRIjpb0w==
X-Received: by 2002:a05:622a:14c9:: with SMTP id u9mr3827123qtx.7.1626179681638;
        Tue, 13 Jul 2021 05:34:41 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id k14sm6849327qtm.18.2021.07.13.05.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:34:41 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v33 12/13] mm/damon: Add user space selftests
Date:   Tue, 13 Jul 2021 12:33:55 +0000
Message-Id: <20210713123356.6924-13-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210713123356.6924-1-sj38.park@gmail.com>
References: <20210713123356.6924-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a simple user space tests for DAMON.  The tests are
using kselftest framework.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Markus Boehme <markubo@amazon.de>
---
 tools/testing/selftests/damon/Makefile        |  7 ++
 .../selftests/damon/_chk_dependency.sh        | 28 +++++++
 .../testing/selftests/damon/debugfs_attrs.sh  | 75 +++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/damon/Makefile
 create mode 100644 tools/testing/selftests/damon/_chk_dependency.sh
 create mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
new file mode 100644
index 000000000000..8a3f2cd9fec0
--- /dev/null
+++ b/tools/testing/selftests/damon/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for damon selftests
+
+TEST_FILES = _chk_dependency.sh
+TEST_PROGS = debugfs_attrs.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
new file mode 100644
index 000000000000..0189db81550b
--- /dev/null
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+DBGFS=/sys/kernel/debug/damon
+
+if [ $EUID -ne 0 ];
+then
+	echo "Run as root"
+	exit $ksft_skip
+fi
+
+if [ ! -d "$DBGFS" ]
+then
+	echo "$DBGFS not found"
+	exit $ksft_skip
+fi
+
+for f in attrs target_ids monitor_on
+do
+	if [ ! -f "$DBGFS/$f" ]
+	then
+		echo "$f not found"
+		exit 1
+	fi
+done
diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
new file mode 100755
index 000000000000..bfabb19dc0d3
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -0,0 +1,75 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+test_write_result() {
+	file=$1
+	content=$2
+	orig_content=$3
+	expect_reason=$4
+	expected=$5
+
+	echo "$content" > "$file"
+	if [ $? -ne "$expected" ]
+	then
+		echo "writing $content to $file doesn't return $expected"
+		echo "expected because: $expect_reason"
+		echo "$orig_content" > "$file"
+		exit 1
+	fi
+}
+
+test_write_succ() {
+	test_write_result "$1" "$2" "$3" "$4" 0
+}
+
+test_write_fail() {
+	test_write_result "$1" "$2" "$3" "$4" 1
+}
+
+test_content() {
+	file=$1
+	orig_content=$2
+	expected=$3
+	expect_reason=$4
+
+	content=$(cat "$file")
+	if [ "$content" != "$expected" ]
+	then
+		echo "reading $file expected $expected but $content"
+		echo "expected because: $expect_reason"
+		echo "$orig_content" > "$file"
+		exit 1
+	fi
+}
+
+source ./_chk_dependency.sh
+
+# Test attrs file
+# ===============
+
+file="$DBGFS/attrs"
+orig_content=$(cat "$file")
+
+test_write_succ "$file" "1 2 3 4 5" "$orig_content" "valid input"
+test_write_fail "$file" "1 2 3 4" "$orig_content" "no enough fields"
+test_write_fail "$file" "1 2 3 5 4" "$orig_content" \
+	"min_nr_regions > max_nr_regions"
+test_content "$file" "$orig_content" "1 2 3 4 5" "successfully written"
+echo "$orig_content" > "$file"
+
+# Test target_ids file
+# ====================
+
+file="$DBGFS/target_ids"
+orig_content=$(cat "$file")
+
+test_write_succ "$file" "1 2 3 4" "$orig_content" "valid input"
+test_write_succ "$file" "1 2 abc 4" "$orig_content" "still valid input"
+test_content "$file" "$orig_content" "1 2" "non-integer was there"
+test_write_succ "$file" "abc 2 3" "$orig_content" "the file allows wrong input"
+test_content "$file" "$orig_content" "" "wrong input written"
+test_write_succ "$file" "" "$orig_content" "empty input"
+test_content "$file" "$orig_content" "" "empty input written"
+echo "$orig_content" > "$file"
+
+echo "PASS"
-- 
2.17.1

