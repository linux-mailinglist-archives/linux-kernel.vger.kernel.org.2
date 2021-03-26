Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8F34A00A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhCZDD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:03:59 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:31032 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhCZDDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:03:30 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 66548400120;
        Fri, 26 Mar 2021 11:03:27 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] mm/zsmalloc: Use BUG_ON instead of if condition followed by BUG.
Date:   Thu, 25 Mar 2021 20:03:17 -0700
Message-Id: <1616727798-9110-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTkxDGBkYShkeS04YVkpNSk1MSUxDS0xNS09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSI6USo5Az8QEj0jNDM1GggC
        PhIaFC9VSlVKTUpNTElMQ0tDT0NMVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlLSEs3Bg++
X-HM-Tid: 0a786c7c9634d991kuws66548400120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be optimized at compile time.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 mm/zsmalloc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 30c358b..58697f7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1987,8 +1987,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 		head = obj_to_head(page, addr);
 		if (head & OBJ_ALLOCATED_TAG) {
 			handle = head & ~OBJ_ALLOCATED_TAG;
-			if (!testpin_tag(handle))
-				BUG();
+			BUG_ON(!testpin_tag(handle));
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
@@ -2035,8 +2034,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 		head = obj_to_head(page, addr);
 		if (head & OBJ_ALLOCATED_TAG) {
 			handle = head & ~OBJ_ALLOCATED_TAG;
-			if (!testpin_tag(handle))
-				BUG();
+			BUG_ON(!testpin_tag(handle));
 			unpin_tag(handle);
 		}
 	}
-- 
2.7.4

