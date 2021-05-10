Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CBE3779D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 03:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhEJBg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 21:36:29 -0400
Received: from mail-m17670.qiye.163.com ([59.111.176.70]:30480 "EHLO
        mail-m17670.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhEJBg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 21:36:28 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 May 2021 21:36:27 EDT
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17670.qiye.163.com (Hmail) with ESMTPA id 3DEAD3C00AC;
        Mon, 10 May 2021 09:26:28 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] kernel/signal: Modify the comment of function check_kill_permission
Date:   Sun,  9 May 2021 18:26:20 -0700
Message-Id: <1620609982-25340-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQx5DTVZCSR8fQxlMGB1OHkJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6Ajo4Tz8UMz9WFBQxSj01
        NTQwC05VSlVKTUlLTUtCQkNDQktLVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlLSEM3Bg++
X-HM-Tid: 0a7953e1f78cda5akuws3dead3c00ac
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe it's easier for us to understand the function of
check_kill_permission().

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 kernel/signal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 66e8864..8335f17 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -861,8 +861,10 @@ static bool kill_ok_by_cred(struct task_struct *t)
 }
 
 /*
- * Bad permissions for sending the signal
- * - the caller must hold the RCU read lock
+ * Check whether the caller has permissions to send the signal.
+ * - The caller must hold the RCU read lock;
+ * - Return 0 means permission is allowed, otherwise returns the
+ *   corresponding error number.
  */
 static int check_kill_permission(int sig, struct kernel_siginfo *info,
 				 struct task_struct *t)
-- 
2.7.4

