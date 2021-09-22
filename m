Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C28414CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhIVP2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232318AbhIVP2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:28:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E34861168;
        Wed, 22 Sep 2021 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632324440;
        bh=ovV4urk3GlFS7e1HLPM5jlLAOz+tjnV1IqgTo1O9svM=;
        h=From:To:Cc:Subject:Date:From;
        b=eo05KFjBJaxgt7DoeZ/1sjWOZ8jeiyUiibfEP585IltwSmx02D5s0T9vTTRjzA5KF
         1NAtUYGs5CDz5qQFFtVoaIi2DX3oKxjRaHWCfvigLHIoJigYPdP57xQIM9FOSL3Oii
         66Y6scUdY3RnAoXEtsaS6p7DRmLAKfpQV8JkYrGN9g28EfJVQcO+I2Nhr68luqz3Z6
         X3SRx0onTuETYf4+aDEOiB8xD9WHZi3t4GtGkUUkSXCvGj1wzJch3YDe2XBqj1QNGd
         lK2ePpoEKzkzj1kBE9VLwOBUqPiSfaJKhWVZmsTWvCHQNWngeRyT62tEVaigvqS4+6
         8zScPDUctzjZQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH] f2fs: fix incorrect return value in f2fs_sanity_check_ckpt()
Date:   Wed, 22 Sep 2021 23:27:05 +0800
Message-Id: <20210922152705.720071-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Pavel Machek reported in [1]

This code looks quite confused: part of function returns 1 on
corruption, part returns -errno. The problem is not stable-specific.

[1] https://lkml.org/lkml/2021/9/19/207

Let's fix to make 'insane cp_payload case' to return 1 rater than
EFSCORRUPTED, so that return value can be kept consistent for all
error cases, it can avoid confusion of code logic.

Fixes: 65ddf6564843 ("f2fs: fix to do sanity check for sb/cp fields correctly")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8d6d0657a470..e3975cb8e3e8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3487,7 +3487,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		NR_CURSEG_PERSIST_TYPE + nat_bits_blocks >= blocks_per_seg)) {
 		f2fs_warn(sbi, "Insane cp_payload: %u, nat_bits_blocks: %u)",
 			  cp_payload, nat_bits_blocks);
-		return -EFSCORRUPTED;
+		return 1;
 	}
 
 	if (unlikely(f2fs_cp_error(sbi))) {
-- 
2.32.0

