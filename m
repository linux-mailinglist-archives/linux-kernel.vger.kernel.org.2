Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6183C3F1840
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbhHSLfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:35:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46630 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhHSLfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:35:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 00F73220C3;
        Thu, 19 Aug 2021 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629372873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=C5L3+E3FrtzJQeCJa4s00UVMVLpvEbwXxqPMWVgvpgE=;
        b=snbkeYDpPT5cojvS678qZDl855L6XpWhdtHqYCcv0Wph5Yev2EBpVcaOWZacanGDm45O1d
        MqGn1XQP86TYHD3QDMta+Ev35+H4P+e7nRJ7uLY2HAKxlXmNm1/LWfBEzqjC0Kic/HPcDp
        tqYK6cawMSkGXhtwnOshjo/TneEx0Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629372873;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=C5L3+E3FrtzJQeCJa4s00UVMVLpvEbwXxqPMWVgvpgE=;
        b=L4iA4mmlhka6C37QaFU+on0rb2jZM5FXMsqy4QcfhkMdClKOlYITOLHigRPeIvef1zmLA1
        5b/aQmQ3Vy00srAQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 58580A3BFF;
        Thu, 19 Aug 2021 11:34:15 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: renesas-xhci: Prefer firmware loading on unknown ROM state
Date:   Thu, 19 Aug 2021 13:34:27 +0200
Message-Id: <20210819113427.1166-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent attempt to handle an unknown ROM state in the commit
d143825baf15 ("usb: renesas-xhci: Fix handling of unknown ROM state")
resulted in a regression and reverted later by the commit 44cf53602f5a
("Revert "usb: renesas-xhci: Fix handling of unknown ROM state"").
The problem of the former fix was that it treated the failure of
firmware loading as a fatal error.  Since the firmware files aren't
included in the standard linux-firmware tree, most users don't have
them, hence they got the non-working system after that.  The revert
fixed the regression, but also it didn't make the firmware loading
triggered even on the devices that do need it.  So we need still a fix
for them.

This is another attempt to handle the unknown ROM state.  Like the
previous fix, this also tries to load the firmware when ROM shows
unknown state.  In this patch, however, the failure of a firmware
loading (such as a missing firmware file) isn't handled as a fatal
error any longer when ROM has been already detected, but it falls back
to the ROM mode like before.  The error is returned only when no ROM
is detected and the firmware loading failed.

Along with it, for simplifying the code flow, the detection and the
check of ROM is factored out from renesas_fw_check_running() and done
in the caller side, renesas_xhci_check_request_fw().  It avoids the
redundant ROM checks.

The patch was tested on Lenovo Thinkpad T14 gen (BIOS 1.34).  Also it
was confirmed that no regression is seen on another Thinkpad T14
machine that has worked without the patch, too.

Fixes: 44cf53602f5a ("Revert "usb: renesas-xhci: Fix handling of unknown ROM state"")
BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1189207
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/host/xhci-pci-renesas.c | 35 +++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index aa88e57649a9..52599d96634f 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -207,7 +207,8 @@ static int renesas_check_rom_state(struct pci_dev *pdev)
 			return 0;
 
 		case RENESAS_ROM_STATUS_NO_RESULT: /* No result yet */
-			return 0;
+			dev_dbg(&pdev->dev, "Unknown ROM status ...\n");
+			return -ENOENT;
 
 		case RENESAS_ROM_STATUS_ERROR: /* Error State */
 		default: /* All other states are marked as "Reserved states" */
@@ -224,14 +225,6 @@ static int renesas_fw_check_running(struct pci_dev *pdev)
 	u8 fw_state;
 	int err;
 
-	/* Check if device has ROM and loaded, if so skip everything */
-	err = renesas_check_rom(pdev);
-	if (err) { /* we have rom */
-		err = renesas_check_rom_state(pdev);
-		if (!err)
-			return err;
-	}
-
 	/*
 	 * Test if the device is actually needing the firmware. As most
 	 * BIOSes will initialize the device for us. If the device is
@@ -591,21 +584,39 @@ int renesas_xhci_check_request_fw(struct pci_dev *pdev,
 			(struct xhci_driver_data *)id->driver_data;
 	const char *fw_name = driver_data->firmware;
 	const struct firmware *fw;
+	bool has_rom;
 	int err;
 
+	/* Check if device has ROM and loaded, if so skip everything */
+	has_rom = renesas_check_rom(pdev);
+	if (has_rom) {
+		err = renesas_check_rom_state(pdev);
+		if (!err)
+			return 0;
+		else if (err != -ENOENT)
+			has_rom = false;
+	}
+
 	err = renesas_fw_check_running(pdev);
 	/* Continue ahead, if the firmware is already running. */
 	if (!err)
 		return 0;
 
+	/* no firmware interface available */
 	if (err != 1)
-		return err;
+		return has_rom ? 0 : err;
 
 	pci_dev_get(pdev);
-	err = request_firmware(&fw, fw_name, &pdev->dev);
+	err = firmware_request_nowarn(&fw, fw_name, &pdev->dev);
 	pci_dev_put(pdev);
 	if (err) {
-		dev_err(&pdev->dev, "request_firmware failed: %d\n", err);
+		if (has_rom) {
+			dev_info(&pdev->dev, "failed to load firmware %s, fallback to ROM\n",
+				 fw_name);
+			return 0;
+		}
+		dev_err(&pdev->dev, "failed to load firmware %s: %d\n",
+			fw_name, err);
 		return err;
 	}
 
-- 
2.26.2

