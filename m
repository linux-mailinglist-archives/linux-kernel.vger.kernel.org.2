Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047E134E724
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhC3MH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:07:56 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:42970 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhC3MHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:07:43 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id A6ACC400123;
        Tue, 30 Mar 2021 20:07:41 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] kernel/module: Use BUG_ON instead of if condition followed by BUG.
Date:   Tue, 30 Mar 2021 05:07:34 -0700
Message-Id: <1617106055-6295-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSkMYSUNDTB0eSE4eVkpNSkxKS01LTUpMQkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTY6CCo6UT8OTzczDxIVUSNL
        FhUaFApVSlVKTUpMSktNS01JS0pPVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpJSUk3Bg++
X-HM-Tid: 0a78830849a3d991kuwsa6acc400123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be optimized at compile time.

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

