Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92C036202C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbhDPMsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:48:12 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38442 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243210AbhDPMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:48:07 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B70AC40E1C;
        Fri, 16 Apr 2021 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577262; bh=qpaf+tMuC1nclK+sLtQgfWYIxBk6tVHsAlbEaJ06YeM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=TbkfQBEv7GH3Cc6yenAHyky23RYsWm7GCjW98q5F9RWUcNZQjY9s8EtZf9NfrEjai
         CYecdLHtgdtQPu2bO988DeJJXo7lAHrC2U9iM3z5YKRshFoo0fOpoXufF2ONvhrg5O
         QE9HUamcQVXhz9n/6BT9zy6NgPrLX6GC3IL7kie1kYMeHmMW7nMdwOu8XbaF+PMo/z
         y1tgPs4icLhpSwQu5QB97QAAxj7bG4bKgUIju1A63/8t30cOM/WZ5Prur2QrcTlLeE
         ouPQy1wk3i/C6ZXHS+4s+N64C9FjoXRhlW+7YcqF0XZEmTlOTj8k2nmfrPSbhxZQiH
         UZZ7epruoqd3A==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id D6269A005D;
        Fri, 16 Apr 2021 12:47:39 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:47:38 +0400
Date:   Fri, 16 Apr 2021 16:47:38 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 07/15] usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is generated.
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-Id: <20210416124739.D6269A005D@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hibernation exit is performed the dwc2_hib_restore_common()
function is called. In that function we wait until GINTSTS_RESTOREDONE
bit is set. However, after the setting of that bit we get a lot of
(dwc2_hsotg_irq:) interrupts which indicates that (GINTSTS.RstrDoneInt)
restore done interrupt is asserted.

To avoid restore done interrupt storm after restore is generated
clear GINTSTS_RESTOREDONE bit in GINTSTS register.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index eccd96fa164e..576c262dba55 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -299,6 +299,12 @@ void dwc2_hib_restore_common(struct dwc2_hsotg *hsotg, int rem_wakeup,
 			__func__);
 	} else {
 		dev_dbg(hsotg->dev, "restore done  generated here\n");
+
+		/*
+		 * To avoid restore done interrupt storm after restore is
+		 * generated clear GINTSTS_RESTOREDONE bit.
+		 */
+		dwc2_writel(hsotg, GINTSTS_RESTOREDONE, GINTSTS);
 	}
 }
 
-- 
2.25.1

