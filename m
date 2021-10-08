Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96D6426713
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbhJHJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238284AbhJHJrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:47:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B419660F93;
        Fri,  8 Oct 2021 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633686323;
        bh=QpB8vOphlNULoI8JHt6/RvQsOptTwkXGE84Cqe6nQrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=de86IhDbuFcUmVzyR3tO2XgI7h/lRvNT7qRpCZDyfgTRGZqMFb5qGFZHLmN3pOadl
         iQh9qvxPjZPaIpLPRHlaX0j8Xg5GQ/21fQYvv1RTzdCuQ2SjbUPJnBfFt+1i2JihrE
         Hs+kHDuX8nAVYrXys3qi+zyk/6EZKbR9lwNwsaez+VxD8vUc9f/x4w8etWebmr65AA
         MlE/ONz+G/k+FNvF4srtTZV+eZFvQ+XNLBL3ZCrWDvonw2Pd7BtZSGi2D1t9O+lm6o
         NqQ40tFIxnzToMGVcfgyv2QBj2x55ZACdFTZP3K742qmuF32E/eczxHV0nRLloYA3f
         kJ0/dQLE4bfoQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] selftests/damon: Test recording feature
Date:   Fri,  8 Oct 2021 09:45:08 +0000
Message-Id: <20211008094509.16179-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008094509.16179-1-sj@kernel.org>
References: <20211008094509.16179-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds selftests for the record feature of DAMON.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |   4 +-
 .../selftests/damon/_chk_dependency.sh        |   2 +-
 tools/testing/selftests/damon/_chk_record.py  | 109 ++++++++++++++++++
 .../testing/selftests/damon/debugfs_attrs.sh  |  15 +++
 .../testing/selftests/damon/debugfs_record.sh |  50 ++++++++
 5 files changed, 177 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/damon/_chk_record.py
 create mode 100755 tools/testing/selftests/damon/debugfs_record.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 8a3f2cd9fec0..cfd5393a4639 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for damon selftests
 
-TEST_FILES = _chk_dependency.sh
-TEST_PROGS = debugfs_attrs.sh
+TEST_FILES = _chk_dependency.sh _chk_record_file.py
+TEST_PROGS = debugfs_attrs.sh debugfs_record.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
index 0189db81550b..2ebea83164b7 100644
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -18,7 +18,7 @@ then
 	exit $ksft_skip
 fi
 
-for f in attrs target_ids monitor_on
+for f in attrs record target_ids monitor_on
 do
 	if [ ! -f "$DBGFS/$f" ]
 	then
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
index 639cfb6a1f65..63908a4c397b 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -57,6 +57,21 @@ test_write_fail "$file" "1 2 3 5 4" "$orig_content" \
 test_content "$file" "$orig_content" "1 2 3 4 5" "successfully written"
 echo "$orig_content" > "$file"
 
+# Test record file
+# ================
+
+file="$DBGFS/record"
+orig_content=$(cat "$file")
+
+test_write_succ "$file" "4242 foo.bar" "$orig_content" "valid input"
+test_write_fail "$file" "abc 2 3" "$orig_content" "too many fields"
+test_write_fail "$file" "123" "$orig_content" "not enough fields"
+test_content "$file" "$orig_content" "4242 foo.bar" "successfully written"
+test_write_succ "$file" "0 null" "$orig_content" "disabling"
+test_content "$file" "$orig_content" "0 null" "should disabled"
+test_write_succ "$file" "4242 foo.bar2" "$orig_content" "reenabling"
+echo "$orig_content" > "$file"
+
 # Test schemes file
 # =================
 
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

