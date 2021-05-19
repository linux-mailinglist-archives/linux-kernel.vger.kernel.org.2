Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A331F388ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbhESJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345520AbhESJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:34:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9195F613AC;
        Wed, 19 May 2021 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416801;
        bh=+z50DH6y5nk22AVu8oFQ8KsCNGoWbe85hVbd+LyXB+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODb6tP/t7Jvc+menfbfq/p4DYqo40r51CsJNcBJ69RnTNqxtwCwCwuJyjR9wi8oJG
         qW70w+CllhxvyE4HAIY2eXjfKQO+0KN+cxA+Xh/rxzmsOF5gZfaVvsq31tbrdu/8rC
         37J/CkLHboPMawkf9I9yizwweaoWcW8tprgecgJtY5V61tRjQjozCNvgg7oICevox5
         7vTfiHW75cZDYMu1NJ31M1YGvpXn6NHh6tm3/oPjbjC+SJZsmf3mXLSmJMVvMyoU3K
         6njG3XPkZqV2aF1XenkxkQ0REyEh69TxH2SB75jYdwQCG+DdaCqVaF8r1oTA7I7GVT
         6UGHuxJYpT4zw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljIZt-0002pU-0t; Wed, 19 May 2021 11:33:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>
Subject: [PATCH 2/3] USB: dwc2: drop irq-flags initialisations
Date:   Wed, 19 May 2021 11:33:02 +0200
Message-Id: <20210519093303.10789-3-johan@kernel.org>
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

While at it drop two redundant return-value initialisations from two of
the functions that got it wrong.

Cc: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/dwc2/gadget.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 184964174dc0..b16fb3611a86 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1496,8 +1496,8 @@ static int dwc2_hsotg_ep_queue_lock(struct usb_ep *ep, struct usb_request *req,
 {
 	struct dwc2_hsotg_ep *hs_ep = our_ep(ep);
 	struct dwc2_hsotg *hs = hs_ep->parent;
-	unsigned long flags = 0;
-	int ret = 0;
+	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&hs->lock, flags);
 	ret = dwc2_hsotg_ep_queue(ep, req, gfp_flags);
@@ -4374,8 +4374,8 @@ static int dwc2_hsotg_ep_sethalt_lock(struct usb_ep *ep, int value)
 {
 	struct dwc2_hsotg_ep *hs_ep = our_ep(ep);
 	struct dwc2_hsotg *hs = hs_ep->parent;
-	unsigned long flags = 0;
-	int ret = 0;
+	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&hs->lock, flags);
 	ret = dwc2_hsotg_ep_sethalt(ep, value, false);
@@ -4505,7 +4505,7 @@ static int dwc2_hsotg_udc_start(struct usb_gadget *gadget,
 static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 {
 	struct dwc2_hsotg *hsotg = to_hsotg(gadget);
-	unsigned long flags = 0;
+	unsigned long flags;
 	int ep;
 
 	if (!hsotg)
@@ -4577,7 +4577,7 @@ static int dwc2_hsotg_set_selfpowered(struct usb_gadget *gadget,
 static int dwc2_hsotg_pullup(struct usb_gadget *gadget, int is_on)
 {
 	struct dwc2_hsotg *hsotg = to_hsotg(gadget);
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	dev_dbg(hsotg->dev, "%s: is_on: %d op_state: %d\n", __func__, is_on,
 		hsotg->op_state);
-- 
2.26.3

