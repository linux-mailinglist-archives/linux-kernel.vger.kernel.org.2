Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6913E8909
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 05:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhHKDzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 23:55:38 -0400
Received: from m12-14.163.com ([220.181.12.14]:52287 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232905AbhHKDzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GM9L+
        HUk4X50o6mDdEuNj+fmqhM9FliDuUpR9ApSuTE=; b=cIX4VIAmUOEUSbSkqBhoj
        AXQGmS+4J6/V0mmvalvro/VR3Pf3LQrNmBqVCwnK46V9IlxaW1ges/kgtkgmJMVP
        nBHzGEsrmPauS9CQ4AvyE0wRGtA9765IKME27ojV/9Ut3QNi4u/3MlDORy086anW
        LyFu0n2ftX4KqIMSDFMPIk=
Received: from localhost.localdomain (unknown [223.104.68.7])
        by smtp10 (Coremail) with SMTP id DsCowABXstbFSRNhUkp5BQ--.21168S2;
        Wed, 11 Aug 2021 11:53:47 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        slark_xiao@163.com
Subject: [PATCH] This change aims to support Foxconn SDX55. In some scenario, we need to use this port to capture memory dump.
Date:   Wed, 11 Aug 2021 11:53:09 +0800
Message-Id: <20210811035309.7942-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABXstbFSRNhUkp5BQ--.21168S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw48tw43CFyUXw1xJw13urg_yoW3Xwc_Cr
        yDWFZ7W3WYkF4aqr47JaySvw4Fk3y2vFZY9F1vgas5JFW7KaykA3W7tF1Dtr18Xw1xXF9x
        ZwnrWwn7tr4qgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Hv3UUUUUU==
X-Originating-IP: [223.104.68.7]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDQvrZFaEEuWiSwAAsF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

