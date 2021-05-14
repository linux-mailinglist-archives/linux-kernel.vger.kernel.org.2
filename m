Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F33806FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhENKP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhENKPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0FB3613AA;
        Fri, 14 May 2021 10:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620987253;
        bh=ti35DWvjjXET7XuI9BAF+V+AMh3UIKweXBk2BcOMOiM=;
        h=Date:From:To:Cc:Subject:From;
        b=IUBAohzO/B15+HaPGczZmguSUWEh3Jkk2WSFR3FB+qQqtyr+SKM5YNNiwobai2OxC
         /tgLcC/DM8QTsY+Xc1YsQP/ypkKpKKhthqc7KQnnvrn5pMfZ3P8Y5WVSk2V7Kwa1wD
         tK1DdgFfxauri6q8QeRngySBM56+7TFCD28hQmP+xvhNqn11xCA/plbOFUZxqyv/N8
         52bfa6PWMfA9S5QM5AW+gAwMiUTzSrd4d/UFJiW4rbBhXHwPaHWuIKJkW8eeT4iDYt
         rr4Nm11kAGYWL2YJIKb3ezHT4AtF28oOi9gyW1hLGfk2VpG+O1JW9GhSkrOcEvZ49K
         z6pZM5FwA+RxQ==
Date:   Fri, 14 May 2021 03:14:12 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs fix for 5.13-rc1
Message-ID: <YJ5NdFzVb1f9aVqG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-5.13-rc1-fix

for you to fetch changes up to f395183f9544ba2f56b25938d6ea7042bd873521:

  f2fs: return EINVAL for hole cases in swap file (2021-05-12 07:38:00 -0700)

----------------------------------------------------------------
f2fs-5.13-rc1-fix

This series of patches fix some critical bugs such as memory leak in compression
flows, kernel panic when handling errors, and swapon failure due to newly added
condition check.

----------------------------------------------------------------
Chao Yu (3):
      f2fs: compress: fix to free compress page correctly
      f2fs: compress: fix race condition of overwrite vs truncate
      f2fs: compress: fix to assign cc.cluster_idx correctly

Jaegeuk Kim (4):
      f2fs: avoid null pointer access when handling IPU error
      f2fs: support iflag change given the mask
      f2fs: avoid swapon failure by giving a warning first
      f2fs: return EINVAL for hole cases in swap file

 fs/f2fs/compress.c | 55 +++++++++++++++++++++++-------------------------------
 fs/f2fs/data.c     | 39 +++++++++++++++++++++++++++-----------
 fs/f2fs/f2fs.h     |  2 +-
 fs/f2fs/file.c     |  3 ++-
 fs/f2fs/segment.c  |  4 ++--
 5 files changed, 56 insertions(+), 47 deletions(-)
