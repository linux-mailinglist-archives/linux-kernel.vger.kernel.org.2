Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E27631F5F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBSIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBSIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:33:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDC0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:32:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e9so3734921pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WSN2nCd7ehopB1fbP9nmBNTf5GDQl/nfkRiUecNb/jY=;
        b=HZbaOBIcwN2pluP8dY3Zqx5Yp0XTf0p81GIPkrxvPQLFrDLesFbFxURo8c5gEvRtq/
         iDBK897oTp/AMbaY/WiPp4h9fg19r6jC9dBH2oKoEbt4PofkuuBr7Sdz5EZdMED2okyR
         iex1IsJ2uZn7CUmj8W64/Vs1vN6saEGItY8e8Zs1nSOsDHra7mGmpgIxMvoIgaWyW92q
         kjFxeV4hWgkA9JwhRXq9jFGUQ5a80CS2HG9e7dmbbAwnwJ4neJt4oscTf7GOHxvhFMGt
         uY1hKlkgQ5qNGfyqjru03YBZqVpRRd7lpmhfTWeoVVEZ23Fz0jKugRigMp3n2fNpTSd3
         N6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WSN2nCd7ehopB1fbP9nmBNTf5GDQl/nfkRiUecNb/jY=;
        b=NOW/6QD2VLrSNHtscV39n8jLyqrmVgmWi3jBO++rDxv9v5MywhHQ3SOlI/sroVFhNN
         AlC0ZBHG8bX9AsU7ZePcvKkJoLwGc5ZLdfzNffm376iFEPy8wW2ZCrvgd0Lt5sBZZ/UZ
         b7vp6PHbxXHoBqd4D1MZL4vqqDDa2kFnnTlwFsD9wdYbaPPfNoEl+1KqK292JSHxOyOs
         OKUEI675EBUKDTL7SD3XIiwEKaM9q2FERvOuDYqt/I5MG93QVKNHjUMW5mwVIArJ6loD
         mhnXet03Y5ecUJrVBtpgFG/tJcpgqHLeB/FU/WTHK9vllOmgqIfBwvegjjPr5NfG5j8f
         Qu+g==
X-Gm-Message-State: AOAM533YhxF9R68OnjECXCxKNLP/PtgVoYhymz2OKvd/K4t2tJXAP+YO
        0hKaY8cqs8QRUcvOv4hdTM0=
X-Google-Smtp-Source: ABdhPJwyrTjy+j/1QXa9u6klVKgG+xh584WRqYGDEh3LlB+f0CD68WQEasAWtdPy1NA6yf77ERUxng==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id kb13mr8043201pjb.10.1613723549288;
        Fri, 19 Feb 2021 00:32:29 -0800 (PST)
Received: from rayare.domain.name ([106.51.141.71])
        by smtp.googlemail.com with ESMTPSA id 4sm7881341pjc.23.2021.02.19.00.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 00:32:28 -0800 (PST)
From:   chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     chakravarthikulkarni2021@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs:jffs2: Fixed return statement in if and else statement
Date:   Fri, 19 Feb 2021 14:02:12 +0530
Message-Id: <20210219083214.11583-1-chakravarthikulkarni2021@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error:  Fixed Error found by checkpath.pl script.
	switch and case should be at the same indent
Warning: Fixed Warning found by checkpath.pl script.

Signed-off-by: chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
---
 fs/jffs2/acl.c | 105 ++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 53 deletions(-)

diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 093ffbd82395..e66a1c4eaefd 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -38,18 +38,20 @@ static size_t jffs2_acl_size(int count)
 static int jffs2_acl_count(size_t size)
 {
 	size_t s;
+	int ret = 0;
 
 	size -= sizeof(struct jffs2_acl_header);
 	if (size < 4 * sizeof(struct jffs2_acl_entry_short)) {
 		if (size % sizeof(struct jffs2_acl_entry_short))
 			return -1;
-		return size / sizeof(struct jffs2_acl_entry_short);
+		ret =  size / sizeof(struct jffs2_acl_entry_short);
 	} else {
 		s = size - 4 * sizeof(struct jffs2_acl_entry_short);
 		if (s % sizeof(struct jffs2_acl_entry))
 			return -1;
-		return s / sizeof(struct jffs2_acl_entry) + 4;
+		ret = s / sizeof(struct jffs2_acl_entry) + 4;
 	}
+	return ret;
 }
 
 static struct posix_acl *jffs2_acl_from_medium(void *value, size_t size)
@@ -82,39 +84,37 @@ static struct posix_acl *jffs2_acl_from_medium(void *value, size_t size)
 	if (!acl)
 		return ERR_PTR(-ENOMEM);
 
