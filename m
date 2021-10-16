Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C342FF36
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 01:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbhJOXzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 19:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbhJOXzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 19:55:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F77C061762;
        Fri, 15 Oct 2021 16:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6NZfHmNoX5N/dbslA9tEZ3wm71g//v2MOeHuD/3FoC0=; b=IqiWkGJxOs4RZJjHpZ7nll994s
        uQA7UIW+Ocik9GPEuu98PXKCk2c1/R4dmgJNmMK7hIT0CSmMm2dNOhTyBQnJAcQVps9OAi5PycSEB
        lFwC/uYATxJhPiYhXVyPODu4sXxqnG/Kv6uAQzwaYmHA5XxAypucqitped5paW7j/jY5YdjpBuwNO
        JXXnDjWd7gRdgfbjhElarcK95Xm273zx4UiqerCVkP3oitZ1QvMbY/dK2IjadIAuhraTLxgzCGeBo
        hA6DJrWJ+8rFDTxLBOZlKX+fmT/H5hwAwFdfvcPhQB8OtMJQQqLRwkmCHBpjn7W+8UVgkpKB5sRdm
        X3RLj42w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbWzt-009C3H-Bn; Fri, 15 Oct 2021 23:52:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
        minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 11/13] ps3vram: add error handling support for add_disk()
Date:   Fri, 15 Oct 2021 16:52:17 -0700
Message-Id: <20211015235219.2191207-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/ps3vram.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index c7b19e128b03..af2a0d09c598 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -755,9 +755,14 @@ static int ps3vram_probe(struct ps3_system_bus_device *dev)
 	dev_info(&dev->core, "%s: Using %llu MiB of GPU memory\n",
 		 gendisk->disk_name, get_capacity(gendisk) >> 11);
 
-	device_add_disk(&dev->core, gendisk, NULL);
+	error = device_add_disk(&dev->core, gendisk, NULL);
+	if (error)
+		goto out_cleanup_disk;
+
 	return 0;
 
+out_cleanup_disk:
+	blk_cleanup_disk(gendisk);
 out_cache_cleanup:
 	remove_proc_entry(DEVICE_NAME, NULL);
 	ps3vram_cache_cleanup(dev);
-- 
2.30.2

