Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432BF3204C5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBTJjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:39:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12629 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTJjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:39:39 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DjNdc0xhvz169WF;
        Sat, 20 Feb 2021 17:37:24 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 17:38:45 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: remove unused FORCE_FG_GC macro
Date:   Sat, 20 Feb 2021 17:38:42 +0800
Message-ID: <20210220093843.64379-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210220093843.64379-1-yuchao0@huawei.com>
References: <20210220093843.64379-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FORCE_FG_GC was introduced by commit 6aefd93b0137 ("f2fs: introduce
background_gc=sync mount option"), but never be used, remove it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 229814b4f4a6..144980b62f9e 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -172,12 +172,10 @@ enum {
 /*
  * BG_GC means the background cleaning job.
  * FG_GC means the on-demand cleaning job.
- * FORCE_FG_GC means on-demand cleaning job in background.
  */
 enum {
 	BG_GC = 0,
 	FG_GC,
-	FORCE_FG_GC,
 };
 
 /* for a function parameter to select a victim segment */
-- 
2.29.2

