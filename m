Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED54934480D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhCVOur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230203AbhCVOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4RPyI1XLSiiAMaJC0jNwo5IEZ8WVN/LKvC5LjkFnvoQ=;
        b=O+Io9Xvg53GC8I+qXfCfHDJ98+yWw2aH964we0V1wG1/0KU0B5pKkp+2eR3LRBChU3mEQ3
        6QO4wrjsYlqBMe/bYuDmugrwE5PiF68Bo1dOC74w7cNEjBT7QNJifDUX4YaKlhl4kdParc
        dRbfzCkvK4kzcTjMpnloty0v4pYn52Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-KSzETiF2PV-hd7c__e5AuQ-1; Mon, 22 Mar 2021 10:49:20 -0400
X-MC-Unique: KSzETiF2PV-hd7c__e5AuQ-1
Received: by mail-ed1-f70.google.com with SMTP id cq11so27480009edb.14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RPyI1XLSiiAMaJC0jNwo5IEZ8WVN/LKvC5LjkFnvoQ=;
        b=uVSfQIUjOMGn0Dui88qfOCVZ75cbbh7AO/fJyLdKDEpvFnAYnDwvaeAa0RWJsKcm+K
         ZGw3oE7vE01xnDIpziJZnUNV0vnse2sQxCOmMdvOvsjy5sXv4WVzA+dSeIffcrYcqhpi
         tKvNvpS7r7QcdombT03JC9BqIC9WMDqaQmTuNAnW1dw6NiliR+t56O0jCOyR6sw19gjY
         ITZDZEHbG6gHQMS0G8uCspSAQecCB5tTyonha20XdjuaEUy5KRDBn/eMod+4tu880XuX
         lH1BZbp5ocW5ho/a151h2hwnwfpccubNDNHqyTVhrfiet8ACSC/n2Pb1bw8vzboJOBl8
         I4Qw==
X-Gm-Message-State: AOAM530I++qNSjurZS2f6VgLbVO9oOmQJPQ5RiKUboHrxxt9sU4wI1bn
        K0wDPnO/zlDaKP32uE8LTaXUw9Bru/HGGbKdftSp8CJvJhM19IBPfvThEi9OUNzIn0YJd2L5m2e
        QSezSFQzxNaZoe4tjQLuG1JgI
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr144632ejt.216.1616424558816;
        Mon, 22 Mar 2021 07:49:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+xtIxvoCJATRMdkNsaLEfGA2QA1KAQg4KsHgMtdI5tAai611CaCVK3Fj8Zrf7VQHTLXr7cw==
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr144617ejt.216.1616424558683;
        Mon, 22 Mar 2021 07:49:18 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:18 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 00/18] new kAPI for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
Date:   Mon, 22 Mar 2021 15:48:58 +0100
Message-Id: <20210322144916.137245-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

See 01/18 for the details.

Can you please apply this series?  Or at least the core part, so that the
fs parts can go independently?

Christoph, you were positive on the RFC version but didn't comment on the
full implementation.  Can you please review?

Changes since v1:

 - rebased on 5.12-rc1 (mnt_userns churn)
 - fixed LSM hook on overlayfs

Git tree is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#miscattr_v2


Thanks,
Miklos

---
Miklos Szeredi (18):
  vfs: add miscattr ops
  ecryptfs: stack miscattr ops
  ovl: stack miscattr ops
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

 Documentation/filesystems/locking.rst |   5 +
 Documentation/filesystems/vfs.rst     |  15 ++
 fs/btrfs/ctree.h                      |   3 +
 fs/btrfs/inode.c                      |   4 +
 fs/btrfs/ioctl.c                      | 249 ++++---------------
 fs/ecryptfs/inode.c                   |  22 ++
 fs/efivarfs/file.c                    |  77 ------
 fs/efivarfs/inode.c                   |  44 ++++
 fs/ext2/ext2.h                        |   7 +-
 fs/ext2/file.c                        |   2 +
 fs/ext2/ioctl.c                       |  88 +++----
 fs/ext2/namei.c                       |   2 +
 fs/ext4/ext4.h                        |  12 +-
 fs/ext4/file.c                        |   2 +
 fs/ext4/ioctl.c                       | 210 ++++------------
 fs/ext4/namei.c                       |   2 +
 fs/f2fs/f2fs.h                        |   3 +
 fs/f2fs/file.c                        | 213 +++--------------
 fs/f2fs/namei.c                       |   2 +
 fs/gfs2/file.c                        |  57 ++---
 fs/gfs2/inode.c                       |   4 +
 fs/gfs2/inode.h                       |   3 +
 fs/hfsplus/dir.c                      |   2 +
 fs/hfsplus/hfsplus_fs.h               |  14 +-
 fs/hfsplus/inode.c                    |  54 +++++
 fs/hfsplus/ioctl.c                    |  84 -------
 fs/inode.c                            |  87 -------
 fs/ioctl.c                            | 329 ++++++++++++++++++++++++++
 fs/jfs/file.c                         |   6 +-
 fs/jfs/ioctl.c                        | 105 +++-----
 fs/jfs/jfs_dinode.h                   |   7 -
 fs/jfs/jfs_inode.h                    |   4 +-
 fs/jfs/namei.c                        |   6 +-
 fs/nilfs2/file.c                      |   2 +
 fs/nilfs2/ioctl.c                     |  61 ++---
 fs/nilfs2/namei.c                     |   2 +
 fs/nilfs2/nilfs.h                     |   3 +
 fs/ocfs2/file.c                       |   2 +
 fs/ocfs2/ioctl.c                      |  59 ++---
 fs/ocfs2/ioctl.h                      |   3 +
 fs/ocfs2/namei.c                      |   3 +
 fs/ocfs2/ocfs2_ioctl.h                |   8 -
 fs/orangefs/file.c                    |  79 -------
 fs/orangefs/inode.c                   |  50 ++++
 fs/overlayfs/dir.c                    |   2 +
 fs/overlayfs/inode.c                  |  77 ++++++
 fs/overlayfs/overlayfs.h              |   3 +
 fs/reiserfs/file.c                    |   2 +
 fs/reiserfs/ioctl.c                   | 121 +++++-----
 fs/reiserfs/namei.c                   |   2 +
 fs/reiserfs/reiserfs.h                |   7 +-
 fs/reiserfs/super.c                   |   2 +-
 fs/ubifs/dir.c                        |   2 +
 fs/ubifs/file.c                       |   2 +
 fs/ubifs/ioctl.c                      |  74 +++---
 fs/ubifs/ubifs.h                      |   3 +
 fs/xfs/libxfs/xfs_fs.h                |   4 -
 fs/xfs/xfs_ioctl.c                    | 316 +++++++------------------
 fs/xfs/xfs_ioctl.h                    |  11 +
 fs/xfs/xfs_ioctl32.c                  |   2 -
 fs/xfs/xfs_ioctl32.h                  |   2 -
 fs/xfs/xfs_iops.c                     |   7 +
 include/linux/fs.h                    |  16 +-
 include/linux/miscattr.h              |  53 +++++
 64 files changed, 1170 insertions(+), 1534 deletions(-)
 create mode 100644 include/linux/miscattr.h

-- 
2.30.2

