Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D6422A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhJEOJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbhJEOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:09 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95884C08E870;
        Tue,  5 Oct 2021 07:03:31 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HNznt0nwYzQlXv;
        Tue,  5 Oct 2021 16:03:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=Vyb27ZqtjS+tKU7zZ0G+derFOD0cVxMh9MjB5mxAUo8=;
        b=QNQnpkWdCRNqU7B1CNHTZXGNRUiSDmgtEP/yKhjgNc20T+d0RAxL4QsKPY80ZPR4aaCVQM
        MyLjDl3Wzgf7HNI0reqmTs57zqDZZC6idSGLZKNLRjzx7L5TVMemvtVg/KSDGsqp2ktEka
        tGKKwj0fnyh1E3uG771tLRkZvhNlTArZeC9GFAqvUrFpAfIt3ebfcCjsBFgWfc3XFYnb1V
        PLCJORH9jFoqwkYnWFRvyppuPgyR8j3wEjv5cDYhqtIgiSUFGUkq4iMfQctsh0fQ++hQ/E
        0xQD5nm1ceikpcN4qTruefFv91y9Dn8b/a5XQ4Fhyxw+wE8qLKS4yzjjyvvz1w==
X-Mailbox-Line: From 46320ab3bcc30f51da1f1dacf24eeed082690fa2 Mon Sep 17 00:00:00 2001
Message-Id: <46320ab3bcc30f51da1f1dacf24eeed082690fa2.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 14:37:35 +0100
Subject: [PATCH 11/13] usb: core: config: remove unnecessary parentheses
X-Rspamd-Queue-Id: 5E8952A7
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl warnings:

core/config.c:657: CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'header->bLength > size2'
core/config.c:657: CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'header->bLength < 2'

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 76038e8c84c5..ab3395ec4260 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -267,8 +267,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 
 	if (d->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE) {
 		n = USB_DT_ENDPOINT_AUDIO_SIZE;
-	}
-	else if (d->bLength >= USB_DT_ENDPOINT_SIZE) {
+	} else if (d->bLength >= USB_DT_ENDPOINT_SIZE) {
 		n = USB_DT_ENDPOINT_SIZE;
 	} else {
 		dev_warn(ddev,
@@ -655,7 +654,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 		}
 
 		header = (struct usb_descriptor_header *)buffer2;
-		if ((header->bLength > size2) || (header->bLength < 2)) {
+		if (header->bLength > size2 || header->bLength < 2) {
 			dev_warn(ddev,
 				 "config %d has an invalid descriptor of length %d, skipping remainder of the config\n",
 				 cfgno, header->bLength);
-- 
2.32.0

