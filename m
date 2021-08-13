Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3A3EAFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 07:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhHMFaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 01:30:05 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37994 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229654AbhHMFaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 01:30:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UiqodgM_1628832571;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UiqodgM_1628832571)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Aug 2021 13:29:36 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        nl6720 <nl6720@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 0/2] erofs: add fiemap support with iomap
Date:   Fri, 13 Aug 2021 13:29:29 +0800
Message-Id: <20210813052931.203280-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This patchset mainly addresses fiemap support for EROFS. After this
patchset, end users can observe (un)compressed extent distribution
by hand.

The first patch is also useful for later LZMA support in order to
decompress full LZMA extents if needed (according to specific
strategy.)

Btw, the current development status for LZMA is in the following
branches (yet these are not aimed for the next merge window since
it's still some work to do):
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/lzma
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-lzma

Thanks,
Gao Xiang

Gao Xiang (2):
  erofs: add support for the full decompressed length
  erofs: add fiemap support with iomap

 fs/erofs/data.c     |  15 ++++-
 fs/erofs/inode.c    |   1 +
 fs/erofs/internal.h |  10 ++++
 fs/erofs/namei.c    |   1 +
 fs/erofs/zmap.c     | 131 +++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 149 insertions(+), 9 deletions(-)

-- 
2.24.4

