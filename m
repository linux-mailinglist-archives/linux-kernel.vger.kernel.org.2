Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822DB44A6BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbhKIGUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbhKIGUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:20:10 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5D4C061766
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 22:17:24 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n85so13971024pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 22:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+4p8iCSg5fdU2hA+HAu0ciUTCxD+Jovqw6Lw+zBsQn4=;
        b=c0mYPeIubezW8It6zTFUxpYceqiy3dip6u89M/mAOYYRfpLH8q5Oal3P5CYZCw5CdV
         vwNCOfuXNDP0oQGFnwzn0skTydWNRzEOxu35+gK1RzddUKbZvPC76yg+QacOLFTOEtFo
         HzTUTJbRM5hJfM+vSWdWGx0PZHVjpgvkmtWYE0bwE/Jz6gzTVrq78p7QCwbs8CBINvTG
         lMlIN/z1Jx45f4dBzS+HtV3wrYkRhi+IIXbcKj2gSRQXVjEF2GCdI4HQUBmsJNNozYJf
         qxkb8ko/OzmEfh5/5KpurbKw082vrTl+96Sbl1biCeGJh78mKfNt/Fbl9fo7YEYt8EFS
         CoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+4p8iCSg5fdU2hA+HAu0ciUTCxD+Jovqw6Lw+zBsQn4=;
        b=gUnj+kC81YSNLc9ibWSvvh8Ibtqt3+VREcBEKHhpy7HzICQUQingt1pUXq60MMNJpE
         hNZw1EspQ9cKY24jxqVpSwU7BjpaGjH5IWGh3aJdyOWBhoYbZIsnmawYebhnPXXBvNyC
         +hkzEIyOQOU+ZcnOpivbCkkX0p4Zdf7QEcWfdMxXpoeBCVImZbD5fH9t+Lt6uzq5az+r
         frVEH4NdvKTuWNeOxfSalFB0j5alckJM2g0Y+bO+3XtsB78+SQJyrCf2LwDAQTNqdJSz
         QejXrm96hr66NKTVJGdabPIbCP/qjkgZnwykUl+Cnrli5d5HUKxunDDx81cUCyaNqXPO
         P8mw==
X-Gm-Message-State: AOAM531QSEZ4PKT8AP8u27qichOA6U7IDcqmFUb9cRcszmH+/9jaU6Gh
        DMnnZPFil5JIFs9cMlrh4ho=
X-Google-Smtp-Source: ABdhPJw3oDQweJ7mnPkwHh6285Fc0kB7Vmga2oj403dTuyul3HqVfyW9lpBD58b6r2w8K4su/LX/RA==
X-Received: by 2002:a63:9902:: with SMTP id d2mr370428pge.104.1636438644271;
        Mon, 08 Nov 2021 22:17:24 -0800 (PST)
Received: from bj08434pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y18sm7586887pgh.18.2021.11.08.22.17.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 22:17:24 -0800 (PST)
From:   niuzhiguo84@gmail.com
To:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Jing.Xia@unisoc.com
Subject: [PATCH Vx 1/1] f2fs: Avoid deadlock between writeback and checkpoint
Date:   Tue,  9 Nov 2021 14:16:48 +0800
Message-Id: <1636438608-27597-1-git-send-email-niuzhiguo84@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

There could be a scenario as following:
The inodeA and inodeB are in b_io queue of writeback
inodeA : f2fs's node inode
inodeB : a dir inode with only one dirty pages, and the node page
of inodeB cached into inodeA

writeback:

wb_workfn
wb_writeback
blk_start_plug
        loop {
        queue_io
        progress=__writeback_inodes_wb
                __writeback_single_inode
                        do_writepages
                                f2fs_write_data_pages
                                wbc->pages_skipped +=get_dirty_pages
                        inode->i_state &= ~dirty
                wrote++
                requeue_inode
        }
blk_finish_plug

checkpoint:

f2fs_write_checkpoint
f2fs_sync_dirty_inodes
filemap_fdatawrite
do_writepages
f2fs_write_data_pages
        f2fs_write_single_data_page
                f2fs_do_write_data_page
                        set_page_writeback
                        f2fs_outplace_write_data
                                f2fs_update_data_blkaddr
                                        f2fs_wait_on_page_writeback
                inode_dec_dirty_pages

1. Writeback thread flush inodeA, and push it's bio request in task's plug;
2. Checkpoint thread writes inodeB's dirty page, and then wait its node
    page writeback cached into inodeA which is in writeback task's plug
3. Writeback thread flush inodeB and skip writing the dirty page as
    wb_sync_req[DATA] > 0.
4. As none of the inodeB's page is marked as PAGECACHE_TAG_DIRTY, writeback
    thread clear inodeB's dirty state.
5. Then inodeB is moved from b_io to b_dirty because of pages_skipped > 0
    as checkpoint thread is stuck before dec dirty_pages.

This patch collect correct pages_skipped according to the tag state in
page tree of inode

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Jing Xia <jing.xia@unisoc.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f4fd6c246c9a..e98628e3868c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3237,7 +3237,9 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	return ret;
 
 skip_write:
-	wbc->pages_skipped += get_dirty_pages(inode);
+	wbc->pages_skipped +=
+		mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ?
+		get_dirty_pages(inode) : 0;
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
 	return 0;
 }
-- 
2.28.0

