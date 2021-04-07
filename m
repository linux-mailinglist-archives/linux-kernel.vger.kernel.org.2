Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C503572A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354548AbhDGRGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhDGRGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:06:08 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB211C06175F;
        Wed,  7 Apr 2021 10:05:58 -0700 (PDT)
Received: from ipservice-092-217-079-185.092.217.pools.vodafone-ip.de ([92.217.79.185] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUBco-0001Q6-2f; Wed, 07 Apr 2021 19:05:54 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/10] staging: rtl8188eu: remove unused defines
Date:   Wed,  7 Apr 2021 19:05:24 +0200
Message-Id: <20210407170531.29356-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407170531.29356-1-martin@kaiser.cx>
References: <20210407170531.29356-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some defines in usb_ops_linux.h are not used by the rtl8188eu driver.
Remove them.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/usb_ops_linux.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/usb_ops_linux.h b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
index 1a0b38de5027..36a53239d5df 100644
--- a/drivers/staging/rtl8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
@@ -7,15 +7,10 @@
 #ifndef __USB_OPS_LINUX_H__
 #define __USB_OPS_LINUX_H__
 
-#define VENDOR_CMD_MAX_DATA_LEN	254
-
-#define RTW_USB_CONTROL_MSG_TIMEOUT_TEST	10/* ms */
 #define RTW_USB_CONTROL_MSG_TIMEOUT	500/* ms */
 
 #define MAX_USBCTRL_VENDORREQ_TIMES	10
 
-#define RTW_USB_BULKOUT_TIME	5000/* ms */
-
 #define ALIGNMENT_UNIT			16
 #define MAX_VENDOR_REQ_CMD_SIZE	254	/* 8188cu SIE Support */
 #define MAX_USB_IO_CTL_SIZE	(MAX_VENDOR_REQ_CMD_SIZE + ALIGNMENT_UNIT)
-- 
2.20.1

