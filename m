Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BB41984A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhI0P5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhI0P5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:57:04 -0400
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Sep 2021 08:55:26 PDT
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3850C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:55:26 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id C4D887056; Mon, 27 Sep 2021 17:45:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valentin-vidic.from.hr; s=2020; t=1632757523;
        bh=uINzckaHWRAB6bDI1ZJ2oBSaftYRznM27HEgddxJZKM=;
        h=From:To:Cc:Subject:Date:From;
        b=eSO8ov2jfCvB+3BlliFk88AdmhWOL8hzLCPoXRUuz8hCrrwE7txUkyeHpgicqVVHR
         QxWVF8anepK+dq/aMWHuYAh3XOLMEf6joPjPpGDqFEEy4BaxinGnB1oH15VnGLX+3I
         9MG9UgyDVhsfHoynwPSSp7uEjynw0Q+XBG7R6/Mx6CxEVYSNsJTTfHdeqhmyQ1OAgE
         DkCzUOLZkh23aVTlVTG+cnzS2HOyWUz2LxPQ5JVI/jxqNtp7n7oHs+ddL8WiVXp74T
         nN8erRqaNgyd6gUcqb7QVN43aurGy7X37wETW8arEV9cSK3gkIVUoupWnSESCfQevl
         /lSpBtMi9MMXITru5LSd0BFLE1J9ag5qif9mBEBPYLYGUUnFJNcVBwTJVRzBnysKuq
         ZXo8xTCR5/ChyKCf3s6YwXKr2XNYS2gP4MhKm+8gwmqNasn/qFmIvFuEWL34a4JOCh
         rgviaq+1Go34PPzByjtmdEtETgii61e5jn4Yn/ngbYajIP414FKeJ092Q/u4+SK8Kd
         BmQrbrLjKz8MRYcWvQcpIn37Tieu/pZ78pJXZwMdQRL2NthBDQ7ai+xO/PKGrcmA+P
         AAQvr/Kb8mWotWtrwMB5+2tKFc4JuxkX5zc9RYOdDdxfa9M9kOTbGxCKppBkopTVkZ
         yNChzp/N5lsO9jbeCCbvJy3g=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] ocfs2: mount fails with buffer overflow in strlen
Date:   Mon, 27 Sep 2021 17:44:59 +0200
Message-Id: <20210927154459.15976-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with kernel v5.11 mouting an ocfs2 filesystem with either o2cb
or pcmk cluster stack fails with the trace below. Problem seems to be
that strings for cluster stack and cluster name are not guaranteed to be
null terminated in the disk representation, while strlcpy assumes that
the source string is always null terminated. This causes a read outside
of the source string triggering the buffer overflow detection.

detected buffer overflow in strlen
------------[ cut here ]------------
kernel BUG at lib/string.c:1149!
invalid opcode: 0000 [#1] SMP PTI
CPU: 1 PID: 910 Comm: mount.ocfs2 Not tainted 5.14.0-1-amd64 #1
  Debian 5.14.6-2
RIP: 0010:fortify_panic+0xf/0x11
...
Call Trace:
 ocfs2_initialize_super.isra.0.cold+0xc/0x18 [ocfs2]
 ocfs2_fill_super+0x359/0x19b0 [ocfs2]
 mount_bdev+0x185/0x1b0
 ? ocfs2_remount+0x440/0x440 [ocfs2]
 legacy_get_tree+0x27/0x40
 vfs_get_tree+0x25/0xb0
 path_mount+0x454/0xa20
 __x64_sys_mount+0x103/0x140
 do_syscall_64+0x3b/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 fs/ocfs2/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index c86bd4e60e20..1dea535224df 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2169,9 +2169,10 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	if (ocfs2_clusterinfo_valid(osb)) {
 		osb->osb_stackflags =
 			OCFS2_RAW_SB(di)->s_cluster_info.ci_stackflags;
-		strlcpy(osb->osb_cluster_stack,
+		memcpy(osb->osb_cluster_stack,
 		       OCFS2_RAW_SB(di)->s_cluster_info.ci_stack,
-		       OCFS2_STACK_LABEL_LEN + 1);
+		       OCFS2_STACK_LABEL_LEN);
+		osb->osb_cluster_stack[OCFS2_STACK_LABEL_LEN] = '\0';
 		if (strlen(osb->osb_cluster_stack) != OCFS2_STACK_LABEL_LEN) {
 			mlog(ML_ERROR,
 			     "couldn't mount because of an invalid "
@@ -2180,9 +2181,10 @@ static int ocfs2_initialize_super(struct super_block *sb,
 			status = -EINVAL;
 			goto bail;
 		}
-		strlcpy(osb->osb_cluster_name,
+		memcpy(osb->osb_cluster_name,
 			OCFS2_RAW_SB(di)->s_cluster_info.ci_cluster,
-			OCFS2_CLUSTER_NAME_LEN + 1);
+			OCFS2_CLUSTER_NAME_LEN);
+		osb->osb_cluster_name[OCFS2_CLUSTER_NAME_LEN] = '\0';
 	} else {
 		/* The empty string is identical with classic tools that
 		 * don't know about s_cluster_info. */
-- 
2.30.2

