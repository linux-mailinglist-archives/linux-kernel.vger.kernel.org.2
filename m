Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4517244E9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhKLPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhKLPQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:16:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC33D61039;
        Fri, 12 Nov 2021 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636729994;
        bh=5hnz5F+TE+0eKQ93EziZ9HPbLm9MBzXgmdtn1ecVitE=;
        h=Date:From:To:Cc:Subject:From;
        b=L69Vwjz+yv0SKlETQvfDj8scuC7W3UwvTxyMdv87bjz2jCFxEIBfjOrgBJgDnwuWv
         EriGUFHVqiySrDzersjajR0DAEAXh46oQZVfPNzOCkHIrTIrant82hSgzpa08t+JtE
         cCdbu9vbaCCgl7wqLz4XbZ5tVWohPvFmIbuzRrDkC4ln65OfUddbDkn1/8ukN5mWFL
         OOsi2hUsfdyfzHusdhnbH6d2tdVX+bs/BNpl6zHySapOWPm3tnpsW7cbKL3dvG1WpT
         zJHH8QfEAuVoF1NP6o3HplN9aNVDw9j2AGKdW1dq+n8Yz+ygMHY25IuSXmdtmD8vPi
         AkS0FE99yb+dA==
Date:   Fri, 12 Nov 2021 23:13:06 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@yulong.com>,
        Miao Xie <miaoxie@huawei.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: [GIT PULL] erofs fixes for 5.16-rc1
Message-ID: <20211112151303.GA28430@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@yulong.com>,
        Miao Xie <miaoxie@huawei.com>, Liu Bo <bo.liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider these 2 small erofs patches?

One patch fixes an old corner case which can hardly reproduce
but cause unsafe pagevec reuse. It needs to be fixed right now.

Another patch is a trivial cleanup which gets rid of the unused
DELAYEDALLOC strategy which has already been replaced by TRYALLOC.

All commits have been in linux-next for a while and no merge
conflicts. I think no need to hold on these until 5.16-rc1 is
out and I could plan for 5.17 cleanup/development stuffs then...

Many thanks!
Gao Xiang

The following changes since commit 8bb7eca972ad531c9b149c0a51ab43a417385813:

  Linux 5.15 (2021-10-31 13:53:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc1-fixes

for you to fetch changes up to 4c7e42552b3a1536f3cdf534aba8c4262ee26716:

  erofs: remove useless cache strategy of DELAYEDALLOC (2021-11-08 10:02:34 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix unsafe pagevec reuse which could cause unexpected behaviors;

 - get rid of the unused DELAYEDALLOC strategy.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix unsafe pagevec reuse of hooked pclusters

Yue Hu (1):
      erofs: remove useless cache strategy of DELAYEDALLOC

 fs/erofs/zdata.c | 33 +++++++--------------------------
 fs/erofs/zdata.h |  1 -
 fs/erofs/zpvec.h | 13 ++++++++++---
 3 files changed, 17 insertions(+), 30 deletions(-)

