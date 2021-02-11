Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBA6319360
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhBKTsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhBKTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:47:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C311DC061788;
        Thu, 11 Feb 2021 11:46:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s5so8185959edw.8;
        Thu, 11 Feb 2021 11:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ki372JPzgSTNSo8pjr6Qw99cDcb/v0iRPGUG+av7wM=;
        b=lZxY0B8e3ptGH/5tLgLFeaRXpx5wqvkUEkjogSI86mnjr/+Y8QMdot0l7Tivpc1AP7
         P5nuOxrmDPD3gxxuXGXxjPHPmP2RtM4PgG+Z48n91XekTav12sKHJdwD+3xwCQKJoMfh
         8IwfPPP7OtFwkQb5GhkWhQsPTPH9tYKWpmMeiA8vjcqscsHVzTBZS7kWfa/VWvH4JNhW
         KUKm6dcQu00aCIZDSd01ecNXpIX9s2HgVQae3fLX3JKUGM/uVeGSlRiXiABx4K/5nCRm
         ZXRhbgVbcJTPwvVH7hMCkUb803TuhUk9jNn+HsrjoNH9G5ruHWZUOJ+5A1ameuHxZFMV
         RBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ki372JPzgSTNSo8pjr6Qw99cDcb/v0iRPGUG+av7wM=;
        b=XSmuMWOGdUsJHHN5bF/Wxqq3To9LVVw1NMjoAGH+yXdBslQoNA8QbQjr7haDCk3RNx
         GYnr4OMzwfoFP28liRHssCCd9DO2MGjnQF+aAjczLSKByMtDMWmm3FwzcI4p4MN/an0D
         Zm9jtq6W1E7LhSgVdGSxAdWBkFGb+lvlcPk7xi6GmQiKo0sdK8DFp1gs6wt8dB531BgS
         ROmyMqvMlIyRJQgtOlWN79qDYZEgMA1UyfNKWgXfCT1HA/aBOvo/keWIm5n7xL73mlKS
         KyZkOiRFZxSi+VVbreEqtQgZ5un/h0ohPEjecU9pXtKiOsliUuWTQYVfFYkgT1K2gm69
         KCAQ==
X-Gm-Message-State: AOAM532wrBocFsoyh6fkDEj5cTono66Spwoem7LpZoSpGQ0iG2IDepXq
        R/z8+PjAJYMRyooBC83ABX4=
X-Google-Smtp-Source: ABdhPJxNEweeAwl2Yh5SbacEq8es27DFk0y1wuhMvs8vZQUoEmMZ6PPaVr6QOD2nGdECdTuJnxsZzg==
X-Received: by 2002:a05:6402:3553:: with SMTP id f19mr9942315edd.271.1613072810587;
        Thu, 11 Feb 2021 11:46:50 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id f6sm4728728edr.72.2021.02.11.11.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:46:50 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] platform/surface: aggregator_registry: Add platform profile device
Date:   Thu, 11 Feb 2021 20:46:34 +0100
Message-Id: <20210211194636.568929-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211194636.568929-1-luzmaximilian@gmail.com>
References: <20210211194636.568929-1-luzmaximilian@gmail.com>
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

