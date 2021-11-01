Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB589441ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhKALtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhKALtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:49:07 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39ADC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=kuLy/8jiUbD+nZ5OSmtZpAkZEkowU/+2O9rn5AK/AIQ=; b=Pv
        wwrJWqEA66dBac0YPxQHvqCPR5NMWbuE+zWGv94t2awG4N7lfHMyQxxYYjxRg8mIX9U0tzZ7kfPz8
        qNfKf/nzg77GRRPgtMQO8LfvEVazaqSGYzbEDSi9JliOZ5CLFZyGyq/bq1jpavOKOGrLqlNX2mW9+
        fPSuHzQshH97AcuwUVBtIFgboXsaHNM5AVcyIXQ7bO6frNlT0Kva5tfJNFAVvIZMv2cTr2LBycwYt
        HQ3qnkzaW5ECx2w7+ueUKnRL6ax0GIWiE5FWOnd2tQ+yJ7VXD9MZF/3cbi7OIfdPEje3X09sFwxY1
        QbN57r3v1rfNZ4vn15+hOb2O94Rm5/RA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mhVlk-0007Ay-01; Mon, 01 Nov 2021 11:46:28 +0000
From:   John Keeping <john@metanate.com>
To:     dri-devel@lists.freedesktop.org
Cc:     John Keeping <john@metanate.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: pass 0 to drm_fbdev_generic_setup()
Date:   Mon,  1 Nov 2021 11:46:22 +0000
Message-Id: <20211101114622.813536-1-john@metanate.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow drm_fbdev_generic_setup() to pick the default bpp value for the
framebuffer.

This has no functional impact because the default is 32, given that
mode_config.preferred_depth is not set for Rockchip.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: John Keeping <john@metanate.com>
---
This needs [1] to be applied first.

[1] https://lore.kernel.org/all/20211029115014.264084-1-john@metanate.com

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 1481181445fd..e37e74998fa9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -165,7 +165,7 @@ static int rockchip_drm_bind(struct device *dev)
 	if (ret)
 		goto err_kms_helper_poll_fini;
 
-	drm_fbdev_generic_setup(drm_dev, 32);
+	drm_fbdev_generic_setup(drm_dev, 0);
 
 	return 0;
 err_kms_helper_poll_fini:
-- 
2.33.1

