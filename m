Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856D343F941
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhJ2IyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:54:10 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223]:31793 "EHLO
        esa9.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229844AbhJ2IyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:54:09 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Oct 2021 04:54:09 EDT
IronPort-SDR: Al2z8rGmCsGEDN/Rl6+Zv2XmBLQfMJC7MusWZg4QAeJ/r7FNrNbUUglgrBV5eCqTdWRKR+3qUs
 OrCRK7asx5Er3HzlW66wvZW/gpAz7a2H5y6+YtNOvpJIQcxDGz0/t3+kng3AoppOapiqyFkaWs
 8vpcOyJGH7w+fA39ufxZZ6ul9fmceF6o03IdZ4+NUBo9oL72sxPl6DpbabaoaeERQEZNEsX7B3
 PioKcVTiwYEuVXI6R/biSbQWq/1WAo8UjeoQtCCsvdhIybe5SJGJAY7pf/CxM5VWq8KwW1IKfP
 ykOmcTuZuzzftkLaesfEfLwn
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="38593036"
X-IronPort-AV: E=Sophos;i="5.87,192,1631545200"; 
   d="scan'208";a="38593036"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Oct 2021 17:44:28 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 73AE7EDC14
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 17:44:27 +0900 (JST)
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A8B9DD9609
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 17:44:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3051.s.css.fujitsu.com (Postfix) with ESMTP id 7829385;
        Fri, 29 Oct 2021 17:44:26 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, yamamoto.rei@jp.fujitsu.com
Subject: [PATCH] irq: consider cpus on nodes are unbalanced
Date:   Fri, 29 Oct 2021 17:27:30 +0900
Message-Id: <20211029082730.6728-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cpus on a node are offline at boot time, there are
difference in the number of nodes between when building affinity
masks for present cpus and when building affinity masks for possible
cpus. This patch fixes 2 problems caused by the difference of the
number of nodes:

 - If some unused vectors remain after building masks for present cpus,
   remained vectors are assigned for building masks for possible cpus.
   Therefore "numvecs <= nodes" condition must be
   "vecs_to_assign <= nodes_to_assign". Fix this problem by making this
   condition appropriate.

 - The routine of "numvecs <= nodes" condition can overwrite bits of
   masks for present cpus in building masks for possible cpus. Fix this
   problem by making CPU bits, which is not target, not changing.

Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
---
 kernel/irq/affinity.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f7ff8919dc9b..1cdf89e5e2fb 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -267,10 +267,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	 * If the number of nodes in the mask is greater than or equal the
 	 * number of vectors we just spread the vectors across the nodes.
 	 */
-	if (numvecs <= nodes) {
+	if (numvecs - (curvec - firstvec) <= nodes) {
 		for_each_node_mask(n, nodemsk) {
+			unsigned int ncpus;
+
+			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+			ncpus = cpumask_weight(nmsk);
+			if (!ncpus)
+				continue;
 			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
-				   node_to_cpumask[n]);
+				   nmsk);
 			if (++curvec == last_affv)
 				curvec = firstvec;
 		}
-- 
2.27.0

