Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F07405CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbhIISLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243542AbhIISLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14B1C061757
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:09:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id l11so5420547lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XToBbj0RLZIUqA/Q77X2jgrFy5XbrvR0CFc+NLRHUDM=;
        b=VGlo+77Pp0Rb7Pz2BYqkpTwmELbb0KZ8n+RBPOsdppOcuBh4bRP/W6oIp3NM1QPiOs
         uWtrPlPhiuEfBAKCcUTmzfIg5cffdM5mow1+Tjpf25p5a6UVEWh9ZLVdxW/h+kvabmKB
         QHVOf7ZEY8YZHe37MZX4KV5eMW/2dZkJ0UZKoqP4auEJRVCZ/VOrZJ8ZA1WgEFoO+Liz
         +cPQBqAKzwOpXIsFeTnjrVNXkbYaPz3yXgjO0yo6P0VSkq0eZ48LKwsyjYc0VB2urwjP
         jzIIPQbPvzofdXyt+/9WKVl4C3zahd3YEGzj5Lw0+BaFVLGK/+mf4NzXleGhYMF+FE5y
         iC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XToBbj0RLZIUqA/Q77X2jgrFy5XbrvR0CFc+NLRHUDM=;
        b=nriSDVgxG+a8AIr2AZmiOfCAkllHcVNPDJzYhhZTt5/kI3Pu0GzaXoPHE0MyHcgVrg
         8zyuRWTHQl1HBGHgCqiVK7x+h4dUv7ZtHOUlQ2bKcHRekfdPV5tUalBMMRNbnRWWFPya
         Mfk0KjSdjm612OZf659T4kVOYrKM5FVcjAlZYu42L12UaaChZMT24QwtVARJpsXuh6Ic
         sP4EeQ5PvCMX32l0wO4Y5cQnOiMBFWXYDFxkvAxOZsQu43t0s331gd0D212MCzMahRPm
         UPjj4qotQDf6nNq1MWLWvfPdZcFfK7wUHmjtCU97nMr/QbCPsVDz2qlNSkzTXIj6Qo+8
         eK/Q==
X-Gm-Message-State: AOAM531ZNBIhRoB5nBlQ1tXE8Keb7zU0DOnlJhFG33nR6o/ITGiYbj0F
        dIHLi0VcG+CSYrllh0Ii6Uc=
X-Google-Smtp-Source: ABdhPJwridSjsXJffDy5FbxpKUC6X3YV+BvAblYI/G4We0UWvB+VTAB0/wcWK+aAWRsg3Qlr5eUpAA==
X-Received: by 2002:a19:700c:: with SMTP id h12mr847185lfc.672.1631210997353;
        Thu, 09 Sep 2021 11:09:57 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:09:57 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 04/11] fs/ntfs3: Return straight without goto in fill_super
Date:   Thu,  9 Sep 2021 21:09:35 +0300
Message-Id: <20210909180942.8634-5-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909180942.8634-1-kari.argillander@gmail.com>
References: <20210909180942.8634-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many places it is not needed to use goto out. We can just return
right away. This will make code little bit more cleaner as we won't
need to check error path.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 56 ++++++++++++++----------------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 793c064833c2..f3c3c2bea6ca 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -923,7 +923,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	err = ntfs_init_from_boot(sb, rq ? queue_logical_block_size(rq) : 512,
 				  bd_inode->i_size);
 	if (err)
-		goto out;
+		return err;
 
 #ifdef CONFIG_NTFS3_64BIT_CLUSTER
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
@@ -939,10 +939,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	ref.seq = cpu_to_le16(MFT_REC_VOL);
 	inode = ntfs_iget5(sb, &ref, &NAME_VOLUME);
 	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
 		ntfs_err(sb, "Failed to load $Volume.");
-		inode = NULL;
-		goto out;
+		return PTR_ERR(inode);
 	}
 
 	ni = ntfs_i(inode);
@@ -990,10 +988,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	ref.seq = cpu_to_le16(MFT_REC_MIRR);
 	inode = ntfs_iget5(sb, &ref, &NAME_MIRROR);
 	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
 		ntfs_err(sb, "Failed to load $MFTMirr.");
