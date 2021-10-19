Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC1943338F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhJSKfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:35:04 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:38777
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S235162AbhJSKfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:35:01 -0400
Received: from fedora33.wangsu.com (unknown [59.61.78.138])
        by app2 (Coremail) with SMTP id 4zNnewD3HeTKnm5h5ogBAA--.3005S2;
        Tue, 19 Oct 2021 18:32:47 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, linf@wangsu.com
Subject: [PATCH] mm: vmstat.c: make extfrag_index show more pretty
Date:   Tue, 19 Oct 2021 18:32:41 +0800
Message-Id: <20211019103241.134797-1-linf@wangsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 4zNnewD3HeTKnm5h5ogBAA--.3005S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4rGrWrZw18CFyfGF15Arb_yoW8Gw4Upr
        4YyF1UJw15GFy7Jw17t3W8Jw1Ut3WkGF18JrW5Xr18Zr1UAr1jyr17trW7tF1DJa4DJrW5
        JF4xJw1Utr1xt37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fragmentation_index may return -1000 and the corresponding formated value
showed by seq_printf will take a negative signatrue, but other positive
formated values don't take a positive signatrue, so the output becomes
unaligned.

before:
Node 0, zone      DMA -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
Node 0, zone    DMA32 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
Node 0, zone   Normal -1.000 -1.000 -1.000 -1.000 0.931 0.966 0.983 0.992 0.996 0.998 0.999

after this patch:
Node 0, zone      DMA -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
Node 0, zone    DMA32 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000 -1.000
Node 0, zone   Normal -1.000 -1.000 -1.000 -1.000  0.931  0.966  0.983  0.992  0.996  0.998  0.999

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 mm/vmstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8ce2620344b2..263d367d193b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2179,7 +2179,7 @@ static void extfrag_show_print(struct seq_file *m,
 	for (order = 0; order < MAX_ORDER; ++order) {
 		fill_contig_page_info(zone, order, &info);
 		index = __fragmentation_index(order, &info);
-		seq_printf(m, "%d.%03d ", index / 1000, index % 1000);
+		seq_printf(m, "%2d.%03d ", index / 1000, index % 1000);
 	}
 
 	seq_putc(m, '\n');
-- 
2.31.1

