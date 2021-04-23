Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB640369A16
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243747AbhDWSp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232291AbhDWSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619203490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TK/HCBgSwK2Cr1w9f8LcIDUHN8pP/+kQDI6sHsRo0hA=;
        b=RddjcoREVipYR5mOisy+kOy6sb2tU7S6+0jm8gcBZtnJenRIT9GGIp0HWq5003ieVRlav4
        lqCDas0IyzoSXEk5xVac+pFSVLSWDBn3Xfjn86wt5IcBasN/vNKV/gsTJH1GxR5ij59Bxj
        tirfRN6wrfbR/dHrhauQde3YY0Xj7NU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-kVdzM5myM5eoSvudv4o-Jg-1; Fri, 23 Apr 2021 14:44:46 -0400
X-MC-Unique: kVdzM5myM5eoSvudv4o-Jg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF47C1092C58;
        Fri, 23 Apr 2021 18:44:44 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-114-74.rdu2.redhat.com [10.10.114.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D6376F130;
        Fri, 23 Apr 2021 18:44:43 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 07/17] drm/dp: Always print aux channel name in logs
Date:   Fri, 23 Apr 2021 14:42:59 -0400
Message-Id: <20210423184309.207645-8-lyude@redhat.com>
In-Reply-To: <20210423184309.207645-1-lyude@redhat.com>
References: <20210423184309.207645-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're about to convert everything in drm_dp_helper.c over to using
drm_dbg_*(), let's also make our logging more consistent in drm_dp_helper.c
while we're at it to ensure that we always print the name of the AUX
channel in question.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index a2047dae3ab7..b50e572b544d 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -139,8 +139,8 @@ void drm_dp_link_train_clock_recovery_delay(const struct drm_dp_aux *aux,
 					 DP_TRAINING_AUX_RD_MASK;
 
 	if (rd_interval > 4)
-		DRM_DEBUG_KMS("AUX interval %lu, out of range (max 4)\n",
-			      rd_interval);
+		DRM_DEBUG_KMS("%s: AUX interval %lu, out of range (max 4)\n",
+			      aux->name, rd_interval);
 
 	if (rd_interval == 0 || dpcd[DP_DPCD_REV] >= DP_DPCD_REV_14)
 		rd_interval = 100;
@@ -155,8 +155,8 @@ static void __drm_dp_link_train_channel_eq_delay(const struct drm_dp_aux *aux,
 						 unsigned long rd_interval)
 {
 	if (rd_interval > 4)
-		DRM_DEBUG_KMS("AUX interval %lu, out of range (max 4)\n",
-			      rd_interval);
+		DRM_DEBUG_KMS("%s: AUX interval %lu, out of range (max 4)\n",
+			      aux->name, rd_interval);
 
 	if (rd_interval == 0)
 		rd_interval = 400;
@@ -2781,7 +2781,7 @@ int drm_dp_pcon_frl_enable(struct drm_dp_aux *aux)
 	if (ret < 0)
 		return ret;
 	if (!(buf & DP_PCON_ENABLE_SOURCE_CTL_MODE)) {
-		DRM_DEBUG_KMS("PCON in Autonomous mode, can't enable FRL\n");
+		DRM_DEBUG_KMS("%s: PCON in Autonomous mode, can't enable FRL\n", aux->name);
 		return -EINVAL;
 	}
 	buf |= DP_PCON_ENABLE_HDMI_LINK;
@@ -2876,7 +2876,8 @@ void drm_dp_pcon_hdmi_frl_link_error_count(struct drm_dp_aux *aux,
 			num_error = 0;
 		}
 
-		DRM_ERROR("More than %d errors since the last read for lane %d", num_error, i);
+		DRM_ERROR("%s: More than %d errors since the last read for lane %d",
+			  aux->name, num_error, i);
 	}
 }
 EXPORT_SYMBOL(drm_dp_pcon_hdmi_frl_link_error_count);
-- 
2.30.2

