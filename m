Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9560D3CED75
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356437AbhGSSe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383770AbhGSSKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:10:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF94360232;
        Mon, 19 Jul 2021 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626720657;
        bh=Fmxur8PEGRLFcvvTlqSw+qeFZN6toa/D9x3oxGIYtV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjRkn/wrE7kcIz31q88YK5VW5qKuTdF0qwIJVqijiq/h43RkIQJvHsS28bHrsM/Qa
         KVKFB3thixzFnn2XqQ6heQ4SuDrxvdoz55IPzHcVB+PTiT5VMWZYG0hTtvI2T5wwwG
         eZ7wS52RkMGUVekTsEPgVmjxLU3+If43xqu2TamG1mCCKjGJAPugJnpvNHBq/Fvjos
         mGGdP5TF9bD5LYmBw3UMCJpGhmM+tA9ixIBeH29wRJ9cf6TgETTHMTIdfBQe8XiU5g
         qebN2lkgHkHmuzPX5EMsARgUdLUsLhY9jaJd/AZXsalEUnKmCgfU2A4ZiCF+FpzJp1
         pxbvVnkad5Ntw==
Date:   Mon, 19 Jul 2021 11:50:55 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stable@kernel.org
Subject: Re: [PATCH v2] f2fs: let's keep writing IOs on SBI_NEED_FSCK
Message-ID: <YPXJj+63rNtcnGdy@google.com>
References: <20210714231850.2567509-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714231850.2567509-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered, so it
is not fully critical to stop any IO writes. So, let's allow to write data
instead of reporting EIO forever given SBI_NEED_FSCK, but do keep OPU.

Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")
Cc: <stable@kernel.org> # v5.13+
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 v2 from v1:
  - use OPU in the NEED_FSCK case.

 fs/f2fs/data.c    | 2 ++
 fs/f2fs/segment.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d2cf48c5a2e4..ba120d55e9b1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2498,6 +2498,8 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (f2fs_is_atomic_file(inode))
 		return true;
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+		return true;
 
 	/* swap file is migrating in aligned write mode */
 	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 15cc89eef28d..f9b7fb785e1d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3563,7 +3563,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
-	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_cp_error(sbi)) {
+	if (f2fs_cp_error(sbi)) {
 		err = -EIO;
 		goto drop_bio;
 	}
-- 
2.32.0.402.g57bb445576-goog

