Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27903319DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBLMAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhBLL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:56:50 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBED2C06178A;
        Fri, 12 Feb 2021 03:55:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so655122wmz.0;
        Fri, 12 Feb 2021 03:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNh6rH4UdLS/W3UD6qka/BzSxRKPCMk3eczDtB3LU80=;
        b=pbAzSXV5CmLq7aXlHfQrC3edRTT7E3lNx9g0+7Hfa6XCNxb9fdio+lrVdw+Eqhs8Bn
         Y+GMIlvpLX8jks/7g+5rMWOdiDrvQnlx9bzTcIWcsaWK9npo8fbko0hDgyU2yJdWi3CI
         5MxzswPeli9DPNVcDiHm2RfwZt4dJ63jGmTc8WDoExQFHLV423Ro/d8RsCon7JDpb44U
         5ZfnDV9XCJhDnb1HlgFjf36GtCU7cxTrKDF9R5y+q9mAp7UPdYMdtX293q2C1oEf1yCl
         Nkot4gtv8vPsLqt/UODXI0YqL6ac9rr9tWiC7kv98i1uGPSL6CksTciCevjUuFlCmOgA
         UdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNh6rH4UdLS/W3UD6qka/BzSxRKPCMk3eczDtB3LU80=;
        b=B/MvSlbkicp8YRmIIzFjwgxn85m+3Agd/HDENLJqNhluDO7yZc+pY1gKUkzMLEz739
         F/v3GwBX6FfNjSQjEMmPHuL07+MvqN0dxf3avaxo1EdLfLaPfDCUFB+FBrICLQyj7ebj
         jL5xffLVTVfVu8/ZD8TnyT5rDYkqGnI4HKpbOt7sbZW6QQ6g9GaBTcWx/ZwkVkYexfah
         dejKqU5by4zYLlgCbUwgo4Pj6SS4ieseMOrCtMKXl4Q1I2gDtN3lI9zsd0jEla/oKH+K
         DjXqxmQLvRrYuL7tjKn6mO8mGgbiP7nDJVXgyearmuLvHiVIR3L1t9rDmLT3bw4a/Gw7
         ekSw==
X-Gm-Message-State: AOAM532GEU8XGiyZ+tvH0pbj49qS9s50yoUN8ynOd2CD2X97ZdmQEX9T
        YK052v1Roi8CEQAB0CTcsYM=
X-Google-Smtp-Source: ABdhPJw2YaA5x9eyltYdf9L5lVHj5jpjGun5V42/zv14fWRkY3WIY1/WD1ANyzssGuUn93esEyUQiw==
X-Received: by 2002:a05:600c:204b:: with SMTP id p11mr2327208wmg.129.1613130904729;
        Fri, 12 Feb 2021 03:55:04 -0800 (PST)
Received: from xws.localdomain (p5487bf16.dip0.t-ipconnect.de. [84.135.191.22])
        by smtp.gmail.com with ESMTPSA id p1sm9455560wru.86.2021.02.12.03.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 03:55:04 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] platform/surface: aggregator_registry: Add DTX device
Date:   Fri, 12 Feb 2021 12:54:38 +0100
Message-Id: <20210212115439.1525216-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210212115439.1525216-1-luzmaximilian@gmail.com>
References: <20210212115439.1525216-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the detachment system (DTX) SSAM device for the Surface Book 3. This
device is accessible under the base (TC=0x11) subsystem.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 33904613dd4b..dc044d06828b 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -71,6 +71,12 @@ static const struct software_node ssam_node_tmp_pprof = {
 	.parent = &ssam_node_root,
 };
 
+/* DTX / detachment-system device (Surface Book 3). */
+static const struct software_node ssam_node_bas_dtx = {
+	.name = "ssam:01:11:01:00:00",
+	.parent = &ssam_node_root,
+};
+
 /* Devices for Surface Book 2. */
 static const struct software_node *ssam_node_group_sb2[] = {
 	&ssam_node_root,
@@ -86,6 +92,7 @@ static const struct software_node *ssam_node_group_sb3[] = {
 	&ssam_node_bat_main,
 	&ssam_node_bat_sb3base,
 	&ssam_node_tmp_pprof,
+	&ssam_node_bas_dtx,
 	NULL,
 };
 
-- 
2.30.1

