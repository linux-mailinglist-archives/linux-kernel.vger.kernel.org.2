Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B3E422A29
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhJEOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbhJEOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:11 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AABAC08EA40;
        Tue,  5 Oct 2021 07:03:43 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HNznp3chKzQkhP;
        Tue,  5 Oct 2021 16:03:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=FjhFDSUGW84ijFVsp75XszYo7omZ7fAAJfvDmYT0TrY=;
        b=ZtEC+IyPjitXcMx3oBuEtSjC1lVaSKGkadE+qQFTF8oTuOmJctM+9uOt5DVaMlFfJOVW37
        uvFAgJ0E0LvwE28pFNdZHAR/2l98BgbqkgksgFi0Cx+49dN5XlXBrI2eszq6WLxcjamlK2
        oT57zlo2VsT3lcHxZ7JBChSpg9Bo8ssq4rpzBlIsXp2qLQKFBIRY72nTUqGrqy6gcZtEe9
        xagMeARqE44+5R4id41ONWWGvJqRcmPZNzU9u4wZcuyzP78/mGFYvRGcdFt2E2t6A8kYkc
        /kg/3tDzYnMPKmKw036tHqWuj+0mrk8IioddTx6m/+qO3QA3Pw8sH6+nSkogsg==
X-Mailbox-Line: From 3d00fef299d94804b5719e36f398e42deb760bc9 Mon Sep 17 00:00:00 2001
Message-Id: <3d00fef299d94804b5719e36f398e42deb760bc9.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 14:25:33 +0100
Subject: [PATCH 07/13] usb: core: config: remove unnecessary blank lines
X-Rspamd-Queue-Id: A03EF274
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning at multiple
locations:

CHECK:LINE_SPACING: Please don't use multiple blank lines

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 51c590da7651..af88cfe52e92 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -13,12 +13,10 @@
 #include <asm/byteorder.h>
 #include "usb.h"
 
-
 #define USB_MAXALTSETTING		128	/* Hard limit */
 
 #define USB_MAXCONFIG			8	/* Arbitrary limit */
 
-
 static inline const char *plural(int n)
 {
 	return (n == 1 ? "" : "s");
@@ -848,7 +846,6 @@ void usb_destroy_configuration(struct usb_device *dev)
 	dev->config = NULL;
 }
 
-
 /*
  * Get the USB config descriptors, cache and parse'em
  *
-- 
2.32.0

