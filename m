Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FB0406B17
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhIJMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232613AbhIJMBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:01:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCA2E610E9;
        Fri, 10 Sep 2021 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631275190;
        bh=edYf6lmuATbO2HCB5qHEmuPxrMlvtoeMOZ67qg2bQYg=;
        h=From:To:Cc:Subject:Date:From;
        b=RwlTLCnr4M/LdUs0YxqKUrQspftnh+9thgIJ9PIAJ4OnU5R9vIJ4Or899CxMFPJGi
         5sApSYxfLl/4vP1w3MEnnUg0yELMIuBZ3kGaBgZjme2f9xBGlbDexzr5ol5OdAr2Mc
         qRt1JFAvN/QKBJ/jlmJv6ac2l8RlXXuo+HIL+3wHvk2t14y9YNkKPcR3q2bj0hM2Zp
         mCtPkwnXPpQerSKe2W3e3/3OoJ0d6b9Vx+e1ILxD3Pyt5qdX4hwlmh2Jka3fdfGtMZ
         hQmlilBMCTgdRVsyQ8OMVL3a8ngi/khkVEu0+OtFTeMlLeNjOrzUoAJ1PZd4mPbx9C
         4GLT8qoQGaCcg==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/psi: remove a duplicated comment line
Date:   Fri, 10 Sep 2021 19:59:39 +0800
Message-Id: <20210910115939.2298921-1-alexs@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

The comments are duplicated, remove it.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/sched/psi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2bb54b7..526af84ab852 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -833,7 +833,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		/*
 		 * When switching between tasks that have an identical
 		 * runtime state, the cgroup that contains both tasks
-		 * runtime state, the cgroup that contains both tasks
 		 * we reach the first common ancestor. Iterate @next's
 		 * ancestors only until we encounter @prev's ONCPU.
 		 */
-- 
2.27.0

