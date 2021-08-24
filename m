Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E633F6900
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhHXSVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhHXSVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:21:24 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABBEC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:20:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q21so39142246ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBABjmHqYwSGMvrKOv+LHJL9S1tFaoQC8OEouPmbANI=;
        b=NGhAAuZZ/gVDx4WlrNQt8cLEsDc+JhpFXPBX3Wob3AVse2hz8oe5+DtC+NUIoqMo1a
         g8RxCqsMETMsufGr7r06hpQ1nDPwNKzUdhVp4X6EeDZ5I5iq3EeaRcjNb4kRHCt227lD
         a/vyTBt0djsZSHKsTLSOOiBLOqzpWccgfVXKhorFuRxfGU2SNmWiBdokCBAfU2Zx/4mC
         ILyAjXDIFzGOxondKuMt86R131+T6AxfRHABjdR5C7NFBuhWgMhqu2hxs8/OJ71jURWQ
         iruIlLTu5ynm42WAWV2L4EFNJFxALiuJF77fMaO97GLg699vZVKJahgo01Rfub1q6eos
         m/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBABjmHqYwSGMvrKOv+LHJL9S1tFaoQC8OEouPmbANI=;
        b=nuNa1uow0RxEmhCehb+8nwb/QiPzqX2/DM30bLE5DvwTwAABtQpWBOxWOXC5yPZNdw
         y6TIzV4xHq70opN06LsF+/MvMR2aKhsbXP9yUuU1KMOMoEi6bmRGX8SbUXIHDg7wOAZf
         BTKI2s1lsEHrf5wFTy8wmkfAqTZ4bVZIPdBeI9ayMPnLSfsHGMWrvTbfqDok0LJ3sRh2
         SFp6gmqrs9c5RPeNTFN60WPB+P9ozXom7FYsZELYZHqWJs1YHPU2GMAd2uLKYFo5Wseg
         R+hMiq4yVAsufNCE1xTLQ4b1G2Q6AQYq6lPFc49J+EYNW/9Aykx+y9kJSDY21ZDb6ZWz
         4s/Q==
X-Gm-Message-State: AOAM531h4TRphK8zJcKEx3dXEbJDNe8xFy8AfRpvP5xegn8PuMZCsKk1
        jOifyl2UbUVEk5XG350Wpic=
X-Google-Smtp-Source: ABdhPJxQUZ6wDtkA/pCRg7RLySrQbFXiTPbB78Q6+KHCxEe3xzRHc6jp2wV9DUMZTJUKCOjDcE7EGQ==
X-Received: by 2002:a05:651c:225:: with SMTP id z5mr22991979ljn.409.1629829237833;
        Tue, 24 Aug 2021 11:20:37 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id p5sm1823783lfs.99.2021.08.24.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 11:20:37 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH] fs/ntfs3: Remove fat ioctl's from ntfs3 driver for now
Date:   Tue, 24 Aug 2021 21:20:20 +0300
Message-Id: <20210824182020.1007329-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason we have FAT ioctl calls. Even old ntfs driver did not
use these. We should not use these because it his hard to get things out
of kernel when they are upstream. That's why we remove these for now.

More discussion is needed what ioctl should be implemented and what is
important.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
Earlier disgussion with Pali can be founded here:
lore.kernel.org/linux-fsdevel/20210824113304.eabzy7ulbuouzlac@pali/
---
 fs/ntfs3/file.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 59344985c2e8..819afc4c902b 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -10,7 +10,6 @@
 #include <linux/compat.h>
 #include <linux/falloc.h>
 #include <linux/fiemap.h>
-#include <linux/msdos_fs.h> /* FAT_IOCTL_XXX */
 #include <linux/nls.h>
 
 #include "debug.h"
@@ -50,15 +49,8 @@ static long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
-	u32 __user *user_attr = (u32 __user *)arg;
 
 	switch (cmd) {
-	case FAT_IOCTL_GET_ATTRIBUTES:
-		return put_user(le32_to_cpu(ntfs_i(inode)->std_fa), user_attr);
-
-	case FAT_IOCTL_GET_VOLUME_ID:
-		return put_user(sbi->volume.ser_num, user_attr);
-
 	case FITRIM:
 		return ntfs_ioctl_fitrim(sbi, arg);
 	}
-- 
2.30.2

