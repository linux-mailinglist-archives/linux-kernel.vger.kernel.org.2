Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F7C42A025
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhJLIpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:45:17 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:40656 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235237AbhJLIpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:45:16 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-03 (Coremail) with SMTP id rQCowAC3vamLSmVhcXBJAw--.40210S2;
        Tue, 12 Oct 2021 16:42:51 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] XArray: Fix xa_to_node by adding xa_is_node
Date:   Tue, 12 Oct 2021 08:42:50 +0000
Message-Id: <1634028170-1753612-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: rQCowAC3vamLSmVhcXBJAw--.40210S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr43JrW5Zry5AF4xAr48Xrb_yoWkJrbEka
        1xWr1ftr1Y9Fs3Xw1jganYq3yvy395CFWFqw1kGFZxC34UJr9rXr95Zr1q93ZF9rZ09Fy7
        Jr45ArWakryxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjxR65UUUUU==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly using xa_to_node may lead to the compulsory type
conversion of unknown type,which is unsafe.
So it might be better that adding xa_is_node before.

Fixes: 58d6ea3 ("xarray: Add XArray unconditional store operations")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 lib/test_xarray.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 8b1c318..7ad3d51 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -606,8 +606,10 @@ static noinline void check_multi_store(struct xarray *xa)
 	XA_BUG_ON(xa, xa_load(xa, 1) != xa_mk_value(0));
 	XA_BUG_ON(xa, xa_load(xa, 2) != NULL);
 	rcu_read_lock();
-	XA_BUG_ON(xa, xa_to_node(xa_head(xa))->count != 2);
-	XA_BUG_ON(xa, xa_to_node(xa_head(xa))->nr_values != 2);
+	if (xa_is_node(xa_head(xa))) {
+		XA_BUG_ON(xa, xa_to_node(xa_head(xa))->count != 2);
+		XA_BUG_ON(xa, xa_to_node(xa_head(xa))->nr_values != 2);
+	}
 	rcu_read_unlock();
 
 	/* Storing adjacent to the value does not alter the value */
-- 
2.7.4

