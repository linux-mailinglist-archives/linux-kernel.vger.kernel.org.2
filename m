Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF223E8BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhHKIUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:20:55 -0400
Received: from m12-17.163.com ([220.181.12.17]:53816 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhHKIUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5+JWO
        J3r+zEO/65mm1qHsvRxGwpDfO8uhEu2vZUGL9Y=; b=lS/ZdneJ0e+Nqt9K/vkAm
        FJu5eNhIXmQfIB8+VIX0TQmFzm0KGnigMVJc53q7RukrW4FSIyC7b5UW1pHjl0Rv
        5zCLBGaWaIBClsIJgcUQUkGPS1ORxMJiXBQHQTsi+yftu3l/ER31zBxGO5FT+9D/
        3gW3+0DMOLveo3xbwgqsxI=
Received: from localhost.localdomain (unknown [223.104.68.7])
        by smtp13 (Coremail) with SMTP id EcCowADnDIFehBNhWMUnFg--.10383S2;
        Wed, 11 Aug 2021 16:03:43 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     hmh@hmh.eng.br, hdegoede@redhat.com
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] Fix WWAN device disabled issue after S3 deep When WWAN device wake from S3 deep, under thinkpad platform,it would be disabled. This disable status could be checked by command 'nmcli r wwan' or 'rfkill list'. Issue analysis as below: 1. When host resume from S3 deep, thinkpad_acpi driver would call hotkey_resume() function. Finnaly, it will use wan_get_status to check the current status of WWAN device. During this resume progress, wan_get_status would always return off even WWAN boot up completely. 2. If wan_get_status() return off, rfkill_set_sw_state() would set WWAN's status as disabled. 3. This may be a fault of LENOVO BIOS. 4. Workaround is add a WWAN device check before rfkill_set_sw_state(). If it's a Foxconn WWAN device, then we will ignore to do a status update.
Date:   Wed, 11 Aug 2021 16:03:38 +0800
Message-Id: <20210811080338.3098-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADnDIFehBNhWMUnFg--.10383S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyfury5Zw17ZFyfXFy7Jrb_yoW8Xr15pr
        WYyay0yFW7Kw4ag3WxJa15Ca98uFn8CryxKFZFyw1SvFWDKFyrJa4xtay3ZF43Gry8ta1a
        va4kJr18Ga1DZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaVbkUUUUU=
X-Originating-IP: [223.104.68.7]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDRDrZFaEEueg5wABsz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 603156a6e3ed..e3b7bc0e7a33 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1159,6 +1159,13 @@ struct tpacpi_rfk_ops {
 
 static struct tpacpi_rfk *tpacpi_rfkill_switches[TPACPI_RFK_SW_MAX];
 
+/*Foxconn SDX55 T77W175 products. All available device ID*/
+static const struct pci_device_id foxconn_device_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xE0AB) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xE0AF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xE0B4) },
+	{}
+};
 /* Query FW and update rfkill sw state for a given rfkill switch */
 static int tpacpi_rfk_update_swstate(const struct tpacpi_rfk *tp_rfk)
 {
@@ -1182,8 +1189,13 @@ static void tpacpi_rfk_update_swstate_all(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < TPACPI_RFK_SW_MAX; i++)
-		tpacpi_rfk_update_swstate(tpacpi_rfkill_switches[i]);
+	for (i = 0; i < TPACPI_RFK_SW_MAX; i++) {
+		if (pci_dev_present(foxconn_device_ids) && i == 1)
+			pr_info("Find Foxconn wwan device, ignore to update rfkill switch status\n");
+		else
+			tpacpi_rfk_update_swstate(tpacpi_rfkill_switches[i]);
+
+	}
 }
 
 /*
-- 
2.25.1


