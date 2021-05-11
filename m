Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EEC37A46E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhEKKTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:19:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2628 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhEKKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:18:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FfYhp4p5hzlcfM;
        Tue, 11 May 2021 18:15:38 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 18:17:42 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 1/2] f2fs: atgc: fix to set default age threshold
Date:   Tue, 11 May 2021 18:17:34 +0800
Message-ID: <20210511101735.15573-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default age threshold value is missed to set, fix it.

Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
Reported-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 1105c02d6768..40c2af91ccb1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1823,6 +1823,7 @@ static void init_atgc_management(struct f2fs_sb_info *sbi)
 	am->candidate_ratio = DEF_GC_THREAD_CANDIDATE_RATIO;
 	am->max_candidate_count = DEF_GC_THREAD_MAX_CANDIDATE_COUNT;
 	am->age_weight = DEF_GC_THREAD_AGE_WEIGHT;
+	am->age_threshold = DEF_GC_THREAD_AGE_THRESHOLD;
 }
 
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
-- 
2.29.2

