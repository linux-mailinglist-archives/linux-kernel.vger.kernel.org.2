Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A6C3601AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhDOFkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:40:05 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56436 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230159AbhDOFkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:40:02 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3B076400CB;
        Thu, 15 Apr 2021 05:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465179; bh=EB3d1O8ZkzAhpUgq8QJFbFXUneDMHT1L8PBMvL6acPw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=D28ijBM+9zkLyup6OeGK2f9lmOi+EhilzKWW9yut2d+7kr2L3Fj3FDzi2MA6bwshT
         aLZ74Vs3t+GmsXIESg5ZVx6JghQ9cevd6WgMGUuSF1B9qlr82csRfYHxtD95Jz4GH2
         fPdaR5rLGICfDKB1Kjuly+XAtisZJHln+w3/LZtsJr3g0Giw/jFs5xxPCAanDjJiR+
         jS4IvHXvAhOmvGvPnNH91vZcWeiPC1TmhtXiEtOctQvzIEIUBLftB8SkG8+af0aWC6
         LbxvGhz8oLBcnTAPyaC4fvcPiGBZDa2cJnC+WN7L45pzgq3aAke5dU7REK6+PuHk/H
         T1xfmkBGpMhlA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 4D7D9A005C;
        Thu, 15 Apr 2021 05:39:36 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:39:35 +0400
Date:   Thu, 15 Apr 2021 09:39:35 +0400
Message-Id: <db6f89882b40cfbefd5c6d7281f30742774fbd15.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 02/15] usb: dwc2: Reset DEVADDR after exiting gadget hibernation.
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

Initially resetting device address was done in dwc2_hsotg_irq()
interrupt handler. However, when core is hibernated USB RESET
is not handled in dwc2_hsotg_irq() handler, instead USB RESET
interrupt is handled in dwc2_handle_gpwrdn_intr() handler.

- Added reset device address to zero when core exits from gadget
  hibernation.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/gadget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 2f50f3e62caa..e6bb1bdb2760 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5305,6 +5305,10 @@ int dwc2_gadget_exit_hibernation(struct dwc2_hsotg *hsotg,
 	dwc2_writel(hsotg, dr->dcfg, DCFG);
 	dwc2_writel(hsotg, dr->dctl, DCTL);
 
+	/* On USB Reset, reset device address to zero */
+	if (reset)
+		dwc2_clear_bit(hsotg, DCFG, DCFG_DEVADDR_MASK);
+
 	/* De-assert Wakeup Logic */
 	gpwrdn = dwc2_readl(hsotg, GPWRDN);
 	gpwrdn &= ~GPWRDN_PMUACTV;
-- 
2.25.1

