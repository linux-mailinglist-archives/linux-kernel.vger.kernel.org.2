Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A23EF2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhHQTn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233366AbhHQTni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D7261059;
        Tue, 17 Aug 2021 19:43:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zI-004TPX-77; Tue, 17 Aug 2021 15:43:04 -0400
Message-ID: <20210817194304.059129069@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [for-next][PATCH 08/19] tracing: Fix a typo in tracepoint.h
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Shijie <shijie@os.amperecomputing.com>

It should be @prev_pid, not @prev_prid.

Link: https://lkml.kernel.org/r/20210802140234.5383-1-shijie@os.amperecomputing.com

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index ab58696d0ddd..28031b15f878 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -475,7 +475,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  *	*
  *	* The declared 'local variable' is called '__entry'
  *	*
- *	* __field(pid_t, prev_prid) is equivalent to a standard declaration:
+ *	* __field(pid_t, prev_pid) is equivalent to a standard declaration:
  *	*
  *	*	pid_t	prev_pid;
  *	*
-- 
2.30.2
