Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F013F691F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhHXSiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhHXSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:38:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34575C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:37:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z2so47519659lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cwbm0dtVbTskGDHM6fDYi7+zCShasPxmbKd2QwmHNI=;
        b=UBPam4ErsN9K2v4R2gZdSjQ6cNCfpfbMS1Nh+CViIHsg21KeFVKbDR5HaQuBfBxkVJ
         X5ocneg3CQVaQDYxiSlsxT0t5xNgnpc2DJybMxFHOe4XG4c2JOnPs7zQtl6CTyj/9LP1
         Tvo+zbzXuGLXYAnGk1jwxccvRikoQnt/g2QrAaTFiIe+y7uhVU1XwjCKmTXRMs5GO5g1
         wuUwZYRZ9kHp6rY2nG0QDOx6rkD18skJdle/C+d0Xc5ehIKKzrJ+NfJBxql/ZCLNEzLs
         kWWBnoL6WRaJGe0X+LCwuOCyT6Sl+9s1KgRSZCjgh4/Kl2PMedI9QCY6gNaFYPXFNO0B
         CFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cwbm0dtVbTskGDHM6fDYi7+zCShasPxmbKd2QwmHNI=;
        b=JPUMdV/2zVJLIl7gUtCZ+ibI++r9EVc/f5ukoEgGFhq+LrOFk54fYwy2JbekuAA4QO
         nC6geLJqsjLETr4n3Ff6AVyV3ER4Zx1lxxynxOjgSRfQJ88H2+E5nWvZ/G47dTWG+HX2
         klKSmag31zjf+wBAC6ArC/f/icYz8U0cUbI1642twX94ja9NsI+aFXJxcdIJjwBEGUj+
         OYMGQ3CHYOwPNPOStNn+BHb2Pm8fSHdClhlh49ZMpKAycJBYFSqmylw8Oknzv+ZBSsOZ
         wUOJWlTh+EVB6bGp3esFS/CxQH2IHu3nBnyBLszsZ34CrhX5sVpIuc7x3fKkOgu7wG3t
         OZsw==
X-Gm-Message-State: AOAM5334fYpP0j8RV+PMObRzWSWfdKjVz2k/GWNqyPhLyO+0+jo2Zq+J
        WK3SMDomNo/KGXaxt6L4/jM=
X-Google-Smtp-Source: ABdhPJzJAo3KMmDx+Ar7gi+3SNs2Lu5FPjuJg1/ruzsod3SLQKDSaGxJAgANpEvQ9t9IGbRmk6b+FQ==
X-Received: by 2002:ac2:5b9e:: with SMTP id o30mr4391440lfn.400.1629830234563;
        Tue, 24 Aug 2021 11:37:14 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id k13sm1826378lfm.168.2021.08.24.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 11:37:14 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v4 0/3] fs/ntfs3: Use kernel alloc wrappers and fix warnings
Date:   Tue, 24 Aug 2021 21:37:05 +0300
Message-Id: <20210824183708.1008538-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ntfs3 driver there is allocation made like this ntfs_malloc().
Patch 2/3 will converter these to kernel ones like kmalloc(). After I
did this then checkpatch raise warnings about array allocations so I
fix these in patch 3/3.

I also notice when I made patch that there is broken utf8 char so I
wanted first fix that because it raised some warning in my editor and
did not want to "break" patch 2/3. And because we are editing comment
then make whole comment block clean. So patch 1/3 address that. I did
try to apply this and it seem to work without issues.

v2:
 - Add patch 1/3 because I found broken utf8 char in source file
 - Add another patch 3/3 which will fix allocation warnings
 - Rewrite some of commit message from first patch
v3:
 - Patch series didn't have X/X numbers
 - Cover letter didn't have fs/ntfs3 in it
 - One kmalloc was converted to kcalloc insted of kmalloc_array
 	Thanks Joe Perches
v4:
 - Wrap whole comment block in patch 1/1 max 80 char. And restyle.
 	Thanks Christoph Hellwig for noting this
 - Add Reviewed-by: from Christoph Hellwig to patch 2 and 3

Kari Argillander (3):
  fs/ntfs3: Restyle comment block in ni_parse_reparse()
  fs/ntfs3: Do not use driver own alloc wrappers
  fs/ntfs3: Use kcalloc/kmalloc_array over kzalloc/kmalloc

 fs/ntfs3/attrib.c   |   6 +-
 fs/ntfs3/attrlist.c |  10 +--
 fs/ntfs3/bitmap.c   |   8 +--
 fs/ntfs3/debug.h    |   7 --
 fs/ntfs3/file.c     |   4 +-
 fs/ntfs3/frecord.c  |  42 ++++++-----
 fs/ntfs3/fslog.c    | 172 ++++++++++++++++++++++----------------------
 fs/ntfs3/fsntfs.c   |   8 +--
 fs/ntfs3/index.c    |  54 +++++++-------
 fs/ntfs3/inode.c    |  10 +--
 fs/ntfs3/lznt.c     |   4 +-
 fs/ntfs3/ntfs_fs.h  |  18 ++---
 fs/ntfs3/record.c   |   8 +--
 fs/ntfs3/run.c      |   8 +--
 fs/ntfs3/super.c    |  20 +++---
 fs/ntfs3/xattr.c    |  18 ++---
 16 files changed, 197 insertions(+), 200 deletions(-)

-- 
2.25.1