-	for (i=0; i < count; i++) {
+	for (i = 0; i < count; i++) {
 		entry = value;
 		if (value + sizeof(struct jffs2_acl_entry_short) > end)
 			goto fail;
 		acl->a_entries[i].e_tag = je16_to_cpu(entry->e_tag);
 		acl->a_entries[i].e_perm = je16_to_cpu(entry->e_perm);
 		switch (acl->a_entries[i].e_tag) {
-			case ACL_USER_OBJ:
-			case ACL_GROUP_OBJ:
-			case ACL_MASK:
-			case ACL_OTHER:
-				value += sizeof(struct jffs2_acl_entry_short);
-				break;
-
-			case ACL_USER:
-				value += sizeof(struct jffs2_acl_entry);
-				if (value > end)
-					goto fail;
-				acl->a_entries[i].e_uid =
-					make_kuid(&init_user_ns,
-						  je32_to_cpu(entry->e_id));
-				break;
-			case ACL_GROUP:
-				value += sizeof(struct jffs2_acl_entry);
-				if (value > end)
-					goto fail;
-				acl->a_entries[i].e_gid =
-					make_kgid(&init_user_ns,
-						  je32_to_cpu(entry->e_id));
+		case ACL_USER_OBJ:
+		case ACL_GROUP_OBJ:
+		case ACL_MASK:
+		case ACL_OTHER:
+			value += sizeof(struct jffs2_acl_entry_short);
+			break;
+		case ACL_USER:
+			value += sizeof(struct jffs2_acl_entry);
+			if (value > end)
+				goto fail;
+			acl->a_entries[i].e_uid =
+				make_kuid(&init_user_ns,
+						je32_to_cpu(entry->e_id));
 				break;
-
-			default:
+		case ACL_GROUP:
+			value += sizeof(struct jffs2_acl_entry);
+			if (value > end)
 				goto fail;
+			acl->a_entries[i].e_gid =
+				make_kgid(&init_user_ns,
+						je32_to_cpu(entry->e_id));
+			break;
+		default:
+			goto fail;
 		}
 	}
 	if (value != end)
@@ -139,32 +139,31 @@ static void *jffs2_acl_to_medium(const struct posix_acl *acl, size_t *size)
 		return ERR_PTR(-ENOMEM);
 	header->a_version = cpu_to_je32(JFFS2_ACL_VERSION);
 	e = header + 1;
-	for (i=0; i < acl->a_count; i++) {
+	for (i = 0; i < acl->a_count; i++) {
 		const struct posix_acl_entry *acl_e = &acl->a_entries[i];
+
 		entry = e;
 		entry->e_tag = cpu_to_je16(acl_e->e_tag);
 		entry->e_perm = cpu_to_je16(acl_e->e_perm);
-		switch(acl_e->e_tag) {
-			case ACL_USER:
-				entry->e_id = cpu_to_je32(
-					from_kuid(&init_user_ns, acl_e->e_uid));
-				e += sizeof(struct jffs2_acl_entry);
-				break;
-			case ACL_GROUP:
-				entry->e_id = cpu_to_je32(
-					from_kgid(&init_user_ns, acl_e->e_gid));
-				e += sizeof(struct jffs2_acl_entry);
-				break;
-
-			case ACL_USER_OBJ:
-			case ACL_GROUP_OBJ:
-			case ACL_MASK:
-			case ACL_OTHER:
-				e += sizeof(struct jffs2_acl_entry_short);
-				break;
-
-			default:
-				goto fail;
+		switch (acl_e->e_tag) {
+		case ACL_USER:
+			entry->e_id = cpu_to_je32(from_kuid(&init_user_ns,
+						acl_e->e_uid));
+			e += sizeof(struct jffs2_acl_entry);
+			break;
+		case ACL_GROUP:
+			entry->e_id = cpu_to_je32(
+				from_kgid(&init_user_ns, acl_e->e_gid));
+			e += sizeof(struct jffs2_acl_entry);
+			break;
+		case ACL_USER_OBJ:
+		case ACL_GROUP_OBJ:
+		case ACL_MASK:
+		case ACL_OTHER:
+			e += sizeof(struct jffs2_acl_entry_short);
+			break;
+		default:
+			goto fail;
 		}
 	}
 	return header;
@@ -196,13 +195,13 @@ struct posix_acl *jffs2_get_acl(struct inode *inode, int type)
 			return ERR_PTR(-ENOMEM);
 		rc = do_jffs2_getxattr(inode, xprefix, "", value, rc);
 	}
-	if (rc > 0) {
+	if (rc > 0)
 		acl = jffs2_acl_from_medium(value, rc);
-	} else if (rc == -ENODATA || rc == -ENOSYS) {
+	else if (rc == -ENODATA || rc == -ENOSYS)
 		acl = NULL;
-	} else {
+	else
 		acl = ERR_PTR(rc);
-	}
+
 	kfree(value);
 	return acl;
 }
-- 
2.17.1

