Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7034B72E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 13:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhC0MO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 08:14:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15024 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0MO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 08:14:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6yQC5XDmzPrgf;
        Sat, 27 Mar 2021 20:12:19 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 20:14:45 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <dhowells@redhat.com>, <linux-afs@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengzengkai@huawei.com>, <huawei.libin@huawei.com>
Subject: [PATCH] afs: fix no return statement in function returning non-void
Date:   Sat, 27 Mar 2021 20:16:24 +0800
Message-ID: <20210327121624.194639-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing return to fix following compilation issue:

fs/afs/dir.c: In function ‘afs_dir_set_page_dirty’:
fs/afs/dir.c:51:1: error: no return statement in function
returning non-void [-Werror=return-type]

Fixes: f3ddee8dc4e2 ("afs: Fix directory handling")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 fs/afs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 17548c1faf02..1795a05b7cb7 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -48,6 +48,7 @@ static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
 static int afs_dir_set_page_dirty(struct page *page)
 {
 	BUG(); /* This should never happen. */
+	return 0;
 }
 
 const struct file_operations afs_dir_file_operations = {
-- 
2.20.1

