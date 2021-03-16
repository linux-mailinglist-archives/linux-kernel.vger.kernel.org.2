Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76F633CEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhCPHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:31:56 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:50300 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCPHbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:31:33 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.228])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 71585E041D;
        Tue, 16 Mar 2021 15:31:30 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] sched: completion: Reinterpret the meaning of completion_done()
Date:   Tue, 16 Mar 2021 15:31:20 +0800
Message-Id: <1615879880-16832-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSUkeSR0dTUIeQxlPVkpNSk5DTEJDQktCS0xVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NlE6Myo5ET8TOUoySlEITDdJ
        L0waCTdVSlVKTUpOQ0xCQ0JKT0tKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUNZV1kIAVlBSUhJQzcG
X-HM-Tid: 0a7839f2678b2c17kusn71585e041d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most intuitive meaning of completion_done() is to see if a completion has 
been done, done=0 can only indicate that someone may be waiting.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/sched/completion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index a778554f9dad..c8ea7575cc41
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -304,10 +304,10 @@ bool try_wait_for_completion(struct completion *x)
 EXPORT_SYMBOL(try_wait_for_completion);
 
 /**
- *	completion_done - Test to see if a completion has any waiters
+ *	completion_done - Test to see if a completion has been done
  *	@x:	completion structure
  *
- *	Return: 0 if there are waiters (wait_for_completion() in progress)
+ *	Return: 0 if there may be waiters (wait_for_completion() in progress)
  *		 1 if there are no waiters.
  *
  *	Note, this will always return true if complete_all() was called on @X.
-- 
2.27.0

