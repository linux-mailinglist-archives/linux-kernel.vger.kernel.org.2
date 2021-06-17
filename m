Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0291D3AB310
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhFQLyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFQLyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:54:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2976C061574;
        Thu, 17 Jun 2021 04:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eWfLpTUm88WigYNAtGgk0puveZH4s8vjCO/lhD+KZFA=; b=Ksd9U+/hjhk7n5mA5nDGHYSxdq
        ZjKymSIxqpChMzh0uIjvW46GqzQIAUbUkc2KgZ9iAtw8Occ48KXpEdrwhf1V/SOTILfcoq15YzLe3
        pd2CTMHOibHCqPeQRFeJ+4BC4ILcOzzZlwMQ2XJdFSZSJQvxqsSIiiB86v16VD2X6LhGwWc2G4m1t
        uFkCcygCch96mtPisbW0Rcu8S0F+xiZ7w0iBJigWj0LIkJiT4+ftv1HKs+Gl2mWC+/9jGuRXczqQu
        giuqpDjJl4ppLa1xG1/FiE+jjtHCtzBVDRSSiR/xwcuf8YQMDOUoC40mvQmMTWu7Ez0sr24mI8Vhz
        GU+A0e7g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltqYN-0095Tm-BZ; Thu, 17 Jun 2021 11:51:30 +0000
Date:   Thu, 17 Jun 2021 12:51:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] block: break circular locks in blk_request_module
Message-ID: <YMs3O/cg4V7ywlVq@infradead.org>
References: <20210617092016.522985-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617092016.522985-1-desmondcheongzx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 05:20:16PM +0800, Desmond Cheong Zhi Xi wrote:
>  	mutex_lock(&major_names_lock);
>  	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
>  		if ((*n)->major == major && (*n)->probe) {
> -			(*n)->probe(devt);
> +			probe = (*n)->probe;
>  			mutex_unlock(&major_names_lock);
> +			probe(devt);

And now you can all probe after it has been freed and/or the module has
been unloaded. The obviously correct fix is to only hold mtd_table_mutex
for the actually required critical section:

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index fb8e12d590a1..065d94f9b1fb 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -529,13 +529,11 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
 		register_mtd_user(&blktrans_notifier);
 
 
-	mutex_lock(&mtd_table_mutex);
 
 	ret = register_blkdev(tr->major, tr->name);
 	if (ret < 0) {
 		printk(KERN_WARNING "Unable to register %s block device on major %d: %d\n",
 		       tr->name, tr->major, ret);
-		mutex_unlock(&mtd_table_mutex);
 		return ret;
 	}
 
@@ -545,12 +543,12 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
 	tr->blkshift = ffs(tr->blksize) - 1;
 
 	INIT_LIST_HEAD(&tr->devs);
-	list_add(&tr->list, &blktrans_majors);
 
+	mutex_lock(&mtd_table_mutex);
+	list_add(&tr->list, &blktrans_majors);
 	mtd_for_each_device(mtd)
 		if (mtd->type != MTD_ABSENT)
 			tr->add_mtd(tr, mtd);
-
 	mutex_unlock(&mtd_table_mutex);
 	return 0;
 }
