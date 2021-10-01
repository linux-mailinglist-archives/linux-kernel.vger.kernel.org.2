Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC51D41F0F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354985AbhJAPPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354983AbhJAPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:15:41 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F24C06177D;
        Fri,  1 Oct 2021 08:13:56 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HLYXx46ylzQkjm;
        Fri,  1 Oct 2021 17:13:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633101231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=vsWwbtCbjdsDyMAyF/8tuO6kRl7i+bdAs8rqqkL+1GM=;
        b=Cm4fBYYTO63NOxhhcNJNOEsU3rzGSNEd5Che9Z1eqBHjQi4sAVou+XBGHKs3kIWMEs2pQ2
        WZvADkYUrrecCmp8tEGhXg7ZywXkkcuGbfR2bt5B5T1XjdP/KzaEabrYvUMFlmgOqJMYY2
        dIhR/rzQuQd4xXZv6/PPSYm56eQJAbUWL37UGsQd8+iiAFpPB9FDtn+qfe7YHUrgluLtuZ
        O1B5KQ7SNxpHokjM264oOI2v5iLKrIX1UBtSyNFqtptSEVDMLsLPo3FcDuMeFuVYItPyk9
        +OWaGUUcSYxOOqrXyfTk57uHe6b6qlmBYo9wRBVXZzTsBuSzGTaXUhcJpN2Llg==
Date:   Fri, 1 Oct 2021 16:13:50 +0100
From:   Robert Greener <rob@robgreener.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: config: Change sizeof(struct ...) to sizeof(*...)
Message-ID: <20211001151350.ijiexr3ebwvypmdd@shortbread>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: BFF1126D
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl warnings:

drivers/usb/core/config.c:989: CHECK:ALLOC_SIZEOF_STRUCT: Prefer kzalloc(sizeof(*bos)...) over kzalloc(sizeof(struct usb_bos_descriptor)...)
drivers/usb/core/config.c:1010: CHECK:ALLOC_SIZEOF_STRUCT: Prefer kzalloc(sizeof(*dev->bos)...) over kzalloc(sizeof(struct usb_host_bos)...)

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index b199eb65f..16b1fd9dc 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -986,7 +986,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 	__u8 cap_type;
 	int ret;
 
-	bos = kzalloc(sizeof(struct usb_bos_descriptor), GFP_KERNEL);
+	bos = kzalloc(sizeof(*bos), GFP_KERNEL);
 	if (!bos)
 		return -ENOMEM;
 
@@ -1007,7 +1007,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 	if (total_len < length)
 		return -EINVAL;
 
-	dev->bos = kzalloc(sizeof(struct usb_host_bos), GFP_KERNEL);
+	dev->bos = kzalloc(sizeof(*dev->bos), GFP_KERNEL);
 	if (!dev->bos)
 		return -ENOMEM;
 
-- 
2.32.0

