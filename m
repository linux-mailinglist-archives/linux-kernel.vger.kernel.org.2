Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C71B3D8074
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhG0VEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbhG0VEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:04:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8509C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:04:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q15-20020a25820f0000b029055bb0981111so187318ybk.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=383gaVpNqlLkwS7v7dVHihUUC0Gv0oWfLHlkAgvdKtc=;
        b=j1BwDdTCAHvo8p19/DxegI7QQhlKp/5CfyEqSk/JqE0Ah/yrEe9/ujq1YvA9uMUGtT
         s7ZvMK6JhxQABF6gLpPTBTK1Z727kuGPeInai4V0Nff8rznvB5h3jBis9++XNyk8c7Ni
         EJ56pAQ/GP2qf1h/aTtxmNNAvw+7bpHwwWGHFOyrQ7R+3cfKs085fFSTBRZqv8vi24KM
         ZB4LKJZ0K74pNcW3rMuLGf1n2xKa4W85Rxsepq9o411cgbPjiHFtpU6fp/nejCr0j/9q
         1HEE/d1bl77oPgczD5pt5bVTPgBg92XClcqtpWKI8wjPY5DCWhS8M9ARGdraOywJDo+L
         XSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=383gaVpNqlLkwS7v7dVHihUUC0Gv0oWfLHlkAgvdKtc=;
        b=bbDPS44lPH5g4lxARmzkIynYXao+JBr+9R8AMPJS+SxmBChGZt3Dkm9jgKKwLB5FPx
         mCqcSen6I1Ad+hK1fnU4zaoesOJKnmRbZeApopFGnjcTqkWLxeDbrJDJtZuzcYPijvzs
         xJckZaYBdimXVKP3qfY5m00Hqof139HJ3hKz4dvBDscOwzwmr7PqYYBMLYyz6Sf3ebVj
         RTZ0RNTCDlAaYIwVld9K/mguWITo3qmsu2y1+6NN/B8Mp8sBX+j/Be7I5bTCqQbBc7jT
         RvcTckgrHahCU083UEfTnqee4ax3F6TDrRpuHkbzeTVIDbKqsKdeD9mdMPWnnjYjzGeK
         0mqQ==
X-Gm-Message-State: AOAM532w8S2jeYgMsbaEudIfiIwtBrGFNF/PDGVRk7PS6rpap4Ct4qO0
        9Rqhew/vQo6/xy9X6RgG7Afhg7jjp2Re7fOhfQ==
X-Google-Smtp-Source: ABdhPJxVdnGte2RRUJ4ePeRr9hD5UMVYaIPxTP1VdrcyDyum2tar+QObrWSDt2chazY4j1MINrjfyFMuPHDOq3op+g==
X-Received: from michaelfsun.mtv.corp.google.com ([2620:15c:202:201:4e82:4fa2:fd10:e771])
 (user=michaelfsun job=sendgmr) by 2002:a25:b993:: with SMTP id
 r19mr35118195ybg.445.1627419878924; Tue, 27 Jul 2021 14:04:38 -0700 (PDT)
Date:   Tue, 27 Jul 2021 14:04:35 -0700
Message-Id: <20210727140425.1.I1ac63dde4853d7b38a018b20b3d6d3d539378df3@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] Bluetooth: btusb: Enable MSFT extension for TyphoonPeak,
 GarfieldPeak, and WCN6855 controllers
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Chethan T N <chethan.tumkur.narayan@intel.com>,
        Michael Sun <michaelfsun@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

The Intel TyphoonPeak, GarfieldPeak and Qualcomm WCN6855 Bluetooth
controllers support the Microsoft vendor extension, enable them by
setting VsMsftOpCode accordingly.

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 drivers/bluetooth/btusb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f8d9b1628af..b68511b7e07a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3016,6 +3016,17 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	btintel_version_info_tlv(hdev, &version);
 
 finish:
+	/* All Intel new genration controllers support the Microsoft vendor
+	 * extension are using 0xFC1E for VsMsftOpCode.
+	 */
+	switch (INTEL_HW_VARIANT(version.cnvi_bt)) {
+	case 0x17:
+	case 0x18:
+	case 0x19:
+		hci_set_msft_opcode(hdev, 0xFC1E);
+		break;
+	}
+
 	/* Set the event mask for Intel specific vendor events. This enables
 	 * a few extra events that are useful during general operation. It
 	 * does not enable any debugging related events.
@@ -4710,6 +4721,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
 		hdev->cmd_timeout = btusb_qca_cmd_timeout;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+		hci_set_msft_opcode(hdev, 0xFD70);
 	}
 
 	if (id->driver_info & BTUSB_AMP) {
-- 
2.32.0.432.gabb21c7263-goog

