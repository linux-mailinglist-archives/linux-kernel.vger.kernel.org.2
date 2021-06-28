Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5116E3B65C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhF1Pff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235874AbhF1PdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:33:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FBE661949;
        Mon, 28 Jun 2021 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624894235;
        bh=vzb6Z54jI789erHmz8QOJy6iadnhXPMOsyBItuzWX7A=;
        h=Date:From:To:Cc:Subject:From;
        b=H3SnTu09o1Yqi1Nh0TGB3n/qIOiKwBsDHsGoC4g85zynJDU8UmnSI0033tLeP7jPP
         V1dWEVdC4QTTvbQQwuFGOoJfijyR4TDoN6kaebosDHfOg6aORZaZwVhjHN+jaNKywm
         NR2DApRdbXHw3h6i4BXvzFvpUZcYSAXsHX88HQ3pFm6zsxxTSUkRV1rAFca7Ok/Gas
         3vSm4YR7eZsSv4LHq7Dqyu2lYSu3eb7ny5D2u8NhRlz3JThBt91wPog3wzJlE99kKV
         i0n9vOClWC3slvtT/67d1zmuzS7twV2VtgQTNbwA2NAr08E0YpmWB9zh5FvCE7RUj4
         JpYNt72sAUG+A==
Date:   Mon, 28 Jun 2021 23:30:22 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yue Hu <huyue2@yulong.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [GIT PULL] erofs updates for 5.14-rc1
Message-ID: <20210628153020.GA18976@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>,
        Yue Hu <huyue2@yulong.com>, Gao Xiang <hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.14-rc1?

No noticable change available for this cycle. Just a bugfix related to
sb chksum feature, 2 minor cleanups and Chao's email address update.

All commits have been in linux-next. This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.14-rc1

for you to fetch changes up to 8215d5b7f15f8643bf12fe005b2bc0cc322aff62:

  MAINTAINERS: erofs: update my email address (2021-06-28 04:46:32 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix wrong error code overwritten due to sb checksum feature;

 - 2 minor cleanups;

 - update Chao's email address.

----------------------------------------------------------------
Chao Yu (1):
      MAINTAINERS: erofs: update my email address

Gao Xiang (1):
      erofs: clean up file headers & footers

Wei Yongjun (1):
      erofs: fix error return code in erofs_read_superblock()

Yue Hu (1):
      erofs: remove the occupied parameter from z_erofs_pagevec_enqueue()

 MAINTAINERS             | 2 +-
 fs/erofs/Kconfig        | 1 -
 fs/erofs/compress.h     | 2 --
 fs/erofs/data.c         | 2 --
 fs/erofs/decompressor.c | 2 --
 fs/erofs/dir.c          | 2 --
 fs/erofs/erofs_fs.h     | 2 --
 fs/erofs/inode.c        | 2 --
 fs/erofs/internal.h     | 2 --
 fs/erofs/namei.c        | 2 --
 fs/erofs/super.c        | 3 +--
 fs/erofs/tagptr.h       | 3 ---
 fs/erofs/utils.c        | 2 --
 fs/erofs/xattr.c        | 2 --
 fs/erofs/xattr.h        | 1 -
 fs/erofs/zdata.c        | 6 +-----
 fs/erofs/zdata.h        | 1 -
 fs/erofs/zmap.c         | 2 --
 fs/erofs/zpvec.h        | 7 +------
 19 files changed, 4 insertions(+), 42 deletions(-)

