Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E446437443
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhJVJFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232521AbhJVJFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:05:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E109D61183;
        Fri, 22 Oct 2021 09:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634893401;
        bh=o2El5na/lWVXwxAvgNlBS2hL5ac6ibX0f87FAyS96nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iA5X6eg7CuzZjMM8FSvNCDXToX3iRbPR9lw9nRxWm2wh3vy3qudNKOAn3wgg2tkTT
         GAntfSI/PEbPN+r2kpLzFmCITFiEG538mQDM58RyXhrr6MoUHLjm41i3pVfke6zqj+
         tB3xVMuH5JAydZI1qEZ0hHnZi8Et5IJMWOg59nmGyAJLXhEWeyWMSGjEsJPptNNXq4
         oyPrFCA9a9ZS2eo1u1QF6ZYD6ikOAyT0TzhEFeU93IsEYv7cKo8atj/Js6Byhw8j01
         OrAD6BLMtPv16mezTqmjpYPgt6iNUTl37e3hRAva9OkKzQb8PwWF1W4n0krz5Qp1je
         gfOKDAyskXZjA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     peterx@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/4] Docs/admin-guide/mm/damon/start: Simplify the content
Date:   Fri, 22 Oct 2021 09:03:10 +0000
Message-Id: <20211022090311.3856-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022090311.3856-1-sj@kernel.org>
References: <20211022090311.3856-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Information in 'TL; DR' section of 'Getting Started' is duplicated in
other parts of the doc.  It is also asking readers to visit the access
pattern visualizations gallery web site to show the results of example
visualization commands, while the users of the commands can use terminal
output.

