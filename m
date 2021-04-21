Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9238366C01
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbhDUNKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241208AbhDUNHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC44761460;
        Wed, 21 Apr 2021 13:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010424;
        bh=CnZ7WV5hyKsc+Xdaoj6tfN3IEyd8ep1/EpD1Q8f9zE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2RWtWfBnB/NBVUhz96VzRiYo0f5YqQ78stqFMuqOYEjaXfNGVAOpi6i2GBELOwRz
         z3leh0auNFsCQkm+H/OJbyxqOrS1wanesZcz8FUnD4rbVeHKQ8WiV4W0Yg3JZD3hGE
         FBOhSoZc+tJmy9K+kAGShDQLJH39Yhf27tMzsOX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 131/190] Revert "net: 8390: fix potential NULL pointer dereferences"
Date:   Wed, 21 Apr 2021 15:00:06 +0200
Message-Id: <20210421130105.1226686-132-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c7cbc3e937b885c9394bf9d0ca21ceb75c2ac262.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/8390/pcnet_cs.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index 9d3b1e0e425c..0a408fa2b7a4 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -289,11 +289,6 @@ static struct hw_info *get_hwinfo(struct pcmcia_device *link)
 
     virt = ioremap(link->resource[2]->start,
 	    resource_size(link->resource[2]));
-    if (unlikely(!virt)) {
-	    pcmcia_release_window(link, link->resource[2]);
-	    return NULL;
-    }
-
     for (i = 0; i < NR_INFO; i++) {
 	pcmcia_map_mem_page(link, link->resource[2],
 		hw_info[i].offset & ~(resource_size(link->resource[2])-1));
@@ -1430,11 +1425,6 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     /* Try scribbling on the buffer */
     info->base = ioremap(link->resource[3]->start,
 			resource_size(link->resource[3]));
-    if (unlikely(!info->base)) {
-	    ret = -ENOMEM;
-	    goto failed;
-    }
-
     for (i = 0; i < (TX_PAGES<<8); i += 2)
 	__raw_writew((i>>1), info->base+offset+i);
     udelay(100);
-- 
2.31.1

