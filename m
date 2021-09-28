Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6768841A290
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbhI0WHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhI0WGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:35 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C1AC051746;
        Mon, 27 Sep 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YC09ub7H5zBS0+xaUnAKeTnZGFxVdKsA0MqfDrrsdEA=; b=qXe/9q0VrWzJQ6L2paDwqwlDOz
        9ymCO7BTLZOnONaIF04YusbGQgSi/HTXHc7CH4L8jQB9OCifwbM/e8/udMQB714Tt2PKNfgc1JxGv
        nNhmK4Jy1UGl7LOty8p0f126dlU8JOi70lbitnNl7os7wvm2gVE7+FY6PBSph0ZzWp+3hgDALhS5v
        dRr4ALq5v9A+dsNmHau7/VVWd1NgAmi7OyP0fJMvHeYqcrwnXycfo8WyCshLUgZ09TON4YfPAaH2c
        +u5HforcmGk1TYHOcC5dEi3oEeGwOMt5VXIe/WiJ+NoX6wzLJom9jjrw9gGganY31wRN4n4Wo8zv+
        CxGWakbg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiF-004VI9-IG; Mon, 27 Sep 2021 22:03:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 05/14] floppy: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:02:53 -0700
Message-Id: <20210927220302.1073499-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
References: <20210927220302.1073499-1-mcgrof@kernel.org>
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
 drivers/block/floppy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3592a6277d0b..0434f28742e7 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4696,8 +4696,10 @@ static int __init do_floppy_init(void)
 
 		registered[drive] = true;
 
-		device_add_disk(&floppy_device[drive].dev, disks[drive][0],
-				NULL);
+		err = device_add_disk(&floppy_device[drive].dev,
+				      disks[drive][0], NULL);
+		if (err)
+			goto out_remove_drives;
 	}
 
 	return 0;
-- 
2.30.2

