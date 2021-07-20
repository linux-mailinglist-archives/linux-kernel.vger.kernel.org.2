Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAEB3CFE87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbhGTPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:19:18 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:38996
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234905AbhGTPRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:17:14 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EFFF2408B7;
        Tue, 20 Jul 2021 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626796652;
        bh=3II+PC97VCoKt9T8F7pnL4yTXL+6p6xVAwlLpzbPYU8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=wamHC7s9ZUcpEsWL5kOnny8dJU+Awirb8oRm5Y/2RXgjZks+aV2HQ4AeH20sGvBfr
         iKhGC44hNjMmWGN43/ATPYl6wJWfQAqCB1bdaCDGrSwlUgnRA0pblL5D5nAB+8lx8h
         ywKKsN+sAyQDiz1SIGH8oUU9j74gI1yoP+kZoVT0WORkTjdVC5omewH8nZB+hmmtjr
         jytKz61f4ZqLSA+xZa2XpSK1ppdU+nJEdGHkTggapNtj+tWO6bkIaWsPQcpyNRnPYD
         0dkR4mBDPq3vhn4HA7FNTKggBMCUW3arWN1KeozryRPMx9AoC3FkjL70jdBLZNHz8R
         tO8eAJ/BfoBzA==
From:   Colin King <colin.king@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/xelpd: Fix unsigned compared to less than zero error
Date:   Tue, 20 Jul 2021 16:57:26 +0100
Message-Id: <20210720155726.73628-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The subtraction of fw->size - offset is operating on two unsigned
integers and the result is unsigned and hence the less than zero
comparison will always to be false. Fix this by casting fw->size
from a size_t to a ssize_t to ensure the result can be signed to
allow a less than zero result.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 3d5928a168a9 ("drm/i915/xelpd: Pipe A DMC plugging")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index f8789d4543bf..dde1f243d375 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -645,7 +645,7 @@ static void parse_dmc_fw(struct drm_i915_private *dev_priv,
 			continue;
 
 		offset = readcount + dmc->dmc_info[id].dmc_offset * 4;
-		if (fw->size - offset < 0) {
+		if ((ssize_t)fw->size - offset < 0) {
 			drm_err(&dev_priv->drm, "Reading beyond the fw_size\n");
 			continue;
 		}
-- 
2.31.1

