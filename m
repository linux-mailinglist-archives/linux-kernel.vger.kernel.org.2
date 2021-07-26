Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B7B3D65A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhGZQpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbhGZQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:45:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39AFC0619C2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:12:30 -0700 (PDT)
Date:   Mon, 26 Jul 2021 17:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627319547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXBQZsDd51W2sdOYvJQ5MXROj2T+/uSsDgUby9kd9a0=;
        b=qPhy8HC21qqCkQsEDMYKc7rL4dJ+czf5LeV14KXFFB+uw87/LZTnOMDWTYwsu2QInWNDnx
        KLgDUk3z3qkIYmVo5y4MUPaO57TQgxSZptUJQolwUHps/rXQUPD4m8veqGH3RdAWk32C6T
        WeN8IvYU1mxrn9Kp5feg1Hpha/dxWHmf8U7HwTqzkYxxfy9jjmYe8MQrmA7ps/t/jRvzN0
        RK6DOUNR8uNGfA4mBMXyL5cECPNos4vUyD113S1SmaV+IZ8YCRDskVEMCJjr/J5OV5zTQj
        KL7GDarRlDaAA/4J7Hm+q1Pc8i8Oa1YCMcHWDF2FEXeL5hnpyRreoh4j8eq4WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627319547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXBQZsDd51W2sdOYvJQ5MXROj2T+/uSsDgUby9kd9a0=;
        b=IJw5B1lE93GmNH5H30xw1vcX22IcvkiSyAgrKMkDdRxJOZem23QsejX8CLrfykAhr9u6PN
        1IqSSo+GpFVaYLBg==
From:   "irqchip-bot for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mvebu-odmi: Switch to bitmap_zalloc()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210618151657.65305-7-andriy.shevchenko@linux.intel.com>
References: <20210618151657.65305-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162731954673.395.7245296324600505338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c980983daebf10633c922998bade3a7fd74f1fc1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c980983daebf10633c922998bade3a7fd74f1fc1
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 18 Jun 2021 18:16:57 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 26 Jul 2021 18:04:11 +01:00

irqchip/mvebu-odmi: Switch to bitmap_zalloc()

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210618151657.65305-7-andriy.shevchenko@linux.intel.com
---
 drivers/irqchip/irq-mvebu-odmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index b4d3678..dc4145a 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -171,8 +171,7 @@ static int __init mvebu_odmi_init(struct device_node *node,
 	if (!odmis)
 		return -ENOMEM;
 
-	odmis_bm = kcalloc(BITS_TO_LONGS(odmis_count * NODMIS_PER_FRAME),
-			   sizeof(long), GFP_KERNEL);
+	odmis_bm = bitmap_zalloc(odmis_count * NODMIS_PER_FRAME, GFP_KERNEL);
 	if (!odmis_bm) {
 		ret = -ENOMEM;
 		goto err_alloc;
@@ -227,7 +226,7 @@ err_unmap:
 		if (odmi->base && !IS_ERR(odmi->base))
 			iounmap(odmis[i].base);
 	}
-	kfree(odmis_bm);
+	bitmap_free(odmis_bm);
 err_alloc:
 	kfree(odmis);
 	return ret;
