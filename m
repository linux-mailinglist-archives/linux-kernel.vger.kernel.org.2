Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0776535D8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhDMHR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:17:57 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35748 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237947AbhDMHRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:17:47 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 79E8A4023B;
        Tue, 13 Apr 2021 07:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618298248; bh=BG5GUDIVsA46ColugDQj9igzqclrdp639hYIXtnRcYc=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=TaYFRSk3LjW/r8iv8qzjLtB/wEt1a1K/78mScHkt9GzR2dry7fpmiJrlGYo/P2ZuL
         4DUYO75RYOuaqhwFd1Y1TuWLhazU2Qeija4Z8P5tsmKfdflJiZJrw2J7sttbAIDUOl
         L0hIy7Yh0fVTmpWBjCqYzEOTcyoaB8vODJjCTMxuXBWw9LOCJnt3hLrKDKPEtc6i2A
         FQtERUWaVTLgL933Jqa9GW3cVICVEpAbbDqBPKhgL6CDKYQ4m15BN5W0MpGvp/ou6m
         g/f1UB6Lm4DKUilLHkfh5oqCP8GsAR17u+zksNWG7IjJGgzXR3HdX7k1/fzz9GpKG5
         DzdnJT/GWqUBA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id C4AC8A0094;
        Tue, 13 Apr 2021 07:17:25 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:17:24 +0400
Date:   Tue, 13 Apr 2021 11:17:24 +0400
Message-Id: <98bafb89c2693eb83a17a16cfa31380223c59b06.1618297800.git.Arthur.Petrosyan@synopsys.com>
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH 10/12] usb: dwc2: Add clock gating entering flow by system suspend
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If not hibernation nor partial power down are supported,
clock gating is used to save power.

Adds a new flow of entering clock gating when PC is
suspended.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 drivers/usb/dwc2/hcd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 31d6a1b87228..09dcd37b9ef8 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4372,6 +4372,15 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		break;
 	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
 	case DWC2_POWER_DOWN_PARAM_NONE:
+		/*
+		 * If not hibernation nor partial power down are supported,
+		 * clock gating is used to save power.
+		 */
+		dwc2_host_enter_clock_gating(hsotg);
+
+		/* After entering suspend, hardware is not accessible */
+		clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+		break;
 	default:
 		goto skip_power_saving;
 	}
-- 
2.25.1

