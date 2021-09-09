Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF27405CAC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbhIISLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243659AbhIISLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8586BC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:10:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h1so4352565ljl.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfrA7yCk08W+f7B0nV9XF/ban1tdbk/AFjE2kKZi8vM=;
        b=gXRl8n1oVEqv6QME3+YMOvq6Q4UOsv7LjHe/4l0LoymvfAzhCgs327dt/IlHS2fK2O
         b8bHa1ZKxTNDMKDdZhzTnhIGSJRaC1Y5G0O+gMfNwFknyltqEeBT7KiDRq7RbbVwkd4N
         HPwdfVTwntP5k380neVU1rXbdmQrtjqIwAU/21Hf2BR4JmfW69JBYtXjK1wErI0Kk3+f
         /J7cSGczo4/cNMkzsM4amVbxOfP4HZpu8JxFXRb4vCBiX0q1fEsfIOPhHI90BWj2Aolq
         vqafwbtfsKzo/EmwLlJ9Zk3MOM3GkJDDISZPHslLDxrXkkCVEbbFleChsr7genDk4tmV
         2ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfrA7yCk08W+f7B0nV9XF/ban1tdbk/AFjE2kKZi8vM=;
        b=o/ZgD93V9Ska4vSNzgObCi+0sCZEsB28l1pd8LvbDngHdFn9MK8e4KeRk2MgCsBy9z
         1796q3HYL54xD4Hhza2bU7Js3+HKvuMc4uKAgujfsLpF0FkJC03aObCVep7JPE5fcWxj
         bJdffOtxC6Du+bc59nXFp6lXXx9PTroBMdDs3S0bQ54J2oNgGjq+o3K96eP2ihHfTKX5
         adDCL5KhuO85omJQKb+GZFnM2hoWKIriNWz6YJwFO4CgRn4PGFb9PZqs24oggTo6O3ZD
         3sGwxWYLzBPCMinLqfT6Nh+y+lMLIlGRI+HZ7kAohBjQgAaHSYOIYt0eCtbHI2/cQmNF
         ugzA==
X-Gm-Message-State: AOAM530Ing8mWvSZFqOAukbOEesYYsixCywNrhgN4RFBvZISA9R8HyQ5
        pwv+amakoCWo9kYMCpVCgDBwU8J6AeA=
X-Google-Smtp-Source: ABdhPJzO5AbxW8rsSSsYaIEyqzrfURNFAAQCUZr66i+EvdRtrGKaLJsuA6nbdBGlaqfPYQnubOBubQ==
X-Received: by 2002:a2e:a26c:: with SMTP id k12mr919173ljm.17.1631211006881;
        Thu, 09 Sep 2021 11:10:06 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:10:06 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 11/11] fs/ntfs3: Initiliaze sb blocksize only in one place + refactor
Date:   Thu,  9 Sep 2021 21:09:42 +0300
Message-Id: <20210909180942.8634-12-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909180942.8634-1-kari.argillander@gmail.com>
References: <20210909180942.8634-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now sb blocksize first get initiliazed in fill_super but in can be
changed in helper function. It makes more sense to that this happened
only in one place.

Because we move this to helper function it makes more sense that
s_maxbytes will also be there. I rather have every sb releted thing in
fill_super, but because there is already sb releted stuff in this
helper. This will have to do for now.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
I really would like to initialize all sb stuff in fill_super and I try
it but it did not work out so well. Maybe if we do more refactoring
then maybe, but this should still be better that these can be found in
one place.

---
 fs/ntfs3/super.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 321fcfce64e1..9ad04fcf535a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -842,8 +842,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	rec->total = cpu_to_le32(sbi->record_size);
 	((struct ATTRIB *)Add2Ptr(rec, ao))->type = ATTR_END;
 
-	if (sbi->cluster_size < PAGE_SIZE)
-		sb_set_blocksize(sb, sbi->cluster_size);
+	sb_set_blocksize(sb, min_t(u32, sbi->cluster_size, PAGE_SIZE));
 
 	sbi->block_mask = sb->s_blocksize - 1;
 	sbi->blocks_per_cluster = sbi->cluster_size >> sb->s_blocksize_bits;
@@ -856,9 +855,11 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	if (clusters >= (1ull << (64 - sbi->cluster_bits)))
 		sbi->maxbytes = -1;
 	sbi->maxbytes_sparse = -1;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
 #else
 	/* Maximum size for sparse file. */
 	sbi->maxbytes_sparse = (1ull << (sbi->cluster_bits + 32)) - 1;
+	sb->s_maxbytes = 0xFFFFFFFFull << sbi->cluster_bits;
 #endif
 
 	err = 0;
@@ -913,20 +914,12 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			~(u64)(sbi->discard_granularity - 1);
 	}
 
-	sb_set_blocksize(sb, PAGE_SIZE);
-
 	/* Parse boot. */
 	err = ntfs_init_from_boot(sb, rq ? queue_logical_block_size(rq) : 512,
 				  bdev->bd_inode->i_size);
 	if (err)
 		return err;
 
-#ifdef CONFIG_NTFS3_64BIT_CLUSTER
-	sb->s_maxbytes = MAX_LFS_FILESIZE;
-#else
-	sb->s_maxbytes = 0xFFFFFFFFull << sbi->cluster_bits;
-#endif
-
 	/*
 	 * Load $Volume. This should be done before $LogFile
 	 * 'cause 'sbi->volume.ni' is used 'ntfs_set_state'.
-- 
2.25.1

