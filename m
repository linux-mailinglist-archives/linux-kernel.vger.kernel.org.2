Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1105334593C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCWIEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:04:53 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:52680 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCWIE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:04:28 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 10D73400097;
        Tue, 23 Mar 2021 16:04:25 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] kernel/signal: Modify the comment of function check_kill_permission
Date:   Tue, 23 Mar 2021 01:03:56 -0700
Message-Id: <1616486638-82721-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTk1KT08eSU5JTUxNVkpNSk1PQ01NTU5JTUNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogg6AQw*Lz8WNDoQDQ4QC0s*
        TxRPCwpVSlVKTUpNT0NNTU1NSkhNVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpCTEg3Bg++
X-HM-Tid: 0a785e1d0bf5d991kuws10d73400097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe it's easier for us to understand the function of
check_kill_permission.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 kernel/signal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index f2a1b89..2fbf68a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -823,8 +823,10 @@ static bool kill_ok_by_cred(struct task_struct *t)
 }
 
 /*
- * Bad permissions for sending the signal
- * - the caller must hold the RCU read lock
+ * Check if the signal has permission to kill the process.
+ * - The caller must hold the RCU read lock;
+ * - Return 0 means permission is allowed, otherwise returns the
+ *   corresponding error number.
  */
 static int check_kill_permission(int sig, struct kernel_siginfo *info,
 				 struct task_struct *t)
-- 
2.7.4

