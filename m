Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6BB3601BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhDOFkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:40:51 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53744 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230366AbhDOFkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:40:43 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E7DD8C0619;
        Thu, 15 Apr 2021 05:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465221; bh=qpaf+tMuC1nclK+sLtQgfWYIxBk6tVHsAlbEaJ06YeM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=X64+WLMkkDO2RIGGRdFTTT1PgYTEwOjayyv60BDpM+Oa7bxzC5wBCQzxic06KURxF
         epHeEUSdfNcUqjbfH3IeoDomMD7HFZCxfgz5KDd0stfrS3SbzhVxuTspdJkkI75FD/
         P677vIBf4z3OVJ6WlGco++kJ0ZdXgscMOgChaE5dK9PEiT5Is/mB77FK5b+uHzHYb8
         GjoX5csDdfs8LGxxRnHTKc7LVXiOkp7yadLe3Vll827dhchX3/S5r+hMLxs7fbqzyi
         LcmiwnTPruYamWdt+1gsB2genWjjl+j1cI+zjKrU5nu8tFgqD+jF8xY4JD0RGNkZsw
         1vYPcxDqKERnQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id EBA62A005D;
        Thu, 15 Apr 2021 05:40:17 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:40:16 +0400
Date:   Thu, 15 Apr 2021 09:40:16 +0400
Message-Id: <e11f18a51f9e1de056ebafc434504e03d758bbdf.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 07/15] usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is generated.
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
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

