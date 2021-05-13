Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A48E37F1E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 06:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhEMEQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 00:16:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49208 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhEMEQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 00:16:15 -0400
Received: from 111-240-128-202.dynamic-ip.hinet.net ([111.240.128.202] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lh2kY-000084-GC; Thu, 13 May 2021 04:15:03 +0000
From:   chris.chiu@canonical.com
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        m.v.b@runbox.com, hadess@hadess.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v3 2/2] Revert "USB: Add reset-resume quirk for WD19's Realtek Hub"
Date:   Thu, 13 May 2021 12:14:46 +0800
Message-Id: <20210513041446.3082-3-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20210513041446.3082-1-chris.chiu@canonical.com>
References: <20210513041446.3082-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

This reverts commit ca91fd8c7643d93bfc18a6fec1a0d3972a46a18a. The
problematic hub should be taken care for each setting PORT_SUSPEND
feature timeout instead of reset-resume all the time.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 drivers/usb/core/quirks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 21e7522655ac..6114cf83bb44 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -406,7 +406,6 @@ static const struct usb_device_id usb_quirk_list[] = {
 
 	/* Realtek hub in Dell WD19 (Type-C) */
 	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
-	{ USB_DEVICE(0x0bda, 0x5487), .driver_info = USB_QUIRK_RESET_RESUME },
 
 	/* Generic RTL8153 based ethernet adapters */
 	{ USB_DEVICE(0x0bda, 0x8153), .driver_info = USB_QUIRK_NO_LPM },
-- 
2.20.1

