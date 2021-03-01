Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E53E327DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhCAMGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:06:49 -0500
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:32868 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhCAMGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:06:48 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.228])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 2A463540317;
        Mon,  1 Mar 2021 20:06:02 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Vineet Gupta <vgupta@synopsys.com>, Jens Axboe <axboe@kernel.dk>,
        Wang Qing <wangqing@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arc: kernel: Return -EFAULT if copy_to_user() fails
Date:   Mon,  1 Mar 2021 20:05:48 +0800
Message-Id: <1614600349-15662-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGEweGR5CT0xJTEIZVkpNSk9NS0tITUlPTEtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDI6Lww5Pj8QSBAdQyEjEzIr
        CQ5PCSlVSlVKTUpPTUtLSE1JQ0lJVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUNZV1kIAVlBSUtOSTcG
X-HM-Tid: 0a77edae5993b038kuuu2a463540317
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copy_to_user() function returns the number of bytes remaining to be
copied, but we want to return -EFAULT if the copy doesn't complete.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arc/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index a78d8f7..fdbe06c
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -96,7 +96,7 @@ stash_usr_regs(struct rt_sigframe __user *sf, struct pt_regs *regs,
 			     sizeof(sf->uc.uc_mcontext.regs.scratch));
 	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(sigset_t));
 
-	return err;
+	return err ? -EFAULT : 0;
 }
 
 static int restore_usr_regs(struct pt_regs *regs, struct rt_sigframe __user *sf)
@@ -110,7 +110,7 @@ static int restore_usr_regs(struct pt_regs *regs, struct rt_sigframe __user *sf)
 				&(sf->uc.uc_mcontext.regs.scratch),
 				sizeof(sf->uc.uc_mcontext.regs.scratch));
 	if (err)
-		return err;
+		return -EFAULT;
 
 	set_current_blocked(&set);
 	regs->bta	= uregs.scratch.bta;
-- 
2.7.4

