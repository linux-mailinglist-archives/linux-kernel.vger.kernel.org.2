Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A463140FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhBHUxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbhBHTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:36:40 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DEDC0617AB;
        Mon,  8 Feb 2021 11:35:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a9so27051958ejr.2;
        Mon, 08 Feb 2021 11:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R6dNG5V5dWsYH7eHxyaPUs81huQoeK3laGD/naMd3MI=;
        b=CHbzY5FFybjixBJkOKuQ+JQw1DIvi3NOmwErK5cM6JIaCy4PLKcm3nYQgS863HPnwS
         BXKDgfB9EgxFdPupKh2WH9xdnAJcz55TE6Z9Y4xj3w8j9LD/Xe3C8Fh2pyOyqUD8Sswg
         YwC/4net2CQAiTtmAiBj4ZkSIGAzKI5T4g574/b14z2/hI3igFU8KI741QpcsZLnhRmK
         zkaqdLQcoHDPW2oqFlYH6G8Ahp6jZx4SMzfNbtntNurEot5k57o6kqtY0dtuClapiOfb
         Ps71T7mRDm8tibRfTVnYilp6ok+qtGzHNlxCrMD3nlVqJEYiLMLRGAHRz03N/2RkWgKq
         7ZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6dNG5V5dWsYH7eHxyaPUs81huQoeK3laGD/naMd3MI=;
        b=OgC+5iyS8WW9ByIdotnQIoaZ6zAvE6t1U0C8EanAWAko5tQVg22nYwR0QeoR2xuToT
         s1a5tBqt1i4D0DDUB5y9DC0SreY0nRS/0RlcU4u645PO+uy1joVZzK8GxVVdFWMVqnYN
         UhhUYKCLABNu2z8qWx0pxU7i2WP1UPBW9NVGioBBc9i/qcNFA5NnW9zR83Wsi6YtM7P1
         ijZe2Fu4T9iV1CMcOSMU9CtDcXBZSGzvLpUL2jHO93M1Jy/xGXwtNZSIDOzjcNbySGIH
         lYVu3qN7Svb+zl5xCvvcsp+QrFZlru5OmVyD0QSUdtoR+cwkQ48SH4D7UY7VdzbY/d3Z
         1Luw==
X-Gm-Message-State: AOAM531UX6KvawWIDSOaDe8da02HGnENuqdCJAzv4DwM8HO3CTn6xb5h
        Mk0gM2HDgcB0QTvXBuFznZKkwJsG8rNydA==
X-Google-Smtp-Source: ABdhPJy4fn5Ni+hVifH+PdTcEvSUNKAcSqMpM4IphaVuf5pJqnHAIoTk6dCX9k2S8fx3ERy5jghVtw==
X-Received: by 2002:a17:906:b752:: with SMTP id fx18mr19117055ejb.17.1612812928177;
        Mon, 08 Feb 2021 11:35:28 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id g9sm9241414ejp.55.2021.02.08.11.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:35:27 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] platform/surface: aggregator_registry: Add HID subsystem devices
Date:   Mon,  8 Feb 2021 20:35:08 +0100
Message-Id: <20210208193508.3038055-7-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208193508.3038055-1-luzmaximilian@gmail.com>
References: <20210208193508.3038055-1-luzmaximilian@gmail.com>
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

