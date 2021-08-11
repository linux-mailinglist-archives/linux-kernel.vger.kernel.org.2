Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8973E952E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhHKQAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:00:21 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:7412 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232847AbhHKQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628697597; x=1660233597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q6bTaAzqKCmfR9183c3CDW98qIeaLOQ4+KwxcaEL7Ds=;
  b=rkId31qkMxh0/yB6MuQovQH6Bc66jIxU1UTFK4Yb5Wl2aW+INFkgwmvx
   FRi1RBoT0mi9I9TUvp6yPBkcFvI3FJHHMBhV9I+RTyWJlOolAktMi8l2F
   9Jw2nMwRESuFyvqL0q8neG/idoDnXtZMdgt6qy7n/kxFKgEQ+c2FkbT16
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Aug 2021 08:59:56 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Aug 2021 08:59:56 -0700
Received: from hu-eberman-lv.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 11 Aug 2021 08:59:55 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        Jinlong Mao <jinlmao@codeaurora.org>
Subject: [PATCH 1/1] cfi: Use rcu_read_{un}lock_sched_notrace
Date:   Wed, 11 Aug 2021 08:59:14 -0700
Message-ID: <20210811155914.19550-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03f.na.qualcomm.com (10.85.0.47) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rcu_read_lock_sched tracing is enabled, the tracing subsystem can
perform a jump which needs to be checked by CFI. For example, stm_ftrace
source is enabled as a module and hooks into enabled ftrace events. This
can cause an recursive loop where find_shadow_check_fn ->
rcu_read_lock_sched -> (call to stm_ftrace generates cfi slowpath) ->
find_shadow_check_fn -> rcu_read_lock_sched -> ...

To avoid the recursion, either the ftrace codes needs to be marked with
__no_cfi or CFI should not trace. Use the "_notrace" in CFI to avoid
tracing so that CFI can guard ftrace.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 kernel/cfi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cfi.c b/kernel/cfi.c
index e17a56639766..9594cfd1cf2c 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -248,9 +248,9 @@ static inline cfi_check_fn find_shadow_check_fn(unsigned long ptr)
 {
 	cfi_check_fn fn;
 
-	rcu_read_lock_sched();
+	rcu_read_lock_sched_notrace();
 	fn = ptr_to_check_fn(rcu_dereference_sched(cfi_shadow), ptr);
-	rcu_read_unlock_sched();
+	rcu_read_unlock_sched_notrace();
 
 	return fn;
 }
@@ -269,11 +269,11 @@ static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
 	cfi_check_fn fn = NULL;
 	struct module *mod;
 
-	rcu_read_lock_sched();
+	rcu_read_lock_sched_notrace();
 	mod = __module_address(ptr);
 	if (mod)
 		fn = mod->cfi_check;
-	rcu_read_unlock_sched();
+	rcu_read_unlock_sched_notrace();
 
 	return fn;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

