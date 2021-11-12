Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1498844E554
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 12:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbhKLLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 06:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhKLLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 06:09:55 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08882C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 03:07:04 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c126so8277121pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 03:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fibocom-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfbdNfPRKiXEShy5FRCun9rl5zvUp5N+pmeBSmr/0OE=;
        b=3fwXMDOm36uht8ippOLg8VoDeEoEjQOCxweixsjBMdRwxeQ7Uy2B36OkwJ5Ldu/GM3
         jwQh8gB6sO3ySMP8SrlEWsxOc3FzGhlvPnojHRPSPDW1hcaEP1f//9Z7RzUqLvZYFJna
         bLmezReJaQohURMSV6f2b3NMJH/UyTXYNJe8URg20CQxCj+06SLeu3QRBuJbP3O6MhOA
         vqbmf1dcOcfMV4QUeRrK/CmqJ2tPQeLd2p0kEyXZv+NcKTYj815OnAeubMQnyLSe6sd4
         t756QSC5Unlq1Y4ev/TBuHRxnRYMahbqu3DRZfWAVhkx6DkxPzKfnX1Ovsk5iGVFAhdq
         Z2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfbdNfPRKiXEShy5FRCun9rl5zvUp5N+pmeBSmr/0OE=;
        b=gFY4+lxIIrEgxByk3YhRVMdjtJjwtzRaJFp+j4uSzeati+P28Yqp6GYpQ/QtxA0i0l
         vSP3sbHo+oqAU3OY15HICy5T8tJICxHVC+dbvHu/oovWnQHa+UJXqMHmEeuqv0cHX5OL
         dUUDHQdzxh4AkC6KX77UNweQ1E7OSR4SjMYGmHdXWGZ50ReErDmDnMoYYDBORnxVZp/n
         JA8qZfG3fLgNevgydcVJHBtQ5u43pc0KDIpShhYUkk22jEeRk+n8KbTMGs+wPBmv6Zt5
         tJ33k/zJSEIfOCaxhFKyOPKKabPLkQVGxK3MqOoboAnhl37fktvgJ5ndXHIu7AF1iAKu
         qAnQ==
X-Gm-Message-State: AOAM530cHyXGJgWC4S2fp7WWEeXTz4mLSv3NoSpw2vX507w5xDch45Fr
        P69Hm/wS2aOgGnUSmoKB68JcJ9EnYVUSbjKM
X-Google-Smtp-Source: ABdhPJy8VP4eQF6+4V8z3AV+wlxSCZegoWCA9NlOq6wbpZqvL/2G6O80yFikG+09dw2V6rQnemE04Q==
X-Received: by 2002:aa7:88cb:0:b0:49f:ad17:c08 with SMTP id k11-20020aa788cb000000b0049fad170c08mr12894189pff.19.1636715224425;
        Fri, 12 Nov 2021 03:07:04 -0800 (PST)
Received: from localhost ([103.95.66.60])
        by smtp.gmail.com with ESMTPSA id l1sm4616806pgn.27.2021.11.12.03.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 03:07:04 -0800 (PST)
From:   Super Zhang <superzmj@fibocom.corp-partner.google.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Super Zhang <superzmj@fibocom.corp-partner.google.com>
Subject: [PATCH] USB: serial: option: add Fibocom FM101-GL variants
Date:   Fri, 12 Nov 2021 19:06:38 +0800
Message-Id: <20211112110638.751141-1-superzmj@fibocom.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the USB serial option driver support for the Fibocom
FM101-GL Cat.6
LTE modules as there are actually several different variants.
- VID:PID 2cb7:01a4, FM101-GL for laptop debug M.2 cards(adb
  interface)
- VID:PID 2cb7:01a2, FM101-GL are laptop M.2 cards (with
MBIM interfaces for /Linux/Chrome OS)

T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=5000
MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=01a2 Rev= 5.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=86bffe63
C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00
Driver=cdc_mbim
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30
Driver=(none)
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40
Driver=(none)
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40
Driver=(none)
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40
Driver=(none)
I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40
Driver=(none)

T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=01a4 Rev= 5.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=86bffe63
C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00
Driver=cdc_mbim
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30
Driver=(none)
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40
Driver=(none)
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01
Driver=(none)
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40
Driver=(none)
I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40
Driver=(none)

Signed-off-by: Super Zhang <superzmj@fibocom.corp-partner.google.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 29c765cc8495..8f5c98a75429 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2081,6 +2081,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff) },			/* Fibocom FM101-GL (laptop adb) */
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.25.1

