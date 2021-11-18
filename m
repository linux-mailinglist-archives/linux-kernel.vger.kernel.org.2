Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6584553B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 05:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbhKRETT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 23:19:19 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:22610 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242867AbhKRETF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 23:19:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ux7kHzU_1637208964;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Ux7kHzU_1637208964)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Nov 2021 12:16:04 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1] mm/damon/schemes: Add the validity judgment of thresholds
Date:   Thu, 18 Nov 2021 12:16:02 +0800
Message-Id: <2ebc35fcafe61f9dfbb61cfb5dd3fa2c567c37fa.1637208947.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dbgfs "schemes" interface, i do some test like this:
    # cd /sys/kernel/debug/damon
    # echo "2 1 2 1 10 1 3 10 1 1 1 1 1 1 1 1 2 3" > schemes
    # cat schemes
    # 2 1 2 1 10 1 3 10 1 1 1 1 1 1 1 1 2 3 0 0

There have some unreasonable places, i set the valules of these variables
"<min_sz, max_sz> <min_nr_a, max_nr_a>, <min_age, max_age>, <wmarks.high,
wmarks.mid, wmarks.low>" as "<2, 1>, <2, 1>, <10, 1>, <1, 2, 3>.

So there add a validity judgment for these threshold values.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/dbgfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index befb27a29aab..a4c94d563d3d 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -215,6 +215,17 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 			goto fail;
 		}
 
+		if (min_sz > max_sz || min_nr_a > max_nr_a || min_age > max_age) {
+			pr_err("mininum > maxinum\n");
+			goto fail;
+		}
+
+		if (wmarks.high < wmarks.mid || wmarks.high < wmarks.low ||
+		    wmarks.mid <  wmarks.low) {
+			pr_err("wrong wmarks\n");
+			goto fail;
+		}
+
 		pos += parsed;
 		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
 				min_age, max_age, action, &quota, &wmarks);
-- 
2.31.0

