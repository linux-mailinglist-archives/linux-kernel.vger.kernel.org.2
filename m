Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61C3389F50
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhETH7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhETH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:58:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34CAC06138A;
        Thu, 20 May 2021 00:57:11 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o27so15272342qkj.9;
        Thu, 20 May 2021 00:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=92l+8w7L4L+POeiMQ+785lRXaO47cAlZxhuw/8KNqwY=;
        b=e5tGORXElV2niilXU9p6zwQSibYPE78JjEZl9D/rV346TloCkYEEm3paLyUTETHHGZ
         NBuvR8yzd48vIIT7T0UCptccYLCuI0sbLIxBg0iXf+26MMptukzuV4Uc0zLEM1nQkv2s
         PCvP5Zz+V35veN9Io2JBcB4/ynH2eq2hFcPEqRe5kGheVzrfhAMW+EKfUYR+bFwWyN8D
         ACIyZLhnL5Tof3BzY89ZcjVdztYn1sXFnHFT5jm0nywW6NsKgi1klXLbHyMgli+Q9p+y
         5G31NRIJ5ZbV13axo5spfqBYsEql3yDuQfweIa8CIHkSAPf5EJmexvCBQGkWrPPOAaMn
         G5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=92l+8w7L4L+POeiMQ+785lRXaO47cAlZxhuw/8KNqwY=;
        b=OdAkARh5hZz8OMI+JSPH+Hu0O8IouDNFH4a7kPipAAHI4vSVRYt4jgZZySTMLL6Av0
         dCxz8Ty79I0AC8T4jdocwlJhuNydua33kUlnUExUn0lP0aUQjoiYMTwvAAap4cB1Tjwn
         foAbqrfNpaACJjRd4fy3s5ApIFXjFCb5A/BbmMhiKPtq1H/ur27SvTB+PPUMOtNjrXxg
         qjMG8nExDeLxwpog7cwTY2W5b07OqfEjZpfvgJ2vTvA09UbCT0AvYbkapEbL6RQx6M5V
         mlb4U1Lx+bNbgaFojsu0D+GvPtEUpIeDFl5k63WiJ6/jPc6UNtcV5NtcAnXHbFmFr/z3
         HrjA==
X-Gm-Message-State: AOAM531ujvEtja1PDnhjHsXaFFfhfSM7tGiMlzaMMNJcnnj51KoELTb8
        AmsI978Md72o11oqKcQVR7o=
X-Google-Smtp-Source: ABdhPJzJQmpvqWhcLThGmjrhjCDrqO0TcVgaG9taRSNQTWYSWxNLpcVK91J2BrAzg9vK99pYG6nYqw==
X-Received: by 2002:ae9:d60f:: with SMTP id r15mr3746384qkk.20.1621497430348;
        Thu, 20 May 2021 00:57:10 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g9sm1478254qka.38.2021.05.20.00.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:57:09 -0700 (PDT)
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
Subject: [PATCH v29 12/13] mm/damon: Add user space selftests
Date:   Thu, 20 May 2021 07:56:28 +0000
Message-Id: <20210520075629.4332-13-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520075629.4332-1-sj38.park@gmail.com>
References: <20210520075629.4332-1-sj38.park@gmail.com>
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

