Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D79368E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbhDWH5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:57:25 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:11038 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhDWH5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:57:23 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 41DA8E04BA;
        Fri, 23 Apr 2021 15:56:44 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
        zhouchuangao <zhouchuangao@vivo.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/notifier: Use BUG_ON instead of if condition followed by BUG
Date:   Fri, 23 Apr 2021 00:56:34 -0700
Message-Id: <1619164597-69309-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGRgfTlYYGh9DTR5DHUlJHklVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NEk6OSo5Tz8WFg0dQ1EBM1EV
        LT8aFBZVSlVKTUpCSk1PTUtPTEpNVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlLT003Bg++
X-HM-Tid: 0a78fdbb27d42c17kusn41da8e04ba
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON uses unlikely in if(). Through disassembly, we can see that
brk #0x800 is compiled to the end of the function.
As you can see below:
    ......
    ffffff8008660bec:   d65f03c0    ret
    ffffff8008660bf0:   d4210000    brk #0x800

Usually, the condition in if () is not satisfied. For the
multi-stage pipeline, we do not need to perform fetch decode
and excute operation on brk instruction.

In my opinion, this can improve the efficiency of the
multi-stage pipeline.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 kernel/notifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index 1b019cb..2b0ed7d 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -522,8 +522,7 @@ EXPORT_SYMBOL_GPL(srcu_notifier_call_chain);
 void srcu_init_notifier_head(struct srcu_notifier_head *nh)
 {
 	mutex_init(&nh->mutex);
-	if (init_srcu_struct(&nh->srcu) < 0)
-		BUG();
+	BUG_ON(init_srcu_struct(&nh->srcu) < 0);
 	nh->head = NULL;
 }
 EXPORT_SYMBOL_GPL(srcu_init_notifier_head);
-- 
2.7.4

