Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06C3351A13
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhDAR6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhDARlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:41:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEF0C0604DE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ojDjqcSeZKBZ1QucxS4+kU/n4y+EBdALOnFOKmlpENc=; b=Qp21uJoz2TECONNp80kaf/4OSX
        z9O7vlKwC1LBBtwaMWgv6pXHpOACDbnpKdJLNGsHlVLVWYK+XV2oqnnD93DHyd8DueUEqETvik0pY
        pA1aiFRpIVRmZtim9QpvT1fGPLdK+f/Wj9jSGjpHrwFJ2q0sB4zFbDlORS89GyAZJUlWvGP+GnPJ0
        QA0LJUNBZR/eu+p336x5DI+nvGsN5XlwswGiqYppcJBjUkS6v9h4qwjXhlumR24CjLOdCQ20fBzGS
        GGH2CSL+sbCqR1dhLUQNBcsGhmHD+ibxZbP3aQGZb7e2kP23LZh0KKvi5VlRe2THGJqcmeDxQJ3ik
        XXIZgJNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRwmb-0068gQ-MU; Thu, 01 Apr 2021 12:50:47 +0000
Date:   Thu, 1 Apr 2021 13:50:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] XArray for 5.12
Message-ID: <20210401125045.GC351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


My apologies for the lateness of this pull.  I had a bug reported in
the test suite, and when I started working on it, I realised I had two
fixes sitting in the xarray tree since last November.  Anyway, everything
here is fixes, apart from adding xa_limit_16b.  The test suite passes.

The following changes since commit 17860ccabff533748c85ea32904abd6bae990099:

  Merge tag 'vfio-v5.12-rc6' of git://github.com/awilliam/linux-vfio (2021-03-30 09:49:36 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/xarray.git tags/xarray-5.12

for you to fetch changes up to 2c7e57a02708a69d0194f9ef2a7b7e54f5a0484a:

  idr test suite: Improve reporting from idr_find_test_1 (2021-04-01 07:50:42 -0400)

----------------------------------------------------------------
XArray updates for 5.12
 - Fix a bug when splitting to a non-zero order
 - Documentation fix
 - Add a predefined 16-bit allocation limit
 - Various test suite fixes

----------------------------------------------------------------
Matthew Wilcox (Oracle) (8):
      XArray: Fix split documentation
      XArray: Fix splitting to non-zero orders
      XArray: Add xa_limit_16b
      radix tree test suite: Fix compilation
      radix tree test suite: Register the main thread with the RCU library
      idr test suite: Take RCU read lock in idr_find_test_1
      idr test suite: Create anchor before launching throbber
      idr test suite: Improve reporting from idr_find_test_1

 include/linux/xarray.h                          |  4 +++-
 lib/test_xarray.c                               | 26 +++++++++++++------------
 lib/xarray.c                                    | 11 ++++++-----
 tools/testing/radix-tree/idr-test.c             | 21 +++++++++++++++++---
 tools/testing/radix-tree/linux/compiler_types.h |  0
 tools/testing/radix-tree/multiorder.c           |  2 ++
 tools/testing/radix-tree/xarray.c               |  2 ++
 7 files changed, 45 insertions(+), 21 deletions(-)
 delete mode 100644 tools/testing/radix-tree/linux/compiler_types.h


