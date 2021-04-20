Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C8365B34
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhDTOdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:33:19 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:17541 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhDTOdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:33:17 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d56 with ME
        id v2Yj2400321Fzsu032Yj4E; Tue, 20 Apr 2021 16:32:44 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Apr 2021 16:32:44 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH resend] xhci: Do not use GFP_KERNEL in (potentially) atomic context
Date:   Tue, 20 Apr 2021 14:32:23 +0200
Message-Id: <f30e8c94707b0e3a257f4c628a1b5d7744898109.1618921790.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'xhci_urb_enqueue()' is passed a 'mem_flags' argument, because "URBs may be
submitted in interrupt context" (see comment related to 'usb_submit_urb()'
in 'drivers/usb/core/urb.c')

So this flag should be used in all the calling chain.
Up to now, 'xhci_check_maxpacket()' which is only called from
'xhci_urb_enqueue()', uses GFP_KERNEL.

Be safe and pass the mem_flags to this function as well.

Fixes: ddba5cd0aeff ("xhci: Use command structures when queuing commands on the command ring")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I'm not 100% sure of the Fixes tag. The commit is the only that introduced
this GFP_KERNEL, but I've not checked what was the behavior before that.

If the patch is correct, I guess that a cc stable should be welcome.

This patch was proposed on 14/08/20. It has been rebased on latest -next tree.
---
 drivers/usb/host/xhci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index ca9385d22f68..27283654ca08 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1514,7 +1514,7 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
  * we need to issue an evaluate context command and wait on it.
  */
 static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
-		unsigned int ep_index, struct urb *urb)
+		unsigned int ep_index, struct urb *urb, gfp_t mem_flags)
 {
 	struct xhci_container_ctx *out_ctx;
 	struct xhci_input_control_ctx *ctrl_ctx;
@@ -1545,7 +1545,7 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
 		 * changes max packet sizes.
 		 */
 
-		command = xhci_alloc_command(xhci, true, GFP_KERNEL);
+		command = xhci_alloc_command(xhci, true, mem_flags);
 		if (!command)
 			return -ENOMEM;
 
@@ -1639,7 +1639,7 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		 */
 		if (urb->dev->speed == USB_SPEED_FULL) {
 			ret = xhci_check_maxpacket(xhci, slot_id,
-					ep_index, urb);
+					ep_index, urb, mem_flags);
 			if (ret < 0) {
 				xhci_urb_free_priv(urb_priv);
 				urb->hcpriv = NULL;
-- 
2.27.0

