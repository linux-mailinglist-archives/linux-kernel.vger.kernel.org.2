Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923B23B1316
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 06:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFWE67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 00:58:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45478 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhFWE66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 00:58:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624424201; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=0rSIwgctBlahlkEeN46SC5CMf+Iz8K2VB7mfWOAp8iM=; b=iXV2jCkfZZRQLkb8EJfc1465729iCwCD3p7FJh/VKPKLAvOfTOxmoVgZUP4M/67ra/4NVs7F
 XwmzHqmnzxO9c2WeYSkU+4v5SQidCdFzmhiuAGh3r0RpI7MoMZAgpJOhG2/7CLDudSNdNUHf
 jYy+Q4HOJw0C66EUOYoqlrmqusY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60d2bf08638039e997ef5226 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 04:56:40
 GMT
Sender: eberman=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95185C433F1; Wed, 23 Jun 2021 04:56:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-eberman-lv.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 571BBC433F1;
        Wed, 23 Jun 2021 04:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 571BBC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] lockdep: Remove console_verbose when disable lock debugging
Date:   Tue, 22 Jun 2021 21:55:59 -0700
Message-Id: <20210623045559.15750-1-eberman@codeaurora.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debug_locks_off can be called in scenarios where the kernel doesn't
immediately panic. For instance, debug_locks_off is called with a
mismatched preempt_count or when registering an improper lockdep map
and fails the sanity check for lock-class key [1]. Both of these issues
were discovered in vendor kernel code and were fixed.

When console_verbose is enabled, we have found that kernel tends to be
unstable because it is spending much of its time printing to the serial
log, so the system may miss watchdog pats. We explicitly set our system
to reduce the loglevel in order to prevent such scenarios, however
lockdep can circumvent the commandline setting. Thus, when we ran into
the kernel bugs, we first ended up trying to debug why the kernel wasn't
able to respond to watchdog pets and why it was spending all of its time
flushing the console, which did not quickly lead us to the "real"
lock dependency issue.

Remove the console_verbose when turning off lock debugging. Other debug
facilities, such as KASAN, KFENCE, SPINLOCK_DEBUG, and DEBUG_OBJECTS
don't set console_verbose when issues are detected. Current other uses
for console_verbose are in situations where kernel is in a panic path.

[1]: kernel/locking/lockdep.c:lockdep_init_map_waits:4617

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 lib/debug_locks.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index 06d3135bd184..f91b5d31f63c 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -38,12 +38,8 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
  */
 noinstr int debug_locks_off(void)
 {
-	if (debug_locks && __debug_locks_off()) {
-		if (!debug_locks_silent) {
-			console_verbose();
-			return 1;
-		}
-	}
+	if (debug_locks && __debug_locks_off() && !debug_locks_silent)
+		return 1;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(debug_locks_off);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

