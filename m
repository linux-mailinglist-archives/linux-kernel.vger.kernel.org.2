Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885AC458E61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhKVMe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhKVMeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:34:24 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37F7C061574;
        Mon, 22 Nov 2021 04:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=ace3/XkDSzXxtFm7I2wASteyEKOS8kkwwgKgrgoR8LQ=; b=mt
        pzpg+rIsfzG++WakSY42tuhyBlPp2Mq6eq5tZnX0E+c6dKDLOQ5fb90Fqa6pMuILbgKgdluf6mDUG
        Ea73ezuP0YaktactL7f4OMd2PfW8ugbu974cGnbhw7LMO+BHKgnFrLuXkq+vrSYVhpQvw3XMZAsaY
        R09iNrADWnB8aY0n/EITwiNjNDAIigRmdQ7f9xOS3ThmEDFMFns0JHOvyvAM+LPJGI5sEUuJLZnRx
        Dm0oszQlxdIhG+O4APdJS0sF0wEYSoLgUOgfs9BUd2Po5EkuvBCIOovSKBAIukd4RTVD4wLrquwP4
        tcAM5u70vUOX/RsJelXt7qHPvlhfnI5g==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mp8TY-0002Sr-Tp; Mon, 22 Nov 2021 12:31:13 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     John Keeping <john@metanate.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc2: gadget: use existing helper
Date:   Mon, 22 Nov 2021 12:31:07 +0000
Message-Id: <20211122123107.3147353-1-john@metanate.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other checks of params.g_dma_desc in this file use the
using_desc_dma() helper function.  Use that helper in two more places
for consistency throughout the file.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/dwc2/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index ab8d7dad9f567..b884a83b26a6e 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5217,7 +5217,7 @@ int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg, int remote_wakeup)
 		 * as result BNA interrupt asserted on hibernation exit
 		 * by restoring from saved area.
 		 */
-		if (hsotg->params.g_dma_desc &&
+		if (using_desc_dma(hsotg) &&
 		    (dr->diepctl[i] & DXEPCTL_EPENA))
 			dr->diepdma[i] = hsotg->eps_in[i]->desc_list_dma;
 		dwc2_writel(hsotg, dr->dtxfsiz[i], DPTXFSIZN(i));
@@ -5229,7 +5229,7 @@ int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg, int remote_wakeup)
 		 * as result BNA interrupt asserted on hibernation exit
 		 * by restoring from saved area.
 		 */
-		if (hsotg->params.g_dma_desc &&
+		if (using_desc_dma(hsotg) &&
 		    (dr->doepctl[i] & DXEPCTL_EPENA))
 			dr->doepdma[i] = hsotg->eps_out[i]->desc_list_dma;
 		dwc2_writel(hsotg, dr->doepdma[i], DOEPDMA(i));
-- 
2.34.0

