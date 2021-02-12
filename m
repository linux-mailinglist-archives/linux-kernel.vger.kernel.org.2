Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2C319DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhBLL6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhBLLzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:55:45 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA666C061788;
        Fri, 12 Feb 2021 03:55:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 7so7569611wrz.0;
        Fri, 12 Feb 2021 03:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oioqwQoSTIzVy9jk3Rwm6T1cSacseJktNMTIpVeJWKg=;
        b=keYgiB6Ig+jq0cCM+XhmNnwQWWnNXyZnQ4nyTGO+nPS4Bz1uVPzdSvUzRXzLXR67Mr
         A0b6trlEE8cfQjeKLy81MdUsl8yRVWYoUOQXZAW88UtQuVjHvzfzmVga8qjv0Zs9gbYf
         ggFCoPuFMDYEkwHSMCdPFblOEnyQJjRnUEnQisX+B39khu9vDnKPXaW5CVyEVhBgTM7X
         4NfFzeAl0EeCYR8eqJvpWPJ+lrHvoc+x1Dmdk0JOnnnTyGrWdeTGA4aG156wx7itrZ8X
         wUaAxpzSYek2h8z1ZQPGInF9oX8n/o0l1EX4K5WD5UckPCLmwWF2Lq9WljuCHR4pUpnj
         gQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oioqwQoSTIzVy9jk3Rwm6T1cSacseJktNMTIpVeJWKg=;
        b=L+VwMF8Yo4056qj+gs0qO2gfeorgynNAr6/PvmrcpCAaGoZn37MVZF9ah8r2tMlL+b
         /8aPTysVnI0SsHwrkjqWZw2c2yKQ6uwxU0jwEsemphhDL3nTKxUeuqcSrPR1qu68L/wH
         LRXLoAq0iGMi81DzHLKCql7j1nBbenoep3GRXmEK9SqrqPAWlpnFuTo6WFJL4o0XqttC
         ZqA1XRWSl6Wo+WdgxdfZgqF9CVwgQ2K+Bi3oShqv0kLS9AganEVzvkB6mnPIUnVjJ3x5
         O9JUJfXp7dAfXEmVSAGtxl+BTsndmiBGd02Q4MkBdiw8357wd0XnMtFRaSDPMbjIJk9b
         ir3Q==
X-Gm-Message-State: AOAM533gydLGgfqtuQYa8W/fAQU53eO2ab2BTiEhLztkT0iDkDp++7ov
        2DdhkS9b6csXv3CetrI1//8=
X-Google-Smtp-Source: ABdhPJyLj2Q/CnqgnkHXRXLjxIJWCEdsucg5CfUNmwpp2drAC+tEd0S/JDloJDQ0gk1bfhkaEK9F8w==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr3009539wrb.205.1613130903568;
        Fri, 12 Feb 2021 03:55:03 -0800 (PST)
Received: from xws.localdomain (p5487bf16.dip0.t-ipconnect.de. [84.135.191.22])
        by smtp.gmail.com with ESMTPSA id p1sm9455560wru.86.2021.02.12.03.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 03:55:03 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] platform/surface: aggregator_registry: Add platform profile device
Date:   Fri, 12 Feb 2021 12:54:37 +0100
Message-Id: <20210212115439.1525216-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210212115439.1525216-1-luzmaximilian@gmail.com>
References: <20210212115439.1525216-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SSAM platform profile device to the SSAM device registry. This
device is accessible under the thermal subsystem (TC=0x03) and needs to
be registered for all Surface models.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index cde279692842..33904613dd4b 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -65,9 +65,16 @@ static const struct software_node ssam_node_bat_sb3base = {
 	.parent = &ssam_node_hub_base,
 };
 
+/* Platform profile / performance-mode device. */
+static const struct software_node ssam_node_tmp_pprof = {
+	.name = "ssam:01:03:01:00:01",
+	.parent = &ssam_node_root,
+};
+
 /* Devices for Surface Book 2. */
 static const struct software_node *ssam_node_group_sb2[] = {
 	&ssam_node_root,
+	&ssam_node_tmp_pprof,
 	NULL,
 };
 
@@ -78,18 +85,21 @@ static const struct software_node *ssam_node_group_sb3[] = {
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_bat_sb3base,
+	&ssam_node_tmp_pprof,
 	NULL,
 };
 
 /* Devices for Surface Laptop 1. */
 static const struct software_node *ssam_node_group_sl1[] = {
 	&ssam_node_root,
+	&ssam_node_tmp_pprof,
 	NULL,
 };
 
 /* Devices for Surface Laptop 2. */
 static const struct software_node *ssam_node_group_sl2[] = {
 	&ssam_node_root,
+	&ssam_node_tmp_pprof,
 	NULL,
 };
 
@@ -98,6 +108,7 @@ static const struct software_node *ssam_node_group_sl3[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
+	&ssam_node_tmp_pprof,
 	NULL,
 };
 
@@ -106,18 +117,21 @@ static const struct software_node *ssam_node_group_slg1[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
+	&ssam_node_tmp_pprof,
 	NULL,
 };
 
 /* Devices for Surface Pro 5. */
 static const struct software_node *ssam_node_group_sp5[] = {
 	&ssam_node_root,
+	&ssam_node_tmp_pprof,
 	NULL,
 };
 
 /* Devices for Surface Pro 6. */
 static const struct software_node *ssam_node_group_sp6[] = {
 	&ssam_node_root,
+	&ssam_node_tmp_pprof,
 	NULL,
 };
 
@@ -126,6 +140,7 @@ static const struct software_node *ssam_node_group_sp7[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
+	&ssam_node_tmp_pprof,
 	NULL,
 };
 
-- 
2.30.1

