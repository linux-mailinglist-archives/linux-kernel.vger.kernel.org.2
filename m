Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD48422A16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhJEOIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhJEOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:09 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8AC08E869;
        Tue,  5 Oct 2021 07:03:25 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4HNznm3BC4zQkJH;
        Tue,  5 Oct 2021 16:03:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=W9q0yh9C4+f0hhYGXD2Uh2ACE2H49tKjSCovdaIxFos=;
        b=QvSNHBRDu9x1PgSNakfLRM/XYuWBKFDmajZEmT1qLscUEcofGk2PRphmBRDhJWAveqpHin
        4Mo5qnCnePGAmqEv0vprQ42Bfg8Q1Jm+3507Nr80VZ+sl5C+pBSl8CfWcHUljgj5rTqSNE
        Og+0VDJkBUwIb7EbbXvDyovxhjwAAMTpa6jf50NQxPRT6y/AYMtNqRyDl0YR+LiFRp5kJB
        dnp+c9lNwm1Q0+muPoHhsMWvbGqI29RF9qN0rwD62482HRoYXGx9L84O/a1PEl5urnlIAm
        LEmRNj30SNhekn5/wq8h/ctzlIkhDFO923nFyxAyfJOuraRRs9nvFXlTwaXoSQ==
X-Mailbox-Line: From c818d250f53a97577f01aae2ae051092d098fe74 Mon Sep 17 00:00:00 2001
Message-Id: <c818d250f53a97577f01aae2ae051092d098fe74.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 13:41:27 +0100
Subject: [PATCH 05/13] usb: core: config: Fix typo in dev_warn
X-Rspamd-Queue-Id: B64B6274
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl error:

core/config.c:66: WARNING:MISSING_SPACE: break quoted strings at a space character

This fix solvers inserts a space between companion and for, where
there is not one currently.

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index f6c90214bba0..c7451081b08b 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -62,7 +62,7 @@ static void usb_parse_ssp_isoc_endpoint_companion(struct device *ddev,
 	desc = (struct usb_ssp_isoc_ep_comp_descriptor *) buffer;
 	if (desc->bDescriptorType != USB_DT_SSP_ISOC_ENDPOINT_COMP ||
 	    size < USB_DT_SSP_ISOC_EP_COMP_SIZE) {
-		dev_warn(ddev, "Invalid SuperSpeedPlus isoc endpoint companion"
+		dev_warn(ddev, "Invalid SuperSpeedPlus isoc endpoint companion "
 			 "for config %d interface %d altsetting %d ep %d.\n",
 			 cfgno, inum, asnum, ep->desc.bEndpointAddress);
 		return;
-- 
2.32.0

