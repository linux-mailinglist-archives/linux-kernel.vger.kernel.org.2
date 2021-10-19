Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779584333D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhJSKuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:50:44 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:52471
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S235224AbhJSKuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:50:40 -0400
Received: from fedora33.wangsu.com (unknown [59.61.78.138])
        by app2 (Coremail) with SMTP id 4zNnewBHbuRuom5hgooBAA--.3123S2;
        Tue, 19 Oct 2021 18:48:19 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, linf@wangsu.com
Subject: [PATCH] mm/readahead.c: fix incorrect comments for get_init_ra_size
Date:   Tue, 19 Oct 2021 18:48:12 +0800
Message-Id: <20211019104812.135602-1-linf@wangsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 4zNnewBHbuRuom5hgooBAA--.3123S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr48Wr15CF4xCw1DWry3Arb_yoW3uFX_Ca
        18Kw4qgFZ3Gr4av3WYvw4xXFWFgrykuryDuF47XrW7J3y8uF98Wa4Dtr17Gr1xXr4qyw17
        WrW3WFW7Cr43GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fact, formated values returned by get_init_ra_size are not that
intuitive. This patch make the comments reflect its truth.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 mm/readahead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 41b75d76d36e..88a84f254ed6 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -309,7 +309,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
  * Set the initial window size, round to next power of 2 and square
  * for small size, x 4 for medium, and x 2 for large
  * for 128k (32 page) max ra
- * 1-8 page = 32k initial, > 8 page = 128k initial
+ * 1-2 page = 16k, 3-4 page 32k, 5-8 page = 64k, > 8 page = 128k initial
  */
 static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
 {
-- 
2.31.1

