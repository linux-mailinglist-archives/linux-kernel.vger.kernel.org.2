Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F0F3714E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhECMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233939AbhECMBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:01:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0E3A61278;
        Mon,  3 May 2021 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043227;
        bh=5DFi3yzKw+rniBZNk6JE9FjRKTgIIkyrqxIHDzQkPnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sO8E4GPGNhP6iK6TThr4Uy2frzGNt23oB7UjkBEoBNT4yO3fmLxX2cd8f/Ggyy0bm
         OhHpPaEwE2hUHNjKWpRXrWtO8SPIw2vOa0wj2fZTJubR3xY7ex384xeXF9CT6Jzwf4
         QhyaacWAgFSibWb7J3Nzymb+ArN65s3U2qP9ees8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Tyler Hicks <code@tyhicks.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 49/69] fs: ecryptfs: remove BUG_ON from crypt_scatterlist
Date:   Mon,  3 May 2021 13:57:16 +0200
Message-Id: <20210503115736.2104747-50-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phillip Potter <phil@philpotter.co.uk>

crypt_stat memory itself is allocated when inode is created, in
ecryptfs_alloc_inode, which returns NULL on failure and is handled
by callers, which would prevent us getting to this point. It then
calls ecryptfs_init_crypt_stat which allocates crypt_stat->tfm
checking for and likewise handling allocation failure. Finally,
crypt_stat->flags has ECRYPTFS_STRUCT_INITIALIZED merged into it
in ecryptfs_init_crypt_stat as well.

Simply put, the conditions that the BUG_ON checks for will never
be triggered, as to even get to this function, the relevant conditions
will have already been fulfilled (or the inode allocation would fail in
the first place and thus no call to this function or those above it).

Cc: Tyler Hicks <code@tyhicks.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ecryptfs/crypto.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 3d8623139538..271064511c1b 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -296,8 +296,6 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 	struct extent_crypt_result ecr;
 	int rc = 0;
 
-	BUG_ON(!crypt_stat || !crypt_stat->tfm
-	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
 				crypt_stat->key_size);
-- 
2.31.1

