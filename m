Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214B23601B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhDOFka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:40:30 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53722 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230296AbhDOFk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:40:27 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6B1ACC0638;
        Thu, 15 Apr 2021 05:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618465204; bh=FxOfx5Bn8qkUjQt47mpov0RocJvJwOaxj7tZCSw43H0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=d1O9nnMGmI5ivJRs/ZCkz4HJVx3aQyt9bbU40bK2+j+5/J1EueLTg8dDHcGzdgGxN
         UzYywOCSzonOzTGi6YxPO6QTmgmM6smkfJxslxBDMR46eUNh+/fFqzDK2xEnEAJKDK
         7XZ+4QHAWATQg1/ZUymaVM903i4w5yFKsyWEoA+P66dja5cCMYx7R/cM/ZDYlapGxC
         N9qGQY99RHCxGrOhN1kUGn7xnkqgUItWxR5GVtricGuyXpXAzwY+GDwknMMB8omz3O
         V7WtBACBQ9K0nzHX4fa8Mk6tblZ0YGc/+ieK2VPUgmZCwXRFrn5hKBzq+UHorfGlns
         e8Vnf+Bq2SU8w==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 6F804A005C;
        Thu, 15 Apr 2021 05:40:01 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 15 Apr 2021 09:40:00 +0400
Date:   Thu, 15 Apr 2021 09:40:00 +0400
Message-Id: <1a7c38722ebff88be857655485f2a341e73a7e4f.1618464534.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 05/15] usb: dwc2: Allow exiting hibernation from gpwrdn rst detect
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

When device cable is disconnected core receives suspend
interrupt and enters hibernation. After entering
into hibernation GPWRDN_RST_DET and GPWRDN_STS_CHGINT
interrupts are asserted.

Allowed exit from gadget hibernation from
GPWRDN_RST_DET by checking only linestate.

Changed the return type of "dwc2_handle_gpwrdn_intr()"
function from void to int because exit from hibernation
functions have a return value.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/core_intr.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 27d729fad227..f8963c0cf6af 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -751,10 +751,11 @@ static inline void dwc_handle_gpwrdn_disc_det(struct dwc2_hsotg *hsotg,
  * The GPWRDN interrupts are those that occur in both Host and
  * Device mode while core is in hibernated state.
  */
-static void dwc2_handle_gpwrdn_intr(struct dwc2_hsotg *hsotg)
+static int dwc2_handle_gpwrdn_intr(struct dwc2_hsotg *hsotg)
 {
 	u32 gpwrdn;
 	int linestate;
+	int ret = 0;
 
 	gpwrdn = dwc2_readl(hsotg, GPWRDN);
 	/* clear all interrupt */
@@ -778,17 +779,27 @@ static void dwc2_handle_gpwrdn_intr(struct dwc2_hsotg *hsotg)
 		if (hsotg->hw_params.hibernation &&
 		    hsotg->hibernated) {
 			if (gpwrdn & GPWRDN_IDSTS) {
-				dwc2_exit_hibernation(hsotg, 0, 0, 0);
+				ret = dwc2_exit_hibernation(hsotg, 0, 0, 0);
+				if (ret)
+					dev_err(hsotg->dev,
+						"exit hibernation failed.\n");
 				call_gadget(hsotg, resume);
 			} else {
-				dwc2_exit_hibernation(hsotg, 1, 0, 1);
+				ret = dwc2_exit_hibernation(hsotg, 1, 0, 1);
+				if (ret)
+					dev_err(hsotg->dev,
+						"exit hibernation failed.\n");
 			}
 		}
 	} else if ((gpwrdn & GPWRDN_RST_DET) &&
 		   (gpwrdn & GPWRDN_RST_DET_MSK)) {
 		dev_dbg(hsotg->dev, "%s: GPWRDN_RST_DET\n", __func__);
-		if (!linestate && (gpwrdn & GPWRDN_BSESSVLD))
-			dwc2_exit_hibernation(hsotg, 0, 1, 0);
+		if (!linestate) {
+			ret = dwc2_exit_hibernation(hsotg, 0, 1, 0);
+			if (ret)
+				dev_err(hsotg->dev,
+					"exit hibernation failed.\n");
+		}
 	} else if ((gpwrdn & GPWRDN_STS_CHGINT) &&
 		   (gpwrdn & GPWRDN_STS_CHGINT_MSK)) {
 		dev_dbg(hsotg->dev, "%s: GPWRDN_STS_CHGINT\n", __func__);
@@ -800,6 +811,8 @@ static void dwc2_handle_gpwrdn_intr(struct dwc2_hsotg *hsotg)
 		 */
 		dwc_handle_gpwrdn_disc_det(hsotg, gpwrdn);
 	}
+
+	return ret;
 }
 
 /*
-- 
2.25.1

