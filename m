Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB243CFA73
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbhGTMjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238491AbhGTMeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:34:10 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81721C061574;
        Tue, 20 Jul 2021 06:14:48 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id w26so15272158qto.9;
        Tue, 20 Jul 2021 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2KUp38YsvXkumqr3XMuR3ixgpLpciARDVQEewv37dA8=;
        b=aVQsoNLLEUlYbW+7TK5d9IdEAm0+426B5ooqKpDUWLQ2TcGYH7ou17/g1YRTRu/aka
         YTJWjWj6qDwXdawDVTviUeJQu52HZWmqH0NOk44qkCsRqAFSJsS2MYYsVggAhO2t9Bli
         kzYNZh1IluvcnsyTK4G4fYElr3eaOtKlzHdZ0EgM4WpzolPUZc+pSuAFmHP6XrWrANzd
         6EXpFYhVy40duZvLFmFqyeY2YKEoKWZ6aGU+1N6PzQ95pH9XKZvBRABfa0iA74cCeu07
         cqHnhigqXEPCpeRR2Qtcy+hhGTPKCMs2iMYZICwXFtDntdmqn+8VI9GrBeqP96mlVWYN
         +nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2KUp38YsvXkumqr3XMuR3ixgpLpciARDVQEewv37dA8=;
        b=HlBX+F612GrirxaAT3Kqd/xcwKH7N+reKhvG4L76WoX2Xohyt6nT+UBH3ZI0SHlwmi
         GnoXbdqtz6YZxJT0JyauZdSQgOj/hPVWiCL3DYvDqym8FVo3/I3/+dMqOeYxsD6YfhUO
         c8ZwzZFhX5wmW1Dh/53KhnR3Wouk87zvK4t2gVzVsiKWQ79r6AvESghQmX3CR7fIJJqw
         uw+BH4n+seRWlAEL8lLz6Ptmw4PGWpT/btaGcRjQeeJdB8orvfnuUwZT2IFqJAfJfcTn
         ruihiKx2Ej4RXd7vBlU5AgUh9Ih705/gr9kf4uuyHF4DWlNH5eOjBD6H0a+sS1r6QN/w
         RNHQ==
X-Gm-Message-State: AOAM532DJjiYYlZxqH7fwur9CCosR5tpGofx23cvu4ZOF1rFTCyewB7/
        Z7XYc07lFCUnQta3Icwvivg=
X-Google-Smtp-Source: ABdhPJzOM11CvnWbx/+kPZxTtC4it9bcXXkHiOXCvsRsm1pi23w+6aTKOCIzymxrnG2/6q33limkdw==
X-Received: by 2002:ac8:7f07:: with SMTP id f7mr25963209qtk.120.1626786887598;
        Tue, 20 Jul 2021 06:14:47 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:47 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 15/15] Documentation/admin-guide/mm/damon: Add a document for DAMON_RECLAIM
Date:   Tue, 20 Jul 2021 13:13:09 +0000
Message-Id: <20210720131309.22073-16-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds an admin-guide document for DAMON-based Reclamation.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/index.rst  |   1 +
 .../admin-guide/mm/damon/reclaim.rst          | 233 ++++++++++++++++++
 2 files changed, 234 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/damon/reclaim.rst

diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index 8c5dde3a5754..61aff88347f3 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -13,3 +13,4 @@ optimize those.
 
    start
    usage
