Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD93401AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbhIFMNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:13:09 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46061 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241751AbhIFMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:13:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UnRyn5B_1630930321;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UnRyn5B_1630930321)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Sep 2021 20:12:02 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, cfijalkovich@google.com,
        song@kernel.org, william.kucharski@oracle.com, hughd@google.com
Subject: [PATCH 0/2] mm, thp: fix file-backed THP race in collapse_file
Date:   Mon,  6 Sep 2021 20:11:58 +0800
Message-Id: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
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

Rongwei Wang (2):
  mm, thp: check page mapping when truncating page cache
  mm, thp: bail out early in collapse_file for writeback page

 mm/filemap.c    |  7 ++++++-
 mm/khugepaged.c |  3 ++-
 mm/truncate.c   | 17 ++++++++++++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

-- 
1.8.3.1

