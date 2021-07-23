Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB363D3783
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhGWIgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 04:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhGWIgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:36:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A589860EC0;
        Fri, 23 Jul 2021 09:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627031808;
        bh=au86PxqA2mC/AGbvba2BAcsU2LvEED9SySjD6r/5nJU=;
        h=From:To:Cc:Subject:Date:From;
        b=NTuP/2oGEHlnpXXX2Sfr75Vdi8CfXzGaW3DQULzfVypPu7mZl9Vo0xkmG34ozA9UN
         0UROrUFybVrf5gBjGFLTcHA+WBQ98WsOGpuTZP5AKVaHJ6GR6hF27q8T5X7+zw9iyC
         Onht6Vn5+zS/Bvfhnz8pZpCJAk3PcKoczwQR5SJCVwSuAQJdKwbAsDvY12EoYEtIsO
         JRicpjEwIKl4N0V296sOE6UVdz9aD+lofQjbKc3WUuQXju+slkKX4l4LP1w/OUj1n0
         tCcESe20bHMtcO/GubgitJ0Jp3K8CzPis09mgjTFuSyF/EdN+ODF1sFYbdBrMlTDsg
         YjMdh3nL3JB3Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/hisilicon/hibmc: remove an unused variable
Date:   Fri, 23 Jul 2021 11:16:34 +0200
Message-Id: <20210723091643.1768874-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A recent patch left an unused variable in place that needs to be
removed:

drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c: In function 'hibmc_unload':
drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c:252:35: error: unused variable 'priv' [-Werror=unused-variable]
  252 |         struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);

Fixes: 39a364a19e03 ("drm/hisilicon/hibmc: Convert to Linux IRQ interfaces")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index f73a8e0ea12e..610fc8e135f9 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -249,7 +249,6 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
 
 static int hibmc_unload(struct drm_device *dev)
 {
-	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	drm_atomic_helper_shutdown(dev);
-- 
2.29.2

