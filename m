Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E68735D913
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242493AbhDMHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:37:59 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36518 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241598AbhDMHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:37:38 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DFA8D40162;
        Tue, 13 Apr 2021 07:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618299439; bh=oQLK+as116JsTTrwBLAOVEJMYz2eNHyQVGS7SPLaUGU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=g3/xysSbZVxmBNw/QcoiUV39KPyjS5jPK7ofrJeCxysCJHKDHx623afBwmWXykWDw
         QyuDS4/ZyTRZJlvH4IMCzC9bTT9r3y/pz3QErn763nsdNA+SQml+DyXce6EcjDHEDI
         4Y1dBxti8n9I6cMKKcMtLNNKMe4kxTRtbnunqxpur67bFYf3OXZ2JQA4kfA157lxL6
         74UfokeP9YVEDeU/5eJbxOqSRq1hl0GzLwvZRofOOz74bmaw33l+KsMaC0/5Nd2RtI
         nhIHEI08e0XfJNC6C6XB9ChrOmo36GSRkA/qdEr0+i6VbiEDfmFaOvcTgT6rfaHhSq
         diQO51rjzrkaA==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 30C13A0094;
        Tue, 13 Apr 2021 07:37:16 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Tue, 13 Apr 2021 11:37:15 +0400
Date:   Tue, 13 Apr 2021 11:37:15 +0400
In-Reply-To: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v2 10/12] usb: dwc2: Add clock gating entering flow by system suspend
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210413073716.30C13A0094@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If not hibernation nor partial power down are supported,
clock gating is used to save power.

Adds a new flow of entering clock gating when PC is
suspended.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v2:
 - None

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

