Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5102459042
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 15:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbhKVOfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 09:35:18 -0500
Received: from mail-m2835.qiye.163.com ([103.74.28.35]:19680 "EHLO
        mail-m2835.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhKVOfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 09:35:17 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2021 09:35:16 EST
Received: from ubuntu.localdomain (unknown [183.221.17.9])
        by mail-m2835.qiye.163.com (Hmail) with ESMTPA id 59DF08A0025;
        Mon, 22 Nov 2021 22:26:54 +0800 (CST)
From:   Yu Chen <chen.yu@easystack.cn>
To:     mcgrof@kernel.org, jeyu@kernel.org
Cc:     chen.yu@easystack.cn, linux-kernel@vger.kernel.org
Subject: [PATCH] module: Remove outdated comment
Date:   Mon, 22 Nov 2021 06:26:48 -0800
Message-Id: <20211122142648.10842-1-chen.yu@easystack.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlCN1dZLVlBSVdZDwkaFQgSH1lBWRpPGRlWQhoZSEJKHkpLH0
        NPVRkRExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6LBw*TzIwTyoYM04QHyk4
        Li4aCzxVSlVKTUhMTkJKSUpPTENMVTMWGhIXVRgTHhVVAg47HhoIAggPGhgQVRgVRVlXWRILWUFZ
        SkNIVUlJSlVKTFVCWVdZCAFZQUpJTk03Bg++
X-HM-Tid: 0a7d480ae9c9841dkuqw59df08a0025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e513cc1c07e2 ("module: Remove stop_machine from module
unloading") this comment is no longer correct. Remove it.

Signed-off-by: Yu Chen <chen.yu@easystack.cn>
---
 kernel/module.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 84a9141..320ec90 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -958,7 +958,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 		}
 	}
 
-	/* Stop the machine so refcounts can't move and disable module. */
 	ret = try_stop_module(mod, flags, &forced);
 	if (ret != 0)
 		goto out;
-- 
2.25.1

