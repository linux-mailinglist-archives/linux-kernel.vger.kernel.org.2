Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14420422A2A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbhJEOIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbhJEOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:11 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A4CC08E90F;
        Tue,  5 Oct 2021 07:03:43 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HNzns1ZgYzQk3d;
        Tue,  5 Oct 2021 16:03:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=UVWMT03HEQyFx2aXE/nLl7IrocPT7phhra9kOwhx2ak=;
        b=v3eGTvXkTX+iQy7r/mNMr6/kvRq9ASiM1Glmn7VAvDFtZ3oDLjewQA8v8SzCT79Y8dPmEc
        ZsN9kS0UuP0BlM6BSoSbkmcehGa1dsBRMvQGB1bHCzcw7/epsl3G4RRqdBR3Fi9Qe2P4pE
        E8CK4HmbqhN1FiF0jKPBVizOnnMvwncDiy8Z9KJ8l1QkJrN8ubDsXESk3TmJO8SuLeUBD0
        6vbOx7/u18mvc9x2e1aBroMcpdaDo2X107gR+2qq/MoiSJ106rIbTdQNOcNnThyd3IUpPV
        gTtSc6bEVPebAmsNzw+BPb9JZg+Ygd+4/9DlAsXyibaz8EgCGOW3GeZ9dgO7qw==
X-Mailbox-Line: From 9fb688c9a39a9114a6137361dc4a143d7a198822 Mon Sep 17 00:00:00 2001
Message-Id: <9fb688c9a39a9114a6137361dc4a143d7a198822.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 14:34:03 +0100
Subject: [PATCH 10/13] usb: core: config: fix checkpatch.pl braces warning
X-Rspamd-Queue-Id: 7D869271
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl warnings:

core/config.c:268: CHECK:BRACES: braces {} should be used on all arms of this statement
core/config.c:272: CHECK:BRACES: Unbalanced braces around else statement
core/config.c:649: CHECK:BRACES: Blank lines aren't necessary after an open brace '{'

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 9717f89bcb6f..76038e8c84c5 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -265,11 +265,12 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	buffer += d->bLength;
 	size -= d->bLength;
 
-	if (d->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE)
+	if (d->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE) {
 		n = USB_DT_ENDPOINT_AUDIO_SIZE;
-	else if (d->bLength >= USB_DT_ENDPOINT_SIZE)
+	}
+	else if (d->bLength >= USB_DT_ENDPOINT_SIZE) {
 		n = USB_DT_ENDPOINT_SIZE;
-	else {
+	} else {
 		dev_warn(ddev,
 			 "config %d interface %d altsetting %d has an invalid endpoint descriptor of length %d, skipping\n",
 			 cfgno, inum, asnum, d->bLength);
@@ -646,7 +647,6 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	for ((buffer2 = buffer, size2 = size);
 	      size2 > 0;
 	     (buffer2 += header->bLength, size2 -= header->bLength)) {
-
 		if (size2 < sizeof(struct usb_descriptor_header)) {
 			dev_warn(ddev,
 				 "config %d descriptor has %d excess byte%s, ignoring\n",
-- 
2.32.0

