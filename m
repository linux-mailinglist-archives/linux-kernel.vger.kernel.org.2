Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4B451A09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352411AbhKOXcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245320AbhKOTUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:20:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDDC26325D;
        Mon, 15 Nov 2021 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637001145;
        bh=oZhXbpmweQro5ewwkKxk0Yd8mk+wgVBiyc+oC8/xaYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCO9/wCdmCoT52bMDpXlq7PDb5+sfM1h540vNtSHMW4+76a65oS0CYkBwHCGFhgt7
         aHcnudjBfrroNix08NtohM0vHNp8le/HJgHHc/EuhRE+Mc9hYjhMUs4YIBigSCuafx
         TpZPXdbW+l4KeZrCOl0lpVAKgEjrUB13dOtwmLHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.15 078/917] ath6kl: fix control-message timeout
Date:   Mon, 15 Nov 2021 17:52:53 +0100
Message-Id: <20211115165431.404335624@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165428.722074685@linuxfoundation.org>
References: <20211115165428.722074685@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit a066d28a7e729f808a3e6eff22e70c003091544e upstream.

USB control-message timeouts are specified in milliseconds and should
specifically not vary with CONFIG_HZ.

Fixes: 241b128b6b69 ("ath6kl: add back beginnings of USB support")
Cc: stable@vger.kernel.org      # 3.4
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20211025120522.6045-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath6kl/usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -912,7 +912,7 @@ static int ath6kl_usb_submit_ctrl_in(str
 				 req,
 				 USB_DIR_IN | USB_TYPE_VENDOR |
 				 USB_RECIP_DEVICE, value, index, buf,
-				 size, 2 * HZ);
+				 size, 2000);
 
 	if (ret < 0) {
 		ath6kl_warn("Failed to read usb control message: %d\n", ret);


