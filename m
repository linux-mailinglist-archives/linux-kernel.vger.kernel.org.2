Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA393D65AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbhGZQp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbhGZQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:45:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CDEC078728
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:12:31 -0700 (PDT)
Date:   Mon, 26 Jul 2021 17:12:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627319549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0s8dgNYACO8bsyr46O6qiFYEDhSPM5zMg38aDC0gnGk=;
        b=xsewpt7T/j5n4YrLjTMzZu3MZlmI2rta2Q4JO2OUMH/Te1m4FR47LLtwyyXLv/8u9ojhMf
        W6xYXnjlsl6ppa/flS8JUIDF2LJhXJSBBi5Fg2eGDvd4hTn8wMh5HU5novwa+l8yA2+n64
        SdlyQicgxAniQ7TiUtYYT7yO13hGBpcUbA7WZnn38mGM/8FNyKMX4k3TH5rKEU8IOyeXbB
        O3onuBjg4vuALjUKNL6rvTTqtexIMTEI4W4a/CoMEqHDyhJQKC1bUTKKQWCRdsIS29HQRy
        SCVUNaBLjH0kTAA2DKDDZFQAxbGf6HddFy9H8dkCjw6rrOxgKwqhQKOfMQC0tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627319549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0s8dgNYACO8bsyr46O6qiFYEDhSPM5zMg38aDC0gnGk=;
        b=5JhBcgn4VKB7ziF9dU/vnxI2/3gnedWzVaGDLYsX5clEsUisKOHEjJ3QPa5dqon9hnjj4U
        hFeik1zgOYhcJABw==
From:   "irqchip-bot for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v2m: Switch to bitmap_zalloc()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210618151657.65305-3-andriy.shevchenko@linux.intel.com>
References: <20210618151657.65305-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162731954920.395.6194793714346482738.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     81d3c9e7b43e9426e67a5df66d51a5f2bfce0362
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/81d3c9e7b43e9426e67a5df66d51a5f2bfce0362
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 18 Jun 2021 18:16:53 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 26 Jul 2021 18:01:44 +01:00

irqchip/gic-v2m: Switch to bitmap_zalloc()

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210618151657.65305-3-andriy.shevchenko@linux.intel.com
---
 drivers/irqchip/irq-gic-v2m.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index be9ea6f..9349fc6 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -269,7 +269,7 @@ static void gicv2m_teardown(void)
 
 	list_for_each_entry_safe(v2m, tmp, &v2m_nodes, entry) {
 		list_del(&v2m->entry);
-		kfree(v2m->bm);
+		bitmap_free(v2m->bm);
 		iounmap(v2m->base);
 		of_node_put(to_of_node(v2m->fwnode));
 		if (is_fwnode_irqchip(v2m->fwnode))
@@ -386,8 +386,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 			break;
 		}
 	}
-	v2m->bm = kcalloc(BITS_TO_LONGS(v2m->nr_spis), sizeof(long),
-			  GFP_KERNEL);
+	v2m->bm = bitmap_zalloc(v2m->nr_spis, GFP_KERNEL);
 	if (!v2m->bm) {
 		ret = -ENOMEM;
 		goto err_iounmap;
