Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC9040DD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbhIPPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhIPPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:10:50 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57B8C061574;
        Thu, 16 Sep 2021 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1Qt8eZVGXXPoJliytaxomQR7Nt9R4Kd4tnZSMiZb234=; b=ITEDWgRTX8u92noycsKy8kC8zW
        uoEBd5MsebiVz5tfHkaj0h/NVe5yN6qVj9xdeMloF3SzbGxhzvvEFvA/p5bVo0vfKR1PlvpNo/X4h
        RnBPVRHAkEXzdUtXlDuxqrEc7gv5PyPIi+5r5tvicgbruONp0h0fX0wxEQ1BG2so6mYTerCz28jBJ
        j3XpBj98nEHwI2xz3NJyRehLYA+hDt5qRpfTFqN/mVPzQSGlnJ8MmR4Iit18PS4s2M+zRx+la9NFY
        gR0MMCMCSy4SXWBvbc/0oGRDhvQo26e9shKfz8hXFSN0nSbh69za6N4ugOzFhgEvMxgHu3Ij778pA
        qbyx0F4A==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mperttunen@nvidia.com>)
        id 1mQt0v-0006by-QU; Thu, 16 Sep 2021 18:09:25 +0300
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH] drm/tegra: Bump VIC/NVDEC clock rates to Fmax
Date:   Thu, 16 Sep 2021 18:09:20 +0300
Message-Id: <20210916150920.2136180-1-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get full performance out of these engines, bump their clock rates
to maximum. In the future we may want something smarter but this
should be fine for now.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/nvdec.c | 6 ++++++
 drivers/gpu/drm/tegra/vic.c   | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index c3b6fe7fb454..48c90e26e90a 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -374,6 +374,12 @@ static int nvdec_probe(struct platform_device *pdev)
 		return PTR_ERR(nvdec->clk);
 	}
 
+	err = clk_set_rate(nvdec->clk, ULONG_MAX);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to set clock rate\n");
+		return err;
+	}
+
 	err = of_property_read_u32(dev->of_node, "nvidia,host1x-class", &host_class);
 	if (err < 0)
 		host_class = HOST1X_CLASS_NVDEC;
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index c02010ff2b7f..dec5e56f6780 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -441,6 +441,12 @@ static int vic_probe(struct platform_device *pdev)
 		return PTR_ERR(vic->clk);
 	}
 
+	err = clk_set_rate(vic->clk, ULONG_MAX);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to set clock rate\n");
+		return err;
+	}
+
 	if (!dev->pm_domain) {
 		vic->rst = devm_reset_control_get(dev, "vic");
 		if (IS_ERR(vic->rst)) {
-- 
2.32.0

