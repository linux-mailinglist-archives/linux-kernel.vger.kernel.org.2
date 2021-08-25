Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89203F6D78
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 04:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbhHYCoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 22:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbhHYCoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 22:44:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B17CC061757;
        Tue, 24 Aug 2021 19:43:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so3149409pjw.2;
        Tue, 24 Aug 2021 19:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CTWJLTSJroYMndBn0PhkaK8v33nMScSCNsUYYunUuks=;
        b=jkjgJ0Dyj4L9f9ubpsjVa2rPGugDKcxnMU0niNCT+QaDJ9bZsCzpX27icvQ89Dzxlq
         Et5mNoP+rSkXNo674nANqXcgXZ6ywtcyveGIbENDbmzhJdbVToseA5fzyedEbxAL3wda
         XDwtARgdhlT+VbFLQHoUcoThlgxmU8YyZ7vN0DVRctbmN9bRW9DjWR36v5HVLLz5KOgI
         829vLbbxpsA+R7654sSImNaZYJtOTzeaghpVAcFX6teBcbh5PfNaTQ4QSB8vOhYNt1lH
         JCJch/RUEV144ysBUw82kq4uTVxJFX8aki90Oqn5fo4VdmFc+bjJOlJypJ2gZTaeMdZD
         U3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CTWJLTSJroYMndBn0PhkaK8v33nMScSCNsUYYunUuks=;
        b=ZoutoH7Iob510UVoAh0aYVFMzFXgtx8tZ+H8mEcj2e+IV+/0A7BNX1dFscU2Y/sYZQ
         N7rmVIhNBmx/0eyHmdv8qGL98w50K9Hwb1cZ0FKwBQtaRrVe/h00RElJeA086UpLIodE
         PiLbA/T2jxz/9QIjRzBFV6eIAbOvElDNbDoDUzAc/ltUDl016MS/vu98b2WUi4qVMT15
         FvBoxWVYkigBQ5Cw7GsK9rCMXObvfciTSyM7WTzTgA6T/KpbGqcBPAHVK2AcrBvTytBR
         YKdv7YQfLvO3wxYLqsiARDcWSUv7jyZn62AZ8/5LHfscjPZQD06e4AeeviZpEzYB4MNk
         g/ew==
X-Gm-Message-State: AOAM530cPtsynEkSLtZqw1cdPZCW5LfG92Nb5e4zR3eKAQf1CFmTNCN+
        GJO3GlBqD5dOuwX7xFaxkpBBR1c9YOTmWA==
X-Google-Smtp-Source: ABdhPJx0j2g2gSzBp6GAuQp/Ysowe1UxNAlp3h3uOMc+mLR+u7XBtznuwgOmpFLz3eQx1Ikyfzwa/A==
X-Received: by 2002:a17:902:dacd:b029:12d:7444:7f87 with SMTP id q13-20020a170902dacdb029012d74447f87mr35911764plx.77.1629859432809;
        Tue, 24 Aug 2021 19:43:52 -0700 (PDT)
Received: from carrot.localdomain (i222-151-22-34.s42.a014.ap.plala.or.jp. [222.151.22.34])
        by smtp.gmail.com with ESMTPSA id d3sm20352082pfa.51.2021.08.24.19.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:43:51 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: use refcount_dec_and_lock() to fix potential UAF
Date:   Wed, 25 Aug 2021 11:43:48 +0900
Message-Id: <1629859428-5906-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

When the refcount is decreased to 0, the resource reclamation branch is
entered. Before CPU0 reaches the race point (1), CPU1 may obtain the
spinlock and traverse the rbtree to find 'root', see nilfs_lookup_root().
Although CPU1 will call refcount_inc() to increase the refcount, it is
obviously too late. CPU0 will release 'root' directly, CPU1 then accesses
'root' and triggers UAF.

Use refcount_dec_and_lock() to ensure that both the operations of decrease
refcount to 0 and link deletion are lock protected eliminates this risk.

     CPU0                      CPU1
nilfs_put_root():
			    <-------- (1)
spin_lock(&nilfs->ns_cptree_lock);
rb_erase(&root->rb_node, &nilfs->ns_cptree);
spin_unlock(&nilfs->ns_cptree_lock);

kfree(root);
			    <-------- use-after-free

========================================================================
refcount_t: underflow; use-after-free.
WARNING: CPU: 2 PID: 9476 at lib/refcount.c:28 \
refcount_warn_saturate+0x1cf/0x210 lib/refcount.c:28
Modules linked in:
CPU: 2 PID: 9476 Comm: syz-executor.0 Not tainted 5.10.45-rc1+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
RIP: 0010:refcount_warn_saturate+0x1cf/0x210 lib/refcount.c:28
... ...
Call Trace:
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 nilfs_put_root+0xc1/0xd0 fs/nilfs2/the_nilfs.c:795
 nilfs_segctor_destroy fs/nilfs2/segment.c:2749 [inline]
 nilfs_detach_log_writer+0x3fa/0x570 fs/nilfs2/segment.c:2812
 nilfs_put_super+0x2f/0xf0 fs/nilfs2/super.c:467
 generic_shutdown_super+0xcd/0x1f0 fs/super.c:464
 kill_block_super+0x4a/0x90 fs/super.c:1446
 deactivate_locked_super+0x6a/0xb0 fs/super.c:335
 deactivate_super+0x85/0x90 fs/super.c:366
 cleanup_mnt+0x277/0x2e0 fs/namespace.c:1118
 __cleanup_mnt+0x15/0x20 fs/namespace.c:1125
 task_work_run+0x8e/0x110 kernel/task_work.c:151
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:164 [inline]
 exit_to_user_mode_prepare+0x13c/0x170 kernel/entry/common.c:191
 syscall_exit_to_user_mode+0x16/0x30 kernel/entry/common.c:266
 do_syscall_64+0x45/0x80 arch/x86/entry/common.c:56
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

There is no reproduction program, and the above is only theoretical
analysis.

Fixes: ba65ae4729bf ("nilfs2: add checkpoint tree to nilfs object")
Link: https://lkml.kernel.org/r/20210723012317.4146-1-thunder.leizhen@huawei.com
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/the_nilfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 8b7b01a380ce..c8bfc01da5d7 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -792,14 +792,13 @@ struct nilfs_root *
 
 void nilfs_put_root(struct nilfs_root *root)
 {
-	if (refcount_dec_and_test(&root->count)) {
-		struct the_nilfs *nilfs = root->nilfs;
+	struct the_nilfs *nilfs = root->nilfs;
 
-		nilfs_sysfs_delete_snapshot_group(root);
-
-		spin_lock(&nilfs->ns_cptree_lock);
+	if (refcount_dec_and_lock(&root->count, &nilfs->ns_cptree_lock)) {
 		rb_erase(&root->rb_node, &nilfs->ns_cptree);
 		spin_unlock(&nilfs->ns_cptree_lock);
+
+		nilfs_sysfs_delete_snapshot_group(root);
 		iput(root->ifile);
 
 		kfree(root);
-- 
1.8.3.1

