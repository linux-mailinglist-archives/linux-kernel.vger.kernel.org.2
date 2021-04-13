Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159A635E18E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245415AbhDMOcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbhDMOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:30:01 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010F5C06175F;
        Tue, 13 Apr 2021 07:29:40 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 130so3791703qkm.4;
        Tue, 13 Apr 2021 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=92l+8w7L4L+POeiMQ+785lRXaO47cAlZxhuw/8KNqwY=;
        b=D5CCyMvOHAvavZZifzx4/+Kx2do2w+7fV7Leh+8DN8pe0/hf7V6IMVp7BORvd6cELg
         M205egr4PFWX7ssqZOrFfS9V0NiB3KNEC1b6FXHtQszwlOIdw8X559Xv1wyoNhkN0Rvw
         Cf0r0q0iWyGhO8JPCwMNnzr/wXJL0EdZXSAmfTW+sH+H7U8rdv1Vz6dJzkPlVCzct86v
         7DAfj/zyqxCxoHF3hoonazbak6qyan6Qy/BYlhnTemxGr17/1pXm4Krpk3Bfu7kkbWyL
         F5FjTr55CUmHKJ9miCerj/MsWuFeDodJzg0YFzBnkwu7rqD49sqQ8Ks8qne0vgwQGtlT
         GdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=92l+8w7L4L+POeiMQ+785lRXaO47cAlZxhuw/8KNqwY=;
        b=kZO5apeqGO2Ovk9qTt+SZW35ZKuFjHWtBFQw6NEjhgtDx+i0nmG5GlecLPTMyQZfYx
         b0jlWqlQaDDnvcqDf07Nwub2DSlgh9oke8LEuzWb16SgiFRPMPiLjoJkza/k0/Krh/jc
         wnHDu0EirfGtlYMjs/Zea6z/r7cKe/mp4gDHwLIHOtT0CsBIYIExGnMuszSVsWT/suxw
         /47PcIebnjJ9mHF//maz4XdbhtAGMG7v3lcv3hIJxSqxTetWCFPDYhE+mUvp7LIwIzSD
         idXwjnBvEKfUaRkFN5pnm17D+XMotuF/v/NgFvBTNRuUsE85QOGHEQLRYHgnuLOJA6nJ
         550g==
X-Gm-Message-State: AOAM531VFYIy+mYy8ZCbjm5zdc2FMpkrOFrEhjWoixcwpP76Q/a6zfVW
        1k095ksXg4l2F7h1juZR7I8=
X-Google-Smtp-Source: ABdhPJzbr9XfAuzz2YtBjbF1+1fPyvdwv9W7I0y57Cqa/Lz3KUZD54pnZe7Nr6u5aycSU7ZoCgDHHg==
X-Received: by 2002:a37:89c7:: with SMTP id l190mr34745718qkd.361.1618324179276;
        Tue, 13 Apr 2021 07:29:39 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 2sm6160911qko.134.2021.04.13.07.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:29:38 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v28 12/13] mm/damon: Add user space selftests
Date:   Tue, 13 Apr 2021 14:29:03 +0000
Message-Id: <20210413142904.556-13-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210413142904.556-1-sj38.park@gmail.com>
References: <20210413142904.556-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a simple user space tests for DAMON.  The tests are
using kselftest framework.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/damon/Makefile        |  7 ++
 .../selftests/damon/_chk_dependency.sh        | 28 ++++++
 .../testing/selftests/damon/debugfs_attrs.sh  | 98 +++++++++++++++++++
 3 files changed, 133 insertions(+)
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
index 000000000000..e090836c2bf7
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
+if [ ! -d $DBGFS ]
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
index 000000000000..4a8ab4910ee4
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -0,0 +1,98 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./_chk_dependency.sh
+
+# Test attrs file
+file="$DBGFS/attrs"
+
+ORIG_CONTENT=$(cat $file)
+
+echo 1 2 3 4 5 > $file
+if [ $? -ne 0 ]
+then
+	echo "$file write failed"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo 1 2 3 4 > $file
+if [ $? -eq 0 ]
+then
+	echo "$file write success (should failed)"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+CONTENT=$(cat $file)
+if [ "$CONTENT" != "1 2 3 4 5" ]
+then
+	echo "$file not written"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo $ORIG_CONTENT > $file
+
+# Test target_ids file
+file="$DBGFS/target_ids"
+
+ORIG_CONTENT=$(cat $file)
+
+echo "1 2 3 4" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file write fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo "1 2 abc 4" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file write fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+CONTENT=$(cat $file)
+if [ "$CONTENT" != "1 2" ]
+then
+	echo "$file not written"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo abc 2 3 > $file
+if [ $? -ne 0 ]
+then
+	echo "$file wrong value write fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+if [ ! -z "$(cat $file)" ]
+then
+	echo "$file not cleared"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo > $file
+if [ $? -ne 0 ]
+then
+	echo "$file init fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+if [ ! -z "$(cat $file)" ]
+then
+	echo "$file not initialized"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo $ORIG_CONTENT > $file
+
+echo "PASS"
-- 
2.17.1

