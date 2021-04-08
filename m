Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08A235844C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhDHNMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:12:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16098 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhDHNMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:12:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGM7j4Pfsz19L9X;
        Thu,  8 Apr 2021 21:10:25 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:12:30 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Peng Wu <wupeng58@huawei.com>
Subject: [PATCH -next] sched/topology: Make some symbols static
Date:   Thu, 8 Apr 2021 21:12:17 +0800
Message-ID: <1617887537-38438-1-git-send-email-wupeng58@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

kernel/sched/topology.c:211:1: warning:
 symbol 'sched_energy_mutex' was not declared. Should it be static?
kernel/sched/topology.c:212:6: warning:
 symbol 'sched_energy_update' was not declared. Should it be static?

This symbol is not used outside of topology.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d1aec244c027..25c3f88d43cd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -208,8 +208,8 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 unsigned int sysctl_sched_energy_aware = 1;
-DEFINE_MUTEX(sched_energy_mutex);
-bool sched_energy_update;
+static DEFINE_MUTEX(sched_energy_mutex);
+static bool sched_energy_update;
 
 void rebuild_sched_domains_energy(void)
 {

