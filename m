Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BA3F87C8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbhHZMmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:42:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47484 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhHZMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:42:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0FF49201A8;
        Thu, 26 Aug 2021 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629981695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yIff+2XJvrp6u1GxM0D/Wk0qpyDBh4ZSonmGJkPqpbg=;
        b=r2crKNj1/rFDSWFPitGSZpRhlefXvnivy7+1mjJwG8z030+hYgQ6Ai0WZIHmtthMw4fjOs
        gmDA4cgFD1ZrT1KSMiq/aGaD96vgF3N/WkMJsUvVk3cksE7Z7Ja9day3pwc6bfvYogPXE+
        XHyDuifxOJy5h5Tg4xD1y3vBDLo8xWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629981695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yIff+2XJvrp6u1GxM0D/Wk0qpyDBh4ZSonmGJkPqpbg=;
        b=qcnpgrEUoOQNot5QgjRPSktAAzOTPIqFIfMS1KHMQ2024M7/w7zJUd5GCRbVjtSOLqvROA
        OzF6bXzUztkH3JBw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 07F43A3B8D;
        Thu, 26 Aug 2021 12:41:35 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Moritz Fischer <mdf@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: renesas-xhci: Prefer firmware loading on unknown ROM state
Date:   Thu, 26 Aug 2021 14:41:27 +0200
Message-Id: <20210826124127.14789-1-tiwai@suse.de>
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
v1->v2: just rebased to 5.14-rc7+

 drivers/usb/host/xhci-pci-renesas.c | 35 +++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 5923844ed821..ef5e91a5542d 100644
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
 	if (err == 0)
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

