Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05B1388B33
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347194AbhESJy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:54:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52994 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347969AbhESJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:54:49 -0400
Received: from [222.129.39.165] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <aaron.ma@canonical.com>)
        id 1ljItC-0005Op-D3; Wed, 19 May 2021 09:53:19 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     lyude@redhat.com, jani.nikula@intel.com, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, aaron.ma@canonical.com
Subject: [PATCH] drm/i915: Force DPCD backlight mode for Samsung 16727 panel
Date:   Wed, 19 May 2021 17:53:05 +0800
Message-Id: <20210519095305.47133-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another Samsung OLED panel needs DPCD to get control of backlight.
Kernel 5.12+ support the backlight via:
commit: <4a8d79901d5b> ("drm/i915/dp: Enable Intel's HDR backlight interface (only SDR for now)")
Only make backlight work on lower versions of kernel.

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3474
Cc: stable@vger.kernel.org # 5.11-
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 5bd0934004e3..7b91d8a76cd6 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1960,6 +1960,7 @@ static const struct edid_quirk edid_quirk_list[] = {
 	{ MFG(0x4d, 0x10), PROD_ID(0xe6, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	{ MFG(0x4c, 0x83), PROD_ID(0x47, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 	{ MFG(0x09, 0xe5), PROD_ID(0xde, 0x08), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
+	{ MFG(0x4c, 0x83), PROD_ID(0x57, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
 };
 
 #undef MFG
-- 
2.25.1

