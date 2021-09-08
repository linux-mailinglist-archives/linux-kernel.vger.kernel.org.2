Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26D14037BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348332AbhIHKWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:22:36 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:36532
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S231723AbhIHKWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=VHnWdqESa93w75cueAST1+9bYfvGTN4Oz3FApTzNEAw=; b=K
        zAXpWgU2FXvHBwyrtLJulOGC64YgtbIAj2jdRYSfpMk7ohQk/ha+pBNWRsrllUpJ
        IOlJ4SGXtzluT6Nj2M9+12Pb9rJgRqmOZyMowtIHc38uQnrWhq1GZp8cGdwYTSQ1
        zSzz/IpAYgLcJal5nRYiuuG245jTakUzH4IuUmM/jk=
Received: from t640 (unknown [10.176.36.8])
        by app1 (Coremail) with SMTP id XAUFCgD3VmSJjjhhYiA3AA--.1544S3;
        Wed, 08 Sep 2021 18:20:57 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Chenyuan Mi <cymi20@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ocfs2: Fix handle refcount leak in two exception handling paths
Date:   Wed,  8 Sep 2021 18:20:55 +0800
Message-Id: <20210908102055.10168-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgD3VmSJjjhhYiA3AA--.1544S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF17JF1xGrW8KFykAF43ZFb_yoW8JFWfp3
        y7Kw43Krs5GFy8A3Z3J34kWF1fuayDKF9rZr4vy34DZF45Jw1ayrWFgw1jgFWrAryrAF17
        XF1akr4Y9ayUCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwC2zVAIFx02awCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjTRAl1kUUUUU
X-CM-SenderInfo: isqsiiisuqikmt6i3vldqovvfxof0/
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference counting issue happens in two exception handling paths
of ocfs2_replay_truncate_records(). When executing these two exception
handling paths, the function forgets to decrease the refcount of handle
increased by ocfs2_start_trans(), causing a refcount leak.

Fix this issue by using ocfs2_commit_trans() to decrease the refcount
of handle in two handling paths.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/ocfs2/alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index f1cc8258d34a..b05fde7edc3a 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -5940,6 +5940,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
 		status = ocfs2_journal_access_di(handle, INODE_CACHE(tl_inode), tl_bh,
 						 OCFS2_JOURNAL_ACCESS_WRITE);
 		if (status < 0) {
+			ocfs2_commit_trans(osb, handle);
 			mlog_errno(status);
 			goto bail;
 		}
@@ -5964,6 +5965,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
 						     data_alloc_bh, start_blk,
 						     num_clusters);
 			if (status < 0) {
+				ocfs2_commit_trans(osb, handle);
 				mlog_errno(status);
 				goto bail;
 			}
-- 
2.17.1

