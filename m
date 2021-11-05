Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB09844606F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhKEINi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhKEINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:13:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7DEC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 01:10:56 -0700 (PDT)
Received: from beast.luon.net (unknown [IPv6:2a00:bba0:114f:8c00:217f:12f7:a43b:2a0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5F8D91F46617;
        Fri,  5 Nov 2021 08:10:54 +0000 (GMT)
Received: by beast.luon.net (Postfix, from userid 1000)
        id 224081BBE5E9; Fri,  5 Nov 2021 09:10:52 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     linux-um@lists.infradead.org
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hostfs: Fix writeback of dirty pages
Date:   Fri,  5 Nov 2021 09:10:51 +0100
Message-Id: <20211105081052.2353801-1-sjoerd@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hostfs was not setting up the backing device information, which means it
uses the noop bdi. The noop bdi does not have the writeback capability
enabled, which in turns means  dirty pages never got written back to
storage.

In other words programs using mmap to write to files on  hostfs never
actually got their data written out...

Fix this by simply setting up the bdi with default settings as all the
required code for writeback is already in place.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

 fs/hostfs/hostfs_kern.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index d5c9d886cd9f..ef481c3d9019 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -924,6 +924,9 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 	sb->s_op = &hostfs_sbops;
 	sb->s_d_op = &simple_dentry_operations;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	err = super_setup_bdi(sb);
+	if (err)
+		goto out;
 
 	/* NULL is printed as '(null)' by printf(): avoid that. */
 	if (req_root == NULL)
-- 
2.33.1

