Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F153FE81A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 05:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbhIBDjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 23:39:19 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:60324 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233122AbhIBDjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 23:39:18 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowAD3ItEWRzBh1MM4AQ--.62571S2;
        Thu, 02 Sep 2021 11:37:58 +0800 (CST)
From:   jiasheng <jiasheng@iscas.ac.cn>
To:     linux-kernel@vger.kernel.org
Cc:     jiasheng <jiasheng@iscas.ac.cn>
Subject: [PATCH 10/10] seqlock: Add do_read_seqcount_retry() in front of seqcount_lockdep_reader_access() in read_seqbegin()
Date:   Thu,  2 Sep 2021 03:37:56 +0000
Message-Id: <1630553876-484166-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAD3ItEWRzBh1MM4AQ--.62571S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy5ArWDJFW8Xry5uFWDtwb_yoW8JF4Dpw
        1kury8Kr4FkF1xuayDJ39FvFyrtwn7AFnrXrZav34avF13tw4aq3yUur4ayF1UZw4IyF4j
        qFW7WFsxZFsrGFJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
        JwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
        C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUxwI3UUUUU==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have found that in the complied files seqcount_lockdep_reader_access()
appear more than 20 times, and under at least 90% circumstances
that do_read_seqcount_retry() and seqcount_lockdep_reader_access()
appear in pairs.
For example, they appear together in the irqfd_wakeup()
of the file complie from 'virt/kvm/eventfd.c'.
But we have found that in the read_seqbegin(), there is only
seqcount_lockdep_reader_access() instead of the pair.
Therefore, we consider that the do_read_seqcount_retry()
might be forgotten.

Signed-off-by: jiasheng <jiasheng@iscas.ac.cn>
---
 include/linux/seqlock.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index f61e34f..14169ce 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -837,8 +837,10 @@ typedef struct {
  */
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
-	unsigned ret = read_seqcount_begin(&sl->seqcount);
-
+	unsigned int ret = 0;
+
+	if (read_seqcount_retry(&sl->seqcount, ret))
+		ret = read_seqcount_begin(&sl->seqcount);
 	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry() */
 	kcsan_flat_atomic_begin();
 	return ret;
-- 
2.7.4

