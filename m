Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A93F37B4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 06:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhELEBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 00:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhELEBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 00:01:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B7736143A;
        Wed, 12 May 2021 04:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620792032;
        bh=cjqAoPxV3C3vu9F4/M1vGSY/ZX1NLSzuT2Uq5VG+/A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpoClDe/HNSxM4Vxmnw2VaUGj6qBsi15ErdVcXrg8mORCERnNkwrPURdwUC6zJaFz
         Zj/4HaKBxx4WVPPTt/bcsDmWbOUO/7WrwqRCTFHJiIIckQOMNN21qTVnkjwvl9faUW
         9Gco/LegGP2L/mWXF0VGfehMSCq6zMy5SvrlLMOqDWNisLGB57RwBcx1BJb4ViKWj+
         KpKAJi/v7EVcHmIPx/4hjS05Ugv+s57QcJEudCx6bloxog0cPHl4T9L9XZ1WnWvR1m
         djZOK8fFYlr3bf3dx0oY6zg2qxC4v1EcFOXfQQortjZI/LITrPBt5u2hm5i9/w7HOd
         jp0cUkBBgBBfw==
Date:   Tue, 11 May 2021 21:00:30 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] f2fs: avoid swapon failure by giving a warning first
Message-ID: <YJtS3qEDFIzqc5Ki@google.com>
References: <20210511214337.2857522-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511214337.2857522-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final solution can be migrating blocks to form a section-aligned file
internally. Meanwhile, let's ask users to do that when preparing the swap
file initially like:
1) create()
2) ioctl(F2FS_IOC_SET_PIN_FILE)
3) fallocate()

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 36e4d95891ed ("f2fs: check if swapfile is section-alligned")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2:
 - fix to warn out once
 - cover check_swap_activate_fast

 fs/f2fs/data.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 33e56ae84e35..41e260680b27 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3801,6 +3801,7 @@ static int f2fs_is_file_aligned(struct inode *inode)
 	block_t pblock;
 	unsigned long nr_pblocks;
 	unsigned int blocks_per_sec = BLKS_PER_SEC(sbi);
+	unsigned int not_aligned = 0;
 	int ret = 0;
 
 	cur_lblock = 0;
@@ -3833,13 +3834,20 @@ static int f2fs_is_file_aligned(struct inode *inode)
 
 		if ((pblock - main_blkaddr) & (blocks_per_sec - 1) ||
 			nr_pblocks & (blocks_per_sec - 1)) {
-			f2fs_err(sbi, "Swapfile does not align to section");
-			ret = -EINVAL;
-			goto out;
+			if (f2fs_is_pinned_file(inode)) {
+				f2fs_err(sbi, "Swapfile does not align to section");
+				ret = -EINVAL;
+				goto out;
+			}
+			not_aligned++;
 		}
 
 		cur_lblock += nr_pblocks;
 	}
+	if (not_aligned)
+		f2fs_warn(sbi, "Swapfile (%u) is not align to section: \n"
+			"\t1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()",
+			not_aligned);
 out:
 	return ret;
 }
@@ -3858,6 +3866,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	int nr_extents = 0;
 	unsigned long nr_pblocks;
 	unsigned int blocks_per_sec = BLKS_PER_SEC(sbi);
+	unsigned int not_aligned = 0;
 	int ret = 0;
 
 	/*
@@ -3896,9 +3905,12 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 
 		if ((pblock - SM_I(sbi)->main_blkaddr) & (blocks_per_sec - 1) ||
 				nr_pblocks & (blocks_per_sec - 1)) {
-			f2fs_err(sbi, "Swapfile does not align to section");
-			ret = -EINVAL;
-			goto out;
+			if (f2fs_is_pinned_file(inode)) {
+				f2fs_err(sbi, "Swapfile does not align to section");
+				ret = -EINVAL;
+				goto out;
+			}
+			not_aligned++;
 		}
 
 		if (cur_lblock + nr_pblocks >= sis->max)
@@ -3927,6 +3939,11 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	sis->max = cur_lblock;
 	sis->pages = cur_lblock - 1;
 	sis->highest_bit = cur_lblock - 1;
+
+	if (not_aligned)
+		f2fs_warn(sbi, "Swapfile (%u) is not align to section: \n"
+			"\t1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()",
+			not_aligned);
 out:
 	return ret;
 }
-- 
2.31.1.607.g51e8a6a459-goog

