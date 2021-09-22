Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FED414247
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhIVHIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:08:19 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46995 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233036AbhIVHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:08:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UpCSO0C_1632294405;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UpCSO0C_1632294405)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 15:06:46 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, cfijalkovich@google.com,
        willy@infradead.org, song@kernel.org, william.kucharski@oracle.com,
        hughd@google.com
Subject: [PATCH v2 0/2] mm, thp: fix file-backed THP race in collapse_file and truncate pagecache
Date:   Wed, 22 Sep 2021 15:06:43 +0800
Message-Id: <20210922070645.47345-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We found two bugs related to file-backed THP in our cases, recently.
The two bugs rough description as following:

1) in truncate_inode_pages_range, subpage(s) of file-backed THP can be
revealed by find_get_entry.

2) 'collapse_file' miss the pages which in writeback but no private.
This situation will be triggered in XFS when block size is set to
PAGESIZE.

These two patchs mainly fix the above mentioned bugs, and have been
tested in latest branch.

v1 -> v2:
- Patch "mm, thp: check page mapping when truncating page cache"
move the check of page mapping to behind lock_page
- Patch "mm, thp: bail out early in collapse_file for writeback page"
check the writeback flag before taking page lock.

v1 link:
https://patchwork.kernel.org/project/linux-mm/cover/20210906121200.57905-1-rongwei.wang@linux.alibaba.com/

Rongwei Wang (2):
  mm, thp: check page mapping when truncating page cache
  mm, thp: bail out early in collapse_file for writeback page

 mm/filemap.c    |  7 ++++++-
 mm/khugepaged.c |  7 ++++++-
 mm/truncate.c   | 17 ++++++++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)

-- 
1.8.3.1

