Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F2730D9FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhBCMnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhBCMnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eaHavqdLzNN4HIXolByqIWIQT4TrE3vDVyTXfXQ1h/o=;
        b=TCMfTBfo/hGwUqGnaUxz1rbbL5x8yaZ2k4DE/XPXQO7z5rfvvDoTp+I6kkIjOZnv/GwPE/
        uHZ75BKdtsuYLlKX4J4ohZSDc1vlUVyQbe3FL9Caz5S6JWxiU1JKo9KxDaQPNP6NQh/wLs
        coIaGIvKHpVk6VQzh3TLVksKRVJapeo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-_Jxt6iHKPeawCDmCWaJwnw-1; Wed, 03 Feb 2021 07:41:33 -0500
X-MC-Unique: _Jxt6iHKPeawCDmCWaJwnw-1
Received: by mail-ed1-f69.google.com with SMTP id i4so5406442edt.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaHavqdLzNN4HIXolByqIWIQT4TrE3vDVyTXfXQ1h/o=;
        b=PD8PsIMvilo5NpHNVidy+0ayVfPWIQx+6OsiGm1Y69C8IPv8Oc94MzkbTZ7TgHmCf0
         Qj1DJUmDbp9qZr+6AhwFzG30o6+NsGH6DMrp0qnCW2pMD/lXcnvHvsRMe9NydWPqg8d4
         DdrQCtezUNNkM/jUP+q3vlTiCYDLlg9E23icygbh1/ylF+jJvHRAY/JqR9N6JX+7NZjB
         ssQG7iW4IKdfuiKl5sSYXBvAyaH6A41bBBO8uvPEqVX6yvk9inqgjFE/Td0vu4QZQEVC
         f7j+8CBQ5ObZe2mLEQnIFMSlNV60UrdragWSu4oFYW/zyOmSRXqztstYxq5P8DdLDGMv
         8JxA==
X-Gm-Message-State: AOAM533y7NJVYCTtn9g1spmbxQ5pLozbQWC4XRKVWMJo47cQIYj5RPs+
        mKFATsdaV1y3LGWk/mOAOBhaeLFt0Aw/R1FrMxLdAutecLP22W37fXlMFH5m+MIV1udLRlCn7BG
        Y/NPFXUz4lyLaeRH5Ne2m1hrd
X-Received: by 2002:a17:906:5653:: with SMTP id v19mr733189ejr.481.1612356092413;
        Wed, 03 Feb 2021 04:41:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRXVedxTX98WUSw33tq7PLwSR8WbTWYfniFQx78sLmuewEdVI4H9cmtLKSUszoYJVf8TMoRw==
X-Received: by 2002:a17:906:5653:: with SMTP id v19mr733179ejr.481.1612356092264;
        Wed, 03 Feb 2021 04:41:32 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:31 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
Date:   Wed,  3 Feb 2021 13:40:54 +0100
Message-Id: <20210203124112.1182614-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the infrastructure and conversion of filesystems to the
new API.

Two filesystems are not converted: FUSE and CIFS, as they behave
differently from local filesystems (use the file pointer, don't perform
permission checks).  It's likely that these two can be supported with minor
changes to the API, but this requires more thought.

Quick xfstests on ext4, xfs and overlayfs didn't show any regressions.
Other filesystems were only compile tested.

Git tree is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#miscattr

