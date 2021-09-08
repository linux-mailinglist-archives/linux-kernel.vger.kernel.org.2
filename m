Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07324038A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351445AbhIHLVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351239AbhIHLVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:21:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E0DC061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 04:20:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oc9so1373030pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pmk2a81JVl4SkAncwyxKrhCXZFyctOgBxo36TTei3kc=;
        b=AWG1220m9+DCOAGn5Ytl/f+I2ojC1KPGwYixzk2HOe/AqaVO3K9yqyNxd/B9HKWV1T
         du/mzJWSwa6TLuad+dcXAYyNHmm5m2yb6c95yjmS0YvspxMQORTQJrETXD3xiiEvEbf/
         zLBg0dbQfcSQv0JXkIwPxqWZKyMQpeM14Cxog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pmk2a81JVl4SkAncwyxKrhCXZFyctOgBxo36TTei3kc=;
        b=mTEUJCndP6STVp0co+vYZJXvFh4yUiT2B8Z7CjJwz9KqmxXVQXkICkxIKTvuenmWTg
         BHZjKBEV9hvGHIAyBVRA2uBOSQccJROpj+H4UHQH9zcHhGg5m6daqPsdhLh0az1OZ/aa
         6Kq/F7Z/wGEyiRXHwnN0+TYfa1MO5/LsRYyxhbX2l+zk34Cu2bhtEYIr96104hRvGQme
         BMvtWJKW4jnrNCpwoI83bGVSAXcrzQyMoPpKb/OkJ1dNE4SzFkIBqyz26YkpW4qkutR4
         gXyCODhwiVTPI3BxtPoX+4g4b1j54kBbYgGzVxv3I9Ye7ErWaxb1738Ww9lenpb/BMzS
         w+Kg==
X-Gm-Message-State: AOAM532i1lAxHeGPjy6ag5SjMDd2BqmGsGip+0khRhvFSzSbz0bzZDvC
        t9xb41DYlaWtrnoph5lA6PqKvQ==
X-Google-Smtp-Source: ABdhPJxHbqzFAiURaotJ7J2wZ1NVUHXZuEv5T02En4QRCuPNLGNTg50874q3/ZcCbJ9rEkc5ktwr2w==
X-Received: by 2002:a17:902:b713:b0:132:5a48:18cb with SMTP id d19-20020a170902b71300b001325a4818cbmr2583683pls.50.1631100003426;
        Wed, 08 Sep 2021 04:20:03 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6939:f2f4:4be:bf22])
        by smtp.gmail.com with ESMTPSA id v6sm2160881pjr.41.2021.09.08.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:20:03 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: btrtl: Set up Realtek 8822CE for Android BQR commands
Date:   Wed,  8 Sep 2021 19:19:51 +0800
Message-Id: <20210908191915.v2.3.Ic8dcac2622d16775748f9d36c0a5e893372aa48d@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210908191915.v2.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
References: <20210908191915.v2.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets up Realtek 8822CE to support the Android BQR commands.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v2:
- Fix the title

 drivers/bluetooth/btrtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1f8afa0244d8..e0bcdbe03eca 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -14,6 +14,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "btrtl.h"
+#include "btandroid.h"
 
 #define VERSION "0.1"
 
@@ -740,12 +741,13 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	/* Enable central-peripheral role (able to create new connections with
 	 * an existing connection in slave role).
 	 */
-	/* Enable WBS supported for the specific Realtek devices. */
+	/* Enable WBS and quality report supported by the specific devices. */
 	switch (btrtl_dev->project_id) {
 	case CHIP_ID_8822C:
 	case CHIP_ID_8852A:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+		hdev->set_quality_report = btandroid_set_quality_report;
 		break;
 	default:
 		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
-- 
2.33.0.153.gba50c8fa24-goog

