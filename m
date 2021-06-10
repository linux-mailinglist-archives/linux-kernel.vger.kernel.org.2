Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC63A27A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFJJEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:04:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54614 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhFJJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:04:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E798821A5B;
        Thu, 10 Jun 2021 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623315768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gkJjXqyMqyjcHscw9ww+z/qYTfMQYB5/wvgbnThR8I=;
        b=we57jbu5Nzk/9CUpTM1+oXKtnkuo8z7FXenfZaDJ/8gcFMuIgDwFerb3gwcd8hWQZAgDD1
        wMJINGUH4gozNeKrChOSB5Gy5Y7iWbgpoZb8KTeMLzB+TFWQGfzuSYdTlz1xh/+hsRTxF7
        E+LYm8CxbP1hR/aseiBsYU8IsIPmY4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623315768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gkJjXqyMqyjcHscw9ww+z/qYTfMQYB5/wvgbnThR8I=;
        b=CiKNijeL8PyiSXHh9lpiPWsH1TbjZxPIN26xMJJD24oi4CautDaSV7OGISFSWi9sSe8KCC
        jyEBR9bJDJAagBAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C07EFA3B8C;
        Thu, 10 Jun 2021 09:02:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v3 3/4] cypress_m8: switch data_bits to real character bits
Date:   Thu, 10 Jun 2021 11:02:46 +0200
Message-Id: <20210610090247.2593-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610090247.2593-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210610090247.2593-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make data_bits what it really is. Assign proper bit counts to data_bits
instead of magic 0..3. There are two reasons:
1) it's clear what we store there, and
2) it will make the transition to tty_tty_get_char_size() in the next
   patch easier.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/usb/serial/cypress_m8.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 1dca04e1519d..ad8ed5361677 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -326,7 +326,7 @@ static int cypress_serial_control(struct tty_struct *tty,
 
 		/* fill the feature_buffer with new configuration */
 		put_unaligned_le32(new_baudrate, feature_buffer);
-		feature_buffer[4] |= data_bits;   /* assign data bits in 2 bit space ( max 3 ) */
+		feature_buffer[4] |= data_bits - 5;   /* assign data bits in 2 bit space ( max 3 ) */
 		/* 1 bit gap */
 		feature_buffer[4] |= (stop_bits << 3);   /* assign stop bits in 1 bit space */
 		feature_buffer[4] |= (parity_enable << 4);   /* assign parity flag in 1 bit space */
@@ -889,20 +889,20 @@ static void cypress_set_termios(struct tty_struct *tty,
 
 	switch (cflag & CSIZE) {
 	case CS5:
-		data_bits = 0;
+		data_bits = 5;
 		break;
 	case CS6:
-		data_bits = 1;
+		data_bits = 6;
 		break;
 	case CS7:
-		data_bits = 2;
+		data_bits = 7;
 		break;
 	case CS8:
-		data_bits = 3;
+		data_bits = 8;
 		break;
 	default:
 		dev_err(dev, "%s - CSIZE was set, but not CS5-CS8\n", __func__);
-		data_bits = 3;
+		data_bits = 8;
 	}
 	spin_lock_irqsave(&priv->lock, flags);
 	oldlines = priv->line_control;
-- 
2.32.0

