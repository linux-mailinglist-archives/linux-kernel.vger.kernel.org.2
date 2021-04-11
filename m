Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EE535B311
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 12:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhDKKWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 06:22:16 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:60085 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbhDKKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 06:22:14 -0400
Received: from localhost.localdomain ([90.126.11.170])
        by mwinf5d55 with ME
        id rNMv240023g7mfN03NMvbp; Sun, 11 Apr 2021 12:21:57 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Apr 2021 12:21:57 +0200
X-ME-IP: 90.126.11.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rostedt@goodmis.org, mingo@redhat.com, zanussi@kernel.org,
        mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tracing/dynevent: Fix a memory leak in an error handling path
Date:   Sun, 11 Apr 2021 12:21:54 +0200
Message-Id: <21e3594ccd7fc88c5c162c98450409190f304327.1618136448.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must free 'argv' before returning, as already done in all the other
paths of this function.

Fixes: d262271d0483 ("tracing/dynevent: Delegate parsing to create function")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 kernel/trace/trace_dynevent.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index dc971a68dda4..e57cc0870892 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -63,8 +63,10 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		event = p + 1;
 		*p = '\0';
 	}
-	if (event[0] == '\0')
-		return -EINVAL;
+	if (event[0] == '\0') {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	mutex_lock(&event_mutex);
 	for_each_dyn_event_safe(pos, n) {
-- 
2.27.0

