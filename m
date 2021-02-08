Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C036B3140FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhBHUwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhBHTgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:36:06 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8AEC06178C;
        Mon,  8 Feb 2021 11:35:26 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so27115027ejc.1;
        Mon, 08 Feb 2021 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ki372JPzgSTNSo8pjr6Qw99cDcb/v0iRPGUG+av7wM=;
        b=cVaiIw30T0+miPLGI/MQ6yRhVfVP/VDobvEgcQD20KEmh5F6s8F4fO0gRG51Zy7Czz
         3Yw0VO6jIFe+ma350fFaMUUjeItnDwpl9xWqjToILY5l+HTUYYAefz9lZnhOLzAzkK4+
         EBkauxhVcQfQUuoSO3pwiao1rzNpsC2gXLwxDDZa8BTgNlD6TrAa00b4sOizULVwyxml
         oSgomik+Cp9fFSX87zoTmZr+DviTWDn74jhTTji3vtbIwwHM37IGtDc5A5/ZsRdlTnyn
         sUIyR7ilT3IsBr7vaCkvbEC3Ut41wiUo6KkoFoS5hOSWUVRxsu26yvb+PKiY1dMWWwYR
         GFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ki372JPzgSTNSo8pjr6Qw99cDcb/v0iRPGUG+av7wM=;
        b=mks/OKNfiIAGL902gUJP7TSlecbcdTdkxnMOPe5fLKTszJMH8Zop82FlQvqnr6YSYw
         I//XH+ulWqGuh5mQzgTmVPSP2fqHEbYu83tr1B9uXuvJiPxy4Gr4ThrIv7tx1SwtGgRD
         Pw3LvT0HtY09en8bJCbkSpkJFJJDGXNqt6Eswfq6kbEpAvcGtc11Ppkfi0w7vBmJpWTc
         vYBNqSEcwqZSfEdnaBMM4OzhDbT04BEEqiD907ET9+PueAcvxrUTwUeBsFQ6l6ZYYXe/
         NafGrHH3+JiDwYkr+Mcc1ji1YgubUxtIgnFoUTqV/wYIgWcJWFOkx90ZHBoDeMLfeEfT
         MYAQ==
X-Gm-Message-State: AOAM533LxqnNDhpFkpg/GJX49KRHgslQkYjloS69YkGNrgr5d2z1diqc
        fkXrCNtOuig+02OLwSGLIZI8hCoNfzl/zA==
X-Google-Smtp-Source: ABdhPJy6CqGMLdnHzYpER6/g3RyEd9/cr7gPm5s6FAlg3xrN9rSCv/ReTPXxXiW3SL5EYmxemEfJHw==
X-Received: by 2002:a17:906:40f:: with SMTP id d15mr18797571eja.522.1612812925160;
        Mon, 08 Feb 2021 11:35:25 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id g9sm9241414ejp.55.2021.02.08.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:35:24 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] platform/surface: aggregator_registry: Add platform profile device
Date:   Mon,  8 Feb 2021 20:35:06 +0100
Message-Id: <20210208193508.3038055-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208193508.3038055-1-luzmaximilian@gmail.com>
References: <20210208193508.3038055-1-luzmaximilian@gmail.com>
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
index 7e7b801bc606..913fa5cae705 100644
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
2.30.0

