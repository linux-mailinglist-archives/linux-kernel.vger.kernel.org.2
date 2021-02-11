Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA225319362
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhBKTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhBKTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:08 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CEDC06178B;
        Thu, 11 Feb 2021 11:46:54 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id lg21so11889244ejb.3;
        Thu, 11 Feb 2021 11:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R6dNG5V5dWsYH7eHxyaPUs81huQoeK3laGD/naMd3MI=;
        b=ImN+gkxPMKH18ZnVHeshOhr6ndqLV0rGBOdvaLkJKceRH6rw6FTWDxX8NAN7MTmStK
         OphFjMafr3l3HKTEE6p9esG30KKohMSc3Kl67n55Y27J+5qh8vKR3TjyBE1BkDAaoiz1
         X4LLHnP8jzS1XXdBnifchrlXp0t92kmRS5X0brMJGouVp7jAZyOj/fMgQ4DvMNFAEgUS
         DOR1Uqdt4KeuoAMK3bsEEuyb6Zj6jBNi5CQ87ZAaM8EMVzGZ4v7NOFjXlH47S9GR73Wg
         RoQLyVJ5tLafaTUmM9wvtsJh6a+AfRElG0p/24IZGJXpAHMWQgwIodvRoS6ib065H9qe
         05Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6dNG5V5dWsYH7eHxyaPUs81huQoeK3laGD/naMd3MI=;
        b=dw6r7CzoPyT3KI4U9tl4jQg7wrtO+XHREFfXcK4fUzDFAb4K/u8uF77gjU4JPoptWU
         t4EWnhft3KPMaH7bPK8ZxMaG9xzyQoC6Nh21+JW3qZTPYo4Nz0DlT+GR1GJfUrl7XA0Y
         55p1KGN7AM4tR86uR3lkEVaLkP77T37f9QuMg//AH3efBTpg5DrV5nMkTkdVbd7YaeoG
         3T30sHH2EGLJwWqn/NJyqgw9bMX13P+Fg68UDFbe0m1RK/s7Gq1VEg5kRAByIOIgkOmx
         EPEHNvcGxk73QciO1LX6/zBYJ4n/tZKPnBKQBd9P8pBM7B+Gxh7gyQ6Jxant33Jxftf3
         R1uw==
X-Gm-Message-State: AOAM530vlPfXcPLXig3Xl0SaFb3M7pSX1V2aEX6Q8vKp7FC0H9GWKBEe
        PvV5DTdfZB+UK4zehlEP7Oz9jDTgy5rqJg==
X-Google-Smtp-Source: ABdhPJywvdLWQHY5PyOytsgynRAmotV5Y0WSjahGWQ3duTSfa/ADDHTS3N3gBwlugDdePFRGFISmlw==
X-Received: by 2002:a17:906:ce24:: with SMTP id sd4mr9788048ejb.21.1613072812956;
        Thu, 11 Feb 2021 11:46:52 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id f6sm4728728edr.72.2021.02.11.11.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:46:52 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] platform/surface: aggregator_registry: Add HID subsystem devices
Date:   Thu, 11 Feb 2021 20:46:36 +0100
Message-Id: <20210211194636.568929-7-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211194636.568929-1-luzmaximilian@gmail.com>
References: <20210211194636.568929-1-luzmaximilian@gmail.com>
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
index 4c74e80dc34a..07cadd5a10f2 100644
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
2.30.0

