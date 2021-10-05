Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257F0422A2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhJEOJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhJEOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:12 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2FAC0613B0;
        Tue,  5 Oct 2021 07:03:43 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HNznk4WbqzQkBV;
        Tue,  5 Oct 2021 16:03:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:in-reply-to:in-reply-to:references:references;
        bh=qp8W3CHdssybII7b16zFOx2u+1MbGZ2xtIgnn5PDyIQ=;
        b=c9zAaSkCskfg6+CWV+LmSPsZMsNkw7kNaqCAJNYzBQmzhq5jqEbW+amrCD51Ko1EPCq2DA
        pRX1QFsUlOoZyJuAZiv/0r6Psjl3QMiyeoxg0H1THKzpZ6oHi9rSoDlGafXb7MGWZu9OiM
        i/ejoh2mRKxxua+oh3oLrVqgIQobL+ua6gB7oEAolEWVq3ZN7/ITPGAC4Nxub1OVyfEfTR
        c7RKVYwkDTl8XhPXnAeEQ2dhLZrvt20ERvw21Bmmn56gUJixH4AMEmHUvbGeWn8OOCy3BC
        XhZbqYmnaLMveakA4dEKRmIwzBqqBK3M9FqKDAU19qQfyTWfTg05T5niccrslA==
X-Mailbox-Line: From 89e7ed8527882bef87734af998b83b4f4912b790 Mon Sep 17 00:00:00 2001
Message-Id: <89e7ed8527882bef87734af998b83b4f4912b790.1633442131.git.rob@robgreener.com>
In-Reply-To: <cover.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 13:35:33 +0100
Subject: [PATCH 03/13] usb: core: config: Change `unsigned` to `unsigned int`
X-Rspamd-Queue-Id: DDEEA5C1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:

core/config.c:622: WARNING:UNSPECIFIED_INT: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Robert Greener <rob@robgreener.com>
---
 drivers/usb/core/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 52aab1462787..5de26d64a00b 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -619,7 +619,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	struct usb_descriptor_header *header;
 	int retval;
 	u8 inums[USB_MAXINTERFACES], nalts[USB_MAXINTERFACES];
-	unsigned iad_num = 0;
+	unsigned int iad_num = 0;
 
 	memcpy(&config->desc, buffer, USB_DT_CONFIG_SIZE);
 	nintf = nintf_orig = config->desc.bNumInterfaces;
-- 
2.32.0

