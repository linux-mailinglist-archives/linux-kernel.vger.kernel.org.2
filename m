Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54FD362F37
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhDQK16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 06:27:58 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:57274 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhDQK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 06:27:55 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Apr 2021 06:27:55 EDT
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id 0006D80106;
        Sat, 17 Apr 2021 18:22:13 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] kernel/module: Use BUG_ON instead of if condition followed by BUG.
Date:   Sat, 17 Apr 2021 03:22:01 -0700
Message-Id: <1618654921-124063-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk8eTFYdSRhNSUsfTktIQhpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAg6Nio5Vj8RAhciTQoPEisO
        HBxPChlVSlVKTUpDTU5PQkhPSE5LVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpMSEM3Bg++
X-HM-Tid: 0a78df5a3429b037kuuu0006d80106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First:
This patch comes from cocinelle warning.

Second:
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
 kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 3047935..f46fc4f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1014,8 +1014,8 @@ void __symbol_put(const char *symbol)
 	};
 
 	preempt_disable();
-	if (!find_symbol(&fsa))
-		BUG();
+	BUG_ON(!find_symbol(&fsa));
+
 	module_put(fsa.owner);
 	preempt_enable();
 }
-- 
2.7.4

