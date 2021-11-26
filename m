Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249C345EAF9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352956AbhKZKGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:06:08 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:62704 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbhKZKEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:04:07 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1AQ9aCln042552;
        Fri, 26 Nov 2021 17:36:12 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Nov
 2021 18:00:28 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Neal Liu <neal_liu@aspeedtech.com>, Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] usb: uhci: add aspeed ast2600 uhci support
Date:   Fri, 26 Nov 2021 18:00:21 +0800
Message-ID: <20211126100021.2331024-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1AQ9aCln042552
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ast2600 uhci quirks.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/host/uhci-platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 70dbd95c3f06..be9e9db7cad1 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -113,7 +113,8 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 				num_ports);
 		}
 		if (of_device_is_compatible(np, "aspeed,ast2400-uhci") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-uhci")) {
+		    of_device_is_compatible(np, "aspeed,ast2500-uhci") ||
+		    of_device_is_compatible(np, "aspeed,ast2600-uhci")) {
 			uhci->is_aspeed = 1;
 			dev_info(&pdev->dev,
 				 "Enabled Aspeed implementation workarounds\n");
-- 
2.25.1

