Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834E4363CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbhDSHuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:50:09 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42923 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230313AbhDSHuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:50:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 955FD1D60;
        Mon, 19 Apr 2021 03:49:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 19 Apr 2021 03:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=WY3OOnK1dLzce0lceZd13Qs7Q2TBRN8fudv/fUe7Rns=; b=XbjJtAcv
        3Kw5+jojwO0jgor3mY79EL9qLMLWysIQmswvo7lyiFINsWLy90ksTHPWNOTdQkZB
        xAdKxwORMI3iByUeMDwl10TT5MLjm/WQjqQ9GcRuCPUE3B34gXWjrnmfHdvFRqCI
        1maZtPnUNOSVrkbZayRFzKyMHNRdJapNwUDXHxJ22plImZW/LJi8KNw9knRBGg5e
        pxTTHEnUzbweVprqEHSCBXcekV0eIiSaAUK8wSSD0JL19fOSHbXgf8Qmej0iV9o4
        jwfpZvwnN8Jmukrbi4D1TzTpFShwbMGMzZaB6B+z7Orj7CFqE4fd73QkkohR+3Nm
        lqNDz5vHZ9i7MQ==
X-ME-Sender: <xms:ETZ9YPT_TBFknAxfSSA87ZP8RdS-3kNfBj-vfdy8EO9Xl9AdOECclA>
    <xme:ETZ9YAxPpGAfkM3W4AVuAq1QXxfy2CWw8E2_q5lCCzMaqSJ0Hx2hVRiAj8AlAOB8q
    7MXufi0ZYh0OBxcdJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtfedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpedvteekvdeuhedthfeuudelheejie
    fhvddtteelleeghfekhfeugfehgeekffdtheenucfkphepudduiedrvdehuddrudelfedr
    udelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ETZ9YE3IagPrEMLXgLp_cViSZN_PkT8pXGvUUCYJwZKvY8vd0eA2Bw>
    <xmx:ETZ9YPDiSxY5ZtYwbW623iSoZTKEW3rF7kgWaLIPEVJL6CfqiyuoeQ>
    <xmx:ETZ9YIgEtz3RdRBKEBPUjBUJ6adDmR17F4IpZFl_3p6i4f-fzUVm0A>
    <xmx:ETZ9YLsa23wOndsy9T-gzTXyiMATCCYFmGzwpVs_kAhBVQYRdoC9dg>
Received: from fedora.. (unknown [116.251.193.196])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B0BA24005A;
        Mon, 19 Apr 2021 03:49:33 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/2] Revert "platform/x86: asus-nb-wmi: Drop duplicate DMI quirk structures"
Date:   Mon, 19 Apr 2021 19:49:14 +1200
Message-Id: <20210419074915.393433-2-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419074915.393433-1-luke@ljones.dev>
References: <20210419074915.393433-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 67186653c90360922e3965d0376a61dbf6c42711.
---
 drivers/platform/x86/asus-nb-wmi.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index d41d7ad14be0..b07b1288346e 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -110,7 +110,12 @@ static struct quirk_entry quirk_asus_forceals = {
 	.wmi_force_als_set = true,
 };
 
-static struct quirk_entry quirk_asus_vendor_backlight = {
+static struct quirk_entry quirk_asus_ga401i = {
+	.wmi_backlight_power = true,
+	.wmi_backlight_set_devstate = true,
+};
+
+static struct quirk_entry quirk_asus_ga502i = {
 	.wmi_backlight_power = true,
 	.wmi_backlight_set_devstate = true,
 };
@@ -432,7 +437,7 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "GA401IH"),
 		},
-		.driver_data = &quirk_asus_vendor_backlight,
+		.driver_data = &quirk_asus_ga401i,
 	},
 	{
 		.callback = dmi_matched,
@@ -441,7 +446,7 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "GA401II"),
 		},
-		.driver_data = &quirk_asus_vendor_backlight,
+		.driver_data = &quirk_asus_ga401i,
 	},
 	{
 		.callback = dmi_matched,
@@ -450,7 +455,7 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "GA401IU"),
 		},
-		.driver_data = &quirk_asus_vendor_backlight,
+		.driver_data = &quirk_asus_ga401i,
 	},
 	{
 		.callback = dmi_matched,
@@ -459,7 +464,7 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "GA401IV"),
 		},
-		.driver_data = &quirk_asus_vendor_backlight,
+		.driver_data = &quirk_asus_ga401i,
 	},
 	{
 		.callback = dmi_matched,
@@ -468,7 +473,7 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "GA401IVC"),
 		},
-		.driver_data = &quirk_asus_vendor_backlight,
+		.driver_data = &quirk_asus_ga401i,
 	},
 		{
 		.callback = dmi_matched,
@@ -477,7 +482,7 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "GA502II"),
 		},
-		.driver_data = &quirk_asus_vendor_backlight,
+		.driver_data = &quirk_asus_ga502i,
 	},
 	{
 		.callback = dmi_matched,
@@ -486,7 +491,7 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "GA502IU"),
 		},
-		.driver_data = &quirk_asus_vendor_backlight,
+		.driver_data = &quirk_asus_ga502i,
 	},
 	{
 		.callback = dmi_matched,
@@ -495,7 +500,7 @@ static const struct dmi_system_id asus_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "GA502IV"),
 		},
-		.driver_data = &quirk_asus_vendor_backlight,
+		.driver_data = &quirk_asus_ga502i,
 	},
 	{
 		.callback = dmi_matched,
-- 
2.31.1

