Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEB5388AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbhESJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345530AbhESJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:34:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9441F613BA;
        Wed, 19 May 2021 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416801;
        bh=w0kH4aEv0kclW6uE2UePjrSnaKIliZMimvw9Tin9myo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGTXN3gCzzjxlfX1yt4cyWNue2oBy5pZLJun6le07y1rPqG6cONuuzrK6nugDZi+3
         /jQ1ToWbqFkeWDTzPCUH0LHE/u+ucDqitBJ0yNVeio2xbwMAT36w8oOI0L9Vk8ERjI
         3K8gcx9EdWMDPqLiu6RAjtiwop/jbh3763iIf7b61ivgs0rrcVMhYCu5VvQI08X4rq
         kGAASzwQI5FG94YsDZQ/idAaqRBuT9N+2O4dfGpvwan8IBlEDCW2J5Ce2PqNOEieCU
         pdBJJB8W/jU2u788+MpKthddSMOd6KQLRyC5eqG5tkBlGUex61uVjRTuq/P5hC9DOh
         rjIg5XDNV+0BQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljIZt-0002pX-3M; Wed, 19 May 2021 11:33:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 3/3] USB: gadget: drop irq-flags initialisations
Date:   Wed, 19 May 2021 11:33:03 +0200
Message-Id: <20210519093303.10789-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210519093303.10789-1-johan@kernel.org>
References: <20210519093303.10789-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to initialise irq-flags variables before saving the
interrupt state.

Drop the redundant initialisations from drivers that got this wrong.

Cc: Li Yang <leoyang.li@nxp.com>
Cc: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 8 ++++----
 drivers/usb/gadget/udc/mv_u3d_core.c  | 2 +-
 drivers/usb/gadget/udc/mv_udc_core.c  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index ad6ff9c4188e..2b357b3f64c0 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -547,7 +547,7 @@ static int fsl_ep_enable(struct usb_ep *_ep,
 	unsigned short max = 0;
 	unsigned char mult = 0, zlt;
 	int retval = -EINVAL;
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	ep = container_of(_ep, struct fsl_ep, ep);
 
@@ -631,7 +631,7 @@ static int fsl_ep_disable(struct usb_ep *_ep)
 {
 	struct fsl_udc *udc = NULL;
 	struct fsl_ep *ep = NULL;
-	unsigned long flags = 0;
+	unsigned long flags;
 	u32 epctrl;
 	int ep_num;
 
@@ -1001,7 +1001,7 @@ out:	epctrl = fsl_readl(&dr_regs->endptctrl[ep_num]);
 static int fsl_ep_set_halt(struct usb_ep *_ep, int value)
 {
 	struct fsl_ep *ep = NULL;
-	unsigned long flags = 0;
+	unsigned long flags;
 	int status = -EOPNOTSUPP;	/* operation not supported */
 	unsigned char ep_dir = 0, ep_num = 0;
 	struct fsl_udc *udc = NULL;
@@ -1938,7 +1938,7 @@ static int fsl_udc_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
 	int retval = 0;
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	/* lock is needed but whether should use this lock or another */
 	spin_lock_irqsave(&udc_controller->lock, flags);
diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index 5486f5a70868..ce3d7a3eb7e3 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -941,7 +941,7 @@ mv_u3d_ep_set_stall(struct mv_u3d *u3d, u8 ep_num, u8 direction, int stall)
 static int mv_u3d_ep_set_halt_wedge(struct usb_ep *_ep, int halt, int wedge)
 {
 	struct mv_u3d_ep *ep;
-	unsigned long flags = 0;
+	unsigned long flags;
 	int status = 0;
 	struct mv_u3d *u3d;
 
diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index 0fb4ef464321..7f24ce400b59 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -888,7 +888,7 @@ static int ep_is_stall(struct mv_udc *udc, u8 ep_num, u8 direction)
 static int mv_ep_set_halt_wedge(struct usb_ep *_ep, int halt, int wedge)
 {
 	struct mv_ep *ep;
-	unsigned long flags = 0;
+	unsigned long flags;
 	int status = 0;
 	struct mv_udc *udc;
 
-- 
2.26.3

