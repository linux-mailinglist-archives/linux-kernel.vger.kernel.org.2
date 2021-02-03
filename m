Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D25C30D5F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhBCJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbhBCJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:09:13 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70CC061793
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 01:07:53 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id ob3so4220258pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 01:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aacYYvBrsO89246VG7kwqo+UEXeIJ89FcRhL6OJu++c=;
        b=pN/zjW9WW+TyD9lbKiOtFxDGJFcLXOUEk8mf4j4LL2nKVCYXWHgvcFMAIDORtfvxjR
         ab3D51qsSlSJFu8gkhH1ug3grudzV/43vairsH8wHF9Ox8zgf/d4SiVVCBN+3PrNqV0R
         YB2rujh4TnKXkkIiaDcAWTKoE4FtaH3x9IUUceBso37WVLyA+Rm4352hhfTAcvmLwxil
         xxmxtYhk/nI96yrAAvcZKKm5Kw7YJWrKOe7oYYPugQEROAh512qFLoJIWgW24rtDPOvL
         hdiNl7bLuddHHdxG+IQfcVfFT3bO2DKY2gKKdC6Rmc4zWzecF2ZeCFuHP9yYkjLckSk5
         CFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aacYYvBrsO89246VG7kwqo+UEXeIJ89FcRhL6OJu++c=;
        b=p0OFOCvVPU6s8y+bHLh5Di1LrpI1u0vvMu9oCKTT6ZW21uOJYw202rXloclsludlAh
         udCcQ+BlYFZYG7FNLir5G+L2MHFgzG3UhWOBgg4NToQfX3smfezuwNk2jUy4VMmYpusz
         KtEiAVwm4WGXtjPI6Kus5Jr491UHfXSDI5ylyGuZNznwkLyToQlktA1FZ3PdReGuTnxy
         9qBPC/ej1UpyKLtVRZcNNf6vr/Lj0BrggcM7zH2752ZQynskbzNtIGBT5sogLOz6g1RW
         PQV5i2p6voXKq2Y27l7RZ2UKcXXVZt1wbuZTzgpjy5FHovSYk/yHYiizh0PE7+hVPdA+
         yYdw==
X-Gm-Message-State: AOAM530yF0yHP/2K4puKWk9A+aaWA1EPEXo7EoKhbhF+CBY71tlxFfuA
        oKU+KfxGJONdfqflLxMr3ZfX24N2yo4=
X-Google-Smtp-Source: ABdhPJw5vmAJE95kY1WlsgmFy7c+dcSAbpT0DRm2voYp9n6Cnu4XTnhuwz73/Pa5zmYCrpk77Md1S67BpU8=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a17:90a:3b44:: with SMTP id
 t4mr87542pjf.1.1612343272973; Wed, 03 Feb 2021 01:07:52 -0800 (PST)
Date:   Wed,  3 Feb 2021 09:07:45 +0000
In-Reply-To: <20210203090745.4103054-1-drosen@google.com>
Message-Id: <20210203090745.4103054-3-drosen@google.com>
Mime-Version: 1.0
References: <20210203090745.4103054-1-drosen@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 2/2] ext4: Optimize match for casefolded encrypted dirs
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matching names with casefolded encrypting directories requires
decrypting entries to confirm case since we are case preserving. We can
avoid needing to decrypt if our hash values don't match.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/ext4/ext4.h  | 17 ++++++++-------
 fs/ext4/namei.c | 55 ++++++++++++++++++++++++++-----------------------
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 90a2c182e4d7..997f80cfe5df 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2637,9 +2637,9 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
 ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
 #ifdef CONFIG_UNICODE
-extern void ext4_fname_setup_ci_filename(struct inode *dir,
+extern int ext4_fname_setup_ci_filename(struct inode *dir,
 					 const struct qstr *iname,
-					 struct fscrypt_str *fname);
+					 struct ext4_filename *fname);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -2670,9 +2670,9 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 	ext4_fname_from_fscrypt_name(fname, &name);
 
 #ifdef CONFIG_UNICODE
-	ext4_fname_setup_ci_filename(dir, iname, &fname->cf_name);
+	err = ext4_fname_setup_ci_filename(dir, iname, fname);
 #endif
-	return 0;
+	return err;
 }
 
 static inline int ext4_fname_prepare_lookup(struct inode *dir,
@@ -2689,9 +2689,9 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 	ext4_fname_from_fscrypt_name(fname, &name);
 
 #ifdef CONFIG_UNICODE
-	ext4_fname_setup_ci_filename(dir, &dentry->d_name, &fname->cf_name);
+	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
 #endif
-	return 0;
+	return err;
 }
 
 static inline void ext4_fname_free_filename(struct ext4_filename *fname)
