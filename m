Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AC455BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344793AbhKRMth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:49:37 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:40560 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344779AbhKRMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:49:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UxCJM88_1637239590;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UxCJM88_1637239590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Nov 2021 20:46:30 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/damon/schemes: Add the validity judgment of thresholds
Date:   Thu, 18 Nov 2021 20:46:24 +0800
Message-Id: <d78360e52158d786fcbf20bc62c96785742e76d3.1637239568.git.xhao@linux.alibaba.com>
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

So there add a validity judgment for these thresholds value.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/dbgfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index befb27a29aab..4a96cd4df24f 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -215,6 +215,13 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 			goto fail;
 		}

+		if (min_sz > max_sz || min_nr_a > max_nr_a || min_age > max_age)
+			goto fail;
+
+		if (wmarks.high < wmarks.mid || wmarks.high < wmarks.low ||
+		    wmarks.mid <  wmarks.low)
+			goto fail;
+
 		pos += parsed;
 		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
 				min_age, max_age, action, &quota, &wmarks);
--
2.31.0
