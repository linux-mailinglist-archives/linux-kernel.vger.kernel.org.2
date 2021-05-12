Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8DC37BF28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhELODQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:03:16 -0400
Received: from mail-m17670.qiye.163.com ([59.111.176.70]:41158 "EHLO
        mail-m17670.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhELODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:03:14 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17670.qiye.163.com (Hmail) with ESMTPA id E2CD93C009F;
        Wed, 12 May 2021 22:02:02 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH v2] kernel/module: Use BUG_ON instead of if condition followed by BUG
Date:   Wed, 12 May 2021 07:01:57 -0700
Message-Id: <1620828117-88111-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGklOTlYaTB9ITB5OTE9NTB1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6Dww5Hz8XQjMsDTk1IgML
        VjgKFEtVSlVKTUlLQ0lDSklISUJIVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpMTEI3Bg++
X-HM-Tid: 0a7960e26f88da5akuwse2cd93c009f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccinelle report:

kernel/module.c:1018:2-5:
WARNING: Use BUG_ON instead of if condition followed by BUG.

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

