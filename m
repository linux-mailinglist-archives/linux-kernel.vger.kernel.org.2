Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E237B0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEKVo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKVo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:44:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 703CC61628;
        Tue, 11 May 2021 21:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620769430;
        bh=uJajgRSXFIg/kSkTCl0T5ZiXJbHhBXOs6OX0ybiOsEY=;
        h=From:To:Cc:Subject:Date:From;
        b=mp6pyOM2YCKKNxFP69P7FNDyfOyRcnYxSN90nen0RTmSlTxPATnY4tAt1YfjQU8rN
         Gh4WuDYdnktfntrcpxkt7CCLfhwLDllQIunIDTTL0lBNAfvNleZeEeo77AfIZxcv6f
         gSvRX7BH35f6Q6RIVeonZG2Lxu6g2/wdcRn4LXNyis95Oi9LH+VnSVhOXlhx+NzEJw
         1wmheJMyhXkF209QMPizJVrgPIJEUu1LWv3qm1ATngPtLaBrC9wQUoM4emY/fJuxkD
         +yD/1qx6Vrcm6S5H7bvzAFsqCAB1JHMxkDHzH/0mhYwK+P1SrpbU6qajpi6gwPJiWR
         bTP/+jNgtuQzw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] f2fs: avoid swapon failure by giving a warning first
Date:   Tue, 11 May 2021 14:43:37 -0700
Message-Id: <20210511214337.2857522-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/f2fs/data.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 33e56ae84e35..041f2d9ec972 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3833,9 +3833,13 @@ static int f2fs_is_file_aligned(struct inode *inode)
 
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
+			f2fs_warn(sbi, "Swapfile does not align to section: \n"
+				"\t1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate()");
 		}
 
 		cur_lblock += nr_pblocks;
-- 
2.31.1.607.g51e8a6a459-goog

