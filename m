Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CC53F1B08
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbhHSOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:00:10 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44076
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240163AbhHSOAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:00:08 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id CBBF6411C7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629381570;
        bh=a9ny+xZUCPsZrVKI8nflfzc/2KeNQowb9QjnWfTlKg4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Jzh1Cv16e4jQZTSrLtVvvBC4sDzrz42xppmUEDufKfXIh6SVSlt734ZO/nzuF5SYL
         bDgt2+3w7Fszp6vZfqUpBIw+4+xYIdxN+H0n60DrXKWUZUjt8M0CPcUAW9kKcsckVQ
         o4EJma+TloqJ2wsuX+Jli0iTgdjUqTw1CHMeZouufd7mElnvk+La8ZOyl1vkucI3w2
         QYLs3zFJcgAeSD9O93EewYB/Zq4yF3lIKkez6keaa4dkYX5tdS7LaGq4OUUJT4kzts
         rB2ahljKlWtiUnSvN2cLeerih6lxasVu60Ow5W+gxDO/h8UmxPHJQ7piNe+yygEn+F
         1KMCBqF034jTQ==
Received: by mail-pj1-f72.google.com with SMTP id gn12-20020a17090ac78c00b0017b13c022d8so74790pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 06:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9ny+xZUCPsZrVKI8nflfzc/2KeNQowb9QjnWfTlKg4=;
        b=VJiY/mPrROug4AIVrQviQVUjvLJb+xhxfqe3lQAVHSI7+7WvCpYZ3W1YmVdqkjanQW
         yBKASLbbrpTmwLwuo3AcQ2aSyqk7zL/aqkn6Nrnz5P58vnczXX78mmQl5g2Go6tZBDL0
         KxuxVQ5QhFgC37fw+zhIrfS7OXTGsV2JUBNb3Fj2dTAuJ9MhZh3XeVnamODBNerM6GGR
         2CRobkz0Duoam+MexGUbb9buRDTm7wjtyYgfK7fTBFv+F5nUYgANisH+bnn6S7Jpyzc8
         /aSVOpp4XKNnE3Oe03ViZS6BvM0mbcjFZj12CcI518Rr/iFppTKD/4dJuklGPFoH7mym
         KQzA==
X-Gm-Message-State: AOAM5335o+hQyz/l3thPAo1nfb7Dwd84o4gc+iEwNBT2GVsiFqo28h61
        iMiKRs5sceEVV6bjHMKUmZkO91IgwfS3CcuLKqSLFqIJKH9+s8NvIx0tD4/Jp7PBStfhbnBtdcM
        MDR34gq0RrAh20qr6giMDVumM/QwOF/6to0y8BdS2UQ==
X-Received: by 2002:a17:90b:240e:: with SMTP id nr14mr2711014pjb.170.1629381569260;
        Thu, 19 Aug 2021 06:59:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1I0V0a2X/mGlmKX1WllergnUm3sI0/t/EbLVGJ+aZPfoLFatszSaySp4oJ7weoz8f4yMU4w==
X-Received: by 2002:a17:90b:240e:: with SMTP id nr14mr2710980pjb.170.1629381568916;
        Thu, 19 Aug 2021 06:59:28 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net. [61.220.137.34])
        by smtp.gmail.com with ESMTPSA id g26sm4277522pgb.45.2021.08.19.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:59:28 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: add a reject table to disable msft
Date:   Thu, 19 Aug 2021 21:59:27 +0800
Message-Id: <20210819135927.49715-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Intel AC9560, follow this scenario and can't turn on bt since.
1. turn off BT
2. then suspend&resume multiple times
3. turn on BT

Get this error message after turn on bt.
[ 877.194032] Bluetooth: hci0: urb 0000000061b9a002 failed to resubmit (113)
[ 886.941327] Bluetooth: hci0: Failed to read MSFT supported features (-110)

Remove msft from compilation would be helpful.
Turn off msft would be also helpful.

As per Intel's comment, For AC9560, in JSL the hw_variant is 0x13.
In GLK, the hw_variant is 0x11. can't use hw_variant to filter for
AC9560.
Only AC9560 encounter this issue, so add a reject table to
disable msft for AC9560.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/bluetooth/btusb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..3c131fd40869 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -479,6 +479,11 @@ static const struct usb_device_id blacklist_table[] = {
 	{ }	/* Terminating entry */
 };
 
+static const struct usb_device_id msft_rej_table[] = {
+	{ USB_DEVICE(0x8087, 0x0aaa) },
+	{ }	/* Terminating entry */
+};
+
 /* The Bluetooth USB module build into some devices needs to be reset on resume,
  * this is a problem with the platform (likely shutting off all power) not with
  * the module itself. So we use a DMI list to match known broken platforms.
@@ -2851,6 +2856,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	char ddcname[64];
 	int err;
 	struct intel_debug_features features;
+	struct usb_device_id *match;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2928,7 +2934,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	case 0x12:	/* ThP */
 	case 0x13:	/* HrP */
 	case 0x14:	/* CcP */
-		hci_set_msft_opcode(hdev, 0xFC1E);
+		match = usb_match_id(data->intf, msft_rej_table);
+		if (!match)
+			hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	}
 
-- 
2.25.1

