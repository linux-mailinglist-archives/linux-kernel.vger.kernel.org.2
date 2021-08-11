Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107D03E8CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhHKI5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:57:21 -0400
Received: from m12-16.163.com ([220.181.12.16]:42144 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236152AbhHKI5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZiId/
        h2qDo7qfJ8MekJHMaRXBLsNBtDxkycmVfcPO2s=; b=X0BPCdIMJkW4JmzYj4Xh7
        0Kobg77qeEVm5efEGayrRGapWgyRb5OkMYO6WiNFASSMMTdHSV8vNZGlZqj2F9Af
        ikGtzoTsVEGD4yNh2DG8HXSie+A+1elBeJVjxWvCIh8za36+4tNyod4e8yDKGN24
        GHvYf80gDNpMmyT3wkh+t4=
Received: from localhost.localdomain (unknown [223.104.68.7])
        by smtp12 (Coremail) with SMTP id EMCowAC3xFjNkBNhmxe36w--.9208S2;
        Wed, 11 Aug 2021 16:56:47 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] [v2,1/1] This aims to support Foxconn SDX55
Date:   Wed, 11 Aug 2021 16:56:35 +0800
Message-Id: <20210811085635.4699-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAC3xFjNkBNhmxe36w--.9208S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GryxZFW3Wr4xuF4xuFW3Jrb_yoWDGFg_Cr
        yDurW7Ww1YgF42qrsrJaySq3yFk3y2qFZY93Wqgas5Xay7ta97Z3W2qr1Dtr1kAr17JF9x
        ZwnrWrn7tr4qgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0ajg7UUUUU==
X-Originating-IP: [223.104.68.7]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivw-rZFWBvNP95QAAsc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Foxconn SDX55 T77W175 device is working in PCIe mode normally.
You can find it in drivers/bus/mhi/pci_geneirc.c file.
But in some scenario, we need to capture the memory dump once it crashed.
So a diag port driver is needed.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/usb/serial/qcserial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 83da8236e3c8..d8b58aea3c60 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -111,6 +111,7 @@ static const struct usb_device_id id_table[] = {
 	{USB_DEVICE(0x16d8, 0x8002)},	/* CMDTech Gobi 2000 Modem device (VU922) */
 	{USB_DEVICE(0x05c6, 0x9204)},	/* Gobi 2000 QDL device */
 	{USB_DEVICE(0x05c6, 0x9205)},	/* Gobi 2000 Modem device */
+	{USB_DEVICE(0x05c6, 0x901d)},	/* Foxconn SDX55 QDL */
 
 	/* Gobi 3000 devices */
 	{USB_DEVICE(0x03f0, 0x371d)},	/* HP un2430 Gobi 3000 QDL */
-- 
2.25.1


