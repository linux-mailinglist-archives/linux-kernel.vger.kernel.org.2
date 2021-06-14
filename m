Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7723A5CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 08:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhFNGEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 02:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhFNGEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:04:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773C7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 23:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sieSQHIhc9L3rVXPIAwUGKB2AvAP2MFbOfxqoxwsg4U=; b=wZxHfYqRBbxRGGfMiV7814q16g
        VHgJ/SczeABySXR1oXuAz4MQiYN/6luTuuAbCsveMN4bCaIch91W/W9pcYs2CJDZHpTPYAndYVGHn
        C4NeOCD2KJmeVRglt3YUhzNYZ6uE0t8VdHTkVKb0h9gMpEiyvE6OJkyOX0MyILiWvxFZ+orXIvg5/
        rDMgdyJQ4nxnRE8D2zGArCoHIR9/jdGU4ywoFbUzKC8eaK02YbcQ/befS0yn/W3nY8FYJWe78Nhkc
        0ZAV+JO65fzcZhKn8RuLBkqmuIivAz0ZDP7u12z27d1+qnlVEFDYmKoBSmH3Ez7n62lkaTv20P4Wk
        Mn09AWyA==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsfg9-00CfkX-BH; Mon, 14 Jun 2021 06:02:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] null_blk: remove an unused variable assignment in null_add_dev
Date:   Mon, 14 Jun 2021 08:02:31 +0200
Message-Id: <20210614060231.3965278-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the recent blk_alloc_disk conversion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 3b320b005aa8..d734e9ee1546 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1849,7 +1849,6 @@ static int null_add_dev(struct nullb_device *dev)
 		if (!null_setup_fault())
 			goto out_cleanup_tags;
 
-		rv = -ENOMEM;
 		nullb->tag_set->timeout = 5 * HZ;
 		nullb->disk = blk_mq_alloc_disk(nullb->tag_set, nullb);
 		if (IS_ERR(nullb->disk)) {
-- 
2.30.2

