Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95257377C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 08:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhEJGs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 02:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhEJGsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 02:48:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B44B60FF2;
        Mon, 10 May 2021 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620629240;
        bh=VzIh79aZTlyDo5MhlwudRKtMrw2LssnLkTfBS8seF6g=;
        h=From:To:Cc:Subject:Date:From;
        b=X8Xvw8dS54qu2sc1ho+QqbI4N0V3eZOZ4FuomOyDm80UM0EQtRxG86UFaxOKhKmzL
         hRFSESvhGmv3gb/YU7XQ71O+n4hu4qRu2PtC3kIEkb92ESujiesDAtfP5iNfsLoY6R
         N1Cr34v36o7aRQoSZ2qKBOQmKxEXTdUczUKB551k+i/uTTXNlzHIyrPRYZqZgGfm4D
         CJUTZiU4w2hgROtKs/KxyuoVadkuSJTogE1xMBebQWByYxuTyqzG04/bNhnW6N9Ref
         W09/QxWqho7lvM032wv9q8DNBSOIpoRDSKehRqKK0nwZrbDHFsfpbYfx3DVGH/29+t
         uQMR+MW4kwl4Q==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Gao Xiang <xiang@kernel.org>
Subject: [PATCH] erofs: fix 1 lcluster-sized pcluster for big pcluster
Date:   Mon, 10 May 2021 14:47:15 +0800
Message-Id: <20210510064715.29123-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the 1st NONHEAD lcluster of a pcluster isn't CBLKCNT lcluster type
rather than a HEAD or PLAIN type instead, which means its pclustersize
_must_ be 1 lcluster (since its uncompressed size < 2 lclusters),
as illustrated below:

       HEAD     HEAD / PLAIN    lcluster type
   ____________ ____________
  |_:__________|_________:__|   file data (uncompressed)
   .                .
  .____________.
  |____________|                pcluster data (compressed)

Such on-disk case was explained before [1] but missed to be handled
properly in the runtime implementation.

It can be observed if manually generating 1 lcluster-sized pcluster
with 2 lclusters (thus CBLKCNT doesn't exist.) Let's fix it now.

[1] https://lore.kernel.org/r/20210407043927.10623-1-xiang@kernel.org
Fixes: cec6e93beadf ("erofs: support parsing big pcluster compress indexes")
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 fs/erofs/zmap.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e62d813756f2..efaf32596b97 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -450,14 +450,31 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	lcn = m->lcn + 1;
 	if (m->compressedlcs)
 		goto out;
-	if (lcn == initial_lcn)
-		goto err_bonus_cblkcnt;
 
 	err = z_erofs_load_cluster_from_disk(m, lcn);
 	if (err)
 		return err;
 
+	/*
+	 * If the 1st NONHEAD lcluster has already been handled initially w/o
+	 * valid compressedlcs, which means at least it mustn't be CBLKCNT, or
+	 * an internal implemenatation error is detected.
+	 *
+	 * The following code can also handle it properly anyway, but let's
+	 * BUG_ON in the debugging mode only for developers to notice that.
+	 */
+	DBG_BUGON(lcn == initial_lcn &&
+		  m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD);
+
 	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		/*
+		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
+		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
+		 */
+		m->compressedlcs = 1;
+		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
 			goto err_bonus_cblkcnt;
-- 
2.20.1

