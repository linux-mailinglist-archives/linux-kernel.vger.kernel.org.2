Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABE545A62D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhKWPGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:06:25 -0500
Received: from mail-m971.mail.163.com ([123.126.97.1]:49798 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhKWPGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:06:24 -0500
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Nov 2021 10:06:23 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=TRdagmPh9g+F7jmGxl
        CYV02jLr2Fp6hrvf/+IjRdrik=; b=E8ObMbcH9sStXprpkduX30aMI6ts6KwfZS
        uGdlRWX1HhMNSUCIPukaiZlXmgbRZ2oqiYvmt1StRo2yreZKpK5P2TTFQnqmdG7R
        1jauGPjJRMlLL+ZUCIaD1PpXutDmWOdRsi70OYFXoQsVma7hOLdjk4Z38DS9uHJs
        tiPONrKQ8=
Received: from localhost.localdomain.localdomain (unknown [114.242.206.180])
        by smtp1 (Coremail) with SMTP id GdxpCgAHNe2z_pxh0A_zLw--.14826S2;
        Tue, 23 Nov 2021 22:46:16 +0800 (CST)
From:   Liu Peibao <liupeibao@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: aplly TASK_RUNNING in state judgement
Date:   Tue, 23 Nov 2021 22:46:11 +0800
Message-Id: <1637678771-17525-1-git-send-email-liupeibao@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: GdxpCgAHNe2z_pxh0A_zLw--.14826S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur45JF47Cw45Kr4rZFykGrg_yoW3XFX_Gw
        1rXr18urn8JwnFvr43Aay8W340v3WjvF4Skr45AF4UA3y8tr90y398ZF95WrnxXFs7XFy7
        AFnxWFsI9rnFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8-_-PUUUUU==
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: xolx1vpled0qqrwthudrp/xtbBdQ1UbFaEBmiy-gAAsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks more clearly.

Signed-off-by: Liu Peibao <liupeibao@163.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c9b0fd..abafd2e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6181,7 +6181,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
 	prev_state = READ_ONCE(prev->__state);
-	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
+	if (!(sched_mode & SM_MASK_PREEMPT) && (prev_state != TASK_RUNNING)) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
-- 
1.8.3.1

