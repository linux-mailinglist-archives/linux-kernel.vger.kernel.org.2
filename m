Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443463D65AD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhGZQqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbhGZQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:45:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2826C07872D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:12:32 -0700 (PDT)
Date:   Mon, 26 Jul 2021 17:12:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627319551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnukRoXGw/eB7Xm62A28nrJx2S5lPj0kVQpQmROo3rw=;
        b=Bcs2oql9MyzrBCScioUmw3ON00jVll89gUeIojvzeycsV97Tzx/iQmU+6/bTtWsqJhE5C5
        XhNA6mqZ9W6eMo1/gFHGxS409MkNfzbfvkvuItw7dz4HxDq/lIeK8VHfHRfGly5ScEKBiV
        SfERhsbAwzIepfnCYhNsXZYZp71cJddd0AZ4Z5QNClFQmZL0E9D/7WD5FBeM8H7Ti9MXaa
        dj5GSpsMfcKi364Qvj2PYyz/Kl0kDg++VRhJVPDQ+uusBvrszaopqKGRgxuitN+4vUWLi0
        xiaQdrIL4wNEwTtWZjvVgo//5f3R2gEF+b2+41cwmPacAC36s6YbSfIXCQ4WFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627319551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnukRoXGw/eB7Xm62A28nrJx2S5lPj0kVQpQmROo3rw=;
        b=fs+IgPx8gKPWc+XtDdzSuXg/2FLGAMxjeMvmo5MNfixljyWXFR7UQEEFMKClZtFqdQ+9Lz
        hdyKrbTRX+l4UyCw==
From:   "irqchip-bot for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/partitions: Switch to bitmap_zalloc()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210618151657.65305-1-andriy.shevchenko@linux.intel.com>
References: <20210618151657.65305-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162731955028.395.18225310756328944682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4cad4da0795e9c03973d5456945394aee75bdf0f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4cad4da0795e9c03973d5456945394aee75bdf0f
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 18 Jun 2021 18:16:51 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 26 Jul 2021 18:01:27 +01:00

irqchip/partitions: Switch to bitmap_zalloc()

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210618151657.65305-1-andriy.shevchenko@linux.intel.com
---
 drivers/irqchip/irq-partition-percpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index 89c23a1..8e76d29 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -215,8 +215,7 @@ struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
 		goto out;
 	desc->domain = d;
 
-	desc->bitmap = kcalloc(BITS_TO_LONGS(nr_parts), sizeof(long),
-			       GFP_KERNEL);
+	desc->bitmap = bitmap_zalloc(nr_parts, GFP_KERNEL);
 	if (WARN_ON(!desc->bitmap))
 		goto out;
 
