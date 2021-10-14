Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0129342E1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhJNTHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhJNTHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:07:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C195CC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:05:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q12so3476529pgq.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5G1Z7zdFjuQv3OgjKzHJqIpbQjtxeWAIqHbYudxE9M=;
        b=mLotX/DKZtpaXvvJqOeci5zOTa59irH0vZ9c+N7SGXeVHVz79wT/MkYwrSsTzQQL/W
         f9JaXuDYgE5RqWGuHz8lB+nklGHaYsIm0w3IktJkzfvEiqy1hz4uvSuRtJy0qLnFBDDV
         vNxp5T86Qtq51D2MNd1Mx9DTgTcLVMHwb86zO4OyzknkTQceAiBdXoTKn9dCBMs6qr1J
         jaFHKLnXZ4Dw1fBSJiimyxUoBpvzl3WjqajbRJ1bQPzgUFG80WigBTPBraGLZKfvs0Ng
         BGOlTUh+AOTgq4p4MHysDV6s4kUn5ovlXcUtxBM7s5DtZBZ4vg7fNu/toQuPu7/ad8FM
         oGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5G1Z7zdFjuQv3OgjKzHJqIpbQjtxeWAIqHbYudxE9M=;
        b=sDn1zf2mDsrEdM5r6BpA5xWw7g6jATVXGbc04n6IsdrIzZVIqsu6EO3wMXjIwuyjJL
         O6hKG6U4Zsdabx89He5MtmrPspF+TfqGJvSzr9Gkq41sXvdNRG1kiMIaO5kk+xVh1Y3t
         ywatxTvKvRaHq56oWPCMHnYwSqoB9nP44fzNOsW/KSEXHM2MrUp/1wJph9zibtv68TFD
         rbacaQ8W+jMivcabxklVXZ0CMq29YLQWOptj/Q5sm5k/zf8C53SmKXaVLlTt/j8d1PVu
         qxFNUScqVciXgIA5cp0QXiabFwJcz8w8kK8VQL1x8sGIGU+kdw7yCtmmpvvk5NrX+7a4
         JMiw==
X-Gm-Message-State: AOAM5302wCoxOpGu8UbtJyOFHOk4JKU3+UyaBEjVDPy2CMxWMk1/WWBU
        MOP8lEmiBUtW67rLm8Fi0vuCO5jYKg4=
X-Google-Smtp-Source: ABdhPJyn78db7DKSxkPDgSKP11vWPzSExNwqSJ0yfUi7m1VTMuv6blAIWPgV84C17qfchgHKXuqliA==
X-Received: by 2002:a63:1cd:: with SMTP id 196mr5534401pgb.39.1634238310672;
        Thu, 14 Oct 2021 12:05:10 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:d1c9:d6a2:4655:3944])
        by smtp.gmail.com with ESMTPSA id t3sm3134098pfb.100.2021.10.14.12.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:05:07 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: remove circular locking between sb_internal and fs_reclaim
Date:   Thu, 14 Oct 2021 12:05:03 -0700
Message-Id: <20211014190503.717830-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We detected the below circular locking dependency between sb_internal
and fs_reclaim. So, removed it by calling dquot_initialize() before
sb_start_intwrite().

 ======================================================
 WARNING: possible circular locking dependency detected
 ------------------------------------------------------
 kswapd0/133 is trying to acquire lock:
ffffff80d5fb9680 (sb_internal#2){.+.+}-{0:0}, at: evict+0xd4/0x2f8

but task is already holding lock:
ffffffda597c93a8 (fs_reclaim){+.+.}-{0:0}, at:
__fs_reclaim_acquire+0x4/0x50

which lock already depends on the new lock.
...
other info that might help us debug this:

 Chain exists of:

sb_internal#2 --> &s->s_dquot.dqio_sem --> fs_reclaim

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(fs_reclaim);
                                lock(&s->s_dquot.dqio_sem);
                                lock(fs_reclaim);
   lock(sb_internal#2);

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 86eeb019cc52..a133932333c5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1370,6 +1370,8 @@ static int f2fs_drop_inode(struct inode *inode)
 			/* should remain fi->extent_tree for writepage */
 			f2fs_destroy_extent_node(inode);
 
+			dquot_initialize(inode);
+
 			sb_start_intwrite(inode->i_sb);
 			f2fs_i_size_write(inode, 0);
 
-- 
2.33.0.1079.g6e70778dc9-goog

