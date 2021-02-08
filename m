Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4DB3140EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhBHUuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbhBHTgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:36:05 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3395C06178B;
        Mon,  8 Feb 2021 11:35:24 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lg21so27068939ejb.3;
        Mon, 08 Feb 2021 11:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Md7oHiTHjbwRSktyunhTsYtpsxjjWEPdbXs75rlCNs=;
        b=J7wGk+lkfGiegQ1Cta04DXg28H/jJcVhDu37qQ6XsTZeJ9SN7v17kVc5959vGXS76f
         16GI83uAPwqDvBMYqpK0J0FhjWhXtL7T378GYh70dmWskSpCfp5AhqkuGM3ZUawQtIJv
         NjwiamnVMW91p1V8yBmRtC+c9WfWHwEFZWVtbPTqYNHq9tBViXWF7TPiCShqeBFpDmhb
         BTiPudQ+AleAmk7eSzSzSQV4kgznJk3L3p5yoSE8VRQADa4YDUd0Cb8DQS8+w8A8nHH3
         Yi5ZK9TWPGoybvtbNyX+kYFpQamVnkXtHsquKGqISHsPk6ZrEjUidoZimfF8SwhA7nPr
         iYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Md7oHiTHjbwRSktyunhTsYtpsxjjWEPdbXs75rlCNs=;
        b=N8OsgrSNaoKsYdHvCVR1ht3E8gisaqhX+mA0/JptfimFAFQV5PgtLRuYNGrzerbz0O
         yiZBMKU4rNIfM44IBubpM7vXEN/6pUj1GIDY5z7yZ2k5Lu8hxQ2dUtmU1m1fVNnBktPk
         r1Wz8hrWS74Z9SDgw/+akQy20uSooZ77EVRhj9fiIRicqxaBOqbolVDXWW/RDo+/UO2I
         euuivYlEp5LyMdP94BLL3FKsK9QJN8P1Oiz02WNVNsV8/S5gchD924LMOeF1QoNLbPPa
         i9an77ZH9ucL2rlcpfTgBJGPMQTp9attWRFh0azorT+25OYvVFbj16BNIlJwIf3Vlg9R
         oQqw==
X-Gm-Message-State: AOAM532wkBD6IZzN+Dp8cFqn/rWmrtxvpPQyvds+2MXrRoUnsTDlA3HE
        AU9cVkgmz+rfPA0EQ+aK8AYAeEhRsbMHcg==
X-Google-Smtp-Source: ABdhPJw1as3iXGuEPUD5NsUhFgrUx7wgIMZrhXt2zmfgLm3MXrG9V38FGYzEoEdw+thJKORcoaSMVA==
X-Received: by 2002:a17:906:3a10:: with SMTP id z16mr3490304eje.483.1612812923604;
        Mon, 08 Feb 2021 11:35:23 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id g9sm9241414ejp.55.2021.02.08.11.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:35:22 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] platform/surface: aggregator_registry: Add battery subsystem devices
Date:   Mon,  8 Feb 2021 20:35:05 +0100
Message-Id: <20210208193508.3038055-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208193508.3038055-1-luzmaximilian@gmail.com>
References: <20210208193508.3038055-1-luzmaximilian@gmail.com>
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
index 0d802804594c..7e7b801bc606 100644
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
2.30.0

