Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B52401CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbhIFOKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:10:04 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:14570 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242521AbhIFOKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:10:03 -0400
X-QQ-mid: bizesmtp31t1630937306t5fm3lmy
Received: from localhost.localdomain (unknown [171.223.98.107])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 06 Sep 2021 22:08:25 +0800 (CST)
X-QQ-SSF: 01000000004000C0D000B00A0000000
X-QQ-FEAT: 36bcWu7HFRCmh4e2P0JhJujmco/+eqj513/Fm6sVpVjLsErKWabJsTzNJ55bq
        fnSU2Yv6JI0vCaFbBkontk4+gDly7CQbVogOQVEM18RbKhczNmUWUpFP/3sv9c0/Q6ug0ij
        4D0q5ZZwEWB9FFuWugQvzN3qvG+C4KS1rCxBE06AGx3L4ev98WGHbGTusB19r4KGhlgftmG
        xVzTJwU3mz/WdBZWvqQrGdgw+W5Ryptu5iXqAAtvwg4kc63cRyE3lZiSk613XEhL5UbqdO4
        tJ8g86qV/n7He3QV5VexCDe6kd9og8+Vy6A9lxZnOX0sgE4vqPOVAS/DW7hq77BkuwaK4ya
        OQIa/cRUF1jkYUEjTCW1VFIolhT9Q==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linux@armlinux.org.uk
Cc:     akpm@linux-foundation.org, david@redhat.com, rppt@kernel.org,
        wangborong@cdjrlc.com, willy@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mm: Fix typo in a comment
Date:   Mon,  6 Sep 2021 22:08:23 +0800
Message-Id: <20210906140823.118213-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/page page/page/

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm/mm/copypage-v4mc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index f1da3b439b96..d06f57a51a74 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -5,7 +5,7 @@
  *  Copyright (C) 1995-2005 Russell King
  *
  * This handles the mini data cache, as found on SA11x0 and XScale
- * processors.  When we copy a user page page, we map it in such a way
+ * processors.  When we copy a user page, we map it in such a way
  * that accesses to this page will not touch the main data cache, but
  * will be cached in the mini data cache.  This prevents us thrashing
  * the main data cache on page faults.
-- 
2.33.0

