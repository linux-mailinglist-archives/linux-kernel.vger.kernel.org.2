Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC3438DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhJYD5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:57:24 -0400
Received: from prt-mail.chinatelecom.cn ([42.123.76.228]:50821 "EHLO
        chinatelecom.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232169AbhJYD5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:57:22 -0400
HMM_SOURCE_IP: 172.18.0.48:38176.619599683
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.11.244 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 5D8D42800DA;
        Mon, 25 Oct 2021 11:46:33 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 2644b3ac7a5f4906bc4966b328380019 for linux-kernel@vger.kernel.org;
        Mon, 25 Oct 2021 11:46:39 CST
X-Transaction-ID: 2644b3ac7a5f4906bc4966b328380019
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com,
        zhouchengming@bytedance.com, Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH 1/2] psi: Remove repeated verbose comment
Date:   Mon, 25 Oct 2021 11:46:25 +0800
Message-Id: <1635133586-84611-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment in function psi_task_switch,there are two same lines.
...
* runtime state, the cgroup that contains both tasks
* runtime state, the cgroup that contains both tasks
...

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 kernel/sched/psi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2b..526af84 100644
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
1.8.3.1

