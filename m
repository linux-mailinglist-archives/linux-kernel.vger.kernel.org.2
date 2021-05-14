Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D199380F94
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhENSRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235224AbhENSRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621016166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riDRdfnAHr/tMUAgFk2nA55/FOgZEaKSe6bPwrAaU5E=;
        b=Xn5E8YDpPIbV+xI6exnrmO8Nj9fECRIKdIXZ946BQ5cMncnKDj0WHUTYbeELuI+t8w6M/B
        Rw2ZlxDYM1kIJG+0zPWj9cICtSATOcPq7V4TX43zWRtQ3GnXU2oVHRkv5i2tPZYI7Pf20W
        FNkqc5+KqqOPbYwIotBoUiZ2qkeUUJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-h-oSVJ7fMka7P6jGuNE6dg-1; Fri, 14 May 2021 14:16:04 -0400
X-MC-Unique: h-oSVJ7fMka7P6jGuNE6dg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D555E107ACC7;
        Fri, 14 May 2021 18:16:01 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-140.rdu2.redhat.com [10.10.118.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7478919D9B;
        Fri, 14 May 2021 18:16:00 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>, greg.depoire@gmail.com,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 6/9] drm/i915/dpcd_bl: Return early in vesa_calc_max_backlight if we can't read PWMGEN_BIT_COUNT
Date:   Fri, 14 May 2021 14:15:00 -0400
Message-Id: <20210514181504.565252-7-lyude@redhat.com>
In-Reply-To: <20210514181504.565252-1-lyude@redhat.com>
References: <20210514181504.565252-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we can't read DP_EDP_PWMGEN_BIT_COUNT in
intel_dp_aux_vesa_calc_max_backlight() but do have a valid PWM frequency
defined in the VBT, we'll keep going in the function until we inevitably
fail on reading DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN. There's not much point in
doing this, so just return early.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 781c7cd98d75..bf8e4ed56847 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -449,11 +449,14 @@ static u32 intel_dp_aux_vesa_calc_max_backlight(struct intel_connector *connecto
 	int freq, fxp, fxp_min, fxp_max, fxp_actual, f = 1;
 	u8 pn, pn_min, pn_max;
 
-	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, &pn) == 1) {
-		pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
-		max_backlight = (1 << pn) - 1;
+	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, &pn) != 1) {
+		drm_dbg_kms(&i915->drm, "Failed to read pwmgen bit count cap\n");
+		return 0;
 	}
 
+	pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
+	max_backlight = (1 << pn) - 1;
+
 	/* Find desired value of (F x P)
 	 * Note that, if F x P is out of supported range, the maximum value or
 	 * minimum value will applied automatically. So no need to check that.
-- 
2.31.1

