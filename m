Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB981426C5E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhJHOJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:09:19 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10135 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJHOJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:09:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633702042; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=z5HFXO447DX2xV076VYmLHupBfI2lHWsPlxwcYyE54k=; b=orIMt68A4TqaGjfp4hf5XOjjwv6q8+kD5qIFlRioPsE/meUbmRcmmpGZR4LUuEbvNu2krkXl
 E+ByNOcqlW9YS0y+8WgwjCilPda8lv1mbHpbZ3EJq7hfBM4NoSoBnn128FNRhIzr9q7BvYou
 LuL+821TbEosiNl2wD7tJP3qEB4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61605092ff0285fb0a44ba26 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Oct 2021 14:07:14
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 37D14C43618; Fri,  8 Oct 2021 14:07:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-charante-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F340C43460;
        Fri,  8 Oct 2021 14:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3F340C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     hughd@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        rientjes@google.com, david@redhat.com, mhocko@suse.com,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
Date:   Fri,  8 Oct 2021 19:36:22 +0530
Message-Id: <1633701982-22302-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently fadvise(2) is supported only for the files that doesn't
associated with noop_backing_dev_info thus for the files, like shmem,
fadvise results into NOP. But then there is file_operations->fadvise()
that lets the file systems to implement their own fadvise
implementation. Use this support to implement some of the POSIX_FADV_XXX
functionality for shmem files.

This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
advices to shmem files which can be helpful for the drivers who may want
to manage the shmem pages of the files that are created through
shmem_file_setup[_with_mnt]().  An example usecase may be like, driver
can create the shmem file of the size equal to its requirements and
map the pages for DMA and then pass the fd to user. The user who knows
well about the usage of these pages can now decide when these pages are
not required push them to swap through DONTNEED thus free up memory well
in advance rather than relying on the reclaim and use WILLNEED when it
decide that they are useful in the near future. IOW, it lets the clients
to free up/read the memory when it wants to. Another usecase is that GEM
objets which are currenlty allocated and managed through shmem files can
use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
know(like through some hints from user space) that GEM objects are not
going to use/will need in the near future.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 mm/shmem.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 70d9ce2..ab7ea33 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -38,6 +38,8 @@
 #include <linux/hugetlb.h>
 #include <linux/frontswap.h>
 #include <linux/fs_parser.h>
+#include <linux/mm_inline.h>
+#include <linux/fadvise.h>
 
 #include <asm/tlbflush.h> /* for arch/microblaze update_mmu_cache() */
 
@@ -2792,6 +2794,142 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	return error;
 }
 
+static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
+				loff_t end)
+{
+	int ret;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_NONE,
+		.nr_to_write = LONG_MAX,
+		.range_start = 0,
+		.range_end = LLONG_MAX,
+		.for_reclaim = 1,
+	};
+	struct page *page;
+
+	XA_STATE(xas, &mapping->i_pages, start);
+	if (!shmem_mapping(mapping))
+		return -EINVAL;
+
+	if (!total_swap_pages)
+		return 0;
+
+	lru_add_drain();
+
+	rcu_read_lock();
+	xas_for_each(&xas, page, end) {
+		if (xas_retry(&xas, page))
+			continue;
+		if (xa_is_value(page))
+			continue;
+		if (isolate_lru_page(page))
+			continue;
+
+		inc_node_page_state(page, NR_ISOLATED_ANON +
+						page_is_file_lru(page));
+		lock_page(page);
+		ClearPageDirty(page);
+		SetPageReclaim(page);
+		ret = shmem_writepage(page, &wbc);
+		if (!PageWriteback(page))
+			ClearPageReclaim(page);
+		if (ret) {
+			unlock_page(page);
+			putback_lru_page(page);
+			dec_node_page_state(page, NR_ISOLATED_ANON +
+						page_is_file_lru(page));
+			continue;
+		}
+
+		/*
+		 * shmem_writepage() place the page in the swapcache.
+		 * Delete the page from the swapcache and release the
+		 * page.
+		 */
+		lock_page(page);
+		delete_from_swap_cache(page);
+		unlock_page(page);
+		dec_node_page_state(page, NR_ISOLATED_ANON +
+						page_is_file_lru(page));
+		put_page(page);
+		if (need_resched()) {
+			xas_pause(&xas);
+			cond_resched_rcu();
+		}
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int shmem_fadvise_willneed(struct address_space *mapping,
+				 pgoff_t start, pgoff_t long end)
+{
+	struct page *page;
+
+	XA_STATE(xas, &mapping->i_pages, start);
+	rcu_read_lock();
+	xas_for_each(&xas, page, end) {
+		if (!xa_is_value(page))
+			continue;
+		page = shmem_read_mapping_page(mapping, xas.xa_index);
+		if (!IS_ERR(page))
+			put_page(page);
+
+		if (need_resched()) {
+			xas_pause(&xas);
+			cond_resched_rcu();
+		}
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	loff_t endbyte;
+	pgoff_t start_index;
+	pgoff_t end_index;
+	struct address_space *mapping;
+	int ret = 0;
+
+	mapping = file->f_mapping;
+	if (!mapping || len < 0)
+		return -EINVAL;
+
+	endbyte = (u64)offset + (u64)len;
+	if (!len || endbyte < len)
+		endbyte = -1;
+	else
+		endbyte--;
+
+
+	start_index = offset >> PAGE_SHIFT;
+	end_index   = endbyte >> PAGE_SHIFT;
+	switch (advice) {
+	case POSIX_FADV_DONTNEED:
+		ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
+		break;
+	case POSIX_FADV_WILLNEED:
+		ret = shmem_fadvise_willneed(mapping, start_index, end_index);
+		break;
+	case POSIX_FADV_NORMAL:
+	case POSIX_FADV_RANDOM:
+	case POSIX_FADV_SEQUENTIAL:
+	case POSIX_FADV_NOREUSE:
+		/*
+		 * No bad return value, but ignore advice. May have to
+		 * implement in future.
+		 */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(dentry->d_sb);
@@ -3799,6 +3937,7 @@ static const struct file_operations shmem_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
 #endif
+	.fadvise	= shmem_fadvise,
 };
 
 static const struct inode_operations shmem_inode_operations = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

