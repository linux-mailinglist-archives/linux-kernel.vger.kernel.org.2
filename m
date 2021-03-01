Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F833297BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbhCAWvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238396AbhCARrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:47:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2E4864F69;
        Mon,  1 Mar 2021 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614617956;
        bh=t+OlSRSKsvR2p+UkRmB/vxRTFGJ2W8Y7c1keWtxtQ8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGIlx86v94TXTbVHMlNqZrCuE6SkWvUQ+5ysTizSkA6MyO4o3tOgT/l6FlYS/9ClL
         EF6SWqtSXbtAsuHUowJtpkvPT537XpsvHz1i2bibJk4PH81HwrRNO4k7Sb4+bimw2s
         yiI7eiXswa8BWlkNIBe8x3n8drfhuk3GoExci1Cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Kai Krakow <kai@kaishome.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 255/340] bcache: Give btree_io_wq correct semantics again
Date:   Mon,  1 Mar 2021 17:13:19 +0100
Message-Id: <20210301161100.846774185@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161048.294656001@linuxfoundation.org>
References: <20210301161048.294656001@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Krakow <kai@kaishome.de>

commit d797bd9897e3559eb48d68368550d637d32e468c upstream.

Before killing `btree_io_wq`, the queue was allocated using
`create_singlethread_workqueue()` which has `WQ_MEM_RECLAIM`. After
killing it, it no longer had this property but `system_wq` is not
single threaded.

Let's combine both worlds and make it multi threaded but able to
reclaim memory.

Cc: Coly Li <colyli@suse.de>
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Kai Krakow <kai@kaishome.de>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/btree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -2670,7 +2670,7 @@ void bch_btree_exit(void)
 
 int __init bch_btree_init(void)
 {
-	btree_io_wq = create_singlethread_workqueue("bch_btree_io");
+	btree_io_wq = alloc_workqueue("bch_btree_io", WQ_MEM_RECLAIM, 0);
 	if (!btree_io_wq)
 		return -ENOMEM;
 


