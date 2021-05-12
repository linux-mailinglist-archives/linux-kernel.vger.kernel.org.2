Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4FF37EDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388034AbhELUlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:41:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40542 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387087AbhELUcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:32:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lgvVM-0006Pb-5r; Wed, 12 May 2021 20:30:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm: simpledrm: Fix use after free issues
Date:   Wed, 12 May 2021 21:30:51 +0100
Message-Id: <20210512203051.299026-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two occurrances where objects are being free'd via
a put call and yet they are being referenced after this. Fix these
by adding in the missing continue statement so that the put on the
end of the loop is skipped over.

Addresses-Coverity: ("Use after free")
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 2bdb477d9326..eae748394b00 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -298,6 +298,7 @@ static int simpledrm_device_init_clocks(struct simpledrm_device *sdev)
 			drm_err(dev, "failed to enable clock %u: %d\n",
 				i, ret);
 			clk_put(clock);
+			continue;
 		}
 		sdev->clks[i] = clock;
 	}
@@ -415,6 +416,7 @@ static int simpledrm_device_init_regulators(struct simpledrm_device *sdev)
 			drm_err(dev, "failed to enable regulator %u: %d\n",
 				i, ret);
 			regulator_put(regulator);
+			continue;
 		}
 
 		sdev->regulators[i++] = regulator;
-- 
2.30.2

