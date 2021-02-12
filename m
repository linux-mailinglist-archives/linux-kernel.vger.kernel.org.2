Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4A319DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhBLL5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhBLLzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:55:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B967CC061786;
        Fri, 12 Feb 2021 03:55:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o15so642736wmq.5;
        Fri, 12 Feb 2021 03:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjamovSIZN1h3BG1Szvqk8FPqfwv9+dPJVy4/x8wtSQ=;
        b=TEuQ7n0OirXB40e7d78tZuiLcrCyv2roWDARht1WhKTJ3KCmEsclDoiYx9pUiv+SB0
         osERkswvy93kbY/0bsqn9b7OlheK7P+zrZiDWf6JusCMkR9zkrZA3sRnd0og/IFebL6Z
         KAeFjenYigGwPjNdluaQzPU2PWevj5l9Lgfku9mqAz4IgojAsAMQrsdhL+x3s+2ugjas
         4/NaSkaHSm8YQDtDy9o6ro7x1oGakegNGa4pxo8JAzi/aWQpTBGYa009bK9em99RdbIo
         Zx5SqxfIrUbNONWb8/5Qg5YHcTEe3/BMpFeAHAa1opUI7ZzV102frAQrwi0CfwKVaLoq
         5qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjamovSIZN1h3BG1Szvqk8FPqfwv9+dPJVy4/x8wtSQ=;
        b=loKpMCR1YE9kefZLjgnFu11F+pCQ2t+bxSPTll9m34cplhtrXjjC1/Vx2S0U/Z9lda
         iPGgIic1LHCkvnY9cAVKfX0xQ4AiARNm2zgmVkoCzJ7YNi0p9plMcdQ6Zq5HIRthSE2K
         GJksmJ8FZ+BvFcSePwtM+RfS8SdieyXSF/2A9HCseVXCknNhFEMph2HkjN+7RWn/mpd8
         2fZtH669clWY1RwcMIKFOWRTkNUNcrPDWzF2zUrjm4do978xQGMxo1aqF7P6NV1qTbzR
         ehEFK58eI+dwedShXOUz85EVZ4muis8H2p2vK/9o3ZLVS0DMs0f8mlDXbBqjeLq/fXhI
         AeFQ==
X-Gm-Message-State: AOAM533o+iJ8oPYbSUvaWRh3cDW4oijaquLdCgqiCGRUFIDi2z00uhAg
        h2Lu4/TB4XuLgKmMu7jAP5s=
X-Google-Smtp-Source: ABdhPJwq+6LMtB6ObsxQoxkDg8aq3y6++uEv7bPRQzx6fyZWuTnmgySETJPHLhGBXqp73mOkI5l5ew==
X-Received: by 2002:a1c:bc89:: with SMTP id m131mr2412736wmf.32.1613130902538;
        Fri, 12 Feb 2021 03:55:02 -0800 (PST)
Received: from xws.localdomain (p5487bf16.dip0.t-ipconnect.de. [84.135.191.22])
        by smtp.gmail.com with ESMTPSA id p1sm9455560wru.86.2021.02.12.03.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 03:55:02 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] platform/surface: aggregator_registry: Add battery subsystem devices
Date:   Fri, 12 Feb 2021 12:54:36 +0100
Message-Id: <20210212115439.1525216-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210212115439.1525216-1-luzmaximilian@gmail.com>
References: <20210212115439.1525216-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add battery subsystem (TC=0x02) devices (battery and AC) to the SSAM
device registry. These devices need to be registered for 7th-generation
Surface models. On 5th- and 6th-generation models, these devices are
handled via the standard ACPI battery/AC interface, which in turn
accesses the same SSAM interface via the Surface ACPI Notify (SAN)
driver.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 6c23d75a044c..cde279692842 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -47,6 +47,24 @@ static const struct software_node ssam_node_hub_base = {
 	.parent = &ssam_node_root,
 };
 
+/* AC adapter. */
+static const struct software_node ssam_node_bat_ac = {
+	.name = "ssam:01:02:01:01:01",
+	.parent = &ssam_node_root,
+};
+
+/* Primary battery. */
+static const struct software_node ssam_node_bat_main = {
+	.name = "ssam:01:02:01:01:00",
+	.parent = &ssam_node_root,
+};
+
+/* Secondary battery (Surface Book 3). */
+static const struct software_node ssam_node_bat_sb3base = {
+	.name = "ssam:01:02:02:01:00",
+	.parent = &ssam_node_hub_base,
+};
+
 /* Devices for Surface Book 2. */
 static const struct software_node *ssam_node_group_sb2[] = {
 	&ssam_node_root,
@@ -57,6 +75,9 @@ static const struct software_node *ssam_node_group_sb2[] = {
 static const struct software_node *ssam_node_group_sb3[] = {
 	&ssam_node_root,
 	&ssam_node_hub_base,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_bat_sb3base,
 	NULL,
 };
 
@@ -75,12 +96,16 @@ static const struct software_node *ssam_node_group_sl2[] = {
 /* Devices for Surface Laptop 3. */
 static const struct software_node *ssam_node_group_sl3[] = {
 	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
 	NULL,
 };
 
 /* Devices for Surface Laptop Go. */
 static const struct software_node *ssam_node_group_slg1[] = {
 	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
 	NULL,
 };
 
@@ -99,6 +124,8 @@ static const struct software_node *ssam_node_group_sp6[] = {
 /* Devices for Surface Pro 7. */
 static const struct software_node *ssam_node_group_sp7[] = {
 	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
 	NULL,
 };
 
-- 
2.30.1

