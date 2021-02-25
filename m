Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CE832497A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 04:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhBYD2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 22:28:39 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:57997
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S231843AbhBYD2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 22:28:37 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgBnb_shGTdg5dEfAw--.17262S3;
        Thu, 25 Feb 2021 11:27:30 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] mm/swapfile: minor coding style tweaks
Date:   Thu, 25 Feb 2021 11:27:04 +0800
Message-Id: <1614223624-16055-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgBnb_shGTdg5dEfAw--.17262S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1xKr43CF1rGFWfZr15CFg_yoWDCFX_C3
        y8Zws7Grs8XF13uF13Cr45Ar9rWrsxZFyrCryS9Fy3trWrGa4fXrZ2yFyFyrWrZwsYgFW5
        Cw4Ivrn7X3sxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUjKsUDUUUU
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add whitespace to fix coding style issues, improve code reading.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 mm/swapfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 96799a2..d261be4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2767,7 +2767,7 @@ static int swap_show(struct seq_file *swap, void *v)
 	unsigned int bytes, inuse;
 
 	if (si == SEQ_START_TOKEN) {
-		seq_puts(swap,"Filename\t\t\t\tType\t\tSize\t\tUsed\t\tPriority\n");
+		seq_puts(swap, "Filename\t\t\t\tType\t\tSize\t\tUsed\t\tPriority\n");
 		return 0;
 	}
 
@@ -3271,7 +3271,7 @@ static bool swap_discardable(struct swap_info_struct *si)
 					 sizeof(long),
 					 GFP_KERNEL);
 
-	if (p->bdev &&(swap_flags & SWAP_FLAG_DISCARD) && swap_discardable(p)) {
+	if (p->bdev && (swap_flags & SWAP_FLAG_DISCARD) && swap_discardable(p)) {
 		/*
 		 * When discard is enabled for swap with no particular
 		 * policy flagged, we set all swap discard flags here in
-- 
1.8.3.1

