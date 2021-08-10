Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A741E3E8637
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhHJWvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbhHJWvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:51:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EDEC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mVcczgUsvPTHU1rSVqOdQa3/ma3BKpZlA24Xh0onY+o=; b=S76R0f7S7Rmw7t4AvJVVtvxr8c
        ZnWKS7DBEKs/Y2qM3E/GgQy1R75zOiqeKNHSgIWZaxD9wgiCfSBw8hsROIJ0XbEa9YYKQPo8SO90P
        TubFclnkNAmvZYs0/tAqiDjBpk4PGS+4UWT9SigocZT6Ox9bVn6IvBfx2IMHxeeffevlu7adE5cBe
        Y5Zb6LaZyPunlDjEh8hq1pJfqdR8AX872LLtp3b2Eabe5p7jClQXDAsqh/ABKtB80NsjVoE629HAH
        z2fPDsr9sVlHBOT+9dkuiIVOqzFfG9pung4cOvCPSYvRPZTA4k0pKzoYMWW2pNSDh3TcacyYo4mRB
        wqDa6z9A==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDaaD-004zjf-1E; Tue, 10 Aug 2021 22:50:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] kernel/smp: fix all kernel-doc warnings
Date:   Tue, 10 Aug 2021 15:50:51 -0700
Message-Id: <20210810225051.3938-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings:

kernel/smp.c:1189: warning: cannot understand function prototype: 'struct smp_call_on_cpu_struct '
kernel/smp.c:788: warning: No description found for return value of 'smp_call_function_single_async'
kernel/smp.c:990: warning: Function parameter or member 'wait' not described in 'smp_call_function_many'
kernel/smp.c:990: warning: Excess function parameter 'flags' description in 'smp_call_function_many'
kernel/smp.c:1198: warning: Function parameter or member 'work' not described in 'smp_call_on_cpu_struct'
kernel/smp.c:1198: warning: Function parameter or member 'done' not described in 'smp_call_on_cpu_struct'
kernel/smp.c:1198: warning: Function parameter or member 'func' not described in 'smp_call_on_cpu_struct'
kernel/smp.c:1198: warning: Function parameter or member 'data' not described in 'smp_call_on_cpu_struct'
kernel/smp.c:1198: warning: Function parameter or member 'ret' not described in 'smp_call_on_cpu_struct'
kernel/smp.c:1198: warning: Function parameter or member 'cpu' not described in 'smp_call_on_cpu_struct'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/smp.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- linux-next-20210809.orig/kernel/smp.c
+++ linux-next-20210809/kernel/smp.c
@@ -764,7 +764,7 @@ int smp_call_function_single(int cpu, sm
 EXPORT_SYMBOL(smp_call_function_single);
 
 /**
- * smp_call_function_single_async(): Run an asynchronous function on a
+ * smp_call_function_single_async() - Run an asynchronous function on a
  * 			         specific CPU.
  * @cpu: The CPU to run on.
  * @csd: Pre-allocated and setup data structure
@@ -783,6 +783,8 @@ EXPORT_SYMBOL(smp_call_function_single);
  *
  * NOTE: Be careful, there is unfortunately no current debugging facility to
  * validate the correctness of this serialization.
+ *
+ * Return: %0 on success or negative errno value on error
  */
 int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
 {
@@ -974,7 +976,7 @@ static void smp_call_function_many_cond(
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @flags: Bitmask that controls the operation. If %SCF_WAIT is set, wait
+ * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
  *        (atomically) until function has completed on other CPUs. If
  *        %SCF_RUN_LOCAL is set, the function will also be run locally
  *        if the local CPU is set in the @cpumask.
@@ -1180,7 +1182,13 @@ void wake_up_all_idle_cpus(void)
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
 
 /**
- * smp_call_on_cpu - Call a function on a specific cpu
+ * struct smp_call_on_cpu_struct - Call a function on a specific CPU
+ * @work: &work_struct
+ * @done: &completion to signal
+ * @func: function to call
+ * @data: function's data argument
+ * @ret: return value from @func
+ * @cpu: target CPU (%-1 for any CPU)
  *
  * Used to call a function on a specific cpu and wait for it to return.
  * Optionally make sure the call is done on a specified physical cpu via vcpu
