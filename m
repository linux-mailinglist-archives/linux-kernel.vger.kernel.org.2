Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7786458496
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 16:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhKUP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 10:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbhKUP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 10:58:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F34AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cYs06rCiSJLo2niacctZbBcCGz2tP/7rUUeqqAAMX2s=; b=LjbEPYNRSnQ5ZwW6TsejV4Hbpg
        9y+GLeHwmsA/BgeIFUQ+RPL1FKb+gG/cpC++l3WYTND426O3jGapRWr8RI7zd0uS9RjWfl1zkO6nj
        kBARsDwbqHH7P+RdSsAu+Dy7aG/x9vnibEJUVqqA3klqALhcXBxDQb0bOt/4zgi07K38XEuolDmW0
        v2AzKLCs6e0WEd7VyG2+nRVMFVkuyWXIQGHNn8W5XDGJKeIIZfvzXrgrBM3FkGF5+RJGBx+b+yi0U
        hfqsy7Y+4k4PYQmhTz3o8/KwUoXqHsL5mAAsDPkdn+iu97eeEhiyL5GjQVzzOJpAuyhdzTTlHJDLL
        5SomG9/w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mopB8-00Ds9r-Go; Sun, 21 Nov 2021 15:54:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: ttm: correct ttm_range_manager kernel-doc notation
Date:   Sun, 21 Nov 2021 07:54:52 -0800
Message-Id: <20211121155453.29736-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings in ttm_range_manager.c:

drivers/gpu/drm/ttm/ttm_range_manager.c:144: warning: expecting prototype for ttm_range_man_init(). Prototype was for ttm_range_man_init_nocheck() instead
drivers/gpu/drm/ttm/ttm_range_manager.c:178: warning: expecting prototype for ttm_range_man_fini(). Prototype was for ttm_range_man_fini_nocheck() instead

Also fix subsequent warnings from scripts/kernel-doc.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/ttm/ttm_range_manager.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- linux-next-20211118.orig/drivers/gpu/drm/ttm/ttm_range_manager.c
+++ linux-next-20211118/drivers/gpu/drm/ttm/ttm_range_manager.c
@@ -128,15 +128,17 @@ static const struct ttm_resource_manager
 };
 
 /**
- * ttm_range_man_init
+ * ttm_range_man_init_nocheck - Initialise a generic range manager for the
+ * selected memory type.
  *
  * @bdev: ttm device
  * @type: memory manager type
  * @use_tt: if the memory manager uses tt
  * @p_size: size of area to be managed in pages.
  *
- * Initialise a generic range manager for the selected memory type.
  * The range manager is installed for this device in the type slot.
+ *
+ * Return: %0 on success or a negative error code on failure
  */
 int ttm_range_man_init_nocheck(struct ttm_device *bdev,
 		       unsigned type, bool use_tt,
@@ -166,12 +168,13 @@ int ttm_range_man_init_nocheck(struct tt
 EXPORT_SYMBOL(ttm_range_man_init_nocheck);
 
 /**
- * ttm_range_man_fini
+ * ttm_range_man_fini_nocheck - Remove the generic range manager from a slot
+ * and tear it down.
  *
  * @bdev: ttm device
  * @type: memory manager type
  *
- * Remove the generic range manager from a slot and tear it down.
+ * Return: %0 on success or a negative error code on failure
  */
 int ttm_range_man_fini_nocheck(struct ttm_device *bdev,
 		       unsigned type)
