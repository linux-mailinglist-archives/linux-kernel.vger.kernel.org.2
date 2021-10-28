Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7C43E125
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJ1Mrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhJ1Mrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:47:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1CAE60FC4;
        Thu, 28 Oct 2021 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635425114;
        bh=o2C6FvRrmDzrbftY8FeeMYbB6RuSRYiUaT2LP9Dk+YI=;
        h=From:To:Cc:Subject:Date:From;
        b=Vv8BsWEePhaTpO+39QlXx5FIPm9+IPxz4irhvfpCZC3w+KD1RgItVlwdUjMhGlyRo
         3lWMIOgn1q0EKFllKonO/WqgUFTbw4B6McSUQk4SbRyxcTia8eydYhtba/Ibjzl5Cv
         In4MCYGkwx3inORdhhLfLPga5AAlKWaNeQc/brbQPJ9SXUoRZpTwGCNVpnss9UMMyv
         n0hRpk2IDIg2PVdOFU4WhdTkG8WZb4Mppj2sx4+DsPXZdxgQrB2M6pEsWVAKtyHFQF
         fkxZkZRSN74CK4CmTHS4O46UKVX8HB0Kqq8+VrUD3ypdmE+ywrWntVfndstwfcb/dn
         OJvUDFYo969bQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH RESEND] f2fs: fix incorrect return value in f2fs_sanity_check_ckpt()
Date:   Thu, 28 Oct 2021 20:45:08 +0800
Message-Id: <20211028124508.2672-1-chao@kernel.org>
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
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9693f3e4cdd4..989e76ec7fb2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3495,7 +3495,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		NR_CURSEG_PERSIST_TYPE + nat_bits_blocks >= blocks_per_seg)) {
 		f2fs_warn(sbi, "Insane cp_payload: %u, nat_bits_blocks: %u)",
 			  cp_payload, nat_bits_blocks);
-		return -EFSCORRUPTED;
+		return 1;
 	}
 
 	if (unlikely(f2fs_cp_error(sbi))) {
-- 
2.32.0

