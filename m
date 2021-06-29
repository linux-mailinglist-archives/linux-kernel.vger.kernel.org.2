Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9C3B700C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhF2JZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:25:13 -0400
Received: from m12-12.163.com ([220.181.12.12]:52318 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232614AbhF2JZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=2IFJwus0pkEsCVVjuo
        0SmrtcURGJHkcj08Y0nJHOo7Q=; b=GH/s/ppWW88xkERZ5du9MPajZodIkEPWfw
        NB3Gi6RWKIAyBVm8iVYl7bgZOlOcKO94wqi0akh5X5mDGdVizdLMulsbuxa8dhCd
        EECc7O6DL8fYVTnMZg0EUYIQEdZOSpAqxO4F2zQ9BqP4Rc7+zFYHPspBUCIBAIzl
        AHFoxdVyE=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowABHHzCY4tpgdGV3MQ--.41752S2;
        Tue, 29 Jun 2021 17:06:33 +0800 (CST)
From:   lijian_8010a29@163.com
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: ntfs: super: removed unneeded semicolon
Date:   Tue, 29 Jun 2021 09:06:15 +0000
Message-Id: <20210629090615.114432-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowABHHzCY4tpgdGV3MQ--.41752S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr45Jw43ZF4UuryDJw45GFg_yoWfXrg_ua
        yxCFWxAFWDJryjk393KanrtFWayw4rCF12gFnrKFyYgF45t3y5tr4qqrWFqr45ur43Zr4D
        Cw4jkrW3ur43GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU55R67UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbi3xnAUGB0GqwxOgAAs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijian <lijian@yulong.com>

removed unneeded semicolon ';'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/ntfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 0d7e948cb29c..a45e06fa8a73 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1612,7 +1612,7 @@ static bool load_and_init_attrdef(ntfs_volume *vol)
 		memcpy((u8*)vol->attrdef + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
@@ -1681,7 +1681,7 @@ static bool load_and_init_upcase(ntfs_volume *vol)
 		memcpy((char*)vol->upcase + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
-- 
2.17.1


