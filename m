Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74839F5C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhFHL46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:56:58 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:45870 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhFHL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:56:48 -0400
Received: by mail-qt1-f174.google.com with SMTP id l17so10853709qtq.12;
        Tue, 08 Jun 2021 04:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJTwc2+8OmVO0WYs0LS9qDVADcgdZ32QIgWE+KhO6qY=;
        b=Ed5PIja2L89hTEZqu5p9+ymg2BMEhGDZZ1DfUAX1zG4emZcFOuPPjaUF7Rg6Oq4yZ1
         Bspb2FZhAzvQMP1K6Ecmsv+Yba8KIxnjz/eW73Jgf0JL81xq5iztd86lXEBm21A+8bYf
         E3IGDYaBcXVJKr5jEc9fPBh9+Pr8VUkWsRDwdSeVul6n3PVOP88PX/sDRCijZ/ok6J6O
         /zZwsDZIBDqVwA7+pncCkr/fPE0DbEgBGcqC+tJPjhZReHvs/+QoFFeybt/8F0LNnHj/
         mvjGiGd5H047N4ckB/IqIyM630FO2IFGOq+o/kU2IfpJd7lvfWNLwpdIW/jqONIEMOyN
         MYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pJTwc2+8OmVO0WYs0LS9qDVADcgdZ32QIgWE+KhO6qY=;
        b=P7O4NGs89yD/7xf+WRL9F/HCPmKHYDq0qj6V0khatqETB69oh9NMg5/6ni5ODuZy5s
         mES+aKOMeKXB30Z/WgT77gkpldVlbhnn3b1SJOwIPBDhz8oPSuRp3d+HLT+aLvjcp8u0
         LbBnGpSQy2JCHq6XrrA7BhMz/Pd1vdQ5PjxzjvvHlIQtKqGETkDgcJAp6dSTQiSCdU5S
         C+YNCTlosF5zYngm+7/YOPWZH9CqNVjSuifPHHDpT2MZExPU/l0ml1dxsnuzgEPBSN1g
         XBiI6gCwZL0BI+LjMqYxB3PIGOeZ4AAWPCBbK36XcNUo7I0+ceOgjiujAOEoeBS9vLF2
         Stdg==
X-Gm-Message-State: AOAM533icG7Vbg2kiwDNUNJlDfeWGQxKZ/Zcr7OOAMDDkjCufRQj5ISC
        cLn+QfLX61V/L0bVyAuVyZ4=
X-Google-Smtp-Source: ABdhPJyqXfjoMNVb/P2WbZokEeqnYl1dmsZF5orqEbrbRbGD7efJeeKKimDTO5AEr2MfND2mDEzgTw==
X-Received: by 2002:ac8:67c2:: with SMTP id r2mr6361570qtp.131.1623153222062;
        Tue, 08 Jun 2021 04:53:42 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h4sm2133927qth.66.2021.06.08.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:53:41 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 14/14] Documentation/admin-guide/mm/damon: Add a document for DAMON_RECLAIM
Date:   Tue,  8 Jun 2021 11:52:54 +0000
Message-Id: <20210608115254.11930-15-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608115254.11930-1-sj38.park@gmail.com>
References: <20210608115254.11930-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds an admin-guide document for DAMON-based Reclamation.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/index.rst  |   1 +
 .../admin-guide/mm/damon/reclaim.rst          | 211 ++++++++++++++++++
 2 files changed, 212 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/damon/reclaim.rst

diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index 0baae7a5402b..e5b4da13f60b 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -13,3 +13,4 @@ Using this, users can analyze and optimize their systems.
    start
    guide
    usage
+   reclaim
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
new file mode 100644
index 000000000000..b4fe0c16f72e
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -0,0 +1,211 @@
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
+limit_sz
+--------
+
+Maximum bytes of memory that can be reclaimed in a charging window.
+
+DAMON_RECLAIM counts amount of memory which has reclaimed within current
+charging time window and avoids reclaiming more than this limit in current time
+window.  This could be useful for limiting CPU consumption of DAMON_RECLAIM.
+
+limit_ms
+--------
+
+The reclaimed memory charging window in milliseconds.
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
+    # echo $((1 * 1024 * 1024 * 1024)) > limit_sz
+    # echo 1000 > limit_ms
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

