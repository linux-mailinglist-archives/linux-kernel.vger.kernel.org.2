Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756703ECD5F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 05:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhHPDyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:54:50 -0400
Received: from m12-17.163.com ([220.181.12.17]:53172 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhHPDyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1oyip
        U7nslx+ajlQcYfIDUJkED7lrAhTikyWEiTeqBE=; b=P6pgrF5MFhMHXe+4SX19x
        +A7pJr7kDHSm35/49fFnKe7w0MXJUihWQjW0YnDXu0hFAJWDAvi27Nez49i7c9U7
        m+J4hcVRzHq2GbCloAFO6xwy9imuHiB/M6w10XN1eRkcX8d5QKKZ/Il93ssy4wHg
        +IknG+l2NCv0vWeBvHyFUM=
Received: from localhost.localdomain (unknown [223.104.68.20])
        by smtp13 (Coremail) with SMTP id EcCowADHtn5f4RlhvR3bGQ--.20302S2;
        Mon, 16 Aug 2021 11:54:08 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] [V2,1/1]USB: serial: option: add Foxconn T77W175 composition 0x901d
Date:   Mon, 16 Aug 2021 11:54:04 +0800
Message-Id: <20210816035404.4210-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADHtn5f4RlhvR3bGQ--.20302S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw48Jry5JFW5Ar4rAFWDArb_yoW8GryfpF
        4jqFW5ZFyvq3yfXry0yrs7ZF95ua13t34Sg343Aw43XF13JaykK34xtFy5t343GFs5JryY
        vF1DAr4UGF4UtrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b50edUUUUU=
X-Originating-IP: [223.104.68.20]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBrQDwZF75bPEmlwAAsy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Foxconn SDX55 T77W175 device is working in PCIe mode normally.
You can find the PCIe support in drivers/bus/mhi/pci_generic.c file.
But in some scenario, we need to capture the memory dump once it crashed.
So a diag port under USB driver is needed.

Only interface 0 is used:
jbd@jbd-ThinkPad-P1-Gen-4:~$ lsusb | grep 05c6
Bus 003 Device 010: ID 05c6:901d Qualcomm, Inc. Generic Mobile Broadband Adapter
jbd@jbd-ThinkPad-P1-Gen-4:~$ lsusb -t | grep "Dev 10"
    |__ Port 7: Dev 10, If 0, Class=Vendor Specific Class, Driver=option, 480M

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/usb/serial/option.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 039450069ca4..c275f489c1cc 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2068,6 +2068,7 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
+	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x901d) },				/* Foxconn T77W175 PCIE+USB mode*/
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
-- 
2.25.1