+   reclaim
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
new file mode 100644
index 000000000000..1f4ad79919ca
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -0,0 +1,233 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+DAMON-based Reclamation
+=======================
+
+DAMON-based Reclamation (DAMON_RECLAIM) is a static kernel module that aimed to
+be used for proactive and lightweight reclamation under light memory pressure.
+It doesn't aim to replace the LRU-list based page_granularity reclamation, but
+to be selectively used for different level of memory pressure and requirements.
+
+Where Proactive Reclamation is Required?
+========================================
+
+On general memory over-committed systems, proactively reclaiming cold pages
+helps saving memory and reducing latency spikes that incurred by the direct
+reclaim of the process or CPU consumption of kswapd, while incurring only
+minimal performance degradation [1]_ [2]_ .
+
+Free Pages Reporting [3]_ based memory over-commit virtualization systems are
+good example of the cases.  In such systems, the guest VMs reports their free
+memory to host, and the host reallocates the reported memory to other guests.
+As a result, the memory of the systems are fully utilized.  However, the
+guests could be not so memory-frugal, mainly because some kernel subsystems and
+user-space applications are designed to use as much memory as available.  Then,
+guests could report only small amount of memory as free to host, results in
+memory utilization drop of the systems.  Running the proactive reclamation in
+guests could mitigate this problem.
+
+How It Works?
+=============
+
+DAMON_RECLAIM finds memory regions that didn't accessed for specific time
+duration and page out.  To avoid it consuming too much CPU for the paging out
+operation, a speed limit can be configured.  Under the speed limit, it pages
+out memory regions that didn't accessed longer time first.  System
+administrators can also configure under what situation this scheme should
+automatically activated and deactivated with three memory pressure watermarks.
+
+Interface: Module Parameters
+============================
+
+To use this feature, you should first ensure your system is running on a kernel
+that is built with ``CONFIG_DAMON_RECLAIM=y``.
+
+To let sysadmins enable or disable it and tune for the given system,
+DAMON_RECLAIM utilizes module parameters.  That is, you can put
+``damon_reclaim.<parameter>=<value>`` on the kernel boot command line or write
+proper values to ``/sys/modules/damon_reclaim/parameters/<parameter>`` files.
+
+Note that the parameter values except ``enabled`` are applied only when
+DAMON_RECLAIM starts.  Therefore, if you want to apply new parameter values in
+runtime and DAMON_RECLAIM is already enabled, you should disable and re-enable
+it via ``enabled`` parameter file.  Writing of the new values to proper
+parameter values should be done before the re-enablement.
+
+Below are the description of each parameter.
+
+enabled
+-------
+
+Enable or disable DAMON_RECLAIM.
+
+You can enable DAMON_RCLAIM by setting the value of this parameter as ``Y``.
+Setting it as ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could do
+no real monitoring and reclamation due to the watermarks-based activation
+condition.  Refer to below descriptions for the watermarks parameter for this.
+
+min_age
+-------
+
+Time threshold for cold memory regions identification in microseconds.
+
+If a memory region is not accessed for this or longer time, DAMON_RECLAIM
+identifies the region as cold, and reclaims it.
+
+quota_ms
+--------
+
+Limit of time for the reclamation in milliseconds.
+
+DAMON_RECLAIM tries to use only up to this time within a time window
+(quota_reset_interval_ms) for trying reclamation of cold pages.  This can be
+used for limiting CPU consumption of DAMON_RECLAIM.  If the value is zero, the
+limit is disabled.
+
+100 ms by default.
+
+quota_sz
+--------
+
+Limit of size of memory for the reclamation in bytes.
+
+DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
+window (quota_reset_interval_ms) and makes no more than this limit is tried.
+This can be used for limiting consumption of CPU and IO.  If this value is
+zero, the limit is disabled.
+
+1 GiB by default.
+
+quota_reset_interval_ms
+-----------------------
+
+The time/size quota charge reset interval in milliseconds.
+
+The charget reset interval for the quota of time (quota_ms) and size
+(quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
+quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
+milliseconds.
+
+1 second by default.
+
+wmarks_interval
+---------------
+
+Minimal time to wait before checking the watermarks, when DAMON_RECLAIM is
+enabled but inactive due to its watermarks rule.
+
+wmarks_high
+-----------
+
+Free memory rate (per thousand) for the high watermark.
+
+If free memory of the system in bytes per thousand bytes is higher than this,
+DAMON_RECLAIM becomes inactive, so it does nothing but only periodically checks
+the watermarks.
+
+wmarks_mid
+----------
+
+Free memory rate (per thousand) for the middle watermark.
+
+If free memory of the system in bytes per thousand bytes is between this and
+the low watermark, DAMON_RECLAIM becomes active, so starts the monitoring and
+the reclaiming.
+
+wmarks_low
+----------
+
+Free memory rate (per thousand) for the low watermark.
+
+If free memory of the system in bytes per thousand bytes is lower than this,
+DAMON_RECLAIM becomes inactive, so it does nothing but periodically checks the
+watermarks.  In the case, the system falls back to the LRU-list based page
+granularity reclamation logic.
+
+sample_interval
+---------------
+
+Sampling interval for the monitoring in microseconds.
+
+The sampling interval of DAMON for the cold memory monitoring.  Please refer to
+the DAMON documentation (:doc:`usage`) for more detail.
+
+aggr_interval
+-------------
+
+Aggregation interval for the monitoring in microseconds.
+
+The aggregation interval of DAMON for the cold memory monitoring.  Please
+refer to the DAMON documentation (:doc:`usage`) for more detail.
+
+min_nr_regions
+--------------
+
+Minimum number of monitoring regions.
+
+The minimal number of monitoring regions of DAMON for the cold memory
+monitoring.  This can be used to set lower-bound of the monitoring quality.
+But, setting this too high could result in increased monitoring overhead.
+Please refer to the DAMON documentation (:doc:`usage`) for more detail.
+
+max_nr_regions
+--------------
+
+Maximum number of monitoring regions.
+
+The maximum number of monitoring regions of DAMON for the cold memory
+monitoring.  This can be used to set upper-bound of the monitoring overhead.
+However, setting this too low could result in bad monitoring quality.  Please
+refer to the DAMON documentation (:doc:`usage`) for more detail.
+
+monitor_region_start
+--------------------
+
+Start of target memory region in physical address.
+
+The start physical address of memory region that DAMON_RECLAIM will do work
+against.  That is, DAMON_RECLAIM will find cold memory regions in this region
+and reclaims.  By default, biggest System RAM is used as the region.
+
+monitor_region_end
+------------------
+
+End of target memory region in physical address.
+
+The end physical address of memory region that DAMON_RECLAIM will do work
+against.  That is, DAMON_RECLAIM will find cold memory regions in this region
+and reclaims.  By default, biggest System RAM is used as the region.
+
+kdamond_pid
+-----------
+
+PID of the DAMON thread.
+
+If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.  Else,
+-1.
+
+Example
+=======
+
+Below runtime example commands make DAMON_RECLAIM to find memory regions that
+not accessed for 30 seconds or more and pages out.  The reclamation is limited
+to be done only up to 1 GiB per second to avoid DAMON_RECLAIM consuming too
+much CPU time for the paging out operation.  It also asks DAMON_RECLAIM to do
+nothing if the system's free memory rate is more than 50%, but start the real
+works if it becomes lower than 40%.  If DAMON_RECLAIM doesn't make progress and
+therefore the free memory rate becomes lower than 20%, it asks DAMON_RECLAIM to
+do nothing again, so that we can fall back to the LRU-list based page
+granularity reclamation. ::
+
+    # cd /sys/modules/damon_reclaim/parameters
+    # echo 30000000 > min_age
+    # echo $((1 * 1024 * 1024 * 1024)) > quota_sz
+    # echo 1000 > quota_reset_interval_ms
+    # echo 500 > wmarks_high
+    # echo 400 > wmarks_mid
+    # echo 200 > wmarks_low
+    # echo Y > enabled
+
+.. [1] https://research.google/pubs/pub48551/
+.. [2] https://lwn.net/Articles/787611/
+.. [3] https://www.kernel.org/doc/html/latest/vm/free_page_reporting.html
-- 
2.17.1

