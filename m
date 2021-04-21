Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061C0366BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbhDUNHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240705AbhDUNFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C105A6144B;
        Wed, 21 Apr 2021 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010305;
        bh=mb8Ipx42m64EmBAF8uzMbZUr3lxvl3UwlFclXQ5E7X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlQiG+bNxiQU+tXF2/8XnMKOcy8lAOqn1CeH/j0x+1ZS5A3NBp5iySyaxqYZL6LSm
         2L82/rSW8A0NDtD+FshwdvdkD/ZjWpoIOMYBT9R2yWbmtbeJlUVhyBB5QXic+YAC3u
         is9XDoZAKjEcP9FhVih5Q7sRAFjtGiLIvzwBz3V4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 087/190] Revert "udf: fix an uninitialized read bug and remove dead code"
Date:   Wed, 21 Apr 2021 14:59:22 +0200
Message-Id: <20210421130105.1226686-88-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 39416c5872db69859e867fa250b9cbb3f1e0d185.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Wenwen Wang <wang6495@umn.edu>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/udf/namei.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index f146b3089f3d..77906b679187 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -304,6 +304,21 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > UDF_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
+#ifdef UDF_RECOVERY
+	/* temporary shorthand for specifying files by inode number */
+	if (!strncmp(dentry->d_name.name, ".B=", 3)) {
+		struct kernel_lb_addr lb = {
+			.logicalBlockNum = 0,
+			.partitionReferenceNum =
+				simple_strtoul(dentry->d_name.name + 3,
+						NULL, 0),
+		};
+		inode = udf_iget(dir->i_sb, lb);
+		if (IS_ERR(inode))
+			return inode;
+	} else
+#endif /* UDF_RECOVERY */
+
 	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
 	if (IS_ERR(fi))
 		return ERR_CAST(fi);
-- 
2.31.1

