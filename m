Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E330E39C573
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 05:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFEDYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 23:24:07 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:56436 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFEDYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 23:24:06 -0400
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id D2C4CAC00AC;
        Sat,  5 Jun 2021 11:22:16 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drm/i915/display: remove duplicated argument
Date:   Sat,  5 Jun 2021 11:22:07 +0800
Message-Id: <20210605032209.16111-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0NIHVZKSEMdSUNITk4ZQ09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRQ6TBw6Lj8JIwlOOEspHz0q
        KhMwCglVSlVKTUlJQ01ISEhMTkNMVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJQ0xLNwY+
X-HM-Tid: 0a79da315725b039kuuud2c4cac00ac
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/gpu/drm/i915/display/intel_display_power.c:3081:1-28:
 duplicated argument to & or |

This commit fixes duplicate argument. It might be a typo.
But what I can do is to remove it now.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/i915/display/intel_display_power.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index 3e1f6ec61514..4298ae684d7d 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -3078,7 +3078,6 @@ intel_display_power_put_mask_in_set(struct drm_i915_private *i915,
 	BIT_ULL(POWER_DOMAIN_PORT_DDI_C_LANES) |	\
 	BIT_ULL(POWER_DOMAIN_PORT_DDI_LANES_D_XELPD) |	\
 	BIT_ULL(POWER_DOMAIN_PORT_DDI_LANES_E_XELPD) |	\
-	BIT_ULL(POWER_DOMAIN_AUX_C) |			\
 	BIT_ULL(POWER_DOMAIN_PORT_DDI_LANES_TC1) |	\
 	BIT_ULL(POWER_DOMAIN_PORT_DDI_LANES_TC2) |	\
 	BIT_ULL(POWER_DOMAIN_PORT_DDI_LANES_TC3) |	\
-- 
2.20.1

