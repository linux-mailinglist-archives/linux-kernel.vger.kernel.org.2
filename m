Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4D43683B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhJUQqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:46:36 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38870 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230072AbhJUQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:46:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UtAXCKO_1634834657;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UtAXCKO_1634834657)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Oct 2021 00:44:17 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/damon/dbgfs: Optimize target_ids interface write operation
Date:   Fri, 22 Oct 2021 00:44:16 +0800
Message-Id: <bc341f48b5558f6816dcef22eca4f4a590efdc67.1634834628.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we want to clear previously set target ids,
For example, it works as below now:
    # echo 42 > target_ids
    # cat target_ids
    42
    # echo > target_ids
    # cat target_ids

But in 'dbgfs_target_ids_write', there is no need to
execute other codes, except call 'damon_set_targets'
to clear previously set target ids. So there adds
the 'nr_targets' judgment, if the value is 0, just
call 'damon_set_targets', and then return.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/dbgfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index a02cf6bee8e8..1d83f4138fad 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -362,6 +362,12 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		goto out;
 	}

+	if (!nr_targets) {
+		/* remove targets with previously-set primitive */
+		damon_set_targets(ctx, NULL, 0);
+		goto free_targets_out;
+	}
+
 	if (id_is_pid) {
 		for (i = 0; i < nr_targets; i++) {
 			targets[i] = (unsigned long)find_get_pid(
--
2.31.0
