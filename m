Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6574D399B92
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhFCHaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:30:23 -0400
Received: from m12-14.163.com ([220.181.12.14]:32844 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFCHaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XJ/QH
        K8DEwtDUACyCCZ+St+SThepZsoGSGZ/hVCIqbQ=; b=BdDmLhMFuPlbxRb3kMq46
        /KRSqdr6aas/hal1YDmXrU4AOokrYueYUHKIL00FG7m8PWLogc5NyGuA5/SyJMKN
        6j2GW7eESKi5DMZHUBEG2MiHtiLly6atovLslmBk5OARdkLcvy5dz+ZNO3tU+GIH
        R2rVMVABRg+GIbTiWiVORo=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowAAXHFTSg7hgBX5YMg--.45696S2;
        Thu, 03 Jun 2021 15:25:07 +0800 (CST)
From:   13145886936@163.com
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] mm: opt code indent
Date:   Thu,  3 Jun 2021 00:25:03 -0700
Message-Id: <20210603072503.4265-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAXHFTSg7hgBX5YMg--.45696S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW5WFWxKw1UZrWrZr15CFg_yoWxZrb_XF
        n7trW8KrW5Jr9aka4qyw4SqrW2v3y09rZFk3WUJF13JFyUtw4S9w1DGrW3ur1qvr98J3sx
        X34rt3yYkr12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeBMKtUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiyhOmg1QHMQ+lkgAAsm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Code indent should use tabs where possible.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b9a6db6a7d4f..f4f2adafb526 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1989,7 +1989,7 @@ void lock_page_memcg(struct page *page)
 	 * The RCU lock is held throughout the transaction.  The fast
 	 * path can get away without acquiring the memcg->move_lock
 	 * because page moving starts with an RCU grace period.
-         */
+	 */
 	rcu_read_lock();
 
 	if (mem_cgroup_disabled())
-- 
2.25.1

