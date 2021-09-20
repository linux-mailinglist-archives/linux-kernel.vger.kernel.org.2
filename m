Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A304118D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbhITQFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhITQFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:05:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9371C061574;
        Mon, 20 Sep 2021 09:03:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d21so31113260wra.12;
        Mon, 20 Sep 2021 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcR8T78D6KzdaCdUdXtUTv6ShblvMHi/s5bj6aQtCUA=;
        b=hXlvTF57VTAzUeU3SmrlIOFc08fH8PnH1CZtEmos1h/ms+tTe8LSb15CH1OwAv2l0j
         fMvMZFZkJEZO683Ybx/3MnxNlp2wpLkXRG64/B64Tt+i4ENnCIEHDc44o2BzpCuUZ9Pz
         HyP8ds0EELkUBO51Hd48Dk4V+6r+clmJJmZ2/l0J/+xV+ccIl2E/ft9j/W7kOQVvxxDQ
         9Y7kcrfc3p7Sf8dMLKmT6PYrvtMKllkg+elSH+0Kcq+Sh4iFe64ZwFww/d/Cfpr9ZjJh
         v/5jHBlP383T2CxK0a/QLdbpM3DqfuALbE1e0XXyKaGImASPlTMJEw/LsJbFgRO6ND2I
         sBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcR8T78D6KzdaCdUdXtUTv6ShblvMHi/s5bj6aQtCUA=;
        b=qI5Me0JXLL5/o+hQu+pQVM4ZST9Y6oSEwBRgGaVPr+Tl59vLUf7pMcQKVq6/2crekS
         UPRzPkqsfaR4PjfMgeqTsm+D7uXnViEEdgqL+Z0dVU06LmNrWFxjvoQyT66QOATyoOpJ
         z8vAT16bHDNWy35tlGrJaFZ4ZWPHX6OYlQ6gsRQnOlAMKFl4k7qmevHZIkItljFMaGxL
         k7K+Ysxn/8D3IOKKYPDjVveoSL4u4mRCBQZipsASU8hxr71UbDQpVzFb8J2u0KzjFA6q
         GaQRGB3BFcgFz7kktEjaH4+J7QlP3o4W3ZrbAWA7JWMyY7Zrcm+Q0ObM5uDjXm849Ws/
         WWsA==
X-Gm-Message-State: AOAM532NyZX3fS1984lCUXG/qvWCa/nmOJjzFQcTNKZChSw2n+MKeFpK
        8BsCaqCdjqvFSGmBDpuRf6Y=
X-Google-Smtp-Source: ABdhPJyLFCFhzUxxzuQH2Exq2CM/Wn7dn5n8fkWcWSVKmKJre8nPazDsDpiedPKmZPcho6hEd77cRA==
X-Received: by 2002:a05:600c:4788:: with SMTP id k8mr9540521wmo.131.1632153821428;
        Mon, 20 Sep 2021 09:03:41 -0700 (PDT)
Received: from localhost.localdomain ([94.73.35.139])
        by smtp.gmail.com with ESMTPSA id c17sm20015422wrn.54.2021.09.20.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 09:03:40 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     hdegoede@redhat.com
Cc:     alex.hung@canonical.com, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Tobias Gurtzick <magic@wizardtales.com>
Subject: [PATCH] platform/x86/intel: hid: Add DMI switches allow list
Date:   Mon, 20 Sep 2021 18:03:12 +0200
Message-Id: <20210920160312.9787-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices, even non convertible ones, can send incorrect
SW_TABLET_MODE reports.

Add an allow list and accept such reports only from devices in it.

Bug reported for Dell XPS 17 9710 on:
https://gitlab.freedesktop.org/libinput/libinput/-/issues/662

Reported-by: Tobias Gurtzick <magic@wizardtales.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Tobias Gurtzick <magic@wizardtales.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/platform/x86/intel/hid.c | 33 +++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index a33a5826e81a..24d26336e39a 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -118,6 +118,24 @@ static const struct dmi_system_id dmi_vgbs_allow_list[] = {
 	{ }
 };
 
+/*
+ * Some devices, even non convertible ones, can send incorrect SW_TABLET_MODE
+ * reports. Accept such reports only from devices in this list.
+ */
+static const struct dmi_system_id dmi_switches_auto_add_allow_list[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "31" /* Convertible */),
+		},
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "32" /* Detachable */),
+		},
+	},
+	{} /* Array terminator */
+};
+
 struct intel_hid_priv {
 	struct input_dev *input_dev;
 	struct input_dev *array;
@@ -455,11 +473,16 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	 *
 	 * See dual_accel_detect.h for more info on the dual_accel check.
 	 */
-	if (!priv->switches && !priv->dual_accel && (event == 0xcc || event == 0xcd)) {
-		dev_info(&device->dev, "switch event received, enable switches supports\n");
-		err = intel_hid_switches_setup(device);
-		if (err)
-			pr_err("Failed to setup Intel HID switches\n");
+	if (event == 0xcc || event == 0xcd) {
+		if (!dmi_check_system(dmi_switches_auto_add_allow_list))
+			return;
+
+		if (!priv->switches && !priv->dual_accel) {
+			dev_info(&device->dev, "switch event received, enable switches supports\n");
+			err = intel_hid_switches_setup(device);
+			if (err)
+				pr_err("Failed to setup Intel HID switches\n");
+		}
 	}
 
 	if (priv->wakeup_mode) {
-- 
2.25.1

