Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672F634A6E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhCZMLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:11:10 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:43644 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhCZMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:10:41 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id B518F98027B;
        Fri, 26 Mar 2021 20:10:38 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] linux/profile.h: Remove unnecessary declaration
Date:   Fri, 26 Mar 2021 20:09:55 +0800
Message-Id: <20210326120959.906445-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZShlDHkpLQ09NSklPVkpNSk1MTUtNSENDQkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6Kxw6Iz8JSzw9QywYNx8a
        NFEwCjxVSlVKTUpNTE1LTUhCSEhNVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTE1MNwY+
X-HM-Tid: 0a786e718d5fd992kuwsb518f98027b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declaring struct pt_regs is unnecessary.
On the one hand, there is no function using it;
on the other hand, struct pt_regs has been declared
in linux/kernel.h. Remove them.
Reorder the forward declaration to be in alphabetic order.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/profile.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/profile.h b/include/linux/profile.h
index bad18ca43150..59b3acbbcc2b 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -14,9 +14,8 @@
 #define SLEEP_PROFILING	3
 #define KVM_PROFILING	4
 
-struct proc_dir_entry;
-struct pt_regs;
 struct notifier_block;
+struct proc_dir_entry;
 
 #if defined(CONFIG_PROFILING) && defined(CONFIG_PROC_FS)
 void create_prof_cpu_mask(void);
@@ -84,8 +83,6 @@ int task_handoff_unregister(struct notifier_block * n);
 int profile_event_register(enum profile_type, struct notifier_block * n);
 int profile_event_unregister(enum profile_type, struct notifier_block * n);
 
-struct pt_regs;
-
 #else
 
 #define prof_on 0
-- 
2.25.1

