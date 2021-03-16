Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767B933CCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhCPEuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:50:39 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35464 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231156AbhCPEuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:50:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0US4yKV6_1615870218;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0US4yKV6_1615870218)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 12:50:18 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     changhuaixin@linux.alibaba.com
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com,
        peterz@infradead.org, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: [PATCH v4 4/4] sched/fair: Add document for burstable CFS bandwidth control
Date:   Tue, 16 Mar 2021 12:49:31 +0800
Message-Id: <20210316044931.39733-5-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basic description of usage and effect for CFS Bandwidth Control Burst.

Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 16 +++++----
 Documentation/scheduler/sched-bwc.rst   | 64 ++++++++++++++++++++++++++++++---
 2 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 64c62b979f2f..17ec571ab4a8 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -997,6 +997,8 @@ All time durations are in microseconds.
 	- nr_periods
 	- nr_throttled
 	- throttled_usec
+	- nr_burst
+	- burst_usec
 
   cpu.weight
 	A read-write single value file which exists on non-root
@@ -1017,16 +1019,18 @@ All time durations are in microseconds.
 	the closest approximation of the current weight.
 
   cpu.max
-	A read-write two value file which exists on non-root cgroups.
-	The default is "max 100000".
+	A read-write three value file which exists on non-root cgroups.
+	The default is "max 100000 0".
 
 	The maximum bandwidth limit.  It's in the following format::
 
-	  $MAX $PERIOD
+	  $MAX $PERIOD $BURST
 
-	which indicates that the group may consume upto $MAX in each
-	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
-	one number is written, $MAX is updated.
+	which indicates that the group may consume upto $MAX from this
+	period plus $BURST carried over from previous periods in each
+	$PERIOD duration.  "max" for $MAX indicates no limit. "0" for
+	$BURST indicates no bandwidth can be carried over. On partial
+	writing, values are updated accordingly.
 
   cpu.pressure
 	A read-write nested-keyed file.
diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 845eee659199..42e0773c0eed 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -22,24 +22,51 @@ cfs_quota units at each period boundary. As threads consume this bandwidth it
 is transferred to cpu-local "silos" on a demand basis. The amount transferred
 within each of these updates is tunable and described as the "slice".
 
+By default, CPU bandwidth consumption is strictly limited to quota within each
+given period. For the sequence of CPU usage u_i served under CFS bandwidth
+control, if for any j <= k N(j,k) is the number of periods from u_j to u_k:
+
+        u_j+...+u_k <= quota * N(j,k)
+
+For a bursty sequence among which interval u_j...u_k are at the peak, CPU
+requests might have to wait for more periods to replenish enough quota.
+Otherwise, larger quota is required.
+
+With "burst" buffer, CPU requests might be served as long as:
+
+        u_j+...+u_k <= B_j + quota * N(j,k)
+
+if for any j <= k N(j,k) is the number of periods from u_j to u_k and B_j is
+the accumulated quota from previous periods in burst buffer serving u_j.
+Burst buffer helps in that serving whole bursty CPU requests without throttling
+them can be done with moderate quota setting and accumulated quota in burst
+buffer, if:
+
+        u_0+...+u_n <= B_0 + quota * N(0,n)
+
+where B_0 is the initial state of burst buffer. The maximum accumulated quota in
+the burst buffer is capped by burst. With proper burst setting, the available
+bandwidth is still determined by quota and period on the long run.
+
 Management
 ----------
-Quota and period are managed within the cpu subsystem via cgroupfs.
+Quota, period and burst are managed within the cpu subsystem via cgroupfs.
 
 .. note::
    The cgroupfs files described in this section are only applicable
    to cgroup v1. For cgroup v2, see
    :ref:`Documentation/admin-guide/cgroupv2.rst <cgroup-v2-cpu>`.
 
-- cpu.cfs_quota_us: the total available run-time within a period (in
-  microseconds)
+- cpu.cfs_quota_us: run-time replenished within a period (in microseconds)
 - cpu.cfs_period_us: the length of a period (in microseconds)
 - cpu.stat: exports throttling statistics [explained further below]
+- cpu.cfs_burst_us: the maximum accumulated run-time (in microseconds)
 
 The default values are::
 
 	cpu.cfs_period_us=100ms
-	cpu.cfs_quota=-1
+	cpu.cfs_quota_us=-1
+	cpu.cfs_burst_us=0
 
 A value of -1 for cpu.cfs_quota_us indicates that the group does not have any
 bandwidth restriction in place, such a group is described as an unconstrained
@@ -55,6 +82,11 @@ more detail below.
 Writing any negative value to cpu.cfs_quota_us will remove the bandwidth limit
 and return the group to an unconstrained state once more.
 
+A value of 0 for cpu.cfs_burst_us indicates that the group can not accumulate
+any unused bandwidth. It makes the traditional bandwidth control behavior for
+CFS unchanged. Writing any (valid) positive value(s) into cpu.cfs_burst_us
+will enact the cap on unused bandwidth accumulation.
+
 Any updates to a group's bandwidth specification will result in it becoming
 unthrottled if it is in a constrained state.
 
@@ -72,9 +104,15 @@ This is tunable via procfs::
 Larger slice values will reduce transfer overheads, while smaller values allow
 for more fine-grained consumption.
 
+There is also a global switch to turn off burst for all groups::
+       /proc/sys/kernel/sched_cfs_bw_burst_enabled (default=1)
+
+By default it is enabled. Writing a 0 value means no accumulated CPU time can be
+used for any group, even if cpu.cfs_burst_us is configured.
+
 Statistics
 ----------
-A group's bandwidth statistics are exported via 3 fields in cpu.stat.
+A group's bandwidth statistics are exported via 6 fields in cpu.stat.
 
 cpu.stat:
 
@@ -82,6 +120,10 @@ cpu.stat:
 - nr_throttled: Number of times the group has been throttled/limited.
 - throttled_time: The total time duration (in nanoseconds) for which entities
   of the group have been throttled.
+- nr_burst: Number of periods burst occurs.
+- burst_time: Cumulative wall-time that any CPUs has used above quota in
+  respective periods
+
 
 This interface is read-only.
 
@@ -179,3 +221,15 @@ Examples
 
    By using a small period here we are ensuring a consistent latency
    response at the expense of burst capacity.
+
+4. Limit a group to 20% of 1 CPU, and allow accumulate up to 60% of 1 CPU
+   additionally, in case accumulation has been done.
+
+   With 50ms period, 10ms quota will be equivalent to 20% of 1 CPU.
+   And 30ms burst will be equivalent to 60% of 1 CPU.
+
+	# echo 10000 > cpu.cfs_quota_us /* quota = 10ms */
+	# echo 50000 > cpu.cfs_period_us /* period = 50ms */
+	# echo 30000 > cpu.cfs_burst_us /* burst = 30ms */
+
+   Larger buffer setting allows greater burst capacity.
-- 
2.14.4.44.g2045bb6

