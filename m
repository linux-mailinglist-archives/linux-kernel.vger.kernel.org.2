Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5D3B5F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhF1NiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhF1NhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:37:19 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5CC06124C;
        Mon, 28 Jun 2021 06:34:34 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id bj15so27327004qkb.11;
        Mon, 28 Jun 2021 06:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Vk7ZOtHAlS3Sf8cuVe/kfkiJfu3tPfpbdiCemuvVIA=;
        b=tBExaNIvYsZUtkIb7G1TYZdnGFOM+n/rsbs/urG9vKGPBXkGnh/l8TDuBl6VWloDDe
         eZa9pcEByj82AsH453f2HMEfNOJdFf3vx/hAsj4HxC5/SM5GexsIY3jmYMOQBIffVOJA
         W/g7uWiRmluVynUU5OabtdI6j3Qslf0HJ99H+L6NNxO1+p/vnzE3ZXVKkL8rLBMXRK2J
         9cJXjHDSb50iK+9TClwmDtm4Oj4FLKM6aaHi6OVD3MLzstUmFtGl/ZT2szOuAS+YFvPj
         FAu0VFu8AZ2bs8sQ1nvBd6hN7przPRp7wvjv81z5J1a82qA7LgZTaeQWyAd5heOYh5ac
         BLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Vk7ZOtHAlS3Sf8cuVe/kfkiJfu3tPfpbdiCemuvVIA=;
        b=B574x2N5TWBtqQqgethtr567X1gTMDr5lobSI4w4U9Yshr8xY4dPhdgRbsNHJwwBlW
         FcCM6vA6GXiaM7zSRND80q0Z//HZ+31fmsBxmCLt1k+4AGdQllh2vbW4wyN1C5240slX
         L5Zn0FWFjW+n4cxEQOzYEn82XrDkM5Lg5jzu//sQyKH+dKCNIdZXfkB7hV4XpludguaA
         lqZIx3BgHBwVgBIp0+fkB7mjecHSuvzaeUDMP4MB6FJXsW81mGQ+9OfjBXukAO0Bu/Ht
         YOqC8eMDIZQuppiA5hcMC8cWtGwTA9dEF1m0RREtuzOjlrWbbYPJ1083fUPr06lKlHLn
         lq5A==
X-Gm-Message-State: AOAM533MU55vmPzYvDX3jQFW+gRiU3EwCAqIkunhYaNhX6Tiy5e9Z4gI
        fiJ+I0nJLub+umY2aKTIvOM=
X-Google-Smtp-Source: ABdhPJwWV2//1o5Tl+rwOaAhl8PUYzy7sEhgmYErfDPD3nStRrZH/q0hRbm0GfwvqGeDDC/nC43wNQ==
X-Received: by 2002:a37:7046:: with SMTP id l67mr25227508qkc.69.1624887273392;
        Mon, 28 Jun 2021 06:34:33 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h1sm2276030qkm.50.2021.06.28.06.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 06:34:33 -0700 (PDT)
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
Subject: [PATCH v32 12/13] mm/damon: Add user space selftests
Date:   Mon, 28 Jun 2021 13:33:54 +0000
Message-Id: <20210628133355.18576-13-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210628133355.18576-1-sj38.park@gmail.com>
References: <20210628133355.18576-1-sj38.park@gmail.com>
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

