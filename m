Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656413486ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 03:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhCYC2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 22:28:07 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:15504 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhCYC1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 22:27:38 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id C5FE69801D3;
        Thu, 25 Mar 2021 10:27:35 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] include: linux: debug_locks: Remove duplicate declaration
Date:   Thu, 25 Mar 2021 10:26:58 +0800
Message-Id: <20210325022707.840531-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTkxLHxpDH0tJGE0ZVkpNSk1NSEJJTk1LSkJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6Fww6Iz8WSz8DDTI2EzA1
        LjlPCU9VSlVKTUpNTUhCSU5NQ0JOVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTEtONwY+
X-HM-Tid: 0a7867356580d992kuwsc5fe69801d3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct task_struct is declared at 9th line. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/debug_locks.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 2915f56ad421..0b3187a5290d 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -46,7 +46,6 @@ extern int debug_locks_off(void);
 # define locking_selftest()	do { } while (0)
 #endif
 
-struct task_struct;
 
 #ifdef CONFIG_LOCKDEP
 extern void debug_show_all_locks(void);
-- 
2.25.1

