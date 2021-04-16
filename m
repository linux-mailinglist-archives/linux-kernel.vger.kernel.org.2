Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAA9361BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbhDPIf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:35:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58395 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbhDPIfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:35:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lXJwc-0004d5-Cb; Fri, 16 Apr 2021 08:35:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: Add in additional const on preempt_modes array declaration
Date:   Fri, 16 Apr 2021 09:35:18 +0100
Message-Id: <20210416083518.2031981-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Checkpatch warnings that there is a missing const, fix this by adding it.
Clean us up warning:

"WARNING: static const char * array should probably be static
const char * const"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 42c06fccade5..beaa6263f4c3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5472,7 +5472,7 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
-	static const char * preempt_modes[] = {
+	static const char * const preempt_modes[] = {
 		"none", "voluntary", "full"
 	};
 	int i;
-- 
2.30.2

