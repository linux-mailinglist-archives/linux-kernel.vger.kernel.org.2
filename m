Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB5244687B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhKEShQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231517AbhKEShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636137272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zTpBMvFXVwp0cVfmRszlrLDuyQaiT/zVOksqphYoeg=;
        b=ZFkHhi7Jq9QYasVHIqCu/3vXmDh6fG6YzXJLgx5zEgkXzYcwbermeZaUgrqKMGFrM/xB01
        2rrrMLQH8O+yQxXtnnAutXGWLmHVR3LyHSGZcQdj+gDRg1xC/h+djvir95biJqVYAwQYig
        s7Xy0nvppzJUOwK1+FyyfDIFipCuXdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-UfKaqCuwOPWibbIvzcbeAQ-1; Fri, 05 Nov 2021 14:34:29 -0400
X-MC-Unique: UfKaqCuwOPWibbIvzcbeAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E053E1006AA2;
        Fri,  5 Nov 2021 18:34:27 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.16.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5B735FC13;
        Fri,  5 Nov 2021 18:34:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 5/5] drm/i915: Clarify probing order in intel_dp_aux_init_backlight_funcs()
Date:   Fri,  5 Nov 2021 14:33:42 -0400
Message-Id: <20211105183342.130810-6-lyude@redhat.com>
In-Reply-To: <20211105183342.130810-1-lyude@redhat.com>
References: <20211105183342.130810-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hooray! We've managed to hit enough bugs upstream that I've been able to
come up with a pretty solid explanation for how backlight controls are
actually supposed to be detected and used these days. As well, having the
rest of the PWM bits in VESA's backlight interface implemented seems to
have fixed all of the problematic brightness controls laptop panels that
we've hit so far.

So, let's actually document this instead of just calling the laptop panels
liars. As well, I would like to formally apologize to all of the laptop
panels I called liars. I'm sorry laptop panels, hopefully you can all
forgive me and we can move past this~

Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 .../drm/i915/display/intel_dp_aux_backlight.c    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 96fe3eaba44a..8b9c925c4c16 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -456,11 +456,17 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
 	}
 
 	/*
-	 * A lot of eDP panels in the wild will report supporting both the
-	 * Intel proprietary backlight control interface, and the VESA
-	 * backlight control interface. Many of these panels are liars though,
-	 * and will only work with the Intel interface. So, always probe for
-	 * that first.
+	 * Since Intel has their own backlight control interface, the majority of machines out there
+	 * using DPCD backlight controls with Intel GPUs will be using this interface as opposed to
+	 * the VESA interface. However, other GPUs (such as Nvidia's) will always use the VESA
+	 * interface. This means that there's quite a number of panels out there that will advertise
+	 * support for both interfaces, primarily systems with Intel/Nvidia hybrid GPU setups.
+	 *
+	 * There's a catch to this though: on many panels that advertise support for both
+	 * interfaces, the VESA backlight interface will stop working once we've programmed the
+	 * panel with Intel's OUI - which is also required for us to be able to detect Intel's
+	 * backlight interface at all. This means that the only sensible way for us to detect both
+	 * interfaces is to probe for Intel's first, and VESA's second.
 	 */
 	if (try_intel_interface && intel_dp_aux_supports_hdr_backlight(connector)) {
 		drm_dbg_kms(dev, "Using Intel proprietary eDP backlight controls\n");
-- 
2.31.1

