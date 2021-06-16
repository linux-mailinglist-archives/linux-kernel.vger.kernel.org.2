Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAEF3A940E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhFPHeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhFPHeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:34:05 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083A2C061760;
        Wed, 16 Jun 2021 00:32:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g142so113331qke.4;
        Wed, 16 Jun 2021 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y6ub9fyy+kY3wr1D4jgfP2qUR0G5AOTzKy2dgPcDWXc=;
        b=fNnAkLwSG3SQS1S/AsWGXgaEJggx8W4RDIygXub5gSEndZGgv96E9J0vPZUk5wvejl
         HSfUaODbKbYqWXIf+CInn9ES4GcH+ITpqBmqQHE4E6/Quc+RvEL/er7OX+Qt5RHUs/a1
         DYP7sC6XRGU1i0h8HwfAMKBAloRCtTJtTf6EEd6LVnNoS3NqAEODhVMEOjgHqb3SaPNZ
         9zxBzr0ENmitPdp7JQs2+vyx73gVlkDQ2yHqFJnbJuK1rSOHVpQ6KmW/hB2sSsBH1WNt
         tg07K2rI4rwq0edq3mkwju4obI7vEweF0dW9llQsKXRu9sK3X76t1yAYKVfWd1HqrbV4
         B7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y6ub9fyy+kY3wr1D4jgfP2qUR0G5AOTzKy2dgPcDWXc=;
        b=hVkr2O4emrFmAblDw7SxIC6mfwndbhqg4ATXvFV3A+cxk8NMkEa2HHErgw/EePuR5i
         kwIgiu/HxZu37JytC2vAhCXPOGPjuk462+3CLmJ0Zz3/BsY+hM6l+/u5PbS0In1FzWKp
         RRtag8VTht+33KGVwbTdHyTEuh0z8dle+PwHAyF0+ODCRGM3j76Xec9pYXWxBpMHsfuQ
         1YwI1QQd8Lo0mpzPTdISwPuxBO2v2Ft2yrJJ6mKV/bCbl0jwzLGEXWMb+4yL9tY7Y+oh
         LkJrj2hRzkEmgb/1AgPn9Q+UOyU73ubglPJD4F2yWl6mUOqIaRQwJSchlUtRFOCuwS+g
         05Vw==
X-Gm-Message-State: AOAM532iBdgA1P/KbtxPy0reVJCsRKDNYlctBPURJEKZ9xBpTpUeXfYk
        gVPR2AlQ4sDBGHF8Mhv48mE=
X-Google-Smtp-Source: ABdhPJyJPfy6jHGrgUlJTVNuWTLBKCvXVSohEyiEbCh9BcPh0KMex/uzogQMV9oiE0E/5he0Z3QO+w==
X-Received: by 2002:a37:7046:: with SMTP id l67mr3834882qkc.69.1623828719217;
        Wed, 16 Jun 2021 00:31:59 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h5sm1080697qkg.122.2021.06.16.00.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:31:58 -0700 (PDT)
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
Subject: [PATCH v30 12/13] mm/damon: Add user space selftests
Date:   Wed, 16 Jun 2021 07:31:18 +0000
Message-Id: <20210616073119.16758-13-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210616073119.16758-1-sj38.park@gmail.com>
References: <20210616073119.16758-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a simple user space tests for DAMON.  The tests are
using kselftest framework.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
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
index 000000000000..60342d6c86d8
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
+	if [ "$content" != "$content" ]
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

