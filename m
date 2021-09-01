Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451103FD2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbhIAFMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:12:46 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15279 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhIAFMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:12:45 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gzsbc6T5vz8Cq2;
        Wed,  1 Sep 2021 13:11:24 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 13:11:46 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 13:11:46 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <peterz@infradead.org>, <valentin.schneider@arm.com>,
        <mingo@kernel.org>, <tglx@linutronix.de>, <bigeasy@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [RFC] cpu/hotplug: allow the cpu in UP_PREPARE state to bringup again
Date:   Wed, 1 Sep 2021 13:11:43 +0800
Message-ID: <20210901051143.2752-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu's cpu_hotplug_state will be set to CPU_UP_PREPARE before
the cpu is waken up, but it won't be reset when the failure occurs.
Then the user cannot to make the cpu online anymore, because the
CPU_UP_PREPARE state makes cpu_check_up_prepare() unhappy.

We should allow the user to try again in this case.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 kernel/smpboot.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index f6bc0bc..d18f8ff 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -392,6 +392,13 @@ int cpu_check_up_prepare(int cpu)
 		 */
 		return -EAGAIN;
 
+	case CPU_UP_PREPARE:
+		/*
+		 * The CPU failed to bringup last time, allow the user
+		 * continue to try to start it up.
+		 */
+		return 0;
+
 	default:
 
 		/* Should not happen.  Famous last words. */
-- 
1.8.3.1

