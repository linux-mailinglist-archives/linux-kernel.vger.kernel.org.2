Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A143402EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCRKLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhCRKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:10:27 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB37C06174A;
        Thu, 18 Mar 2021 03:10:27 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t4so1410855qkp.1;
        Thu, 18 Mar 2021 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1L8j0imCjqj6Ox0Kf+3S46R4RWttBliVjR+yZC3m/8Y=;
        b=J/q4BVCGuPL7ibMfGIbmYctpttS7+xSZm6UnyhrEQLwUZMHdAjLFRPOojrB82nJMy3
         kpRQXJv+gw66MPAEgdo+d96RRLlYq09AWzOYg19TbSLHbRz8axzAWMMpsl7bZPMqqhb9
         mCE8o3Bh7sYjK574O/cgoBd+3QomriGGYq3Wn7d/s9XuPuLU/WViSqcecIETuUwaWLqY
         rHZkLqAtOEnhrHwSd+Xxr1ju0kkJn7gsKR5ED6F5etrSRlPIHHmtH7LURny9XRhSVZvx
         iTJRBL7jmSDeDV5rfV7pvX1ZWgPIDGSG+3Ul3LNoMTnmRk2k0XwtM124Y6WipH61pUa/
         i0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1L8j0imCjqj6Ox0Kf+3S46R4RWttBliVjR+yZC3m/8Y=;
        b=MZKozoBWe3qCBxdfutScRUtvdSzBGblhgsQsPdmfC2Hzu1C2GgEK/e+nsJW+XcfP6a
         wdOQWh2ODdFei4wCPyBvKcUVOADvAqC+uy/sqEB72SQictLm4M+Uqyt80DYlb6Uyqsx6
         BsjQ4DyJR8jjoAy3jfMHzS930v3TsCMgZBRXJwIOzWv8i+peqiSRltx51qBUFSX7+/Si
         /VnjJYy+8vvA1a9jbKNrcknYgkbkGOMi0FNf3COe69/Az4Tk1JzpcmAjuZC/5louJbm/
         BGjC/dUw9cS7tXZENopiQ9Xp1JoOA3O11LgdwQVhk1FNsouABkhwXdxjCTdZXd4/wxpA
         z+HQ==
X-Gm-Message-State: AOAM532OY+gxlZxeg1JSHNhhL9hwjufHt9c7WRCQK7nUxgVS+8mwiAjt
        bt4WXQzat1mC2V/hNv5/e94=
X-Google-Smtp-Source: ABdhPJz8woB7jquNSUdFa3WRYXwRQeAE4qB3+ESkaVFh2Csedy/kUIN7xvm/EGVk5WZUDQJBARl7gw==
X-Received: by 2002:a37:8c42:: with SMTP id o63mr3432983qkd.449.1616062226388;
        Thu, 18 Mar 2021 03:10:26 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id d16sm1358101qka.43.2021.03.18.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:10:26 -0700 (PDT)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, gthelen@google.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v25 12/13] mm/damon: Add user space selftests
Date:   Thu, 18 Mar 2021 10:08:55 +0000
Message-Id: <20210318100856.34715-13-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318100856.34715-1-sj38.park@gmail.com>
References: <20210318100856.34715-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a simple user space tests for DAMON.  The tests are
using kselftest framework.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/damon/Makefile        |   7 +
 .../selftests/damon/_chk_dependency.sh        |  28 +++
 tools/testing/selftests/damon/_chk_record.py  | 109 ++++++++++++
 .../testing/selftests/damon/debugfs_attrs.sh  | 161 ++++++++++++++++++
 .../testing/selftests/damon/debugfs_record.sh |  50 ++++++
 5 files changed, 355 insertions(+)
 create mode 100644 tools/testing/selftests/damon/Makefile
 create mode 100644 tools/testing/selftests/damon/_chk_dependency.sh
 create mode 100644 tools/testing/selftests/damon/_chk_record.py
 create mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh
 create mode 100755 tools/testing/selftests/damon/debugfs_record.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
