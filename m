Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F21419FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhI0UOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236928AbhI0UO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632773568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skkbLXdqWZa0OlDaidm6eR+nQIQyI/93FeXhSOp26Z8=;
        b=Kv4qoWoSGbQphYAbqAb4R3YKiPHDvos79olIvkPfFHlc4M1PKTX+jnY0F4CsiioOFQkclB
        02wnHotFwYl34op9E6gpEmlokYHr2R3V8MxSnuPxkbn1sPCmU5KXKpXEFsKPOJXGWCCzDC
        lkGt2+fLVksGlVK0Ta39GdOZTSyBDwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-vMAX0IiuMhKBo2akEbWmDg-1; Mon, 27 Sep 2021 16:12:45 -0400
X-MC-Unique: vMAX0IiuMhKBo2akEbWmDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3AFD802921;
        Mon, 27 Sep 2021 20:12:43 +0000 (UTC)
Received: from Ruby.lyude.net (unknown [10.22.17.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BE7510074EF;
        Mon, 27 Sep 2021 20:12:42 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/i915: Clarify probing order in intel_dp_aux_init_backlight_funcs()
Date:   Mon, 27 Sep 2021 16:12:06 -0400
Message-Id: <20210927201206.682788-4-lyude@redhat.com>
In-Reply-To: <20210927201206.682788-1-lyude@redhat.com>
References: <20210927201206.682788-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
---
 .../drm/i915/display/intel_dp_aux_backlight.c    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 9b1ac02b0263..1e20c607408c 100644
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

