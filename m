Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACD73953C8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 03:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhEaB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 21:58:14 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3293 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhEaB6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 21:58:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FtdZD6zdZz1BGmJ;
        Mon, 31 May 2021 09:51:48 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:56:28 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 31 May
 2021 09:56:28 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>
Subject: [PATCH -next] mm/mmap_lock: fix warning when CONFIG_TRACING is not defined
Date:   Mon, 31 May 2021 09:55:27 +0800
Message-ID: <20210531015527.49785-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning: [-Wunused-function]
mm/mmap_lock.c:157:20: warning: ‘get_mm_memcg_path’ defined but not used
 static const char *get_mm_memcg_path(struct mm_struct *mm)
                    ^~~~~~~~~~~~~~~~~

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 mm/mmap_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 03ee85c696ef..ec7899b08690 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -154,7 +154,7 @@ static inline void put_memcg_path_buf(void)
  * The caller must call put_memcg_path_buf() once the buffer is no longer
  * needed. This must be done while preemption is still disabled.
  */
-static const char *get_mm_memcg_path(struct mm_struct *mm)
+static const char __maybe_unused *get_mm_memcg_path(struct mm_struct *mm)
 {
 	char *buf = NULL;
 	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
-- 
2.17.1

