Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDED3FBECB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhH3WLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbhH3WLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:11:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47529C061760;
        Mon, 30 Aug 2021 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hQpc9Bt96A8NsIGsTZlgxwf8NGt2COgjAu8WZh0eqQI=; b=lqZjOsvPpbo3iaqwzw0Xf0z3LB
        QuVCHBK7Vo83UWNG4DG1RW5uvFpqNfELCzxwf/I0pysV1KiUs6dTOkmAt97Iyhp34pP/6v/B5hh3Q
        ikdYvQdQicXlWig6OZqWuTavl1aL8qOhNq5JoxxHg5crCwspmjqwynessQjuBaOwE9sq4XroFKOUK
        eTCI0zxZfhr7VKdS5LB2/xVvHxAvUElGLp7U2EgH9PXH168I9vZBD7MCHcs6HyOsxhLI9uHMpuHDn
        gQgjliWZrsnWziSE5bCNMqJL+Ueu5h/3SNH96cbQk1TXbBRhdj2WhVU7ctuPd18k10YL5j3aWs9n1
        W+MueH8Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKpTj-000khE-Jv; Mon, 30 Aug 2021 22:10:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 01/15] z2ram: add error handling support for add_disk()
Date:   Mon, 30 Aug 2021 15:09:46 -0700
Message-Id: <20210830221000.179369-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830221000.179369-1-mcgrof@kernel.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling. Only the disk is cleaned up inside
z2ram_register_disk() as the caller deals with the rest.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/z2ram.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 4eef218108c6..6648bbc87c30 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -318,6 +318,7 @@ static const struct blk_mq_ops z2_mq_ops = {
 static int z2ram_register_disk(int minor)
 {
 	struct gendisk *disk;
+	int err;
 
 	disk = blk_mq_alloc_disk(&tag_set, NULL);
 	if (IS_ERR(disk))
@@ -333,8 +334,10 @@ static int z2ram_register_disk(int minor)
 		sprintf(disk->disk_name, "z2ram");
 
 	z2ram_gendisk[minor] = disk;
-	add_disk(disk);
-	return 0;
+	err = add_disk(disk);
+	if (err)
+		blk_cleaup_disk(disk);
+	return err;
 }
 
 static int __init z2_init(void)
-- 
2.30.2

