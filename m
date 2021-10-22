Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6251E437440
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhJVJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232448AbhJVJFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:05:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EA5D61163;
        Fri, 22 Oct 2021 09:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634893398;
        bh=OkzRP2etOM84DmGdDzDCdPmrOdQc3nNLDRppJQreb7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFmfWaIcuMDsNJL+vD2Jaz/HzP+HxsaIfG3loLLf+PPQG6xPHFKZ7X5ECAFXWkeuc
         AbgQt8oAmkR1SqAO0cRapjMERqm8/tNr6MTVStXYQuiLcUrUrlg9JeBUG5sG2F8qqC
         19zqb2WCoNUFzICb1Z/978D0dTUTEd8eaM0077CniezMbLgt+UTi+KBGy7pzveVZH3
         FF/b10dwmZAhBmQ/irGW+FY/XMp0rd85OBzrEiIF5gCnO08RHfGfLhVnW1EZsVEQyW
         tz5QkRHuQKD8CTcfZv+amkq5O1SpHyf9/DsbNwJ5x39774+yl48PWtFR3MIx+TVTa+
         QWomLmLbZoM+w==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     peterx@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/4] Docs/admin-guide/mm/damon/start: Fix wrong example commands
Date:   Fri, 22 Oct 2021 09:03:08 +0000
Message-Id: <20211022090311.3856-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022090311.3856-1-sj@kernel.org>
References: <20211022090311.3856-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the example commands in DAMON getting started guide are
outdated, missing sudo, or just wrong.  This commit fixes those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index 51503cf90ca2..3ad8bbed9b18 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -19,7 +19,7 @@ your workload. ::
     # mount -t debugfs none /sys/kernel/debug/
     # git clone https://github.com/awslabs/damo
     # ./damo/damo record $(pidof <your workload>)
-    # ./damo/damo report heat --plot_ascii
+    # ./damo/damo report heats --heatmap stdout
 
 The final command draws the access heatmap of ``<your workload>``.  The heatmap
 shows which memory region (x-axis) is accessed when (y-axis) and how frequently
@@ -94,9 +94,9 @@ Visualizing Recorded Patterns
 The following three commands visualize the recorded access patterns and save
 the results as separate image files. ::
 
-    $ damo report heats --heatmap access_pattern_heatmap.png
-    $ damo report wss --range 0 101 1 --plot wss_dist.png
-    $ damo report wss --range 0 101 1 --sortby time --plot wss_chron_change.png
+    $ sudo damo report heats --heatmap access_pattern_heatmap.png
+    $ sudo damo report wss --range 0 101 1 --plot wss_dist.png
+    $ sudo damo report wss --range 0 101 1 --sortby time --plot wss_chron_change.png
 
 - ``access_pattern_heatmap.png`` will visualize the data access pattern in a
   heatmap, showing which memory region (y-axis) got accessed when (x-axis)
@@ -115,9 +115,9 @@ Data Access Pattern Aware Memory Management
 Below three commands make every memory region of size >=4K that doesn't
 accessed for >=60 seconds in your workload to be swapped out. ::
 
-    $ echo "#min-size max-size min-acc max-acc min-age max-age action" > scheme
-    $ echo "4K        max      0       0       60s     max     pageout" >> scheme
-    $ damo schemes -c my_thp_scheme <pid of your workload>
+    $ echo "#min-size max-size min-acc max-acc min-age max-age action" > test_scheme
+    $ echo "4K        max      0       0       60s     max     pageout" >> test_scheme
+    $ damo schemes -c test_scheme <pid of your workload>
 
 .. [1] https://damonitor.github.io/doc/html/v17/admin-guide/mm/damon/start.html#visualizing-recorded-patterns
 .. [2] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.1.png.html
-- 
2.17.1

