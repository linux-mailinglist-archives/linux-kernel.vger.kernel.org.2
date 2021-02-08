Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3594314431
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhBHXm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:42:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231503AbhBHXlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612827575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7QuXw0xqGJm2yN8W3IbIyrys9hJs+25FapVqIcdCi8=;
        b=DYevw5xKkpEEUo0Wq9nkNq/kpAQzhSnUxCNcthLZMyNyWf6kEh7gLDu6puemzWGcQNTUoc
        JzEkW8ybC8jQ65xh5MsTBsg8XsIf5mmkWRqXzJElA1wB0ok5eGp06TPZIg4tERQfu32YDH
        mcMG48dPUgAz3GsI0TpbEuBw1waKdcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-JNOM0HblN0CWnUFq04JA1g-1; Mon, 08 Feb 2021 18:39:32 -0500
X-MC-Unique: JNOM0HblN0CWnUFq04JA1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A280804023;
        Mon,  8 Feb 2021 23:39:30 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-114-219.rdu2.redhat.com [10.10.114.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EE3260938;
        Mon,  8 Feb 2021 23:39:29 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v4 08/11] drm/i915/dpcd_bl: Return early in vesa_calc_max_backlight if we can't read PWMGEN_BIT_COUNT
Date:   Mon,  8 Feb 2021 18:38:58 -0500
Message-Id: <20210208233902.1289693-9-lyude@redhat.com>
In-Reply-To: <20210208233902.1289693-1-lyude@redhat.com>
References: <20210208233902.1289693-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we can't read DP_EDP_PWMGEN_BIT_COUNT in
intel_dp_aux_vesa_calc_max_backlight() but do have a valid PWM frequency
defined in the VBT, we'll keep going in the function until we inevitably
fail on reading DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN. There's not much point in
doing this, so just return early.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 611eb3a7cc08..a139f0e08839 100644
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
2.29.2

