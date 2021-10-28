Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AD943D88C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 03:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJ1BbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 21:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJ1BbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:31:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BE6C061570;
        Wed, 27 Oct 2021 18:28:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r12so18037144edt.6;
        Wed, 27 Oct 2021 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqkFiB7e/NYx0pOSA80jVFWxOnU6krfmDw2I9bc9Rts=;
        b=MHXoT+1/58qB4zUSeSmRkTEhSBBlLRKWOtRd+ig771pgdJtYziWPOiR8oKkXkwSfqR
         vyOxqPpx0B2DgjGfGC45HEClWtAii5YOTqkaLUqUxm/Wh3FIka52/ilY0pzJKPHTLnA1
         p8tDZoGXe87dwcSoinBDx5BMAxyVRLewW8yS2JicdIWh0ozdcRdsp3kEgFIpDpdUVl5M
         XkGOAcBOEf6G6GuSrVO1D+MDCHb2QsxSO1KG0DkOU0sEcQiF91v+DSaEI+/VhQTn2cWg
         icwJ008JYDX3M9nlPATZkMOFd1oAcvKaWNIC2V6WUL/6VKR8NYGS9r4V1LAD1gqx5WF2
         MdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqkFiB7e/NYx0pOSA80jVFWxOnU6krfmDw2I9bc9Rts=;
        b=r8gNUoErDoSToF5srIS36QvA6ffRqrts007WW4jBNopcAVp8l4+P6xwLLTQm4oU0er
         pmHV3nrpYPssLrAY2v9GyZT0c0lish5i8/rYAoZSSEMhNTerrj39WsUEKdPaDX7X6ANf
         OoGNWtYkDCvAIpzFBIzk+DftvXlDudXkNVUQuhKvSrY6kUQoluLYAFOQ4hyIGRDO2Bm9
         epNHbZTRggcFliu3apGMnoDkW3xpF8sHXHy4BmfC/F260WFtgGkuqwnWjX7VWG2zFtJi
         tWxDckXVHInPPHGvy65L7obZwliGagfsniA095a41jbBFlJsOvEPIQRpYvPd9XccvbDK
         uRlg==
X-Gm-Message-State: AOAM533KM2osogRfedy0K0H3MTgVZnUeqHaYmfc6KtLJ9jkG1+dcGne/
        tNqMmZ2U4233ufrJ+pQFQRVk1FS9/eE=
X-Google-Smtp-Source: ABdhPJwGZrtqbQGsRb8haBmXnfHPenjsGbYrv6NgHDR4pjLdwUKfy/D9Wb8g//zKn7wSl346SawN+A==
X-Received: by 2002:a17:906:6b81:: with SMTP id l1mr1400855ejr.479.1635384532752;
        Wed, 27 Oct 2021 18:28:52 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id b9sm823726edk.62.2021.10.27.18.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 18:28:52 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator_registry: Add initial support for Surface Pro 8
Date:   Thu, 28 Oct 2021 03:28:45 +0200
Message-Id: <20211028012845.1887219-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add preliminary support for the Surface Pro 8 to the Surface Aggregator
registry. This includes battery/charger status and platform profile
support.

In contrast to earlier Surface Pro generations, the keyboard cover is
now also connected via the Surface Aggregator Module (whereas it was
previously connected via USB or HID-over-I2C). To properly support the
HID devices of that cover, however, more changes regarding hot-removal
of Surface Aggregator client devices as well as a new device hub driver
are required. We will address those things in a follow-up series, so do
not add any HID device IDs just yet.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../platform/surface/surface_aggregator_registry.c   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 2e0d3a808d47..ce2bd88feeaa 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -228,6 +228,15 @@ static const struct software_node *ssam_node_group_sp7[] = {
 	NULL,
 };
 
+static const struct software_node *ssam_node_group_sp8[] = {
+	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_tmp_pprof,
+	/* TODO: Add support for keyboard cover. */
+	NULL,
+};
+
 
 /* -- Device registry helper functions. ------------------------------------- */
 
@@ -520,6 +529,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Pro 7+ */
 	{ "MSHW0119", (unsigned long)ssam_node_group_sp7 },
 
+	/* Surface Pro 8 */
+	{ "MSHW0263", (unsigned long)ssam_node_group_sp8 },
+
 	/* Surface Book 2 */
 	{ "MSHW0107", (unsigned long)ssam_node_group_gen5 },
 
-- 
2.33.1

