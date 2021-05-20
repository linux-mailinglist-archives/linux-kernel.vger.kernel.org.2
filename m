Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F017A38A3BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhETJ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:56:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234440AbhETJwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:52:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA114ABEA;
        Thu, 20 May 2021 09:51:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3BD601F2C9C; Thu, 20 May 2021 11:51:19 +0200 (CEST)
Date:   Thu, 20 May 2021 11:51:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [LKP] [ext4] 05c2c00f37: aim7.jobs-per-min -11.8% regression
Message-ID: <20210520095119.GA18952@quack2.suse.cz>
References: <20210227120804.GB22871@xsang-OptiPlex-9020>
 <a8947cee-11f5-8d59-a3ff-1c516276592e@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8947cee-11f5-8d59-a3ff-1c516276592e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello!

On Thu 20-05-21 15:13:20, Xing Zhengjun wrote:
> 
>      Do you have time to look at this? The regression still existed in the
> latest Linux mainline v5.13-rc2.

Thanks for verification and for the ping! I had a look into this and I
think the regression is caused by the changes in orphan handling. The load
runs multiple tasks all creating and deleting files. This generally
contends on the orphan locking with fast storage (which is your case
because you use ramdisk as a backing store AFAICT). And the changes I did
move superblock checksum computation under the orphan lock so the lock hold
times are now higher.

Sadly it is not easy to move checksum update from under the orphan lock and
maintain checksum consistency since the checksum has to be recomputed
consistently with the changes of superblock state. But I have one idea how
we could maybe improve the situation. Can you check whether attached patch
recovers the regression? Because that's about how good it could get when we
are more careful when writing out superblock.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--gBBFr7Ir9EOA20Yy
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-ext4-Experiment-with-checksum-computation-during-orp.patch"

From fb788956380e066308e2a37afb97d2c4bed44de5 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 20 May 2021 11:46:02 +0200
Subject: [PATCH] ext4: Experiment with checksum computation during orphan
 handling

DONTMERGE. Just experiment whether this recovers performance.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index afb9d05a99ba..bb687ed4a604 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3105,7 +3105,6 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 		NEXT_ORPHAN(inode) = le32_to_cpu(sbi->s_es->s_last_orphan);
 		lock_buffer(sbi->s_sbh);
 		sbi->s_es->s_last_orphan = cpu_to_le32(inode->i_ino);
-		ext4_superblock_csum_set(sb);
 		unlock_buffer(sbi->s_sbh);
 		dirty = true;
 	}
@@ -3113,6 +3112,9 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	mutex_unlock(&sbi->s_orphan_lock);
 
 	if (dirty) {
+		lock_buffer(sbi->s_sbh);
+		ext4_superblock_csum_set(sb);
+		unlock_buffer(sbi->s_sbh);
 		err = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
 		rc = ext4_mark_iloc_dirty(handle, inode, &iloc);
 		if (!err)
@@ -3191,9 +3193,9 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 		}
 		lock_buffer(sbi->s_sbh);
 		sbi->s_es->s_last_orphan = cpu_to_le32(ino_next);
+		mutex_unlock(&sbi->s_orphan_lock);
 		ext4_superblock_csum_set(inode->i_sb);
 		unlock_buffer(sbi->s_sbh);
-		mutex_unlock(&sbi->s_orphan_lock);
 		err = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
 	} else {
 		struct ext4_iloc iloc2;
-- 
2.26.2


--gBBFr7Ir9EOA20Yy--
