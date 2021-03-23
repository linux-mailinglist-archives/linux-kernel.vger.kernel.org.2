Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CCE345D79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCWL4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:56:42 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:45476 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCWL4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:56:34 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id A2ADD400339;
        Tue, 23 Mar 2021 19:56:31 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH v2] kernel/signal: Modify the comment of function check_kill_permission()
Date:   Tue, 23 Mar 2021 04:56:20 -0700
Message-Id: <1616500582-84709-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTk1CTU4eHxlNHk1MVkpNSk1OS0tOQkpCSE9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSo6KTo6Pz8RFjkaSzdLGQg*
        Eg0KCk5VSlVKTUpNTktLTkJJSUJOVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlLTUM3Bg++
X-HM-Tid: 0a785ef18cf9d991kuwsa2add400339
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
index f2a1b89..e6b6277 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -823,8 +823,10 @@ static bool kill_ok_by_cred(struct task_struct *t)
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

