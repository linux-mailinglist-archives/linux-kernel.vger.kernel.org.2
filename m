Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD95F418354
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbhIYQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 12:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234075AbhIYQB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 12:01:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0274610FD;
        Sat, 25 Sep 2021 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632585592;
        bh=WAwJ0O+4kCyValty29Ksr2SWwdodXAMeTHDUEnDGDYM=;
        h=Date:From:To:Cc:Subject:From;
        b=DcLigCXJtlu1DMG1XJ29mzkug5nIR1ZZX85k6kuviG43w9fQEMEvp6rf1bNC0Tena
         grawWtx1nCTh7lXawApXm2pWK9i66jt5KLNeLBkl/KaGCCfbGnORC+yZCKbnqHkjsn
         oB87mt1DUbOBgOnSl+TC8qo6cEAD0uKDxfeYwcTPXYbcPD+EhGgr2v7miImeBJPv5D
         RIb0dWprARJcN3KiCLB4uciY+97T8pYe9jBX4jLQmjjcchdv2IY17wUAkbv4TLijk4
         1ktHPkzx/S5DBoXbNBcClHGdlGYZAMxrFkqeX8vVyNgkD2wmO4lBasCI2zQMax8AnR
         i/nOSe5YYQ/1w==
Date:   Sat, 25 Sep 2021 23:57:58 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Yue Hu <huyue2@yulong.com>, Liu Bo <bo.liu@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: [GIT PULL] erofs fixes for 5.15-rc3
Message-ID: <20210925155757.GA22083@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.15-rc3?

2 bugfixes are included in order to fix the 4KiB blockmap chunk format
availability and a dangling pointer usage. There is also a trivial
cleanup to clarify compacted_2b if compacted_4b_initial > totalidx.

All commits have been in -next. This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.15-rc3-fixes

for you to fetch changes up to c40dd3ca2a45d5bd6e8b3f4ace5cb81493096263:

  erofs: clear compacted_2b if compacted_4b_initial > totalidx (2021-09-23 23:23:04 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix the dangling pointer use in erofs_lookup tracepoint;
 - fix unsupported chunk format check;
 - zero out compacted_2b if compacted_4b_initial > totalidx.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: fix up erofs_lookup tracepoint
      erofs: fix misbehavior of unsupported chunk format check

Yue Hu (1):
      erofs: clear compacted_2b if compacted_4b_initial > totalidx

 fs/erofs/inode.c             | 2 +-
 fs/erofs/zmap.c              | 3 ++-
 include/trace/events/erofs.h | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)
