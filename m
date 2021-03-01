Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8DB327D3E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhCAL3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:29:37 -0500
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:39590 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhCAL32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:29:28 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 9057354015E;
        Mon,  1 Mar 2021 19:28:26 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Cedeno <thomascedeno@google.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Michel Lespinasse <walken@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] kernel: Return -EFAULT if copy_to_user() fails
Date:   Mon,  1 Mar 2021 19:28:11 +0800
Message-Id: <1614598093-1188-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSkgZHUhPQ0NDHR5NVkpNSk9OQkNKS0xLTUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6Njo*AT8cIRArDjkxMy0U
        EjcwCUNVSlVKTUpPTkJDSktMT0tOVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJS09LNwY+
X-HM-Tid: 0a77ed8bef69b038kuuu9057354015e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copy_to_user() function returns the number of bytes remaining to be
copied, but we want to return -EFAULT if the copy doesn't complete.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 8bb46e5..d97a84a
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1247,7 +1247,7 @@ static int override_release(char __user *release, size_t len)
 		copy = scnprintf(buf, copy, "2.6.%u%s", v, rest);
 		ret = copy_to_user(release, buf, copy + 1);
 	}
-	return ret;
+	return ret ? -EFAULT : 0;
 }
 
 SYSCALL_DEFINE1(newuname, struct new_utsname __user *, name)
-- 
2.7.4

