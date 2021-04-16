Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5551A36201D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbhDPMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:47:29 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42226 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243069AbhDPMr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:47:27 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 85CD0C06B9;
        Fri, 16 Apr 2021 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618577222; bh=EB3d1O8ZkzAhpUgq8QJFbFXUneDMHT1L8PBMvL6acPw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=BTKwQJ01811YGPnYL7QPJGuoLneHbq2jCfFXUl3pnyiWR6+Ik+VmFApXc6gLOzkxG
         vPmXlDcnue2xUUsPOIQqPVZSh8BZo3rrrXhHJ1BGAUxvjINi8uDch5ReOXWP8HPgpx
         IXW60CsAOHFoN7J0CykiS7pl1Yeybyzf44bUov/AkJzBRILoBK4oZ2IsJEmutGFCeK
         WWAWmiMHiOi1EZc56R+UEA5tIYgDQhPAThLV8EpPjwCJNsuHiq+J7HZOEH5p3FPqfL
         vitCp6G1q5vsW6rGPdHFApiy0HAfUp1LXeZgXf4YKdU5+CZgLM4lRONwsKOu5A5Xwk
         zHDV2bCML4keA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 652CFA005C;
        Fri, 16 Apr 2021 12:46:59 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Fri, 16 Apr 2021 16:46:58 +0400
Date:   Fri, 16 Apr 2021 16:46:58 +0400
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 02/15] usb: dwc2: Reset DEVADDR after exiting gadget hibernation.
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-Id: <20210416124659.652CFA005C@mailhost.synopsys.com>
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

