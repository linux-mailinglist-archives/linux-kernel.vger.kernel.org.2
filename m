Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9793E319DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhBLMBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhBLL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:56:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CFC06178B;
        Fri, 12 Feb 2021 03:55:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u14so7559405wri.3;
        Fri, 12 Feb 2021 03:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUUbiYDFGCraawh5DHwBORHGH4DrwjhPrPCMACKRdt4=;
        b=qBW/D+K870aXZzvpoPhHwC41LOXs8CSAQpBSJSY48hqDscNQ+rAZ9ShLRBl2ZAVNG0
         DkfoEc+FkIAsX6MgvonK3Oyq4q0mA9+enPCpRUIctiKLUUbwPI9Med+eSC6h3Hd9K8vH
         8l35vboXzD2ZDSHsWgIMvfnQyH3qglffeRswqhd5Rger60nuBPlszgl7mjlq1wuCM9F9
         UK1J2jXihR1tcm7XgrOaiOIvjQ8Os2J0KDUV3y/mtPVRQ10lCDDQr/wXkoMR/4WH7Cw7
         W5ffdsYWQZkq//fV8s58Y5Qy29HcINbVz4hvPcTGh/DD4IvyP+FjBxPPpWHR+1aLgr/p
         DGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUUbiYDFGCraawh5DHwBORHGH4DrwjhPrPCMACKRdt4=;
        b=ITsU9gdaTn98PG7oAmO6gUv2Oofb+7H4n9JjbErGpSY7l/lIaS5i/1Is1A0gjQhM2A
         eyoGl27bLsMluu1Uk4///gm1ZqXPehZjyxHRWJT3jiRt9j2P1WP+SQmgygEvM6Pgz+4l
         dfWzEcwWGDecONc5xmgLcct5+MYsso3kLRNb33xjZothlwtFAm2X8nBhcm2CmN+E9Nmo
         LSbJPl/r3lVtqWWhdeJUP7ZZR1tYeWXOqBTkeEDkWyr6oCBDtzW5mQWggFSmyuLVS9OO
         4ktXnuBH9UwCZLop6yWp1FzLfxRf67O0iKDZLBDDPq8pHfdnNbA+MvqyrQTdG2QH6GL5
         EC7A==
X-Gm-Message-State: AOAM5318PxCX4XnZmVRpJgDUl7S1WbBx1tv8iFlMs+qXPSDc7q6SZ9wM
        GU/Rki3wjPna/Mg0czemqUXLtzJKGPg=
X-Google-Smtp-Source: ABdhPJwVq7SAHGGeGJykYop+zmjN3d3isQDdaPPor0FE+DxNQjw+nAH5IXvgjmEY4Oyd16s+EzYwSg==
X-Received: by 2002:adf:9599:: with SMTP id p25mr2806772wrp.107.1613130905894;
        Fri, 12 Feb 2021 03:55:05 -0800 (PST)
Received: from xws.localdomain (p5487bf16.dip0.t-ipconnect.de. [84.135.191.22])
        by smtp.gmail.com with ESMTPSA id p1sm9455560wru.86.2021.02.12.03.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 03:55:05 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] platform/surface: aggregator_registry: Add HID subsystem devices
Date:   Fri, 12 Feb 2021 12:54:39 +0100
Message-Id: <20210212115439.1525216-7-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210212115439.1525216-1-luzmaximilian@gmail.com>
References: <20210212115439.1525216-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HID subsystem (TC=0x15) devices. These devices need to be registered
for 7th-generation Surface models. On previous generations, these
devices are either provided as platform devices via ACPI (Surface Laptop
1 and 2) or implemented as standard USB device.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index dc044d06828b..caee90d135c5 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -77,6 +77,48 @@ static const struct software_node ssam_node_bas_dtx = {
 	.parent = &ssam_node_root,
 };
 
+/* HID keyboard. */
+static const struct software_node ssam_node_hid_main_keyboard = {
+	.name = "ssam:01:15:02:01:00",
+	.parent = &ssam_node_root,
+};
+
+/* HID touchpad. */
+static const struct software_node ssam_node_hid_main_touchpad = {
+	.name = "ssam:01:15:02:03:00",
+	.parent = &ssam_node_root,
+};
+
+/* HID device instance 5 (unknown HID device). */
+static const struct software_node ssam_node_hid_main_iid5 = {
+	.name = "ssam:01:15:02:05:00",
+	.parent = &ssam_node_root,
+};
+
+/* HID keyboard (base hub). */
+static const struct software_node ssam_node_hid_base_keyboard = {
+	.name = "ssam:01:15:02:01:00",
+	.parent = &ssam_node_hub_base,
+};
+
+/* HID touchpad (base hub). */
+static const struct software_node ssam_node_hid_base_touchpad = {
+	.name = "ssam:01:15:02:03:00",
+	.parent = &ssam_node_hub_base,
+};
+
+/* HID device instance 5 (unknown HID device, base hub). */
+static const struct software_node ssam_node_hid_base_iid5 = {
+	.name = "ssam:01:15:02:05:00",
+	.parent = &ssam_node_hub_base,
+};
+
+/* HID device instance 6 (unknown HID device, base hub). */
+static const struct software_node ssam_node_hid_base_iid6 = {
+	.name = "ssam:01:15:02:06:00",
+	.parent = &ssam_node_hub_base,
+};
+
 /* Devices for Surface Book 2. */
 static const struct software_node *ssam_node_group_sb2[] = {
 	&ssam_node_root,
@@ -93,6 +135,10 @@ static const struct software_node *ssam_node_group_sb3[] = {
 	&ssam_node_bat_sb3base,
 	&ssam_node_tmp_pprof,
 	&ssam_node_bas_dtx,
+	&ssam_node_hid_base_keyboard,
+	&ssam_node_hid_base_touchpad,
+	&ssam_node_hid_base_iid5,
+	&ssam_node_hid_base_iid6,
 	NULL,
 };
 
@@ -116,6 +162,9 @@ static const struct software_node *ssam_node_group_sl3[] = {
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_tmp_pprof,
+	&ssam_node_hid_main_keyboard,
+	&ssam_node_hid_main_touchpad,
+	&ssam_node_hid_main_iid5,
 	NULL,
 };
 
-- 
2.30.1

