Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA040343C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347594AbhIHG1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 02:27:53 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:49552
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S236202AbhIHG1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=tBKOihU0elkgZqOzadlnXUqZui17o+yRY8k+snYrFP4=; b=j
        3nC4H/9kJkhhrKPR8UmYJitt2rz1BBSQPPDHPKPLNGnHCZx1mSzCtt8aCSA6JHLB
        yzzSd75cKutXfUzwigZtCqqKr50NPDMOstQgjnGI/pYj+xuU+jeCodOrts/B/9oT
        LfiHNLgjorfktIJRCDGeClHVeTirB1oahjO6J/75Dw=
Received: from t640 (unknown [10.176.36.8])
        by app1 (Coremail) with SMTP id XAUFCgBHTV2CVzhhbJA1AA--.12868S3;
        Wed, 08 Sep 2021 14:26:10 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Chenyuan Mi <cymi20@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: Fix handle refcount leak in two exception handling paths
Date:   Wed,  8 Sep 2021 14:26:03 +0800
Message-Id: <20210908062603.6723-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgBHTV2CVzhhbJA1AA--.12868S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF17JF1xGrW8KrykGrW7Jwb_yoW8GFW7p3
        y7Kw43Kr4rKa4UA3W8J34vgF1S9ayDKF9rur40ywnrZFs8tw13AryIq34agayrA34rArW7
        XFyakr4Fg3Z8Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
        6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        Jw0_GFylx4CE04Ijxs4lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7sREo7KUUUUUU==
X-CM-SenderInfo: isqsiiisuqikmt6i3vldqovvfxof0/
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference counting issue happens in two exception handling 
paths of ocfs2_replay_truncate_records(). When executing these 
two exception handling paths, the function forgets to decrease 
the refcount of handle increased by ocfs2_start_trans(), causing 
a refcount leak.

Fix this issue by using ocfs2_commit_trans() to decrease the 
refcount of handle in two handling paths.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

---
 fs/ocfs2/alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index f1cc8258d34a..b87960cdda0d 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -5941,7 +5941,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
 						 OCFS2_JOURNAL_ACCESS_WRITE);
 		if (status < 0) {
 			mlog_errno(status);
-			goto bail;
+			goto bail_commit;
 		}
 
 		tl->tl_used = cpu_to_le16(i);
@@ -5965,7 +5965,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
 						     num_clusters);
 			if (status < 0) {
 				mlog_errno(status);
-				goto bail;
+				goto bail_commit;
 			}
 		}
 
@@ -5975,6 +5975,8 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
 
 	osb->truncated_clusters = 0;
 
+bail_commit:
+	ocfs2_commit_trans(osb, handle);
 bail:
 	return status;
 }
-- 
2.17.1

