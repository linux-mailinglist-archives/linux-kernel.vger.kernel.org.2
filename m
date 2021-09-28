Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783E441B2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbhI1PVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241405AbhI1PVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:21:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8CBE61213;
        Tue, 28 Sep 2021 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842366;
        bh=bycBfj7a7y99K5/y/PMobW5rEQpsQjstRkBVVLsg87A=;
        h=From:To:Cc:Subject:Date:From;
        b=Gk6Cm1NdPgAYBtNQQcgvZOeOqFNgX2Rq/ZDqcIBit5BqcgE5nJFu/usr7Cejuz8Yv
         f2wiClv1fwCiKdp1BXpGVk9lXtCftKtafwET6KX/9O30VwRlrduaXn/xWN/VPoq8ie
         ffMFGvWxlRfhlPGZNAFbuEv8htFkKTafxNyPP0Q51j54LPUxbjQabJar3i226mfo5W
         ixoFHf9NsjGfhO6y+Ohg9cfPPCIam86Ep+LXnKopMXH4M1vsLtm5CUl1MzpsadoHJy
         FBpeCkEccqeCTnBb5qasiK1Mm5DP1BPb1yO4bhtP/O5Ueo3bTzcrkic5mhzaMXDNdK
         vQuzrIo0H2+yQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: skip f2fs_preallocate_blocks() for overwrite case
Date:   Tue, 28 Sep 2021 23:19:11 +0800
Message-Id: <20210928151911.11189-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_file_write_iter(), let's use f2fs_overwrite_io() to
check whethere it is overwrite case, for such case, we can skip
f2fs_preallocate_blocks() in order to avoid f2fs_do_map_lock(),
which may be blocked by checkpoint() potentially.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 13deae03df06..51fecb2f4db5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4321,6 +4321,10 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		preallocated = true;
 		target_size = iocb->ki_pos + iov_iter_count(from);
 
+		if (f2fs_overwrite_io(inode, iocb->ki_pos,
+						iov_iter_count(from)))
+			goto write;
+
 		err = f2fs_preallocate_blocks(iocb, from);
 		if (err) {
 out_err:
-- 
2.32.0

