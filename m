Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD78405CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbhIISLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243634AbhIISLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:13 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EBBC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:10:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t19so5351234lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NV/0xR4Wd5a8K3rGYu9nrf5FiDiBhhqYO1ip2WBYO/k=;
        b=D99cnNWLNyWiHSzCZ/jqvfEKRd5jra/f2uqsXAKoIwEJMIeEYimgEDnOBUTzPfGqRm
         iLKM9aZCogvKt7kH4V1FGjCt2eGm4j7FC55Ftz1u8znjTv6PjdIcg2F7TVwpQMsSklHM
         r5LqrbKFmYXusz/wEFDsaog7sur6mTCVW7oCCymehSb/4rU7DsRfytt9X9lyKcz02OxG
         68JWS/DQxNrq8eKNGxP653mEnzcqQlH5HKBqvkyh0ZQRCHiaGa0In4shUGPw+3AGEOOq
         rz34r1ox3fthZk7u7xa72cLqL+lkiFNal27qkIS959BCUvPXnk1ZjPjm9NLnObS2Yrxg
         3EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NV/0xR4Wd5a8K3rGYu9nrf5FiDiBhhqYO1ip2WBYO/k=;
        b=V/ad0rstL4hsaKiHrXrKV4HDq6rC/bTWmVRpeyGM/EAu4LgCnqKWlP2K0KP0PQjbPv
         aU+Gwr8OsjGKsHLoh5jeKMMM5mvb9lG9WXasgZdaZGIyodgs7AI65vdIyhrS9YWZIb+W
         WOzIkwuc4YIw425jOeQuVq0pFUg1CiM7aUYo/GtuNwwZDPL7MbYvK+LWjW0AbSaO8Jfc
         1N6/csk9l1IJHby0uuuuto/bF6Q0ry5QV4jyKMZj4uaAQdkQF6BWYXkBbPdyTTXWoWtn
         9EjecyB3NunauxvXzSLk5VgKm5VuA4KISwRvNoo7xpO3Jlk+1zq8LYQqL0uILbmebuJH
         6+QA==
X-Gm-Message-State: AOAM533TU6U5eHFRJ12UeB4jSz0jPj5iLLdk1FC3rKNeCV/YfBgpQgBI
        tQoGM7fOMrKgoPjf2INf89+wKVA4nkg=
X-Google-Smtp-Source: ABdhPJzHoasyLk7GBFtx/ys/kNkLvNtfD0V582eAnm7zAjnnIfnmUObZDODDXUbt/cufc2vFzODknQ==
X-Received: by 2002:ac2:592f:: with SMTP id v15mr822084lfi.73.1631211001745;
        Thu, 09 Sep 2021 11:10:01 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:10:01 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 07/11] fs/ntfs3: Remove tmp var is_ro in ntfs_fill_super
Date:   Thu,  9 Sep 2021 21:09:38 +0300
Message-Id: <20210909180942.8634-8-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909180942.8634-1-kari.argillander@gmail.com>
References: <20210909180942.8634-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only use this in two places so we do not really need it. Also
wrapper sb_rdonly() is pretty self explanatory. This will make little
bit easier to read this super long variable list in the beginning of
ntfs_fill_super().

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index efe12c45e421..8022149f6b88 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -889,7 +889,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct ATTR_DEF_ENTRY *t;
 	u16 *upcase;
 	u16 *shared;
-	bool is_ro;
 	struct MFT_REF ref;
 
 	ref.high = 0;
@@ -1012,16 +1011,14 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	iput(inode);
 
-	is_ro = sb_rdonly(sb);
-
 	if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
-		if (!is_ro) {
+		if (!sb_rdonly(sb)) {
 			ntfs_warn(sb,
 				  "failed to replay log file. Can't mount rw!");
 			return -EINVAL;
 		}
 	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
-		if (!is_ro && !sbi->options->force) {
+		if (!sb_rdonly(sb) && !sbi->options->force) {
 			ntfs_warn(
 				sb,
 				"volume is dirty and \"force\" flag is not set!");
-- 
2.25.1

