Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0594143D816
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 02:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJ1AZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 20:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhJ1AZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:25:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27E3C061570;
        Wed, 27 Oct 2021 17:23:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ee16so4441434edb.10;
        Wed, 27 Oct 2021 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ahKhrHirpXz6r9DfRiERy6Xt9mCAFVI2v2LBmTZuv+k=;
        b=GC1UNNAP2fbhjIdhBgf+g08hymHvQi2bEkuZJ43l0Mm8VS4HTMULwq/+lO+fKmn0B6
         Y8ebj8qFS0+tXaDXHTC5Om8FxMyhdYAfjjkuEPdQBbuBrROaY1dO33qEdcaid0jQF5jA
         QY6BdJiaRxK5WT9tRx8xH1hOrYscO8kVvrdgdqqCgdpnIJhheIrBx0PMKEoBKYfMHQ3i
         +AFoHLWJh7Ce4FowQWj7Y0H52Xd1OCH/buU/huuhX0yXZrnfj/fQTbyPfM4nq+Jlwaf3
         ho3E5b6aP02w8KCZUukniWHfxoBFMtSliSKXtqkhCi1i7C/S7jDLdkl4yG4XkzX4Lb9b
         wkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahKhrHirpXz6r9DfRiERy6Xt9mCAFVI2v2LBmTZuv+k=;
        b=RuoXh12F/KOaWgZzj9w8SjP62gP753akXDUa/CngJBuWBRly8rn81DwR79W3mZdMXI
         lUSXRZCF++J5YBpaAJjdG1S3sWQPR7kPDKXF7CAPuW6DaCzGtJ+AWQ951Q8EYLehfE71
         PEnSJ/x+DbnntMTH5I4PuChkMj09H1lhJMFsug+h8PfDR4vyZbNJeqmyZSl81ZzlJKb9
         YoQkDoEFsdsweL5+l3ojGOh9V15rLJyiI1Osmph5SKRjjbdul7/AmP3R3W+FC1+TTG6q
         Wovg4ZkTNs+HTBk+Pj5Yj4c0dcvX5SAszYDqHtu6XBX3sMQfmYnyOUN6Z/eXkm1mK9ki
         HC3Q==
X-Gm-Message-State: AOAM532+ncwZUly2kKytkETcNPprQ4YakRSadokPJ+JhjWTp/Y7LBuOV
        1m97dk8bbxrPOQPOz3KwSHVLQ5ABeHFPGA==
X-Google-Smtp-Source: ABdhPJybZswh65Hg+M6KlK9UCdcitb6By3+6zwbEUwW8nlxqUA/9seNgUy9sm75SYhfQekolzh0WrA==
X-Received: by 2002:a05:6402:348d:: with SMTP id v13mr1527465edc.279.1635380587293;
        Wed, 27 Oct 2021 17:23:07 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id i22sm753801edu.93.2021.10.27.17.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 17:23:06 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/surface: aggregator_registry: Rename device registration function
Date:   Thu, 28 Oct 2021 02:22:43 +0200
Message-Id: <20211028002243.1586083-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028002243.1586083-1-luzmaximilian@gmail.com>
References: <20211028002243.1586083-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the device registration function to better align names with the
newly introduced device removal function.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index d63f975bfd4c..2e0d3a808d47 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -274,8 +274,8 @@ static int ssam_hub_add_device(struct device *parent, struct ssam_controller *ct
 	return status;
 }
 
-static int ssam_hub_add_devices(struct device *parent, struct ssam_controller *ctrl,
-				struct fwnode_handle *node)
+static int ssam_hub_register_clients(struct device *parent, struct ssam_controller *ctrl,
+				     struct fwnode_handle *node)
 {
 	struct fwnode_handle *child;
 	int status;
@@ -389,7 +389,7 @@ static void ssam_base_hub_update_workfn(struct work_struct *work)
 	hub->state = state;
 
 	if (hub->state == SSAM_BASE_HUB_CONNECTED)
-		status = ssam_hub_add_devices(&hub->sdev->dev, hub->sdev->ctrl, node);
+		status = ssam_hub_register_clients(&hub->sdev->dev, hub->sdev->ctrl, node);
 	else
 		ssam_remove_clients(&hub->sdev->dev);
 
@@ -585,7 +585,7 @@ static int ssam_platform_hub_probe(struct platform_device *pdev)
 
 	set_secondary_fwnode(&pdev->dev, root);
 
-	status = ssam_hub_add_devices(&pdev->dev, ctrl, root);
+	status = ssam_hub_register_clients(&pdev->dev, ctrl, root);
 	if (status) {
 		set_secondary_fwnode(&pdev->dev, NULL);
 		software_node_unregister_node_group(nodes);
-- 
2.33.1

