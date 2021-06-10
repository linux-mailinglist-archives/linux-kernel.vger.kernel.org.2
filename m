Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEF83A21B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 03:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFJBEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhFJBDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:03:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A790561405;
        Thu, 10 Jun 2021 01:01:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr953-002bZN-NW; Wed, 09 Jun 2021 21:01:57 -0400
Message-ID: <20210610010157.549263801@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 21:01:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: [for-next][PATCH 05/11] trace: replace WB_REASON_FOREIGN_FLUSH with a string
References: <20210610010130.069460694@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Now WB_REASON_FOREIGN_FLUSH is displayed as a number, maybe a
string is better.

v2: replace some space with tab.

Link: https://lkml.kernel.org/r/1619914347-21904-1-git-send-email-brookxu.cn@gmail.com

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/writeback.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1efa463c4979..840d1ba84cf5 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -36,7 +36,8 @@
 	EM( WB_REASON_PERIODIC,			"periodic")		\
 	EM( WB_REASON_LAPTOP_TIMER,		"laptop_timer")		\
 	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
-	EMe(WB_REASON_FORKER_THREAD,		"forker_thread")
+	EM( WB_REASON_FORKER_THREAD,		"forker_thread")	\
+	EMe(WB_REASON_FOREIGN_FLUSH,		"foreign_flush")
 
 WB_WORK_REASON
 
-- 
2.30.2
