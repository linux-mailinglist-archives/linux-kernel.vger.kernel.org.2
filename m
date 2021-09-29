Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA4441CB84
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbhI2SJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344935AbhI2SJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:09:27 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC9C061765
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:07:45 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 8E8D270E4; Wed, 29 Sep 2021 20:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valentin-vidic.from.hr; s=2020; t=1632938853;
        bh=a4hgCGqLnOw4G78VKKZ4rKp4IkCN+FVD1nc+E4fDymY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdS2bbQB9uPYAZo21xxdKc66KYqEP4/cqU1xWRvfIUmc+JSkrePKVBZE+33WnULTg
         A092ivEz9xBe+QWnxKY/4Ogu/muIrZCYCbgy36rvMopygg8nh9DRLh2bNtYpfghtI9
         8kUYzks+EfhGQPCAN2CEskpZdli/42er4qjDiMK6hjHjFfvBPk1FKHaDQxWJkL+Twm
         COvgI658MLmREAFhFSV3u2IKDiTZU0NuXUnq+kkNwuKfF+G+o+tnBbQcHGaxbrw6jg
         2EQ5p5LvRUnyGH/BbORo9seeLtk5feEdDPVs4l92W59WmrZJ1zUoLvyq6ZCDYb1Rrm
         owuB5SqnMc/dSI/GQGogGY7sEBQDX3sRcEVXw8TgIo44PnxnNjoBHSX2/ckfpBu+iR
         QdlYHFlvk+t0zSn+UZPvGDpYmH/BT6lYIDe4yKRXwQ/hQAYBM7adhrlbx9L4JCKk+G
         2sjvn1vBCutEEDmzyt+f7l/mpNgvE0AHtsBdyABkGICg0RcCJ0hOcv+cJTI7VHcSu7
         RWyonXgDD+udaOvuWHbNvskTOK7YV5+OCoiRntLDG61iyn/aecdWMVPPZloFM5/mQx
         eKST4jGW8Y2MzhsooCSW45Nqi5tkDg5eCAgI9/3Kt0N6v+Ql4IL2alC+xdaDE9pLI5
         bXpMPF7xYBWsUy/iLOICzMm4=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH v2] ocfs2: mount fails with buffer overflow in strlen
Date:   Wed, 29 Sep 2021 20:06:54 +0200
Message-Id: <20210929180654.32460-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1ab61ba3-8c9b-092c-7843-9c45b58e3987@linux.alibaba.com>
References: <1ab61ba3-8c9b-092c-7843-9c45b58e3987@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with kernel 5.11 built with CONFIG_FORTIFY_SOURCE mouting an
ocfs2 filesystem with either o2cb or pcmk cluster stack fails with the
trace below. Problem seems to be that strings for cluster stack and
cluster name are not guaranteed to be null terminated in the disk
representation, while strlcpy assumes that the source string is always
null terminated. This causes a read outside of the source string
triggering the buffer overflow detection.

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
v2: update description, add comment, drop null termination

 fs/ocfs2/super.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index c86bd4e60e20..5c914ce9b3ac 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2167,11 +2167,17 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	}
 
 	if (ocfs2_clusterinfo_valid(osb)) {
+		/*
+		 * ci_stack and ci_cluster in ocfs2_cluster_info may not be null
+		 * terminated, so make sure no overflow happens here by using
+		 * memcpy. Destination strings will always be null terminated
+		 * because osb is allocated using kzalloc.
+		 */
 		osb->osb_stackflags =
 			OCFS2_RAW_SB(di)->s_cluster_info.ci_stackflags;
-		strlcpy(osb->osb_cluster_stack,
+		memcpy(osb->osb_cluster_stack,
 		       OCFS2_RAW_SB(di)->s_cluster_info.ci_stack,
-		       OCFS2_STACK_LABEL_LEN + 1);
+		       OCFS2_STACK_LABEL_LEN);
 		if (strlen(osb->osb_cluster_stack) != OCFS2_STACK_LABEL_LEN) {
 			mlog(ML_ERROR,
 			     "couldn't mount because of an invalid "
@@ -2180,9 +2186,9 @@ static int ocfs2_initialize_super(struct super_block *sb,
 			status = -EINVAL;
 			goto bail;
 		}
-		strlcpy(osb->osb_cluster_name,
+		memcpy(osb->osb_cluster_name,
 			OCFS2_RAW_SB(di)->s_cluster_info.ci_cluster,
-			OCFS2_CLUSTER_NAME_LEN + 1);
+			OCFS2_CLUSTER_NAME_LEN);
 	} else {
 		/* The empty string is identical with classic tools that
 		 * don't know about s_cluster_info. */
-- 
2.30.2

