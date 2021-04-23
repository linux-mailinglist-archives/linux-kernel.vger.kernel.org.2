Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36D369640
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbhDWPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:34:38 -0400
Received: from mail.solidxs.nl ([176.9.52.130]:46040 "EHLO mail.solidxs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242623AbhDWPeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:34:37 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 11:34:37 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.solidxs.nl (Postfix) with ESMTP id 70F7D4C80C46;
        Fri, 23 Apr 2021 17:25:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at solidxs.nl
Received: from mail.solidxs.nl ([127.0.0.1])
        by localhost (mail.solidxs.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ARmYwmx2-_4L; Fri, 23 Apr 2021 17:25:32 +0200 (CEST)
Received: from precision.lan (81-227-11-245-no2212.tbcn.telia.com [81.227.11.245])
        by mail.solidxs.nl (Postfix) with ESMTPA id F0A1D4C80C33;
        Fri, 23 Apr 2021 17:25:31 +0200 (CEST)
From:   Marcel Hamer <marcel@solidxs.se>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Marcel Hamer <marcel@solidxs.se>
Subject: [PATCH] usb: dwc3: gadget: add missing wakeup link states
Date:   Fri, 23 Apr 2021 17:25:24 +0200
Message-Id: <20210423152524.624619-1-marcel@solidxs.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dwc3_send_gadget_ep_cmd() a check is performed if the gadget needs
waking up. The following condition is checked before calling the
__dwc3_gadget_wakeup() function:

	needs_wakeup = (dwc->link_state == DWC3_LINK_STATE_U1 ||
        		dwc->link_state == DWC3_LINK_STATE_U2 ||
                        dwc->link_state == DWC3_LINK_STATE_U3);

Inside __dwc3_gadget_wakeup() only link_state DWC3_LINK_STATE_U3 is checked
and link state DWC3_LINK_STATE_U1 and DWC3_LINK_STATE_U2 are considered
invalid and generate a warning because of the call to:

	dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n", ret);

because of ret being -EINVAL.

Signed-off-by: Marcel Hamer <marcel@solidxs.se>
---
 drivers/usb/dwc3/gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c7ef218e7a8c..d05a7d630410 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1972,6 +1972,8 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	switch (link_state) {
 	case DWC3_LINK_STATE_RESET:
 	case DWC3_LINK_STATE_RX_DET:	/* in HS, means Early Suspend */
+	case DWC3_LINK_STATE_U1:
+	case DWC3_LINK_STATE_U2:
 	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
 	case DWC3_LINK_STATE_RESUME:
 		break;
-- 
2.25.1

