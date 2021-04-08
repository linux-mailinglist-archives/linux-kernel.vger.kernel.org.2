Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145D9357FAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhDHJpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:45:42 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37594 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231472AbhDHJpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:45:40 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 40948407FC;
        Thu,  8 Apr 2021 09:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617875129; bh=lPCDsZcRhusTFDeg15mXbONSbqTeAeoBYV574nrxvCU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=EB4iR7h+v/MNgrocS9YbkPHZJ3jLe45pROc0WrS7JOlTpUIBOCQ+lV4FABTg3mVVb
         nImszTwIeFOK5sxdjFUXqYtc0FR7jQsQn5gob2k9OmjC7E2kQXaO33fbSPywBm9zBN
         Ex6Ql2Tpp60hFKpJICckv6EuZjRWNaPw9LvhM0pBOCjUN65LlwQDi4F9RinrUt+fF3
         S5zUAZTkMN+9fTLmMsxUc4z3ESuDmsors7p7eaurBijb1gqfAWcSZoWIdBnglTlIKo
         O1tDQh+iojRG4imXN6bhhBZ8DTHUwZwR6rx4ImNMUxI/HW7LShVML0ke/dMcgiXQv1
         Pd+LmxEqRyPpQ==
Received: from razpc-HP (razpc-hp.internal.synopsys.com [10.116.126.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 4DD7AA022E;
        Thu,  8 Apr 2021 09:45:26 +0000 (UTC)
Received: by razpc-HP (sSMTP sendmail emulation); Thu, 08 Apr 2021 13:45:25 +0400
Date:   Thu, 08 Apr 2021 13:45:25 +0400
In-Reply-To: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Subject: [PATCH v3 08/14] usb: dwc2: Add exit partial power down when port reset is asserted
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Message-Id: <20210408094526.4DD7AA022E@mailhost.synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Partial Power Down exiting flow when set port feature
reset is received in suspended state.

Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
---
 Changes in v3:
 - None
 Changes in v2:
 - None

 drivers/usb/dwc2/hcd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 720354df014b..7c7496719152 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3694,6 +3694,15 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_HIBERNATION &&
 			    hsotg->hibernated)
 				dwc2_exit_hibernation(hsotg, 0, 1, 1);
+
+			if (hsotg->in_ppd) {
+				retval = dwc2_exit_partial_power_down(hsotg, 1,
+								      true);
+				if (retval)
+					dev_err(hsotg->dev,
+						"exit partial_power_down failed\n");
+			}
+
 			hprt0 = dwc2_read_hprt0(hsotg);
 			dev_dbg(hsotg->dev,
 				"SetPortFeature - USB_PORT_FEAT_RESET\n");
-- 
2.25.1

