Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1167377352
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 19:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhEHRFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 13:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhEHRFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 13:05:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C13C06175F;
        Sat,  8 May 2021 10:04:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id j12so3713845pgh.7;
        Sat, 08 May 2021 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=blMp1g0RFxSJmjV33e/VxP44v2nWe4MjcBjFmy9TpQM=;
        b=dM6Z7TwMEQdfjeP3eCuzzOhLc5ZWi4A0eSN4segc5kiuuGi93kzDQODUEuCaoK6i65
         /k0kxum5BpgTPnc37jEBsyfQf22bpC7ycCPXHBKA43XFjYvlkjaA6YzL/dvT2ehhltk7
         WTI5FXsAAT6FNQytqlzstgTSAC/9DG7RoFkmTTmIMjw2O+01/uh23mBNmQ3w6KRcooQS
         1aIkPv0WIKk+1Bf5HJbvZrzAlFKkdCLPVJvbVMzQmJqjQ2F7PCdNiA2caLEW8xuRgjm2
         2XJOR32829TbHdSymd5OOhNzgXMz+JgG/uOxS189MeFOmdWYDnKOiHA03u/kwLnrtXA6
         iywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=blMp1g0RFxSJmjV33e/VxP44v2nWe4MjcBjFmy9TpQM=;
        b=iQEF0YmhXb5Zomrt2pvSxXCE6jGtVym7qk/MBbxUQFa+tuKjq1k1oMDiSISqJJ1Pdk
         REruJxej5cTLY4ZC9k8wZU/Mdwdb9rU/8tiTDUqqy6VFwDHEFgpyLTu0ZQjeEm5ynjsI
         x7mY+IjVGoGlWwrE4ZC1xx+jZqWC5JfA/qP/kwfc6aHfh5L7+T2AnxpPbo7SHter1Q8F
         s+egKujwdn0ILIGFUjEMJ8OyCrMRPi/xLhonoZdL+weBKbOpuwo57tv9k02m/me5swtY
         fQZbKt5qCgiHnQSeRZQ3J+4QosbV8kwH4+/DMQCP7qUhcLv2mgB7tqvrp3kzuyl4bMRW
         BxRQ==
X-Gm-Message-State: AOAM530rPXly3AFf0+TcUTP2f0q0m8E8n0wF8Q8UCHlkFRpL+Zkrwwe8
        NSxwKRqKF+4NuqwMizMskr8=
X-Google-Smtp-Source: ABdhPJwXE2lFG6IUuXAo50GvlRQtLkSQs9scvovlpo2i3GL5VCkXNB3jZGjN/oMIGMIDS8EI90mmgQ==
X-Received: by 2002:a65:4286:: with SMTP id j6mr16569700pgp.261.1620493440050;
        Sat, 08 May 2021 10:04:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:4490:4409:357e:ddc0:965d:2b13:8892])
        by smtp.gmail.com with ESMTPSA id g190sm1674468pfb.60.2021.05.08.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 10:03:59 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>
Subject: [PATCH 1/2] usb: musb: Remove unused local variable dma, urb, offset
Date:   Sat,  8 May 2021 22:33:16 +0530
Message-Id: <20210508170317.24403-2-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210508170317.24403-1-saurav.girepunje@gmail.com>
References: <20210508170317.24403-1-saurav.girepunje@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function argument struct dma_controller *dma,
struct urb *urb and u32 offset from musb_tx_dma_set_mode_mentor.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/usb/musb/musb_host.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 8b7d22a0c0fb..14d9b366e605 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -563,10 +563,9 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, u8 epnum)
 	ep->rx_reinit = 0;
 }
 
-static void musb_tx_dma_set_mode_mentor(struct dma_controller *dma,
-		struct musb_hw_ep *hw_ep, struct musb_qh *qh,
-		struct urb *urb, u32 offset,
-		u32 *length, u8 *mode)
+static void musb_tx_dma_set_mode_mentor(struct musb_hw_ep *hw_ep, 
+					struct musb_qh *qh,
+					u32 *length, u8 *mode)
 {
 	struct dma_channel	*channel = hw_ep->tx_channel;
 	void __iomem		*epio = hw_ep->regs;
@@ -630,7 +629,7 @@ static bool musb_tx_dma_program(struct dma_controller *dma,
 	u8			mode;
 
 	if (musb_dma_inventra(hw_ep->musb) || musb_dma_ux500(hw_ep->musb))
-		musb_tx_dma_set_mode_mentor(dma, hw_ep, qh, urb, offset,
+		musb_tx_dma_set_mode_mentor(hw_ep, qh,
 					    &length, &mode);
 	else if (is_cppi_enabled(hw_ep->musb) || tusb_dma_omap(hw_ep->musb))
 		musb_tx_dma_set_mode_cppi_tusb(dma, hw_ep, qh, urb, offset,
-- 
2.25.1