@@ -2716,15 +2716,16 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 					    int lookup,
 					    struct ext4_filename *fname)
 {
+	int err = 0;
 	fname->usr_fname = iname;
 	fname->disk_name.name = (unsigned char *) iname->name;
 	fname->disk_name.len = iname->len;
 
 #ifdef CONFIG_UNICODE
-	ext4_fname_setup_ci_filename(dir, iname, &fname->cf_name);
+	err = ext4_fname_setup_ci_filename(dir, iname, fname);
 #endif
 
-	return 0;
+	return err;
 }
 
 static inline int ext4_fname_prepare_lookup(struct inode *dir,
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 00b0b0cb4600..ff024bb613c0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -799,7 +799,9 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	if (hinfo->hash_version <= DX_HASH_TEA)
 		hinfo->hash_version += EXT4_SB(dir->i_sb)->s_hash_unsigned;
 	hinfo->seed = EXT4_SB(dir->i_sb)->s_hash_seed;
-	if (fname && fname_name(fname))
+	/* hash is already computed for encrypted casefolded directory */
+	if (fname && fname_name(fname) &&
+				!(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)))
 		ext4fs_dirhash(dir, fname_name(fname), fname_len(fname), hinfo);
 	hash = hinfo->hash;
 
@@ -1364,19 +1366,21 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 	return ret;
 }
 
-void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
-				  struct fscrypt_str *cf_name)
+int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
+				  struct ext4_filename *name)
 {
+	struct fscrypt_str *cf_name = &name->cf_name;
+	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
 	if (!IS_CASEFOLDED(dir) || !dir->i_sb->s_encoding) {
 		cf_name->name = NULL;
-		return;
+		return 0;
 	}
 
 	cf_name->name = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
 	if (!cf_name->name)
-		return;
+		return -ENOMEM;
 
 	len = utf8_casefold(dir->i_sb->s_encoding,
 			    iname, cf_name->name,
@@ -1384,10 +1388,18 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	if (len <= 0) {
 		kfree(cf_name->name);
 		cf_name->name = NULL;
-		return;
 	}
 	cf_name->len = (unsigned) len;
+	if (!IS_ENCRYPTED(dir))
+		return 0;
 
+	hinfo->hash_version = DX_HASH_SIPHASH;
+	hinfo->seed = NULL;
+	if (cf_name->name)
+		ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
+	else
+		ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
+	return 0;
 }
 #endif
 
@@ -1417,16 +1429,12 @@ static bool ext4_match(struct inode *parent,
 			struct qstr cf = {.name = fname->cf_name.name,
 					  .len = fname->cf_name.len};
 			if (IS_ENCRYPTED(parent)) {
-				struct dx_hash_info hinfo;
-
-				hinfo.hash_version = DX_HASH_SIPHASH;
-				hinfo.seed = NULL;
-				ext4fs_dirhash(parent, fname->cf_name.name,
-						fname_len(fname), &hinfo);
-				if (hinfo.hash != EXT4_DIRENT_HASH(de) ||
-						hinfo.minor_hash !=
-						    EXT4_DIRENT_MINOR_HASH(de))
+				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
+					fname->hinfo.minor_hash !=
+						EXT4_DIRENT_MINOR_HASH(de)) {
+
 					return 0;
+				}
 			}
 			return !ext4_ci_compare(parent, &cf, de->name,
 							de->name_len, true);
@@ -2061,15 +2069,11 @@ void ext4_insert_dentry(struct inode *dir,
 	de->name_len = fname_len(fname);
 	memcpy(de->name, fname_name(fname), fname_len(fname));
 	if (ext4_hash_in_dirent(dir)) {
-		struct dx_hash_info hinfo;
+		struct dx_hash_info *hinfo = &fname->hinfo;
 
-		hinfo.hash_version = DX_HASH_SIPHASH;
-		hinfo.seed = NULL;
-		ext4fs_dirhash(dir, fname_usr_name(fname),
-				fname_len(fname), &hinfo);
-		EXT4_DIRENT_HASHES(de)->hash = cpu_to_le32(hinfo.hash);
+		EXT4_DIRENT_HASHES(de)->hash = cpu_to_le32(hinfo->hash);
 		EXT4_DIRENT_HASHES(de)->minor_hash =
-				cpu_to_le32(hinfo.minor_hash);
+						cpu_to_le32(hinfo->minor_hash);
 	}
 }
 
@@ -2220,10 +2224,9 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	if (fname->hinfo.hash_version <= DX_HASH_TEA)
 		fname->hinfo.hash_version += EXT4_SB(dir->i_sb)->s_hash_unsigned;
 	fname->hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
-	if (ext4_hash_in_dirent(dir))
-		ext4fs_dirhash(dir, fname_usr_name(fname),
-				fname_len(fname), &fname->hinfo);
-	else
+
+	/* casefolded encrypted hashes are computed on fname setup */
+	if (!ext4_hash_in_dirent(dir))
 		ext4fs_dirhash(dir, fname_name(fname),
 				fname_len(fname), &fname->hinfo);
 
-- 
2.30.0.365.g02bc693789-goog

