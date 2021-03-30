Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0034E3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhC3JHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhC3JGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:06:23 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5DC061762;
        Tue, 30 Mar 2021 02:06:23 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f12so11405357qtq.4;
        Tue, 30 Mar 2021 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=92l+8w7L4L+POeiMQ+785lRXaO47cAlZxhuw/8KNqwY=;
        b=Y5/ln7IZ+9G1HFKKFbKL7gR9g5/oFg+30yn4rBd9h1/ckg2nlh0bJDBGTwoCVIq2xj
         srHfzDmPfX2BpjQwjGW5xlSg2y72f4xT82Ch3tHZLTaoFn69UKlbZFYH/tcRCbQVMFnx
         s/D+GZn6hCrUhcMxa0QizJ1W6vuWObdnU0v0m/2giwNV0M03rh6qAKBKM53FOwfesGDp
         i0dK7q4L6moW6GfptVpHtwP7kB2A7zKnRwMZ+BgO4bEAT4DzcdQ8yR8HzVF9LBnSD+dF
         texyHWa4OmnBM1KC9GSG1zglxtLYB/HscVXS9EMENZqhWj+jTlhUrF+qIfV8HUSPomZe
         VfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=92l+8w7L4L+POeiMQ+785lRXaO47cAlZxhuw/8KNqwY=;
        b=gkhauD0u4iDZBfkLT8kSl62heymQgRGpxSU16yO/+dgUzfkUQdRUAtJUX4Z+aBfVmY
         Y7QLyiVygdE467Le3YEz5zxpcEUVfePl8wuZzYT1afRDUopZUdxwmYmrXCNWJrK0G6/h
         6HMWJF84m2AypQQXGGhDs02hBpblBBTOuklux/q9+BBi17dBZ/L+2QBhjoxiIJ4gFZ+6
         IbMRynnu62vDnhCF85zwa5eIm0YVHIddv8c9t+SPmriJM2U27zqdgnYp4FWszlj3+wk8
         RbQ427ge9YkD2n+KQz2ZFKRMb8LiHBa/C24h67qFlYn3cRODFqHCowggFCDreCYnslcj
         1x6g==
X-Gm-Message-State: AOAM531TOG7uGLrvw/KLK9HgAbiLQe0hQEJ3LHK0vhYj0yTMKneXPV5q
        Eu8tiMCNfo5ka2a2lMJFbs8=
X-Google-Smtp-Source: ABdhPJynq7jM6AVwr0lv1Ds7DnOcWwNXFsT0Sw+5Qz4fW2/oldiIFf+iwgmZHCSC9eG1aAK5lDp0Mw==
X-Received: by 2002:a05:622a:c6:: with SMTP id p6mr26728342qtw.200.1617095182335;
        Tue, 30 Mar 2021 02:06:22 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 8sm14630011qkc.32.2021.03.30.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:06:21 -0700 (PDT)
From:   sj38.park@gmail.com
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
Subject: [PATCH v26 12/13] mm/damon: Add user space selftests
Date:   Tue, 30 Mar 2021 09:05:36 +0000
Message-Id: <20210330090537.12143-13-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330090537.12143-1-sj38.park@gmail.com>
References: <20210330090537.12143-1-sj38.park@gmail.com>
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

