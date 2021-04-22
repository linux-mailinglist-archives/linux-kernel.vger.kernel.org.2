Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B52368046
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhDVMX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:23:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52825 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236175AbhDVMX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:23:26 -0400
X-UUID: ee850abb69be4398a6d7c00e0dba1d5a-20210422
X-UUID: ee850abb69be4398a6d7c00e0dba1d5a-20210422
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 515067121; Thu, 22 Apr 2021 20:22:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Apr 2021 20:22:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Apr 2021 20:22:47 +0800
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH 1/1] sched: remove the redundant 'success' in the sched tracepoint
Date:   Thu, 22 Apr 2021 20:22:26 +0800
Message-ID: <20210422122226.9415-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'success' is left here for a long time and also it is meaningless
for the upper user. Just remove it.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 include/trace/events/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index cbe3e152d24c..720204539e0b 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -148,7 +148,6 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 		__array(	char,	comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	pid			)
 		__field(	int,	prio			)
-		__field(	int,	success			)
 		__field(	int,	target_cpu		)
 	),
 
@@ -156,7 +155,6 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
-		__entry->success	= 1; /* rudiment, kill when possible */
 		__entry->target_cpu	= task_cpu(p);
 	),
 
-- 
2.18.0

