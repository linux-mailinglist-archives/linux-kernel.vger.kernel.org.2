Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE1A330A46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCHJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:27:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13866 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCHJ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:27:23 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DvCcb5M8Wz8tyT;
        Mon,  8 Mar 2021 17:25:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Mar 2021 17:27:13 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <yangyicong@hisilicon.com>
Subject: [PATCH] sched/topology: Fix a typo in pr_err()
Date:   Mon, 8 Mar 2021 17:24:56 +0800
Message-ID: <1615195496-13980-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo 'borken' to 'broken' in pr_err().

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 09d3504..c42e388 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1906,7 +1906,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 
 		if (!cpumask_subset(sched_domain_span(child),
 				    sched_domain_span(sd))) {
-			pr_err("BUG: arch topology borken\n");
+			pr_err("BUG: arch topology broken\n");
 #ifdef CONFIG_SCHED_DEBUG
 			pr_err("     the %s domain not a subset of the %s domain\n",
 					child->name, sd->name);
-- 
2.8.1

