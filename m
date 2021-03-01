Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5734E327847
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 08:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhCAH3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 02:29:02 -0500
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163]:44512 "EHLO
        outbound-gw.openxchange.ahost.me" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232286AbhCAH3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:29:00 -0500
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.94)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1lGcyD-0005Mf-FP; Mon, 01 Mar 2021 07:27:57 +0000
Date:   Mon, 1 Mar 2021 07:27:57 +0000 (GMT)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <2069685113.2081245.1614583677427@webmail.123-reg.co.uk>
Subject: [PATCH] Squashfs: fix xattr id and id lookup sanity checks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev22
X-Originating-IP: 82.69.79.175
X-Originating-Client: open-xchange-appsuite
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks for maximum metadata block size is
missing SQUASHFS_BLOCK_OFFSET (the two byte length
count).

Cc: stable@vger.kernel.org
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/id.c       | 6 ++++--
 fs/squashfs/xattr_id.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/id.c b/fs/squashfs/id.c
index 11581bf31af4..ea5387679723 100644
--- a/fs/squashfs/id.c
+++ b/fs/squashfs/id.c
@@ -97,14 +97,16 @@ __le64 *squashfs_read_id_index_table(struct super_block *sb,
 		start = le64_to_cpu(table[n]);
 		end = le64_to_cpu(table[n + 1]);
 
-		if (start >= end || (end - start) > SQUASHFS_METADATA_SIZE) {
+		if (start >= end || (end - start) >
+				(SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
 			kfree(table);
 			return ERR_PTR(-EINVAL);
 		}
 	}
 
 	start = le64_to_cpu(table[indexes - 1]);
-	if (start >= id_table_start || (id_table_start - start) > SQUASHFS_METADATA_SIZE) {
+	if (start >= id_table_start || (id_table_start - start) >
+				(SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
 		kfree(table);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/fs/squashfs/xattr_id.c b/fs/squashfs/xattr_id.c
index ead66670b41a..087cab8c78f4 100644
--- a/fs/squashfs/xattr_id.c
+++ b/fs/squashfs/xattr_id.c
@@ -109,14 +109,16 @@ __le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 table_start,
 		start = le64_to_cpu(table[n]);
 		end = le64_to_cpu(table[n + 1]);
 
-		if (start >= end || (end - start) > SQUASHFS_METADATA_SIZE) {
+		if (start >= end || (end - start) >
+				(SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
 			kfree(table);
 			return ERR_PTR(-EINVAL);
 		}
 	}
 
 	start = le64_to_cpu(table[indexes - 1]);
-	if (start >= table_start || (table_start - start) > SQUASHFS_METADATA_SIZE) {
+	if (start >= table_start || (table_start - start) >
+				(SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
 		kfree(table);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.29.2
