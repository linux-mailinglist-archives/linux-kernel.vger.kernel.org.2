Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A303AD9D2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 13:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhFSLcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 07:32:22 -0400
Received: from m12-14.163.com ([220.181.12.14]:56334 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233146AbhFSLcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 07:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sbkz9
        1C9VvI/oDFBSMz+PetJvkdbKgHbo2rZE8Jc2pM=; b=XWxb377YKehNCcu1+LRWs
        TQlZiAbxxhigDOQ+BJYfID85SRE7SeeXLbDm7lgAxC9Mvg5672IngPs+qJicNKi3
        4aUNmj1S7/4OmsFUquiQFYQ5Q/F8yasbf5wpEZGN4OR4X+wJQCTPoLIA7T168KIo
        DXIAZx72vjvEJBxhpcVKk8=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowABXXBg51c1gfpvlPg--.22537S2;
        Sat, 19 Jun 2021 19:30:02 +0800 (CST)
From:   angkery <angkery@163.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        anant.thazhemadam@gmail.com
Cc:     linux-kernel@vger.kernel.org, Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] misc: vmw_vmci: return the correct errno code
Date:   Sat, 19 Jun 2021 19:28:54 +0800
Message-Id: <20210619112854.1720-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABXXBg51c1gfpvlPg--.22537S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1fKF43Ww48Jr4UWw43GFg_yoW3Arg_C3
        y0qrsrWrZ0yasa9wnFkFnxZ34rtrZ8urn3WrnxKry3XFy7Ar1xGr1qqrnxXa4rZrWxAF9x
        Xr1DCa4Iy3WI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeTSoJUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/1tbiLBq2I1spa3wXKQAAs4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

When kzalloc failed, should return -ENOMEM rather than -EINVAL.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
 drivers/misc/vmw_vmci/vmci_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index 26ff49f..c0b5e33 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -107,7 +107,7 @@ struct vmci_ctx *vmci_ctx_create(u32 cid, u32 priv_flags,
 	context = kzalloc(sizeof(*context), GFP_KERNEL);
 	if (!context) {
 		pr_warn("Failed to allocate memory for VMCI context\n");
-		error = -EINVAL;
+		error = -ENOMEM;
 		goto err_out;
 	}
 
-- 
1.9.1