new file mode 100644
index 000000000000..cfd5393a4639
--- /dev/null
+++ b/tools/testing/selftests/damon/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for damon selftests
+
+TEST_FILES = _chk_dependency.sh _chk_record_file.py
+TEST_PROGS = debugfs_attrs.sh debugfs_record.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
new file mode 100644
index 000000000000..b304b7779976
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
+for f in attrs record target_ids monitor_on
+do
+	if [ ! -f "$DBGFS/$f" ]
+	then
+		echo "$f not found"
+		exit 1
+	fi
+done
diff --git a/tools/testing/selftests/damon/_chk_record.py b/tools/testing/selftests/damon/_chk_record.py
new file mode 100644
index 000000000000..73e128904319
--- /dev/null
+++ b/tools/testing/selftests/damon/_chk_record.py
@@ -0,0 +1,109 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"Check whether the DAMON record file is valid"
+
+import argparse
+import struct
+import sys
+
+fmt_version = 0
+
+def set_fmt_version(f):
+    global fmt_version
+
+    mark = f.read(16)
+    if mark == b'damon_recfmt_ver':
+        fmt_version = struct.unpack('i', f.read(4))[0]
+    else:
+        fmt_version = 0
+        f.seek(0)
+    return fmt_version
+
+def read_pid(f):
+    if fmt_version == 1:
+        pid = struct.unpack('i', f.read(4))[0]
+    else:
+        pid = struct.unpack('L', f.read(8))[0]
+
+def err_percent(val, expected):
+    return abs(val - expected) / expected * 100
+
+def chk_task_info(f):
+    pid = read_pid(f)
+    nr_regions = struct.unpack('I', f.read(4))[0]
+
+    if nr_regions > max_nr_regions:
+        print('too many regions: %d > %d' % (nr_regions, max_nr_regions))
+        exit(1)
+
+    nr_gaps = 0
+    eaddr = 0
+    for r in range(nr_regions):
+        saddr = struct.unpack('L', f.read(8))[0]
+        if eaddr and saddr != eaddr:
+            nr_gaps += 1
+        eaddr = struct.unpack('L', f.read(8))[0]
+        nr_accesses = struct.unpack('I', f.read(4))[0]
+
+        if saddr >= eaddr:
+            print('wrong region [%d,%d)' % (saddr, eaddr))
+            exit(1)
+
+        max_nr_accesses = aint / sint
+        if nr_accesses > max_nr_accesses:
+            if err_percent(nr_accesses, max_nr_accesses) > 15:
+                print('too high nr_access: expected %d but %d' %
+                        (max_nr_accesses, nr_accesses))
+                exit(1)
+    if nr_gaps != 2:
+        print('number of gaps are not two but %d' % nr_gaps)
+        exit(1)
+
+def parse_time_us(bindat):
+    sec = struct.unpack('l', bindat[0:8])[0]
+    nsec = struct.unpack('l', bindat[8:16])[0]
+    return (sec * 1000000000 + nsec) / 1000
+
+def main():
+    global sint
+    global aint
+    global min_nr
+    global max_nr_regions
+
+    parser = argparse.ArgumentParser()
+    parser.add_argument('file', metavar='<file>',
+            help='path to the record file')
+    parser.add_argument('--attrs', metavar='<attrs>',
+            default='5000 100000 1000000 10 1000',
+            help='content of debugfs attrs file')
+    args = parser.parse_args()
+    file_path = args.file
+    attrs = [int(x) for x in args.attrs.split()]
+    sint, aint, rint, min_nr, max_nr_regions = attrs
+
+    with open(file_path, 'rb') as f:
+        set_fmt_version(f)
+        last_aggr_time = None
+        while True:
+            timebin = f.read(16)
+            if len(timebin) != 16:
+                break
+
+            now = parse_time_us(timebin)
+            if not last_aggr_time:
+                last_aggr_time = now
+            else:
+                error = err_percent(now - last_aggr_time, aint)
+                if error > 15:
+                    print('wrong aggr interval: expected %d, but %d' %
+                            (aint, now - last_aggr_time))
+                    exit(1)
+                last_aggr_time = now
+
+            nr_tasks = struct.unpack('I', f.read(4))[0]
+            for t in range(nr_tasks):
+                chk_task_info(f)
+
+if __name__ == '__main__':
+    main()
diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
new file mode 100755
index 000000000000..c75557e8ba58
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -0,0 +1,161 @@
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
+# Test record file
+file="$DBGFS/record"
+
+ORIG_CONTENT=$(cat $file)
+
+echo "4242 foo.bar" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file writing sane input failed"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo abc 2 3 > $file
+if [ $? -eq 0 ]
+then
+	echo "$file writing insane input 1 success (should failed)"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo 123 > $file
+if [ $? -eq 0 ]
+then
+	echo "$file writing insane input 2 success (should failed)"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+CONTENT=$(cat $file)
+if [ "$CONTENT" != "4242 foo.bar" ]
+then
+	echo "$file not written"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo "0 null" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file disabling write fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+CONTENT=$(cat $file)
+if [ "$CONTENT" != "0 null" ]
+then
+	echo "$file not disabled"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo "4242 foo.bar" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file writing sane data again fail"
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
diff --git a/tools/testing/selftests/damon/debugfs_record.sh b/tools/testing/selftests/damon/debugfs_record.sh
new file mode 100755
index 000000000000..c0fb8d24dc32
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_record.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./_chk_dependency.sh
+
+restore_attrs()
+{
+	echo $ORIG_ATTRS > $DBGFS/attrs
+	echo $ORIG_TARGET_IDS > $DBGFS/target_ids
+	echo $ORIG_RECORD > $DBGFS/record
+}
+
+ORIG_ATTRS=$(cat $DBGFS/attrs)
+ORIG_TARGET_IDS=$(cat $DBGFS/target_ids)
+ORIG_RECORD=$(cat $DBGFS/record)
+
+rfile=$pwd/damon.data
+
+rm -f $rfile
+ATTRS="5000 100000 1000000 10 1000"
+echo $ATTRS > $DBGFS/attrs
+echo 4096 $rfile > $DBGFS/record
+sleep 5 &
+echo $(pidof sleep) > $DBGFS/target_ids
+echo on > $DBGFS/monitor_on
+sleep 0.5
+killall sleep
+echo off > $DBGFS/monitor_on
+
+sync
+
+if [ ! -f $rfile ]
+then
+	echo "record file not made"
+	restore_attrs
+
+	exit 1
+fi
+
+python3 ./_chk_record.py $rfile --attrs "$ATTRS"
+if [ $? -ne 0 ]
+then
+	echo "record file is wrong"
+	restore_attrs
+	exit 1
+fi
+
+rm -f $rfile
+restore_attrs
+echo "PASS"
-- 
2.17.1

