Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7087345DD3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355850AbhKYPZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:25:06 -0500
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:35958 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355841AbhKYPXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:23:05 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id EDAB9BF085
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 15:19:52 +0000 (GMT)
Received: (qmail 25424 invoked from network); 25 Nov 2021 15:19:52 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 25 Nov 2021 15:19:52 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/2] Adjust NUMA imbalance for multiple LLCs
Date:   Thu, 25 Nov 2021 15:19:39 +0000
Message-Id: <20211125151941.8710-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
nodes") allowed an imbalance between NUMA nodes such that communicating
tasks would not be pulled apart by the load balancer. This works fine when
there is a 1:1 relationship between LLC and node but can be suboptimal
for multiple LLCs if independent tasks prematurely use CPUs sharing cache.

The series addresses two problems -- inconsistent use of scheduler domain
weights and sub-optimal performance when there are many LLCs per NUMA node.

 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 26 +++++++++++++++-----------
 kernel/sched/topology.c        | 24 ++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.31.1

