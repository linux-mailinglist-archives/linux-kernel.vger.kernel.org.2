Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6DE349653
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhCYQDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:03:40 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:30614 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhCYQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:03:07 -0400
Received: from localhost.localdomain (unknown [180.111.236.218])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id DC24D980238;
        Fri, 26 Mar 2021 00:03:04 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] [v3] debug_locks: Remove duplicate declaration
Date:   Fri, 26 Mar 2021 00:02:44 +0800
Message-Id: <20210325160245.5949-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS08eGhpJQ0odSU5PVkpNSk1NQ0NKQ05LTU5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K006Ogw5Hj8OPD1WUTgSNT8d
        CylPFANVSlVKTUpNTUNDSkNOT0tDVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlK
        Q0tVSkpKVUlITVVJSkNZV1kIAVlBSkNMSTcG
X-HM-Tid: 0a786a1ffeaed992kuwsdc24d980238
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct task_struct is declared twice.
Remove the duplicate.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v3:
- Add reviewer info and modify subject line
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

