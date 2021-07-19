Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26C03CECDD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381944AbhGSRi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:38:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42110 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbhGSQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:03:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4D9AE1F41380
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1567A4800BA; Mon, 19 Jul 2021 18:43:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Ian Ray <ian.ray@ge.com>
Subject: [PATCH] USB: serial: cp210x: fix comments for GE CS1000
Date:   Mon, 19 Jul 2021 18:43:49 +0200
Message-Id: <20210719164349.137402-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Ray <ian.ray@ge.com>

Fix comments for GE CS1000 CP210x USB ID assignments.

Fixes: 42213a0190b5 ("USB: serial: cp210x: add some more GE USB IDs")
Signed-off-by: Ian Ray <ian.ray@ge.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/serial/cp210x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 09b845d0da41..af286240807e 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -202,8 +202,8 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x1901, 0x0194) },	/* GE Healthcare Remote Alarm Box */
 	{ USB_DEVICE(0x1901, 0x0195) },	/* GE B850/B650/B450 CP2104 DP UART interface */
 	{ USB_DEVICE(0x1901, 0x0196) },	/* GE B850 CP2105 DP UART interface */
-	{ USB_DEVICE(0x1901, 0x0197) }, /* GE CS1000 Display serial interface */
-	{ USB_DEVICE(0x1901, 0x0198) }, /* GE CS1000 M.2 Key E serial interface */
+	{ USB_DEVICE(0x1901, 0x0197) }, /* GE CS1000 M.2 Key E serial interface */
+	{ USB_DEVICE(0x1901, 0x0198) }, /* GE CS1000 Display serial interface */
 	{ USB_DEVICE(0x199B, 0xBA30) }, /* LORD WSDA-200-USB */
 	{ USB_DEVICE(0x19CF, 0x3000) }, /* Parrot NMEA GPS Flight Recorder */
 	{ USB_DEVICE(0x1ADB, 0x0001) }, /* Schweitzer Engineering C662 Cable */
-- 
2.30.2

