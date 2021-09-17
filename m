Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF00D40F69F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbhIQLSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:18:07 -0400
Received: from m12-11.163.com ([220.181.12.11]:60466 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243123AbhIQLRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:17:53 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 07:17:52 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1GnoK
        xIThZOcUjZN+LnKLkrBCV1Z2p0AxQde/xcbFFQ=; b=OWr9uc+9WUeESiGZu2Q4r
        5J3Koq0W1uXnyFQRnfi50wbA3RegGSDmj5utpmnJDio7DkqGwPpf6q72KGT5kwcF
        09hSJUUXfsRM/pVS0jYvoPcQoZPESX7PW/P6wUvkK+aQ6CN1GhmM0c/7HI/eclKV
        U7YXu1dbx6+ZcQy9xwt4Iw=
Received: from localhost.localdomain (unknown [117.136.79.132])
        by smtp7 (Coremail) with SMTP id C8CowAD39Y13dURhnjK+xQ--.2421S2;
        Fri, 17 Sep 2021 19:01:13 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     slark_xiao@163.com
Subject: [PATCH] USB:serial:option Add Foxconn T99W265
Date:   Fri, 17 Sep 2021 19:01:06 +0800
Message-Id: <20210917110106.9852-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAD39Y13dURhnjK+xQ--.2421S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWftw15Wr48Gw43GFW5trb_yoW8Ww13pr
        4qyry7uryDWayrXrykJrs5AFyrWan3t34fKasrA3WagFWIywsrt348tFyfZFnxKrs3Kr4q
        vr4Dur47Kay8ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07js8n5UUUUU=
X-Originating-IP: [117.136.79.132]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRxwRZFc7T2nDjQAAsq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for Foxconn device T99W265 for enumeration with
PID 0xe0db.

usb-devices output for 0xe0db
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 19 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
P:  Vendor=0489 ProdID=e0db Rev=05.04
S:  Manufacturer=Microsoft
S:  Product=Generic Mobile Broadband Adapter
S:  SerialNumber=6c50f452
C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=896mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

if0/1: MBIM, if2:Diag, if3:GNSS, if4: Modem

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 29c765cc8495..fde599fa2d73 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2068,6 +2068,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
+	{ USB_DEVICE(0x0489, 0xe0db),						/* Foxconn T99W265 MBIM extension*/
+	  .driver_info = RSVD(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
-- 
2.25.1

