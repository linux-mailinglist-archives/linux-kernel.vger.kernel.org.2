Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2853779D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 03:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhEJBjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 21:39:25 -0400
Received: from mail-m17670.qiye.163.com ([59.111.176.70]:32806 "EHLO
        mail-m17670.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhEJBjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 21:39:24 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17670.qiye.163.com (Hmail) with ESMTPA id 5F4293C00CB;
        Mon, 10 May 2021 09:38:19 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] kernel/module: Use BUG_ON instead of if condition followed by BUG
Date:   Sun,  9 May 2021 18:38:02 -0700
Message-Id: <1620610682-25567-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkIYS1YdTR0eH01LT00YHx9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6LBw4MD8SHT8KIgofSTMh
        EUMaFFZVSlVKTUlLTUpLTUJCTE5IVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpNQ003Bg++
X-HM-Tid: 0a7953ecd0c2da5akuws5f4293c00cb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch comes from cocinelle warning.

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
 kernel/module.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index b5dd92e..faf9114 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1014,8 +1014,7 @@ void __symbol_put(const char *symbol)
 	};
 
 	preempt_disable();
-	if (!find_symbol(&fsa))
-		BUG();
+	BUG_ON(!find_symbol(&fsa));
 	module_put(fsa.owner);
 	preempt_enable();
 }
-- 
2.7.4

