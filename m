Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB873140FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhBHUxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhBHTgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:36:16 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5171C0617AA;
        Mon,  8 Feb 2021 11:35:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t5so20119400eds.12;
        Mon, 08 Feb 2021 11:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zCukg/KgnVqLu7nAjOfWD7rNSU7F1rMMVwt26iP/dqU=;
        b=ty/IJtlIHRDpFugNZ3CHWS2dHJqVxGVbBMB87Yzw5G6yEi1B9uEgK+nZ6MTvq2zuIY
         GBql1+FsFG08agEOFxbseHfsRQDtXlE86VH8MifQlp2Yh6F8+mwcRvPomJu+a3mYoWDZ
         t+97vpXjFEon5+AB3owH7qxFUa8iq57Qj7VURYbDzQYEh2NmRo3p7BIplvoFe/ivJlEA
         bWyR4nLp0aDB+0sUAev6oimspVkd9fzT54XtLEZCoDWU90S7ISinpR4FHRp3Eg6V0ctm
         31pzukMqqyc9AWjgWfVbbJ7VQvT/CUQHboqoCXS2wkb0upYYNfWSywCmt4EJ2wNI7Muq
         DGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCukg/KgnVqLu7nAjOfWD7rNSU7F1rMMVwt26iP/dqU=;
        b=BuLvZvkZjw8n9aZUicI4kPyzVdK3B+iwAdTdSrKiQppNSWDNzNF1ORLa0YKpVSTSk2
         ZOu0urmnzd+C1xFn0FtIpmCLi2JPakNLUcRClLjPl/3KCK/0BHFKctAAzBCCCyD1tYs+
         YvLHOHB3Obfe7Ns9FDuKU96MQMvXFf2FsenGK/thouftMy1l5NKN90xLI+WaeSce9u/x
         YnLUpbklIk8WC/ULlOiPbYXWI0tR3S4KVysddYi5W3Y6pnAwX0chC+5DwEm6ohWpHVDt
         ZW1Fx2KMlMe4NfeVLaryMn6bIUSqPVaQHbO98wroDY+PQpKDRzhZePRfQ2pnILlZBZ6x
         0MhQ==
X-Gm-Message-State: AOAM532+pv8uXr+g6zV5A/KsYJ/EPeeWpQJ9FoZMFS8W6YI+kKUA3lbq
        7p9905WLegN1AuARoRkk5t0=
X-Google-Smtp-Source: ABdhPJw58iBzM/+C1+aA1z/9IE8pHExoUQafXxNnJLt79SqlOok/4yvwO4xmgNeJrhRK7GjlJgRZEw==
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr18483174edb.143.1612812926648;
        Mon, 08 Feb 2021 11:35:26 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id g9sm9241414ejp.55.2021.02.08.11.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:35:26 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] platform/surface: aggregator_registry: Add DTX device
Date:   Mon,  8 Feb 2021 20:35:07 +0100
Message-Id: <20210208193508.3038055-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208193508.3038055-1-luzmaximilian@gmail.com>
References: <20210208193508.3038055-1-luzmaximilian@gmail.com>
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
index 913fa5cae705..4c74e80dc34a 100644
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
2.30.0

