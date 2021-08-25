Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD53F7C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhHYSZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhHYSZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:25:52 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB68C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:25:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d16so288932ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wEFdUjBoguMCYu79H5CG+fjqzScpor0FXOKgS+zYbuE=;
        b=OtitS2JGGBRTnBeNYMNJdvP0DYo1pvWK6BXTFmgjvIF09Tw6H1BCEavHoocWWDYbjn
         BzRKK2n9F9dxjQOzP64y26EJ9EHMPeDhPW5+cAns/plrwVY66NcOtrNMhnGinW5Z/yMq
         iDjBfk5DFHgHy9BGDoHTZn1XTwtDSkr1NgyF2WBTXad/3zoWWaS0cL8uYW7FLM7LJonX
         mKrt1YD0c7q+7eA8/pB23oWxqSvRXnlzN3BSu7dBQOgHha9FMRXDge9sDFk6KwzrrOAh
         4NVokKzQSAoWYkp7UmYatLpmLmnIVYuBhRpmOEm25xaMwq9MegzhUd1i8zIklkWBKlXA
         ds9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wEFdUjBoguMCYu79H5CG+fjqzScpor0FXOKgS+zYbuE=;
        b=spaCTaVB0aOFeptlOA+QFwQCSIvozi53dAcfqmQNDcgFH+5CiHiA0k4fMzDOj1XG1X
         okBtss10+OUIFVv6Smgs38W0JIXHeXoYpmvjpQlYgcsSB81ICqlbxj1FQqWvBh0C/hyg
         XdQ+bgMrhk6odI3dgoHSBebi28+RED7CEg7YRoPop4S3jNa/QCL4Gxsy33Hv6+w1Ec03
         s+p/i6epoyEROMfop62wrWxerwX3WmGa0ChzfIuuoabM7lES/sbiOEae5OeffW7mkARn
         Gdm8/kSE0xQ+uSbBS36UDlaj9xeMHeLqHMfK1ec6jyH2jSEtvdw4sEezdLjY6JGLs3Zn
         rOqQ==
X-Gm-Message-State: AOAM533Bxv7ny2AHqs3+jrFqyhCGPA+7TERt+Y4HP0bV7NBHD4CI/vnG
        pj9qR527ZDyvvJ3SjbnkB/k=
X-Google-Smtp-Source: ABdhPJwD4UridqD1q/3Mp9EAb7nsbM+UrtHso3wRPcn1yCXUclqczh3cz4JTo+XaCC/U1jC33FV+GA==
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr31595221ljj.140.1629915904300;
        Wed, 25 Aug 2021 11:25:04 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id v5sm86122ljg.117.2021.08.25.11.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 11:25:03 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] fs/ntfs3: Fix integer overflow in ni_fiemap with fiemap_prep()
Date:   Wed, 25 Aug 2021 21:24:35 +0300
Message-Id: <20210825182435.1367530-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use fiemap_prep() to check valid flags. It also shrink request scope
(@len) to what the fs can actually handle.

This address following Smatch static checker warning:
	fs/ntfs3/frecord.c:1894 ni_fiemap()
	warn: potential integer overflow from user 'vbo + len'

Because fiemap_prep() shrinks @len this cannot happened anymore.

Reported-by Dan Carpenter <dan.carpenter@oracle.com>
Link: lore.kernel.org/ntfs3/20210825080440.GA17407@kili/

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 59344985c2e8..cb736701f2cc 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1210,8 +1210,9 @@ int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
-	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR)
-		return -EOPNOTSUPP;
+	err = fiemap_prep(inode, fieinfo, start, &len, ~FIEMAP_FLAG_XATTR);
+	if (err)
+		return err;
 
 	ni_lock(ni);
 
-- 
2.30.2