-		inode = NULL;
-		goto out;
+		return PTR_ERR(inode);
 	}
 
 	sbi->mft.recs_mirr =
@@ -1006,10 +1002,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	ref.seq = cpu_to_le16(MFT_REC_LOG);
 	inode = ntfs_iget5(sb, &ref, &NAME_LOGFILE);
 	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
 		ntfs_err(sb, "Failed to load \x24LogFile.");
-		inode = NULL;
-		goto out;
+		return PTR_ERR(inode);
 	}
 
 	ni = ntfs_i(inode);
@@ -1027,16 +1021,14 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (!is_ro) {
 			ntfs_warn(sb,
 				  "failed to replay log file. Can't mount rw!");
-			err = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
 		if (!is_ro && !sbi->options->force) {
 			ntfs_warn(
 				sb,
 				"volume is dirty and \"force\" flag is not set!");
-			err = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 	}
 
@@ -1046,10 +1038,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	inode = ntfs_iget5(sb, &ref, &NAME_MFT);
 	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
 		ntfs_err(sb, "Failed to load $MFT.");
-		inode = NULL;
-		goto out;
+		return PTR_ERR(inode);
 	}
 
 	ni = ntfs_i(inode);
@@ -1073,10 +1063,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	ref.seq = cpu_to_le16(MFT_REC_BADCLUST);
 	inode = ntfs_iget5(sb, &ref, &NAME_BADCLUS);
 	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
 		ntfs_err(sb, "Failed to load $BadClus.");
-		inode = NULL;
-		goto out;
+		return PTR_ERR(inode);
 	}
 
 	ni = ntfs_i(inode);
@@ -1098,10 +1086,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	ref.seq = cpu_to_le16(MFT_REC_BITMAP);
 	inode = ntfs_iget5(sb, &ref, &NAME_BITMAP);
 	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
 		ntfs_err(sb, "Failed to load $Bitmap.");
-		inode = NULL;
-		goto out;
+		return PTR_ERR(inode);
 	}
 
 	ni = ntfs_i(inode);
@@ -1131,17 +1117,15 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* Compute the MFT zone. */
 	err = ntfs_refresh_zone(sbi);
 	if (err)
-		goto out;
+		return err;
 
 	/* Load $AttrDef. */
 	ref.low = cpu_to_le32(MFT_REC_ATTR);
 	ref.seq = cpu_to_le16(MFT_REC_ATTR);
 	inode = ntfs_iget5(sbi->sb, &ref, &NAME_ATTRDEF);
 	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
 		ntfs_err(sb, "Failed to load $AttrDef -> %d", err);
-		inode = NULL;
-		goto out;
+		return PTR_ERR(inode);
 	}
 
 	if (inode->i_size < sizeof(struct ATTR_DEF_ENTRY)) {
@@ -1202,10 +1186,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	ref.seq = cpu_to_le16(MFT_REC_UPCASE);
 	inode = ntfs_iget5(sb, &ref, &NAME_UPCASE);
 	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
 		ntfs_err(sb, "Failed to load $UpCase.");
-		inode = NULL;
-		goto out;
+		return PTR_ERR(inode);
 	}
 
 	ni = ntfs_i(inode);
@@ -1251,7 +1233,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		/* Load $Secure. */
 		err = ntfs_security_init(sbi);
 		if (err)
-			goto out;
+			return err;
 
 		/* Load $Extend. */
 		err = ntfs_extend_init(sbi);
@@ -1275,26 +1257,20 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	ref.seq = cpu_to_le16(MFT_REC_ROOT);
 	inode = ntfs_iget5(sb, &ref, &NAME_ROOT);
 	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
 		ntfs_err(sb, "Failed to load root.");
-		inode = NULL;
-		goto out;
+		return PTR_ERR(inode);
 	}
 
 	ni = ntfs_i(inode);
 
 	sb->s_root = d_make_root(inode);
-
-	if (!sb->s_root) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!sb->s_root)
+		return -ENOMEM;
 
 	fc->fs_private = NULL;
 	fc->s_fs_info = NULL;
 
 	return 0;
-
 out:
 	iput(inode);
 	return err;
-- 
2.25.1

