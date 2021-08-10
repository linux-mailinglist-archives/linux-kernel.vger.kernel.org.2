Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3333E59A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 14:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbhHJMIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 08:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229997AbhHJMIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628597292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=70ZHj0e/G2BjF0qu80h7rVUL9ZmoCs0npJRWccY1LHM=;
        b=QXnt/uzOtzOwOSj2DdK8bIGKda0ouH72WcTAdzM2DY83uW3uoNs4rE6QS1J9b+T2vsD+Rq
        RstVTDdgiyEZureF4HHLWf2SJJL0IJ+QseI3OXjvhDKOAJT0de4dpva9c5rK8hmso+bMmM
        HTXxuvpP4twt/H1TXt6HnnzjLV+lyIg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-HREiI4OyOAuSNujjOlrNrQ-1; Tue, 10 Aug 2021 08:08:11 -0400
X-MC-Unique: HREiI4OyOAuSNujjOlrNrQ-1
Received: by mail-ej1-f69.google.com with SMTP id q19-20020a1709064cd3b02904c5f93c0124so5489578ejt.14
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=70ZHj0e/G2BjF0qu80h7rVUL9ZmoCs0npJRWccY1LHM=;
        b=UZkKyLB5/1KCEGw7B67xmIO7z/IMNL/WPzbOSilXBVNJRlNi5ppLdQVCOuuS5VIkg2
         Kt9k+i7e0mLaVueYgDgCu/c9tbrzhwi3vJsh+nVrgJPqpS0iwLY1bzPru+c+YLRuXa0h
         aWZNB0f4bsy94N0PIjOv/YgGpAJPOtbhjRLS1Y/0hQVOBqZ2bCBGOVhf+RTKbeRw6ewO
         8bYwSw3X0woMHJNbAqrTk38T1Y3XZ0qplPMQ9VEsFu8N2wzKC+GqIZFkReECSqEfWrWj
         OY7V9pfYuLXoadX7qNccNXZVAzkUbiLU2Qm35E43Y1OvDqywmhThMrmO7pka89fYRZ8y
         vecQ==
X-Gm-Message-State: AOAM533y8GBz2rTkhyramPL2Lx4FOvDyEFiMCJQBKRRI5XetgUvWMgKF
        DEwvrRQ2/1F2vXFQ6v6XraCaDGtxSTglF9OYjsLaiBG7BT0he5kWVtH0hHj+EgemOwk1tXjV0LB
        n+qeQTcRt5uofyxF9On9jAh/X
X-Received: by 2002:a17:906:2a8e:: with SMTP id l14mr27273136eje.321.1628597290060;
        Tue, 10 Aug 2021 05:08:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR0lHRTWqCIJUXhezLaRhmTRQnvFBVh9FIq/tTZJaz9LLJLVcV9H2kglC1W1U9s9048PKdJw==
X-Received: by 2002:a17:906:2a8e:: with SMTP id l14mr27273125eje.321.1628597289914;
        Tue, 10 Aug 2021 05:08:09 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id p5sm6804900ejl.73.2021.08.10.05.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 05:08:09 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/2] allow overlayfs to do RCU lookups
Date:   Tue, 10 Aug 2021 14:08:05 +0200
Message-Id: <20210810120807.456788-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mini-series enables RCU lookups for overlayfs.

Al, can you take this into your tree, or at least ack the vfs changes so I
can push this to the overlayfs tree?

Thanks,
Miklos

---
Miklos Szeredi (2):
  vfs: add flags argument to ->get_acl() callback
  ovl: enable RCU'd ->get_acl()

 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/vfs.rst     |  2 +-
 fs/9p/acl.c                           |  5 ++++-
 fs/9p/acl.h                           |  2 +-
 fs/bad_inode.c                        |  2 +-
 fs/btrfs/acl.c                        |  5 ++++-
 fs/btrfs/ctree.h                      |  2 +-
 fs/ceph/acl.c                         |  5 ++++-
 fs/ceph/super.h                       |  2 +-
 fs/erofs/xattr.c                      |  5 ++++-
 fs/erofs/xattr.h                      |  2 +-
 fs/ext2/acl.c                         |  5 ++++-
 fs/ext2/acl.h                         |  2 +-
 fs/ext4/acl.c                         |  5 ++++-
 fs/ext4/acl.h                         |  2 +-
 fs/f2fs/acl.c                         |  5 ++++-
 fs/f2fs/acl.h                         |  2 +-
 fs/fuse/acl.c                         |  5 ++++-
 fs/fuse/fuse_i.h                      |  2 +-
 fs/gfs2/acl.c                         |  5 ++++-
 fs/gfs2/acl.h                         |  2 +-
 fs/jffs2/acl.c                        |  5 ++++-
 fs/jffs2/acl.h                        |  2 +-
 fs/jfs/acl.c                          |  5 ++++-
 fs/jfs/jfs_acl.h                      |  2 +-
 fs/nfs/nfs3_fs.h                      |  2 +-
 fs/nfs/nfs3acl.c                      |  5 ++++-
 fs/ocfs2/acl.c                        |  5 ++++-
 fs/ocfs2/acl.h                        |  2 +-
 fs/orangefs/acl.c                     |  5 ++++-
 fs/orangefs/orangefs-kernel.h         |  2 +-
 fs/overlayfs/inode.c                  |  6 +++++-
 fs/overlayfs/overlayfs.h              |  2 +-
 fs/posix_acl.c                        | 10 ++++++++--
 fs/reiserfs/acl.h                     |  2 +-
 fs/reiserfs/xattr_acl.c               |  5 ++++-
 fs/xfs/xfs_acl.c                      |  5 ++++-
 fs/xfs/xfs_acl.h                      |  4 ++--
 include/linux/fs.h                    |  7 ++++++-
 39 files changed, 104 insertions(+), 41 deletions(-)

-- 
2.31.1

