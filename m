Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D614544ADA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbhKIMjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 07:39:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235446AbhKIMjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:39:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64B4461051;
        Tue,  9 Nov 2021 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636461385;
        bh=bEqtsunkCqzyvLmJ01+UgK4ocxqK5hKbibd6067Iybw=;
        h=From:To:Cc:Subject:Date:From;
        b=kKoRygr1aLdjdT2oR+YWhfguWvriEWF/tW6v2t8NCXh74cm3i7DU94YJc524STLk2
         Y6OPYk9oAhaOce03rtfqXR+EG6Z+6zPvLCYQ97dXKQ+0NLpkgIr62krhKssI6SJMhV
         uQ5ZFaziUgAdT+mWPDwIfbsKhbt0PHiUrER+iSnkmTLJkKJ1yO2eBuieFVgKgj7/N8
         BAV9sgq8QktH8gaewev4iGYDdSS+TgvuTUdv1xKfVzOAT23FQ2hzNdODquTQH/0Lrq
         12NkUIXOJLvdiH18Ej5DFrl3pXhi1dcCR8Uzuyn+iYAXs1HsTccEWJQxTJMgAcK0B2
         XMgT+420/rY0w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jan Kara <jack@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] udf: shut up pointer cast warning
Date:   Tue,  9 Nov 2021 13:36:08 +0100
Message-Id: <20211109123621.52474-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit architectures, the workaround of storing the directory position
in the private_data pointer causes a warning, as loff_t does not fit in
a pointer:

fs/udf/dir.c: In function 'udf_readdir':
fs/udf/dir.c:78:25: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
   78 |         if (ctx->pos != (uintptr_t)file->private_data) {
      |                         ^
fs/udf/dir.c:211:30: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  211 |         file->private_data = (void *)(uintptr_t)ctx->pos;
      |                              ^

An extra cast to uintptr_t shuts up the warning. This is of course
still broken if the position is ever beyond the first 2^32 bytes (4GB).

I have not found a clear information on whether directories this
large are allowed on UDF, but it seems unlikely.

Fixes: 39a464de961f ("udf: Fix crash after seekdir")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/udf/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index 8ae501d27eff..5aaa82be420a 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -75,7 +75,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 	 * identifying beginning of dir entry (names are under user control),
 	 * we need to scan the directory from the beginning.
 	 */
-	if (ctx->pos != (loff_t)file->private_data) {
+	if (ctx->pos != (uintptr_t)file->private_data) {
 		emit_pos = nf_pos;
 		nf_pos = 0;
 	}
@@ -208,7 +208,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 
 out:
 	/* Store position where we've ended */
-	file->private_data = (void *)ctx->pos;
+	file->private_data = (void *)(uintptr_t)ctx->pos;
 	if (fibh.sbh != fibh.ebh)
 		brelse(fibh.ebh);
 	brelse(fibh.sbh);
-- 
2.29.2

