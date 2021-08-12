Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46C3EA73A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbhHLPNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbhHLPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0036C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:13:02 -0700 (PDT)
Date:   Thu, 12 Aug 2021 15:12:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eu/htMrm89VTLsaMuJfyw/P9NK6mk9z7bg8y6R80820=;
        b=2GOyCbOtaUb0aXKBcdD3aRhw8Feim6pn1f4UdotFUmYeVxPUPb7xNhTkYNoWAYBAgMdxSF
        Cqe8AK/T8mYsYobr8LbvEDOhnu54tZrpgWnK1IhpyYhRbg1DHIbgv363cl+9erWq7FWfkH
        ghwKIFuhG21QDavJzVpt2Ebdlk5BVBTtaJSbTbgQ95LPybBoRcPr+s+ci1LRQSuqOGmSjc
        jZdDpSn4TAaEnTnTw11Vt4bIMVTn1LWkvUAyWqnTvDkbSTONZX7Va0QEr43J5wSgWmYZD0
        haWKtntYj6ooxo2X71UOZmCmzja/Tq6jqkfZhzi684iRgpWEwSRXmEZWSdg3Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eu/htMrm89VTLsaMuJfyw/P9NK6mk9z7bg8y6R80820=;
        b=5zoaLBdkQTT4ZM3wF9ah1KjzTDhdx5N1Dl14ldjadSG6VnaP8pXwW0sQt/DaUM6Wzz3G6v
        IZ4mRmAV3YR+iAAg==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq/msi: Provide default .irq_ack()
 for MSI chips
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-11-valentin.schneider@arm.com>
References: <20210629125010.458872-11-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878117940.395.954956166954216646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     69ad12c13d582c8e28404138d8e19ea7f06166a5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/69ad12c13d582c8e28404138d8e19ea7f06166a5
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:07 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:21 +01:00

genirq/msi: Provide default .irq_ack() for MSI chips

MSI_FLAG_USE_DEF_CHIP_OPS can now provide a default .irq_eoi() to any
irqchip attached to an MSI domain. Complement it by adding a default
.irq_ack() implementation.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-11-valentin.schneider@arm.com
---
 kernel/irq/msi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c975909..127e0dd 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -274,6 +274,8 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 	BUG_ON(!chip || !chip->irq_mask || !chip->irq_unmask);
 	if (!chip->irq_set_affinity)
 		chip->irq_set_affinity = msi_domain_set_affinity;
+	if (!chip->irq_ack)
+		chip->irq_ack = irq_chip_ack_parent;
 	if (!chip->irq_eoi)
 		chip->irq_eoi = irq_chip_eoi_parent;
 }