To make the doc simple, this commit removes the duplicated 'TL; DR'
section and replaces the visualization example commands with versions
using terminal outputs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 113 ++++++++++---------
 1 file changed, 60 insertions(+), 53 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index 5f3b22cafc76..4d5ca2c46288 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -11,38 +11,6 @@ of its features for brevity.  Please refer to the usage `doc
 details.
 
 
-TL; DR
-======
-
-Follow the commands below to monitor and visualize the memory access pattern of
-your workload. ::
-
-    # # build the kernel with CONFIG_DAMON_*=y, install it, and reboot
-    # mount -t debugfs none /sys/kernel/debug/
-    # git clone https://github.com/awslabs/damo
-    # ./damo/damo record $(pidof <your workload>)
-    # ./damo/damo report heats --heatmap stdout
-
-The final command draws the access heatmap of ``<your workload>``.  The heatmap
-shows which memory region (x-axis) is accessed when (y-axis) and how frequently
-(number; the higher the more accesses have been observed). ::
-
-    111111111111111111111111111111111111111111111111111111110000
-    111121111111111111111111111111211111111111111111111111110000
-    000000000000000000000000000000000000000000000000001555552000
-    000000000000000000000000000000000000000000000222223555552000
-    000000000000000000000000000000000000000011111677775000000000
-    000000000000000000000000000000000000000488888000000000000000
-    000000000000000000000000000000000177888400000000000000000000
-    000000000000000000000000000046666522222100000000000000000000
-    000000000000000000000014444344444300000000000000000000000000
-    000000000000000002222245555510000000000000000000000000000000
-    # access_frequency:  0  1  2  3  4  5  6  7  8  9
-    # x-axis: space (140286319947776-140286426374096: 101.496 MiB)
-    # y-axis: time (605442256436361-605479951866441: 37.695430s)
-    # resolution: 60x10 (1.692 MiB and 3.770s for each character)
-
-
 Prerequisites
 =============
 
@@ -93,22 +61,66 @@ pattern in the ``damon.data`` file.
 Visualizing Recorded Patterns
 =============================
 
-The following three commands visualize the recorded access patterns and save
-the results as separate image files. ::
-
-    $ sudo damo report heats --heatmap access_pattern_heatmap.png
-    $ sudo damo report wss --range 0 101 1 --plot wss_dist.png
-    $ sudo damo report wss --range 0 101 1 --sortby time --plot wss_chron_change.png
-
-- ``access_pattern_heatmap.png`` will visualize the data access pattern in a
-  heatmap, showing which memory region (y-axis) got accessed when (x-axis)
-  and how frequently (color).
-- ``wss_dist.png`` will show the distribution of the working set size.
-- ``wss_chron_change.png`` will show how the working set size has
-  chronologically changed.
-
-You can view the visualizations of this example workload at [1]_.
-Visualizations of other realistic workloads are available at [2]_ [3]_ [4]_.
+You can visualize the pattern in a heatmap, showing which memory region
+(x-axis) got accessed when (y-axis) and how frequently (number).::
+
+    $ sudo damo report heats --heatmap stdout
+    22222222222222222222222222222222222222211111111111111111111111111111111111111100
+    44444444444444444444444444444444444444434444444444444444444444444444444444443200
+    44444444444444444444444444444444444444433444444444444444444444444444444444444200
+    33333333333333333333333333333333333333344555555555555555555555555555555555555200
+    33333333333333333333333333333333333344444444444444444444444444444444444444444200
+    22222222222222222222222222222222222223355555555555555555555555555555555555555200
+    00000000000000000000000000000000000000288888888888888888888888888888888888888400
+    00000000000000000000000000000000000000288888888888888888888888888888888888888400
+    33333333333333333333333333333333333333355555555555555555555555555555555555555200
+    88888888888888888888888888888888888888600000000000000000000000000000000000000000
+    88888888888888888888888888888888888888600000000000000000000000000000000000000000
+    33333333333333333333333333333333333333444444444444444444444444444444444444443200
+    00000000000000000000000000000000000000288888888888888888888888888888888888888400
+    [...]
+    # access_frequency:  0  1  2  3  4  5  6  7  8  9
+    # x-axis: space (139728247021568-139728453431248: 196.848 MiB)
+    # y-axis: time (15256597248362-15326899978162: 1 m 10.303 s)
+    # resolution: 80x40 (2.461 MiB and 1.758 s for each character)
+
+You can also visualize the distribution of the working set size, sorted by the
+size.::
+
+    $ sudo damo report wss --range 0 101 10
+    # <percentile> <wss>
+    # target_id     18446632103789443072
+    # avr:  107.708 MiB
+      0             0 B |                                                           |
+     10      95.328 MiB |****************************                               |
+     20      95.332 MiB |****************************                               |
+     30      95.340 MiB |****************************                               |
+     40      95.387 MiB |****************************                               |
+     50      95.387 MiB |****************************                               |
+     60      95.398 MiB |****************************                               |
+     70      95.398 MiB |****************************                               |
+     80      95.504 MiB |****************************                               |
+     90     190.703 MiB |*********************************************************  |
+    100     196.875 MiB |***********************************************************|
+
+Using ``--sortby`` option with the above command, you can show how the working
+set size has chronologically changed.::
+
+    $ sudo damo report wss --range 0 101 10 --sortby time
+    # <percentile> <wss>
+    # target_id     18446632103789443072
+    # avr:  107.708 MiB
+      0       3.051 MiB |                                                           |
+     10     190.703 MiB |***********************************************************|
+     20      95.336 MiB |*****************************                              |
+     30      95.328 MiB |*****************************                              |
+     40      95.387 MiB |*****************************                              |
+     50      95.332 MiB |*****************************                              |
+     60      95.320 MiB |*****************************                              |
+     70      95.398 MiB |*****************************                              |
+     80      95.398 MiB |*****************************                              |
+     90      95.340 MiB |*****************************                              |
+    100      95.398 MiB |*****************************                              |
 
 
 Data Access Pattern Aware Memory Management
@@ -120,8 +132,3 @@ accessed for >=60 seconds in your workload to be swapped out. ::
     $ echo "#min-size max-size min-acc max-acc min-age max-age action" > test_scheme
     $ echo "4K        max      0       0       60s     max     pageout" >> test_scheme
     $ damo schemes -c test_scheme <pid of your workload>
-
-.. [1] https://damonitor.github.io/doc/html/v17/admin-guide/mm/damon/start.html#visualizing-recorded-patterns
-.. [2] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.1.png.html
-.. [3] https://damonitor.github.io/test/result/visual/latest/rec.wss_sz.png.html
-.. [4] https://damonitor.github.io/test/result/visual/latest/rec.wss_time.png.html
-- 
2.17.1