---
Miklos Szeredi (18):
  vfs: add miscattr ops
  ecryptfs: stack miscattr ops
  ovl: stack miscattr
  btrfs: convert to miscattr
  ext2: convert to miscattr
  ext4: convert to miscattr
  f2fs: convert to miscattr
  gfs2: convert to miscattr
  orangefs: convert to miscattr
  xfs: convert to miscattr
  efivars: convert to miscattr
  hfsplus: convert to miscattr
  jfs: convert to miscattr
  nilfs2: convert to miscattr
  ocfs2: convert to miscattr
  reiserfs: convert to miscattr
  ubifs: convert to miscattr
  vfs: remove unused ioctl helpers

 Documentation/filesystems/locking.rst |   4 +
 Documentation/filesystems/vfs.rst     |  14 ++
 fs/btrfs/ctree.h                      |   2 +
 fs/btrfs/inode.c                      |   4 +
 fs/btrfs/ioctl.c                      | 248 ++++---------------
 fs/ecryptfs/inode.c                   |  21 ++
 fs/efivarfs/file.c                    |  77 ------
 fs/efivarfs/inode.c                   |  43 ++++
 fs/ext2/ext2.h                        |   6 +-
 fs/ext2/file.c                        |   2 +
 fs/ext2/ioctl.c                       |  85 +++----
 fs/ext2/namei.c                       |   2 +
 fs/ext4/ext4.h                        |  11 +-
 fs/ext4/file.c                        |   2 +
 fs/ext4/ioctl.c                       | 209 ++++------------
 fs/ext4/namei.c                       |   2 +
 fs/f2fs/f2fs.h                        |   2 +
 fs/f2fs/file.c                        | 212 +++--------------
 fs/f2fs/namei.c                       |   2 +
 fs/gfs2/file.c                        |  56 +----
 fs/gfs2/inode.c                       |   4 +
 fs/gfs2/inode.h                       |   2 +
 fs/hfsplus/dir.c                      |   2 +
 fs/hfsplus/hfsplus_fs.h               |  13 +-
 fs/hfsplus/inode.c                    |  53 +++++
 fs/hfsplus/ioctl.c                    |  84 -------
 fs/inode.c                            |  87 -------
 fs/ioctl.c                            | 329 ++++++++++++++++++++++++++
 fs/jfs/file.c                         |   6 +-
 fs/jfs/ioctl.c                        | 104 +++-----
 fs/jfs/jfs_dinode.h                   |   7 -
 fs/jfs/jfs_inode.h                    |   3 +-
 fs/jfs/namei.c                        |   6 +-
 fs/nilfs2/file.c                      |   2 +
 fs/nilfs2/ioctl.c                     |  60 ++---
 fs/nilfs2/namei.c                     |   2 +
 fs/nilfs2/nilfs.h                     |   2 +
 fs/ocfs2/file.c                       |   2 +
 fs/ocfs2/ioctl.c                      |  58 ++---
 fs/ocfs2/ioctl.h                      |   2 +
 fs/ocfs2/namei.c                      |   3 +
 fs/ocfs2/ocfs2_ioctl.h                |   8 -
 fs/orangefs/file.c                    |  79 -------
 fs/orangefs/inode.c                   |  49 ++++
 fs/overlayfs/dir.c                    |   2 +
 fs/overlayfs/inode.c                  |  43 ++++
 fs/overlayfs/overlayfs.h              |   2 +
 fs/reiserfs/file.c                    |   2 +
 fs/reiserfs/ioctl.c                   | 120 +++++-----
 fs/reiserfs/namei.c                   |   2 +
 fs/reiserfs/reiserfs.h                |   6 +-
 fs/reiserfs/super.c                   |   2 +-
 fs/ubifs/dir.c                        |   2 +
 fs/ubifs/file.c                       |   2 +
 fs/ubifs/ioctl.c                      |  73 +++---
 fs/ubifs/ubifs.h                      |   2 +
 fs/xfs/libxfs/xfs_fs.h                |   4 -
 fs/xfs/xfs_ioctl.c                    | 294 +++++++----------------
 fs/xfs/xfs_ioctl.h                    |  10 +
 fs/xfs/xfs_ioctl32.c                  |   2 -
 fs/xfs/xfs_ioctl32.h                  |   2 -
 fs/xfs/xfs_iops.c                     |   7 +
 include/linux/fs.h                    |  15 +-
 include/linux/miscattr.h              |  52 ++++
 64 files changed, 1097 insertions(+), 1518 deletions(-)
 create mode 100644 include/linux/miscattr.h

-- 
2.26.2

