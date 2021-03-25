Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C3D349543
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhCYPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:21:19 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:43832 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCYPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:21:13 -0400
Received: from localhost.localdomain (unknown [180.111.236.218])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 26AB9980144;
        Thu, 25 Mar 2021 23:21:09 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     keal_w@yeah.net
Subject: [PATCH] [v2] include: linux: debug_locks: Remove duplicate declaration
Date:   Thu, 25 Mar 2021 23:20:28 +0800
Message-Id: <20210325152029.4976-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSEodGBkdGB8YQhgaVkpNSk1NQ05NTUJISU5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRg6Szo*GD8QOD0BOBQIAwIf
        EkxPCxxVSlVKTUpNTUNOTU1CTU1LVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlK
        Q0tVSkpKVUlITVVJSkNZV1kIAVlBSkxJSTcG
X-HM-Tid: 0a7869f99b8fd992kuws26ab9980144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct task_struct has been declared.
Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Remove another duplicate declaration for being closer
  to its user.
---
 include/linux/debug_locks.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 2915f56ad421..32f6a37a3d3f 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -6,8 +6,6 @@
 #include <linux/bug.h>
 #include <linux/printk.h>
 
-struct task_struct;
-
 extern int debug_locks __read_mostly;
 extern int debug_locks_silent __read_mostly;
 
-- 
2.25.1

