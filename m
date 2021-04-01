Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C863513E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhDAKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:48:49 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:14400 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhDAKsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:48:45 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id A6C629803E9;
        Thu,  1 Apr 2021 18:48:43 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] linux/profile.h: Remove unnecessary declaration
Date:   Thu,  1 Apr 2021 18:48:34 +0800
Message-Id: <20210401104834.1009157-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSR5MHU5CHhpIH0lDVkpNSkxJTE9KSUhDTUhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzI6Dgw5FT8KTysCSxQ8Gh4Z
        LzwwCj1VSlVKTUpMSUxPSklPSkhDVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTU5CNwY+
X-HM-Tid: 0a788d0cb60ad992kuwsa6c629803e9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declaring struct pt_regs is unnecessary.
On the one hand, there is no function using it;
on the other hand, struct pt_regs has been declared
in linux/kernel.h. Remove them.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/profile.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/profile.h b/include/linux/profile.h
index bad18ca43150..fd18ca96f557 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -15,7 +15,6 @@
 #define KVM_PROFILING	4
 
 struct proc_dir_entry;
-struct pt_regs;
 struct notifier_block;
 
 #if defined(CONFIG_PROFILING) && defined(CONFIG_PROC_FS)
@@ -84,8 +83,6 @@ int task_handoff_unregister(struct notifier_block * n);
 int profile_event_register(enum profile_type, struct notifier_block * n);
 int profile_event_unregister(enum profile_type, struct notifier_block * n);
 
-struct pt_regs;
-
 #else
 
 #define prof_on 0
-- 
2.25.1

