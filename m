Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3161B3F3B80
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhHUQum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhHUQuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:50:39 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153A5C061757
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:50:00 -0700 (PDT)
Received: from dslb-178-004-175-162.178.004.pools.vodafone-ip.de ([178.4.175.162] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mHUBv-0002Ch-Ee; Sat, 21 Aug 2021 18:49:55 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/10] staging: r8188eu: rewrite usb vendor request defines
Date:   Sat, 21 Aug 2021 18:48:53 +0200
Message-Id: <20210821164859.4351-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210821164859.4351-1-martin@kaiser.cx>
References: <20210821164859.4351-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the numeric values with USB constants to make their
meaning clearer.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/usb_ops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 5d290199e37c..b6a1cd536adf 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -8,8 +8,8 @@
 #include "drv_types.h"
 #include "osdep_intf.h"
 
-#define REALTEK_USB_VENQT_READ		0xC0
-#define REALTEK_USB_VENQT_WRITE		0x40
+#define REALTEK_USB_VENQT_READ		(USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
+#define REALTEK_USB_VENQT_WRITE		(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
 #define REALTEK_USB_VENQT_CMD_REQ	0x05
 #define REALTEK_USB_VENQT_CMD_IDX	0x00
 
-- 
2.20.1

