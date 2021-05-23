Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7938DB50
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 15:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhEWNrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhEWNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 09:47:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17991C06138A;
        Sun, 23 May 2021 06:46:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o127so13531864wmo.4;
        Sun, 23 May 2021 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cNcfLpz0vUxqJWLN0Vstq7hzDU9wT7LpyzkE9U/3cdM=;
        b=VqY8cA6lR7ksWcc0dBv8VcLJxkOEVSkT/EWfMNeLrLOlCgGZOGeaqasCeGAyZR8id4
         IHCJyyzIg7gubPDVWYsjUWgHx8oUGeInKlX6RSNR6J5eKZycD4pgXAS+TLIMcDOkg1dA
         oiNac74ahE353dBExoTKMybLekklE0Atf9puds3KCJTger9/SdQaX6AfJeHMWNvRW2LK
         8pdbC9D86bbHs0o3Pz1N9tbJ2aWEV/Yxo0JT5qwiom9Bdbp+CfyYZin5/Gx0T2Jk2qcF
         m4jUMXS42Nzv+zmlZEci9ZAyFVAKDLAQbKASWz3gF9xic7d0NW1e+O6v0z2szRLhfXhC
         paqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNcfLpz0vUxqJWLN0Vstq7hzDU9wT7LpyzkE9U/3cdM=;
        b=Rh+6COEA3nwuLicK29zvLRXezyqppAKxLwchaBTwmgOl4n/9uN0oGUQl12+9aECNa0
         SyKshA4dI9rqj2j2L3ociebD+HSPVqHX4c+BA0xsIEvWYBLBhxJ3TuWgGcr23bH52FSI
         5dloDWjRtVqdkOUropO3E51TrTskpnIyas7yjqbUUoxTEd/eI50sBJHst7Guvr9gl1/C
         MrTvqOy4rE63xJHHn5cPi6mr5i3G2Xx0eXiwgmNOth1seZfZdwbtEvJhKf8iy3UG+qyU
         QJY9wj54Ssa32Z5IKdvlrTvAP6mD3ykJ7UXKxhakXzkiWamn/6oKIHQjPcYRkgzpddZe
         DeLA==
X-Gm-Message-State: AOAM530p3ii+cHplgHZpP0pg6L4W3tn7n1DNAg0c7QGzupdoVFDqXjRC
        svbI/kUa5kxneIMHIzqZb8A=
X-Google-Smtp-Source: ABdhPJzaIuJ4pwJinmguVlH5yWVWMlUbuqKOarHFJDkfagP3/mmK/uItDFlKWxmoHeeIjqQDF/1+NQ==
X-Received: by 2002:a05:600c:1994:: with SMTP id t20mr15875343wmq.177.1621777572730;
        Sun, 23 May 2021 06:46:12 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id z188sm5112414wme.38.2021.05.23.06.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 06:46:12 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/3] platform/surface: aggregator_registry: Update comments for 15" AMD Surface Laptop 4
Date:   Sun, 23 May 2021 15:45:26 +0200
Message-Id: <20210523134528.798887-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210523134528.798887-1-luzmaximilian@gmail.com>
References: <20210523134528.798887-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 15" AMD version of the Surface Laptop 4 shares its WSID HID with the
15" AMD version of the Surface Laptop 3. Update the comments
accordingly.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 685d37a7add1..bdc09305aab7 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -156,7 +156,7 @@ static const struct software_node *ssam_node_group_sl2[] = {
 	NULL,
 };
 
-/* Devices for Surface Laptop 3. */
+/* Devices for Surface Laptop 3 and 4. */
 static const struct software_node *ssam_node_group_sl3[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
@@ -521,7 +521,7 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Laptop 3 (13", Intel) */
 	{ "MSHW0114", (unsigned long)ssam_node_group_sl3 },
 
-	/* Surface Laptop 3 (15", AMD) */
+	/* Surface Laptop 3 (15", AMD) and 4 (15", AMD) */
 	{ "MSHW0110", (unsigned long)ssam_node_group_sl3 },
 
 	/* Surface Laptop Go 1 */
-- 
2.31.1

