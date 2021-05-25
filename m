Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC53390AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 22:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhEYUvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 16:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhEYUv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 16:51:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5FAF6140B;
        Tue, 25 May 2021 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621975798;
        bh=geFDm1hfESSrv4FhIDHlYbHKdE/pWgZd003DvoGhi84=;
        h=From:To:Cc:Subject:Date:From;
        b=EzTDQ3bin0jBFm0kogkX3AOwC4klpfJI9abSvGhy3mQntOCmug8Pr5WGB6TjFRLhE
         m745FlJkrhmKcYOlokMzRj0y8dpRZvo0IOdfmsN9mJZufVHeiPTqeMd/DPzL+eVVsW
         WSNFbenV3sR9BoyXCN/78tFNQp01Lo4WQTc3TpYm9lCPeLcpX4jdB2mocBOc+bG/lk
         M3AB1gwisdJs6KBlIyoc/SLpLCfsqyxnkXEKEYmeCNB6xUScNDwEm8FhmiDfIwU6iH
         QqxDfmHe181alL7nQRBpv4Unoy1LbT4xE8fdkK9CcEUagMalJk0Sh6OUKlEvoxSzkz
         HeY6Kc4ZoseWw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: let's allow compression for mmap files
Date:   Tue, 25 May 2021 13:49:54 -0700
Message-Id: <20210525204955.2512409-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to compress mmap files. E.g., for so files.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1189740aa141..bec92ff5ee7d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -955,8 +955,6 @@ static bool cluster_may_compress(struct compress_ctx *cc)
 		return false;
 	if (f2fs_is_atomic_file(cc->inode))
 		return false;
-	if (f2fs_is_mmap_file(cc->inode))
-		return false;
 	if (!f2fs_cluster_is_full(cc))
 		return false;
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(cc->inode))))
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

