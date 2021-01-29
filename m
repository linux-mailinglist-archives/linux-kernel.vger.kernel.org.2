Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225A9308275
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhA2Agb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:36:31 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30]:42700 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231184AbhA2AdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:33:21 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id ED3FD89A3;
        Thu, 28 Jan 2021 16:31:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com ED3FD89A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611880273;
        bh=NjFI/jqh/CWQoeGrbisZE1b7OarwTKW7s1zJH7D6oxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MAba7cZPZZso4f5/KrUmx5MwlAtLQybzczq3F8Ok9rEQy7Hal1uQXMuI7QU2pH+5m
         E9BIbOErxNaaXdypLqYKyrcR+f4pNVMRwwU3av19u6hRI7Vghx6RVUoe8VdSVbvtM/
         r8DJvdlJWp88Ttfxh+meCnqIXHvRcsg2gjr8JfWE=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v10 11/13] misc: bcm-vk: add mmap function for exposing BAR2
Date:   Thu, 28 Jan 2021 16:30:27 -0800
Message-Id: <20210129003029.10672-12-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129003029.10672-1-scott.branden@broadcom.com>
References: <20210129003029.10672-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmap function that allows host application to open up BAR2 memory
for remote spooling out messages from the VK logger.

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 69a351fe3b38..ee926eb07542 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1199,6 +1199,29 @@ static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset __user *arg)
 	return ret;
 }
 
+static int bcm_vk_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct bcm_vk_ctx *ctx = file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
+	unsigned long pg_size;
+
+	/* only BAR2 is mmap possible, which is bar num 4 due to 64bit */
+#define VK_MMAPABLE_BAR 4
+
+	pg_size = ((pci_resource_len(vk->pdev, VK_MMAPABLE_BAR) - 1)
+		    >> PAGE_SHIFT) + 1;
+	if (vma->vm_pgoff + vma_pages(vma) > pg_size)
+		return -EINVAL;
+
+	vma->vm_pgoff += (pci_resource_start(vk->pdev, VK_MMAPABLE_BAR)
+			  >> PAGE_SHIFT);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				  vma->vm_end - vma->vm_start,
+				  vma->vm_page_prot);
+}
+
 static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	long ret = -EINVAL;
@@ -1237,6 +1260,7 @@ static const struct file_operations bcm_vk_fops = {
 	.write = bcm_vk_write,
 	.poll = bcm_vk_poll,
 	.release = bcm_vk_release,
+	.mmap = bcm_vk_mmap,
 	.unlocked_ioctl = bcm_vk_ioctl,
 };
 
-- 
2.17.1

