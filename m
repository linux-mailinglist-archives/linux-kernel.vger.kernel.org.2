Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7E35428C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhDEOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 10:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235903AbhDEOFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 10:05:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00D226121E;
        Mon,  5 Apr 2021 14:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617631548;
        bh=PHrcNolj0EoDz+1MXkjJbaaIY3wpqO2TnagGJbPHdoE=;
        h=From:To:Cc:Subject:Date:From;
        b=RhtHjyi21Mb53KG5wwRhWZO81bBAbdqh6smLLfpqWGNQjtMthwkWtJCpied3rG/Vv
         RvVyQxt48ZCSX1OXD90i1nG8m2q8gXkibZmo3MiFUTqqC0dkokST4pGLr4onYVt37M
         +vqNjV0zCrJ9mG0Z+NHDMcXHGNn7Mdkj628AESfdWCPZv9Czk4gVIiWs6/RmJHetL0
         6dgw5uNMMjLAkwJbG97lEwJGuJLfha9DP36HCOC7FQpQpkmVWVWYssmE8rYlb2dki5
         dxlTywCErJ7uCyJK/ML5mWHGOiB46vg3v9n+5ZwCOZUJgKmtI9AsCAxCqtbngol8n1
         MKPs9iW1chzRQ==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] iov_iter: fix kernel-doc comments issues
Date:   Mon,  5 Apr 2021 22:05:38 +0800
Message-Id: <20210405140538.132791-1-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

There are some issues of kernel-doc comments:
lib/iov_iter.c:752: warning: Function parameter or member 'i' not described in '_copy_mc_to_iter'
lib/iov_iter.c:752: warning: Excess function parameter 'iter' description in '_copy_mc_to_iter'
lib/iov_iter.c:886: warning: Function parameter or member 'i' not described in '_copy_from_iter_flushcache'
lib/iov_iter.c:886: warning: Excess function parameter 'iter' description in '_copy_from_iter_flushcache'

correct the 'iter' in comments to 'i' to fix this.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk> 
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org 
---
 lib/iov_iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2ace486824f4..7cda61e6b467 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -729,7 +729,7 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
  * _copy_mc_to_iter - copy to iter with source memory error exception handling
  * @addr: source kernel address
  * @bytes: total transfer length
- * @iter: destination iterator
+ * @i: destination iterator
  *
  * The pmem driver deploys this for the dax operation
  * (dax_copy_to_iter()) for dax reads (bypass page-cache and the
@@ -872,7 +872,7 @@ EXPORT_SYMBOL(_copy_from_iter_nocache);
  * _copy_from_iter_flushcache - write destination through cpu cache
  * @addr: destination kernel address
  * @bytes: total transfer length
- * @iter: source iterator
+ * @i: source iterator
  *
  * The pmem driver arranges for filesystem-dax to use this facility via
  * dax_copy_from_iter() for ensuring that writes to persistent memory
-- 
2.25.1

