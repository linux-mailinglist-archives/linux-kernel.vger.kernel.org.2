Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095203572A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354537AbhDGRGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhDGRGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:06:03 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6FC06175F;
        Wed,  7 Apr 2021 10:05:53 -0700 (PDT)
Received: from ipservice-092-217-079-185.092.217.pools.vodafone-ip.de ([92.217.79.185] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUBcj-0001Q6-N0; Wed, 07 Apr 2021 19:05:49 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 02/10] staging: rtl8188eu: remove unnecessary brackets
Date:   Wed,  7 Apr 2021 19:05:23 +0200
Message-Id: <20210407170531.29356-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407170531.29356-1-martin@kaiser.cx>
References: <20210407170531.29356-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ESHUTDOWN is just a number, it needs no brackets.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 8e9fd9d4afda..74f34440fc8c 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -267,7 +267,7 @@ usbctrl_vendorreq(struct adapter *adapt, u16 value, void *pdata, u16 len, u8 req
 				len, status, *(u32 *)pdata, vendorreq_times);
 
 			if (status < 0) {
-				if (status == (-ESHUTDOWN) || status == -ENODEV)
+				if (status == -ESHUTDOWN || status == -ENODEV)
 					adapt->bSurpriseRemoved = true;
 				else
 					adapt->HalData->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
-- 
2.20.1

