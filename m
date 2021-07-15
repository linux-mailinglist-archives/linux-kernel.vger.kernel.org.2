Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58FA3C964E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 05:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhGODSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:18:51 -0400
Received: from foss.arm.com ([217.140.110.172]:45928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhGODSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:18:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFCFFD6E;
        Wed, 14 Jul 2021 20:15:57 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 164813F7D8;
        Wed, 14 Jul 2021 20:15:55 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH RFC 00/13] Simplify the print format string with new '%pD'
Date:   Thu, 15 Jul 2021 11:15:20 +0800
Message-Id: <20210715031533.9553-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the followup work after changing the behavior of '%pD' to
print the full path of file.

Background
==========
Linus suggested printing the full path of file instead of printing
the components as '%pd'.

This series is based on my patch series of making '%pD' print the full
path of file [1], which is stable now.

[1]: https://lkml.org/lkml/2021/7/14/1519

Test
====
I only tested it with basic compilation and booting. All the changed
codes are compiled and built successfully on Arm64. Therefore set it as
RFC.

Patch details
=============
Patches 01 to 06 with minor changes are easy for review. They are to
remove the hard coding and the postfix number of previous '%pD'. This
should be removed after the '%pD' behavior is changed.

Patches 07 to 13 are changed to simplify the printing helpers.

Jia He (13):
  s390/hmcdrv: remove the redundant directory path in format string
  afs: Remove the number postfix of '%pD' in format string
  fs: Remove the number postfix of '%pD' in format string
  NFS: Remove the number postfix of '%pD' in format string
  NFSD: Remove the number postfix of '%pD' in format string
  ovl: remove the number postfix of '%pD' in format string
  iomap: simplify iomap_swapfile_fail() with '%pD' specifier
  fs/coredump: simplify the printing with '%pD' and '%pd' specifier
  mm/filemap: simplify the printing with '%pD' specifier
  usb: gadget: simplify the printing with '%pD' specifier
  md/bitmap: simplify the printing with '%pD' specifier
  mm: simplify the printing with '%pd' specifier
  ext4: simplify the printing with '%pD' specifier

 drivers/md/md-bitmap.c                       | 13 ++-------
 drivers/s390/char/hmcdrv_dev.c               | 10 +++----
 drivers/usb/gadget/function/f_mass_storage.c | 28 ++++++++------------
 fs/afs/mntpt.c                               |  2 +-
 fs/coredump.c                                | 26 +++---------------
 fs/exec.c                                    |  2 +-
 fs/ext4/super.c                              | 12 +++------
 fs/ioctl.c                                   |  2 +-
 fs/iomap/direct-io.c                         |  2 +-
 fs/iomap/swapfile.c                          |  8 +-----
 fs/nfs/dir.c                                 | 12 ++++-----
 fs/nfs/direct.c                              |  4 +--
 fs/nfs/file.c                                | 26 +++++++++---------
 fs/nfs/nfs4file.c                            |  2 +-
 fs/nfs/write.c                               |  2 +-
 fs/nfsd/nfs4state.c                          |  2 +-
 fs/overlayfs/file.c                          |  2 +-
 fs/read_write.c                              |  2 +-
 fs/splice.c                                  |  2 +-
 mm/filemap.c                                 |  7 +----
 mm/memory.c                                  | 16 +++++------
 21 files changed, 65 insertions(+), 117 deletions(-)

-- 
2.17.1

