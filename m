Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158AF33705F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhCKKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:44:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53961 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhCKKor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:44:47 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lKIo9-0007xc-6u; Thu, 11 Mar 2021 10:44:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usbip: Fix incorrect double assignment to udc->ud.tcp_rx
Date:   Thu, 11 Mar 2021 10:44:45 +0000
Message-Id: <20210311104445.7811-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently udc->ud.tcp_rx is being assigned twice, the second assignment
is incorrect, it should be to udc->ud.tcp_tx instead of rx. Fix this.

Addresses-Coverity: ("Unused value")
Fixes: 46613c9dfa96 ("usbip: fix vudc usbip_sockfd_store races leading to gpf")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/usbip/vudc_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
index a3ec39fc6177..7383a543c6d1 100644
--- a/drivers/usb/usbip/vudc_sysfs.c
+++ b/drivers/usb/usbip/vudc_sysfs.c
@@ -174,7 +174,7 @@ static ssize_t usbip_sockfd_store(struct device *dev,
 
 		udc->ud.tcp_socket = socket;
 		udc->ud.tcp_rx = tcp_rx;
-		udc->ud.tcp_rx = tcp_tx;
+		udc->ud.tcp_tx = tcp_tx;
 		udc->ud.status = SDEV_ST_USED;
 
 		spin_unlock_irq(&udc->ud.lock);
-- 
2.30.2

