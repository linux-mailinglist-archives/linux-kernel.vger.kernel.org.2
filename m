Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0F428518
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 04:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhJKCYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 22:24:46 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55259 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233235AbhJKCYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 22:24:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UrJKfFt_1633918961;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UrJKfFt_1633918961)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 10:22:42 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, song@kernel.org,
        william.kucharski@oracle.com, hughd@google.com, shy828301@gmail.com
Subject: [PATCH v4 0/2] mm, thp: fix file-backed THP race in collapse_file and truncate pagecache
Date:   Mon, 11 Oct 2021 10:22:39 +0800
Message-Id: <20211011022241.97072-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
We found two bugs related to file-backed THP in our cases, recently.
The two bugs rough description as following:

1. in truncate_inode_pages_range, subpage(s) of file-backed THP can be
revealed by find_get_entry.

2. 'collapse_file' miss the pages which in writeback but no private.
This situation will be triggered in XFS when block size is set to
PAGESIZE.

These two patches mainly fix the above mentioned bugs, and have been
tested in latest branch.

Changelog:

v3 -> v4:
- Patch "mm, thp: lock filemap when truncating page cache"
- Patch "mm, thp: bail out early in collapse_file for writeback page"
remove the timestamps from the commit log.

v2 -> v3:
- Patch "mm, thp: lock filemap when truncating page cache"
add filemap_invalidate_{un}lock before and after calling truncate_pagecache (Suggested by Song Liu and Matthew).

v1 -> v2:
- Patch "mm, thp: check page mapping when truncating page cache"
move the check of page mapping to behind lock_page.
- Patch "mm, thp: bail out early in collapse_file for writeback page"
check the writeback flag before taking page lock (Suggested by Yang Shi).

v1 link:
https://patchwork.kernel.org/project/linux-mm/cover/20210906121200.57905-1-rongwei.wang@linux.alibaba.com/
v2 link:
https://patchwork.kernel.org/project/linux-mm/patch/20210922070645.47345-2-rongwei.wang@linux.alibaba.com/
v3 link:
https://patchwork.kernel.org/project/linux-mm/cover/20211006021837.59721-1-rongwei.wang@linux.alibaba.com/

Rongwei Wang (2):
  mm, thp: lock filemap when truncating page cache
  mm, thp: bail out early in collapse_file for writeback page

 fs/open.c       | 5 ++++-
 mm/khugepaged.c | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.27.0

