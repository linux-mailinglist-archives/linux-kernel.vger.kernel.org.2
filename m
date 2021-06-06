Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24539CF7F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 16:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFFO1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 10:27:16 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:37651 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFFO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 10:27:13 -0400
Received: by mail-lj1-f177.google.com with SMTP id e2so18332667ljk.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=71LYe/9A82MU2U7qpPvvSHYKFsAW4OvM56Zk359MIrE=;
        b=sxsV2lDPjxm4rvvIyT6R4nzVWwrDWizDZ9JbyRR9r0/WFPKVTEmRT43fR7XipKAoG1
         a5lvavxO9k6HDVFTNduSiseLn+DHYUFiUv4QRNauiXuVD5cq/ZJLjiOHo1ZDMMzLE2p7
         WINNstmSUvu78qWkAkqCl9oRM0M2fuM/JWFo0K0mK1ciMw6qwfIozy/5a+++ynz70AQH
         gvnVbAFmg5Ikmm2qVJUZuKZwvYR1CjAMZRhDLWwloqAjUgQg0DNJ9AJhGKw8y4mmqCeE
         ahwKDQSSR9YQa8dqjBlMOAv8MKcLxnl+3e5fEC8iNFPpUVVLTd+ZQ9Y+fSB64ldNM6yB
         yMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=71LYe/9A82MU2U7qpPvvSHYKFsAW4OvM56Zk359MIrE=;
        b=Xcn0yAKhpT8bZ59yrCohx5TULqN4ST227aEFiCf1Ntjijzh8gW0fMh4HPscSavlK/b
         ReOMUbHz6IjkWzM+BqeYIaTunshMJQsOOJ2eN3yXNtYKYQJzOBMOMIhcqxfGuJ+7+Pmr
         YFyotARLZCrEaqWU0fOPuLrOZQpifcKW/BhWqBX8wdMZ6F2/IZxU4uwwv+YE4DrBCgks
         4o+x2EitHdbLsQmpHI5yrB+gJYHd0KQVi81+p1HCMmzfTMzc5UT28Ro/tJ1o6Ni15KYW
         QIIa/LEj27VPv++nryS+SLRh82X9PIxtRqHT6Zg8vRkSlEOvcy2o+Mt11tXklDaPHLyh
         Wi3A==
X-Gm-Message-State: AOAM531dBW8p1MGFnRe3rf2XYUGxTfWj7dMYv0YG+MmfcJoMOybr0jo9
        PCZkO9o0yQMjDT1WxspNp3E=
X-Google-Smtp-Source: ABdhPJw+HSSEZKmMYJUwrSg0m17VXA1KbfJRlAdJOMKvv3IOKFFnhkxjdA5f5v6fB9KPo4S5+2CLGg==
X-Received: by 2002:a05:651c:1132:: with SMTP id e18mr10955679ljo.386.1622989449190;
        Sun, 06 Jun 2021 07:24:09 -0700 (PDT)
Received: from localhost.localdomain ([94.103.224.40])
        by smtp.gmail.com with ESMTPSA id o19sm1163910lfd.22.2021.06.06.07.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 07:24:08 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+0a89a7b56db04c21a656@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix GPF in diFree
Date:   Sun,  6 Jun 2021 17:24:05 +0300
Message-Id: <20210606142405.31047-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid passing inode with
JFS_SBI(inode->i_sb)->ipimap == NULL to
diFree()[1]. GFP will appear:

	struct inode *ipimap = JFS_SBI(ip->i_sb)->ipimap;
	struct inomap *imap = JFS_IP(ipimap)->i_imap;

JFS_IP() will return invalid pointer when ipimap == NULL

Call Trace:
 diFree+0x13d/0x2dc0 fs/jfs/jfs_imap.c:853 [1]
 jfs_evict_inode+0x2c9/0x370 fs/jfs/inode.c:154
 evict+0x2ed/0x750 fs/inode.c:578
 iput_final fs/inode.c:1654 [inline]
 iput.part.0+0x3fe/0x820 fs/inode.c:1680
 iput+0x58/0x70 fs/inode.c:1670

Reported-and-tested-by: syzbot+0a89a7b56db04c21a656@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 fs/jfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 6f65bfa9f18d..b0eb9c85eea0 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -151,7 +151,8 @@ void jfs_evict_inode(struct inode *inode)
 			if (test_cflag(COMMIT_Freewmap, inode))
 				jfs_free_zero_link(inode);
 
-			diFree(inode);
+			if (JFS_SBI(inode->i_sb)->ipimap)
+				diFree(inode);
 
 			/*
 			 * Free the inode from the quota allocation.
-- 
2.31.1

