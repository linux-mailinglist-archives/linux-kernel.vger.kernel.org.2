Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50734B064
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCZUjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230240AbhCZUil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616791121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmJWUQTnyNyF1uUV1/UTgNBKp8byMNl0QTWnDQNcXzM=;
        b=VGbOItZpkLAL60B6rzzmnpn1+HXBSMyWRXuduxxRw1oM8qvHlkyivsMP6WrxIoC8/3tR9O
        EnPZee47f9JoHL17unV5NsQlcal+ydpC7pSO5LToybdfAq28KqsurhtLJDXU+9dbXtg+Q5
        AbWIdA+TvlO4UBGj+s0r+TBJkBNUm/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-YxUCerzBOUCJkjvHCXR8Tg-1; Fri, 26 Mar 2021 16:38:25 -0400
X-MC-Unique: YxUCerzBOUCJkjvHCXR8Tg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36385501EC;
        Fri, 26 Mar 2021 20:38:23 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-114-133.rdu2.redhat.com [10.10.114.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 058795DDAD;
        Fri, 26 Mar 2021 20:38:21 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:DRM DRIVERS FOR NVIDIA TEGRA),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/20] drm/tegra: Don't register DP AUX channels before connectors
Date:   Fri, 26 Mar 2021 16:37:49 -0400
Message-Id: <20210326203807.105754-3-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-1-lyude@redhat.com>
References: <20210326203807.105754-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by the documentation for drm_dp_aux_register(),
drm_dp_aux_init() should be used in situations where the AUX channel for a
display driver can potentially be registered before it's respective DRM
driver. This is the case with Tegra, since the DP aux channel exists as a
platform device instead of being a grandchild of the DRM device.

Since we're about to add a backpointer to a DP AUX channel's respective DRM
device, let's fix this so that we don't potentially allow userspace to use
the AUX channel before we've associated it with it's DRM connector.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/tegra/dpaux.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 105fb9cdbb3b..ea56c6ec25e4 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -534,9 +534,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	dpaux->aux.transfer = tegra_dpaux_transfer;
 	dpaux->aux.dev = &pdev->dev;
 
-	err = drm_dp_aux_register(&dpaux->aux);
-	if (err < 0)
-		return err;
+	drm_dp_aux_init(&dpaux->aux);
 
 	/*
 	 * Assume that by default the DPAUX/I2C pads will be used for HDMI,
@@ -589,8 +587,6 @@ static int tegra_dpaux_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	drm_dp_aux_unregister(&dpaux->aux);
-
 	mutex_lock(&dpaux_lock);
 	list_del(&dpaux->list);
 	mutex_unlock(&dpaux_lock);
@@ -723,6 +719,10 @@ int drm_dp_aux_attach(struct drm_dp_aux *aux, struct tegra_output *output)
 	unsigned long timeout;
 	int err;
 
+	err = drm_dp_aux_register(aux);
+	if (err < 0)
+		return err;
+
 	output->connector.polled = DRM_CONNECTOR_POLL_HPD;
 	dpaux->output = output;
 
@@ -760,6 +760,7 @@ int drm_dp_aux_detach(struct drm_dp_aux *aux)
 	unsigned long timeout;
 	int err;
 
+	drm_dp_aux_unregister(aux);
 	disable_irq(dpaux->irq);
 
 	if (dpaux->output->panel) {
-- 
2.30.2

