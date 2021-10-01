Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8CA41EDF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353676AbhJAM6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354417AbhJAM6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:58:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 776F860F41;
        Fri,  1 Oct 2021 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092996;
        bh=6jdDpNw+ejDlTJ+/f9GYU6iAwLrn82qyI/um3a8PjZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jb3I9G/GvCsFTVach3cgiPySw91zs/3YBIwnn83VdbME6FFdn+p6o7K5lkgu3bPc9
         +AbMo9u9PvkF6F5kEmMQ4ny3aD2P+P4elNE5vfiyWKDEme88Gf18xKMomwPxWOA2YD
         DJrB06BUnKOMGhluH0ko7mnedFO7YJqufUTmA5fY67SlYtnK974jutG792BMTfcMIT
         UvWrSf3qn8yPqF5l9HdHM8R7A5hETBF/HnRtRTrb8JoYeX8w0fshEVkogQDVtTV37N
         Cj6R1Y+9jkOJQFS2D+udEWbfhBx2ScDhy6/KCoz+uEUblNkGLN3f6zc+7YmuPWIwxS
         EFbQ1PEQAnNyQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] Docs/admin-guide/mm/damon: Document DAMON-based Operation Schemes
Date:   Fri,  1 Oct 2021 12:56:04 +0000
Message-Id: <20211001125604.29660-8-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001125604.29660-1-sj@kernel.org>
References: <20211001125604.29660-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit add description of DAMON-based operation schemes in the
DAMON documents.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 11 +++++
 Documentation/admin-guide/mm/damon/usage.rst | 51 +++++++++++++++++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index 9b313a66298d..e6a6d8ba51c3 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -108,6 +108,17 @@ the results as separate image files. ::
 You can show the images in a web page [1]_ .  Those made with other realistic
 workloads are also available [2]_ [3]_ [4]_.
 
+
+Data Access Pattern Aware Memory Management
+===========================================
+
+Below three commands make every memory region of size >=4K that doesn't
+accessed for >=60 seconds in your workload to be swapped out. ::
+
+    $ echo "#min-size max-size min-acc max-acc min-age max-age action" > scheme
+    $ echo "4K        max      0       0       60s     max     pageout" >> scheme
+    $ damo schemes -c my_thp_scheme <pid of your workload>
+
 .. [1] https://damonitor.github.io/doc/html/v17/admin-guide/mm/damon/start.html#visualizing-recorded-patterns
 .. [2] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.1.png.html
 .. [3] https://damonitor.github.io/test/result/visual/latest/rec.wss_sz.png.html
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index a72cda374aba..c0296c14babf 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -34,8 +34,8 @@ the reason, this document describes only the debugfs interface
 debugfs Interface
 =================
 
-DAMON exports three files, ``attrs``, ``target_ids``, and ``monitor_on`` under
-its debugfs directory, ``<debugfs>/damon/``.
+DAMON exports four files, ``attrs``, ``target_ids``, ``schemes`` and
+``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
 
 
 Attributes
@@ -74,6 +74,53 @@ check it again::
 Note that setting the target ids doesn't start the monitoring.
 
 
+Schemes
+-------
+
+For usual DAMON-based data access aware memory management optimizations, users
+would simply want the system to apply a memory management action to a memory
+region of a specific size having a specific access frequency for a specific
+time.  DAMON receives such formalized operation schemes from the user and
+applies those to the target processes.  It also counts the total number and
+size of regions that each scheme is applied.  This statistics can be used for
+online analysis or tuning of the schemes.
+
+Users can get and set the schemes by reading from and writing to ``schemes``
+debugfs file.  Reading the file also shows the statistics of each scheme.  To
+the file, each of the schemes should be represented in each line in below form:
+
+    min-size max-size min-acc max-acc min-age max-age action
+
+Note that the ranges are closed interval.  Bytes for the size of regions
+(``min-size`` and ``max-size``), number of monitored accesses per aggregate
+interval for access frequency (``min-acc`` and ``max-acc``), number of
+aggregate intervals for the age of regions (``min-age`` and ``max-age``), and a
+predefined integer for memory management actions should be used.  The supported
+numbers and their meanings are as below.
+
+ - 0: Call ``madvise()`` for the region with ``MADV_WILLNEED``
+ - 1: Call ``madvise()`` for the region with ``MADV_COLD``
+ - 2: Call ``madvise()`` for the region with ``MADV_PAGEOUT``
+ - 3: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``
+ - 4: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``
+ - 5: Do nothing but count the statistics
+
+You can disable schemes by simply writing an empty string to the file.  For
+example, below commands applies a scheme saying "If a memory region of size in
+[4KiB, 8KiB] is showing accesses per aggregate interval in [0, 5] for aggregate
+interval in [10, 20], page out the region", check the entered scheme again, and
+finally remove the scheme. ::
+
+    # cd <debugfs>/damon
+    # echo "4096 8192    0 5    10 20    2" > schemes
+    # cat schemes
+    4096 8192 0 5 10 20 2 0 0
+    # echo > schemes
+
+The last two integers in the 4th line of above example is the total number and
+the total size of the regions that the scheme is applied.
+
+
 Turning On/Off
 --------------
 
-- 
2.17.1

