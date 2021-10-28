Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A4A43D815
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 02:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhJ1AZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 20:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhJ1AZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:25:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B7C061570;
        Wed, 27 Oct 2021 17:23:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m17so16447958edc.12;
        Wed, 27 Oct 2021 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZEhtnC2chaC5XRdYRduKjbzt19pdMtxAMTtsk0+We4=;
        b=Q20O4y6+O6Jr0YfDvLMHy4AI+NFdQukb5dcF4I+i7h95H5NVPPFQnTXs+zbw0O8sEY
         bZ+IeAS6T2IbR9yKV+SaD3ruRn27oCkwp1m8tV07Gu4JgbCJYT5liJaD/SpQs0SpYGSv
         wn64O1mJTK+7VtYemEA7jwsr+p2BzhCwFupv28kEJe7mjSWJlEvyjvxpxunSxiA0FLRP
         4VYUTdGkvxAQqtO5Ky50bSHT+jfl+UxzxF0P3XucCJJeEnXS2mGr1jXRjG1ViPrn27nJ
         9M17xq/5UYnGZX/5jABOFLyewFPRmODiHgCtua7+S82h7OcbcnsE2zjmP2yivOcAEC6x
         mUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZEhtnC2chaC5XRdYRduKjbzt19pdMtxAMTtsk0+We4=;
        b=K1vRNp2jd61mmVQyiPsa9YN+Rlq1c9/EOa0OTp6c4C7bq319x+SEkooNe2RoMen31B
         3eseMVScbqfNDcU86lmjkmp8lKn0SHx5CKpDB9R+flGlMZZ/cvfOBknaDcU1Vw4oPaA1
         KGMX2v9QcC0Y2koZl6Ld7AedjLnpW/UDdC1B5+AnYFosavWsbVaEivv/hitD7jyv1JiR
         A8Ln3Be6fe2syMVH3vhvK9fP6SrqZk2fgMdGAr6NHD89O/650EDeNYfDgoJT4098182h
         B7dOom282JMRt4VVBOwqDhH9aNYdannnACGsNyaTj3pgFsYhxq9HZVqtBSfIVTIiZVBu
         5g4g==
X-Gm-Message-State: AOAM533DgQvGHsI1ez3HteW0E2lJN9SCNEYp5WdJmoLmhlojoUpRUtjq
        JhyCXvjLxhRdC8Bwcpfbm4ON8acS2BoLFA==
X-Google-Smtp-Source: ABdhPJy5j5Bnfl3dIbigAyvEXqa8zjAF5taOMgkS/qR+a+UUYy7XRkWmg/h6xMI/98t/HF5fodWKwg==
X-Received: by 2002:a05:6402:5188:: with SMTP id q8mr1515858edd.332.1635380586205;
        Wed, 27 Oct 2021 17:23:06 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id i22sm753801edu.93.2021.10.27.17.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 17:23:05 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/surface: aggregator_registry: Use generic client removal function
Date:   Thu, 28 Oct 2021 02:22:42 +0200
Message-Id: <20211028002243.1586083-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028002243.1586083-1-luzmaximilian@gmail.com>
References: <20211028002243.1586083-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic client removal function introduced in the previous commit
instead of defining our own one.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 24 ++++---------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 1679811eff50..d63f975bfd4c 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -249,20 +249,6 @@ static int ssam_uid_from_string(const char *str, struct ssam_device_uid *uid)
 	return 0;
 }
 
-static int ssam_hub_remove_devices_fn(struct device *dev, void *data)
-{
-	if (!is_ssam_device(dev))
-		return 0;
-
-	ssam_device_remove(to_ssam_device(dev));
-	return 0;
-}
-
-static void ssam_hub_remove_devices(struct device *parent)
-{
-	device_for_each_child_reverse(parent, NULL, ssam_hub_remove_devices_fn);
-}
-
 static int ssam_hub_add_device(struct device *parent, struct ssam_controller *ctrl,
 			       struct fwnode_handle *node)
 {
@@ -308,7 +294,7 @@ static int ssam_hub_add_devices(struct device *parent, struct ssam_controller *c
 
 	return 0;
 err:
-	ssam_hub_remove_devices(parent);
+	ssam_remove_clients(parent);
 	return status;
 }
 
@@ -405,7 +391,7 @@ static void ssam_base_hub_update_workfn(struct work_struct *work)
 	if (hub->state == SSAM_BASE_HUB_CONNECTED)
 		status = ssam_hub_add_devices(&hub->sdev->dev, hub->sdev->ctrl, node);
 	else
-		ssam_hub_remove_devices(&hub->sdev->dev);
+		ssam_remove_clients(&hub->sdev->dev);
 
 	if (status)
 		dev_err(&hub->sdev->dev, "failed to update base-hub devices: %d\n", status);
@@ -487,7 +473,7 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
 err:
 	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
 	cancel_delayed_work_sync(&hub->update_work);
-	ssam_hub_remove_devices(&sdev->dev);
+	ssam_remove_clients(&sdev->dev);
 	return status;
 }
 
@@ -499,7 +485,7 @@ static void ssam_base_hub_remove(struct ssam_device *sdev)
 
 	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
 	cancel_delayed_work_sync(&hub->update_work);
-	ssam_hub_remove_devices(&sdev->dev);
+	ssam_remove_clients(&sdev->dev);
 }
 
 static const struct ssam_device_id ssam_base_hub_match[] = {
@@ -613,7 +599,7 @@ static int ssam_platform_hub_remove(struct platform_device *pdev)
 {
 	const struct software_node **nodes = platform_get_drvdata(pdev);
 
-	ssam_hub_remove_devices(&pdev->dev);
+	ssam_remove_clients(&pdev->dev);
 	set_secondary_fwnode(&pdev->dev, NULL);
 	software_node_unregister_node_group(nodes);
 	return 0;
-- 
2.33.1

