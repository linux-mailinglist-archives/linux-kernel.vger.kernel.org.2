Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE19933ED40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCQJm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:42:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49123 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhCQJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:42:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lMSgh-0005in-5F; Wed, 17 Mar 2021 09:41:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: slab: Fix spelling mistake "disired" -> "desired"
Date:   Wed, 17 Mar 2021 09:41:58 +0000
Message-Id: <20210317094158.5762-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a comment. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/slab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index df45c437b394..d56607a80fa6 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2284,7 +2284,7 @@ void __kmem_cache_release(struct kmem_cache *cachep)
  * Because if it is the case, that means we defer the creation of
  * the kmalloc_{dma,}_cache of size sizeof(slab descriptor) to this point.
  * And we eventually call down to __kmem_cache_create(), which
- * in turn looks up in the kmalloc_{dma,}_caches for the disired-size one.
+ * in turn looks up in the kmalloc_{dma,}_caches for the desired-size one.
  * This is a "chicken-and-egg" problem.
  *
  * So the off-slab slab descriptor shall come from the kmalloc_{dma,}_caches,
-- 
2.30.2

