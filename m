Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC1A408310
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhIMDOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:14:30 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16192 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbhIMDOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:14:21 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H7BNL0xGNz1DGt0;
        Mon, 13 Sep 2021 11:12:02 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 11:12:59 +0800
Received: from huawei.com (10.175.100.227) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 11:12:59 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <bristot@redhat.com>, <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <tangyizhou@huawei.com>
Subject: [PATCH] trace: Do some cleanups for osnoise tracer
Date:   Mon, 13 Sep 2021 11:32:06 +0800
Message-ID: <20210913033206.23682-1-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add 'static' and 'const' qualifier when necessary.
2. Use DEFINE_MUTEX() to define a mutex.

Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 kernel/trace/trace_osnoise.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index ce053619f289..c1a8dc6a154e 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -105,7 +105,7 @@ struct osnoise_variables {
 /*
  * Per-cpu runtime information.
  */
-DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
+static DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
 
 /*
  * this_cpu_osn_var - Return the per-cpu osnoise_variables on its relative CPU
@@ -128,7 +128,7 @@ struct timerlat_variables {
 	u64			count;
 };
 
-DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
+static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
 
 /*
  * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
@@ -220,7 +220,7 @@ struct timerlat_sample {
 /*
  * Protect the interface.
  */
-struct mutex interface_lock;
+static DEFINE_MUTEX(interface_lock);
 
 /*
  * Tracer data.
@@ -1818,8 +1818,8 @@ static struct trace_min_max_param osnoise_print_stack = {
 /*
  * osnoise/timerlat_period: min 100 us, max 1 s
  */
-u64 timerlat_min_period = 100;
-u64 timerlat_max_period = 1000000;
+static const u64 timerlat_min_period = 100;
+static const u64 timerlat_max_period = 1000000;
 static struct trace_min_max_param timerlat_period = {
 	.lock	= &interface_lock,
 	.val	= &osnoise_data.timerlat_period,
@@ -2087,8 +2087,6 @@ __init static int init_osnoise_tracer(void)
 {
 	int ret;
 
-	mutex_init(&interface_lock);
-
 	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
 
 	ret = register_tracer(&osnoise_tracer);
-- 
2.17.1

