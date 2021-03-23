Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C65346073
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhCWN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231548AbhCWN42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:56:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B19C6199F;
        Tue, 23 Mar 2021 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616507787;
        bh=8lKy2kI8+VRpgd7UaH5wsraNigVbnf5gjlgvvdBwnBE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ctFllR8M5ADN0PQZGilMeRK2vxtz2PfkIZU/rB+oJPFpyrze0z1jirtPfRojTZe7E
         K01johJh0sVT0XKGOnU64IktnMSgnZxXU6wiax1/38dRhg6j9LaGsV+yG++7q64tUw
         14WWIO+Jldbd+pHJ1SwnvFwRfEx1aqP6ADIeycO+RrYseD/Nv8OHdh3TwN/IupPFoU
         6kRJOLAcnAsFBY5rNa4gFBXu70qInd+nqc7T2yaYnRG2tfJyzRgngYsW6zq4D/UxLY
         AWmdUbpOuu3HFsgdh5IOBweu2byr8HoJbL/Yv5vkutu2kCphIuxIcoWwgifginyA+H
         kpnt6hN17p83g==
Subject: Re: [PATCH] f2fs: fix to align to section for fallocate() on pinned
 file
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
References: <20210305095601.96591-1-yuchao0@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <d9c118eb-45b3-7f35-70bd-cb016957e6e8@kernel.org>
Date:   Tue, 23 Mar 2021 21:56:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305095601.96591-1-yuchao0@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/5 17:56, Chao Yu wrote:
> Now, fallocate() on a pinned file only allocates blocks which aligns
> to segment rather than section, so GC may try to migrate pinned file's
> block, and after several times of failure, pinned file's block could
> be migrated to other place, however user won't be aware of such
> condition, and then old obsolete block address may be readed/written
> incorrectly.
> 
> To avoid such condition, let's try to allocate pinned file's blocks
> with section alignment.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Jaegeuk,

Could you please check and apply below diff into original patch?

---
  fs/f2fs/file.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 236f3f69681a..24fa68fdcaa0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1648,13 +1648,13 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
  		return 0;

  	if (f2fs_is_pinned_file(inode)) {
-		block_t len = (map.m_len >> sbi->log_blocks_per_seg) <<
-					sbi->log_blocks_per_seg;
+		block_t sec_blks = BLKS_PER_SEC(sbi);
+		block_t len = rounddown(map.m_len, sec_blks);

-		if (map.m_len % sbi->blocks_per_seg)
-			len += sbi->blocks_per_seg;
+		if (map.m_len % sec_blks)
+			len += sec_blks;

-		map.m_len = sbi->blocks_per_seg;
+		map.m_len = sec_blks;
  next_alloc:
  		if (has_not_enough_free_secs(sbi, 0,
  			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
-- 
2.22.1


