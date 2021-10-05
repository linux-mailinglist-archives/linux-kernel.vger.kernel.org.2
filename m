Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C09422A2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhJEOI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbhJEOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:11 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9F7C08E90E;
        Tue,  5 Oct 2021 07:03:40 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HNznr4bgtzQkhq;
        Tue,  5 Oct 2021 16:03:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=WPntSniBfBJXxI5Bu1inF6s7l6kqvEphqLuLAFznXlk=;
        b=uf5vFbgRylcbHETK1Ct1/UqU5KjigATy5lkAj9HLTB54vt1mx6S8m8Z7kJCDnqG/k/K+QZ
        y69Sf3xyWhoTKgBcvPnw8pySdzoUo4Kgi2hkwVIuTfH2Xb9oMQPnbEyod5F6gFBNdqwUl+
        Rr61nJhbbqixjVE6bRn6EnCOgYqN0z8CJd39dHine5x98Nm5N5sCCD8MQxGzSVsFWgMTnV
        QUQyU+dMeyQeKeqIX7LXacCTfvfv7PSah8JcOjIdAtpganEgT2Dm9qDeaeYAhK/RiH28OP
        g9woj8KRU0Xu537VQ7lnG3BlCh3qwbp4wtBngK/Q3hwpJ8TnQElvkce5Pd//Zg==
X-Mailbox-Line: From 7ccbda3348ab1806edf5c0d91e655b1bcec7f2c1 Mon Sep 17 00:00:00 2001
Message-Id: <7ccbda3348ab1806edf5c0d91e655b1bcec7f2c1.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 14:26:43 +0100
Subject: [PATCH 08/13] usb: core: config: add blank lines after struct def
X-Rspamd-Queue-Id: E7D7426C
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl warning at multiple locations:

CHECK:LINE_SPACING: Please use a blank line after function/struct/union/enum declarations

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index af88cfe52e92..3bf04fdf850a 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -176,12 +176,14 @@ static const unsigned short low_speed_maxpacket_maxes[4] = {
 	[USB_ENDPOINT_XFER_BULK] = 0,
 	[USB_ENDPOINT_XFER_INT] = 8,
 };
+
 static const unsigned short full_speed_maxpacket_maxes[4] = {
 	[USB_ENDPOINT_XFER_CONTROL] = 64,
 	[USB_ENDPOINT_XFER_ISOC] = 1023,
 	[USB_ENDPOINT_XFER_BULK] = 64,
 	[USB_ENDPOINT_XFER_INT] = 64,
 };
+
 static const unsigned short high_speed_maxpacket_maxes[4] = {
 	[USB_ENDPOINT_XFER_CONTROL] = 64,
 	[USB_ENDPOINT_XFER_ISOC] = 1024,
@@ -190,6 +192,7 @@ static const unsigned short high_speed_maxpacket_maxes[4] = {
 	[USB_ENDPOINT_XFER_BULK] = 1024,
 	[USB_ENDPOINT_XFER_INT] = 1024,
 };
+
 static const unsigned short super_speed_maxpacket_maxes[4] = {
 	[USB_ENDPOINT_XFER_CONTROL] = 512,
 	[USB_ENDPOINT_XFER_ISOC] = 1024,
-- 
2.32.0

