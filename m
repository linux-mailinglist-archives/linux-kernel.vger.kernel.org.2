Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5B39C62E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFEGWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:22:44 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4361 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEGWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:22:43 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FxqD10xtPz5s1v;
        Sat,  5 Jun 2021 14:17:05 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 14:20:52 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 14:20:51 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <peterz@infradead.org>, <vincent.donnefort@arm.com>,
        <valentin.schneider@arm.com>, <mingo@kernel.org>,
        <tglx@linutronix.de>, <frederic@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] cpu/hotplug: fix doc warnings in cpu.c
Date:   Sat, 5 Jun 2021 14:30:03 +0800
Message-ID: <20210605063003.681049-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 kernel/cpu.c:1949: warning: Function parameter or member 
  'name' not described in '__cpuhp_setup_state_cpuslocked'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2942cb4644c5..35ab1bddbb6b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1927,6 +1927,7 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance);
 /**
  * __cpuhp_setup_state_cpuslocked - Setup the callbacks for an hotplug machine state
  * @state:		The state to setup
+ * @name:		Name of the step
  * @invoke:		If true, the startup function is invoked for cpus where
  *			cpu state >= @state
  * @startup:		startup callback function
-- 
2.31.1

